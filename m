Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DAE62D7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbiKQKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKQKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:16:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1002AC73;
        Thu, 17 Nov 2022 02:16:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78AD2CE1D8F;
        Thu, 17 Nov 2022 10:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B3C433D6;
        Thu, 17 Nov 2022 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668680156;
        bh=nMX1pmWgMtqMDE+X0xEQhYb2QG4bMnX19JdISdG+DL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0dVWZuKE2duBP/h6i0onOn4RoBub/OqNs6M5PLnKvlMI5DSp/xFX5gXHlFSUSdO0
         bFIBtPZFIA0svwZYeHjpJXTUP60NoLVVB9SfAuKE89Fq89LHo0wrFYuUaaCojlAqYz
         RPSrfvej7SKX04dbC3gZxeF9RoADm4sdNebXTwSBbSiTueebWlYt8dDJtAkUh7VIxd
         R3jM+vRZrn1PWdEpTZ/51vdvR20IxTPS3OyoEGfUR44oOva8aM9IB36RTi+qXXsMb1
         wQLGWRq063EMepjC3AFlDPJIKdrbrZBQwWOe7bMXDuyoFV3HWI+4YzbIXmvXTrpn0b
         PSWsiCZZpUi1g==
Date:   Thu, 17 Nov 2022 10:15:52 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <Y3YJ2EkYNW+gA+/R@google.com>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Implement a regulator driver with IRQ support for fault management.
> Written against documentation [1] and [2] and tested on real hardware.
> 
> Every channel has its own regulator supplies nammed 'vss1-supply' and
> 'vss2-supply'. The regulator supply is used to determine the output
> voltage, as the smart switch provides no output regulation.
> The driver requires the 'shunt-resistor-micro-ohms' property to be
> present in Device Tree to properly calculate current related
> values.
> 
> Datasheet links:
> 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/mfd/Kconfig         |  12 +++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
>  include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 207 insertions(+)
>  create mode 100644 drivers/mfd/max597x.c
>  create mode 100644 include/linux/mfd/max597x.h

Ignoring my comments won't make them go away. :)

