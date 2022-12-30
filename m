Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B64659B04
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiL3RhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbiL3RhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:37:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220FB1B1E1;
        Fri, 30 Dec 2022 09:37:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD4261AE9;
        Fri, 30 Dec 2022 17:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D930C433D2;
        Fri, 30 Dec 2022 17:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672421821;
        bh=rCl1UecVlOrD9RCO3yicb5gTBDsr5DvTYOaVSuwhWpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DA7dNyrX2hWfjDnxOOFOU5uJkfvn9sRgcFYrCYePSOF+MNOq81EipFd91XRJOS3cQ
         EymiZUAIHdRSyNkn13dOzdZB6RDaMTbSxSMP0RO8WJcbJSb1cpLvUwAW8k8snuzxDK
         5r+hxmOyOJ/N4O/36tKYAUuXWL3K6k3nqt3R9t+Wd3FlDCXofOGIeklrO3AjNFEaDg
         pxEQTRAKLtMKjGjdAAXNypLJ/P/Y49kI3SMejLNnrUZ7rYhnhdZm1JzjveLe/030NA
         TRGkkBrtZfajB/LYoutmHd20ERhT5rrFfi/y2F0tZcjwkt2zbIGkb29YW7aDZOgYm+
         uxHaBUezUna+w==
Date:   Fri, 30 Dec 2022 17:50:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] drivers: iio: adc: Add MAX77541 ADC Support
Message-ID: <20221230175019.7075f987@jic23-huawei>
In-Reply-To: <20221226223839.103460-6-okan.sahin@analog.com>
References: <20221226223839.103460-1-okan.sahin@analog.com>
        <20221226223839.103460-6-okan.sahin@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 01:38:39 +0300
Okan Sahin <okan.sahin@analog.com> wrote:

> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature
> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

If there is a v3 please send the whole series to everyone who is cc'd on
any of the patches in this version.  For a driver like this, it's much better
to let people pick and choose which bits they are interested in than
to only send part of it to each list / reviewer.

I took a closer look at the offsets / scales this time.  They don't appear
to comply with the ABI.  Whilst 'most' IIO units are SI units, a few have
units borrowed from hwmon including temperature and voltage - this brings
some multiplication factors that need to be taken into account.

Jonathan

> ---
>  MAINTAINERS                    |   1 +
>  drivers/iio/adc/Kconfig        |  11 ++
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/max77541-adc.c | 199 +++++++++++++++++++++++++++++++++
>  4 files changed, 212 insertions(+)
>  create mode 100644 drivers/iio/adc/max77541-adc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e5572b28a8c..18ce4644cc75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12503,6 +12503,7 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/adi,max77541.yaml
>  F:	Documentation/devicetree/bindings/regulator/adi,max77541.yaml
> +F:	drivers/iio/adc/max77541-adc.c
>  F:	drivers/mfd/max77541.c
>  F:	drivers/regulator/max77541-regulator.c
>  F:	include/linux/mfd/max77541.h
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 791612ca6012..9716225b50da 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -696,6 +696,17 @@ config MAX1363
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
> index 46caba7a010c..03774cccbb4b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_MAX1118) += max1118.o
>  obj-$(CONFIG_MAX11205) += max11205.o
>  obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
> +obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
>  obj-$(CONFIG_MAX9611) += max9611.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
> diff --git a/drivers/iio/adc/max77541-adc.c b/drivers/iio/adc/max77541-adc.c
> new file mode 100644
> index 000000000000..29adcdbd96ae
> --- /dev/null
> +++ b/drivers/iio/adc/max77541-adc.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.
> + * ADI MAX77541 ADC Driver with IIO interface
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mfd/max77541.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/units.h>
> +
> +#define MAX77541_ADC_CHANNEL(_channel, _name, _type, _reg) \
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

Move this macro down to just above where it is used.  Given the purpose
of this is to reduce boilerplate repetition we want to review what
it does based on the values provided.  That's much easier if we don't
have to go look for the macro.

