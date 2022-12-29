Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E86588CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiL2C7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiL2C73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:59:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AAD10FCE;
        Wed, 28 Dec 2022 18:59:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2A55109;
        Thu, 29 Dec 2022 03:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672282767;
        bh=YlB4C8HyjVBwzOC0nTE75Xm0bR+yCI7bML4cjb7g6CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4dgPeRfKx7nSTNGAMkkml2X0DY9rFuV0Aj+XII8d1fk++zvN3SCiUXWhhjdNRrob
         QIywI56VqTCQbam+bzFkWYlh9k1JWrUwkdd/9DwLOJCc7V76vvCpym//6VOUsDQSy8
         CLkwOQZSspj3/iQudrRgh/U1lSjjeGlCsXoVTEks=
Date:   Thu, 29 Dec 2022 04:59:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH RESEND v2 2/7] media: uvcvideo: improve error logging in
 uvc_query_ctrl()
Message-ID: <Y60Ci5awdZnY2AN2@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
 <20220920-resend-v4l2-compliance-v2-2-b0ceb15353ac@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v2-2-b0ceb15353ac@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo and Hans,

Thank you for the patch.

On Fri, Dec 02, 2022 at 06:21:36PM +0100, Ricardo Ribalda wrote:
> From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> 
> If __uvc_query_ctrl() failed with a non-EPIPE error, then
> report that with dev_err. If an error code is obtained, then
> report that with dev_dbg.

The commit message should explain why this is desirable.

> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 170a008f4006..2cf7f692c0bb 100644
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
> +	/* reuse data[0] to request the error code. */

s/reuse/Reuse/

>  	tmp = *(u8 *)data;
>  
>  	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,
> 

-- 
Regards,

Laurent Pinchart
