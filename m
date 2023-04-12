Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B306DF77F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDLNlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjDLNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:41:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666183FC;
        Wed, 12 Apr 2023 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681306897; x=1712842897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vT0LqjKFDK/5Av6PJjxxq20lgHvDiGW3TQWTthosmyI=;
  b=O3cSYzkttwtPh1LQuYGfiDco8tjzLyF6ADMqxS7judXIDZVbXPj3oknV
   US4XRQNC/TnDytBzQN6xI2Mg0Jy8+GolePv4XxkojljtiQFP0jYKCJJEH
   ocubtNvYB4CGyiQdC0dqm0WSBXX8CvZaN0t9yB0iiNWC18Zl9oWFtCnM7
   /gC0FDCioWY8hum4wnC2eeTe5eYOhxnRVdQhuY/E0UUrNEcFSQW7C/V2Z
   5BUro3ZURUhJ7odB2oElJ+emFZ2KK8lGYBk2LOdwM1FSRzeIQtNH6EKxv
   oyCg5UJBiCnxiGQ8g/ggzA4X5xkw6SMMb6lxvAg6R/M2AYJdUWLVjXIyk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343903492"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343903492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800330743"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800330743"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2023 06:41:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmaj3-00Fxbw-1d;
        Wed, 12 Apr 2023 16:41:29 +0300
Date:   Wed, 12 Apr 2023 16:41:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 3/5] iio: adc: max77541: Add ADI MAX77541 ADC Support
Message-ID: <ZDa1CWY1owgPNwh8@smile.fi.intel.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-4-okan.sahin@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412111256.40013-4-okan.sahin@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:12:44PM +0300, Okan Sahin wrote:
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/Kconfig        |  11 ++
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/max77541-adc.c | 194 +++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/iio/adc/max77541-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 45af2302be53..518e7bd453aa 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -735,6 +735,17 @@ config MAX1363
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1363.
>  
> +config MAX77541_ADC
> +	tristate "Analog Devices MAX77541 ADC driver"
> +	depends on MFD_MAX77541
> +	help
> +	  This driver controls a Analog Devices MAX77541 ADC
> +	  via I2C bus. This device has one adc. Say yes here to build
> +	  support for Analog Devices MAX77541 ADC interface.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called max77541-adc.
> +
>  config MAX9611
>  	tristate "Maxim max9611/max9612 ADC driver"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 36c18177322a..f8433b560c3b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
>  obj-$(CONFIG_MAX11410) += max11410.o
>  obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
> +obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
>  obj-$(CONFIG_MAX9611) += max9611.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
> diff --git a/drivers/iio/adc/max77541-adc.c b/drivers/iio/adc/max77541-adc.c
> new file mode 100644
> index 000000000000..21d024bde16b
> --- /dev/null
> +++ b/drivers/iio/adc/max77541-adc.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.
> + * ADI MAX77541 ADC Driver with IIO interface
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <linux/mfd/max77541.h>
> +
> +enum max77541_adc_range {
> +	LOW_RANGE,
> +	MID_RANGE,
> +	HIGH_RANGE,
> +};
> +
> +enum max77541_adc_channel {
> +	MAX77541_ADC_VSYS_V,
> +	MAX77541_ADC_VOUT1_V,
> +	MAX77541_ADC_VOUT2_V,
> +	MAX77541_ADC_TEMP,
> +};
> +
> +static int max77541_adc_offset(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2)
> +{
> +	switch (chan->channel) {
> +	case MAX77541_ADC_TEMP:
> +		*val = DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS, 1725);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max77541_adc_scale(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2)
> +{
> +	struct regmap **regmap = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	switch (chan->channel) {
> +	case MAX77541_ADC_VSYS_V:
> +		*val = 25;
> +		return IIO_VAL_INT;
> +	case MAX77541_ADC_VOUT1_V:
> +	case MAX77541_ADC_VOUT2_V:
> +		ret = regmap_read(*regmap, MAX77541_REG_M2_CFG1, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		reg_val = FIELD_GET(MAX77541_BITS_MX_CFG1_RNG, reg_val);
> +		switch (reg_val) {
> +		case LOW_RANGE:
> +			*val = 6;
> +			*val2 = 250000;
> +			break;
> +		case MID_RANGE:
> +			*val = 12;
> +			*val2 = 500000;
> +			break;
> +		case HIGH_RANGE:
> +			*val = 25;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case MAX77541_ADC_TEMP:
> +		*val = 1725;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max77541_adc_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val)
> +{
> +	struct regmap **regmap = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_read(*regmap, chan->address, val);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +#define MAX77541_ADC_CHANNEL_V(_channel, _name, _type, _reg) \
> +	{							\
> +		.type = _type,					\
> +		.indexed = 1,					\
> +		.channel = _channel,				\
> +		.address = _reg,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +				      BIT(IIO_CHAN_INFO_SCALE), \
> +		.datasheet_name = _name,			\
> +	}
> +
> +#define MAX77541_ADC_CHANNEL_TEMP(_channel, _name, _type, _reg) \
> +	{							\
> +		.type = _type,					\
> +		.indexed = 1,					\
> +		.channel = _channel,				\
> +		.address = _reg,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +				      BIT(IIO_CHAN_INFO_SCALE) |\
> +				      BIT(IIO_CHAN_INFO_OFFSET),\
> +		.datasheet_name = _name,			\
> +	}
> +
> +static const struct iio_chan_spec max77541_adc_channels[] = {
> +	MAX77541_ADC_CHANNEL_V(MAX77541_ADC_VSYS_V, "vsys_v", IIO_VOLTAGE,
> +			       MAX77541_REG_ADC_DATA_CH1),
> +	MAX77541_ADC_CHANNEL_V(MAX77541_ADC_VOUT1_V, "vout1_v", IIO_VOLTAGE,
> +			       MAX77541_REG_ADC_DATA_CH2),
> +	MAX77541_ADC_CHANNEL_V(MAX77541_ADC_VOUT2_V, "vout2_v", IIO_VOLTAGE,
> +			       MAX77541_REG_ADC_DATA_CH3),
> +	MAX77541_ADC_CHANNEL_TEMP(MAX77541_ADC_TEMP, "temp", IIO_TEMP,
> +				  MAX77541_REG_ADC_DATA_CH6),
> +};
> +
> +static int max77541_adc_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		return max77541_adc_offset(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return max77541_adc_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_RAW:
> +		return max77541_adc_raw(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max77541_adc_info = {
> +	.read_raw = max77541_adc_read_raw,
> +};
> +
> +static int max77541_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct regmap **regmap;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*regmap));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = iio_priv(indio_dev);
> +
> +	*regmap = dev_get_regmap(dev->parent, NULL);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->name = "max77541";
> +	indio_dev->info = &max77541_adc_info;
> +	indio_dev->channels = max77541_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max77541_adc_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id max77541_adc_platform_id[] = {
> +	{ "max77541-adc" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, max77541_adc_platform_id);
> +
> +static struct platform_driver max77541_adc_driver = {
> +	.driver = {
> +		.name = "max77541-adc",
> +	},
> +	.probe = max77541_adc_probe,
> +	.id_table = max77541_adc_platform_id,
> +};
> +module_platform_driver(max77541_adc_driver);
> +
> +MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
> +MODULE_DESCRIPTION("MAX77541 ADC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