Please tell me why you need a whole new driver, instead of adding
support to simple-mfd-i2c?

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b93856de432..416fe7986b7b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -253,6 +253,18 @@ config MFD_MADERA_SPI
>  	  Support for the Cirrus Logic Madera platform audio SoC
>  	  core functionality controlled via SPI.
>  
> +config MFD_MAX597X
> +	tristate "Maxim 597x Power Switch and Monitor"
> +	depends on I2C
> +	depends on OF
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  This driver controls a Maxim 5970/5978 switch via I2C bus.
> +	  The MAX5970/5978 is a smart switch with no output regulation, but
> +	  fault protection and voltage and current monitoring capabilities.
> +	  Also it supports upto 4 indication LEDs.
> +
>  config MFD_CS47L15
>  	bool "Cirrus Logic CS47L15"
>  	select PINCTRL_CS47L15
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7ed3ef4a698c..819d711fa748 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -161,6 +161,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
>  obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>  
>  obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
> +obj-$(CONFIG_MFD_MAX597X)	+= max597x.o
>  obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
> diff --git a/drivers/mfd/max597x.c b/drivers/mfd/max597x.c
> new file mode 100644
> index 000000000000..45838413f24a
> --- /dev/null
> +++ b/drivers/mfd/max597x.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Maxim MAX5970/MAX5978 Power Switch & Monitor
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max597x.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config max597x_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = MAX_REGISTERS,
> +};
> +
> +static const struct mfd_cell max597x_cells[] = {
> +	{ .name = "max597x-regulator", },
> +	{ .name = "max597x-iio", },
> +	{ .name = "max597x-led", },
> +};
> +
> +static int max597x_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
> +{
> +	struct max597x_data *ddata;
> +	enum max597x_chip_type chip = id->driver_data;
> +
> +	ddata = devm_kzalloc(&i2c->dev, sizeof(*ddata),	GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Based on chip type, Initialize the number of switch. This is needed by
> +	 * regulator & iio cells.
> +	 */
> +	switch (chip) {
> +	case MAX597x_TYPE_MAX5970:
> +		ddata->num_switches = MAX5970_NUM_SWITCHES;
> +		break;
> +	case MAX597x_TYPE_MAX5978:
> +		ddata->num_switches = MAX5978_NUM_SWITCHES;
> +		break;
> +	}
> +
> +	ddata->regmap = devm_regmap_init_i2c(i2c, &max597x_regmap_config);
> +	if (IS_ERR(ddata->regmap)) {
> +		dev_err(&i2c->dev, "Failed to initialize regmap");
> +		return PTR_ERR(ddata->regmap);
> +	}
> +
> +	/* IRQ used by regulator cell */
> +	ddata->irq = i2c->irq;
> +	ddata->dev = &i2c->dev;
> +	i2c_set_clientdata(i2c, ddata);
> +
> +	return devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO,
> +				    max597x_cells, ARRAY_SIZE(max597x_cells),
> +				    NULL, 0, NULL);
> +}
> +
> +static const struct i2c_device_id max597x_table[] = {
> +	{ .name = "max5970", MAX597x_TYPE_MAX5970 },
> +	{ .name = "max5978", MAX597x_TYPE_MAX5978 },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, max597x_table);
> +
> +static const struct of_device_id max597x_of_match[] = {
> +	{ .compatible = "maxim,max5970" },
> +	{ .compatible = "maxim,max5978" },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, max597x_of_match);
> +
> +static struct i2c_driver max597x_driver = {
> +	.id_table = max597x_table,
> +	.driver = {
> +		  .name = "max597x",
> +		  .of_match_table = of_match_ptr(max597x_of_match),
> +		  },
> +	.probe = max597x_probe,
> +};
> +module_i2c_driver(max597x_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX597X Power Switch and Monitor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max597x.h
> new file mode 100644
> index 000000000000..706eff9c50a4
> --- /dev/null
> +++ b/include/linux/mfd/max597x.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Maxim MAX5970/MAX5978 Power Switch & Monitor
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#ifndef MFD_MAX597X_H
> +#define MFD_MAX597X_H
> +
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX5970_NUM_SWITCHES 2
> +#define MAX5978_NUM_SWITCHES 1
> +#define MAX597X_NUM_LEDS     4
> +
> +enum max597x_chip_type {
> +	MAX597x_TYPE_MAX5978 = 1,
> +	MAX597x_TYPE_MAX5970,
> +};
> +
> +#define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
> +#define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
> +#define MAX5970_REG_VOLTAGE_H(ch)		(0x02 + (ch) * 4)
> +#define MAX5970_REG_MON_RANGE			0x18
> +#define  MAX5970_MON_MASK				0x3
> +#define  MAX5970_MON(reg, ch)		(((reg) >> ((ch) * 2)) & MAX5970_MON_MASK)
> +#define  MAX5970_MON_MAX_RANGE_UV		16000000
> +
> +#define MAX5970_REG_CH_UV_WARN_H(ch)	(0x1A + (ch) * 10)
> +#define MAX5970_REG_CH_UV_WARN_L(ch)	(0x1B + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_H(ch)	(0x1C + (ch) * 10)
> +#define MAX5970_REG_CH_UV_CRIT_L(ch)	(0x1D + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_H(ch)	(0x1E + (ch) * 10)
> +#define MAX5970_REG_CH_OV_WARN_L(ch)	(0x1F + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_H(ch)	(0x20 + (ch) * 10)
> +#define MAX5970_REG_CH_OV_CRIT_L(ch)	(0x21 + (ch) * 10)
> +
> +#define  MAX5970_VAL2REG_H(x)			(((x) >> 2) & 0xFF)
> +#define  MAX5970_VAL2REG_L(x)			((x) & 0x3)
> +
> +#define MAX5970_REG_DAC_FAST(ch)		(0x2E + (ch))
> +
> +#define MAX5970_FAST2SLOW_RATIO			200
> +
> +#define MAX5970_REG_STATUS0				0x31
> +#define  MAX5970_CB_IFAULTF(ch)			(1 << (ch))
> +#define  MAX5970_CB_IFAULTS(ch)			(1 << ((ch) + 4))
> +
> +#define MAX5970_REG_STATUS1				0x32
> +#define  STATUS1_PROT_MASK				0x3
> +#define  STATUS1_PROT(reg) \
> +	(((reg) >> 6) & STATUS1_PROT_MASK)
> +#define  STATUS1_PROT_SHUTDOWN			0
> +#define  STATUS1_PROT_CLEAR_PG			1
> +#define  STATUS1_PROT_ALERT_ONLY		2
> +
> +#define MAX5970_REG_STATUS2				0x33
> +#define  MAX5970_IRNG_MASK				0x3
> +#define  MAX5970_IRNG(reg, ch)	\
> +						(((reg) >> ((ch) * 2)) & MAX5970_IRNG_MASK)
> +
> +#define MAX5970_REG_STATUS3				0x34
> +#define  MAX5970_STATUS3_ALERT			BIT(4)
> +#define  MAX5970_STATUS3_PG(ch)			BIT(ch)
> +
> +#define MAX5970_REG_FAULT0				0x35
> +#define  UV_STATUS_WARN(ch)				BIT(ch)
> +#define  UV_STATUS_CRIT(ch)				BIT(ch + 4)
> +
> +#define MAX5970_REG_FAULT1				0x36
> +#define  OV_STATUS_WARN(ch)				BIT(ch)
> +#define  OV_STATUS_CRIT(ch)				BIT(ch + 4)
> +
> +#define MAX5970_REG_FAULT2				0x37
> +#define  OC_STATUS_WARN(ch)				BIT(ch)
> +
> +#define MAX5970_REG_CHXEN				0x3b
> +#define  CHXEN(ch)						(3 << (ch * 2))
> +
> +#define MAX5970_REG_LED_FLASH			0x43
> +
> +#define MAX_REGISTERS					0x49
> +#define ADC_MASK						0x3FF
> +
> +struct max597x_data {
> +	struct device *dev;
> +	int irq;
> +	int num_switches;
> +	struct regmap *regmap;
> +	/* Chip specific parameters needed by regulator & iio cells */
> +	u32 irng[MAX5970_NUM_SWITCHES];
> +	u32 mon_rng[MAX5970_NUM_SWITCHES];
> +	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
> +};
> +
> +#endif

-- 
Lee Jones [李琼斯]
