Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD46693718
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBLL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLL4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:56:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD78E11169;
        Sun, 12 Feb 2023 03:56:06 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="332848857"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="332848857"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 03:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="914012213"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="914012213"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 12 Feb 2023 03:56:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@infradead.org>)
        id 1pRAxd-005qmt-1H;
        Sun, 12 Feb 2023 13:56:01 +0200
Date:   Sun, 12 Feb 2023 13:56:01 +0200
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
Subject: Re: [PATCH 2/3] HID: apple-touchbar: Add driver for the Touch Bar on
 MacBook Pros
Message-ID: <Y+jT0cDmlutS5CHg@smile.fi.intel.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <868AA58D-2399-4E4A-A6C6-73F88DB13992@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:44:26AM +0000, Aditya Garg wrote:
> From: Ronald Tschalär <ronald@innovation.ch>
> 
> This driver enables basic touch bar functionality: enabling it, switching
> between modes on FN key press, and dimming and turning the display
> off/on when idle/active.

...

> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> [Kerem Karabay: use USB product IDs from hid-ids.h]
> [Kerem Karabay: use hid_hw_raw_request except when setting the touchbar mode on T1 Macs]
> [Kerem Karabay: update Kconfig description]
> Signed-off-by: Kerem Karabay <kekrby@gmail.com>
> [Orlando Chamberlain: add usage check to not bind to keyboard backlight interface]
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> [Aditya Garg: check if apple-touchbar is enabled in the special driver list]
> [Aditya Garg: fix suspend on T2 Macs]

Are you going to use this as a changelog? Not okay for a list of changes.
Consider Co-developed-by and proper Changelog in the cover letter.

> Signed-off-by: Aditya Garg <gargaditya08@live.com>

...

> +config HID_APPLE_TOUCHBAR
> +	tristate "Apple Touch Bar"
> +	depends on USB_HID
> +	help

> +	Say Y here if you want support for the Touch Bar on x86
> +	MacBook Pros.
> +
> +	To compile this driver as a module, choose M here: the
> +	module will be called apple-touchbar.

Wrong indentation for the help description. Missing two spaces.

...

> +#define dev_fmt(fmt) "tb: " fmt

Do we really need this?

...


> +static ssize_t idle_timeout_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf);
> +static ssize_t idle_timeout_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t size);

> +static ssize_t dim_timeout_show(struct device *dev,
> +				struct device_attribute *attr, char *buf);
> +static ssize_t dim_timeout_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t size);

> +static ssize_t fnmode_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf);
> +static ssize_t fnmode_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t size);

Make sure you will have no unnecessary forward declarations.

...

> +static struct attribute *appletb_attrs[] = {
> +	&dev_attr_idle_timeout.attr,
> +	&dev_attr_dim_timeout.attr,
> +	&dev_attr_fnmode.attr,

> +	NULL,

No comma for terminator entry.

> +};

...

> +static struct appletb_device *appletb_dev;

Why is it global?

...

> +static bool appletb_disable_autopm(struct hid_device *hdev)
> +{
> +	int rc;
> +
> +	rc = hid_hw_power(hdev, PM_HINT_FULLON);

> +

Redundant blank line and see below.

> +	if (rc == 0)
> +		return true;
> +
> +	hid_err(hdev,
> +		"Failed to disable auto-pm on touch bar device (%d)\n", rc);
> +	return false;


	if (rc)
		hid_err(...);

	return rc == 0;

> +}

...

> +static bool appletb_any_tb_key_pressed(struct appletb_device *tb_dev)
> +{
> +	return !!memchr_inv(tb_dev->last_tb_keys_pressed, 0,
> +			    sizeof(tb_dev->last_tb_keys_pressed));

Sounds like last_tb_keys_pressed should be declared as a bitmap and hence

	return !bitmap_empty(...);

> +}

...

> +static ssize_t idle_timeout_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct appletb_device *tb_dev = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", tb_dev->idle_timeout);

sysfs_emit().

> +}

...

> +static ssize_t idle_timeout_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t size)
> +{
> +	struct appletb_device *tb_dev = dev_get_drvdata(dev);
> +	long new;
> +	int rc;
> +
> +	rc = kstrtol(buf, 0, &new);
> +	if (rc || new > INT_MAX || new < -2)
> +		return -EINVAL;

Do not shadow the error code.

	if (rc)
		return rc;

Why do you use INT_MAX check with to-long conversion instead of simply calling
kstrtoint()?


> +	appletb_set_idle_timeout(tb_dev, new);
> +	appletb_update_touchbar(tb_dev, true);
> +
> +	return size;
> +}

