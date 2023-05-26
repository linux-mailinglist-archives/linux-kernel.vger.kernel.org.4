Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1811B712C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjEZSQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjEZSQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:16:05 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1115113A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:16:00 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 581a60e7-fbf1-11ed-abf4-005056bdd08f;
        Fri, 26 May 2023 21:15:51 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 26 May 2023 21:15:50 +0300
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH v3 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
Message-ID: <ZHD3VtFDYUyy_Std@surfacebook>
References: <20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com>
 <20230511-tps65219-add-gpio-support-v3-1-19837a34d820@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511-tps65219-add-gpio-support-v3-1-19837a34d820@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 26, 2023 at 05:06:03PM +0200, Jerome Neanne kirjoitti:
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
> It's either a GPO when MULTI_DEVICE_EN=0,
> or a GPI when MULTI_DEVICE_EN=1.

> Datasheet describes specific usage for non standard GPIO.

> Link: https://www.ti.com/lit/ds/symlink/tps65219.pdf
> 

This blank line makes Link: above not to be a tag. Tag block mustn't have blank
lines. OTOH, the other text must be delimited by a blank line before the tag
block. That said, move this blank line to before Link: line.

> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>

...

> +	help
> +	  Select this option to enable GPIO driver for the TPS65219
> +	  chip family.
> +	  GPIO0 is statically configured as input or output prior to Linux boot.
> +	  it is used for MULTI_DEVICE_ENABLE function.
> +	  This setting is statically configured by NVM.
> +	  GPIO0 can't be used as a generic GPIO.
> +	  It's either a GPO when MULTI_DEVICE_EN=0,
> +	  or a GPI when MULTI_DEVICE_EN=1.

This is strange indentation, we have longer lines, why not using all room
available? Btw, seems the commit message itself has the same issue.

> +	  This driver can also be built as a module. If so, the
> +	  module will be called gpio_tps65219.

...

Missing bits.h

> +#include <linux/gpio/driver.h>
> +#include <linux/mfd/tps65219.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

...

> +static int tps65219_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct tps65219_gpio *gpio = gpiochip_get_data(gc);

With

	struct device *dev = gpio->tps->dev;

you may make some code blocks shorter.

> +	int ret, val;
> +
> +	if (offset != TPS65219_GPIO0_IDX) {
> +		dev_err(gpio->tps->dev,
> +			"GPIO%d is output only, cannot get\n",
> +			offset);

Like here.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = regmap_read(gpio->tps->regmap, TPS65219_REG_MFP_CTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	dev_warn(gpio->tps->dev,
> +		 "GPIO%d = %d, used for MULTI_DEVICE_ENABLE, not as standard GPIO\n",

> +		 offset, !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK)));

Isn't it the same...

> +	/* depends on NVM config return error if dir output else the GPIO0 status bit */
> +	if (tps65219_gpio_get_direction(gc, offset) == TPS65219_GPIO_DIR_OUT)
> +		return -EOPNOTSUPP;
> +
> +	return !!(val & BIT(TPS65219_MFP_GPIO_STATUS_MASK));

...as this one? What the point to evaluate it twice?

> +}

...

> +		dev_err(gpio->tps->dev, "GPIO%d, set to value %d failed.\n", offset, value);

Yeah, there is an inconsistency between line lengths in different functions.
Define for yourself the style 80 or 100 and use it everywhere.

...

> +	/* Documentation is stating that GPIO0 direction must not be changed in Linux:
> +	 * Table 8-34. MFP_1_CONFIG(3): MULTI_DEVICE_ENABLE,
> +	 * Should only be changed in INITIALIZE state (prior to ON Request).
> +	 * Set statically by NVM, changing direction in application can cause a hang.
> +	 * Below can be used for test purpose only:
> +	 */
> +

/*
 * The style of multi-line comment
 * is incorrect. See this example.
 * Besides that, remove unneeded
 * blank line above.
 */

> +	if (IS_ENABLED(DEBUG)) {
> +		int ret = regmap_update_bits(gpio->tps->regmap, TPS65219_REG_MFP_1_CONFIG,
> +					     TPS65219_GPIO0_DIR_MASK, direction);
> +		if (ret) {
> +			dev_err(gpio->tps->dev,

> +				"DEBUG enabled: Fail to change direction to %u for GPIO%d. \
> +				For test only\n",

Do not split string literals on non-\n characters.

> +				direction, offset);

> +		return ret;

Wrong indentation.

> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


