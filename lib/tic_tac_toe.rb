class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9," ")
  end

  #constant self::WIN_COMBINATIONS
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [6,4,2],
    [0,4,8]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    index.to_i - 1
  end

  def move(index,player)
    @board[index] = player
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      player = current_player()
      move(index,player)
    else
      turn()
    end
    display_board()
  end

  def turn_count
    @board.count{|x| x == "X" || x == "O"}
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def full?
    @board.all?{|token| token == "X" || token == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def won?
    WIN_COMBINATIONS.detect do |e|
      if position_taken?(e[0]) &&
        @board[e[0]] == @board[e[1]] &&
        @board[e[1]] == @board[e[2]]
        return e
      end
    end
  end

  def winner
    if combo = won?
      @board[combo[0]]
    end
  end

  def play
    until over?
      turn()
    end
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end


end
