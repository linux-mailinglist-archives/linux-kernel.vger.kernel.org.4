Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18FA67F9CD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjA1RTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjA1RTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:19:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557FC298D3;
        Sat, 28 Jan 2023 09:19:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAACFB80B6F;
        Sat, 28 Jan 2023 17:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F81C433D2;
        Sat, 28 Jan 2023 17:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674926376;
        bh=Sld33yFkm47ppc48WVE+Rl1Bw96GVNy9qyeuB7qPJ3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C8e4M/xuAAHCzIKDEcI4muhTsQGrWNHY/JOvi3CROSXS932SNHkvaqw2/iaaYGnYd
         BeYg2eQFTf4Wy2Z79SkKtDxgmvqDwggN/x0htSEk5ztJsADkB6tzwn1m/D3nLGB8fx
         85ysYQJOtVYO1LTIpMCnUOkr7j4UREmnhKS/f1hUNY1SbrXx35SBZk1RY0yMPNkFBk
         I2NEvw8INUh+11fWThqTqpzlIi1IaUpT4auuBFfiYcNjiS7dE7AwVZaElTTQ0TR+Kz
         99Z8wDXEUwyKxgMNTNOnOeDAgUF6oqonoICy62mBYdrLOMLFa7siQTc0NK/6oNBpuJ
         RxZUiqNLQg4xA==
Date:   Sat, 28 Jan 2023 17:33:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: Add support for AMS TCS3490 light
 sensor
Message-ID: <20230128173326.0a083e04@jic23-huawei>
In-Reply-To: <20230123231028.26073-3-markuss.broks@gmail.com>
References: <20230123231028.26073-1-markuss.broks@gmail.com>
        <20230123231028.26073-3-markuss.broks@gmail.com>
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

On Tue, 24 Jan 2023 01:10:25 +0200
Markuss Broks <markuss.broks@gmail.com> wrote:

> Add a driver for AMS TCS3490 Color Light-to-Digital Converter. This
> device provides color and IR (red, green, blue, clear and IR) light
> sensing. The color sensing can be used for light source detection and
> color temperature measurements.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

Hi Markuss,

I'll probably duplicate some of Andy's review (as it's always very
thorough!) but maybe some new stuff inline.

Jonathan


> ---
>  MAINTAINERS                 |   7 +
>  drivers/iio/light/Kconfig   |  12 ++
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/tcs3490.c | 270 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 drivers/iio/light/tcs3490.c

>  AMT (Automatic Multicast Tunneling)
>  M:	Taehee Yoo <ap420073@gmail.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 0d4447df7200..582e3853e835 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -494,6 +494,18 @@ config TCS3472
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tcs3472.
>  
> +config TCS3490
> +	tristate "AMS TCS3490 color light-to-digital converter"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

No Buffered support in here yet. So these dependencies don't make sense.

> +	help
> +	  Say Y here if you have an AMS TCS3490 color light-to digital converter
> +	  which provides RGB color and IR light sensing.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tcs3490.
> +
>  config SENSORS_TSL2563

> diff --git a/drivers/iio/light/tcs3490.c b/drivers/iio/light/tcs3490.c
> new file mode 100644
> index 000000000000..6fa2c220a6a1
> --- /dev/null
> +++ b/drivers/iio/light/tcs3490.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AMS TCS3490 Color Light-to-Digital Converter
> + *
> + * Copyright (c) 2023 Markuss Broks <markuss.broks@gmail.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define TCS3490_SUSPEND			0
Probably want to call

Good to make a clear difference between register defines
and fields within the register + make it clear which
register they are in.  Lots of ways of doing this. e.g.

#define TSC3490_ENABLE_REG		0
#define   TSC3490_ENABLE_POWER_ON_INTERNAL	BIT(0)
...

> +#define TCS3490_POWER_ON_INTERNAL	BIT(0)
> +#define TCS3490_ADC_ENABLE		BIT(1)
> +
> +#define TCS3490_ENABLE			0x80
> +#define TCS3490_GAIN_CTRL		0x8f
> +#define TCS3490_REVID			0x91
> +#define TCS3490_ID			0x92
> +#define TCS3490_STATUS			0x93
> +
> +#define TCS3490_CLEAR_IR_BASE		0x94
> +#define TCS3490_RED_BASE		0x96
> +#define TCS3490_GREEN_BASE		0x98
> +#define TCS3490_BLUE_BASE		0x9a
> +
> +#define TCS3490_CLEAR_IR_MODE		0xc0
> +
> +#define TCS3490_STATUS_RGBC_VALID	BIT(0)
> +#define TCS3490_STATUS_ALS_SAT		BIT(7)
> +
> +#define TCS3490_MODE_CLEAR		0
> +#define TCS3490_MODE_IR			BIT(7)
> +
> +#define TCS3490_GAIN_MASK		GENMASK(1, 0)
> +
> +#define TCS3490_LIGHT_CHANNEL(_color, _idx) {		\
> +	.type = IIO_INTENSITY,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type =			\
> +			BIT(IIO_CHAN_INFO_CALIBSCALE),	\

