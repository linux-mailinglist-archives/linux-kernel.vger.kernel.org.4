Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647937300DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbjFNNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbjFNNzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1727E5;
        Wed, 14 Jun 2023 06:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3819461F1E;
        Wed, 14 Jun 2023 13:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0F9C433C8;
        Wed, 14 Jun 2023 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750900;
        bh=A2B/Gsee6ihGMQ1QHhXxMQ/QaQxiJfy5c/hn7IAo8bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=torTdnyAUkLZm6p0sRSHxeLnr/F3CO2zsp8zdX4HC6+RdwT64K8OEUty4rRCrB3Bp
         b1OvOgWt0DBEKRXYhNUU5XkcEtip1I2ZwSpT/ed9DwDVmZE3FycmuKb5eXtY3vGyCb
         fJq9meot51lF6dA3hrDjlpM7+jZQClFD4wh6PhdQMUevlNeOw+fJJKPnkDXGKibeCa
         jeitqQP0iXmfwGt5Eeg135kC0H32/Qfyf77jbEmeGLTUGgrTnXOiRIlnjjSzhZXGoE
         2jHo1W714F2Qg2ehjItOVm8O9zWwHSXpYtoUlDdfBXsUdn51kcM38wAywdABYt5RNP
         0irtqerewbJ6g==
Date:   Wed, 14 Jun 2023 14:54:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, aseketeli@baylibre.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v6 2/2] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
Message-ID: <20230614135454.GV3635807@google.com>
References: <20230612125248.1235581-1-eblanc@baylibre.com>
 <20230612125248.1235581-3-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612125248.1235581-3-eblanc@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023, Esteban Blanc wrote:

