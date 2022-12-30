Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2A65997F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 15:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiL3OvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 09:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiL3OvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 09:51:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A130EDDC;
        Fri, 30 Dec 2022 06:51:07 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D42A2F5;
        Fri, 30 Dec 2022 15:51:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672411866;
        bh=ahqWw0F7ZViaezyio1kQAwgm6ChPVpdGYJt0bI6lOCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0N2tl8dmoKP1GguFOuIcDhYvcf/GZSDHb6OdYvBezMmdCyjwYsUQpTSl67v3o4Nu
         YXZsqFkMpxwI5P+yd4V81660MvCboXJcrUGEa4cs6sZZw6mK/mV8yJXB/8OZAho4kd
         9TFDTwtPWYLNEF0gW4pUMVixTEHIqGeyVhpFToXs=
Date:   Fri, 30 Dec 2022 16:51:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 8/8] media: uvcvideo: Fix hw timestampt
 handling for slow FPS
Message-ID: <Y6761ScB9FgMC6zb@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-8-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-8-0d7978a817cc@chromium.org>
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

On Fri, Dec 02, 2022 at 06:02:48PM +0100, Ricardo Ribalda wrote:
> In UVC 1.5, when working with FPS under 32, there is a chance that the
> circular buffer contains two dev_sof overflows,

An explanation of why this is the case would be good in the commit
message. Also, by overflow, are you talking about the SOF counter
rolling over ?

> but the clock interpolator
> is only capable of handle a single overflow.
> 
> Remove all the samples from the circular buffer that are two overflows
> old.

I would rather support multiple roll-over in the clock interpolator.
Dropping older sampls will lead to less predictable behaviour and harder
to debug issues.

> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 15 +++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h  |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index c81a8362d582..6b6bd521d6c2 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -471,6 +471,20 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
>  
>  	spin_lock_irqsave(&clock->lock, flags);
>  
> +	/* Delete last overflows */
> +	if (clock->head == clock->last_sof_overflow)
> +		clock->last_sof_overflow = -1;
> +
> +	/* Handle overflows */
> +	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> +		/* Remove data from the last^2 overflows */
> +		if (clock->last_sof_overflow != -1)
> +			clock->count = (clock->head - clock->last_sof_overflow)
> +								% clock->count;
> +		clock->last_sof_overflow = clock->head;
> +	}
> +
> +	/* Add sample */
>  	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
>  	clock->last_sof = sample->dev_sof;
>  	clock->head = (clock->head + 1) % clock->size;
> @@ -594,6 +608,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
>  	clock->head = 0;
>  	clock->count = 0;
>  	clock->last_sof = -1;
> +	clock->last_sof_overflow = -1;
>  	clock->sof_offset = -1;
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 14daa7111953..d8c520ce5a86 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -647,6 +647,7 @@ struct uvc_streaming {
>  		unsigned int head;
>  		unsigned int count;
>  		unsigned int size;
> +		unsigned int last_sof_overflow;
>  
>  		u16 last_sof;
>  		u16 sof_offset;

-- 
Regards,

Laurent Pinchart
