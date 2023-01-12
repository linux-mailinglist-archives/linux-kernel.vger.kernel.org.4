Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEF46686E4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbjALWZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjALWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:24:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A268BC9C;
        Thu, 12 Jan 2023 14:21:52 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 894AB492;
        Thu, 12 Jan 2023 23:21:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673562110;
        bh=JYDT9Cxb5rPfDdhsk/jpCwTetvrQIHY6XMfqVHEozcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QU4FN+fPuYkta4xsc/h2myr26Q2wbMzGcZPoJ1AltGSBffKnymJ31SG/d/J7intDJ
         2306rOcbeX/dMJ1rK+PK7PCXxq6QAG1+L7VsvXKWetLOJNCY6kIWgwPz9rDsVkXP9T
         ms41ce572DYLGRT+qYJYz3KQKJ8JIW1AUG6NbA2Q=
Date:   Fri, 13 Jan 2023 00:21:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] media: uvcvideo: improve error logging in
 uvc_query_ctrl()
Message-ID: <Y8CH/Y/izN6jXEeB@pendragon.ideasonboard.com>
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

Hi Hans,

On Tue, Jan 03, 2023 at 03:36:20PM +0100, Ricardo Ribalda wrote:
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

There's also a mismatch here between From and Signed-off-by.

> Standard use of the driver may result in error messages on the kernel
> ring buffer. This can hide other more important messages, and alert
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
> 

-- 
Regards,

Laurent Pinchart
