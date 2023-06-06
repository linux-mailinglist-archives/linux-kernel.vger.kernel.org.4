Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D50723D20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbjFFJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbjFFJW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:22:27 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C84E6D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:22:20 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id a061915a-044b-11ee-a9de-005056bdf889;
        Tue, 06 Jun 2023 12:22:16 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 6 Jun 2023 12:22:15 +0300
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jdelvare@suse.com, linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Message-ID: <ZH76x6E9cbfrJHeu@surfacebook>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606014234.29491-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jun 05, 2023 at 08:42:31PM -0500, nick.hawkins@hpe.com kirjoitti:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC supports GPIO on multiple interfaces. The interfaces are
> CPLD and Host. The GPIOs is a combination of both physical and virtual
> I/O across the interfaces. The gpio-gxp driver specifically covers the
> CSM(physical), FN2(virtual), and VUHC(virtual) which are the host. The
> gpio-gxp-pl driver covers the CPLD which takes physical I/O from the
> board and shares it with GXP via a propriety interface that maps the I/O
> onto a specific register area of the GXP. The drivers both support
> interrupts but from different interrupt parents.

Thank you.
This needs some work to be done. See my comments below.

...

> +/* Remember last PSU config */

Would be nice to add why this is a global variable.

> +u8 psu_presence;

...

> +struct gxp_gpio_drvdata {
> +	struct regmap *base;
> +	struct regmap *interrupt;

> +	struct gpio_chip chip;

Making this the first member might save a few bytes of code.

> +	int irq;
> +};

> +static struct regmap *gxp_gpio_init_regmap(struct platform_device *pdev,
> +					   char *reg_name, u8 bits)
> +{
> +	struct regmap_config regmap_config = {
> +		.reg_bits = 32,
> +		.reg_stride = 4,
> +		.val_bits = 32,
> +	};

Move it out and make static const.

> +	void __iomem *base;

> +	if (bits == 8) {
> +		regmap_config.reg_bits = 8;
> +		regmap_config.reg_stride = 1;
> +		regmap_config.val_bits = 8;
> +		regmap_config.max_register = 0xff;
> +	}

Just make two regmap configs and choose them based on the bits.

> +	base = devm_platform_ioremap_resource_byname(pdev, reg_name);
> +	if (IS_ERR(base))
> +		return ERR_CAST(base);
> +
> +	regmap_config.name = reg_name;
> +
> +	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);

Why are you not using gpio-regmap?

> +}

...

> +static int gxp_gpio_pl_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct gxp_gpio_drvdata *drvdata = dev_get_drvdata(chip->parent);
> +	unsigned int val;

> +	int ret = 0;

Unneeded.

> +	switch (offset) {
> +	case IOP_LED1 ... IOP_LED8:
> +		regmap_read(drvdata->base, PLREG_IOP_LED, &val);
> +		ret = (val & BIT(offset)) ? 1 : 0;
> +		break;
> +	case FAN1_INST ...FAN8_INST:
> +		regmap_read(drvdata->base, PLREG_FAN_INST, &val);
> +		ret = (val & BIT((offset - FAN1_INST))) ? 1 : 0;
> +		break;
> +	case FAN1_FAIL ... FAN8_FAIL:
> +		regmap_read(drvdata->base, PLREG_FAN_FAIL, &val);
> +		ret = (val & BIT((offset - FAN1_FAIL))) ? 1 : 0;
> +		break;
> +	case PWR_BTN_INT ... SLP_INT:
> +		regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);
> +		/* Active low */
> +		ret = (val & BIT((offset - PWR_BTN_INT) + 16)) ? 0 : 1;
> +		break;
> +	case  PSU1_INST ... PSU8_INST:
> +		regmap_read(drvdata->base, PLREG_PSU_INST, &val);
> +		psu_presence = (u8)val;
> +		ret = (psu_presence & BIT((offset - PSU1_INST))) ? 1 : 0;
> +		break;
> +	case PSU1_AC ... PSU8_AC:
> +		regmap_read(drvdata->base, PLREG_PSU_AC, &val);
> +		ret = (val & BIT((offset - PSU1_AC))) ? 1 : 0;
> +		break;
> +	case PSU1_DC ... PSU8_DC:
> +		regmap_read(drvdata->base, PLREG_PSU_DC, &val);
> +		ret = (val & BIT((offset - PSU1_DC))) ? 1 : 0;
> +		break;
> +	default:
> +		break;
> +	}

Obviously what needs to be done in a switch case is to assing offset adjustment
and register name. Then here you read and return the value based on that.

Same approach may be used in other switch-cases in the driver.

> +	return ret;
> +}

...

> +static int gxp_gpio_pl_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +	int ret = GXP_GPIO_DIR_IN;

Useless variable. Return directly.

> +	switch (offset) {
> +	case IOP_LED1 ... IOP_LED8:
> +	case LED_IDENTIFY ... LED_HEALTH_AMBER:
> +	case ACM_FORCE_OFF:
> +	case ACM_REQ_N:
> +		ret = GXP_GPIO_DIR_OUT;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}

...

