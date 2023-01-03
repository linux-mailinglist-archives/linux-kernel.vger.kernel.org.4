Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC065C7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjACUNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjACUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:13:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C6CFED;
        Tue,  3 Jan 2023 12:13:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8E796108;
        Tue,  3 Jan 2023 21:13:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672776820;
        bh=q+efZsfUDMUrP6QhkibKwErQi+/XPW5vdPE1r+jmiKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSPxMTDtfN6YY/BZ2ZWsG1BSF+FOZVlQVIqRiL1ew9SplGsMCvDDm+k4EQOKqD0Tc
         pvxH+hGWBsV+w6AfKqaR8XAwxoObygzt+oEEJQtMEYDgdTiG0ZDu+FzbRkeSWHfAPb
         QX2sdYq8Wf3KEXwC+xJ2xoioOhoOJUmCEFmjw3nE=
Date:   Tue, 3 Jan 2023 22:13:36 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v3 2/8] media: uvcvideo: improve error logging in
 uvc_query_ctrl()
Message-ID: <Y7SMcMNwg1eflyCj@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
 <20220920-resend-v4l2-compliance-v3-2-598d33a15815@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v3-2-598d33a15815@chromium.org>
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

On Tue, Jan 03, 2023 at 03:36:20PM +0100, Ricardo Ribalda wrote:
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> Standard use of the driver may result in error messages on the kernel
> ring buffer. This can hide other more important messages, and alert

I assume you meant log (or log buffer), not ring buffer. I'll fix that
when applying.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> unnecessarily the user. Let's keep dev_err() for the important
> occasions.
> 
> If __uvc_query_ctrl() failed with a non -EPIPE error, then report that
> with dev_err. If an error code is obtained, then report that with
> dev_dbg.
> 
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..6b20a23bc3cf 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -79,13 +79,14 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>  	if (likely(ret == size))
>  		return 0;
>  
> -	dev_err(&dev->udev->dev,
> -		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> -		uvc_query_name(query), cs, unit, ret, size);
> -
> -	if (ret != -EPIPE)
> +	if (ret != -EPIPE) {
> +		dev_err(&dev->udev->dev,
> +			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> +			uvc_query_name(query), cs, unit, ret, size);
>  		return ret;
> +	}
>  
> +	/* Reuse data[0] to request the error code. */
>  	tmp = *(u8 *)data;
>  
>  	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,

-- 
Regards,

Laurent Pinchart
