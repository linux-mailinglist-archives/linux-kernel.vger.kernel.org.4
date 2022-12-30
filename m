Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5D65995F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 15:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiL3OiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3OiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 09:38:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951591901E;
        Fri, 30 Dec 2022 06:37:57 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8D452F5;
        Fri, 30 Dec 2022 15:37:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672411076;
        bh=XnXoPl0/oTF/xEWJsb6tZooAxDcN8WbanoTfny0E5lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mw0goLIbKld12s8iBzuSOHgRhJKR7suovCSRb33Ato5970iSXCaXellDPX4scibeU
         td7SjRb4NjLYxI7SWI+mLuePiWLihxaBhuZaJAwsnHCF7ciUchkS1zSihq+Jn4PkKy
         Ob7RHN6EorzgzGxGkjnTXbsAHNME0v+1CiJO87/I=
Date:   Fri, 30 Dec 2022 16:37:51 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 6/8] media: uvcvideo: Allow hw clock updates
 with buffers not full
Message-ID: <Y673v07cMWLgHecD@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-6-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-6-0d7978a817cc@chromium.org>
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

On Fri, Dec 02, 2022 at 06:02:46PM +0100, Ricardo Ribalda wrote:
> With UVC 1.5 we get as little as one clock sample per frame. Which means
> that it takes 32 frames to move from the software timestamp to the
> hardware timestamp method.
> 
> This results in abrupt changes in the timestamping after 32 frames (~1
> second), resulting in noticeable artifacts when used for encoding.
> 
> With this patch we modify the update algorithm to work with whatever
> amount of values are available.

This too makes me thing that we should *really* move this to userspace.
It will but much easier to implement clock domain translation there,
with a better precision.

> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 75c32e232f5d..7c6448c6d706 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -742,10 +742,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
>  
>  	spin_lock_irqsave(&clock->lock, flags);
>  
> -	if (clock->count < clock->size)
> +	if (clock->count < 2)
>  		goto done;
>  
> -	first = &clock->samples[clock->head];
> +	first = &clock->samples[(clock->head - clock->count) % clock->size];
>  	last = &clock->samples[(clock->head - 1) % clock->size];
>  
>  	/* First step, PTS to SOF conversion. */
> @@ -760,6 +760,14 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
>  	if (y2 < y1)
>  		y2 += 2048 << 16;
>  
> +	/*
> +	 * Have at least 1/4 of a second of timestamps before we
> +	 * try to do any calculation. Otherwise we do not have enough
> +	 * precission.

s/precission/precision/

How did you determine 250ms was the right threshold ?

> +	 */
> +	if ((y2 - y1) < (256 << 16))
> +		goto done;
> +
>  	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2
>  	  - (u64)y2 * (u64)x1;
>  	y = div_u64(y, x2 - x1);
> 

-- 
Regards,

Laurent Pinchart
