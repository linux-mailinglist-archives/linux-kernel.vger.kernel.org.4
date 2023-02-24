Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3E6A1BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBXMQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBXMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:16:13 -0500
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DF671D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:16:11 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 03bd5844-b43d-11ed-ba48-005056bdf889;
        Fri, 24 Feb 2023 14:16:07 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Fri, 24 Feb 2023 14:16:06 +0200
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, tony@atomide.com,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <Y/iqhsEIvHgnZ+5l@surfacebook>
References: <20230224113837.874264-1-jneanne@baylibre.com>
 <20230224113837.874264-2-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224113837.874264-2-jneanne@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 24, 2023 at 12:38:36PM +0100, Jerome Neanne kirjoitti:
> Add support for TPS65219 PMICs GPIO interface.
> 
> 3 GPIO pins:
> - GPIO0 only is IO but input mode reserved for MULTI_DEVICE_ENABLE usage
> - GPIO1 and GPIO2 are Output only and referred as GPO1 and GPO2 in spec
> 
> GPIO0 is statically configured as input or output prior to linux boot.

Linux

> it is used for MULTI_DEVICE_ENABLE function.
> This setting is statically configured by NVM.
> GPIO0 can't be used as a generic GPIO (specification Table 8-34).
> It's either a GPO when MULTI_DEVICE_EN=0
> or a GPI when MULTI_DEVICE_EN=1.

Something wrong with the indentation.

> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf

Can it be Datasheet tag?

> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

Not sure how to interpet this along with the From line.

...

> +config GPIO_TPS65219
> +	tristate "TPS65219 GPIO"
> +	depends on MFD_TPS65219
> +	help
> +	  Select this option to enable GPIO driver for the TPS65219
> +	  chip family.
> +	  GPIO0 is statically configured as input or output prior to linux boot.
> +	  it is used for MULTI_DEVICE_ENABLE function.
> +	  This setting is statically configured by NVM.
> +	  GPIO0 can't be used as a generic GPIO.
> +	  It's either a GPO when MULTI_DEVICE_EN=0
> +	  or a GPI when MULTI_DEVICE_EN=1.

Similar issues as with commit message. Also if chosen as M, how will it be
called?

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/tps65219.h>
> +
> +#define TPS65219_GPIO0_DIR_MASK		BIT(3)
> +#define TPS65219_GPIO0_OFFSET		2
> +#define TPS65219_GPIO0_IDX		0
> +#define TPS65219_GPIO_DIR_IN		1
> +#define TPS65219_GPIO_DIR_OUT		0
> +
> +struct tps65219_gpio {
> +	struct gpio_chip gpio_chip;
> +	struct tps65219 *tps;
> +};

...

> +static void tps65219_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +			      int value)
> +{
> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
> +
> +	if (offset != TPS65219_GPIO0_IDX)
> +		regmap_update_bits(gpio->tps->regmap,
> +				   TPS65219_REG_GENERAL_CONFIG,
> +				   BIT(offset - 1), value ? BIT(offset - 1) : 0);
> +	else
> +		regmap_update_bits(gpio->tps->regmap,
> +				   TPS65219_REG_GENERAL_CONFIG,
> +				   BIT(TPS65219_GPIO0_OFFSET),
> +				   value ? BIT(TPS65219_GPIO0_OFFSET) : 0);

With tenporary variables for value and mask this can be simplified.

	bit = (offset == _IDX) ? GPIO0_OFFSET : offset - 1;

	mask = BIT(bit);
	v = value ? mask : 0;

	regmap_update_bits(..., mask, v);

> +}

...

> +static int tps65219_gpio_change_direction(struct gpio_chip *gc, unsigned int offset,
> +					  unsigned int direction)
> +{
> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);
> +
> +	/* Documentation is stating that GPIO0 direction must not be changed in Linux:
> +	 * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
> +	 * Should only be changed in INITIALIZE state (prior to ON Request).
> +	 * Set statically by NVM, changing direction in application can cause a hang.
> +	 * Below can be used for test purpose only:

You may rather put code into #if 0 ... #endif, so it will be easier to get the
test. Also, probably you would need to take care about error handling properly.

> +	 * ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
> +	 *			 TPS65219_GPIO0_DIR_MASK, direction);
> +	 */
> +	dev_err(gpio->tps->dev,
> +		"GPIO%d direction set by NVM, change to %u failed, not allowed by specification\n",
> +		 offset, direction);
> +	return -EOPNOTSUPP;
> +}

...

> +static struct platform_driver tps65219_gpio_driver = {
> +	.driver = {.name = "tps65219-gpio",},

Can you write it as

	.driver = {
		...
	},
?

> +	.probe = tps65219_gpio_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko


