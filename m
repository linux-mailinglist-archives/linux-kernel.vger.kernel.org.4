Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F411675AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjATQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjATQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:59:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC353CA2C;
        Fri, 20 Jan 2023 08:59:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4023BB82953;
        Fri, 20 Jan 2023 16:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83736C4339C;
        Fri, 20 Jan 2023 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674233967;
        bh=WQ/q/RczwANdjXtTH/kGtMg9vJ6G+WZMRAnjtJd7h70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qyc7Sm6lceqiP+9bTsggaUlcPsZC36iCGyDeTbBKNL248w0jvE8K0TJ3u8yPQc/cc
         9DUZf0EH4zha5qQuEbYyAtQS6mdFkeZEZNpEomm1SvT8lWiiIIvXV7vIN9BIoOJdFW
         LCAJSG4t3mCiRkXnPg3DpuUMQQxWIxRLLLyie75op+RrfPm5/ChnNoPY3SZrkYQhEE
         5pFxdaK3L49901YPyeoNqLB5Uo1+tl4lIfTM33wAoGn9KeWO/Scm5aCA5q1GNda4qO
         92qzANAnETh9Y1j52oPySaTXOMeGIhMaNJiB5CsBJvgkody5mI/Edjc4HCgrhk/w1Z
         GX+8btMr+SmVQ==
Date:   Fri, 20 Jan 2023 16:59:21 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv5 07/10] mfd: rk8xx: add rk806 support
Message-ID: <Y8rIadiDIEdXuM0Y@google.com>
References: <20230109172723.60304-1-sebastian.reichel@collabora.com>
 <20230109172723.60304-8-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109172723.60304-8-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Sebastian Reichel wrote:

