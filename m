Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B3660894
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjAFU77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjAFU7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:59:55 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C88673E22;
        Fri,  6 Jan 2023 12:59:54 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D56794AE;
        Fri,  6 Jan 2023 21:59:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673038793;
        bh=tfFk4cqOy1XZOWYxQx6dNDf7ZPddGqF7hvQjN8/ARcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otnO9peaexEaR6dNwwdK/TH9cG1Yy9JmNOzvWmhLNnx5tIgkCoKFznTboBEx1CcTB
         wz2ld2BBZL3CJzDSBVQAxhMYL5WkA2fqChJla67pfRGYeLfD5cr2Ee2VQxq0ox65/d
         j0e0swG0f+27FAwC5RpxJgRfIIXVBIk30EeeGVhM=
Date:   Fri, 6 Jan 2023 22:59:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 6/7] media: uvcvideo: Fix power line control for
 Lenovo Integrated Camera
Message-ID: <Y7iLwzYCEzhT8lCl@pendragon.ideasonboard.com>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
 <20230105-uvc-gcc5-v2-6-2ba6c660d6f5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105-uvc-gcc5-v2-6-2ba6c660d6f5@chromium.org>
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

On Thu, Jan 05, 2023 at 02:52:57PM +0100, Ricardo Ribalda wrote:
> The device does not implement the power line control correctly. It is
> a UVC 1.5 device, but implements the PLC control as a UVC 1.1 device.

Did you mean PLF (power line frequency) ? I'd write:

The device does not implement the power line frequency control
correctly. It is a UVC 1.5 device, but implements the control as a UVC
1.1 device.

No need to resubmit just for this, I'll handle it locally.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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
>  drivers/media/usb/uvc/uvc_ctrl.c   |  2 +-
>  drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index f559a1ac6e3c..28ef9b2024a1 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -736,7 +736,7 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>  				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
>  };
>  
> -static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
> +const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
>  	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
>  	.entity		= UVC_GUID_UVC_PROCESSING,
>  	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 37d2b08bc8b2..57c948d47bbf 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2385,6 +2385,13 @@ static const struct uvc_device_info uvc_ctrl_power_line_limited = {
>  	},
>  };
>  
> +static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
> +	.mappings = (const struct uvc_control_mapping *[]) {
> +		&uvc_ctrl_power_line_mapping_uvc11,
> +		NULL, /* Sentinel */
> +	},
> +};
> +
>  static const struct uvc_device_info uvc_quirk_probe_minmax = {
>  	.quirks = UVC_QUIRK_PROBE_MINMAX,
>  };
> @@ -2964,6 +2971,15 @@ static const struct usb_device_id uvc_ids[] = {
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
> index 1b2d9f327583..31c33eb0edf5 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -748,6 +748,7 @@ void uvc_status_stop(struct uvc_device *dev);
>  
>  /* Controls */
>  extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
> +extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>  
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
Regards,

Laurent Pinchart
