Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4367211F4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 21:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjFCT6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFCT6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 15:58:42 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D53318D
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 12:58:41 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 0835ac98-0249-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 22:58:39 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 22:58:38 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 07/43] pinctrl: add a Cirrus ep93xx SoC pin controller
Message-ID: <ZHubbmYDS76stIg7@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-8-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601053546.9574-8-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:33:58AM +0300, Nikita Shubin kirjoitti:
> This adds a pin control (only multiplexing) driver for ep93xx
> SoC so we can fully convert ep93xx to device tree.
> 
> This driver is capable of muxing ep9301/ep9302/ep9307/ep9312/ep9315
> variants, this is chosen based on "compatible" in device tree.

I have a déjà vu that I commented on this already...

...

> +enum ep93xx_pinctrl_model {
> +	EP93XX_9301_PINCTRL = 0,

It's not needed, guaranteed by the C standard.

> +	EP93XX_9307_PINCTRL,
> +	EP93XX_9312_PINCTRL

Keep trailing comma, might help in case of this being extended.

> +};

> +/**
> + * struct ep93xx_pin_group - describes a ep93xx pin group
> + * @name: the name of this specific pin group
> + * @pins: an array of discrete physical pins used in this group, taken
> + *	from the driver-local pin enumeration space
> + * @num_pins: the number of pins in this group array, i.e. the number of
> + *	elements in .pins so we can iterate over that array
> + * @mask: bits to clear to enable this when doing pin muxing
> + * @value: bits to set to enable this when doing pin muxing
> + */
> +struct ep93xx_pin_group {
> +	const char *name;
> +	const unsigned int *pins;
> +	const unsigned int num_pins;

Please, use struct pingroup.

> +	u32 mask;
> +	u32 value;
> +};

...

> +static const struct ep93xx_pin_group ep9301_pin_groups[] = {
> +	{
> +		.name = "ssp",
> +		.pins = ssp_ep9301_pins,
> +		.num_pins = ARRAY_SIZE(ssp_ep9301_pins),

Use PINCTRL_PINGROUP() respectively.

> +		.mask = EP93XX_SYSCON_DEVCFG_I2SONSSP,
> +	},

> +};

...

> +static const struct ep93xx_pin_group ep9307_pin_groups[] = {

Ditto.

> +};

...
> +static const struct ep93xx_pin_group ep9312_pin_groups[] = {

Ditto.

> +};

...

> +	switch (pmx->model) {
> +	case EP93XX_9301_PINCTRL:
> +		return ARRAY_SIZE(ep9301_pin_groups);
> +	case EP93XX_9307_PINCTRL:
> +		return ARRAY_SIZE(ep9307_pin_groups);
> +	case EP93XX_9312_PINCTRL:
> +		return ARRAY_SIZE(ep9312_pin_groups);
> +	}
> +
> +	return 0;

Simply make it default: case.

...

> +	switch (pmx->model) {
> +	case EP93XX_9301_PINCTRL:
> +		return ep9301_pin_groups[selector].name;
> +	case EP93XX_9307_PINCTRL:
> +		return ep9307_pin_groups[selector].name;
> +	case EP93XX_9312_PINCTRL:
> +		return ep9312_pin_groups[selector].name;
> +	}
> +
> +	return NULL;

Ditto.

...

> +static void ep93xx_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
> +				unsigned int offset)
> +{
> +	seq_printf(s, " " DRIVER_NAME);

How this is useful?

> +}

...

> +static const struct pinctrl_ops ep93xx_pctrl_ops = {
> +	.get_groups_count = ep93xx_get_groups_count,
> +	.get_group_name = ep93xx_get_group_name,
> +	.get_group_pins = ep93xx_get_group_pins,
> +	.pin_dbg_show = ep93xx_pin_dbg_show,

> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
> +	.dt_free_map = pinconf_generic_dt_free_map,

Missing ifdeffery?

> +};

...

> +/**
> + * struct ep93xx_pmx_func - describes ep93xx pinmux functions
> + * @name: the name of this specific function
> + * @groups: corresponding pin groups
> + */
> +struct ep93xx_pmx_func {
> +	const char *name;
> +	const char * const *groups;
> +	const unsigned int num_groups;
> +};

Use struct pinfunction instead.

...

