Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61A6588A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiL2Cbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2Cbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:31:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6101813D47;
        Wed, 28 Dec 2022 18:31:43 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C8B3D109;
        Thu, 29 Dec 2022 03:31:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672281102;
        bh=dH8oWD18PnHqBJzdW67bOpes0o1O+bRiZKBgAZ4gzJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsTS9aEBpL2yHQtmZeLWgqFxYM+F8pvNzSUgbFdmf0M/mEZJo9NMjlIccPiKN4nL2
         ILMkomfv/+64WoOYEkVqt8OKrbN41rYNQXLbnUOkeFLHd5DgaxePs76m3OIcYR97Iw
         oE3vZAIs0ulPkjUkWcoGwDDK/BOAu7BBTeadpuyc=
Date:   Thu, 29 Dec 2022 04:31:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] media: uvcvideo: Limit power line control
 for Lenovo Integrated Camera
Message-ID: <Y6z8Cc9LWa3Nyin3@pendragon.ideasonboard.com>
References: <20221101-easycam-v2-0-ffe3e3a152df@chromium.org>
 <20221101-easycam-v2-2-ffe3e3a152df@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101-easycam-v2-2-ffe3e3a152df@chromium.org>
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

On Fri, Dec 02, 2022 at 05:45:07PM +0100, Ricardo Ribalda wrote:
> The device does not implement the power line control correctly. Add a
> corresponding control mapping override.

Do I understand correctly that this device advertises UVC 1.5 support
buth implements the power line frequency control as if it was a UVC 1.1
device ? Could you record this in the commit message ?

I wonder how all these cameras can pass the UVC conformance test suite.
Either they don't even bother trying, or the test suite is useless.

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
>  drivers/media/usb/uvc/uvc_driver.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index cca3012c8912..e0bb21f2e133 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2373,6 +2373,30 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>   * Driver initialization and cleanup
>   */
>  
> +static const struct uvc_menu_info power_line_frequency_controls_uvc11[] = {
> +	{ 0, "Disabled" },
> +	{ 1, "50 Hz" },
> +	{ 2, "60 Hz" },
> +};
> +
> +static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
> +	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
> +	.entity		= UVC_GUID_UVC_PROCESSING,
> +	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> +	.size		= 2,
> +	.offset		= 0,
> +	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
> +	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> +	.menu_info	= power_line_frequency_controls_uvc11,
> +	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_uvc11),
> +};

It would be nice to avoid duplicating the data, do you think we could
reference uvc_ctrl_mappings_uvc11 from uvc_ctrl.c instead ?

> +
> +static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
> +	.mappings = (const struct uvc_control_mapping *[]) {
> +		&uvc_ctrl_power_line_mapping_uvc11,
> +		NULL, /* Sentinel */
> +	},
> +};
>  static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
>  	{ 1, "50 Hz" },
>  	{ 2, "60 Hz" },
> @@ -2976,6 +3000,15 @@ static const struct usb_device_id uvc_ids[] = {
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

-- 
Regards,

Laurent Pinchart