> Add support for SPI connected rk806, which is used by the RK3588
> evaluation boards. The PMIC is advertised to support I2C and SPI,
> but the evaluation boards all use SPI. Thus only SPI support is
> added here.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/Kconfig       |  14 ++
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rk8xx-core.c  |  67 ++++++-
>  drivers/mfd/rk8xx-spi.c   | 122 ++++++++++++
>  include/linux/mfd/rk808.h | 409 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 611 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mfd/rk8xx-spi.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 692e38283bda..13582ea5cb44 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1222,6 +1222,20 @@ config MFD_RK8XX_I2C
>  	  through I2C interface. The device supports multiple sub-devices
>  	  including interrupts, RTC, LDO & DCDC regulators, and onkey.
>  
> +config MFD_RK8XX_SPI
> +	tristate "Rockchip RK806 Power Management Chip"
> +	depends on SPI && OF
> +	select MFD_CORE
> +	select REGMAP_SPI
> +	select REGMAP_IRQ
> +	select MFD_RK8XX
> +	help
> +	  If you say yes here you get support for the RK806 Power Management
> +	  chip.
> +	  This driver provides common support for accessing the device
> +	  through an SPI interface. The device supports multiple sub-devices
> +	  including interrupts, LDO & DCDC regulators, and power on-key.
> +
>  config MFD_RN5T618
>  	tristate "Ricoh RN5T567/618 PMIC"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f65ef1bd0810..a88f27cd837b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -222,6 +222,7 @@ obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
>  obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
>  obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
> +obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
>  obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
>  obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
>  obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
> diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
> index c52f5fa1a4da..289f4c1f30c2 100644
> --- a/drivers/mfd/rk8xx-core.c
> +++ b/drivers/mfd/rk8xx-core.c
> @@ -37,6 +37,11 @@ static const struct resource rk805_key_resources[] = {
>  	DEFINE_RES_IRQ(RK805_IRQ_PWRON_FALL),
>  };
>  
> +static struct resource rk806_pwrkey_resources[] = {
> +	DEFINE_RES_IRQ(RK806_IRQ_PWRON_FALL),
> +	DEFINE_RES_IRQ(RK806_IRQ_PWRON_RISE),
> +};
> +
>  static const struct resource rk817_pwrkey_resources[] = {
>  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
>  	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
> @@ -64,6 +69,16 @@ static const struct mfd_cell rk805s[] = {
>  	},
>  };
>  
> +static const struct mfd_cell rk806s[] = {
> +	{ .name = "rk805-pinctrl", },
> +	{ .name = "rk808-regulator", },
> +	{
> +		.name = "rk805-pwrkey",
> +		.num_resources = ARRAY_SIZE(rk806_pwrkey_resources),
> +		.resources = &rk806_pwrkey_resources[0],

My OCD-sense is tingling.

Could you please add the resources *before* the num_resources please?

Also: '.resources = rk806_pwrkey_resources' is fine

> +	},
> +};
> +
>  static const struct mfd_cell rk808s[] = {
>  	{ .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
>  	{ .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
> @@ -122,6 +137,12 @@ static const struct rk808_reg_data rk805_pre_init_reg[] = {
>  	{RK805_THERMAL_REG, TEMP_HOTDIE_MSK, TEMP115C},
>  };
>  
> +static const struct rk808_reg_data rk806_pre_init_reg[] = {
> +	{ RK806_GPIO_INT_CONFIG, RK806_INT_POL_MSK, RK806_INT_POL_L },
> +	{ RK806_SYS_CFG3, RK806_SLAVE_RESTART_FUN_MSK, RK806_SLAVE_RESTART_FUN_EN },
> +	{ RK806_SYS_OPTION, RK806_SYS_ENB2_2M_MSK, RK806_SYS_ENB2_2M_EN },
> +};
> +
>  static const struct rk808_reg_data rk808_pre_init_reg[] = {
>  	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
>  	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
> @@ -272,6 +293,27 @@ static const struct regmap_irq rk805_irqs[] = {
>  	},
>  };
>  
> +static const struct regmap_irq rk806_irqs[] = {
> +	/* INT_STS0 IRQs */
> +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_FALL, 0, RK806_INT_STS_PWRON_FALL),
> +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_RISE, 0, RK806_INT_STS_PWRON_RISE),
> +	REGMAP_IRQ_REG(RK806_IRQ_PWRON, 0, RK806_INT_STS_PWRON),
> +	REGMAP_IRQ_REG(RK806_IRQ_PWRON_LP, 0, RK806_INT_STS_PWRON_LP),
> +	REGMAP_IRQ_REG(RK806_IRQ_HOTDIE, 0, RK806_INT_STS_HOTDIE),
> +	REGMAP_IRQ_REG(RK806_IRQ_VDC_RISE, 0, RK806_INT_STS_VDC_RISE),
> +	REGMAP_IRQ_REG(RK806_IRQ_VDC_FALL, 0, RK806_INT_STS_VDC_FALL),
> +	REGMAP_IRQ_REG(RK806_IRQ_VB_LO, 0, RK806_INT_STS_VB_LO),
> +	/* INT_STS1 IRQs */
> +	REGMAP_IRQ_REG(RK806_IRQ_REV0, 1, RK806_INT_STS_REV0),
> +	REGMAP_IRQ_REG(RK806_IRQ_REV1, 1, RK806_INT_STS_REV1),
> +	REGMAP_IRQ_REG(RK806_IRQ_REV2, 1, RK806_INT_STS_REV2),
> +	REGMAP_IRQ_REG(RK806_IRQ_CRC_ERROR, 1, RK806_INT_STS_CRC_ERROR),
> +	REGMAP_IRQ_REG(RK806_IRQ_SLP3_GPIO, 1, RK806_INT_STS_SLP3_GPIO),
> +	REGMAP_IRQ_REG(RK806_IRQ_SLP2_GPIO, 1, RK806_INT_STS_SLP2_GPIO),
> +	REGMAP_IRQ_REG(RK806_IRQ_SLP1_GPIO, 1, RK806_INT_STS_SLP1_GPIO),
> +	REGMAP_IRQ_REG(RK806_IRQ_WDT, 1, RK806_INT_STS_WDT),
> +};
> +
>  static const struct regmap_irq rk808_irqs[] = {
>  	/* INT_STS */
>  	[RK808_IRQ_VOUT_LO] = {
> @@ -422,6 +464,18 @@ static struct regmap_irq_chip rk805_irq_chip = {
>  	.init_ack_masked = true,
>  };
>  
> +static struct regmap_irq_chip rk806_irq_chip = {
> +	.name = "rk806",
> +	.irqs = rk806_irqs,
> +	.num_irqs = ARRAY_SIZE(rk806_irqs),
> +	.num_regs = 2,
> +	.irq_reg_stride = 2,
> +	.mask_base = RK806_INT_MSK0,
> +	.status_base = RK806_INT_STS0,
> +	.ack_base = RK806_INT_STS0,
> +	.init_ack_masked = true,
> +};
> +
>  static const struct regmap_irq_chip rk808_irq_chip = {
>  	.name = "rk808",
>  	.irqs = rk808_irqs,
> @@ -548,6 +602,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  	struct rk808 *rk808;
>  	const struct rk808_reg_data *pre_init_reg;
>  	const struct mfd_cell *cells;
> +	bool dual_support = false;
>  	int nr_pre_init_regs;
>  	int nr_cells;
>  	int ret;
> @@ -569,6 +624,14 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  		cells = rk805s;
>  		nr_cells = ARRAY_SIZE(rk805s);
>  		break;
> +	case RK806_ID:
> +		rk808->regmap_irq_chip = &rk806_irq_chip;
> +		pre_init_reg = rk806_pre_init_reg;
> +		nr_pre_init_regs = ARRAY_SIZE(rk806_pre_init_reg);
> +		cells = rk806s;
> +		nr_cells = ARRAY_SIZE(rk806s);
> +		dual_support = true;
> +		break;
>  	case RK808_ID:
>  		rk808->regmap_irq_chip = &rk808_irq_chip;
>  		pre_init_reg = rk808_pre_init_reg;
> @@ -602,7 +665,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
>  
>  	ret = devm_regmap_add_irq_chip(dev, rk808->regmap, irq,
> -				       IRQF_ONESHOT, -1,
> +				       IRQF_ONESHOT | (dual_support ? IRQF_SHARED : 0), -1,

Why not 'dual_support = IRQF_SHARED', then | it regardless?

>  				       rk808->regmap_irq_chip, &rk808->irq_data);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to add irq_chip\n");
> @@ -617,7 +680,7 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
>  					     pre_init_reg[i].addr);
>  	}
>  
> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +	ret = devm_mfd_add_devices(dev, dual_support ? PLATFORM_DEVID_AUTO : PLATFORM_DEVID_NONE,

Any reason why you can't use AUTO all the time?

>  			      cells, nr_cells, NULL, 0,
>  			      regmap_irq_get_domain(rk808->irq_data));
>  	if (ret)
> diff --git a/drivers/mfd/rk8xx-spi.c b/drivers/mfd/rk8xx-spi.c
> new file mode 100644
> index 000000000000..3fbcaaaa453a
> --- /dev/null
> +++ b/drivers/mfd/rk8xx-spi.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Rockchip RK806 Core (SPI) driver
> + *
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + * Copyright (c) 2023 Collabora Ltd.
> + *
> + * Author: Xu Shengfei <xsf@rock-chips.com>
> + * Author: Sebastian Reichel <sebastian.reichel@collabora.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/rk808.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#define RK806_CMD		0
> +#define RK806_REG_ADDR_L	1
> +#define RK806_REG_ADDR_H	2
> +
> +static const struct regmap_range rk806_volatile_ranges[] = {
> +	regmap_reg_range(RK806_POWER_EN0, RK806_POWER_EN5),
> +	regmap_reg_range(RK806_DVS_START_CTRL, RK806_INT_MSK1),
> +};
> +
> +static const struct regmap_access_table rk806_volatile_table = {
> +	.yes_ranges = rk806_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(rk806_volatile_ranges),
> +};
> +
> +static const struct regmap_config rk806_regmap_config_spi = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_table = &rk806_volatile_table,
> +};
> +
> +static int rk806_spi_bus_write(void *context, const void *vdata, size_t count)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	const char *data = vdata;
> +	char buffer[3] = { 0 };
> +	struct spi_transfer xfer[2] = { 0 };
> +
> +	buffer[RK806_CMD]	 = RK806_CMD_WRITE | (count - 2);

Comment or define please.

> +	buffer[RK806_REG_ADDR_L] = data[0];

As above.

> +	buffer[RK806_REG_ADDR_H] = RK806_REG_H;
> +
> +	xfer[0].tx_buf = buffer;
> +	xfer[0].len = sizeof(buffer);
> +	xfer[1].tx_buf = data+1;

And here.

> +	xfer[1].len = count-1;

Here too.

Nit: spaces around the '+' and '-' please.

> +	return spi_sync_transfer(spi, xfer, ARRAY_SIZE(xfer));
> +}
> +
> +static int rk806_spi_bus_read(void *context, const void *vreg, size_t reg_size,
> +			      void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +	const char *reg = vreg;
> +	char txbuf[3] = { 0 };
> +
> +	if (reg_size != sizeof(char) || val_size < 1)
> +		return -EINVAL;
> +
> +	txbuf[RK806_CMD]	= RK806_CMD_READ | (val_size - 1);
> +	txbuf[RK806_REG_ADDR_L]	= *reg;
> +	txbuf[RK806_REG_ADDR_H]	= RK806_REG_H;

What's this for?  Isn't it already 0?

> +	return spi_write_then_read(spi, txbuf, sizeof(txbuf), val, val_size);
> +}
> +
> +static const struct regmap_bus rk806_regmap_bus_spi = {
> +	.write = rk806_spi_bus_write,
> +	.read = rk806_spi_bus_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +};
> +
> +static int rk8xx_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init(&spi->dev, &rk806_regmap_bus_spi,
> +				  &spi->dev, &rk806_regmap_config_spi);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initialize register map\n");
> +
> +	return rk8xx_probe(&spi->dev, RK806_ID, spi->irq, regmap);
> +}
> +
> +static const struct of_device_id rk8xx_spi_of_match[] = {
> +	{ .compatible = "rockchip,rk806", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rk8xx_spi_of_match);
> +
> +static const struct spi_device_id rk8xx_spi_id_table[] = {
> +	{ "rk806", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, rk8xx_spi_id_table);
> +
> +static struct spi_driver rk8xx_spi_driver = {
> +	.driver		= {
> +		.name	= "rk8xx-spi",
> +		.of_match_table = rk8xx_spi_of_match,
> +	},
> +	.probe		= rk8xx_spi_probe,
> +	.id_table	= rk8xx_spi_id_table,
> +};
> +module_spi_driver(rk8xx_spi_driver);
> +
> +MODULE_AUTHOR("Xu Shengfei <xsf@rock-chips.com>");
> +MODULE_DESCRIPTION("RK8xx SPI PMIC driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h

-- 
Lee Jones [李琼斯]