> TI TPS6594 PMIC has 11 GPIOs which can be used
> for different functions.
> 
> This patch adds a pinctrl and GPIO drivers in
> order to use those functions.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  drivers/pinctrl/Kconfig           |  15 ++
>  drivers/pinctrl/Makefile          |   1 +
>  drivers/pinctrl/pinctrl-tps6594.c | 368 ++++++++++++++++++++++++++++++
>  include/linux/mfd/tps6594.h       |   1 +
>  4 files changed, 385 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 5787c579dcf6..d3cff8d27e5d 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -480,6 +480,21 @@ config PINCTRL_TB10X
>  	depends on OF && ARC_PLAT_TB10X
>  	select GPIOLIB
>  
> +config PINCTRL_TPS6594
> +	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
> +	depends on MFD_TPS6594
> +	default MFD_TPS6594
> +	select PINMUX
> +	select GPIOLIB
> +	select REGMAP
> +	select GPIO_REGMAP
> +	help
> +	  Say Y to select the pinmuxing and GPIOs driver for the TPS6594
> +	  PMICs chip family.
> +
> +	  This driver can also be built as a module
> +	  called tps6594-pinctrl.
> +
>  config PINCTRL_ZYNQ
>  	bool "Pinctrl driver for Xilinx Zynq"
>  	depends on ARCH_ZYNQ
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e196c6e324ad..28271a8d5275 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
>  obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
>  obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
>  obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
> +obj-$(CONFIG_PINCTRL_TPS6594)	+= pinctrl-tps6594.o
>  obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
>  
> diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
> new file mode 100644
> index 000000000000..a1fcb9fd793b
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-tps6594.c
> @@ -0,0 +1,368 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Pinmux and GPIO driver for tps6594 PMIC
> + *
> + * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
> + */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/tps6594.h>
> +
> +#define TPS6594_PINCTRL_PINS_NB 11
> +
> +#define TPS6594_PINCTRL_GPIO_FUNCTION 0
> +#define TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION 1
> +#define TPS6594_PINCTRL_TRIG_WDOG_FUNCTION 1
> +#define TPS6594_PINCTRL_CLK32KOUT_FUNCTION 1
> +#define TPS6594_PINCTRL_SCLK_SPMI_FUNCTION 1
> +#define TPS6594_PINCTRL_SDATA_SPMI_FUNCTION 1
> +#define TPS6594_PINCTRL_NERR_MCU_FUNCTION 1
> +#define TPS6594_PINCTRL_PDOG_FUNCTION 1
> +#define TPS6594_PINCTRL_SYNCCLKIN_FUNCTION 1
> +#define TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION 2
> +#define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION 2
> +#define TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION 2
> +#define TPS6594_PINCTRL_NERR_SOC_FUNCTION 2
> +#define TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION 3
> +#define TPS6594_PINCTRL_NSLEEP1_FUNCTION 4
> +#define TPS6594_PINCTRL_NSLEEP2_FUNCTION 5
> +#define TPS6594_PINCTRL_WKUP1_FUNCTION 6
> +#define TPS6594_PINCTRL_WKUP2_FUNCTION 7
> +
> +/* Special muxval for recalcitrant pins */
> +#define TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_GPIO8 2
> +#define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8 3
> +#define TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9 3
> +
> +#define TPS6594_OFFSET_GPIO_SEL 5
> +
> +#define FUNCTION(fname, v)									\
> +	{											\
> +		.pinfunction = PINCTRL_PINFUNCTION(#fname,					\
> +						tps6594_##fname##_func_group_names,		\
> +						ARRAY_SIZE(tps6594_##fname##_func_group_names)),\
> +		.muxval = v,									\
> +	}
> +
> +static const struct pinctrl_pin_desc tps6594_pins[TPS6594_PINCTRL_PINS_NB] = {
> +	PINCTRL_PIN(0, "GPIO0"),   PINCTRL_PIN(1, "GPIO1"),
> +	PINCTRL_PIN(2, "GPIO2"),   PINCTRL_PIN(3, "GPIO3"),
> +	PINCTRL_PIN(4, "GPIO4"),   PINCTRL_PIN(5, "GPIO5"),
> +	PINCTRL_PIN(6, "GPIO6"),   PINCTRL_PIN(7, "GPIO7"),
> +	PINCTRL_PIN(8, "GPIO8"),   PINCTRL_PIN(9, "GPIO9"),
> +	PINCTRL_PIN(10, "GPIO10"),
> +};
> +
> +static const char *const tps6594_gpio_func_group_names[] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
> +};
> +
> +static const char *const tps6594_nsleep1_func_group_names[] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
> +};
> +
> +static const char *const tps6594_nsleep2_func_group_names[] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
> +};
> +
> +static const char *const tps6594_wkup1_func_group_names[] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
> +};
> +
> +static const char *const tps6594_wkup2_func_group_names[] = {
> +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
> +	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
> +};
> +
> +static const char *const tps6594_scl_i2c2_cs_spi_func_group_names[] = {
> +	"GPIO0",
> +	"GPIO1",
> +};
> +
> +static const char *const tps6594_nrstout_soc_func_group_names[] = {
> +	"GPIO0",
> +	"GPIO10",
> +};
> +
> +static const char *const tps6594_trig_wdog_func_group_names[] = {
> +	"GPIO1",
> +	"GPIO10",
> +};
> +
> +static const char *const tps6594_sda_i2c2_sdo_spi_func_group_names[] = {
> +	"GPIO1",
> +};
> +
> +static const char *const tps6594_clk32kout_func_group_names[] = {
> +	"GPIO2",
> +	"GPIO3",
> +	"GPIO7",
> +};
> +
> +static const char *const tps6594_nerr_soc_func_group_names[] = {
> +	"GPIO2",
> +};
> +
> +static const char *const tps6594_sclk_spmi_func_group_names[] = {
> +	"GPIO4",
> +};
> +
> +static const char *const tps6594_sdata_spmi_func_group_names[] = {
> +	"GPIO5",
> +};
> +
> +static const char *const tps6594_nerr_mcu_func_group_names[] = {
> +	"GPIO6",
> +};
> +
> +static const char *const tps6594_syncclkout_func_group_names[] = {
> +	"GPIO7",
> +	"GPIO9",
> +};
> +
> +static const char *const tps6594_disable_wdog_func_group_names[] = {
> +	"GPIO7",
> +	"GPIO8",
> +};
> +
> +static const char *const tps6594_pdog_func_group_names[] = {
> +	"GPIO8",
> +};
> +
> +static const char *const tps6594_syncclkin_func_group_names[] = {
> +	"GPIO9",
> +};
> +
> +struct tps6594_pinctrl_function {
> +	struct pinfunction pinfunction;
> +	u8 muxval;
> +};
> +
> +static const struct tps6594_pinctrl_function pinctrl_functions[] = {
> +	FUNCTION(gpio, TPS6594_PINCTRL_GPIO_FUNCTION),
> +	FUNCTION(nsleep1, TPS6594_PINCTRL_NSLEEP1_FUNCTION),
> +	FUNCTION(nsleep2, TPS6594_PINCTRL_NSLEEP2_FUNCTION),
> +	FUNCTION(wkup1, TPS6594_PINCTRL_WKUP1_FUNCTION),
> +	FUNCTION(wkup2, TPS6594_PINCTRL_WKUP2_FUNCTION),
> +	FUNCTION(scl_i2c2_cs_spi, TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION),
> +	FUNCTION(nrstout_soc, TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION),
> +	FUNCTION(trig_wdog, TPS6594_PINCTRL_TRIG_WDOG_FUNCTION),
> +	FUNCTION(sda_i2c2_sdo_spi, TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION),
> +	FUNCTION(clk32kout, TPS6594_PINCTRL_CLK32KOUT_FUNCTION),
> +	FUNCTION(nerr_soc, TPS6594_PINCTRL_NERR_SOC_FUNCTION),
> +	FUNCTION(sclk_spmi, TPS6594_PINCTRL_SCLK_SPMI_FUNCTION),
> +	FUNCTION(sdata_spmi, TPS6594_PINCTRL_SDATA_SPMI_FUNCTION),
> +	FUNCTION(nerr_mcu, TPS6594_PINCTRL_NERR_MCU_FUNCTION),
> +	FUNCTION(syncclkout, TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION),
> +	FUNCTION(disable_wdog, TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION),
> +	FUNCTION(pdog, TPS6594_PINCTRL_PDOG_FUNCTION),
> +	FUNCTION(syncclkin, TPS6594_PINCTRL_SYNCCLKIN_FUNCTION),
> +};
> +
> +struct tps6594_pinctrl {
> +	struct tps6594 *tps;
> +	struct gpio_regmap *gpio_regmap;
> +	struct pinctrl_dev *pctl_dev;
> +	const struct tps6594_pinctrl_function *funcs;
> +	const struct pinctrl_pin_desc *pins;
> +};
> +
> +static int tps6594_gpio_regmap_xlate(struct gpio_regmap *gpio,
> +				     unsigned int base, unsigned int offset,
> +				     unsigned int *reg, unsigned int *mask)
> +{
> +	unsigned int line = offset % 8;
> +	unsigned int stride = offset / 8;
> +
> +	switch (base) {
> +	case TPS6594_REG_GPIOX_CONF(0):
> +		*reg = TPS6594_REG_GPIOX_CONF(offset);
> +		*mask = TPS6594_BIT_GPIO_DIR;
> +		return 0;
> +	case TPS6594_REG_GPIO_IN_1:
> +	case TPS6594_REG_GPIO_OUT_1:
> +		*reg = base + stride;
> +		*mask = BIT(line);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tps6594_pmx_func_cnt(struct pinctrl_dev *pctldev)
> +{
> +	return ARRAY_SIZE(pinctrl_functions);
> +}
> +
> +static const char *tps6594_pmx_func_name(struct pinctrl_dev *pctldev,
> +					 unsigned int selector)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl->funcs[selector].pinfunction.name;
> +}
> +
> +static int tps6594_pmx_func_groups(struct pinctrl_dev *pctldev,
> +				   unsigned int selector,
> +				   const char *const **groups,
> +				   unsigned int *num_groups)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	*groups = pinctrl->funcs[selector].pinfunction.groups;
> +	*num_groups = pinctrl->funcs[selector].pinfunction.ngroups;
> +
> +	return 0;
> +}
> +
> +static int tps6594_pmx_set(struct tps6594_pinctrl *pinctrl, unsigned int pin,
> +			   u8 muxval)
> +{
> +	u8 mux_sel_val = muxval << TPS6594_OFFSET_GPIO_SEL;
> +
> +	return regmap_update_bits(pinctrl->tps->regmap,
> +				  TPS6594_REG_GPIOX_CONF(pin),
> +				  TPS6594_MASK_GPIO_SEL, mux_sel_val);
> +}
> +
> +static int tps6594_pmx_set_mux(struct pinctrl_dev *pctldev,
> +			       unsigned int function, unsigned int group)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +	u8 muxval = pinctrl->funcs[function].muxval;
> +
> +	/* Some pins don't have the same muxval for the same function... */
> +	if (group == 8) {
> +		if (muxval == TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION)
> +			muxval = TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_GPIO8;
> +		else if (muxval == TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION)
> +			muxval = TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8;
> +	} else if (group == 9) {
> +		if (muxval == TPS6594_PINCTRL_CLK32KOUT_FUNCTION)
> +			muxval = TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9;
> +	}
> +
> +	return tps6594_pmx_set(pinctrl, group, muxval);
> +}
> +
> +static int tps6594_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> +					  struct pinctrl_gpio_range *range,
> +					  unsigned int offset, bool input)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +	u8 muxval = pinctrl->funcs[TPS6594_PINCTRL_GPIO_FUNCTION].muxval;
> +
> +	return tps6594_pmx_set(pinctrl, offset, muxval);
> +}
> +
> +static const struct pinmux_ops tps6594_pmx_ops = {
> +	.get_functions_count = tps6594_pmx_func_cnt,
> +	.get_function_name = tps6594_pmx_func_name,
> +	.get_function_groups = tps6594_pmx_func_groups,
> +	.set_mux = tps6594_pmx_set_mux,
> +	.gpio_set_direction = tps6594_pmx_gpio_set_direction,
> +	.strict = true,
> +};
> +
> +static int tps6594_groups_cnt(struct pinctrl_dev *pctldev)
> +{
> +	return ARRAY_SIZE(tps6594_pins);
> +}
> +
> +static int tps6594_group_pins(struct pinctrl_dev *pctldev,
> +			      unsigned int selector, const unsigned int **pins,
> +			      unsigned int *num_pins)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	*pins = &pinctrl->pins[selector].number;
> +	*num_pins = 1;
> +
> +	return 0;
> +}
> +
> +static const char *tps6594_group_name(struct pinctrl_dev *pctldev,
> +				      unsigned int selector)
> +{
> +	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return pinctrl->pins[selector].name;
> +}
> +
> +static const struct pinctrl_ops tps6594_pctrl_ops = {
> +	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
> +	.dt_free_map = pinconf_generic_dt_free_map,
> +	.get_groups_count = tps6594_groups_cnt,
> +	.get_group_name = tps6594_group_name,
> +	.get_group_pins = tps6594_group_pins,
> +};
> +
> +static int tps6594_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct tps6594_pinctrl *pinctrl;
> +	struct pinctrl_desc *pctrl_desc;
> +	struct gpio_regmap_config config = {};
> +
> +	pctrl_desc = devm_kzalloc(dev, sizeof(*pctrl_desc), GFP_KERNEL);
> +	if (!pctrl_desc)
> +		return -ENOMEM;
> +	pctrl_desc->name = dev_name(dev);
> +	pctrl_desc->owner = THIS_MODULE;
> +	pctrl_desc->pins = tps6594_pins;
> +	pctrl_desc->npins = ARRAY_SIZE(tps6594_pins);
> +	pctrl_desc->pctlops = &tps6594_pctrl_ops;
> +	pctrl_desc->pmxops = &tps6594_pmx_ops;
> +
> +	pinctrl = devm_kzalloc(dev, sizeof(*pinctrl), GFP_KERNEL);
> +	if (!pinctrl)
> +		return -ENOMEM;
> +	pinctrl->tps = dev_get_drvdata(dev->parent);
> +	pinctrl->funcs = pinctrl_functions;
> +	pinctrl->pins = tps6594_pins;
> +	pinctrl->pctl_dev = devm_pinctrl_register(dev, pctrl_desc, pinctrl);
> +	if (IS_ERR(pinctrl->pctl_dev))
> +		return dev_err_probe(dev, PTR_ERR(pinctrl->pctl_dev),
> +				     "Couldn't register pinctrl driver\n");
> +
> +	config.parent = tps->dev;
> +	config.regmap = tps->regmap;
> +	config.ngpio = TPS6594_PINCTRL_PINS_NB;
> +	config.ngpio_per_reg = 8;
> +	config.reg_dat_base = TPS6594_REG_GPIO_IN_1;
> +	config.reg_set_base = TPS6594_REG_GPIO_OUT_1;
> +	config.reg_dir_out_base = TPS6594_REG_GPIOX_CONF(0);
> +	config.reg_mask_xlate = tps6594_gpio_regmap_xlate;
> +
> +	pinctrl->gpio_regmap = devm_gpio_regmap_register(dev, &config);
> +	if (IS_ERR(pinctrl->gpio_regmap))
> +		return dev_err_probe(dev, PTR_ERR(pinctrl->gpio_regmap),
> +				     "Couldn't register gpio_regmap driver\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tps6594_pinctrl_driver = {
> +	.probe = tps6594_pinctrl_probe,
> +	.driver = {
> +		.name = "tps6594-pinctrl",
> +	},
> +};
> +module_platform_driver(tps6594_pinctrl_driver);
> +
> +MODULE_ALIAS("platform:tps6594-pinctrl");
> +MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
> +MODULE_DESCRIPTION("TPS6594 pinctrl and GPIO driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/tps6594.h b/include/linux/mfd/tps6594.h
> index 3f7c5e23cd4c..55a5701e6f7f 100644
> --- a/include/linux/mfd/tps6594.h
> +++ b/include/linux/mfd/tps6594.h
> @@ -47,6 +47,7 @@ enum pmic_id {
>  #define TPS6594_REG_VMON2_PG_WINDOW			0x2f
>  #define TPS6594_REG_VMON2_PG_LEVEL			0x30
>  
> +// Used to compute the register address of GPIO1_CONF to GPIO11_CONF

No C++ style comments please.

Also, this doesn't need to be part of this patch.

>  #define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
>  #define TPS6594_REG_NPWRON_CONF				0x3c
>  #define TPS6594_REG_GPIO_OUT_1				0x3d
> -- 
> 2.40.1
> 

-- 
Lee Jones [李琼斯]
