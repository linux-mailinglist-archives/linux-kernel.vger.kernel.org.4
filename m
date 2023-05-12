Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74149700F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbjELTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjELTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:19:18 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769257685
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:19:17 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id e1e3206d-f0f9-11ed-a9de-005056bdf889;
        Fri, 12 May 2023 22:19:15 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 12 May 2023 22:19:14 +0300
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Message-ID: <ZF6RMqElYZVMpWRt@surfacebook>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 12, 2023 at 01:28:36PM +0100, Charles Keepax kirjoitti:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> Add a basic pinctrl driver which supports driver strength for the
> various pins, gpios, and pinmux for the 2 multi-function pins.

...

> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>

Can you order them and split into a separate group that goes...

> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +

...here?

> +#include "../pinctrl-utils.h"

...

> +struct cs42l43_pin {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	bool shutters_locked;

> +	struct gpio_chip gpio_chip;

If you move this to be the first member you might save a few bytes of code.

> +	struct pinctrl_gpio_range range;

Is it really needed here?

> +};

...

> +#define CS42L43_PIN(_number, _name, _reg, _field) { \
> +	.number = _number, .name = _name, \
> +	.drv_data = &((struct cs42l43_pin_data){ \
> +		.reg = CS42L43_##_reg, \
> +		.shift = CS42L43_##_field##_DRV_SHIFT, \
> +		.mask = CS42L43_##_field##_DRV_MASK, \
> +	}), \

Do you need this to be GCC extention for the value evaluation?
I mean the compound literal, IIRC, can be used directly as

	.foo = &(struct foo){ ... },

Am I mistaken?

> +}

...

> +#define CS42L43_PINGROUP(_name) \

Use PINCTRL_PINGROUP() instead of open coded.

> +(struct pingroup){				\
> +	.name = #_name, \
> +	.pins = cs42l43_pin_##_name##_pins, \
> +	.npins = ARRAY_SIZE(cs42l43_pin_##_name##_pins) \
> +}

...

> +enum cs42l43_pin_funcs {
> +	CS42L43_FUNC_GPIO,
> +	CS42L43_FUNC_SPDIF,
> +	CS42L43_FUNC_IRQ,
> +	CS42L43_FUNC_MIC_SHT,
> +	CS42L43_FUNC_SPK_SHT,

> +	CS42L43_FUNC_MAX,

No comma for the terminator entry

> +};

...

> +static const char * const cs42l43_pin_funcs[] = {
> +	"gpio", "spdif", "irq", "mic-shutter", "spk-shutter"

I would keep trailing comma.

> +};

...

> +struct cs42l43_pin_func_group {
> +	const char * const *groups;
> +	unsigned int ngroups;
> +};

We have struct pinfunction.

> +static const struct cs42l43_pin_func_group cs42l43_pin_func_groups[] = {
> +	{ cs42l43_pin_gpio_groups,	ARRAY_SIZE(cs42l43_pin_gpio_groups) },
> +	{ cs42l43_pin_spdif_groups,	ARRAY_SIZE(cs42l43_pin_spdif_groups) },
> +	{ cs42l43_pin_irq_groups,	ARRAY_SIZE(cs42l43_pin_irq_groups) },
> +	{ cs42l43_pin_shutter_groups,	ARRAY_SIZE(cs42l43_pin_shutter_groups) },
> +	{ cs42l43_pin_shutter_groups,	ARRAY_SIZE(cs42l43_pin_shutter_groups) },

We have PINCTRL_PINFUNCTION().

> +};

...

> +static int cs42l43_pin_get_func_count(struct pinctrl_dev *pctldev)
> +{
> +	BUILD_BUG_ON(ARRAY_SIZE(cs42l43_pin_funcs) != CS42L43_FUNC_MAX);
> +	BUILD_BUG_ON(ARRAY_SIZE(cs42l43_pin_func_groups) != CS42L43_FUNC_MAX);

Use static_assert() in the global scope instead.

> +
> +	return ARRAY_SIZE(cs42l43_pin_funcs);
> +}

...

> +	default:
> +		reg = CS42L43_GPIO_FN_SEL;
> +		mask = BIT(group_idx + CS42L43_GPIO1_FN_SEL_SHIFT);
> +		val = (func_idx == CS42L43_FUNC_GPIO) <<
> +				(group_idx + CS42L43_GPIO1_FN_SEL_SHIFT);

This would be better as ternary.

> +		break;
> +	}

...

> +	dev_dbg(priv->dev, "Setting gpio%d to %s\n",
> +		offset + 1, input ? "input" : "output");

How ' + 1' part won't be confusing?

...

> +static inline int cs42l43_pin_get_db(struct cs42l43_pin *priv, unsigned int pin)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	if (pin >= CS42L43_NUM_GPIOS)
> +		return -ENOTSUPP;
> +
> +	ret = regmap_read(priv->regmap, CS42L43_GPIO_CTRL2, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & (CS42L43_GPIO1_DEGLITCH_BYP_MASK << pin))
> +		return 0;

> +	else

Redundant.

> +		return 85; // Debounce is roughly 85uS

	// Debounce is roughly 85uS
	return 85;

> +}

...

> +	dev_dbg(priv->dev, "Set debounce %s for %s\n",
> +		us ? "on" : "off", cs42l43_pin_pins[pin].name);

str_on_off()

...

> +		++configs;
> +		--num_configs;

Why preincrements?

...

> +	if (is_of_node(dev_fwnode(cs42l43->dev))) {
> +		device_set_node(priv->dev,
> +				fwnode_get_named_child_node(dev_fwnode(cs42l43->dev),
> +							    "pinctrl"));
> +	} else {
> +		device_set_node(priv->dev, dev_fwnode(cs42l43->dev));
> +	}

This can be called once after if.

...

> +	pctldev = devm_pinctrl_register(priv->dev, &cs42l43_pin_desc, priv);
> +	if (IS_ERR(pctldev)) {
> +		ret = PTR_ERR(pctldev);
> +		dev_err(priv->dev, "Failed to register pinctrl: %d\n", ret);

		ret = dev_err_probe();

Same for other similar cases.

> +		goto err_pm;
> +	}

> +	if (!of_property_read_bool(dev_of_node(cs42l43->dev), "gpio-ranges")) {
> +		ret = gpiochip_add_pin_range(&priv->gpio_chip, priv->gpio_chip.label,
> +					     0, 0, CS42L43_NUM_GPIOS);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to add GPIO pin range: %d\n", ret);
> +			goto err_pm;
> +		}
> +	}

Besides the fact that we have a callback for this, why GPIO library can't
handle this for you already?

...

> +static int cs42l43_pin_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_disable(&pdev->dev);

This is simply wrong order because it's a mix of non-devm_*() followed by
devm_*() calls in the probe.

> +	return 0;
> +}

...

> +static struct platform_driver cs42l43_pin_driver = {
> +	.driver = {
> +		.name	= "cs42l43-pinctrl",
> +	},

> +

Redundant blank line.

> +	.probe		= cs42l43_pin_probe,
> +	.remove		= cs42l43_pin_remove,
> +};

-- 
With Best Regards,
Andy Shevchenko


