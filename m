Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0BF67EF4B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjA0UIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjA0UHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:49 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4E8A6B;
        Fri, 27 Jan 2023 12:06:25 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 931D8FF805;
        Fri, 27 Jan 2023 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674849983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WRP+JrmaRRFZ3Q83wuVddFpg2GlHtoPDec8hQerXooU=;
        b=N29dUbF5hwd6sarxngs68X0iIs7Rhnwgf+56JowXMesCdVXT5oE8e8APql+myBWEZNAUdX
        qBK0vpVD351iMawLCdUeYJuvqwfFAPFD4QtOH8miXT13n+cwtQSAbj6R7rtOzlAlnJATKM
        9eAPdwxOrM4PbKQBpxd4SM6Ifhs3eoX0TeShYIkvscoaxs/SXZXscV1Vg2Xc/b6RTAI/x1
        s+l5UnsILc8Y3cOXVVLValqRMxqShHwQTbSIOh7oEmsQYOOp/YZv/AEWeiPrRfPWOC5ktL
        tpZGTbShGzuPglbWHU0yyyGR2M3nsobBRjsbI1pOKPV9IVbZHzzioE4C+iwK2Q==
Date:   Fri, 27 Jan 2023 21:06:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 05/11] mfd: rk808: split into core and i2c
Message-ID: <Y9QuvrKfSVPi3dvB@mail.local>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-6-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127181244.160887-6-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 19:12:38+0100, Sebastian Reichel wrote:
> Split rk808 into a core and an i2c part in preperation for
> SPI support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

