Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0C6DF776
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDLNlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:41:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D92146A9;
        Wed, 12 Apr 2023 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681306879; x=1712842879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r6sqA2EA5a+oApbcz9TT2zH1SV2RraxSjLygRQVtmyA=;
  b=oD+jvkHyStb08Q3elbXiUznkP+9eh673SkH/A82eD3XrMUIxP4DlcP+A
   WK4NV0fBKDt/Ku1pj6LoA2hp9/wF1Ki8FfMu7PoCtGqn+V4HUIOiE3TAs
   B+0ssFlG1Q6WSWeXvFkHy8x16sp2T88xKPnsuaTXk+MYgMphV8Z5YYFW4
   CND1GyyVxBeA42WIKJ8Qi9FyyLd6/hVNQRndA3z7zmRsQ9gBQZjLDaWOp
   y/G51r2gvO3K8HyBdIrygzAAaUD/tajy0gM9r2NGO3Pyvok9I+H/fSeoZ
   5EUusMNmCCfTbDYwGiApgyH7c5qicBIxz5pml2ufaxgwuni0Rytdnvqii
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343903402"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343903402"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800330685"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800330685"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2023 06:41:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmaik-00Fxbe-2r;
        Wed, 12 Apr 2023 16:41:10 +0300
Date:   Wed, 12 Apr 2023 16:41:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <ZDa09gP6d4yZSBUe@smile.fi.intel.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412111256.40013-6-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:12:46PM +0300, Okan Sahin wrote:
> MFD driver for MAX77541/MAX77540 to enable its sub
> devices.
> 
> The MAX77541 is a multi-function devices. It includes
> buck converter and ADC.
> 
> The MAX77540 is a high-efficiency buck converter
> with two 3A switching phases.
> 
> They have same regmap except for ADC part of MAX77541.

