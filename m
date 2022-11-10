Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F264624410
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiKJOP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiKJOPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:15:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093CEE0F;
        Thu, 10 Nov 2022 06:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668089722; x=1699625722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+xbe+hkNv3LoA42HGd827mtzBfQMJ4k3qq3B+bWxEA=;
  b=i5V39JCaR1o0M3SXJ8QzdbMY2VvISNGhUyC6+u7qVGlzuTj3mVYw6aXK
   zaae8a57p3iWY+VX+gi9lusTD0O7NkRg+v/rz+j9I1rovB7wFubcG9Xfg
   SeoOmdjK99W1dfyO/kv3nKZq+cD+Phqw51I8fh75ibIdgWb9qdPldl+4I
   KXApn4E594uYC8RldHmKMvcByUWcrLJaTzbkbInqiVh+h9dFLtQq8wu4P
   YmNPYz+SP35L1t8MlmYNtV/aT8Hisr6xMIqIpvzBeN2mJyNGXk/quaFB+
   fbRZcA/pO1xpSm0HeN5e5A8k+QAlabCf/wGBJX9Vm5v1Ny6I5XKqYlk5x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="338072658"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="338072658"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 06:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639627330"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="639627330"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2022 06:15:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ot8Kr-00ABDo-0T;
        Thu, 10 Nov 2022 16:15:17 +0200
Date:   Thu, 10 Nov 2022 16:15:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 6/6] gpiolib: add support for software nodes
Message-ID: <Y20HdED/D4gYZ7Bl@smile.fi.intel.com>
References: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
 <20221031-gpiolib-swnode-v3-6-0282162b0fa4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031-gpiolib-swnode-v3-6-0282162b0fa4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:30:44AM -0800, Dmitry Torokhov wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpiolib-swnode.c | 123 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpiolib-swnode.h |  14 +++++
