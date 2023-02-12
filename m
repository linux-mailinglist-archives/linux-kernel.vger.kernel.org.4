Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D27693709
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBLLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:36:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F7211E;
        Sun, 12 Feb 2023 03:35:59 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="358114206"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="358114206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 03:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="914008350"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="914008350"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 12 Feb 2023 03:35:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@infradead.org>)
        id 1pRAeB-005qQE-16;
        Sun, 12 Feb 2023 13:35:55 +0200
Date:   Sun, 12 Feb 2023 13:35:55 +0200
From:   Andy Shevchenko <andy@infradead.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Message-ID: <Y+jPG4/EkYt1otap@smile.fi.intel.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:43:24AM +0000, Aditya Garg wrote:
> From: Ronald Tschalär <ronald@innovation.ch>
> 
> The iBridge device provides access to several devices, including:
> - the Touch Bar
> - the iSight webcam
> - the light sensor
> - the fingerprint sensor
> 
> This driver provides the core support for managing the iBridge device
> and the access to the underlying devices. In particular, the
> functionality for the touch bar and light sensor is exposed via USB HID
> interfaces, and on devices with the T1 chip one of the HID devices is
> used for both functions. So this driver creates virtual HID devices, one
> per top-level report collection on each HID device (for a total of 3
> virtual HID devices). The sub-drivers then bind to these virtual HID
> devices.
> 
> This way the Touch Bar and ALS drivers can be kept in their own modules,
> while at the same time making them look very much like as if they were
> connected to the real HID devices. And those drivers then work (mostly)
> without further changes on MacBooks with the T2 chip that don't need
> this driver.

...

> [Kerem Karabay: convert to a platform driver]
> [Kerem Karabay: fix appleib_forward_int_op]
> [Kerem Karabay: rely on HID core's parsing in appleib_add_device]

If somebody is going to update this (and update seems required for upstreaming)
the list of changes will grow. I suggest to consider Co-developed-by and move
these lines to cover-letter changelog.

> Signed-off-by: Kerem Karabay <kekrby@gmail.com>

...

> +#include <linux/platform_device.h>
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>

Can we keep it sorted?

> +#include "hid-ids.h"
> +#include "../hid/usbhid/usbhid.h"

+ Blank line?

> +#include "apple-ibridge.h"

...

> +static struct hid_device_id appleib_sub_hid_ids[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LINUX_FOUNDATION,
> +			 USB_DEVICE_ID_IBRIDGE_TB) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LINUX_FOUNDATION,
> +			 USB_DEVICE_ID_IBRIDGE_ALS) },
> +};
> +
> +static struct {
> +	unsigned int usage;
> +	struct hid_device_id *dev_id;
> +} appleib_usage_map[] = {
> +	/* Default iBridge configuration, key inputs and mode settings */
> +	{ 0x00010006, &appleib_sub_hid_ids[0] },
> +	/* OS X iBridge configuration, digitizer inputs */
> +	{ 0x000D0005, &appleib_sub_hid_ids[0] },
> +	/* All iBridge configurations, display/DFR settings */
> +	{ 0xFF120001, &appleib_sub_hid_ids[0] },
> +	/* All iBridge configurations, ALS */
> +	{ 0x00200041, &appleib_sub_hid_ids[1] },
> +};

Shouldn't be other way around, i.e. via driver_data?

...

> +struct appleib_device {
> +	acpi_handle asoc_socw;
> +};

What's the point of having struct out of a single member? Can you use it directly?
(you can try and see if it's not ugly, in some cases struct can be justified)

...

> +	bool			sub_open[ARRAY_SIZE(appleib_sub_hid_ids)];

Why not using bitmap?

	DECLARE_BITMAP(sub_open, ARRAY_SIZE(...));

...

> +static __u8 *appleib_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> +				  unsigned int *rsize)

Why __ types are in use? Is it part of ABI?

...

> +static int appleib_forward_int_op(struct hid_device *hdev,

> +				  int (*forward)(struct hid_driver *,
> +						 struct hid_device *, void *),

This can be on one line

> +				  void *args)

...

> +	if (drv->suspend)
> +		rc = drv->suspend(hdev, *(pm_message_t *)args);

This looks like a hack. What's going on here and why the pm_message_t is in
use? All new PM callbacks do not use it.

...

> +	for (i = 0; i < ARRAY_SIZE(hdev_info->sub_hdevs); i++) {
> +		/*
> +		 * hid_hw_open(), and hence appleib_ll_open(), is called
> +		 * from the driver's probe function, which in turn is called
> +		 * while adding the sub-hdev; but at this point we haven't yet
> +		 * added the sub-hdev to our list. So if we don't find the
> +		 * sub-hdev in our list assume it's in the process of being
> +		 * added and set the flag on the first unset sub-hdev.
> +		 */
> +		if (hdev_info->sub_hdevs[i] == hdev ||
> +		    !hdev_info->sub_hdevs[i]) {

Unusual order of || operator arguments.

This will have a side effect, i.e. if hdev is equal to NULL it will go to the
true branch. Is it by design?

> +			WRITE_ONCE(hdev_info->sub_open[i], open);
> +			return 0;
> +		}
> +	}

...

> +				while (i-- > 0)

while (i--) ?

> +					hid_destroy_device(hdev_info->sub_hdevs[i]);

> +				return (void *)hdev_info->sub_hdevs[i];

This casting is strange. And entire code piece. You will always return 0
element as a pointer here, why 'i'? Needs a lot of explanation.

...

> +static const struct hid_device_id appleib_hid_ids[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IBRIDGE) },

> +	{ },

No comma for the terminator entry.

> +};

...

> +#ifdef CONFIG_PM
> +	.suspend = appleib_hid_suspend,
> +	.resume = appleib_hid_resume,
> +	.reset_resume = appleib_hid_reset_resume,
> +#endif

Why not using

	.driver = {
		.pm = ...;
	},

?

...

> +	ret = hid_register_driver(&appleib_hid_driver);
> +	if (ret) {

> +		dev_err(&pdev->dev, "Error registering hid driver: %d\n",
> +			ret);
> +		return ret;

	return dev_err_probe(...);

> +	}

...

> +static int appleib_suspend(struct platform_device *pdev, pm_message_t message)
> +{
> +	struct appleib_device *ib_dev;
> +	int rc;

> +	ib_dev = platform_get_drvdata(pdev);

Just unite it with the definition above.
Ditto for the similar cases here and there.

> +	rc = acpi_execute_simple_method(ib_dev->asoc_socw, NULL, 0);
> +	if (ACPI_FAILURE(rc))
> +		dev_warn(&pdev->dev, "SOCW(0) failed: %s\n",
> +			 acpi_format_exception(rc));
> +
> +	return 0;
> +}

...

> +static const struct acpi_device_id appleib_acpi_match[] = {
> +	{ "APP7777", 0 },
> +	{ },

No comma for terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko


