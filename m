Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C65622A46
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiKILVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiKILUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:20:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673512098E;
        Wed,  9 Nov 2022 03:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667992850; x=1699528850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XKfhN57F5ActHbVyfh0PVl+GnpyqZMZV64TrYNRFF8w=;
  b=YJq1t1dnIij8CP9fISPFsbZIcjopSv0iYwaRxdS2gpHqrRohGfyZSalT
   Oh4UfoLSPOk0s/6K0Saz/Wx1qazhTWMVxLBCH+anQH5FWiqovEjm8ldXG
   NKlG2OP5HwFxrU8u/dTGNKg54I7jh/hyqn+c7Mw2O0d31Px5OeNljmBp4
   AhWLWuIp20PinN6sB2zrmLXZweFzmb632ic0Lg2POPgwNAAEyKPgW86cj
   AAUn0GOTWFgVQnFcngY4p499NxuPScgnF5l3CFH4atRrwAX3pVMrHajoo
   Qu1ofnWzqwrfjftN30u7PhcZg6NL0O8A9if2KkLz5GZ4UcxjJMdzpbgd9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309663830"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="309663830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 03:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="761849526"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="761849526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2022 03:20:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osj8Q-009iPq-2L;
        Wed, 09 Nov 2022 13:20:46 +0200
Date:   Wed, 9 Nov 2022 13:20:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] gpiolib: add support for software nodes
Message-ID: <Y2uNDmRefzPvUu3P@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-6-81f55af5fa0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v2-6-81f55af5fa0e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:26:51PM -0800, Dmitry Torokhov wrote:
> Now that static device properties understand notion of child nodes and
> references, let's teach gpiolib to handle them:
> 
> - GPIOs are represented as a references to software nodes representing
>   gpiochip
> - references must have 2 arguments - GPIO number within the chip and
>   GPIO flags (GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH, etc)
> - a new PROPERTY_ENTRY_GPIO() macro is supplied to ensure the above
> - name of the software node representing gpiochip must match label of
>   the gpiochip, as we use it to locate gpiochip structure at runtime
> 
> The following illustrates use of software nodes to describe a "System"
> button that is currently specified via use of gpio_keys_platform_data
> in arch/mips/alchemy/board-mtx1.c. It follows bindings specified in
> Documentation/devicetree/bindings/input/gpio-keys.yaml.
> 
> static const struct software_node mxt1_gpiochip2_node = {
> 	.name = "alchemy-gpio2",
> };
> 
> static const struct property_entry mtx1_gpio_button_props[] = {
> 	PROPERTY_ENTRY_U32("linux,code", BTN_0),
> 	PROPERTY_ENTRY_STRING("label", "System button"),
> 	PROPERTY_ENTRY_GPIO("gpios", &mxt1_gpiochip2_node, 7, GPIO_ACTIVE_LOW),
> 	{ }
> };
> 
> Similarly, arch/arm/mach-tegra/board-paz00.c can be converted to:
> 
> static const struct software_node tegra_gpiochip_node = {
> 	.name = "tegra-gpio",
> };
> 
> static struct property_entry wifi_rfkill_prop[] __initdata = {
> 	PROPERTY_ENTRY_STRING("name", "wifi_rfkill"),
> 	PROPERTY_ENTRY_STRING("type", "wlan"),
> 	PROPERTY_ENTRY_GPIO("reset-gpios",
> 			    &tegra_gpiochip_node, 25, GPIO_ACTIVE_HIGH);
> 	PROPERTY_ENTRY_GPIO("shutdown-gpios",
> 			    &tegra_gpiochip_node, 85, GPIO_ACTIVE_HIGH);
> 	{ },
> };
> 
> static struct platform_device wifi_rfkill_device = {
> 	.name	= "rfkill_gpio",
> 	.id	= -1,
> };
> 
> ...
> 
> 	software_node_register(&tegra_gpiochip_node);
> 	device_create_managed_software_node(&wifi_rfkill_device.dev,
> 					    wifi_rfkill_prop, NULL);

...

> +static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
> +{
> +	const struct software_node *chip_node;
> +	struct gpio_chip *chip;
> +
> +	chip_node = to_software_node(fwnode);
> +	if (!chip_node || !chip_node->name)
> +		return ERR_PTR(-EINVAL);

> +	chip = gpiochip_find((void *)chip_node->name,
> +			     swnode_gpiochip_match_name);

One line?

> +	if (!chip)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return chip;

As below you can use Elvis here as well, up to you.

	return chip ?: ERR_PTR(...);

> +}

...

> +	desc = gpiochip_get_desc(chip, args.args[0]);
> +	*flags = args.args[1]; /* We expect native GPIO flags */
> +
> +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> +		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));

%pe ?

> +	return desc;

...

> +	while (fwnode_property_get_reference_args(fwnode, propname, NULL,
> +						  0, count, &args) == 0) {

I would move 0 to the previous line.

> +		fwnode_handle_put(args.fwnode);
> +		count++;
> +	}

...

>  int gpiod_count(struct device *dev, const char *con_id)
>  {
> -	const struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
> -	int count = -ENOENT;
> +	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;

Why dropping const?

> +	int count;

Why this change is needed?

>  	if (is_of_node(fwnode))
>  		count = of_gpio_get_count(dev, con_id);
>  	else if (is_acpi_node(fwnode))
>  		count = acpi_gpio_count(dev, con_id);
> +	else if (is_software_node(fwnode))
> +		count = swnode_gpio_count(fwnode, con_id);
> +	else
> +		count = -ENOENT;

...

> +#include <dt-bindings/gpio/gpio.h>

Not sure why we have this here.

> +#include <linux/property.h>
> +
> +#define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
> +	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)

-- 
With Best Regards,
Andy Shevchenko


