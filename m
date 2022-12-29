Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8008658922
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 04:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiL2DZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 22:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2DZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 22:25:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96D0764F;
        Wed, 28 Dec 2022 19:25:48 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BB6C6109;
        Thu, 29 Dec 2022 04:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672284347;
        bh=0/rDbNgt/5sxI9Wpv4iIZv2FrPG78nKm6P2upG60vfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuG4jdYqtEb0e0IP8kWYxCEA89r81o5HtklmIpj+Bt0N8Be/hqi7eOV2TQ8NwrxzD
         oDW1Pu3VTSYwfoSNmVEhM76f/Zu1z49I0F9ejMquv/5/egZbuP8EsVowatkJ1i3/Ah
         PyQHolfx6bF1CtDnrD1ElaV+FnDvywSINO7qAYqI=
Date:   Thu, 29 Dec 2022 05:25:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH RESEND v2 3/7] media: uvcvideo: Return -EACCES for Wrong
 state error
Message-ID: <Y60Itu7apCFpCKzW@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
 <20220920-resend-v4l2-compliance-v2-3-b0ceb15353ac@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v2-3-b0ceb15353ac@chromium.org>
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

On Fri, Dec 02, 2022 at 06:21:37PM +0100, Ricardo Ribalda wrote:
> For error 2 (Wrong state) return -EACCES instead of -EILSEQ.
> EACCES is a much more appropriate error code. EILSEQ will return
> "Invalid or incomplete multibyte or wide character." in strerror(),
> which is a *very* confusing message.

Unless there's an objection, I'd like to use the following text to
replace the commit message to provide more information:

Error 2 is defined by UVC as

  Wrong State: The device is in a state that disallows the specific
  request. The device will remain in this state until a specific action
  from the host or the user is completed.

This is documented as happening happen when attempting to set the value
of a manual control when the device is in auto mode. While V4L2 allows
this, the closest error code defined by VIDIOC_S_CTRL is indeed EACCES:

EACCES

    Attempt to set a read-only control or to get a write-only control.

    Or if there is an attempt to set an inactive control and the driver
    is not capable of caching the new value until the control is active
    again.

Replace EILSEQ with EACCESS.

> Suggested-by: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 2cf7f692c0bb..497073a50194 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -108,7 +108,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
>  	case 1: /* Not ready */
>  		return -EBUSY;
>  	case 2: /* Wrong state */
> -		return -EILSEQ;
> +		return -EACCES;
>  	case 3: /* Power */
>  		return -EREMOTE;
>  	case 4: /* Out of range */
> 

-- 
Regards,

Laurent Pinchart