> +static const struct ep93xx_pmx_func ep93xx_pmx_functions[] = {
> +	{
> +		.name = "spi",
> +		.groups = spigrps,
> +		.num_groups = ARRAY_SIZE(spigrps),
> +	},

And PINCTRL_PINFUNCTION() respectively.

> +};

...

> +	switch (pmx->model) {
> +	case EP93XX_9301_PINCTRL:
> +		grp = &ep9301_pin_groups[group];
> +		break;
> +	case EP93XX_9307_PINCTRL:
> +		grp = &ep9307_pin_groups[group];
> +		break;
> +	case EP93XX_9312_PINCTRL:
> +		grp = &ep9312_pin_groups[group];
> +		break;

default?

> +	}

...

> +	for_each_set_bit(i, &tmp, PADS_MAXBIT) {
> +		bool enabled = expected & BIT(i);
> +
> +		dev_err(pmx->dev,
> +			    "pin group %s could not be %s: probably a hardware limitation\n",
> +			    ep93xx_padgroups[i], enabled ? "enabled" : "disabled");

str_enabled_disabled()

> +		dev_err(pmx->dev,
> +				"DeviceCfg before: %08x, after %08x, expected %08x\n",
> +				before, after, expected);
> +	}

...

> +static const struct of_device_id ep93xx_pinctrl_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-pinctrl", .data = (void *)EP93XX_9301_PINCTRL},
> +	{ .compatible = "cirrus,ep9302-pinctrl", .data = (void *)EP93XX_9301_PINCTRL},
> +	{ .compatible = "cirrus,ep9307-pinctrl", .data = (void *)EP93XX_9307_PINCTRL},
> +	{ .compatible = "cirrus,ep9312-pinctrl", .data = (void *)EP93XX_9312_PINCTRL},
> +	{ .compatible = "cirrus,ep9315-pinctrl", .data = (void *)EP93XX_9312_PINCTRL},
> +	{},

Comma is not needed in the terminator entry.

> +};

...

> +	const struct of_device_id *match = of_match_node(ep93xx_pinctrl_of_ids, pdev->dev.of_node);

Why? This is an old API, simply use of_device_get_match_data().

With it you don't need to locate OF ID table too early in the code.

> +	struct ep93xx_pmx *pmx;
> +	struct regmap *map;
> +	struct device *dev = &pdev->dev;
> +	struct device *parent;

Longer lines first?

...

> +	pmx->dev = &pdev->dev;

	... = dev; ?

...

> +	parent = dev->parent;
> +	if (!parent) {
> +		dev_err(dev, "no parent to pin controller\n");
> +		return -ENODEV;

		return dev_err_probe(...);

> +	}

...

> +	map = syscon_node_to_regmap(parent->of_node);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "no syscon regmap\n");
> +		return PTR_ERR(map);

Ditto.

> +	}

...

> +	switch (pmx->model) {
> +	case EP93XX_9301_PINCTRL:
> +		ep93xx_pmx_desc.pins = ep9301_pins;
> +		ep93xx_pmx_desc.npins = ARRAY_SIZE(ep9301_pins);
> +		dev_info(dev, "detected 9301/9302 chip variant\n");
> +		break;
> +	case EP93XX_9307_PINCTRL:
> +		ep93xx_pmx_desc.pins = ep9307_pins;
> +		ep93xx_pmx_desc.npins = ARRAY_SIZE(ep9307_pins);
> +		dev_info(dev, "detected 9307 chip variant\n");
> +		break;
> +	case EP93XX_9312_PINCTRL:
> +		ep93xx_pmx_desc.pins = ep9312_pins;
> +		ep93xx_pmx_desc.npins = ARRAY_SIZE(ep9312_pins);
> +		dev_info(dev, "detected 9312/9315 chip variant\n");
> +		break;

default?

> +	}

...

> +	pmx->pctl = devm_pinctrl_register(dev, &ep93xx_pmx_desc, pmx);
> +	if (IS_ERR(pmx->pctl)) {
> +		dev_err(dev, "could not register pinmux driver\n");
> +		return PTR_ERR(pmx->pctl);

		return dev_err_probe(...);

> +	}

> +	dev_info(dev, "initialized ep93xx pin control driver\n");

Noise. Please drop it.

> +	return 0;
> +};

-- 
With Best Regards,
Andy Shevchenko


