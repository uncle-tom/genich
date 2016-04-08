class AlbumsController < ApplicationController
  inherit_resources
  skip_before_filter :authenticate_user!, only: [:index, :show]

  def index
    @album = Album.new
    index!
  end

  def create
    @album = Album.new(album_params)
    #@album.user = current_user
    create! do |format|
      format.html { redirect_to hotel_album_url(resource.hotel, resource), notice: "Фотоальбом #{resource.name} було успішно створено!" }
    end
  end

  def show
    #@user = User.find(params[:user_id])
    album = Album.find(params[:id])
    @photo = Photo.new album: album
    @photos = album.photos.where('id IS NOT NULL')
    show!
  rescue ActiveRecord::RecordNotFound => e
    not_found
  end

  private
    def album_params
      params.require(:album).permit(:name, :hotel_id)
    end
end