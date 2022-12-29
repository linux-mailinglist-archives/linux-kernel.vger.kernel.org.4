Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545AE65889E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiL2C0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiL2C0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:26:02 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3867212084;
        Wed, 28 Dec 2022 18:26:01 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 991E3109;
        Thu, 29 Dec 2022 03:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672280759;
        bh=XTqSHYRuQBdAXTVZrTC7Vc59CCgx05BlnkgUtqb6mwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXMUGhPCpN4DAw/XzpO47FFatkw9u4o2LS9AhOWP7Mb3kLAskhiRDSHdoIk7WmQZW
         /H+hT2QXVCLsYVJz3TonUyBYbBH2Lazz9yX3MSXte7AOzX21KGE/6b8yLh8nmrR4v5
         YWcGbscjip3T++HgQZWbJVtPIgK8vJi6OR3036iw=
Date:   Thu, 29 Dec 2022 04:25:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/2] media: uvcvideo: Limit power line control
 for Acer EasyCamera
Message-ID: <Y6z6swFLQuS2z2oq@pendragon.ideasonboard.com>
References: <20221101-easycam-v2-0-ffe3e3a152df@chromium.org>
 <20221101-easycam-v2-1-ffe3e3a152df@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101-easycam-v2-1-ffe3e3a152df@chromium.org>
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

On Fri, Dec 02, 2022 at 05:45:06PM +0100, Ricardo Ribalda wrote:
> The device does not implement the power line control correctly. Add a
> corresponding control mapping override.
> 
> Bus 003 Device 002: ID 5986:1180 Acer, Inc EasyCamera
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x5986 Acer, Inc
>   idProduct          0x1180
>   bcdDevice           56.04
>   iManufacturer           3 Bison
>   iProduct                1 EasyCamera
>   iSerial                 2
>   bNumConfigurations      1

If you have the full descriptors for this device, could you send them to
me ?

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 215fb483efb0..cca3012c8912 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2994,6 +2994,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
> +	/* Acer EasyCamera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x5986,
> +	  .idProduct		= 0x1180,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
>  	/* Intel RealSense D4M */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> 

-- 
Regards,

Laurent Pinchart