>  drivers/gpio/gpiolib.c        |   7 +++
>  include/linux/gpio/property.h |  11 ++++
>  5 files changed, 156 insertions(+)
> 
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 8629e9eaf79e..010587025fc8 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
>  obj-$(CONFIG_GPIO_CDEV)		+= gpiolib-cdev.o
>  obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
>  obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
> +obj-$(CONFIG_GPIOLIB)		+= gpiolib-swnode.o
>  
>  # Device drivers. Generally keep list sorted alphabetically
>  obj-$(CONFIG_GPIO_REGMAP)	+= gpio-regmap.o
> diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
> new file mode 100644
> index 000000000000..dd9ccac214d1
> --- /dev/null
> +++ b/drivers/gpio/gpiolib-swnode.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Software Node helpers for the GPIO API
> + *
> + * Copyright 2022 Google LLC
> + */
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/property.h>
> +#include <linux/string.h>
> +
> +#include "gpiolib.h"
> +#include "gpiolib-swnode.h"
> +
> +static void swnode_format_propname(const char *con_id, char *propname,
> +				   size_t max_size)
> +{
> +	/*
> +	 * Note we do not need to try both -gpios and -gpio suffixes,
> +	 * as, unlike OF and ACPI, we can fix software nodes to conform
> +	 * to the proper binding.
> +	 */
> +	if (con_id)
> +		snprintf(propname, max_size, "%s-gpios", con_id);
> +	else
> +		strscpy(propname, "gpios", max_size);
> +}
> +
> +static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
> +{
> +	return !strcmp(chip->label, data);
> +}
> +
> +static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
> +{
> +	const struct software_node *chip_node;
> +	struct gpio_chip *chip;
> +
> +	chip_node = to_software_node(fwnode);
> +	if (!chip_node || !chip_node->name)
> +		return ERR_PTR(-EINVAL);
> +
> +	chip = gpiochip_find((void *)chip_node->name, swnode_gpiochip_match_name);
> +	return chip ?: ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
> +				   const char *con_id, unsigned int idx,
> +				   unsigned long *flags)
> +{
> +	const struct software_node *swnode;
> +	struct fwnode_reference_args args;
> +	struct gpio_chip *chip;
> +	struct gpio_desc *desc;
> +	char propname[32]; /* 32 is max size of property name */
> +	int error;
> +
> +	swnode = to_software_node(fwnode);
> +	if (!swnode)
> +		return ERR_PTR(-EINVAL);
> +
> +	swnode_format_propname(con_id, propname, sizeof(propname));
> +
> +	/*
> +	 * We expect all swnode-described GPIOs have GPIO number and
> +	 * polarity arguments, hence nargs is set to 2.
> +	 */
> +	error = fwnode_property_get_reference_args(fwnode, propname, NULL, 2, idx, &args);
> +	if (error) {
> +		pr_debug("%s: can't parse '%s' property of node '%pfwP[%d]'\n",
> +			__func__, propname, fwnode, idx);
> +		return ERR_PTR(error);
> +	}
> +
> +	chip = swnode_get_chip(args.fwnode);
> +	fwnode_handle_put(args.fwnode);
> +	if (IS_ERR(chip))
> +		return ERR_CAST(chip);
> +
> +	desc = gpiochip_get_desc(chip, args.args[0]);
> +	*flags = args.args[1]; /* We expect native GPIO flags */
> +
> +	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
> +		 __func__, propname, fwnode, idx, PTR_ERR_OR_ZERO(desc));
> +
> +	return desc;
> +}
> +
> +/**
> + * swnode_gpio_count - count the GPIOs associated with a device / function
> + * @fwnode:	firmware node of the GPIO consumer, can be %NULL for
> + *		system-global GPIOs
> + * @con_id:	function within the GPIO consumer
> + *
> + * Return:
> + * The number of GPIOs associated with a device / function or %-ENOENT,
> + * if no GPIO has been assigned to the requested function.
> + */
> +int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id)
> +{
> +	struct fwnode_reference_args args;
> +	char propname[32];
> +	int count;
> +
> +	swnode_format_propname(con_id, propname, sizeof(propname));
> +
> +	/*
> +	 * This is not very efficient, but GPIO lists usually have only
> +	 * 1 or 2 entries.
> +	 */
> +	count = 0;
> +	while (fwnode_property_get_reference_args(fwnode, propname, NULL, 0,
> +						  count, &args) == 0) {
> +		fwnode_handle_put(args.fwnode);
> +		count++;
> +	}
> +
> +	return count ?: -ENOENT;
> +}
> diff --git a/drivers/gpio/gpiolib-swnode.h b/drivers/gpio/gpiolib-swnode.h
> new file mode 100644
> index 000000000000..af849e56f6bc
> --- /dev/null
> +++ b/drivers/gpio/gpiolib-swnode.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef GPIOLIB_SWNODE_H
> +#define GPIOLIB_SWNODE_H
> +
> +struct fwnode_handle;
> +struct gpio_desc;
> +
> +struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
> +				   const char *con_id, unsigned int idx,
> +				   unsigned long *flags);
> +int swnode_gpio_count(const struct fwnode_handle *fwnode, const char *con_id);
> +
> +#endif /* GPIOLIB_SWNODE_H */
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b1a57fdd96b6..2f4150bf411a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -26,6 +26,7 @@
>  #include "gpiolib.h"
>  #include "gpiolib-of.h"
>  #include "gpiolib-acpi.h"
> +#include "gpiolib-swnode.h"
>  #include "gpiolib-cdev.h"
>  #include "gpiolib-sysfs.h"
>  
> @@ -3818,6 +3819,10 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
>  		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
>  			fwnode, con_id);
>  		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
> +	} else if (is_software_node(fwnode)) {
> +		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n",
> +			fwnode, con_id);
> +		desc = swnode_find_gpio(fwnode, con_id, idx, lookupflags);
>  	}
>  
>  	return desc;
> @@ -3935,6 +3940,8 @@ int gpiod_count(struct device *dev, const char *con_id)
>  		count = of_gpio_get_count(dev, con_id);
>  	else if (is_acpi_node(fwnode))
>  		count = acpi_gpio_count(dev, con_id);
> +	else if (is_software_node(fwnode))
> +		count = swnode_gpio_count(fwnode, con_id);
>  
>  	if (count < 0)
>  		count = platform_gpio_count(dev, con_id);
> diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
> new file mode 100644
> index 000000000000..6c75c8bd44a0
> --- /dev/null
> +++ b/include/linux/gpio/property.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#ifndef __LINUX_GPIO_PROPERTY_H
> +#define __LINUX_GPIO_PROPERTY_H
> +
> +#include <dt-bindings/gpio/gpio.h> /* for GPIO_* flags */
> +#include <linux/property.h>
> +
> +#define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
> +	PROPERTY_ENTRY_REF(_name_, _chip_node_, _idx_, _flags_)
> +
> +#endif /* __LINUX_GPIO_PROPERTY_H */
> 
> -- 
> b4 0.11.0-dev-28747

-- 
With Best Regards,
Andy Shevchenko


