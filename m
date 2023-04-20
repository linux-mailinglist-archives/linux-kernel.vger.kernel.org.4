Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC416E8848
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjDTCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjDTCuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:50:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79966E4E;
        Wed, 19 Apr 2023 19:50:18 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 798519DE;
        Thu, 20 Apr 2023 04:50:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681959009;
        bh=VF5BpzwMqipQvUKFfTdRglNdS4KAtWm3Mr2wpxbCRlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gu1Q2+AvO0JSWBeCUsbZ0jjrymYoJLMig7tu52kkmN/UcI6JOO+k53jXYz0F0y2BX
         JIz/DI6NmcVCBnoOjS7aY5v8K30VRZGXj41hjHqm35zYB/spWzPso4O01WyJQPMiAW
         YdrUI3EnsyF0DO//DxXnE6WxNf2ftFb0d7NedoLc=
Date:   Thu, 20 Apr 2023 05:50:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Perchanov <dmitry.perchanov@intel.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, evgeni.raikhel@intel.com,
        demisrael@gmail.com
Subject: Re: [PATCH] uvc: Intel PID enabling UVC Metadata attributes
Message-ID: <20230420025027.GC631@pendragon.ideasonboard.com>
References: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9001ccdec3e3234253cf2f93ea39745ed6f525f1.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Sun, Jan 29, 2023 at 03:43:38PM +0200, Dmitry Perchanov wrote:
> Intel RealSense UVC cameras Metadata support.

The subject line should start with "media: uvcvideo:".

Both the subject line and the body of the commit message should use the
imperative mood. For instance,

media: uvcvideo: Enable Intel RealSense metadata for 8 new devices

Intel RealSense UVC cameras produce metadata in a vendor-specific format
that is already supported by the uvcvideo driver. Enable handling of
this metadata for 8 additional RealSense devices.

> Co-developed-by: Yu MENG <yu1.meng@intel.com>
> Co-developed-by: Evgeni Raikhel <evgeni.raikhel@intel.com>
> Signed-off-by: Dmitry Perchanov <dmitry.perchanov@intel.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 72 ++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index e4bcb5011360..955f67d9a993 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -3000,6 +3000,78 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D410/ASR depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad2,

Please keep entries sorted by vendor and product ID in this list. The
first four entries from this patch should go before 8086:0b03 that is
already in the driver.

> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D415/ASRC depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad3,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D430/AWG depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad4,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel Fallback USB2 Descriptor */

According to the descriptors you've provided (thank you for that), this
camera is named "Depth Camera 430". How does it differ from the 0ad4
device which you also name 430 right above ?

> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0ad6,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D435/AWGC depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b07,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D435i depth camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b3a,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D405 Depth Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b5b,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
> +	/* Intel D455 Depth Camera */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x8086,
> +	  .idProduct		= 0x0b5c,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_META(V4L2_META_FMT_D4XX) },
>  	/* Generic USB Video Class */
>  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_UNDEFINED) },
>  	{ USB_INTERFACE_INFO(USB_CLASS_VIDEO, 1, UVC_PC_PROTOCOL_15) },

-- 
Regards,

Laurent Pinchart