> +
> +enum max77541_adc_range {
> +	LOW_RANGE,
> +	MID_RANGE,
> +	HIGH_RANGE,
> +};
> +
> +struct max77541_adc_iio {
> +	struct regmap	*regmap;
> +};
> +
> +enum max77541_adc_channel {
> +	MAX77541_ADC_VSYS_V = 0,
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
> +	case MAX77541_ADC_VSYS_V:
> +	case MAX77541_ADC_VOUT1_V:
> +	case MAX77541_ADC_VOUT2_V:
> +		*val = 0;
> +		*val2 = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;

I thought I mentioned this before.  For cases where the offset is 0 don't 
set the bit in info_mask_seperate and don't provide an implementation to
read it.
 
> +	case MAX77541_ADC_TEMP:
> +		*val = DIV_ROUND_CLOSEST(ABSOLUTE_ZERO_MILLICELSIUS,
> +					 MILLIDEGREE_PER_DEGREE);
> +		*val2 = 0;

If *val2 == 0
then the return type should be IIO_VAL_INT allowing any
code using this to handle it as an integer, not a fixed point number.

I'd also like a comment here to explain the maths being done.
Base units of temperature are mili degrees Celsius and the offset looks wrong anyway as it doesn't
take into account that in datasheet it is applied after scale, whereas in IIO ABI it needs
to be applied first (thus requiring it to be divided by scale)
https://elixir.bootlin.com/linux/v6.2-rc1/source/Documentation/ABI/testing/sysfs-bus-iio#L244

So what you currently have is
1LSB = 1.725*(raw + -273/1000) 
I think it should be - based on equation (-273 + 1.725 * ADC_DATA6) deg C
1LSB = 1725*(raw - 273/1725) so offset should be -273/1725 and scale should be 1725.

Also check scaling is right for voltage channels - noting that voltage channels are
expressed in milivolts I suspect the sale should therefore be 25 but I haven't checked
it closely.



> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +



As noted above, put the macro definition here so it is easy to see what
this does.

> +static const struct iio_chan_spec max77541_adc_channels[] = {
> +	MAX77541_ADC_CHANNEL(MAX77541_ADC_VSYS_V, "vsys_v", IIO_VOLTAGE,
> +			     MAX77541_REG_ADC_DATA_CH1),
> +	MAX77541_ADC_CHANNEL(MAX77541_ADC_VOUT1_V, "vout1_v", IIO_VOLTAGE,
> +			     MAX77541_REG_ADC_DATA_CH2),
> +	MAX77541_ADC_CHANNEL(MAX77541_ADC_VOUT2_V, "vout2_v", IIO_VOLTAGE,
> +			     MAX77541_REG_ADC_DATA_CH3),
> +	MAX77541_ADC_CHANNEL(MAX77541_ADC_TEMP, "temp", IIO_TEMP,
> +			     MAX77541_REG_ADC_DATA_CH6),
> +};
> +

> +
> +static int max77541_adc_probe(struct platform_device *pdev)
> +{
> +	struct max77541_dev *max77541 = dev_get_drvdata(pdev->dev.parent);

I can't easily see other parts of the mfd (as not cc'd on rest of series),
but from what is here it might be nice to set the drvdata to the regmap rather
than the mfd driver specific structure.

> +	struct device *dev = &pdev->dev;
> +	struct max77541_adc_iio *info;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	info->regmap = max77541->regmap;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->name = platform_get_device_id(pdev)->name;

I would prefer to see that hard coded.  Also, from an IIO point
of view this should just be the part number which is "max77541"
without the -adc postfix.

The advantage of hard coding it is I don't need to think about what
indio_dev->name = "max77541"; 
sets it to thus reducing the complexity of reviewing a little.
Note that similar cases have gone wrong in the past and we've
ended up stuck with hideous ABI for a few device names so I'm
paranoid about this now.


> +	indio_dev->info = &max77541_adc_info;
> +	indio_dev->channels = max77541_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max77541_adc_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id max77541_adc_platform_id[] = {
> +	{ "max77541-adc", },
> +	{  /* sentinel */  }
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