I couldn't quickly figure it out from the datasheet, but calibscale
usually only applies to small 'calibration' tweaks.

For values like this I'd expect changing the scale to have
equivalent affect on the _raw output and so userspace would
need to compensate.  That would make it IIO_CHAN_INFO_SCALE

So that the actual value would be calculated by userspace as

	_raw * _scale

I've just noticed we don't seem to have ABI docs
for in_intensity_blue_raw or in_intensity_blue_scale etc
Documentation/ABI/testing/sysfs-bus-iio

That wants fixing though doesn't need to be in the same series
as this patch.  If you want to propose such a patch that would
be great! (I might take a while to get to it if not).

> +	.address = _idx,				\
> +	.modified = 1,					\
> +	.channel2 = IIO_MOD_LIGHT_##_color,		\
> +}							\
> +
> +struct tcs3490 {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct regulator *vdd_supply;
> +};
> +
> +const unsigned int tcs3490_gain_multiplier[] = {1, 4, 16, 64};
> +
> +static const struct regmap_config tcs3490_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,

This sort of attempt to align structure elements bites back in the long
ruin. Don't bother ;)

	.reg_bits = 8,

> +};
> +
> +static const struct iio_chan_spec tcs3490_channels[] = {
> +	TCS3490_LIGHT_CHANNEL(RED, TCS3490_RED_BASE),
> +	TCS3490_LIGHT_CHANNEL(GREEN, TCS3490_GREEN_BASE),
> +	TCS3490_LIGHT_CHANNEL(BLUE, TCS3490_BLUE_BASE),
> +	TCS3490_LIGHT_CHANNEL(CLEAR, TCS3490_CLEAR_IR_BASE),
> +	TCS3490_LIGHT_CHANNEL(IR, TCS3490_CLEAR_IR_BASE),
> +};
> +
> +static int tcs3490_get_gain(struct tcs3490 *data, int *val)
> +{
> +	int ret;
> +	unsigned int gain;
> +
> +	ret = regmap_read(data->regmap, TCS3490_GAIN_CTRL, &gain);
> +	if (ret)
> +		return ret;
> +
> +	gain &= TCS3490_GAIN_MASK;

FIELD_GET() preferred as then I don't need to look at whether GAIN_MASK
is aligned to LSB.

> +
> +	*val = tcs3490_gain_multiplier[gain];

blank line before simple returns like this tends to be slightly more readable.

> +	return 0;
> +}
> +
> +static int tcs3490_set_gain(struct tcs3490 *data, unsigned int gain)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcs3490_gain_multiplier); i++) {
> +		if (tcs3490_gain_multiplier[i] == gain)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(tcs3490_gain_multiplier))
> +		return -EINVAL;
> +
> +	ret = regmap_write(data->regmap, TCS3490_GAIN_CTRL, i);

return regmap_write()

