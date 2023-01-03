Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416D565C8A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjACVHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjACVHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:07:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742B14D27;
        Tue,  3 Jan 2023 13:07:14 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C78F108;
        Tue,  3 Jan 2023 22:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672780033;
        bh=bmZB0Q9xCjDn+9uoW5TOUREaIf+NwqIvz6tpXMzKV4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yo5Iu4/penyekAhl3mBRQumyR8GGfS0vBTq5yp0htzKvP/vnpSZl7CSv//qq5CG9d
         cnDxR0xRmrs0m6jO5WT1Ul9f957oGqd6TbfodNOBW3reJQy8Eyl0K62yfGD0zSQG35
         /Oxe9Ng4l5kmg1nOFUzUUKbpEcTxCfvnmC9fP0mY=
Date:   Tue, 3 Jan 2023 23:07:09 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 3/3] media: uvcvideo: Refactor
 power_line_frequency_controls_limited
Message-ID: <Y7SY/eXJ2HPShSRa@pendragon.ideasonboard.com>
References: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
 <20221101-easycam-v3-3-2c9881a7a4f7@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101-easycam-v3-3-2c9881a7a4f7@chromium.org>
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

On Tue, Jan 03, 2023 at 12:01:23PM +0100, Ricardo Ribalda wrote:
> Move the control mapping to uvc_ctrl.c. This way we do not have
> references to uvc controls or v4l2 controls in uvc_driver.c

s/uvc/UVC/
s/v4l2/V4L2/

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 17 +++++++++++++++++
>  drivers/media/usb/uvc/uvc_driver.c | 17 -----------------
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +

This conflicts quite badly with 8/8 from your v4l2-compliance series.
Could you rebase one of top of the other and resend the two patches as
one series, on top of
https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=next/uvc
?

>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index d8283d71bc96..4ff0415d8bf4 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -370,6 +370,11 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
>  	{ 3, "Auto" },
>  };
>  
> +static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> +	{ 1, "50 Hz" },
> +	{ 2, "60 Hz" },
> +};
> +
>  static const struct uvc_menu_info exposure_auto_controls[] = {
>  	{ 2, "Auto Mode" },
>  	{ 1, "Manual Mode" },
> @@ -751,6 +756,18 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>  	},
>  };
>  
> +const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls_limited,
> +	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
> +};
> +
>  /* ------------------------------------------------------------------------
>   * Utility functions
>   */
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c09bc988278..6531aed5d642 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2377,23 +2377,6 @@ static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
>  	},
>  };
>  
> -static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> -	{ 1, "50 Hz" },
> -	{ 2, "60 Hz" },
> -};
> -
> -static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
> -	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> -	.entity		= UVC_GUID_UVC_PROCESSING,
> -	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> -	.size		= 2,
> -	.offset		= 0,
> -	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> -	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -	.menu_info	= power_line_frequency_controls_limited,
> -	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
> -};
> -
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
>  	.mappings = (const struct uvc_control_mapping *[]) {
>  		&uvc_ctrl_power_line_mapping_limited,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index bcb0b0c101c8..818ae7a6f9b9 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -728,6 +728,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
>  void uvc_status_stop(struct uvc_device *dev);
>  
>  /* Controls */
> +extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
>  extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>  

-- 
Regards,

Laurent Pinchart
