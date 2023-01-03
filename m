Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069665C89E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjACVHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjACVGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:06:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6692E14D2E;
        Tue,  3 Jan 2023 13:06:13 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 507FF108;
        Tue,  3 Jan 2023 22:06:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672779971;
        bh=+aDZNTXe2PPDjTmLCglr6MqZJ+xkLWv0E9JnBAc5lYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vD8Vbho+G8SPqlP4FQcJUzeOCq/VVTXUzTxubn7/6qtv6p8OOWrLdKsz1P9x+YxnO
         5hpqJylLW8YYlLpXBseTe66NkbyxY5lQTkZECmiCP1E0/jTUwJ6iuuuwc20q8m3p57
         2ckBT4cOhHdMv1oj/6+R5J+vPJEJ0vhjlFLfrT5w=
Date:   Tue, 3 Jan 2023 23:06:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Fix power line control for
 Lenovo Integrated Camera
Message-ID: <Y7SYviXPM9bpTgE8@pendragon.ideasonboard.com>
References: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
 <20221101-easycam-v3-2-2c9881a7a4f7@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101-easycam-v3-2-2c9881a7a4f7@chromium.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        SUBJECT_DRUG_GAP_L autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Jan 03, 2023 at 12:01:22PM +0100, Ricardo Ribalda wrote:
> The device does not implement the power line control correctly. It is
> a UVC 1.5 device, but implements the PLC control as a UVC 1.1 device.
> 
> Add the corresponding control mapping override.
> 
> Bus 003 Device 002: ID 30c9:0093 Lenovo Integrated Camera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.01
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x30c9
>   idProduct          0x0093
>   bcdDevice            0.07
>   iManufacturer           3 Lenovo
>   iProduct                1 Integrated Camera
>   iSerial                 2 8SSC21J75356V1SR2830069
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 24 +++++++++++++-----------
>  drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index c95a2229f4fa..d8283d71bc96 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -721,18 +721,20 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  	},
>  };
>  
> +const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls,
> +	.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
> +};
> +
>  static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
> -	{
> -		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> -		.entity		= UVC_GUID_UVC_PROCESSING,
> -		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> -		.size		= 2,
> -		.offset		= 0,
> -		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> -		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
> -	},
> +	uvc_ctrl_power_line_mapping_uvc11,

This conflicts with your v4l2-compliance fixes series that I have
applied to my tree. I have fixed the conflict locally and pushed the
result to
https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=next/uvc,
could you check that I got it right ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  };
>  
>  static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index f2abd9d0c717..9c09bc988278 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2370,6 +2370,13 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>   * Driver initialization and cleanup
>   */
>  
> +static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
> +	.mappings = (const struct uvc_control_mapping *[]) {
> +		&uvc_ctrl_power_line_mapping_uvc11,
> +		NULL, /* Sentinel */
> +	},
> +};
> +
>  static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
>  	{ 1, "50 Hz" },
>  	{ 2, "60 Hz" },
> @@ -2973,6 +2980,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
> +	/* Lenovo Integrated Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x30c9,
> +	  .idProduct		= 0x0093,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
>  	/* Sonix Technology USB 2.0 Camera */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index df93db259312..bcb0b0c101c8 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -728,6 +728,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
>  void uvc_status_stop(struct uvc_device *dev);
>  
>  /* Controls */
> +extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>  
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
Regards,

Laurent Pinchart
