require_relative "error_classes"

class Currency
  attr_reader :symbol, :amount
  def initialize(currency_string)
    split_currency = currency_string.chars
    @symbol = split_currency.shift
    @amount = split_currency.join("").to_f
    known_currency
  end

  def currency_code
    currency_hash = { "$" => :USD, "£" => :EUR, "¥" => :JPY}
    currency_code = currency_hash[@symbol]
  end

  def +(other)
    check_type(other.symbol)
    new_value = @amount + other.amount
    Currency.new("#{@symbol}#{new_value}")
  end

  def -(other)
    check_type(other.symbol)
    new_value = @amount - other.amount
    Currency.new("#{@symbol}#{new_value}")
  end

  def *(other)
    new_value = @amount * other.to_f
    Currency.new("#{@symbol}#{new_value}")
  end

  def ==(other)
    symbol == other.symbol && amount == other.amount
  end

  def check_type(symbol)
    if @symbol != symbol
      raise DifferentCurrencyCodeError, "These currencies cannot be combined."
    end
  end

  def known_currency
    unless [ "$", "£", "¥" ].include?(symbol)
      raise UnknownCurrencyCodeError, "This currency is not accepted."
    end
  end
end
