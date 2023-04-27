Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56996F09D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbjD0Q2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243370AbjD0Q2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:28:09 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B3D187
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:28:07 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 7ad0272f-e518-11ed-b972-005056bdfda7;
        Thu, 27 Apr 2023 19:28:03 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 27 Apr 2023 19:28:02 +0300
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jdelvare@suse.com, linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Message-ID: <ZEqikkknyRrFTh2t@surfacebook>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418152824.110823-2-nick.hawkins@hpe.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Apr 18, 2023 at 10:28:16AM -0500, nick.hawkins@hpe.com kirjoitti:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC supports GPIO on multiple interfaces: Host, CPLD and Soc
> pins. The interface from CPLD and Host are interruptable from vic0
> and vic1. This driver allows support for both of these interfaces
> through the use of different compatible bindings.

Thank you for your contribution. To begin with, I don't believe a simple GPIO
driver needs 1000+ LoCs. But see more comments below.

...

> +config GPIO_GXP
> +        tristate "GXP GPIO support"
> +        depends on ARCH_HPE_GXP
> +        select GPIOLIB_IRQCHIP
> +        help
> +	  Say Y here to support GXP GPIO controllers. It provides
> +	  support for the multiple GPIO interfaces available to be
> +	  available to the Host.

The indentation is rather problematic. Had you run checkpatch.pl?

...

> +#include <linux/gpio.h>

No, new code may not include this header.

...

> +#include <linux/of.h>
> +#include <linux/of_device.h>

Why? I haven't seen much evidence of needing of these. What you need are
rather mod_devicetable.h and property.h (see also below).

...

> +#define GPIDATL		0x40
> +#define GPIDATH		0x60
> +#define GPODATL		0xb0
> +#define GPODATH		0xb4
> +#define GPODAT2L	0xf8
> +#define GPODAT2H	0xfc

Use same size of the values, e.g. 0x0fc

> +#define GPOOWNL		0x110
> +#define GPOOWNH		0x114
> +#define GPOOWN2L	0x118
> +#define GPOOWN2H	0x11c

To me this sounds like a 2 8-lines bank GPIO array. Drop those H and L suffixes
and use proper offset calculation based on the bank number. There are plenty of
existing GPIO drivers that do that way.

Also why gpio-regmap is not in use?

...

> +#define GPIO_DIR_OUT	0
> +#define GPIO_DIR_IN	1

Oh, what is this?! You must not interfere with the GPIO_ namespace.

...

> +#define PGOOD_MASK		1

For mask use BIT() / GENMASK()

> +#define PLREG_INT_GRP_STAT_MASK	0x8

Ditto.

...

> +#define PLREG_INT_HI_PRI_EN	0xC

Is it register offset or value?

> +#define PLREG_INT_GRP5_BASE	0x31
> +#define PLREG_INT_GRP6_BASE	0x35
> +#define PLREG_INT_GRP5_FLAG	0x30
> +#define PLREG_INT_GRP6_FLAG	0x34

These need more expanation what they are for and why these specific values are
being used.

...


> +#define PLREG_INT_GRP5_PIN_BASE	59
> +#define PLREG_INT_GRP6_PIN_BASE	90

What are these for?

...

> +enum plreg_gpio_pn {
> +	RESET = 192,
> +	NMI_OUT = 193,
> +	VPBTN = 210,
> +	PGOOD,
> +	PERST,
> +	POST_COMPLETE,

Why these numbers? If it comes from hardware specification, make _all_ them
explicitly assigned.

> +};

...

> +struct gxp_gpio_drvdata {
> +	struct regmap *csm_map;
> +	void __iomem *fn2_vbtn;
> +	struct regmap *fn2_stat;
> +	struct regmap *vuhc0_map;
> +	void __iomem *vbtn;
> +	struct regmap *pl_led;
> +	struct regmap *pl_health;
> +	struct regmap *pl_int;

> +	struct gpio_chip chip;

Move it to be the first member in the structure. Might save a few bytes in the
code. 

> +	int irq;
> +};

...

> +static int gxp_gpio_csm_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
> +	int ret = 0;

> +	switch (offset) {
> +	case 0 ... 31:
> +		regmap_read(drvdata->csm_map, GPIDATL,	&ret);
> +		ret = (ret & BIT(offset)) ? 1 : 0;
> +		break;
> +	case 32 ... 63:
> +		regmap_read(drvdata->csm_map, GPIDATH,	&ret);
> +		ret = (ret & BIT(offset - 32)) ? 1 : 0;
> +		break;
> +	case 64 ... 95:
> +		regmap_read(drvdata->csm_map, GPODATL,	&ret);
> +		ret = (ret & BIT(offset - 64)) ? 1 : 0;
> +		break;
> +	case 96 ... 127:
> +		regmap_read(drvdata->csm_map, GPODATH,	&ret);
> +		ret = (ret & BIT(offset - 96)) ? 1 : 0;
> +		break;
> +	case 128 ...  159:
> +		regmap_read(drvdata->csm_map, GPODAT2L,	&ret);
> +		ret = (ret & BIT(offset - 128)) ? 1 : 0;
> +		break;
> +	case 160 ... 191:
> +		regmap_read(drvdata->csm_map, GPODAT2H,	&ret);
> +		ret = (ret & BIT(offset - 160)) ? 1 : 0;
> +		break;
> +	case 192:
> +		/* SW_RESET */
> +		regmap_read(drvdata->csm_map, 0x5C, &ret);
> +		ret = (ret & BIT(15)) ? 1 : 0;
> +		break;

Besides redundant " ? 1 : 0" parts, see what I wrote above and calculate offset
properly and then apply. Ditto for other functions.

> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}

I stopped here, this driver requires a lot more work to be done before
considering for upstream, sorry.

...

> +	girq->default_type = IRQ_TYPE_NONE;
> +	girq->handler = handle_edge_irq;

Should be handle_bad_irq() by default.

...

> +	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, drvdata);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Could not register gpiochip for plreg, %d\n",
> +			ret);

Huh?! No bailing out?

...

> +	regmap_update_bits(drvdata->pl_int, PLREG_INT_HI_PRI_EN,
> +			   BIT(4) | BIT(5), BIT(4) | BIT(5));

GENMASK(), but do it as a defined value with meaningful name.

> +	regmap_update_bits(drvdata->pl_int, PLREG_INT_GRP_STAT_MASK,
> +			   BIT(4) | BIT(5), 0x00);

Ditto.

...

> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {

> +		dev_err(&pdev->dev, "Get irq from platform fail - %d\n", ret);

No. The message is already printed by platform code. You are not supposed to
pollute logs with duplicative noise.

> +		return ret;
> +	}

...

> +static const struct of_device_id gxp_gpio_of_match[] = {
> +	{ .compatible = "hpe,gxp-gpio"},
> +	{ .compatible = "hpe,gxp-gpio-pl"},

Missing spaces in above two lines.

> +	{}
> +};

...

> +	const struct of_device_id *match = of_match_device(gxp_gpio_of_match, dev);

device_get_match_data()

...

> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct gxp_gpio_drvdata),
> +			       GFP_KERNEL);

sizeof(*drvdata) and make it one line.

> +	if (!drvdata)
> +		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


