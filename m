Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA2698C39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBPFlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBPFlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:41:14 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6517CD2;
        Wed, 15 Feb 2023 21:41:11 -0800 (PST)
Date:   Thu, 16 Feb 2023 05:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1676526069; bh=ICRGtG9359SaAN/rDc4Md+VnU2SIcs/J7MxVLU42JTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVmevh1UBjkgnuPL8cyJlYsFZOXbzyJZHUk5sjJZz+Og3E49NQvSIMnSuZwc+tLab
         s86WIwibkZCETDvPZJEkC8E3ZBhvPJpUM54qh0KeOu9trOQ9GjbTL3laFBatJAOdek
         m5KpFpCmhFJk/9gNRTBPHQxVGKyznz5HeWWrfgII=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH 2/2] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
Message-ID: <20230216054105.nmtft5ma4hiuqwib@t-8ch.de>
References: <20230216041224.4731-1-orlandoch.dev@gmail.com>
 <20230216041224.4731-3-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216041224.4731-3-orlandoch.dev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:12:28PM +1100, Orlando Chamberlain wrote:
> This driver adds support for the keyboard backlight on Intel T2 Macs
> with internal Magic Keyboards (MacBookPro16,x and MacBookAir9,1)
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> Co-developed-by: Kerem Karabay <kekrby@gmail.com>
> Signed-off-by: Kerem Karabay <kekrby@gmail.com>

The last Signed-off-by should be yours.
See Documentation/process/submitting-patches.rst.

> ---
>  MAINTAINERS                         |   6 ++
>  drivers/hid/Kconfig                 |  13 +++
>  drivers/hid/Makefile                |   1 +
>  drivers/hid/apple-magic-backlight.c | 125 ++++++++++++++++++++++++++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 drivers/hid/apple-magic-backlight.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb1471cb5ed3..3319f0c3ed1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9201,6 +9201,12 @@ F:	include/linux/pm.h
>  F:	include/linux/suspend.h
>  F:	kernel/power/
>  
> +HID APPLE MAGIC BACKLIGHT DRIVER
> +M:	Orlando Chamberlain <orlandoch.dev@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hid/apple-magic-backlight.c
> +
>  HID CORE LAYER
>  M:	Jiri Kosina <jikos@kernel.org>
>  M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e2a5d30c8895..f4702d32ce2f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -130,6 +130,19 @@ config HID_APPLE
>  	Say Y here if you want support for keyboards of	Apple iBooks, PowerBooks,
>  	MacBooks, MacBook Pros and Apple Aluminum.
>  
> +config HID_APPLE_MAGIC_BACKLIGHT
> +	tristate "Apple Magic Keyboard Backlight"
> +	depends on USB_HID
> +	depends on LEDS_CLASS
> +	depends on NEW_LEDS
> +	help
> +	Say Y here if you want support for the keyboard backlight on Macs with
> +	the magic keyboard (MacBookPro16,x and MacBookAir9,1). Note that this
> +	driver is not for external magic keyboards.
> +
> +	To compile this driver as a module, choose M here: the
> +	module will be called apple-magic-backlight.
> +
>  config HID_APPLEIR
>  	tristate "Apple infrared receiver"
>  	depends on (USB_HID)
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index e8014c1a2f8b..5cbfe85dd31b 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_HID_ACCUTOUCH)	+= hid-accutouch.o
>  obj-$(CONFIG_HID_ALPS)		+= hid-alps.o
>  obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
>  obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
> +obj-$(CONFIG_HID_APPLE_MAGIC_BACKLIGHT)	+= apple-magic-backlight.o
>  obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
>  obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
>  obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
> diff --git a/drivers/hid/apple-magic-backlight.c b/drivers/hid/apple-magic-backlight.c
> new file mode 100644
> index 000000000000..ed5bcf5bb599
> --- /dev/null
> +++ b/drivers/hid/apple-magic-backlight.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple Magic Keyboard Backlight Driver
> + *
> + * For Intel Macs with internal Magic Keyboard (MacBookPro16,1-4 and MacBookAir9,1)
> + *
> + * Copyright (c) 2022 Kerem Karabay <kekrby@gmail.com>
> + * Copyright (c) 2023 Orlando Chamberlain <orlandoch.dev@gmail.com>
> + */
> +
> +#include <linux/hid.h>
> +#include <linux/usb.h>

No need for linux/usb.h.

