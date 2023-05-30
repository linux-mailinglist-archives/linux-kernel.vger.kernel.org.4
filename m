Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0249A715CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjE3LIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjE3LH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:07:58 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC0B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:07:52 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 36308c3d-feda-11ed-b3cf-005056bd6ce9;
        Tue, 30 May 2023 14:07:49 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 14:07:48 +0300
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        khilman@baylibre.com, msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH v4 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <ZHXZBCwk6tTu8gjY@surfacebook>
References: <20230511-tps65219-add-gpio-support-v4-0-b5d6a764d722@baylibre.com>
 <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511-tps65219-add-gpio-support-v4-1-b5d6a764d722@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 09:59:59AM +0200, Jerome Neanne kirjoitti:

First of all, I have a bit of déjà vu that I have given already some comments
that left neither answered nor addressed.

> Add support for TPS65219 PMICs GPIO interface.
> 
> 3 GPIO pins:
> - GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
> - GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec
> 
> GPIO0 is statically configured as input or output prior to Linux boot.
> it is used for MULTI_DEVICE_ENABLE function.
> This setting is statically configured by NVM.
> GPIO0 can't be used as a generic GPIO (specification Table 8-34).
> It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.
> 
> Datasheet describes specific usage for non standard GPIO.
> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf

Can you convert this to be a Datasheet tag? Currently even Link is *not* a tag
because there must be no blank lines in the tag block.

> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

...

> +	help
> +	  Select this option to enable GPIO driver for the TPS65219 chip family.
> +	  GPIO0 is statically configured as input or output prior to Linux boot.
> +	  It is used for MULTI_DEVICE_ENABLE function.
> +	  This setting is statically configured by NVM.
> +	  GPIO0 can't be used as a generic GPIO.
> +	  It's either a GPO when MULTI_DEVICE_EN=0 or a GPI when MULTI_DEVICE_EN=1.
> +
> +	  This driver can also be built as a module.
> +	  If so, the module will be called gpio_tps65219.

Random indentation. Can you use as much room as available on each line, please?

> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPIO driver for TI TPS65219 PMICs
> + *
> + * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/tps65219.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

...

> +static int tps65219_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
> +	struct device *dev = gpio->tps->dev;
> +	int ret, val;
> +
> +	if (offset != TPS65219_GPIO0_IDX) {
> +		dev_err(dev, "GPIO%d is output only, cannot get\n", offset);

> +		return -EOPNOTSUPP;

This seems blind following the checkpatch false warning. The checkpatch does
not know about subsystem details, i.e. GPIOLIB uses ENOTSUPP in the callbacks.
The userspace won't see that as GPIOLIB takes care of translating it when
needed.

> +	}
> +
> +	ret = regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_CTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	ret = !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));
> +	dev_warn(dev, "GPIO%d = %d, MULTI_DEVICE_ENABLE, not a standard GPIO\n", offset, ret);
> +
> +	/* depends on NVM config return error if dir output else the GPIO0 status bit */

	/*
	 * Depending on NVM config, return an error if direction is output,
	 * otherwise the GPIO0 status bit.
	 */

> +	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
> +		return -EOPNOTSUPP;

Fix the error code.

> +	return ret;
> +}

...

> +static int tps65219_gpio_change_direction(struct gpio_chip *gc, unsigned int offset,
> +					  unsigned int direction)
> +{
> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
> +	struct device *dev = gpio->tps->dev;
> +
> +	/*
> +	 * Documentation is stating that GPIO0 direction must not be changed in Linux:
> +	 * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
> +	 * Should only be changed in INITIALIZE state (prior to ON Request).
> +	 * Set statically by NVM, changing direction in application can cause a hang.
> +	 * Below can be used for test purpose only:
> +	 */
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_GPIO)) {
> +		int ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
> +					     TPS65219_GPIO0_DIR_MASK, direction);
> +		if (ret) {
> +			dev_err(dev,
> +				"GPIO DEBUG enabled: Fail to change direction to %u for GPIO%d.\n",
> +				direction, offset);
> +			return ret;
> +		}
> +	}
> +
> +	dev_err(dev,
> +		"GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
> +		 offset, direction);
> +
> +	return -EOPNOTSUPP;

Ditto.

> +}

...

> +static int tps65219_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
> +	struct device *dev = gpio->tps->dev;
> +
> +	if (offset != TPS65219_GPIO0_IDX) {
> +		dev_err(dev, "GPIO%d is output only, cannot change to input\n", offset);
> +		return -EOPNOTSUPP;

Ditto.

> +	}
> +
> +	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_IN)
> +		return 0;
> +
> +	return tps65219_gpio_change_direction(gc, offset, TPS65219_GPIO_DIR_IN);
> +}

-- 
With Best Regards,
Andy Shevchenko


