Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0064943C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiLKMsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLKMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:48:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27C5DF81;
        Sun, 11 Dec 2022 04:48:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77083B80AD5;
        Sun, 11 Dec 2022 12:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9766C433F0;
        Sun, 11 Dec 2022 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670762904;
        bh=YqGHAeUtjkvb2+3w36MvdEkbN9v5NOQfnXnXcP1UOzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AkU834MglZrcwwSoXK9m6zJeMUXkYsFb0IZQSdcM0ZKFd2qQnJhFId5sUpCByCuTT
         y4NDGgQ+v/a8dSdCQYck2RL6NoFknhQJyB4kCinAGlxo1TZy8DovYi6rni6oHGmNmd
         V99Im/oXLMPPACiw8SQKiTgtpy8O499qCFMqZxnPMFaCWaJ+kusxwHgvY16U6O0PH3
         3o2SMuj3KiX2o7QDj6FC+JqjLpQxwZv2vlEaNHVVTklfrZQmdasEyFIszU4MuWLG28
         oSSuqC+u6tEjeQZuI75x/4mjizYxFGlQEviRXAObeMO0nUImKSPTgpQoPb5g38M/br
         0orqsjMfl7xew==
Date:   Sun, 11 Dec 2022 13:01:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     <outreachy@lists.linux.dev>, Lee Jones <lee@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/5] staging: drivers: iio: adc: Adc MAX77541 ADC
 Support
Message-ID: <20221211130116.6469e390@jic23-huawei>
In-Reply-To: <20221207090906.5896-6-okan.sahin@analog.com>
References: <20221207090906.5896-1-okan.sahin@analog.com>
        <20221207090906.5896-6-okan.sahin@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed, 7 Dec 2022 12:08:44 +0300
Okan Sahin <okan.sahin@analog.com> wrote:

> This patch add adc support for MAX77541.
> 
> The MAX77541 has an 8-bit Successive Approximation Register (SAR) ADC
> with four multiplexers for supporting the telemetry feature

Good to add a little detail on what features the driver currently supports.

> 
> Signed-off-by: Okan Sahin <okan.sahin@analog.com>

...

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 791612ca6012..2e7833b33f12 100644
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
> +	  This driver controls a Analog Devices MAX77541 adc
ADC

> +	  via I2C bus. This device has one adc. Say yes here to build
> +	  support for Analog Devices MAX77541 ADC interface.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max77541-adc.
> +

...

> diff --git a/drivers/iio/adc/max77541-adc.c b/drivers/iio/adc/max77541-adc.c
> new file mode 100644
> index 000000000000..7ca8576bd4e1
> --- /dev/null
> +++ b/drivers/iio/adc/max77541-adc.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Analog Devices, Inc.
> + * ADI MAX77541 ADC Driver with IIO interface
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <include/linux/mfd/max77541.h>

Move this driver specific header include to below the main
block. We want to make it clear it is special.

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>