This sort of unnecessary checking of ret for last entries tends to get
picked up by some of the scripts that get run on the kernel so if
you leave it like this we'll just get patches 'improving' it anyway.
Better to tidy up now.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int tcs3490_read_channel(struct tcs3490 *data,
> +				const struct iio_chan_spec *chan,
> +				int *val)
> +{
> +	unsigned int tries = 20;

Comment needed on why 20 is appropriate in combination with the usleep_range
values.  Probably push setting tries down to just above that loop so that
the comment can cover both tries and the usleep_range parameter

> +	unsigned int val_l, val_h, status;
> +	int ret;
> +

Complex cycle and could be called multiple times if multiple processes read
different channels at same times, so needs a locally defined lock.
(Andy raised this)

> +	ret = regmap_write(data->regmap, TCS3490_ENABLE,
> +			   TCS3490_POWER_ON_INTERNAL | TCS3490_ADC_ENABLE);

Perhaps consider runtime PM with autosuspend (could be a future patch set)
so we leave the device powered up for a while after a read in case someone is
doing lots of reads.  Will reduce time needed to get a value (probably - I've
not checked datasheet that closely)  However, won't be easy to tell you have
a fresh value as we only know it's new once after ADC_ENABLE was set.
Maybe best to leave this suggestion for a possible future follow up patch.

> +	if (ret)
> +		return ret;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_LIGHT_RED:
> +	case IIO_MOD_LIGHT_GREEN:
> +	case IIO_MOD_LIGHT_BLUE:
> +		break;
> +	case IIO_MOD_LIGHT_CLEAR:
> +		ret = regmap_write(data->regmap, TCS3490_CLEAR_IR_MODE, TCS3490_MODE_CLEAR);
check ret.
> +		break;
> +	case IIO_MOD_LIGHT_IR:
> +		ret = regmap_write(data->regmap, TCS3490_CLEAR_IR_MODE, TCS3490_MODE_IR);
check ret.
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	do {
> +		usleep_range(3000, 4000);
> +
> +		ret = regmap_read(data->regmap, TCS3490_STATUS, &status);
> +		if (ret)
> +			return ret;
> +		if (status & TCS3490_STATUS_RGBC_VALID)
> +			break;
> +	} while (--tries);
> +
> +	if (!tries)
> +		return -ETIMEDOUT;
> +
> +	ret = regmap_read(data->regmap, chan->address, &val_l);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, chan->address + 1, &val_h);
> +	if (ret)
> +		return ret;
> +
> +	*val = (val_h << 8) | val_l;

Andy mentioned bulk read.  Definitely a good idea combined with appropriate
endian conversion.

> +
> +	ret = regmap_write(data->regmap, TCS3490_ENABLE, TCS3490_SUSPEND);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return regmap_write() 


> +}
> +
> +static int tcs3490_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tcs3490 *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = tcs3490_read_channel(data, chan, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = IIO_VAL_INT;

return IIO_VAL_INT;

> +		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = tcs3490_get_gain(data, val);
> +		ret = IIO_VAL_INT;
return IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
return -EINVAL;
> +		break;
> +	}
> +
won't be able to get here so all this code goes.

> +	if (ret < 0)
> +		return ret;
> +	return IIO_VAL_INT;
> +}
> +
> +static int tcs3490_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct tcs3490 *data = iio_priv(indio_dev);
> +
> +	if (mask == IIO_CHAN_INFO_CALIBSCALE)
> +		return tcs3490_set_gain(data, val);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info tcs3490_info = {
> +	.read_raw = tcs3490_read_raw,
> +	.write_raw = tcs3490_write_raw,
> +};
> +
> +static int tcs3490_probe(struct i2c_client *client)
> +{
> +	struct tcs3490 *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->client = client;
> +
> +	data->vdd_supply = devm_regulator_get(&client->dev, "vdd");

devm_regulator_get_enable() as you don't need to access the regulator
other than turning it on.  That simplifies handling of regulators
that are only turned on with driver probe and off with remove.

> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get regulators\n");
> +
> +	data->regmap = devm_regmap_init_i2c(client, &tcs3490_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "Failed to register the register map\n");
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Unable to enable regulators\n");
> +
> +	indio_dev->name = "tcs3490";
> +	indio_dev->info = &tcs3490_info;
> +	indio_dev->channels = tcs3490_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tcs3490_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = regmap_write(data->regmap, TCS3490_ENABLE, TCS3490_SUSPEND);

Naming of value vs register is confusing.  See above.
Writing 0 to a register called _ENABLE is probably clear enough that you
don't need the _SUSPEND define which is odd anyway as all other defines
for this register refer to specific bits whereas this is 'all bits not set'.

	ret = regmap_write(data->regmap, TCS3490_ENABLE_REG, 0);


> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct of_device_id tcs3490_of_match[] = {
> +	{ .compatible = "ams,tcs3490", },
> +	{ },

No need for comma after anything that acts as a NULL terminator
as we'll never have anything after it.

> +};
> +MODULE_DEVICE_TABLE(of, tcs3490_of_match);
> +
> +static struct i2c_driver tcs3490_driver = {
> +	.driver = {
> +		.name = "tcs3490",
> +		.of_match_table = of_match_ptr(tcs3490_of_match),
Drop the of_match_ptr()
> +	},
> +	.probe_new = tcs3490_probe,
> +};
> +
> +module_i2c_driver(tcs3490_driver);
> +
> +MODULE_DESCRIPTION("AMS TCS3490 Color Light-to-Digital Converter driver");
> +MODULE_AUTHOR("Markuss Broks <markuss.broks@gmail.com>");
> +MODULE_LICENSE("GPL");

