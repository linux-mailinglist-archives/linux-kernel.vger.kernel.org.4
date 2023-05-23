Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61670E532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbjEWTOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbjEWTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:14:40 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61544119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:14:37 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 0d73c900-f99e-11ed-b3cf-005056bd6ce9;
        Tue, 23 May 2023 22:14:35 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 22:14:34 +0300
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
Subject: Re: [PATCH v5 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
Message-ID: <ZG0QmjZwvzWbNwA4@surfacebook>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
 <20230522163115.2592883-3-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522163115.2592883-3-eblanc@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 06:31:14PM +0200, Esteban Blanc kirjoitti:
> TI TPS6594 PMIC has 11 GPIOs which can be used
> for different functions.
> 
> This patch adds a pinctrl and GPIO drivers in
> order to use those functions.

...

> +#define FUNCTION(n, g, v)                                                    \
> +	{                                                                    \
> +		.pinfunction = PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)), \
> +		.muxval = v,                                                 \
> +	}

It seems you have used SPACEs before \, can you move to TABs?

...

> +static int tps6594_gpio_regmap_xlate(struct gpio_regmap *gpio,
> +				     unsigned int base, unsigned int offset,
> +				     unsigned int *reg, unsigned int *mask)
> +{
> +	unsigned int line = offset % 8;
> +	unsigned int stride = offset / 8;
> +
> +	switch (base) {
> +	case TPS6594_REG_GPIO1_CONF:
> +		*reg = TPS6594_REG_GPIOX_CONF(offset);
> +		*mask = TPS6594_BIT_GPIO_DIR;
> +		break;
> +	case TPS6594_REG_GPIO_IN_1:
> +	case TPS6594_REG_GPIO_OUT_1:
> +		*reg = base + stride;
> +		*mask = BIT(line);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	return 0;

You can return directly instead of breaking.

> +}

> +	pinctrl->pins = tps6594_pins;
> +	pinctrl->pctl_dev =
> +		devm_pinctrl_register(&pdev->dev, pctrl_desc, pinctrl);

With

	struct device *dev = &pdev->dev;

the above becomes a single line. This may help other similar uses.

> +	if (IS_ERR(pinctrl->pctl_dev)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pinctrl->pctl_dev),
> +				     "Couldn't register pinctrl driver\n");
> +	}

Also the {} can be dropped.

...

> +	pinctrl->gpio_regmap = devm_gpio_regmap_register(&pdev->dev, &config);
> +	if (IS_ERR(pinctrl->gpio_regmap)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pinctrl->gpio_regmap),
> +				     "Couldn't register gpio_regmap driver\n");
> +	}

Ditto.

...

> +static struct platform_driver tps6594_pinctrl_driver = {
> +	.driver = { .name = "tps6594-pinctrl" },

Can you use more standard way of style here, i.e.

	.driver = {
		.name = "tps6594-pinctrl",
	},

In case someone is going to add something there in the future it will become
just as cleaner as possible.

> +	.probe = tps6594_pinctrl_probe,
> +};
> +
> +module_platform_driver(tps6594_pinctrl_driver);

Move the above blank line here.

> +MODULE_ALIAS("platform:tps6594-pinctrl");
> +MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");

...

> +// Used to compute register address of GPIO1_CONF to GPIO11_CONF

This is good.

> -#define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
> +#define TPS6594_REG_GPIOX_CONF(gpio_inst)	(0x31 + (gpio_inst))

But why this?!

-- 
With Best Regards,
Andy Shevchenko


