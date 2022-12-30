Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085FB659964
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiL3OkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 09:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3OkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 09:40:05 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B8C16494;
        Fri, 30 Dec 2022 06:40:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 916E92F5;
        Fri, 30 Dec 2022 15:40:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672411202;
        bh=Bv58MED8JIoykb9A+Y5JUS/ULnEkUDLMnnXv/fRRi6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIJtwkQYShv0V5EXP1WfxIaWcSwMICMGlRIar0kiBDQ0BLaE6jzt+JGLzkqSHfcX7
         E3ojhqApXO0sNPumYCQh7+uCx1blA8iAjdt30IbvZToEvwVXDucAAV4v/FL8C5Ubhb
         8aleRZiSWCMbfeByHy2SebCkErn6PjU8VTGSexpQ=
Date:   Fri, 30 Dec 2022 16:39:58 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 7/8] media: uvcvideo: Refactor clock circular
 buffer
Message-ID: <Y674PksMsjOqNG7Q@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-7-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-7-0d7978a817cc@chromium.org>
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

On Fri, Dec 02, 2022 at 06:02:47PM +0100, Ricardo Ribalda wrote:
> Move the addition to the buffer into its own function and remove the
> stream dependency to all the clock functions.

Commit messages need to explain *why* the commit performs a change, not
just how.

> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 81 ++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 7c6448c6d706..c81a8362d582 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -464,18 +464,29 @@ static inline ktime_t uvc_video_get_time(void)
>  		return ktime_get_real();
>  }
>  
> +static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> +				       const struct uvc_clock_sample *sample)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clock->lock, flags);
> +
> +	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
> +	clock->last_sof = sample->dev_sof;
> +	clock->head = (clock->head + 1) % clock->size;
> +	clock->count = min(clock->count + 1, clock->size);
> +
> +	spin_unlock_irqrestore(&clock->lock, flags);
> +}
> +
>  static void
>  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  		       const u8 *data, int len)
>  {
> -	struct uvc_clock_sample *sample;
> +	struct uvc_clock_sample sample;
>  	unsigned int header_size;
>  	bool has_pts = false;
>  	bool has_scr = false;
> -	unsigned long flags;
> -	ktime_t time;
> -	u16 host_sof;
> -	u16 dev_sof;
>  
>  	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
>  	case UVC_STREAM_PTS | UVC_STREAM_SCR:
> @@ -530,20 +541,19 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	 * only the first one will match the host_sof.
>  	 */
>  	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> -		dev_sof = usb_get_current_frame_number(stream->dev->udev);
> +		sample.dev_sof =
> +			usb_get_current_frame_number(stream->dev->udev);
>  	else
> -		dev_sof = get_unaligned_le16(&data[header_size - 2]);
> +		sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
>  
> -	if (dev_sof == stream->clock.last_sof)
> +	if (sample.dev_sof == stream->clock.last_sof)
>  		return;
>  
> -	stream->clock.last_sof = dev_sof;
> -
>  	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> -		host_sof = dev_sof;
> +		sample.host_sof = sample.dev_sof;
>  	else
> -		host_sof = usb_get_current_frame_number(stream->dev->udev);
> -	time = uvc_video_get_time();
> +		sample.host_sof = usb_get_current_frame_number(stream->dev->udev);
> +	sample.host_time = uvc_video_get_time();
>  
>  	/*
>  	 * The UVC specification allows device implementations that can't obtain
> @@ -566,46 +576,29 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	 * the 8 LSBs of the delta are kept.
>  	 */
>  	if (stream->clock.sof_offset == (u16)-1) {
> -		u16 delta_sof = (host_sof - dev_sof) & 255;
> +		u16 delta_sof = (sample.host_sof - sample.dev_sof) & 255;
>  		if (delta_sof >= 10)
>  			stream->clock.sof_offset = delta_sof;
>  		else
>  			stream->clock.sof_offset = 0;
>  	}
>  
> -	dev_sof = (dev_sof + stream->clock.sof_offset) & 2047;
> -
> -	spin_lock_irqsave(&stream->clock.lock, flags);
> -
> -	sample = &stream->clock.samples[stream->clock.head];
> -	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
> -	sample->dev_sof = dev_sof;
> -	sample->host_sof = host_sof;
> -	sample->host_time = time;
> -
> -	/* Update the sliding window head and count. */
> -	stream->clock.head = (stream->clock.head + 1) % stream->clock.size;
> +	sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
> +	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
>  
> -	if (stream->clock.count < stream->clock.size)
> -		stream->clock.count++;
> -
> -	spin_unlock_irqrestore(&stream->clock.lock, flags);
> +	uvc_video_clock_add_sample(&stream->clock, &sample);
>  }
>  
> -static void uvc_video_clock_reset(struct uvc_streaming *stream)
> +static void uvc_video_clock_reset(struct uvc_clock *clock)
>  {
> -	struct uvc_clock *clock = &stream->clock;
> -
>  	clock->head = 0;
>  	clock->count = 0;
>  	clock->last_sof = -1;
>  	clock->sof_offset = -1;
>  }
>  
> -static int uvc_video_clock_init(struct uvc_streaming *stream)
> +static int uvc_video_clock_init(struct uvc_clock *clock)
>  {
> -	struct uvc_clock *clock = &stream->clock;
> -
>  	spin_lock_init(&clock->lock);
>  	clock->size = 32;
>  
> @@ -614,15 +607,15 @@ static int uvc_video_clock_init(struct uvc_streaming *stream)
>  	if (clock->samples == NULL)
>  		return -ENOMEM;
>  
> -	uvc_video_clock_reset(stream);
> +	uvc_video_clock_reset(clock);
>  
>  	return 0;
>  }
>  
> -static void uvc_video_clock_cleanup(struct uvc_streaming *stream)
> +static void uvc_video_clock_cleanup(struct uvc_clock *clock)
>  {
> -	kfree(stream->clock.samples);
> -	stream->clock.samples = NULL;
> +	kfree(clock->samples);
> +	clock->samples = NULL;
>  }
>  
>  /*
> @@ -2085,7 +2078,7 @@ int uvc_video_resume(struct uvc_streaming *stream, int reset)
>  
>  	stream->frozen = 0;
>  
> -	uvc_video_clock_reset(stream);
> +	uvc_video_clock_reset(&stream->clock);
>  
>  	if (!uvc_queue_streaming(&stream->queue))
>  		return 0;
> @@ -2219,7 +2212,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
>  {
>  	int ret;
>  
> -	ret = uvc_video_clock_init(stream);
> +	ret = uvc_video_clock_init(&stream->clock);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2237,7 +2230,7 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
>  error_video:
>  	usb_set_interface(stream->dev->udev, stream->intfnum, 0);
>  error_commit:
> -	uvc_video_clock_cleanup(stream);
> +	uvc_video_clock_cleanup(&stream->clock);
>  
>  	return ret;
>  }
> @@ -2265,5 +2258,5 @@ void uvc_video_stop_streaming(struct uvc_streaming *stream)
>  		usb_clear_halt(stream->dev->udev, pipe);
>  	}
>  
> -	uvc_video_clock_cleanup(stream);
> +	uvc_video_clock_cleanup(&stream->clock);
>  }
> 

-- 
Regards,

Laurent Pinchart