...

> +static ssize_t dim_timeout_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct appletb_device *tb_dev = dev_get_drvdata(dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +			tb_dev->dim_to_is_calc ? -2 : tb_dev->dim_timeout);

sysfs_emit()

> +}
> +
> +static ssize_t dim_timeout_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t size)
> +{

As per above.

> +}
> +
> +static ssize_t fnmode_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{

As per above.

> +}
> +
> +static ssize_t fnmode_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t size)
> +{

As per above.

> +}

...

> +static int appletb_tb_key_to_slot(unsigned int code)
> +{
> +	switch (code) {
> +	case KEY_ESC:
> +		return 0;
> +	case KEY_F1:
> +	case KEY_F2:
> +	case KEY_F3:
> +	case KEY_F4:
> +	case KEY_F5:
> +	case KEY_F6:
> +	case KEY_F7:
> +	case KEY_F8:
> +	case KEY_F9:
> +	case KEY_F10:
> +		return code - KEY_F1 + 1;
> +	case KEY_F11:
> +	case KEY_F12:
> +		return code - KEY_F11 + 11;
> +	default:
> +		return -1;

Use appropriate error code from errno.h.

> +	}
> +}

...

> +	{ },			/* Terminating zero entry */

No comma.

...

> +static bool appletb_match_internal_device(struct input_handler *handler,
> +					  struct input_dev *inp_dev)
> +{
> +	struct device *dev = &inp_dev->dev;
> +
> +	if (inp_dev->id.bustype == BUS_SPI)
> +		return true;
> +
> +	/* in kernel: dev && !is_usb_device(dev) */
> +	while (dev && !(dev->type && dev->type->name &&
> +			!strcmp(dev->type->name, "usb_device")))
> +		dev = dev->parent;

I believe we have some helpers to mach like this.

> +	/*
> +	 * Apple labels all their internal keyboards and trackpads as such,
> +	 * instead of maintaining an ever expanding list of product-id's we
> +	 * just look at the device's product name.
> +	 */
> +	if (dev)
> +		return !!strstr(to_usb_device(dev)->product, "Internal Keyboard");
> +
> +	return false;
> +}

...

> +static int appletb_probe(struct hid_device *hdev,
> +			 const struct hid_device_id *id)

Can be a single line.

...

> +	rc = hid_parse(hdev);
> +	if (rc) {
> +		dev_err(tb_dev->log_dev, "hid parse failed (%d)\n", rc);
> +		goto error;

return dev_err_probe(...);

(error label seems useless)

> +	}

...

> +	if ((hdev->product == USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT) &&
> +			!(hdev->collection && hdev->collection[0].usage ==
> +				HID_USAGE_APPLE_APP)) {

Broken indentation.

> +		return -ENODEV;
> +	}

...

> +	if (rc) {
> +		dev_err(tb_dev->log_dev, "hw start failed (%d)\n", rc);

dev_err_probe()

It will unite the style of error messaging.

> +		goto clear_iface_info;
> +	}

> +	rc = hid_hw_open(hdev);
> +	if (rc) {
> +		dev_err(tb_dev->log_dev, "hw open failed (%d)\n", rc);

Ditto. And so on.

> +		goto stop_hid;
> +	}

...

> +		/* initialize sysfs attributes */
> +		rc = sysfs_create_group(&tb_dev->mode_iface.hdev->dev.kobj,
> +					&appletb_attr_group);
> +		if (rc) {
> +			dev_err(tb_dev->log_dev,
> +				"Failed to create sysfs attributes (%d)\n", rc);
> +			goto unreg_handler;
> +		}

Can't you use .dev_groups?

> +	}

...

> +	/* MacBook Pro's 2018, 2019, with T2 chip: iBridge Display */
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
> +			USB_DEVICE_ID_APPLE_TOUCHBAR_DISPLAY) },
> +	{ },

No comma.

...

> +

Redundant blank line.

> +MODULE_DEVICE_TABLE(hid, appletb_hid_ids);

...

> +#ifdef CONFIG_PM
> +	.suspend = appletb_suspend,
> +	.reset_resume = appletb_reset_resume,
> +#endif

Why not using .driver.pm ?

...

> +module_init(appletb_init);
> +module_exit(appletb_exit);

Just move them closer to the implementation.

-- 
With Best Regards,
Andy Shevchenko


