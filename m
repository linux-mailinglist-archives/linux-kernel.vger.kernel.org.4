Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1E667EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjALTF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjALTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:05:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86A50F46;
        Thu, 12 Jan 2023 10:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC3ACB82000;
        Thu, 12 Jan 2023 18:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3BDC433D2;
        Thu, 12 Jan 2023 18:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673549216;
        bh=beTLX8wVanUtiVrqyrlWyk1oYUEFK7MToGsQsZDav3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZAW/2TCHillUFHn6kzE581lomTCM+v69wM64+SwqhE5+OGX2kfYBIBpMrLfXAI8zM
         3USZ3eS5YZlSrn7DgffJheeJ7fyMWtLFWxWyQaIih8TaxrmtrBCb4uHUjaUCErot/G
         EmUnVsCCCqqtss/cm9QffsztcFhxEHXfPQ4cu02r+JlmnADW1OiZmUkjUwrFdVxczu
         YCsTqdY4NuFwBB9YIDJEBpp5/1JpF92O2wdexdVXbd3cWFsmXQ+WTruKmJPUqiBxWK
         zDVWTINdETOa3S1iXps0bsfYlNxZtPORj766fxXN1nbEXJIoYAj/ci3pQtTSVGTS9z
         gKoGihBW5aOWQ==
Date:   Thu, 12 Jan 2023 19:00:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
Message-ID: <20230112190030.37b9ea2f@jic23-huawei>
In-Reply-To: <20230110160124.3853593-2-hugo@hugovil.com>
References: <20230110160124.3853593-1-hugo@hugovil.com>
        <20230110160124.3853593-2-hugo@hugovil.com>
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

On Tue, 10 Jan 2023 11:01:23 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> digital converter (ADC) with an I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads7924
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hi Hugo,

A few minor additional comments from me as you are doing a v3
(I might just have tidied them up whilst applying otherwise to save
us all time!) 

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> new file mode 100644
> index 000000000000..8384f3451236
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Texas Instruments ADS7924 ADC, 12-bit, 4-Channels, I2C
> + *
> + * iio/adc/ti-ads7924.c

Not a huge amount of point in having a file name in the file.  I don't mind
if you really want it though.

> + * Author: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> + * Copyright 2022 DimOnOff
> + *
> + * based on iio/adc/ti-ads1015.c
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/ads7924
> + */

> +
> +#define ADS7924_TOTAL_CONVTIME_US (ADS7924_PWRUPTIME_US + ADS7924_ACQTIME_US + \
> +				   ADS7924_CONVTIME_US)
> +
> +#define ADS7924_SLEEP_DELAY_MS		2000

Unused, so drop for now.

> +static bool ads7924_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ADS7924_MODECNTRL_REG:
> +	case ADS7924_INTCNTRL_REG:
> +	case ADS7924_ULR0_REG:
> +	case ADS7924_LLR0_REG:
> +	case ADS7924_ULR1_REG:
> +	case ADS7924_LLR1_REG:
> +	case ADS7924_ULR2_REG:
> +	case ADS7924_LLR2_REG:
> +	case ADS7924_ULR3_REG:
> +	case ADS7924_LLR3_REG:
> +	case ADS7924_INTCONFIG_REG:
> +	case ADS7924_SLPCONFIG_REG:
> +	case ADS7924_ACQCONFIG_REG:
> +	case ADS7924_PWRCONFIG_REG:
> +	case ADS7924_RESET_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config ads7924_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADS7924_RESET_REG,
> +	.writeable_reg = ads7924_is_writeable_reg,
> +};
> +
> +static const struct iio_chan_spec ads7924_channels[] = {
> +	ADS7924_V_CHAN(0, ADS7924_DATA0_U_REG),
> +	ADS7924_V_CHAN(1, ADS7924_DATA1_U_REG),
> +	ADS7924_V_CHAN(2, ADS7924_DATA2_U_REG),
> +	ADS7924_V_CHAN(3, ADS7924_DATA3_U_REG),
> +};
> +
> +static
> +int ads7924_get_adc_result(struct ads7924_data *data,

Drop the unusual line break as not needed (probably refactoring left over!) 
static int ...

> +			   struct iio_chan_spec const *chan, int *val)
> +{
> +	int ret;
> +	__be16 be_val;
> +
> +	if (chan->channel < 0 || chan->channel >= ADS7924_CHANNELS)
> +		return -EINVAL;
> +
> +	if (data->conv_invalid) {
> +		int conv_time;
> +
> +		conv_time = ADS7924_TOTAL_CONVTIME_US;
> +		/* Allow 10% for internal clock inaccuracy. */
> +		conv_time += conv_time / 10;
> +		usleep_range(conv_time, conv_time + 1);
> +		data->conv_invalid = false;
> +	}
> +
> +	ret = regmap_raw_read(data->regmap, ADS7924_AUTO_INCREMENT_BIT |
> +			      chan->address, &be_val, sizeof(be_val));
> +	if (ret)
> +		return ret;
> +
> +	*val = be16_to_cpu(be_val);
> +	*val = *val >> ADS7924_DATA_SHIFT;
	*val = be16_to_cpu(be_val) >> ADS7924_DATA_SHIFT;

	return 0;

> +
> +	return ret;
> +}
> +
> +static int ads7924_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret, vref_uv;
> +	struct ads7924_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		mutex_lock(&data->lock);
> +		ret = ads7924_get_adc_result(data, chan, val);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			dev_dbg(data->dev, "%s error1\n", __func__);
> +		else
> +			ret = IIO_VAL_INT;
		if (ret < 0) {
			... 
			return ret;
		}

		return IIO_VAL_INT;
		
