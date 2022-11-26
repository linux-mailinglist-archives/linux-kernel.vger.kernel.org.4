Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AAF6392B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKZAY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKZAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:24:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 913655ADD0;
        Fri, 25 Nov 2022 16:24:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2EF92B;
        Fri, 25 Nov 2022 16:24:26 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9403F587;
        Fri, 25 Nov 2022 16:24:18 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:22:43 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 2/4] regulator: sun20i: Add Allwinner D1 LDOs driver
Message-ID: <20221126002243.37b1034d@slackpad.lan>
In-Reply-To: <20221125040112.18160-3-samuel@sholland.org>
References: <20221125040112.18160-1-samuel@sholland.org>
        <20221125040112.18160-3-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022 22:01:10 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> D1 contains two pairs of LDOs, "analog" LDOs and "system" LDOs. They are
> similar and can share a driver, but only the system LDOs have a DT
> binding defined so far.
> 
> The system LDOs have a single linear range. The voltage step is not an
> integer, so a custom .list_voltage is needed to get the rounding right.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v4:
>  - Drop the analog LDOs until the codec binding is ready
> 
> Changes in v3:
>  - Adjust control flow in sun20i_regulator_get_regmap() for clarity
> 
> Changes in v2:
>  - Use decimal numbers for .n_voltages instead of field widths
>  - Get the regmap from the parent device instead of a property/phandle
> 
>  drivers/regulator/Kconfig            |   8 ++
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/sun20i-regulator.c | 150 +++++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/regulator/sun20i-regulator.c
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 070e4403c6c2..8480532114c1 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1280,6 +1280,14 @@ config REGULATOR_STW481X_VMMC
>  	  This driver supports the internal VMMC regulator in the STw481x
>  	  PMIC chips.
>  
> +config REGULATOR_SUN20I
> +	tristate "Allwinner D1 internal LDOs"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select MFD_SYSCON
> +	default ARCH_SUNXI
> +	help
> +	  This driver supports the internal LDOs in the Allwinner D1 SoC.
> +
>  config REGULATOR_SY7636A
>  	tristate "Silergy SY7636A voltage regulator"
>  	depends on MFD_SY7636A
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 5962307e1130..8e9b5a21123d 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -150,6 +150,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
>  obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
>  obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
> +obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
>  obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
>  obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
>  obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
> diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
> new file mode 100644
> index 000000000000..031bcc3dee50
> --- /dev/null
> +++ b/drivers/regulator/sun20i-regulator.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
> +//
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +
> +#define SUN20I_SYS_LDO_CTRL_REG		0x150
> +
> +struct sun20i_regulator_data {
> +	const struct regulator_desc	*descs;
> +	unsigned int			ndescs;
> +};
> +
> +/* regulator_list_voltage_linear() modified for the non-integral uV_step. */
> +static int sun20i_d1_system_ldo_list_voltage(struct regulator_dev *rdev,
> +					     unsigned int selector)
> +{
> +	const struct regulator_desc *desc = rdev->desc;
> +	unsigned int uV;
> +
> +	if (selector >= desc->n_voltages)
> +		return -EINVAL;
> +
> +	uV = desc->min_uV + (desc->uV_step * selector);
> +
> +	/* Produce correctly-rounded absolute voltages. */
> +	return uV + ((selector + 1 + (desc->min_uV % 4)) / 3);
> +}
> +
> +static const struct regulator_ops sun20i_d1_system_ldo_ops = {
> +	.list_voltage		= sun20i_d1_system_ldo_list_voltage,
> +	.map_voltage		= regulator_map_voltage_ascend,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +};
> +
> +static const struct regulator_desc sun20i_d1_system_ldo_descs[] = {
> +	{
> +		.name		= "ldoa",
> +		.supply_name	= "ldo-in",
> +		.of_match	= "ldoa",
> +		.ops		= &sun20i_d1_system_ldo_ops,
> +		.type		= REGULATOR_VOLTAGE,
> +		.owner		= THIS_MODULE,
> +		.n_voltages	= 32,
> +		.min_uV		= 1600000,
> +		.uV_step	= 13333, /* repeating */

So while I see that those values are probably the closest we can with a
simple linear algorithm, they first two values seem to be slightly off
from those values in the manual:
sel diff algor  manual
 0:   7 (1.600 - 1.593)
 1:   6 (1.613 - 1.607)
Oddly enough the rest of the values are spot on.
I don't know if this really matters, or if the LDOs are actually
accurate enough to that level of precision, or if it's a manual bug, or
if we really care at all, but it might warrant some comment, I guess?
I just got triggered by the min value not being the first value in the
list.

> +		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
> +		.vsel_mask	= GENMASK(7, 0),
> +	},
> +	{
> +		.name		= "ldob",
> +		.supply_name	= "ldo-in",
> +		.of_match	= "ldob",
> +		.ops		= &sun20i_d1_system_ldo_ops,
> +		.type		= REGULATOR_VOLTAGE,
> +		.owner		= THIS_MODULE,
> +		.n_voltages	= 64,
> +		.min_uV		= 1166666,
> +		.uV_step	= 13333, /* repeating */

For LDOB it seems to be worse, as the second half is constantly off by
what looks like 6.666mV:
sel diff algor  manual
...
32:   0 (1.593 - 1.593)
33:   0 (1.607 - 1.607)
34:  -7 (1.620 - 1.627)
35:  -7 (1.633 - 1.64)
36:  -6 (1.647 - 1.653)
...
63:  -6 (2.007 - 2.013)
The first half is correct, though. Closer inspection reveals that
everything with bit 5 set is exactly the same as LDOA. Maybe we can use
that to our advantage?

Cheers,
Andre

> +		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
> +		.vsel_mask	= GENMASK(15, 8),
> +	},
> +};
> +
> +static const struct sun20i_regulator_data sun20i_d1_system_ldos = {
> +	.descs	= sun20i_d1_system_ldo_descs,
> +	.ndescs	= ARRAY_SIZE(sun20i_d1_system_ldo_descs),
> +};
> +
> +static struct regmap *sun20i_regulator_get_regmap(struct device *dev)
> +{
> +	struct regmap *regmap;
> +
> +	/*
> +	 * First try the syscon interface. The system control device is not
> +	 * compatible with "syscon", so fall back to getting the regmap from
> +	 * its platform device. This is ugly, but required for devicetree
> +	 * backward compatibility.
> +	 */
> +	regmap = syscon_node_to_regmap(dev->parent->of_node);
> +	if (!IS_ERR(regmap))
> +		return regmap;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (regmap)
> +		return regmap;
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +static int sun20i_regulator_probe(struct platform_device *pdev)
> +{
> +	const struct sun20i_regulator_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct regulator_config config;
> +	struct regmap *regmap;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	regmap = sun20i_regulator_get_regmap(dev);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to get regmap\n");
> +
> +	config = (struct regulator_config) {
> +		.dev	= dev,
> +		.regmap	= regmap,
> +	};
> +
> +	for (unsigned int i = 0; i < data->ndescs; ++i) {
> +		const struct regulator_desc *desc = &data->descs[i];
> +		struct regulator_dev *rdev;
> +
> +		rdev = devm_regulator_register(dev, desc, &config);
> +		if (IS_ERR(rdev))
> +			return PTR_ERR(rdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun20i_regulator_of_match[] = {
> +	{
> +		.compatible = "allwinner,sun20i-d1-system-ldos",
> +		.data = &sun20i_d1_system_ldos,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sun20i_regulator_of_match);
> +
> +static struct platform_driver sun20i_regulator_driver = {
> +	.probe	= sun20i_regulator_probe,
> +	.driver	= {
> +		.name		= "sun20i-regulator",
> +		.of_match_table	= sun20i_regulator_of_match,
> +	},
> +};
> +module_platform_driver(sun20i_regulator_driver);
> +
> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
> +MODULE_DESCRIPTION("Allwinner D1 internal LDO driver");
> +MODULE_LICENSE("GPL");

