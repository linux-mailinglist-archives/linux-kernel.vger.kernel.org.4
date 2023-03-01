Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A86A716D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCAQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjCAQn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:43:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA711ADCF;
        Wed,  1 Mar 2023 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677689034; x=1709225034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7lwWUU/sBD55Yf0l73aWsm94KQlTlscyZPnSOjeJeXw=;
  b=KYAYRRQaJcdZC6jtPjJwhkkT/J/OVvdpBbjDqg2umXGk7nLKD1JNn99m
   FVrZ1g0RrO4cafnhBQuVNTVOt8aDQTYV2v67jrIZLCO/chxCHlE6tbj6c
   FEoNlg8vD/e00UrfeXfzAjB6yolaY5kqabreTUghl5cjIKzgflUPggMqy
   I2umaSOuglpqZLriCPe8/PsaGfPUVuaJeGMJToLIggYmqH8QHi7p4WuVX
   dMVqjMsnU+8risvZYTy7AguetOBwofoiucFOM9MgL0TEa+diT0RPursk4
   y6NPSynTraHHqbnzNgNgVzvx14eABaP9LQES+OchligJXsH046Z2OJorZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420719656"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420719656"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 08:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003732247"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003732247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 08:43:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pXPXt-00Dpv5-02;
        Wed, 01 Mar 2023 18:43:13 +0200
Date:   Wed, 1 Mar 2023 18:43:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com,
        linus.walleij@linaro.org
Subject: Re: [PATCHv3 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Message-ID: <Y/+AoJiGL8PwJZJC@smile.fi.intel.com>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301142835.19614-5-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:28:35PM +0100, Martin Zaťovič wrote:
> This controller formats the data to a Wiegand format and bit-bangs
> the message on devicetree defined GPIO lines.
> 
> Several attributes need to be defined in the devicetree in order
> for this driver to work, namely the data-hi-gpios, data-lo-gpios,
> pulse-len, frame-gap and interval-len. These attributes are
> documented in the devicetree bindings documentation files.
> 
> The driver creates a dev file for writing messages on the bus.
> It also creates a sysfs file to control the payload length of
> messages(in bits). If a message is shorter than the set payload
> length, it will be discarded. On the other hand, if a message is
> longer, the additional bits will be stripped off.

...

> +Date:		January 2023

Blast from the past?

...

> +config WIEGAND_GPIO
> +	tristate "GPIO-based wiegand master (write only)"
> +	depends on WIEGAND
> +	help
> +	  This GPIO bitbanging Wiegand controller uses the libgpiod library to
> +	  utilize GPIO lines for sending Wiegand data. Userspace may access
> +	  the Wiegand GPIO interface via a dev entry.

What will be the name of the module if M?

...

> +#include <linux/of.h>

No way.

...

> +struct wiegand_gpio {
> +	struct device *dev;
> +	struct wiegand_controller *ctlr;

> +	struct miscdevice misc_dev;

Make it first, same idea as per previous patch comments.

> +	struct mutex mutex;
> +	struct gpio_desc *gpio_data_hi;
> +	struct gpio_desc *gpio_data_lo;
> +	struct file_operations fops;

> +	u8 data[WIEGAND_MAX_PAYLEN_BYTES];

Have you considered DMA alignment? Is it a problem or not here?

> +};

...

> +static ssize_t store_ulong(u32 *val, const char *buf, size_t size, unsigned long max)
> +{
> +	int rc;
> +	u32 new;

> +	if (max != 0 && new > max)

First part of the conditional is redundant. When you have such a user, you may
add the restriction back.

> +		return -EINVAL;
> +
> +	*val = new;
> +	return size;
> +}

...

> +static struct attribute *wiegand_gpio_attrs[] = {
> +	&dev_attr_payload_len.attr,
> +	NULL,

No comma for the terminator entry.

> +};
> +

Redundant blank line.

> +ATTRIBUTE_GROUPS(wiegand_gpio);

...

> +void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
> +{
> +	u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
> +	u32 interval_len = wiegand_gpio->ctlr->interval_len;
> +	u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
> +	struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi : wiegand_gpio->gpio_data_lo;
> +
> +	gpiod_set_value_cansleep(gpio, 0);
> +	udelay(pulse_len);
> +	gpiod_set_value_cansleep(gpio, 1);
> +
> +	if (last)
> +		udelay(frame_gap - pulse_len);
> +	else
> +		udelay(interval_len - pulse_len);

This is quite dangerous. You may end up with CPU 100% load for a long time
without any way out. What is the range and why udelay() can't be replaced
with usleep_range() for longer waits?

> +}

...

> +/* This function is used for writing from file in dev directory */
> +static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
> +{
> +	size_t i;
> +	bool bit_value, is_last_bit;
> +
> +	for (i = 0; i < bitlen; i++) {
> +		bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8))) & 0x01);