For the RTC part:
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/Kconfig                   |   2 +-
>  drivers/input/misc/Kconfig            |   2 +-
>  drivers/mfd/Kconfig                   |   7 +-
>  drivers/mfd/Makefile                  |   3 +-
>  drivers/mfd/{rk808.c => rk8xx-core.c} | 209 +++++---------------------
>  drivers/mfd/rk8xx-i2c.c               | 200 ++++++++++++++++++++++++
>  drivers/pinctrl/Kconfig               |   2 +-
>  drivers/power/supply/Kconfig          |   2 +-
>  drivers/regulator/Kconfig             |   2 +-
>  drivers/rtc/Kconfig                   |   2 +-
>  include/linux/mfd/rk808.h             |   6 +
>  sound/soc/codecs/Kconfig              |   2 +-
>  12 files changed, 256 insertions(+), 183 deletions(-)
>  rename drivers/mfd/{rk808.c => rk8xx-core.c} (76%)
>  create mode 100644 drivers/mfd/rk8xx-i2c.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index d79905f3e174..8448d616b9aa 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -83,7 +83,7 @@ config COMMON_CLK_MAX9485
>  
>  config COMMON_CLK_RK808
>  	tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  This driver supports RK805, RK809 and RK817, RK808 and RK818 crystal oscillator clock.
>  	  These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 5c2d0c06d2a5..6a6978fc68fa 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -598,7 +598,7 @@ config INPUT_PWM_VIBRA
>  
>  config INPUT_RK805_PWRKEY
>  	tristate "Rockchip RK805 PMIC power key support"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  Select this option to enable power key driver for RK805.
>  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 30db49f31866..692e38283bda 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1204,12 +1204,17 @@ config MFD_RC5T583
>  	  Additional drivers must be enabled in order to use the
>  	  different functionality of the device.
>  
> -config MFD_RK808
> +config MFD_RK8XX
> +	bool
> +	select MFD_CORE
> +
> +config MFD_RK8XX_I2C
>  	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power Management Chip"
>  	depends on I2C && OF
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> +	select MFD_RK8XX
>  	help
>  	  If you say yes here you get support for the RK805, RK808, RK809,
>  	  RK817 and RK818 Power Management chips.
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 457471478a93..f65ef1bd0810 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -220,7 +220,8 @@ obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> -obj-$(CONFIG_MFD_RK808)		+= rk808.o
> +obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
> +obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk8xx-core.c
> similarity index 76%
> rename from drivers/mfd/rk808.c
> rename to drivers/mfd/rk8xx-core.c
> index 695a3fe6b9e0..c52f5fa1a4da 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -1,18 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * MFD core driver for Rockchip RK808/RK818
> + * MFD core driver for Rockchip RK8XX
>   *
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
>   *
>   * Author: Chris Zhong <zyw@rock-chips.com>
>   * Author: Zhang Qing <zhangqing@rock-chips.com>
> - *
> - * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> - *
>   * Author: Wadim Egorov <w.egorov@phytec.de>
>   */
>  
> -#include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/rk808.h>
>  #include <linux/mfd/core.h>
> @@ -27,92 +24,6 @@ struct rk808_reg_data {
>  	int value;
>  };
>  
> -static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
> -{
> -	/*
> -	 * Notes:
> -	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
> -	 *   we don't use that feature.  It's better to cache.
> -	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
> -	 *   bits are cleared in case when we shutoff anyway, but better safe.
> -	 */
> -
> -	switch (reg) {
> -	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
> -	case RK808_RTC_STATUS_REG:
> -	case RK808_VB_MON_REG:
> -	case RK808_THERMAL_REG:
> -	case RK808_DCDC_UV_STS_REG:
> -	case RK808_LDO_UV_STS_REG:
> -	case RK808_DCDC_PG_REG:
> -	case RK808_LDO_PG_REG:
> -	case RK808_DEVCTRL_REG:
> -	case RK808_INT_STS_REG1:
> -	case RK808_INT_STS_REG2:
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
> -{
> -	/*
> -	 * Notes:
> -	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
> -	 *   we don't use that feature.  It's better to cache.
> -	 */
> -
> -	switch (reg) {
> -	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
> -	case RK817_RTC_STATUS_REG:
> -	case RK817_CODEC_DTOP_LPT_SRST:
> -	case RK817_GAS_GAUGE_ADC_CONFIG0 ... RK817_GAS_GAUGE_CUR_ADC_K0:
> -	case RK817_PMIC_CHRG_STS:
> -	case RK817_PMIC_CHRG_OUT:
> -	case RK817_PMIC_CHRG_IN:
> -	case RK817_INT_STS_REG0:
> -	case RK817_INT_STS_REG1:
> -	case RK817_INT_STS_REG2:
> -	case RK817_SYS_STS:
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static const struct regmap_config rk818_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -	.max_register = RK818_USB_CTRL_REG,
> -	.cache_type = REGCACHE_RBTREE,
> -	.volatile_reg = rk808_is_volatile_reg,
> -};
> -
> -static const struct regmap_config rk805_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -	.max_register = RK805_OFF_SOURCE_REG,
> -	.cache_type = REGCACHE_RBTREE,
> -	.volatile_reg = rk808_is_volatile_reg,
> -};
> -
> -static const struct regmap_config rk808_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -	.max_register = RK808_IO_POL_REG,
> -	.cache_type = REGCACHE_RBTREE,
> -	.volatile_reg = rk808_is_volatile_reg,
> -};
> -
> -static const struct regmap_config rk817_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -	.max_register = RK817_GPIO_INT_CFG,
> -	.cache_type = REGCACHE_NONE,
> -	.volatile_reg = rk817_is_volatile_reg,
> -};
> -
>  static const struct resource rtc_resources[] = {
>  	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
>  };
> @@ -604,9 +515,9 @@ static int rk808_restart(struct sys_off_data *data)
>  	return NOTIFY_DONE;
>  }
>  
> -static void rk8xx_shutdown(struct i2c_client *client)
> +void rk8xx_shutdown(struct device *dev)
>  {
> -	struct rk808 *rk808 = i2c_get_clientdata(client);
> +	struct rk808 *rk808 = dev_get_drvdata(dev);
>  	int ret;
>  
>  	switch (rk808->variant) {
> @@ -627,61 +538,31 @@ static void rk8xx_shutdown(struct i2c_client *client)
>  		return;
>  	}
>  	if (ret)
> -		dev_warn(&client->dev,
> +		dev_warn(dev,
>  			 "Cannot switch to power down function\n");
>  }
> +EXPORT_SYMBOL_GPL(rk8xx_shutdown);
>  
> -static const struct of_device_id rk808_of_match[] = {
> -	{ .compatible = "rockchip,rk805" },
> -	{ .compatible = "rockchip,rk808" },
> -	{ .compatible = "rockchip,rk809" },
> -	{ .compatible = "rockchip,rk817" },
> -	{ .compatible = "rockchip,rk818" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, rk808_of_match);
> -
> -static int rk808_probe(struct i2c_client *client)
> +int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap)
>  {
> -	struct device_node *np = client->dev.of_node;
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
>  	const struct mfd_cell *cells;
>  	int nr_pre_init_regs;
>  	int nr_cells;
> -	int msb, lsb;
> -	unsigned char pmic_id_msb, pmic_id_lsb;
>  	int ret;
>  	int i;
>  
> -	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
> +	rk808 = devm_kzalloc(dev, sizeof(*rk808), GFP_KERNEL);
>  	if (!rk808)
>  		return -ENOMEM;
> -
> -	if (of_device_is_compatible(np, "rockchip,rk817") ||
> -	    of_device_is_compatible(np, "rockchip,rk809")) {
> -		pmic_id_msb = RK817_ID_MSB;
> -		pmic_id_lsb = RK817_ID_LSB;
> -	} else {
> -		pmic_id_msb = RK808_ID_MSB;
> -		pmic_id_lsb = RK808_ID_LSB;
> -	}
> -
> -	/* Read chip variant */
> -	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
> -	if (msb < 0)
> -		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
> -
> -	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
> -	if (lsb < 0)
> -		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
> -
> -	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
> -	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
> +	rk808->dev = dev;
> +	rk808->variant = variant;
> +	rk808->regmap = regmap;
> +	dev_set_drvdata(dev, rk808);
>  
>  	switch (rk808->variant) {
>  	case RK805_ID:
> -		rk808->regmap_cfg = &rk805_regmap_config;
>  		rk808->regmap_irq_chip = &rk805_irq_chip;
>  		pre_init_reg = rk805_pre_init_reg;
>  		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
> @@ -689,7 +570,6 @@ static int rk808_probe(struct i2c_client *client)
>  		nr_cells = ARRAY_SIZE(rk805s);
>  		break;
>  	case RK808_ID:
> -		rk808->regmap_cfg = &rk808_regmap_config;
>  		rk808->regmap_irq_chip = &rk808_irq_chip;
>  		pre_init_reg = rk808_pre_init_reg;
>  		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
> @@ -697,7 +577,6 @@ static int rk808_probe(struct i2c_client *client)
>  		nr_cells = ARRAY_SIZE(rk808s);
>  		break;
>  	case RK818_ID:
> -		rk808->regmap_cfg = &rk818_regmap_config;
>  		rk808->regmap_irq_chip = &rk818_irq_chip;
>  		pre_init_reg = rk818_pre_init_reg;
>  		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
> @@ -706,7 +585,6 @@ static int rk808_probe(struct i2c_client *client)
>  		break;
>  	case RK809_ID:
>  	case RK817_ID:
> -		rk808->regmap_cfg = &rk817_regmap_config;
>  		rk808->regmap_irq_chip = &rk817_irq_chip;
>  		pre_init_reg = rk817_pre_init_reg;
>  		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
> @@ -714,27 +592,20 @@ static int rk808_probe(struct i2c_client *client)
>  		nr_cells = ARRAY_SIZE(rk817s);
>  		break;
>  	default:
> -		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
> -			rk808->variant);
> +		dev_err(dev, "Unsupported RK8XX ID %lu\n", rk808->variant);
>  		return -EINVAL;
>  	}
>  
> -	rk808->dev = &client->dev;
> -	i2c_set_clientdata(client, rk808);
> -
> -	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
> -	if (IS_ERR(rk808->regmap))
> -		return dev_err_probe(&client->dev, PTR_ERR(rk808->regmap),
> -				     "regmap initialization failed\n");
> +	dev_info(dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
>  
> -	if (!client->irq)
> -		return dev_err_probe(&client->dev, -EINVAL, "No interrupt support, no core IRQ\n");
> +	if (!irq)
> +		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
>  
> -	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
> +	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
>  				       IRQF_ONESHOT, -1,
>  				       rk808->regmap_irq_chip, &rk808->irq_data);
>  	if (ret)
> -		return dev_err_probe(&client->dev, ret, "Failed to add irq_chip\n");
> +		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
>  
>  	for (i = 0; i < nr_pre_init_regs; i++) {
>  		ret = regmap_update_bits(rk808->regmap,
> @@ -742,45 +613,46 @@ static int rk808_probe(struct i2c_client *client)
>  					pre_init_reg[i].mask,
>  					pre_init_reg[i].value);
>  		if (ret)
> -			return dev_err_probe(&client->dev, ret, "0x%x write err\n",
> +			return dev_err_probe(dev, ret, "0x%x write err\n",
>  					     pre_init_reg[i].addr);
>  	}
>  
> -	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>  			      cells, nr_cells, NULL, 0,
>  			      regmap_irq_get_domain(rk808->irq_data));
>  	if (ret)
> -		return dev_err_probe(&client->dev, ret, "failed to add MFD devices\n");
> +		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
>  
> -	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
> -		ret = devm_register_sys_off_handler(&client->dev,
> +	if (device_property_read_bool(dev, "rockchip,system-power-controller")) {
> +		ret = devm_register_sys_off_handler(dev,
>  				    SYS_OFF_MODE_POWER_OFF_PREPARE, SYS_OFF_PRIO_HIGH,
>  				    &rk808_power_off, rk808);
>  		if (ret)
> -			return dev_err_probe(&client->dev, ret,
> +			return dev_err_probe(dev, ret,
>  					     "failed to register poweroff handler\n");
>  
>  		switch (rk808->variant) {
>  		case RK809_ID:
>  		case RK817_ID:
> -			ret = devm_register_sys_off_handler(&client->dev,
> +			ret = devm_register_sys_off_handler(dev,
>  							    SYS_OFF_MODE_RESTART, SYS_OFF_PRIO_HIGH,
>  							    &rk808_restart, rk808);
>  			if (ret)
> -				dev_warn(&client->dev, "failed to register rst handler, %d\n", ret);
> +				dev_warn(dev, "failed to register rst handler, %d\n", ret);
>  			break;
>  		default:
> -			dev_dbg(&client->dev, "pmic controlled board reset not supported\n");
> +			dev_dbg(dev, "pmic controlled board reset not supported\n");
>  			break;
>  		}
>  	}
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(rk8xx_probe);
>  
> -static int __maybe_unused rk8xx_suspend(struct device *dev)
> +int rk8xx_suspend(struct device *dev)
>  {
> -	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
> +	struct rk808 *rk808 = dev_get_drvdata(dev);
>  	int ret = 0;
>  
>  	switch (rk808->variant) {
> @@ -803,10 +675,11 @@ static int __maybe_unused rk8xx_suspend(struct device *dev)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(rk8xx_suspend);
>  
> -static int __maybe_unused rk8xx_resume(struct device *dev)
> +int rk8xx_resume(struct device *dev)
>  {
> -	struct rk808 *rk808 = i2c_get_clientdata(to_i2c_client(dev));
> +	struct rk808 *rk808 = dev_get_drvdata(dev);
>  	int ret = 0;
>  
>  	switch (rk808->variant) {
> @@ -823,22 +696,10 @@ static int __maybe_unused rk8xx_resume(struct device *dev)
>  
>  	return ret;
>  }
> -static SIMPLE_DEV_PM_OPS(rk8xx_pm_ops, rk8xx_suspend, rk8xx_resume);
> -
> -static struct i2c_driver rk808_i2c_driver = {
> -	.driver = {
> -		.name = "rk808",
> -		.of_match_table = rk808_of_match,
> -		.pm = &rk8xx_pm_ops,
> -	},
> -	.probe_new = rk808_probe,
> -	.shutdown = rk8xx_shutdown,
> -};
> -
> -module_i2c_driver(rk808_i2c_driver);
> +EXPORT_SYMBOL_GPL(rk8xx_resume);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>  MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
>  MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
> -MODULE_DESCRIPTION("RK808/RK818 PMIC driver");
> +MODULE_DESCRIPTION("RK8xx PMIC core");
> diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
> new file mode 100644
> index 000000000000..6d121b589fec
> --- /dev/null
> +++ b/drivers/mfd/rk8xx-i2c.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Rockchip RK808/RK818 Core (I2C) driver
> + *
> + * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
> + *
> + * Author: Chris Zhong <zyw@rock-chips.com>
> + * Author: Zhang Qing <zhangqing@rock-chips.com>
> + * Author: Wadim Egorov <w.egorov@phytec.de>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mfd/rk808.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * Notes:
> +	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
> +	 *   we don't use that feature.  It's better to cache.
> +	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
> +	 *   bits are cleared in case when we shutoff anyway, but better safe.
> +	 */
> +
> +	switch (reg) {
> +	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
> +	case RK808_RTC_STATUS_REG:
> +	case RK808_VB_MON_REG:
> +	case RK808_THERMAL_REG:
> +	case RK808_DCDC_UV_STS_REG:
> +	case RK808_LDO_UV_STS_REG:
> +	case RK808_DCDC_PG_REG:
> +	case RK808_LDO_PG_REG:
> +	case RK808_DEVCTRL_REG:
> +	case RK808_INT_STS_REG1:
> +	case RK808_INT_STS_REG2:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool rk817_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * Notes:
> +	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
> +	 *   we don't use that feature.  It's better to cache.
> +	 */
> +
> +	switch (reg) {
> +	case RK817_SECONDS_REG ... RK817_WEEKS_REG:
> +	case RK817_RTC_STATUS_REG:
> +	case RK817_CODEC_DTOP_LPT_SRST:
> +	case RK817_GAS_GAUGE_ADC_CONFIG0 ... RK817_GAS_GAUGE_CUR_ADC_K0:
> +	case RK817_PMIC_CHRG_STS:
> +	case RK817_PMIC_CHRG_OUT:
> +	case RK817_PMIC_CHRG_IN:
> +	case RK817_INT_STS_REG0:
> +	case RK817_INT_STS_REG1:
> +	case RK817_INT_STS_REG2:
> +	case RK817_SYS_STS:
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +
> +static const struct regmap_config rk818_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RK818_USB_CTRL_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = rk808_is_volatile_reg,
> +};
> +
> +static const struct regmap_config rk805_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RK805_OFF_SOURCE_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = rk808_is_volatile_reg,
> +};
> +
> +static const struct regmap_config rk808_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RK808_IO_POL_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = rk808_is_volatile_reg,
> +};
> +
> +static const struct regmap_config rk817_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RK817_GPIO_INT_CFG,
> +	.cache_type = REGCACHE_NONE,
> +	.volatile_reg = rk817_is_volatile_reg,
> +};
> +
> +static int rk8xx_i2c_get_variant(struct i2c_client *client)
> +{
> +	u8 pmic_id_msb, pmic_id_lsb;
> +	int msb, lsb;
> +
> +	if (of_device_is_compatible(client->dev.of_node, "rockchip,rk817") ||
> +	    of_device_is_compatible(client->dev.of_node, "rockchip,rk809")) {
> +		pmic_id_msb = RK817_ID_MSB;
> +		pmic_id_lsb = RK817_ID_LSB;
> +	} else {
> +		pmic_id_msb = RK808_ID_MSB;
> +		pmic_id_lsb = RK808_ID_LSB;
> +	}
> +
> +	/* Read chip variant */
> +	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
> +	if (msb < 0)
> +		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
> +
> +	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
> +	if (lsb < 0)
> +		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
> +
> +	return ((msb << 8) | lsb) & RK8XX_ID_MSK;
> +}
> +
> +static int rk8xx_i2c_probe(struct i2c_client *client)
> +{
> +	const struct regmap_config *regmap_cfg;
> +	struct regmap *regmap;
> +	int variant;
> +
> +	variant = rk8xx_i2c_get_variant(client);
> +	if (variant < 0)
> +		return variant;
> +
> +	switch (variant) {
> +	case RK805_ID:
> +		regmap_cfg = &rk805_regmap_config;
> +		break;
> +	case RK808_ID:
> +		regmap_cfg = &rk808_regmap_config;
> +		break;
> +	case RK818_ID:
> +		regmap_cfg = &rk818_regmap_config;
> +		break;
> +	case RK809_ID:
> +	case RK817_ID:
> +		regmap_cfg = &rk817_regmap_config;
> +		break;
> +	default:
> +		return dev_err_probe(&client->dev, -EINVAL, "Unsupported RK8XX ID %x\n", variant);
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, regmap_cfg);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	return rk8xx_probe(&client->dev, variant, client->irq, regmap);
> +}
> +
> +static void rk8xx_i2c_shutdown(struct i2c_client *client)
> +{
> +	rk8xx_shutdown(&client->dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_suspend, rk8xx_resume);
> +
> +static const struct of_device_id rk8xx_i2c_of_match[] = {
> +	{ .compatible = "rockchip,rk805" },
> +	{ .compatible = "rockchip,rk808" },
> +	{ .compatible = "rockchip,rk809" },
> +	{ .compatible = "rockchip,rk817" },
> +	{ .compatible = "rockchip,rk818" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rk8xx_i2c_of_match);
> +
> +static struct i2c_driver rk8xx_i2c_driver = {
> +	.driver = {
> +		.name = "rk8xx-i2c",
> +		.of_match_table = rk8xx_i2c_of_match,
> +		.pm = &rk8xx_i2c_pm_ops,
> +	},
> +	.probe_new = rk8xx_i2c_probe,
> +	.shutdown  = rk8xx_i2c_shutdown,
> +};
> +module_i2c_driver(rk8xx_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
> +MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
> +MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
> +MODULE_DESCRIPTION("RK8xx I2C PMIC driver");
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 7d5f5458c72e..b3cbce49a087 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -407,7 +407,7 @@ config PINCTRL_PISTACHIO
>  
>  config PINCTRL_RK805
>  	tristate "Pinctrl and GPIO driver for RK805 PMIC"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	select GPIOLIB
>  	select PINMUX
>  	select GENERIC_PINCONF
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 0bbfe6a7ce4d..306a9b1f897e 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -725,7 +725,7 @@ config CHARGER_BQ256XX
>  
>  config CHARGER_RK817
>  	tristate "Rockchip RK817 PMIC Battery Charger"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  Say Y to include support for Rockchip RK817 Battery Charger.
>  
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 820c9a0788e5..90e79ec5b021 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1048,7 +1048,7 @@ config REGULATOR_RC5T583
>  
>  config REGULATOR_RK808
>  	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 Power regulators"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  Select this option to enable the power regulator of ROCKCHIP
>  	  PMIC RK805,RK809&RK817,RK808 and RK818.
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 677d2601d305..313c14c4cb2d 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -395,7 +395,7 @@ config RTC_DRV_NCT3018Y
>  
>  config RTC_DRV_RK808
>  	tristate "Rockchip RK805/RK808/RK809/RK817/RK818 RTC"
> -	depends on MFD_RK808
> +	depends on MFD_RK8XX
>  	help
>  	  If you say yes here you will get support for the
>  	  RTC of RK805, RK809 and RK817, RK808 and RK818 PMIC.
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index a89ddd9ba68e..4183427a80fe 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -794,4 +794,10 @@ struct rk808 {
>  	const struct regmap_config	*regmap_cfg;
>  	const struct regmap_irq_chip	*regmap_irq_chip;
>  };
> +
> +void rk8xx_shutdown(struct device *dev);
> +int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap *regmap);
> +int rk8xx_suspend(struct device *dev);
> +int rk8xx_resume(struct device *dev);
> +
>  #endif /* __LINUX_REGULATOR_RK808_H */
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 0f9d71490075..7df9bb2c458f 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1211,7 +1211,7 @@ config SND_SOC_RK3328
>  
>  config SND_SOC_RK817
>  	tristate "Rockchip RK817 audio CODEC"
> -	depends on MFD_RK808 || COMPILE_TEST
> +	depends on MFD_RK8XX || COMPILE_TEST
>  
>  config SND_SOC_RL6231
>  	tristate
> -- 
> 2.39.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
