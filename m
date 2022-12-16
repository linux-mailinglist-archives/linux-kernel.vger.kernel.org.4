Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4530E64EE25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLPPtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiLPPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:49:48 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 12B6557B63
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:49:48 -0800 (PST)
Received: (qmail 997870 invoked by uid 1000); 16 Dec 2022 10:49:47 -0500
Date:   Fri, 16 Dec 2022 10:49:47 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ray Chi <raychi@google.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: core: hub: disable autosuspend for TI TUSB8041
Message-ID: <Y5yTm5PsE8n4whq/@rowland.harvard.edu>
References: <20221216141717.2728340-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216141717.2728340-1-f.suligoi@asem.it>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 03:17:17PM +0100, Flavio Suligoi wrote:
> The Texas Instruments TUSB8041 has an autosuspend problem at high
> temperature.
> 
> If there is not USB traffic, after a couple of ms, the device enters in
> autosuspend mode. In this condition the external clock stops working, to
> save energy. When the USB activity turns on, ther hub exits the
> autosuspend state, the clock starts running again and all works fine.
> 
> At ambient temperature all works correctly, but at high temperature,
> when the USB activity turns on, the external clock doesn't restart and
> the hub disappears from the USB bus.
> 
> Disabling the autosuspend mode for this hub solves the issue.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/usb/core/hub.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 77e73fc8d673..b64be35e203f 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -44,6 +44,10 @@
>  #define USB_PRODUCT_USB5534B			0x5534
>  #define USB_VENDOR_CYPRESS			0x04b4
>  #define USB_PRODUCT_CY7C65632			0x6570
> +#define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
> +#define USB_PRODUCT_TUSB8041_USB3		0x8140
> +#define USB_PRODUCT_TUSB8041_USB2		\
> +	(USB_PRODUCT_TUSB8041_USB3 | ((USB_PRODUCT_TUSB8041_USB3 & 0x00FF) ^ 0x02))

Argh.  Just put the actual hex number here -- people don't want to do 
calculations like this in their head when they are reading code.  (Not 
to mention that the number would occupy only six characters of source 
text whereas your calculation occupies a lot more.)

Otherwise fine.

Alan Stern

>  #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
>  #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
>  
> @@ -5854,6 +5858,16 @@ static const struct usb_device_id hub_id_table[] = {
>        .idVendor = USB_VENDOR_GENESYS_LOGIC,
>        .bInterfaceClass = USB_CLASS_HUB,
>        .driver_info = HUB_QUIRK_CHECK_PORT_AUTOSUSPEND},
> +    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
> +			| USB_DEVICE_ID_MATCH_PRODUCT,
> +      .idVendor = USB_VENDOR_TEXAS_INSTRUMENTS,
> +      .idProduct = USB_PRODUCT_TUSB8041_USB2,
> +      .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
> +    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
> +			| USB_DEVICE_ID_MATCH_PRODUCT,
> +      .idVendor = USB_VENDOR_TEXAS_INSTRUMENTS,
> +      .idProduct = USB_PRODUCT_TUSB8041_USB3,
> +      .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
>      { .match_flags = USB_DEVICE_ID_MATCH_DEV_CLASS,
>        .bDeviceClass = USB_CLASS_HUB},
>      { .match_flags = USB_DEVICE_ID_MATCH_INT_CLASS,
> -- 
> 2.25.1
> 
