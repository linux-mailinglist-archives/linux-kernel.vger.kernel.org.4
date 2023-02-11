Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA20A693087
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBKLvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:51:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ACB12059;
        Sat, 11 Feb 2023 03:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676116295; x=1707652295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l85uAjCpOoq+tYp3j9Q/TW1Ruotvzt3rvsIYcwVY2rI=;
  b=iiAkPiSj2wf/UBm/os8bqlJvlR5es1+0B3XpmqaGb12XPJOBeC7w6iiq
   iJv65qFdhLhJNyPQDauWELAER7vfM21B5iW/7U33/vb3n5qQIB5Nev7+n
   pX6Q+HqR45QwQQai5G6iccurU4A1iHIbRtksj/x1/fsANe/CCPe6Df8Ia
   FdaPIBLYp5oVMRYRxUyFQSlFjTfTnwF2RDxG+E+q0ZT4SqkeCbndCQIhL
   CeEewPwUQ0GI9UTEruqpq9pHsAZNIcuN6NQARARK8P+uArGD1bM0x5LXi
   7cMYXbOKxcPbwGEynPPuHQFOSRUdwvxBmEk9ws4Y3KyfEj8fHhJ5IGUPd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="358007966"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="358007966"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 03:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="842285157"
X-IronPort-AV: E=Sophos;i="5.97,289,1669104000"; 
   d="scan'208";a="842285157"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 11 Feb 2023 03:51:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1pQoPk-005TEW-1b;
        Sat, 11 Feb 2023 13:51:32 +0200
Date:   Sat, 11 Feb 2023 13:51:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Message-ID: <Y+eBRLB0Q38vGtjR@smile.fi.intel.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 10:39:40AM -0500, Asmaa Mnebhi wrote:
> This patch adds support for the BlueField-3 SoC GPIO driver

The Submitting Patches states that imperative speech should be used.

> which allows:
> - setting certain GPIOs as interrupts from other dependent drivers
> - ability to manipulate certain GPIO pins via libgpiod tools
> 
> BlueField-3 has 56 GPIOs but the user is only allowed to change some
> of them into GPIO mode. Use valid_mask to make it impossible to alter
> the rest of the GPIOs.

...

> +	help
> +	  Say Y here if you want GPIO support on Mellanox BlueField 3 SoC.

Have you run checkpatch? Nowadays 3+ lines of help is recommended.
I would suggest to add a standard phrase about module name in case
the module build is chosen.

...

> +// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause

> +

Redundant blank line

> +/*
> + * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES
> + */

This can be on one line.

...

> +#include <linux/acpi.h>

No user of this header.

> +#include <linux/gpio/driver.h>
> +#include <linux/platform_device.h>

Approx dozen of header inclusions are missing.
(bits.h, types.h, spinlock.h, ...)

...

> +struct mlxbf3_gpio_context {
> +	struct gpio_chip gc;

> +	struct irq_chip irq_chip;

Have you run it on v6.1+ kernels? This should not be here, i.e. it must be
static and const.

> +	/* YU GPIO block address */
> +	void __iomem *gpio_io;
> +
> +	/* YU GPIO cause block address */
> +	void __iomem *gpio_cause_io;
> +
> +	/* Mask of valid gpios that can be accessed by software */
> +	unsigned int valid_mask;
> +};

...

> +		generic_handle_irq(irq_find_mapping(gc->irq.domain, level));

There is a helper that unites these two calls together.

...

> +	bool fall = false;
> +	bool rise = false;

Instead, just assign each of the in the corresponding switch-case.

> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_EDGE_BOTH:
> +		fall = true;
> +		rise = true;
> +		break;
> +	case IRQ_TYPE_EDGE_RISING:
> +		rise = true;
> +		break;
> +	case IRQ_TYPE_EDGE_FALLING:
> +		fall = true;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

...

> +	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +	if (fall) {
> +		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +		val |= BIT(offset);
> +		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
> +	}
> +
> +	if (rise) {
> +		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +		val |= BIT(offset);
> +		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
> +	}
> +	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);

Don't you need to choose and lock the IRQ handler here?

> +}

...

> +static int mlxbf3_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
> +
> +	*valid_mask = gs->valid_mask;
> +
> +	return 0;
> +}

Why do you need this?


> +	struct resource *res;

Useless variable, see below.

...

> +	const char *name;


> +	name = dev_name(dev);

Useless, just call dev_name() where it's needed.

...

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	/* Resource shared with pinctrl driver */
> +	gs->gpio_io = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!gs->gpio_io)
> +		return -ENOMEM;
> +
> +	/* YU GPIO block address */
> +	gs->gpio_cause_io = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(gs->gpio_cause_io))
> +		return PTR_ERR(gs->gpio_cause_io);

These can be folded in a single devm_platform_ioremap_resource() call.

...


> +	if (device_property_read_u32(dev, "npins", &npins))
> +		npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;

You can get of conditional.

	npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
	device_property_read_u32(dev, "npins", &npins);

...

> +	if (device_property_read_u32(dev, "valid_mask", &valid_mask))
> +		valid_mask = 0x0;

Besides that you can move this directly to the respective call and drop
redundant private copy of valid mask, you mean that without that property
no valid GPIOs?

> +	gs->valid_mask = valid_mask;

...

> +		girq->handler = handle_simple_irq;

Should be handle_bad_irq() to avoid some subtle issues that hard to debug.

...

> +		ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
> +				       IRQF_SHARED, name, gs);
> +		if (ret) {

> +			dev_err(dev, "failed to request IRQ");
> +			return ret;

return dev_err_probe(...);

> +		}
> +	}

...

> +	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
> +	if (ret) {
> +		dev_err(dev, "Failed adding memory mapped gpiochip\n");
> +		return ret;

Ditto.

> +	}

...

> +static const struct acpi_device_id __maybe_unused mlxbf3_gpio_acpi_match[] = {
> +	{ "MLNXBF33", 0 },

> +	{},

No comma for termination entry.

> +};

...

> +	.probe    = mlxbf3_gpio_probe,
> +};

> +

Redundant blank line.

> +module_platform_driver(mlxbf3_gpio_driver);

-- 
With Best Regards,
Andy Shevchenko


