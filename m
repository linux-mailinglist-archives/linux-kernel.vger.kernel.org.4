Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51A060D3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiJYSiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiJYSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:38:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41DF53D2;
        Tue, 25 Oct 2022 11:38:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-12-207-nat.elisa-mobile.fi [85.76.12.207])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B41C58A9;
        Tue, 25 Oct 2022 20:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1666723120;
        bh=+fDemZWJ9BwDUYADwraNb69Z+e4JWb/6Gqb5xaNyzLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxd4zU4d21619ybOetl24mVP6I07btNjUUY4QrCXZuJKdz4z8ApF7mZa2J33vOAOS
         YPR7eCGWe3RfktFxk2PJXSjD9oVqOCDmk027t3x4fT/m9eLXTrdbF4EooVPaQot1/b
         xjBJ53sk9QKthu1hakbFrmKQ79SkVcaR6MLiUGp0=
Date:   Tue, 25 Oct 2022 21:38:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] media: uvcvideo: Handle errors from calls to
 usb_string
Message-ID: <Y1gtFNPYmegewAGH@pendragon.ideasonboard.com>
References: <20221025-usb-string-v1-0-4c351b6907bb@chromium.org>
 <20221025-usb-string-v1-1-4c351b6907bb@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025-usb-string-v1-1-4c351b6907bb@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo and Guenter,

Thank you for the patch.

On Tue, Oct 25, 2022 at 04:41:01PM +0200, Ricardo Ribalda wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> On a Webcam from Quanta, we see the following error.
> 
> usb 3-5: New USB device found, idVendor=0408, idProduct=30d2, bcdDevice= 0.03
> usb 3-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> usb 3-5: Product: USB2.0 HD UVC WebCam
> usb 3-5: Manufacturer: Quanta
> usb 3-5: SerialNumber: 0x0001
> ...
> uvcvideo: Found UVC 1.10 device USB2.0 HD UVC WebCam (0408:30d2)
> uvcvideo: Failed to initialize entity for entity 5
> uvcvideo: Failed to register entities (-22).
> 
> The Webcam reports an entity of type UVC_VC_EXTENSION_UNIT. It reports a
> string index of '7' associated with that entity. The attempt to read that
> string from the camera fails with error -32 (-EPIPE). usb_string() returns
> that error, but it is ignored. As result, the entity name is empty. This
> later causes v4l2_device_register_subdev() to return -EINVAL, and no
> entities are registered as result.
> 
> While this appears to be a firmware problem with the camera, the kernel
> should still handle the situation gracefully. To do that, check the return
> value from usb_string(). If it reports an error, assign the entity's
> default name.

Sounds good. The perfect world in which firmwares could be fixed doesn't
exist.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 215fb483efb0..828c443faaa9 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -879,10 +879,8 @@ static int uvc_parse_vendor_control(struct uvc_device *dev,
>  					       + n;
>  		memcpy(unit->extension.bmControls, &buffer[23+p], 2*n);
>  
> -		if (buffer[24+p+2*n] != 0)
> -			usb_string(udev, buffer[24+p+2*n], unit->name,
> -				   sizeof(unit->name));
> -		else
> +		if (buffer[24+p+2*n] == 0 ||
> +		    usb_string(udev, buffer[24+p+2*n], unit->name, sizeof(unit->name)) < 0)
>  			sprintf(unit->name, "Extension %u", buffer[3]);

There's quite a bit of common code between all the cases. I'll submit a
patch that refactors it on top. There's thus no need for nitpicking
here, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  		list_add_tail(&unit->list, &dev->entities);
> @@ -1006,15 +1004,15 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  			memcpy(term->media.bmTransportModes, &buffer[10+n], p);
>  		}
>  
> -		if (buffer[7] != 0)
> -			usb_string(udev, buffer[7], term->name,
> -				   sizeof(term->name));
> -		else if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA)
> -			sprintf(term->name, "Camera %u", buffer[3]);
> -		else if (UVC_ENTITY_TYPE(term) == UVC_ITT_MEDIA_TRANSPORT_INPUT)
> -			sprintf(term->name, "Media %u", buffer[3]);
> -		else
> -			sprintf(term->name, "Input %u", buffer[3]);
> +		if (buffer[7] == 0 ||
> +		    usb_string(udev, buffer[7], term->name, sizeof(term->name)) < 0) {
> +			if (UVC_ENTITY_TYPE(term) == UVC_ITT_CAMERA)
> +				sprintf(term->name, "Camera %u", buffer[3]);
> +			if (UVC_ENTITY_TYPE(term) == UVC_ITT_MEDIA_TRANSPORT_INPUT)
> +				sprintf(term->name, "Media %u", buffer[3]);
> +			else
> +				sprintf(term->name, "Input %u", buffer[3]);
> +		}
>  
>  		list_add_tail(&term->list, &dev->entities);
>  		break;
> @@ -1047,10 +1045,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  
>  		memcpy(term->baSourceID, &buffer[7], 1);
>  
> -		if (buffer[8] != 0)
> -			usb_string(udev, buffer[8], term->name,
> -				   sizeof(term->name));
> -		else
> +		if (buffer[8] == 0 ||
> +		    usb_string(udev, buffer[8], term->name, sizeof(term->name)) < 0)
>  			sprintf(term->name, "Output %u", buffer[3]);
>  
>  		list_add_tail(&term->list, &dev->entities);
> @@ -1072,10 +1068,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  
>  		memcpy(unit->baSourceID, &buffer[5], p);
>  
> -		if (buffer[5+p] != 0)
> -			usb_string(udev, buffer[5+p], unit->name,
> -				   sizeof(unit->name));
> -		else
> +		if (buffer[5+p] == 0 ||
> +		    usb_string(udev, buffer[5+p], unit->name, sizeof(unit->name)) < 0)
>  			sprintf(unit->name, "Selector %u", buffer[3]);
>  
>  		list_add_tail(&unit->list, &dev->entities);
> @@ -1105,10 +1099,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  		if (dev->uvc_version >= 0x0110)
>  			unit->processing.bmVideoStandards = buffer[9+n];
>  
> -		if (buffer[8+n] != 0)
> -			usb_string(udev, buffer[8+n], unit->name,
> -				   sizeof(unit->name));
> -		else
> +		if (buffer[8+n] == 0 ||
> +		    usb_string(udev, buffer[8+n], unit->name, sizeof(unit->name)) < 0)
>  			sprintf(unit->name, "Processing %u", buffer[3]);
>  
>  		list_add_tail(&unit->list, &dev->entities);
> @@ -1136,10 +1128,8 @@ static int uvc_parse_standard_control(struct uvc_device *dev,
>  		unit->extension.bmControls = (u8 *)unit + sizeof(*unit);
>  		memcpy(unit->extension.bmControls, &buffer[23+p], n);
>  
> -		if (buffer[23+p+n] != 0)
> -			usb_string(udev, buffer[23+p+n], unit->name,
> -				   sizeof(unit->name));
> -		else
> +		if (buffer[23+p+n] == 0 ||
> +		    usb_string(udev, buffer[23+p+n], unit->name, sizeof(unit->name)) < 0)
>  			sprintf(unit->name, "Extension %u", buffer[3]);
>  
>  		list_add_tail(&unit->list, &dev->entities);
> 

-- 
Regards,

Laurent Pinchart