> +static int gxp_gpio_pl_direction_input(struct gpio_chip *chip,
> +				       unsigned int offset)
> +{
> +	int ret = -EOPNOTSUPP;

Ditto.
Also note, GPIOLIB uses ENOTSUPP.

> +	switch (offset) {
> +	case 8 ... 55:
> +		ret = GXP_GPIO_DIR_OUT;
> +		break;
> +	case 59 ... 65:
> +		ret = GXP_GPIO_DIR_OUT;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}

Same comments as above may be applied to other function implementations in the
driver.

...

> +static irqreturn_t gxp_gpio_pl_irq_handle(int irq, void *_drvdata)
> +{
> +	struct gxp_gpio_drvdata *drvdata = (struct gxp_gpio_drvdata *)_drvdata;

Redundant casting.

> +	unsigned int val, girq, i;
> +
> +	/* Check group 5 interrupts */
> +
> +	regmap_read(drvdata->base, PLREG_INT_GRP5_FLAG, &val);

No error check? So it will spit a spurious interrupts here and there?

> +	if (val) {

Redundant conditional.

> +		for_each_set_bit(i, (unsigned long *)&val, 3) {

This casting is red flag. It has 3 issues. So, no. Just make the copy in the
unsigned long type.

> +			girq = irq_find_mapping(drvdata->chip.irq.domain,
> +						i + PWR_BTN_INT);
> +			generic_handle_irq(girq);

generic_handle_domain_irq()

> +		}
> +
> +		/* Clear latched interrupt */
> +		regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_FLAG,
> +				   0xFF, 0xFF);

GENMASK()

> +		regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP5_BASE,
> +				   BIT(0) | BIT(2), 0);
> +	}
> +
> +	/* Check group 6 interrupts */
> +
> +	regmap_read(drvdata->base, PLREG_INT_GRP6_FLAG, &val);
> +
> +	if (val & BIT(2)) {
> +		u8 old_psu = psu_presence;
> +
> +		regmap_read(drvdata->base, PLREG_PSU_INST, &val);
> +		psu_presence = (u8)val;
> +
> +		if (old_psu != psu_presence) {
> +			/* Identify all bits which differs */
> +			u8 current_val = psu_presence;
> +			u8 old_val = old_psu;

> +			for (i = 0 ; i < 8 ; i++) {
> +				if ((current_val & 0x1) != (old_val & 0x1)) {

Make them unsigned long, use bitmap_xor() or just ^ followed by
for_each_set_bit().

> +				/* PSU state has changed */
> +					girq = irq_find_mapping(drvdata->chip.irq.domain,
> +								i + PSU1_INST);
> +					if (girq)
> +						generic_handle_irq(girq);

See above.

> +				}

> +				current_val = current_val >> 1;
> +				old_val = old_val >> 1;

No need with the above suggestion.

> +			}
> +		}
> +	}
> +
> +	/* Clear latched interrupt */
> +	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_FLAG,
> +			   0xFF, 0xFF);

GENMASK()

> +	regmap_update_bits(drvdata->interrupt, PLREG_INT_GRP6_BASE,
> +			   BIT(2), 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct gpio_chip plreg_chip = {

Make it const and mark as a template (in the name).

> +	.label			= "gxp_gpio_plreg",
> +	.owner			= THIS_MODULE,
> +	.get			= gxp_gpio_pl_get,
> +	.set			= gxp_gpio_pl_set,
> +	.get_direction = gxp_gpio_pl_get_direction,
> +	.direction_input = gxp_gpio_pl_direction_input,
> +	.direction_output = gxp_gpio_pl_direction_output,
> +	.base = -1,
> +};
> +
> +static struct irq_chip gxp_plreg_irqchip = {

Make it const and immutable.

> +	.name		= "gxp_plreg",
> +	.irq_ack	= gxp_gpio_pl_irq_ack,
> +	.irq_mask	= gxp_gpio_pl_irq_mask,
> +	.irq_unmask	= gxp_gpio_pl_irq_unmask,
> +	.irq_set_type	= gxp_gpio_pl_set_type,
> +};

...

> +	psu_presence = (u8)val;

Why casting?

...

> +	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->chip, drvdata);
> +	if (ret < 0)

What is the meaning of positive returned value? Why do we not care about it?

> +		dev_err_probe(&pdev->dev, ret, "Could not register gpiochip for plreg\n");

...

> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Get irq from platform fail\n");

No need to repeat what the API already messages to the user.

...

> +	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_gpio_pl_irq_handle,
> +			       IRQF_SHARED, "gxp-pl", drvdata);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

	return devm_request_irq(...);

> +}


...

> +static int gxp_gpio_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct gxp_gpio_drvdata *drvdata;
> +
> +	/* Initialize global vars */
> +	psu_presence = 0;

> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, drvdata);

> +	ret = gxp_gpio_pl_init(pdev);
> +
> +	return ret;

	return gxp_...;

But why that function is separate?

> +}

...

> +++ b/drivers/gpio/gpio-gxp.c

Take all above comments and apply here as well.

...

Split this to two patches, one per driver. It makes easier reviews and flexible
handling of the driver maintenance.

-- 
With Best Regards,
Andy Shevchenko