Ah, your buffer should probably be a bitmap.
Also consider bitmap_get_value8().

> +		is_last_bit = (i + 1) == bitlen;
> +		wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t wiegand_gpio_get_user_data(struct wiegand_gpio *wiegand_gpio, char __user const *buf,
> +					  size_t len)
> +{
> +	size_t rc;
> +
> +	if (len > WIEGAND_MAX_PAYLEN_BYTES)
> +		return -EBADMSG;

> +	rc = copy_from_user(&wiegand_gpio->data[0], buf, WIEGAND_MAX_PAYLEN_BYTES);
> +	if (rc < 0)
> +		return rc;

This is wrong. Homework: read the documentation and existing code to see why
and how to fix.

> +	return len;
> +}

...

> +static ssize_t wiegand_gpio_fwrite(struct file *filp, char __user const *buf, size_t len,
> +				loff_t *offset)
> +{
> +	struct wiegand_gpio_instance *info = filp->private_data;
> +	struct wiegand_gpio *wiegand_gpio = info->dev;
> +	u32 msg_length = wiegand_gpio->ctlr->payload_len;
> +	int rc;
> +
> +	if (buf == NULL || len == 0 || len * 8 < msg_length)

	!buf

	DIV_ROUND_UP(msg_length / 8) > len

less overflow prone.

> +		return -EINVAL;
> +
> +	rc = wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
> +	if (rc < 0)
> +		return rc;
> +
> +	wiegand_gpio_write_by_bits(wiegand_gpio, msg_length);
> +
> +	return len;
> +}

> +static int wiegand_gpio_fopen(struct inode *ino, struct file *filp)
> +{
> +	int rc;
> +	struct wiegand_gpio_instance *info;
> +	struct wiegand_gpio *wiegand_gpio = container_of(filp->f_op, struct wiegand_gpio, fops);
> +
> +	mutex_lock(&wiegand_gpio->mutex);

Can it be interrupted by a signal?

> +	if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
> +		dev_err(wiegand_gpio->dev, "Device is write only\n");
> +		rc = -EIO;
> +		goto err;
> +	}
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	info->dev = wiegand_gpio;
> +	info->flags = filp->f_flags;
> +	mutex_unlock(&wiegand_gpio->mutex);
> +
> +	filp->private_data = info;
> +
> +	return 0;
> +err:
> +	mutex_unlock(&wiegand_gpio->mutex);
> +	return rc;
> +}

...

> +	u8 msg_bytelength = (msg_bitlen % 8) ? (msg_bitlen / 8) + 1 : (msg_bitlen / 8);

DIV_ROUND_UP() (you will need math.h)

...

> +	if (dev->of_node)
> +		master->dev.of_node = device->dev.of_node;

No.

...

> +	if (status)
> +		return status;

What's this and why is it here?
I'm afraid you haven't compiled this code... :-(

...

> +	master->transfer_message = &wiegand_gpio_transfer_message;
> +	master->payload_len = 26; /* set standard 26-bit format */

Can you replace master with some of the suggested words?
Or is this a terminology from the specification of the bus?

...

> +	status = wiegand_gpio_request(dev, wiegand_gpio);
> +	if (status) {
> +		dev_err(wiegand_gpio->dev, "failed at requesting GPIOs\n");
> +		return status;

		return dev_error_probe();

Ditto for the rest.

> +	}

...

> +	status = gpiod_direction_output(wiegand_gpio->gpio_data_hi, 1);
> +	status |= gpiod_direction_output(wiegand_gpio->gpio_data_lo, 1);

Huh?!

...

> +	wiegand_gpio->misc_dev.name = kasprintf(GFP_KERNEL, "wiegand-gpio%u", master->bus_num);

No checks?

...

> +	dev->groups = wiegand_gpio_groups;

Feels like this can be moved to dev_groups member of the struct driver.

> +
> +	return status;
> +}

...

> +static const struct of_device_id wiegand_gpio_dt_idtable[] = {
> +	{ .compatible = "wiegand-gpio", },

> +	{},

No comma for the terminator entry.

> +};

...

> +

Redundant blank line.

> +module_platform_driver(wiegand_gpio_driver);

-- 
With Best Regards,
Andy Shevchenko