> +		break;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		vref_uv = regulator_get_voltage(data->vref_reg);
> +		if (vref_uv < 0) {
> +			/* dummy regulator "get_voltage" returns -EINVAL */
> +			ret = -EINVAL;
			return -EINVAL;
> +		} else {
> +			*val =  vref_uv / 1000; /* Convert reg voltage to mV */
> +			*val2 = ADS7924_BITS;
> +			ret = IIO_VAL_FRACTIONAL_LOG2;
			return IIO_VAL_FR...

> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
		return -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ads7924_info = {
> +	.read_raw	= ads7924_read_raw,
The tabbed indent doesn't add anything so 
	.read_raw = ads...

Aligning things is often a bad idea anyway as it just adds noise when inevitably
the alignment needs increasing...  Definitely not worth doing for one item.

> +};
> +
> +static int ads7924_get_channels_config(struct i2c_client *client,
> +				       struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *priv = iio_priv(indio_dev);
> +	struct device *dev = priv->dev;
> +	struct fwnode_handle *node;
> +	int num_channels = 0;
> +
> +	device_for_each_child_node(dev, node) {
> +		u32 pval;
> +		unsigned int channel;
> +
> +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n", node);
> +			continue;
> +		}
> +
> +		channel = pval;
> +		if (channel >= ADS7924_CHANNELS) {
> +			dev_err(dev, "invalid channel index %d on %pfw\n",
> +				channel, node);
> +			continue;
> +		}
> +
> +		num_channels++;
> +	}
> +
> +	if (num_channels > 0) {
> +		dev_dbg(dev, "found %d ADC channels\n", num_channels);
> +		return 0;
> +	} else {

As per other review.  Give us what we expect which is error paths
as out of line. 

> +		return -EINVAL;
> +	}
> +}

> +static int ads7924_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *data = iio_priv(indio_dev);
> +
> +	if (data->reset_gpio) {
> +		gpiod_set_value(data->reset_gpio, 1); /* Assert. */
> +		/* Educated guess: assert time not specified in datasheet... */
> +		mdelay(100);
> +		gpiod_set_value(data->reset_gpio, 0); /* Deassert. */

No real point in shared exit path. Early returns mean less code to look at
when following particular flows which is always nice.

		return 0;

> +	} else {

if returning above, no need to have the else {

> +		int ret;
> +
> +		/*
> +		 * A write of 10101010 to this register will generate a
> +		 * software reset of the ADS7924.
> +		 */
> +		ret = regmap_write(data->regmap, ADS7924_RESET_REG, 0b10101010);
> +		if (ret)
> +			return ret;
		return regmap_write(....)

> +	}
> +
> +	return 0;
and drop this.
> +};

> +static int ads7924_probe(struct i2c_client *client)
> +{

...

> +	ret = devm_add_action_or_reset(dev, ads7924_set_idle_mode, data);

The _or_reset() part of this is there so that if this function fails
it will call the callback before returning an error code.  As a result
you will turn the device, before you've ever turned it on.

Register the callback after turning it on, so ...
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to add idle mode action\n");
> +
> +	ret = ads7924_set_conv_mode(data, ADS7924_MODECNTRL_AUTO_SCAN);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to set conversion mode\n");

... here.  