Would be very very surprised to see off_regulator.h correctly included
in an IIO driver.  Check all of these for whether they are necessary
(rather than cut and paste from another driver).

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
> +
> +enum {
> +	MAX77541_ADC_CH1_I = 0,
> +	MAX77541_ADC_CH2_I,
> +	MAX77541_ADC_CH3_I,
> +	MAX77541_ADC_CH6_I,
> +
> +	MAX77541_ADC_IRQMAX_I,
> +};
> +
> +struct max77541_adc_iio {
> +	struct regmap	*regmap;
> +	int irq;
> +	int irq_arr[MAX77541_ADC_IRQMAX_I];

Clear out unused elements until the follow up patch that actually makes
us of them. For now they are just distracting noise.

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

If the offset is zero, then don't have the interface.  Default
assumption if OFFSET is not provided is that the offset is 0.


> +	case MAX77541_ADC_TEMP:
> +		*val = -273;
> +		*val2 = 0;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max77541_adc_scale(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2)
> +{
> +	struct max77541_adc_iio *info = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	switch (chan->channel) {
> +	case MAX77541_ADC_VSYS_V:
> +		*val = 0;
> +		*val2 = 25000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case MAX77541_ADC_VOUT1_V:
> +		ret = regmap_read(info->regmap, MAX77541_REG_M2_CFG1, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		reg_val = FIELD_GET(MAX77541_BITS_MX_CFG1_RNG, reg_val);
> +
> +		*val = 0;
> +
> +		if (reg_val == LOW_RANGE)

Ah. Here is the mysterious macro from patch 1.  Bring that definition forwards
to this patch.  Also switch statement would be more readable here.

> +			*val2 = 6250;
> +		else if (reg_val == MID_RANGE)
> +			*val2 = 12500;
> +		else if (reg_val == HIGH_RANGE)
> +			*val2 = 25000;
> +		else
> +			return -EINVAL;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case MAX77541_ADC_VOUT2_V:
> +		ret = regmap_read(info->regmap, MAX77541_REG_M2_CFG1, &reg_val);

Umm. Is this identical to the above case?  If so, just have one block for
both.
  
> +		if (ret)
> +			return ret;
> +		reg_val = FIELD_GET(MAX77541_BITS_MX_CFG1_RNG, reg_val);
> +
> +		*val = 0;
> +
> +		if (reg_val == LOW_RANGE)
> +			*val2 = 6250;
> +		else if (reg_val == MID_RANGE)
> +			*val2 = 12500;
> +		else if (reg_val == HIGH_RANGE)
> +			*val2 = 25000;
> +		else
> +			return -EINVAL;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case MAX77541_ADC_TEMP:
> +		*val = 1;
> +		*val2 = 725000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

> +
> +static const struct iio_chan_spec max77541_adc_channels[] = {

Bring the macro definition down to just above this array. That will
make it easier to review as we can see the right parameters are being
passed in.   For 4 channels, I'm not sure I'd bother wrapping it in
a macro at all (particularly as that macro needs to be more
complex - see above), but I don't mind if you want to keep it that way.


I would also move this down below the iio_info definition because
that will keep all the code relevant to that in one place rather
than throwing this in the middle.

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
> +	struct max77541_dev *max77541;
> +	struct max77541_adc_iio *info;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +
> +	info->regmap = max77541->regmap;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->name = platform_get_device_id(pdev)->name;
> +	indio_dev->info = &max77541_adc_info;
> +	indio_dev->channels = max77541_adc_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max77541_adc_channels);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static const struct platform_device_id max77541_adc_platform_id[] = {
> +	{ "max77541-adc", MAX77541, },

Better to introduce the complexity given by the type only when it is needed.
So for now drop the .data values here and below.

If / when that does happen I'll be asking you to use a chip_info structure
anyway - right now that structure would be empty so no point in adding it
yet.

> +	{  /* sentinel */  }
> +};
> +MODULE_DEVICE_TABLE(platform, max77541_adc_platform_id);
> +
> +static const struct of_device_id max77541_adc_of_id[] = {
> +	{
> +		.compatible = "adi,max77541-adc",
> +		.data = (void *)MAX77541,
> +	},
> +	{  /* sentinel */  }
> +};
> +MODULE_DEVICE_TABLE(of, max77541_adc_of_id);
> +
> +static struct platform_driver max77541_adc_driver = {
> +	.driver = {
> +		.name = "max77541-adc",
> +		.of_match_table = max77541_adc_of_id,
> +	},
> +	.probe = max77541_adc_probe,
> +	.id_table = max77541_adc_platform_id,
> +};
> +
Drop blank line.  Macro and structure are very closely associated
so it's good to make that obvious by not separating them.
> +module_platform_driver(max77541_adc_driver);
> +
> +MODULE_AUTHOR("Okan Sahin <Okan.Sahin@analog.com>");
> +MODULE_DESCRIPTION("MAX77541 ADC driver");
> +MODULE_LICENSE("GPL");

