Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB9700DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbjELRIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbjELRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:08:10 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8460FDDAB
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:08:03 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 8bd276d0-f0e7-11ed-b972-005056bdfda7;
        Fri, 12 May 2023 20:08:00 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 12 May 2023 20:07:59 +0300
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
Message-ID: <ZF5yb4DbVDbfxVU4@surfacebook>
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-3-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512141755.1712358-3-eblanc@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 12, 2023 at 04:17:54PM +0200, Esteban Blanc kirjoitti:
> TI TPS6594 PMIC has 11 GPIOs which can be used
> for different functions.
> 
> This patch adds a pinctrl and GPIO drivers in
> order to use those functions.

...

> +config PINCTRL_THUNDERBAY

Is it correct name? To me sounds not. The problem is that you use platform name
for the non-platform-wide pin control, i.e. for PMIC exclusively.
Did I miss anything?

> +	tristate "Generic pinctrl and GPIO driver for Intel Thunder Bay SoC"
> +	depends on ARCH_THUNDERBAY || (ARM64 && COMPILE_TEST)

This doesn't look correct, but I remember some Kconfig options that are using
this way of dependency.

> +	depends on HAS_IOMEM
> +	select PINMUX
> +	select PINCONF
> +	select GENERIC_PINCONF
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select GPIOLIB
> +	select GPIOLIB_IRQCHIP
> +	select GPIO_GENERIC
> +	help
> +	  This selects pin control driver for the Intel Thunder Bay SoC.
> +	  It provides pin config functions such as pull-up, pull-down,
> +	  interrupt, drive strength, sec lock, Schmitt trigger, slew
> +	  rate control and direction control. This module will be
> +	  called as pinctrl-thunderbay.

Ah, the above simply a mistake. right?
Why is it in this patch?

> +config PINCTRL_TPS6594
> +	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
> +	depends on MFD_TPS6594
> +	default MFD_TPS6594
> +	select PINMUX
> +	select GPIOLIB
> +	select REGMAP
> +	select GPIO_REGMAP
> +	help
> +	  This driver supports GPIOs and pinmuxing for the TPS6594
> +	  PMICs chip family.

Module name?

...

> +obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o

Huh?!

> +obj-$(CONFIG_PINCTRL_TPS6594)	+= pinctrl-tps6594.o

...

> +#include <linux/gpio/regmap.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinmux.h>

Ordered?

...

> +static const char *groups_name[TPS6594_PINCTRL_PINS_NB] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10"

Leave trailing comma even for known size.

> +};

...

> +struct tps6594_pinctrl_function {
> +	const char *name;
> +	u8 muxval;
> +	const char **groups;
> +	unsigned long ngroups;

We have struct pinfunction. Use it here (as embedded).

> +};

...

> +static const struct tps6594_pinctrl_function pinctrl_functions[] = {
> +	{ "gpio", TPS6594_PINCTRL_GPIO_FUNCTION, groups_name,
> +	  TPS6594_PINCTRL_PINS_NB },

Here and further use PINCTRL_PINFUNCTION() macro.

> +};

...

> +static int tps6594_group_pins(struct pinctrl_dev *pctldev,
> +			      unsigned int selector, const unsigned int **pins,
> +			      unsigned int *num_pins)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	*pins = (unsigned int *)&pinctrl->pins[selector];

Why casting?

> +	*num_pins = 1;
> +
> +	return 0;
> +}

...

> +	pinctrl->pctl_dev =
> +		devm_pinctrl_register(&pdev->dev, pctrl_desc, pinctrl);

One line?

> +	if (IS_ERR(pinctrl->pctl_dev)) {
> +		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
> +		return PTR_ERR(pinctrl->pctl_dev);

	return dev_err_probe(...);

> +	}

...

> +	pinctrl->gpio_regmap = devm_gpio_regmap_register(&pdev->dev, &config);
> +	if (IS_ERR(pinctrl->gpio_regmap)) {
> +		dev_err(&pdev->dev, "Couldn't register gpio_regmap driver\n");
> +		return PTR_ERR(pinctrl->pctl_dev);

Ditto.

> +	}
> +
> +	return 0;
> +}

...

> -#define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
> +#define TPS6594_REG_GPIO1_CONF				0x31
> +#define TPS6594_REG_GPIOX_CONF(gpio_inst)	(TPS6594_REG_GPIO1_CONF + (gpio_inst))

Why? The original code with parameter 0 will issue the same.

-- 
With Best Regards,
Andy Shevchenko