Since Lee should be happy with your change for ID tables, I'm fine with the
rest and altogether.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> ---
>  drivers/mfd/Kconfig          |  13 ++
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/max77541.c       | 224 +++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max77541.h |  91 ++++++++++++++
>  4 files changed, 329 insertions(+)
>  create mode 100644 drivers/mfd/max77541.c
>  create mode 100644 include/linux/mfd/max77541.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index fcc141e067b9..de89245ce1cb 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -777,6 +777,19 @@ config MFD_MAX14577
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MAX77541
> +	tristate "Analog Devices MAX77541/77540 PMIC Support"
> +	depends on I2C=y
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Say yes here to add support for Analog Devices MAX77541 and
> +	  MAX77540 Power Management ICs. This driver provides
> +	  common support for accessing the device; additional drivers
> +	  must be enabled in order to use the functionality of the device.
> +	  There are regulators and adc.
> +
>  config MFD_MAX77620
>  	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
>  	depends on I2C=y
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2f6c89d1e277..1c8540ddead6 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -151,6 +151,7 @@ obj-$(CONFIG_MFD_DA9063)	+= da9063.o
>  obj-$(CONFIG_MFD_DA9150)	+= da9150-core.o
>  
>  obj-$(CONFIG_MFD_MAX14577)	+= max14577.o
> +obj-$(CONFIG_MFD_MAX77541)	+= max77541.o
>  obj-$(CONFIG_MFD_MAX77620)	+= max77620.o
>  obj-$(CONFIG_MFD_MAX77650)	+= max77650.o
>  obj-$(CONFIG_MFD_MAX77686)	+= max77686.o
> diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
> new file mode 100644
> index 000000000000..4a3bad3493b3
> --- /dev/null
> +++ b/drivers/mfd/max77541.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.
> + * Driver for the MAX77540 and MAX77541
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/max77541.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config max77541_regmap_config = {
> +	.reg_bits   = 8,
> +	.val_bits   = 8,
> +};
> +
> +static const struct regmap_irq max77541_src_irqs[] = {
> +	{ .mask = MAX77541_BIT_INT_SRC_TOPSYS },
> +	{ .mask = MAX77541_BIT_INT_SRC_BUCK },
> +};
> +
> +static const struct regmap_irq_chip max77541_src_irq_chip = {
> +	.name		= "max77541-src",
> +	.status_base	= MAX77541_REG_INT_SRC,
> +	.mask_base	= MAX77541_REG_INT_SRC_M,
> +	.num_regs	= 1,
> +	.irqs		= max77541_src_irqs,
> +	.num_irqs       = ARRAY_SIZE(max77541_src_irqs),
> +};
> +
> +static const struct regmap_irq max77541_topsys_irqs[] = {
> +	{ .mask = MAX77541_BIT_TOPSYS_INT_TJ_120C },
> +	{ .mask = MAX77541_BIT_TOPSYS_INT_TJ_140C },
> +	{ .mask = MAX77541_BIT_TOPSYS_INT_TSHDN },
> +	{ .mask = MAX77541_BIT_TOPSYS_INT_UVLO },
> +	{ .mask = MAX77541_BIT_TOPSYS_INT_ALT_SWO },
> +	{ .mask = MAX77541_BIT_TOPSYS_INT_EXT_FREQ_DET },
> +};
> +
> +static const struct regmap_irq_chip max77541_topsys_irq_chip = {
> +	.name		= "max77541-topsys",
> +	.status_base	= MAX77541_REG_TOPSYS_INT,
> +	.mask_base	= MAX77541_REG_TOPSYS_INT_M,
> +	.num_regs	= 1,
> +	.irqs		= max77541_topsys_irqs,
> +	.num_irqs	= ARRAY_SIZE(max77541_topsys_irqs),
> +};
> +
> +static const struct regmap_irq max77541_buck_irqs[] = {
> +	{ .mask = MAX77541_BIT_BUCK_INT_M1_POK_FLT },
> +	{ .mask = MAX77541_BIT_BUCK_INT_M2_POK_FLT },
> +	{ .mask = MAX77541_BIT_BUCK_INT_M1_SCFLT },
> +	{ .mask = MAX77541_BIT_BUCK_INT_M2_SCFLT },
> +};
> +
> +static const struct regmap_irq_chip max77541_buck_irq_chip = {
> +	.name		= "max77541-buck",
> +	.status_base	= MAX77541_REG_BUCK_INT,
> +	.mask_base	= MAX77541_REG_BUCK_INT_M,
> +	.num_regs	= 1,
> +	.irqs		= max77541_buck_irqs,
> +	.num_irqs	= ARRAY_SIZE(max77541_buck_irqs),
> +};
> +
> +static const struct regmap_irq max77541_adc_irqs[] = {
> +	{ .mask = MAX77541_BIT_ADC_INT_CH1_I },
> +	{ .mask = MAX77541_BIT_ADC_INT_CH2_I },
> +	{ .mask = MAX77541_BIT_ADC_INT_CH3_I },
> +	{ .mask = MAX77541_BIT_ADC_INT_CH6_I },
> +};
> +
> +static const struct regmap_irq_chip max77541_adc_irq_chip = {
> +	.name		= "max77541-adc",
> +	.status_base	= MAX77541_REG_ADC_INT,
> +	.mask_base	= MAX77541_REG_ADC_INT_M,
> +	.num_regs	= 1,
> +	.irqs		= max77541_adc_irqs,
> +	.num_irqs	= ARRAY_SIZE(max77541_adc_irqs),
> +};
> +
> +static const struct mfd_cell max77540_devs[] = {
> +	MFD_CELL_OF("max77540-regulator", NULL, NULL, 0, 0, NULL),
> +};
> +
> +static const struct mfd_cell max77541_devs[] = {
> +	MFD_CELL_OF("max77541-regulator", NULL, NULL, 0, 0, NULL),
> +	MFD_CELL_OF("max77541-adc", NULL, NULL, 0, 0, NULL),
> +};
> +
> +static int max77541_pmic_irq_init(struct device *dev)
> +{
> +	struct max77541 *max77541 = dev_get_drvdata(dev);
> +	int irq = max77541->i2c->irq;
> +	int ret;
> +
> +	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED, 0,
> +				       &max77541_src_irq_chip,
> +				       &max77541->irq_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED, 0,
> +				       &max77541_topsys_irq_chip,
> +				       &max77541->irq_topsys);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> +				       IRQF_ONESHOT | IRQF_SHARED, 0,
> +				       &max77541_buck_irq_chip,
> +				       &max77541->irq_buck);
> +	if (ret)
> +		return ret;
> +
> +	if (max77541->id == MAX77541) {
> +		ret = devm_regmap_add_irq_chip(dev, max77541->regmap, irq,
> +					       IRQF_ONESHOT | IRQF_SHARED, 0,
> +					       &max77541_adc_irq_chip,
> +					       &max77541->irq_adc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77541_pmic_setup(struct device *dev)
> +{
> +	struct max77541 *max77541 = dev_get_drvdata(dev);
> +	const struct mfd_cell *cells;
> +	int n_devs;
> +	int ret;
> +
> +	switch (max77541->id) {
> +	case MAX77540:
> +		cells =  max77540_devs;
> +		n_devs = ARRAY_SIZE(max77540_devs);
> +		break;
> +	case MAX77541:
> +		cells =  max77541_devs;
> +		n_devs = ARRAY_SIZE(max77541_devs);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = max77541_pmic_irq_init(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize IRQ\n");
> +
> +	ret = device_init_wakeup(dev, true);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to init wakeup\n");
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				    cells, n_devs, NULL, 0, NULL);
> +}
> +
> +static int max77541_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct device *dev = &client->dev;
> +	struct max77541 *max77541;
> +
> +	max77541 = devm_kzalloc(dev, sizeof(*max77541), GFP_KERNEL);
> +	if (!max77541)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, max77541);
> +	max77541->i2c = client;
> +
> +	max77541->id  = (enum max7754x_ids)device_get_match_data(dev);
> +	if (!max77541->id)
> +		max77541->id  = (enum max7754x_ids)id->driver_data;
> +
> +	if (!max77541->id)
> +		return -EINVAL;
> +
> +	max77541->regmap = devm_regmap_init_i2c(client,
> +						&max77541_regmap_config);
> +	if (IS_ERR(max77541->regmap))
> +		return dev_err_probe(dev, PTR_ERR(max77541->regmap),
> +				     "Failed to allocate register map\n");
> +
> +	return max77541_pmic_setup(dev);
> +}
> +
> +static const struct of_device_id max77541_of_id[] = {
> +	{
> +		.compatible = "adi,max77540",
> +		.data = (void *)MAX77540,
> +	},
> +	{
> +		.compatible = "adi,max77541",
> +		.data = (void *)MAX77541,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77541_of_id);
> +
> +static const struct i2c_device_id max77541_id[] = {
> +	{ "max77540", MAX77540 },
> +	{ "max77541", MAX77541 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max77541_id);
> +
> +static struct i2c_driver max77541_driver = {
> +	.driver = {
> +		.name = "max77541",
> +		.of_match_table = max77541_of_id,
> +	},
> +	.probe_new = max77541_probe,
> +	.id_table = max77541_id,
> +};
> +module_i2c_driver(max77541_driver);
> +
> +MODULE_DESCRIPTION("MAX7740/MAX7741 Driver");
> +MODULE_AUTHOR("Okan Sahin <okan.sahin@analog.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max77541.h b/include/linux/mfd/max77541.h
> new file mode 100644
> index 000000000000..fe5c0a3dc637
> --- /dev/null
> +++ b/include/linux/mfd/max77541.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __MFD_MAX77541_H
> +#define __MFD_MAX77541_H
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +
> +/* REGISTERS */
> +#define MAX77541_REG_INT_SRC                    0x00
> +#define MAX77541_REG_INT_SRC_M                  0x01
> +
> +#define MAX77541_BIT_INT_SRC_TOPSYS             BIT(0)
> +#define MAX77541_BIT_INT_SRC_BUCK               BIT(1)
> +
> +#define MAX77541_REG_TOPSYS_INT                 0x02
> +#define MAX77541_REG_TOPSYS_INT_M               0x03
> +
> +#define MAX77541_BIT_TOPSYS_INT_TJ_120C         BIT(0)
> +#define MAX77541_BIT_TOPSYS_INT_TJ_140C         BIT(1)
> +#define MAX77541_BIT_TOPSYS_INT_TSHDN           BIT(2)
> +#define MAX77541_BIT_TOPSYS_INT_UVLO            BIT(3)
> +#define MAX77541_BIT_TOPSYS_INT_ALT_SWO         BIT(4)
> +#define MAX77541_BIT_TOPSYS_INT_EXT_FREQ_DET    BIT(5)
> +
> +/* REGULATORS */
> +#define MAX77541_REG_BUCK_INT                   0x20
> +#define MAX77541_REG_BUCK_INT_M                 0x21
> +
> +#define MAX77541_BIT_BUCK_INT_M1_POK_FLT        BIT(0)
> +#define MAX77541_BIT_BUCK_INT_M2_POK_FLT        BIT(1)
> +#define MAX77541_BIT_BUCK_INT_M1_SCFLT          BIT(4)
> +#define MAX77541_BIT_BUCK_INT_M2_SCFLT          BIT(5)
> +
> +#define MAX77541_REG_EN_CTRL                    0x0B
> +
> +#define MAX77541_BIT_M1_EN                      BIT(0)
> +#define MAX77541_BIT_M2_EN                      BIT(1)
> +
> +#define MAX77541_REG_M1_VOUT                    0x23
> +#define MAX77541_REG_M2_VOUT                    0x33
> +
> +#define MAX77541_BITS_MX_VOUT                   GENMASK(7, 0)
> +
> +#define MAX77541_REG_M1_CFG1                    0x25
> +#define MAX77541_REG_M2_CFG1                    0x35
> +
> +#define MAX77541_BITS_MX_CFG1_RNG               GENMASK(7, 6)
> +
> +/* ADC */
> +#define MAX77541_REG_ADC_INT                    0x70
> +#define MAX77541_REG_ADC_INT_M                  0x71
> +
> +#define MAX77541_BIT_ADC_INT_CH1_I              BIT(0)
> +#define MAX77541_BIT_ADC_INT_CH2_I              BIT(1)
> +#define MAX77541_BIT_ADC_INT_CH3_I              BIT(2)
> +#define MAX77541_BIT_ADC_INT_CH6_I              BIT(5)
> +
> +#define MAX77541_REG_ADC_DATA_CH1               0x72
> +#define MAX77541_REG_ADC_DATA_CH2               0x73
> +#define MAX77541_REG_ADC_DATA_CH3               0x74
> +#define MAX77541_REG_ADC_DATA_CH6               0x77
> +
> +/* INTERRUPT MASKS*/
> +#define MAX77541_REG_INT_SRC_MASK               0x00
> +#define MAX77541_REG_TOPSYS_INT_MASK            0x00
> +#define MAX77541_REG_BUCK_INT_MASK              0x00
> +
> +#define MAX77541_MAX_REGULATORS 2
> +
> +enum max7754x_ids {
> +	MAX77540 = 1,
> +	MAX77541,
> +};
> +
> +struct regmap;
> +struct regmap_irq_chip_data;
> +struct i2c_client;
> +
> +struct max77541 {
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
> +	enum max7754x_ids id;
> +
> +	struct regmap_irq_chip_data *irq_data;
> +	struct regmap_irq_chip_data *irq_buck;
> +	struct regmap_irq_chip_data *irq_topsys;
> +	struct regmap_irq_chip_data *irq_adc;
> +};
> +
> +#endif /* __MFD_MAX77541_H */
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


