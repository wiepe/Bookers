class BooksController < ApplicationController
  def top
  end

  def new
    # index.html.erbへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @book = Book.new
  end

  def create
    # 新しいモデルインスタンスの作成
    @book = Book.new(book_params)
    # 呼び出したモデルインスタンスをデータベースに保存
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :show
    end

  end

  def destroy
  # データ(レコード)を1件取得
    book = Book.find(params[:id])
  # データ(レコード)を削除
    if book.destroy
      flash[:notice] = "Book was successfully destroyed."
    end
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
