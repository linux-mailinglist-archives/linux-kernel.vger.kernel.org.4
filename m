Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BB8606668
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJTQ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJTQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:58:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEFD19ABD6;
        Thu, 20 Oct 2022 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666285125; x=1697821125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EdB/x3pV6bign2i/qIA7C2VUh4NXsdGroF4hTnW+aFY=;
  b=SC+bZr7n95iek8Hd3LKngoIpWIYhr9gglY75XQ35Jv6e2MOAn7nX8e15
   SwBmwxPeMUnAPkRaLIBU4bd7DMjeinmpuaVvzTit7sjwXaOoR0ySHV1sP
   wtAmhlVC3hCiGOr844dYgCsZ/XlOH7HMR0BmWInng4EUPG218Y8WBNOrs
   j35kFwS1rwXz1SLGzlZq0BuOQq2qJ2yCuGiCiUAU8Q8/T7zgTeWcmEPdf
   GZzOMnyd4q86qsufp4jUApcs4z8IqdXM5O9mIJKkaXG0BZv6WpW8Y/OYH
   rvD4s8nhA0rUGerlNcfzt3VGVA8ckz7C1ccY+jPk4+mCSmICFX/MyZ1qg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368819602"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="368819602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="632366233"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="632366233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 20 Oct 2022 09:58:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olYsQ-00AeiQ-26;
        Thu, 20 Oct 2022 19:58:38 +0300
Date:   Thu, 20 Oct 2022 19:58:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     chengwei <foxfly.lai.tw@gmail.com>
Cc:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>,
        Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH 5/5] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <Y1F+PuCma1MX3XzK@smile.fi.intel.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
 <20221019022450.16851-6-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019022450.16851-6-larry.lai@yunjingtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 10:24:50AM +0800, chengwei wrote:
> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control) through an on-board FPGA.

...

> +config PINCTRL_UPBOARD
> +	tristate "UP board FPGA pin controller"
> +	depends on ACPI
> +	depends on MFD_UPBOARD_FPGA
> +	depends on X86

No compile test coverage?
I think you wanted something like

	depends on (X86 && ACPI) || COMPILE_TEST

I'm not even sure, why you have ACPI dependency. I do not see right now it has
a compile one.

> +	select GENERIC_PINCONF
> +	select PINMUX
> +	select PINCONF

...

> +#include <linux/acpi.h>

See above.

> +#include <linux/dmi.h>

> +#include <linux/gpio.h>

No way, no new code should ever use this.

> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/upboard-fpga.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>

...

> +static int upboard_gpio_request_enable(struct pinctrl_dev *pctldev,
> +				       struct pinctrl_gpio_range *range,
> +				       unsigned int pin)
> +{
> +	const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
> +	const struct upboard_pin *p;
> +	int ret;

> +	if (!pd)
> +		return -EINVAL;

Why do you need this check?
Ditto for all the same checks over the code.

> +	p = pd->drv_data;
> +
> +	if (p->funcbit) {
> +		ret = regmap_field_write(p->funcbit, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (p->enbit) {
> +		ret = regmap_field_write(p->enbit, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +};

...

> +
> +

One blank line is enough. Please, check all your code for this.

...

> +static int upboard_rpi_to_native_gpio(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct upboard_pinctrl *pctrl =
> +		container_of(gc, struct upboard_pinctrl, chip);
> +	unsigned int pin = pctrl->rpi_mapping[gpio];

> +	struct pinctrl_gpio_range *range =
> +		pinctrl_find_gpio_range_from_pin(pctrl->pctldev, pin);

Instead, split the assignment and the definition. Same amount of LoCs, but
reads and maintained better.

> +	if (!range)
> +		return -ENODEV;
> +
> +	return range->base;
> +}

...

> +static int upboard_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +	int gpio = upboard_rpi_to_native_gpio(gc, offset);
> +
> +	if (gpio < 0)
> +		return gpio;
> +
> +	return gpio_request(gpio, module_name(THIS_MODULE));

Nope, new code mustn't use this APIs.

> +}

...

> +	gpio_free(gpio);

Ditto.

> +	return gpio_get_value(gpio);

Ditto.

> +	gpio_set_value(gpio, value);

Ditto.

> +	return gpio_direction_input(gpio);

Ditto.

> +	return gpio_direction_output(gpio, value);

Ditto.

...

> +	{
> +		.matches = { /* UP2 */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
> +			DMI_EXACT_MATCH(DMI_BOARD_VERSION, "V0.3"),
> +		},
> +		.driver_data = (void *)&upboard_up2_bios_info_v0_3,
> +	},
> +	{ },

No comma for the terminator entry.

...

> +	hid = acpi_device_hid(adev);
> +	if (!strcmp(hid, "AANT0F00") || !strcmp(hid, "AANT0F04")) {
> +		pctldesc = &upboard_up_pinctrl_desc;
> +		rpi_mapping = upboard_up_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_up_rpi_mapping);
> +	} else if (!strcmp(hid, "AANT0F01")) {
> +		pctldesc = &upboard_up2_pinctrl_desc;
> +		rpi_mapping = upboard_up2_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_up2_rpi_mapping);
> +	} else if (!strcmp(hid, "AANT0F02")) {
> +		pctldesc = &upboard_upcore_crex_pinctrl_desc;
> +		rpi_mapping = upboard_upcore_crex_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_upcore_crex_rpi_mapping);
> +		bios_info = &upboard_upcore_crex_bios_info;
> +	} else if (!strcmp(hid, "AANT0F03")) {
> +		pctldesc = &upboard_upcore_crst02_pinctrl_desc;
> +		rpi_mapping = upboard_upcore_crst02_rpi_mapping;
> +		ngpio  = ARRAY_SIZE(upboard_upcore_crst02_rpi_mapping);
> +		bios_info = &upboard_upcore_crst02_bios_info;
> +	} else
> +		return -ENODEV;

NIH device_get_match_data().

...

> +	ret = acpi_node_add_pin_mapping(acpi_fwnode_handle(adev),
> +					"external-gpios",
> +					dev_name(&pdev->dev),
> +					0, UINT_MAX);
> +	if (ret)
> +		return ret;

This is something strange. Can you point out to the DSDT, etc.?


...

> +

Blank line is not needed.

> +module_platform_driver_probe(upboard_pinctrl_driver, upboard_pinctrl_probe);

-- 
With Best Regards,
Andy Shevchenko


