Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5557205C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjFBPTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFBPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:19:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4C2123;
        Fri,  2 Jun 2023 08:19:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156168104.26.openmobile.ne.jp [126.156.168.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 922C8844;
        Fri,  2 Jun 2023 17:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685719135;
        bh=gU0yaWBrgT7+tqOEJsiMT+dgAGI/2MMNm6uujQuRWaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyTV53YCp7cwa+xVr2/JFr+AuaIhX4a8FLalc6In6FACC+qbglEXNdaVEyCMfBczd
         dc1AMUepnNHxC2mcCXdzY092MdbtV56uKxaf25smciq4Finb4fPXCrG6KL2euoMKDD
         QUzx4fKgif4ZO1OFlzoM3IGDrAvprUq/KdmZA8II=
Date:   Fri, 2 Jun 2023 18:19:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eino-Ville Talvala (Eddy)" <etalvala@google.com>,
        Jayant Chowdhary <jchowdhary@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: queue empty isoc requests if no video
 buffer is available
Message-ID: <20230602151916.GH26944@pendragon.ideasonboard.com>
References: <20230508231103.1621375-1-arakesh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508231103.1621375-1-arakesh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avichal,

Thank you for the patch.

On Mon, May 08, 2023 at 04:11:03PM -0700, Avichal Rakesh wrote:
> ISOC transfers expect a certain cadence of requests being queued. Not
> keeping up with the expected rate of requests results in missed ISOC
> transfers (EXDEV). The application layer may or may not produce video
> frames to match this expectation, so uvc gadget driver must handle cases
> where the application is not queuing up buffers fast enough to fulfill
> ISOC requirements.

I think the application *must* not produce video frames to match the
expectations. If it did, it would mean that it would either have to use
more than the available ISOC bandwidth (which is obviously bad), or use
*exactly* the ISOC bandwidth. Unless the application performs rate
matching (which would require information about the USB timings that
isn't available to userspace as far as I can tell), that's not possible.

> Currently, uvc gadget driver waits for new video buffer to become available
> before queuing up usb requests. With this patch the gadget driver queues up
> 0 length usb requests whenever there are no video buffers available. The
> USB controller's complete callback is used as the limiter for how quickly
> the 0 length packets will be queued. Video buffers are still queued as
> soon as they become available.
> 
> Link: https://lore.kernel.org/CAMHf4WKbi6KBPQztj9FA4kPvESc1fVKrC8G73-cs6tTeQby9=w@mail.gmail.com/
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
>  drivers/usb/gadget/function/uvc_video.c | 32 ++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index dd1c6b2ca7c6..e81865978299 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -386,6 +386,9 @@ static void uvcg_video_pump(struct work_struct *work)
>  	struct uvc_buffer *buf;
>  	unsigned long flags;
>  	int ret;
> +	bool buf_int;
> +	/* video->max_payload_size is only set when using bulk transfer */
> +	bool is_bulk = video->max_payload_size;

Let's rename buf_int to buf_done, that matches the intent of the code
better.

Could you reorder the fields by line length ?

	struct uvc_video *video = container_of(work, struct uvc_video, pump);
	struct uvc_video_queue *queue = &video->queue;
	/* video->max_payload_size is only set when using bulk transfer */
	bool is_bulk = video->max_payload_size;
	struct usb_request *req = NULL;
	struct uvc_buffer *buf;
	unsigned long flags;
	bool buf_done;
	int ret;

>  
>  	while (video->ep->enabled) {
>  		/*
> @@ -408,20 +411,35 @@ static void uvcg_video_pump(struct work_struct *work)
>  		 */
>  		spin_lock_irqsave(&queue->irqlock, flags);
>  		buf = uvcg_queue_head(queue);
> -		if (buf == NULL) {
> +
> +		if (buf != NULL) {
> +			video->encode(req, video, buf);
> +			/* Always interrupt for the last request of a video buffer */

I would drop this comment, and ... (see below)

> +			buf_int = buf->state == UVC_BUF_STATE_DONE;
> +		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
> +			/*
> +			 * No video buffer available; the queue is still connected and
> +			 * we're traferring over ISOC. Queue a 0 length request to

s/traferring/transferring/

> +			 * prevent missed ISOC transfers.
> +			 */
> +			req->length = 0;
> +			buf_int = false;
> +		} else {
> +			/*
> +			 * Either queue has been disconnected or no video buffer

s/Either queue/Either the queue/

> +			 * available to bulk transfer. Either way, stop processing

s/to bulk/for bulk/

> +			 * further.
> +			 */
>  			spin_unlock_irqrestore(&queue->irqlock, flags);
>  			break;
>  		}
>  
> -		video->encode(req, video, buf);
> -
>  		/*
>  		 * With usb3 we have more requests. This will decrease the
>  		 * interrupt load to a quarter but also catches the corner
>  		 * cases, which needs to be handled.
>  		 */

... and expand this:

  		/*
		 * With USB3 handling more requests at a higher speed, we can't
		 * afford to generate an interrupt for every request. Decide to
		 * interrupt:
		 *
		 * - When no more requests are available in the free queue, as
		 *   this may be our last chance to refill the endpoint's
		 *   request queue.
		 *
		 * - When this is request is the last request for the video
		 *   buffer, as we want to start sending the next video buffer
		 *   ASAP in case it doesn't get started already in the next
		 *   iteration of this loop.
		 *
		 * - Four times over the length of the requests queue (as
		 *   indicated by video->uvc_num_requests), as a trade-off
		 *   between latency and interrupt load.
		 */

And now that I've written this, I wonder if we could drop the second
case. Now that we have a guarantee we will queue 0-length requests after
the current buffer if no other buffer is available, I don't think we
need to make the last request of a buffer a special case. It even seems
to me that we could drop the first case too, and just interrupt 4 times
over the length of the requests queue. What do you think ?

> -		if (list_empty(&video->req_free) ||
> -		    buf->state == UVC_BUF_STATE_DONE ||
> +		if (list_empty(&video->req_free) || buf_int ||
>  		    !(video->req_int_count %
>  		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>  			video->req_int_count = 0;
> @@ -441,8 +459,7 @@ static void uvcg_video_pump(struct work_struct *work)
>  
>  		/* Endpoint now owns the request */
>  		req = NULL;
> -		if (buf->state != UVC_BUF_STATE_DONE)
> -			video->req_int_count++;
> +		video->req_int_count++;
>  	}
>  
>  	if (!req)
> @@ -527,4 +544,3 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
>  			V4L2_BUF_TYPE_VIDEO_OUTPUT, &video->mutex);
>  	return 0;
>  }
> -

-- 
Regards,

Laurent Pinchart