> +#include <linux/leds.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <dt-bindings/leds/common.h>
> +
> +#include "hid-ids.h"
> +
> +#define HID_USAGE_MAGIC_BL	0xff00000f
> +
> +#define APPLE_MAGIC_REPORT_ID_POWER 3
> +#define APPLE_MAGIC_REPORT_ID_BRIGHTNESS 1
> +
> +struct apple_magic_backlight {
> +	struct led_classdev cdev;
> +	struct hid_device *hdev;
> +	struct hid_report *brightness;
> +	struct hid_report *power;
> +};
> +
> +static void apple_magic_backlight_report_set(struct hid_report *rep, u16 value, u8 rate)
> +{

Could "value" be a s32? "logical_maximum" from the field is a s32,
so there is no risk of truncation.

> +	rep->field[0]->value[0] = value;
> +	rep->field[1]->value[0] = 0x5e; /* Mimic Windows */
> +	rep->field[1]->value[0] |= rate << 8;
> +
> +	hid_hw_request(rep->device, rep, HID_REQ_SET_REPORT);
> +}
> +
> +static void apple_magic_backlight_set(struct apple_magic_backlight *backlight,
> +				     int brightness, char rate)
> +{
> +	apple_magic_backlight_report_set(backlight->power, brightness ? 1 : 0, rate);
> +	if (brightness)
> +		apple_magic_backlight_report_set(backlight->brightness, brightness, rate);
> +}
> +
> +static int apple_magic_backlight_led_set(struct led_classdev *led_cdev,
> +					 enum led_brightness brightness)
> +{
> +	struct apple_magic_backlight *backlight = container_of(led_cdev,
> +			struct apple_magic_backlight, cdev);
> +
> +	apple_magic_backlight_set(backlight, brightness, 1);
> +	return 0;
> +}
> +
> +static int apple_magic_backlight_probe(struct hid_device *hdev,
> +				       const struct hid_device_id *id)
> +{
> +	struct apple_magic_backlight *backlight;
> +	int rc;
> +
> +	rc = hid_parse(hdev);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Ensure this usb endpoint is for the keyboard backlight, not touchbar
> +	 * backlight.
> +	 */
> +	if (!(hdev->collection && hdev->collection[0].usage == HID_USAGE_MAGIC_BL))
> +		return -ENODEV;

I don't think hdev->collection can ever be NULL.

Also personally I would prefer this:

!hdev->collection || hdev->collection[0].usage != HID_USAGE_MAGIC_BL

Like it is done with the reports below.

> +
> +	backlight = devm_kzalloc(&hdev->dev, sizeof(*backlight), GFP_KERNEL);
> +	if (!backlight)
> +		return -ENOMEM;
> +
> +	hid_set_drvdata(hdev, backlight);

Is this needed?

> +
> +	rc = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (rc)
> +		return rc;
> +
> +	backlight->brightness = hid_register_report(hdev, HID_FEATURE_REPORT,
> +			APPLE_MAGIC_REPORT_ID_BRIGHTNESS, 0);
> +	backlight->power = hid_register_report(hdev, HID_FEATURE_REPORT,
> +			APPLE_MAGIC_REPORT_ID_POWER, 0);
> +
> +	if (!backlight->brightness || !backlight->power) {
> +		rc = -ENODEV;
> +		goto hw_stop;
> +	}
> +
> +	backlight->hdev = hdev;
> +	backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;

> +	backlight->cdev.max_brightness = backlight->brightness->field[0]->logical_maximum;
> +	backlight->cdev.brightness_set_blocking = apple_magic_backlight_led_set;
> +
> +	apple_magic_backlight_set(backlight, 0, 0);
> +
> +	return devm_led_classdev_register(&hdev->dev, &backlight->cdev);
> +
> +hw_stop:
> +	hid_hw_stop(hdev);
> +	return rc;
> +}
> +
> +static const struct hid_device_id apple_magic_backlight_hid_ids[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, apple_magic_backlight_hid_ids);
> +
> +static struct hid_driver apple_magic_backlight_hid_driver = {
> +	.name = "apple-magic-backlight",
> +	.id_table = apple_magic_backlight_hid_ids,
> +	.probe = apple_magic_backlight_probe,
> +};
> +module_hid_driver(apple_magic_backlight_hid_driver);
> +
> +MODULE_DESCRIPTION("MacBook Magic Keyboard Backlight");
> +MODULE_AUTHOR("Orlando Chamberlain <orlandoch.dev@gmail.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.39.1
> 

Note: Only your cover letter has the "v2" prefix.
Normally git format-patch should apply this properly to all patches when
using --reroll-count.
