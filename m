Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0750721562
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 09:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjFDHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFDHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 03:54:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC62B3;
        Sun,  4 Jun 2023 00:54:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126166129043.28.openmobile.ne.jp [126.166.129.43])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9597C2CF;
        Sun,  4 Jun 2023 09:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685865221;
        bh=/nSLdYk7pwOVXOtvyS+KoDrIoZI/A0nO6LauFex2Dxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqofZ1VV7WZR33FGxXVDIWtAs9WaF9nVharc1GRQgiSaLkqCJu39S1P66uu22WYMF
         kxRVilZ8XMZm9cwOSnOH1pzR3Tl52OyOOoNTZEEVaasaUTagDZzcrokvZDZcuKYBLV
         UucDew2b1rKqPrENvba0zl3dTJs/OMY7hUoxQ6vk=
Date:   Sun, 4 Jun 2023 10:54:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, thinh.nguyen@synopsys.com,
        etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: uvc: clean up comments and styling in
 video_pump
Message-ID: <20230604075404.GA28735@pendragon.ideasonboard.com>
References: <20230602211602.3b7rfa252wliiszp@synopsys.com>
 <20230602220455.313801-1-arakesh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602220455.313801-1-arakesh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avichal,

Thank you for the patch.

On Fri, Jun 02, 2023 at 03:04:55PM -0700, Avichal Rakesh wrote:
> This patch elaborates on some of the edge cases handled by
> video_pump around setting no_interrupt flag, and brings the
> code style in line with rest of the file.
> 
> Link: https://lore.kernel.org/20230602151916.GH26944@pendragon.ideasonboard.com/
> Signed-off-by: Avichal Rakesh <arakesh@google.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changelog:
> v2:
>   - Updated commit message to make it clear that userspace application is not
>     required to match the ISOC rate.
>   - Styling and comment revision based on review
> v3:
>   - Rebased on to Greg's usb-next where v1 had already merged
>   - Updated commit message to match the actual changes after rebase.
> 
> 
>  drivers/usb/gadget/function/uvc_video.c | 38 ++++++++++++++++---------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index e81865978299..91af3b1ef0d4 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -382,13 +382,13 @@ static void uvcg_video_pump(struct work_struct *work)
>  {
>  	struct uvc_video *video = container_of(work, struct uvc_video, pump);
>  	struct uvc_video_queue *queue = &video->queue;
> +	/* video->max_payload_size is only set when using bulk transfer */
> +	bool is_bulk = video->max_payload_size;
>  	struct usb_request *req = NULL;
>  	struct uvc_buffer *buf;
>  	unsigned long flags;
> +	bool buf_done;
>  	int ret;
> -	bool buf_int;
> -	/* video->max_payload_size is only set when using bulk transfer */
> -	bool is_bulk = video->max_payload_size;
> 
>  	while (video->ep->enabled) {
>  		/*
> @@ -414,20 +414,19 @@ static void uvcg_video_pump(struct work_struct *work)
> 
>  		if (buf != NULL) {
>  			video->encode(req, video, buf);
> -			/* Always interrupt for the last request of a video buffer */
> -			buf_int = buf->state == UVC_BUF_STATE_DONE;
> +			buf_done = buf->state == UVC_BUF_STATE_DONE;
>  		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>  			/*
>  			 * No video buffer available; the queue is still connected and
> -			 * we're traferring over ISOC. Queue a 0 length request to
> +			 * we're transferring over ISOC. Queue a 0 length request to
>  			 * prevent missed ISOC transfers.
>  			 */
>  			req->length = 0;
> -			buf_int = false;
> +			buf_done = false;
>  		} else {
>  			/*
> -			 * Either queue has been disconnected or no video buffer
> -			 * available to bulk transfer. Either way, stop processing
> +			 * Either the queue has been disconnected or no video buffer
> +			 * available for bulk transfer. Either way, stop processing
>  			 * further.
>  			 */
>  			spin_unlock_irqrestore(&queue->irqlock, flags);
> @@ -435,11 +434,24 @@ static void uvcg_video_pump(struct work_struct *work)
>  		}
> 
>  		/*
> -		 * With usb3 we have more requests. This will decrease the
> -		 * interrupt load to a quarter but also catches the corner
> -		 * cases, which needs to be handled.
> +		 * With USB3 handling more requests at a higher speed, we can't
> +		 * afford to generate an interrupt for every request. Decide to
> +		 * interrupt:
> +		 *
> +		 * - When no more requests are available in the free queue, as
> +		 *   this may be our last chance to refill the endpoint's
> +		 *   request queue.
> +		 *
> +		 * - When this is request is the last request for the video
> +		 *   buffer, as we want to start sending the next video buffer
> +		 *   ASAP in case it doesn't get started already in the next
> +		 *   iteration of this loop.
> +		 *
> +		 * - Four times over the length of the requests queue (as
> +		 *   indicated by video->uvc_num_requests), as a trade-off
> +		 *   between latency and interrupt load.
>  		 */
> -		if (list_empty(&video->req_free) || buf_int ||
> +		if (list_empty(&video->req_free) || buf_done ||
>  		    !(video->req_int_count %
>  		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>  			video->req_int_count = 0;

-- 
Regards,

Laurent Pinchart
