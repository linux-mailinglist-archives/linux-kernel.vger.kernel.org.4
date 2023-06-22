Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBFD73A2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFVOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFVOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:18:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738110DB;
        Thu, 22 Jun 2023 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687443483; x=1718979483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R0x1kGgRBAiX0MBDpMw39z+3SDAqRPIhl5FHKL2PhLg=;
  b=Nf+BPwDtUBJMFjMMfijR5rrHKyKoCB3ozJVrUGdXZl9MSq1IggfbGC24
   uY31CO8HRXeYy3eH9NlRazz3rdxYRqeHC4F4X4xfFZEWbsgiQRFPMj4q/
   vGSFqWNy/PwDqiqyjG2E0PqW/o7twG9Il03JQCubVjy5oBR0TYYxUofDr
   2i7gVHYEaJ7fogSHt5edjXlUdQQ9Dh0T28XE/pyP4zNxznQUwQg3+qt81
   BCd1iLCL1VJ0VG4116zSXUh6PJFAhrQbA0E08D9d9bKehCbv7MPYDn5RB
   ywbuZkEpIiNWiXgt5YGF1RdvpeuiKNO8mE1DtXnb+qmQvDCCF57KH4zQf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="426464209"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="426464209"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="784913762"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="784913762"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2023 06:39:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qCKXI-005m6t-0c;
        Thu, 22 Jun 2023 16:39:44 +0300
Date:   Thu, 22 Jun 2023 16:39:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, beanhuo@micron.com,
        nipun.gupta@amd.com, linus.walleij@linaro.org, mwen@igalia.com,
        bvanassche@acm.org, arnd@arndb.de, ogabbay@kernel.org,
        linux@zary.sk, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv4 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Message-ID: <ZJRPH8YFV0ieCxHi@smile.fi.intel.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
 <20230510162243.95820-5-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162243.95820-5-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 06:22:43PM +0200, Martin Zaťovič wrote:
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

> +Date:		May 2023

Taking into account the estimated release date I think this should be changed
to Aug 2023.

...

> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/poll.h>
> +#include <linux/slab.h>
> +#include <linux/wiegand.h>

...

> +#define UP_TO_100_USEC_DEVIATION 1
> +#define MORE_THAN_100_USEC_DEVIATION 3

These require some comments. And maybe better naming (depending on the content
of those comments).

...

> +static ssize_t store_ulong(u32 *val, const char *buf, size_t size, unsigned long max)
> +{
> +	int rc;
> +	u32 new;
> +
> +	rc = kstrtou32(buf, 0, &new);
> +	if (rc)
> +		return rc;
> +
> +	if (new > max)
> +		return -EINVAL;

ERANGE?

> +	*val = new;
> +	return size;
> +}

...

> +	if (sleep_len < 10)
> +		udelay(sleep_len);
> +	else if (sleep_len < 100)
> +		usleep_range(sleep_len - UP_TO_100_USEC_DEVIATION,
> +			     sleep_len + UP_TO_100_USEC_DEVIATION);
> +	else
> +		usleep_range(sleep_len - MORE_THAN_100_USEC_DEVIATION,
> +			     sleep_len + MORE_THAN_100_USEC_DEVIATION);

NIH fsleep()

...

> +static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
> +{
> +	size_t i;
> +	bool bit_value, is_last_bit;
> +
> +	for (i = 0; i < bitlen; i++) {
> +		bit_value = test_bit(i, wiegand_gpio->ctlr->data_bitmap);

> +		is_last_bit = (i + 1) == bitlen;

This is idempotent from for-loop, so...

> +		wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
> +	}

	unsigned int i;
	bool value;

	if (bitlen == 0)
		return 0;

	for (i = 0; i < bitlen - 1; i++) {
		value = test_bit(i, wiegand_gpio->ctlr->data_bitmap);
		wiegand_gpio_send_bit(wiegand_gpio, value, false);
	}

	value = test_bit(bitlen - 1, wiegand_gpio->ctlr->data_bitmap);
	wiegand_gpio_send_bit(wiegand_gpio, value, true);

> +	return 0;
> +}

...

> +static int wiegand_gpio_request(struct device *dev, struct wiegand_gpio *wiegand_gpio)
> +{
> +	wiegand_gpio->data0_gpio = devm_gpiod_get(dev, "data-lo", GPIOD_OUT_HIGH);
> +	if (IS_ERR(wiegand_gpio->data0_gpio))
> +		return PTR_ERR(wiegand_gpio->data0_gpio);
> +
> +	wiegand_gpio->data1_gpio = devm_gpiod_get(dev, "data-hi", GPIOD_OUT_HIGH);
> +	return PTR_ERR_OR_ZERO(wiegand_gpio->data1_gpio);

Maybe you can use devm_gpiod_get_array()?

> +}

...

> +static int wiegand_gpio_probe(struct platform_device *device)
> +{

> +	int status = 0;

Redundant assignment.

> +	struct wiegand_controller *primary;
> +	struct wiegand_gpio *wiegand_gpio;
> +	struct device *dev = &device->dev;

...

> +	primary->payload_len = 26; // set standard 26-bit format

Instead of comment, make a self-explanatory definition?

...

> +	status = wiegand_register_controller(primary);
> +	if (status)
> +		dev_err_probe(wiegand_gpio->dev, status, "failed to register primary\n");

Why out of a sudden it uses this device and not real one?

> +	return status;

With above

		return dev_err_probe(dev, status, "failed to register primary\n");

	return 0;

> +}

...

> +static const struct of_device_id wiegand_gpio_dt_idtable[] = {
> +	{ .compatible = "wiegand-gpio", },

Inner comma is not needed.

> +	{}
> +};

...

> +static struct platform_driver wiegand_gpio_driver = {
> +	.driver = {
> +		.name	= "wiegand-gpio",
> +		.of_match_table = wiegand_gpio_dt_idtable,
> +		.dev_groups = wiegand_gpio_groups

Leave trailing comma when it's not about termination.

> +	},
> +	.probe		= wiegand_gpio_probe

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko


