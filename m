Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C830656C33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiL0OtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0OtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:49:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE0AA47F;
        Tue, 27 Dec 2022 06:49:12 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 488BA514;
        Tue, 27 Dec 2022 15:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672152550;
        bh=9ZvmkU/4cxUqi48AgkHlsUf9hyTs2Mm20J/FBJPHAbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Udn5qiBjHbu3757jVq8Zm/fAx2wQMAWYl4HQY8nQv+AsiAQe7jQ0+b6wyI/luJxKe
         Hd7pxWwkRI/e1pb1wOK6JbJx/NX5cOjYKP4W2krCRCuHvmkyqERlWpe9/wsKrleR2C
         YFbGF/QArSjTOKVIA7YbPAR1JvFgVuJvxevkNaCg=
Date:   Tue, 27 Dec 2022 16:49:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Max Staudt <mstaudt@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 1/2] media: uvcvideo: Refactor streamon/streamoff
Message-ID: <Y6sF40Nx6RPIaFcQ@pendragon.ideasonboard.com>
References: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
 <20220920-resend-powersave-v5-1-692e6df6c1e2@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-powersave-v5-1-692e6df6c1e2@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Dec 06, 2022 at 03:06:55PM +0100, Ricardo Ribalda wrote:
> Add a new variable to handle the streaming state and handle the
> streamoff errors, that were not handled before.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Max Staudt <mstaudt@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 19 ++++++++++++++++---
>  drivers/media/usb/uvc/uvcvideo.h |  1 +
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4d4c33b6dfb..1389a87b8ae1 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -840,13 +840,19 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_streaming *stream = handle->stream;
> -	int ret;
> +	int ret = -EBUSY;
>  
>  	if (!uvc_has_privileges(handle))
>  		return -EBUSY;
>  
>  	mutex_lock(&stream->mutex);
> +
> +	if (handle->is_streaming)
> +		goto unlock;

This isn't needed, uvc_queue_streamon() calls vb2_streamon(), which
returns an error if the queue is already streaming.

>  	ret = uvc_queue_streamon(&stream->queue, type);
> +	handle->is_streaming = !ret;

You can just turn this into

	if (!ret)
		handle->is_streaming = true;

and drop all other changes to this function.

> +
> +unlock:
>  	mutex_unlock(&stream->mutex);
>  
>  	return ret;
> @@ -857,15 +863,22 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
>  {
>  	struct uvc_fh *handle = fh;
>  	struct uvc_streaming *stream = handle->stream;
> +	int ret = 0;
>  
>  	if (!uvc_has_privileges(handle))
>  		return -EBUSY;
>  
>  	mutex_lock(&stream->mutex);
> -	uvc_queue_streamoff(&stream->queue, type);
> +
> +	if (!handle->is_streaming)
> +		goto unlock;

More than unneeded, this is wrong. Calling VIDIOC_STREAMOFF on a queue
that is not streaming is a valid use case, it's the only way to release
buffers that have been queued to the device. vb2_core_streamoff()
handles this correctly. You should drop this check.

> +	ret = uvc_queue_streamoff(&stream->queue, type);
> +	handle->is_streaming = !!ret;

And turn this into

	if (!ret)
		handle->is_streaming = false;

and drop all other changes to this function.

> +
> +unlock:
>  	mutex_unlock(&stream->mutex);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int uvc_ioctl_enum_input(struct file *file, void *fh,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index df93db259312..0d9f335053b8 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -584,6 +584,7 @@ struct uvc_fh {
>  	struct uvc_video_chain *chain;
>  	struct uvc_streaming *stream;
>  	enum uvc_handle_state state;
> +	bool is_streaming;
>  };
>  
>  struct uvc_driver {
> 

-- 
Regards,

Laurent Pinchart
