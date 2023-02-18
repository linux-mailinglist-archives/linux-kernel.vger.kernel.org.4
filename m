Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EF169BB03
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 17:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBRQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 11:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBRQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:34:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99EA1284A;
        Sat, 18 Feb 2023 08:34:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 732E5B801B9;
        Sat, 18 Feb 2023 16:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DA7C4339B;
        Sat, 18 Feb 2023 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676738055;
        bh=qLeF/l+5CCj+mTJO3g1AWEhq2TVBR6PWhZsAH/Lcm/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dSX5K8d8hZkGJaUKUM7nNp2WbIdZQlWBHzumxE5vvfOhwhxMcXh1lMZUPLybMD9jm
         hl6cRGVZ7I/9i3PfkGvEI+cNA/MBPKSWUw4p0c5gEAs1tKf0H2HuTHp+oThDHIcEAl
         QZloCOrbHNBrdVJeFtvt+yv+m3d7fTtHwXsN38oEYtqIVPVpS3byEdcr3AcG//SBVt
         1dq8Szfafi+zPNhCzkaFuSGr/GZjUA/Slt24rTKCelyRagj0ymzIsbD6oD7X8DI/04
         E+HpNG1HCpryOQMtSRVRBoROK+co17hTKws+8EC9nYounSTQrjaDCVGk+TIBacWjqM
         BcPejREfgh/Og==
Date:   Sat, 18 Feb 2023 16:48:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add driver for TI ADS1100 and ADS1000
 chips
Message-ID: <20230218164832.695fe5b5@jic23-huawei>
In-Reply-To: <20230217093128.8344-2-mike.looijmans@topic.nl>
References: <20230217093128.8344-1-mike.looijmans@topic.nl>
        <20230217093128.8344-2-mike.looijmans@topic.nl>
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

On Fri, 17 Feb 2023 10:31:28 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The ADS1100 is a 16-bit ADC (at 8 samples per second).
> The ADS1000 is similar, but has a fixed data rate.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Hi Mike,

I probably overlapped a lot in here with what Andy said, so just ignore
anything you've already fixed.

Biggest thing is HARDWAREGAIN.
That is very rarely used with ADCs.  It exists to support cases where
the gain is not directly coupled to the thing being measured (light
sensitivity of a time of flight sensor for example).  Userspace expects
to use SCALE to both control amplifier gains and to multiply with
the _raw value to get a value in the real world units.

It's a bit fiddly to do the computation, but typically at start up time
you work out what the combination of each PGA gain and the reference
voltage means for the scales available and stash that somewhere to use later.

As per the docs in Documentation/ABI/testing/sysfs-bus-iio userspace is
expected to get real units (here millivolts) from

(_raw + _offset) * _scale
where _offset = 0 if not provided. Hence any front end amplification needs
to be taken into account for _scale and _scale_available

Thanks,

Jonathan

> 
> ---
> 
>  drivers/iio/adc/Kconfig      |  12 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1100.c | 467 +++++++++++++++++++++++++++++++++++
>  3 files changed, 480 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1100.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 63f80d747cbd..bc1918d87f8e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1207,6 +1207,18 @@ config TI_ADS1015
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1015.
>  
> +config TI_ADS1100
> +	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
> +	depends on I2C
> +	select IIO_BUFFER

No sign of buffers yet so shouldn't need the dependency

> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS1100 and
> +	  ADS1000 ADC chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads1100.
> +
>  config TI_ADS7950
>  	tristate "Texas Instruments ADS7950 ADC driver"
>  	depends on SPI && GPIOLIB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 4ef41a7dfac6..61ef600fab99 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> +obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> diff --git a/drivers/iio/adc/ti-ads1100.c b/drivers/iio/adc/ti-ads1100.c
> new file mode 100644
> index 000000000000..0b0d3e5b6bd6
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1100.c
> @@ -0,0 +1,467 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADS1100 - Texas Instruments Analog-to-Digital Converter
> + *
> + * Copyright (c) 2023, Topic Embedded Products
> + *
> + * IIO driver for ADS1100 and ADS1000 ADC 16-bit I2C
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/iio/sysfs.h>

I doubt you need this last header. It's only needed for
non standard ABI definitions.

> +
> +#define ADS1100_DRV_NAME "ads1100"
Just put this inline.  There is no particular
reason the driver name and the iio device name will be the
same so I'd prefer to see the string in each place rather
than using a define hidden up here.
> +
> +/* The ADS1100 has a single byte config register */
> +
> +/* Conversion in progress bit */
> +#define ADS1100_CFG_ST_BSY	BIT(7)
> +/* Single conversion bit */
> +#define ADS1100_CFG_SC		BIT(4)
> +/* Data rate */
> +#define ADS1100_DR_MASK		(BIT(3) | BIT(2))
GENMASK(3, 2)

same for similar cases.

> +#define ADS1100_DR_SHIFT	2
> +/* Gain */
> +#define ADS1100_PGA_MASK	(BIT(1) | BIT(0))
> +
> +#define ADS1100_CONTINUOUS	0
> +#define	ADS1100_SINGLESHOT	ADS1100_CFG_SC
> +
> +#define ADS1100_SLEEP_DELAY_MS	2000
> +
> +static const int ads1100_data_rate[] = {128, 32, 16, 8};
> +static const int ads1100_data_rate_scale[] = {2048, 8192, 16384, 32768};
> +static const int ads1100_gain[] = {1, 2, 4, 8};
> +
> +struct ads1100_data {
> +	struct i2c_client *client;
> +	struct regulator *reg_vdd;
> +	struct mutex lock;
> +	u8 config;
> +	bool supports_data_rate; /* Only the ADS1100 can select the rate */
> +};
> +
> +static const struct iio_chan_spec ads1100_channel = {
> +	.type = IIO_VOLTAGE,
> +	.differential = 0,
> +	.indexed = 0,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_all =
> +				BIT(IIO_CHAN_INFO_SCALE) |
> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_shared_by_all_available =
> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |

Hardware gain is normally only used for cases where the gain is not
directly related to scale.  Things like the gain on a signal that is
being used for measuring time of flight.  Here you should probably
just be using SCALE.


> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 16,
> +		.shift = 0,

Default of 0 is kind of obvious for shift, so no need to explicitly set it.
C will fill it with a 0 anyway.

> +		.endianness = IIO_CPU,
> +	},
> +	.datasheet_name = "AIN",
> +};
> +
> +static int ads1100_set_config_bits(struct ads1100_data *data, u8 mask, u8 value)
> +{
> +	int ret;
> +	u8 config = (data->config & ~mask) | value;
> +
> +	if (data->config == config)
> +		return 0; /* Already done */
> +
> +	ret = i2c_master_send(data->client, &config, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->config = config;
> +	return 0;
> +};
> +
> +static int ads1100_set_conv_mode(struct ads1100_data *data, u8 flag)
> +{
> +	return ads1100_set_config_bits(data, ADS1100_CFG_SC, flag);

This wrapper doesn't feel very useful. Make the call directly.


> +};
> +
> +static int ads1100_data_rate_index(struct ads1100_data *data)
> +{
> +	return (data->config & ADS1100_DR_MASK) >> ADS1100_DR_SHIFT;
FIELD_GET()
> +}
> +
> +static int ads1100_pga_index(struct ads1100_data *data)
> +{

> +	return (data->config & ADS1100_PGA_MASK);
No need for brackets

Also just use FIELD_GET() instead.

> +}
> +
> +/* Calculate full-scale value */
> +static int ads1100_full_scale(struct ads1100_data *data)
> +{
> +	return ads1100_data_rate_scale[ads1100_data_rate_index(data)] *
> +			ads1100_gain[ads1100_pga_index(data)];
> +
> +}
> +
> +#ifdef CONFIG_PM
> +static int ads1100_set_power_state(struct ads1100_data *data, bool on)
> +{
> +	int ret;
> +	struct device *dev = &data->client->dev;


This function makes the code harder to read.  Just make the
pm_runtime_* calls directly but for the put don't check the
return value (as it will be set to an error when runtime PM not built)

It also tends to be unhelpful to fail the caller based on failure
to autosuspend.



> +
> +	if (on) {
> +		ret = pm_runtime_resume_and_get(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret = pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +#else /* !CONFIG_PM */
> +
> +static int ads1100_set_power_state(struct ads1100_data *data, bool on)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_PM */
> +
> +static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
> +{
> +	int ret;
> +	u8 buffer[2];

__le16 buffer;

> +
> +	if (chan != 0)
> +		return -EINVAL;
> +
> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
> +		return ret;
> +	}
> +
> +	*val = (s16)(((u16)buffer[0] << 8) | buffer[1]);

	*val = sign_extend32(le16_to_cpu(), 15);

> +	return 0;
> +}
> +
> +static int ads1100_set_gain(struct ads1100_data *data, int gain)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1100_gain); ++i) {
> +		if (ads1100_gain[i] == gain) {
> +			return ads1100_set_config_bits(
> +						data, ADS1100_PGA_MASK, i);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
> +{
> +	int i;
> +	int size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> +
> +	for (i = 0; i < size; ++i) {
> +		if (ads1100_data_rate[i] == rate) {
> +			return ads1100_set_config_bits(
> +				data, ADS1100_DR_MASK, i << ADS1100_DR_SHIFT);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1100_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = ads1100_data_rate;
> +		if (data->supports_data_rate)
> +			*length = ARRAY_SIZE(ads1100_data_rate);
> +		else
> +			*length = 1;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*type = IIO_VAL_INT;
> +		*vals = ads1100_gain;
> +		*length = ARRAY_SIZE(ads1100_gain);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads1100_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int ret;
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
> +	dev_info(&data->client->dev, "%s %ld\n", __func__, mask);
Definitely shouldn't be having prints in here. I guess left over
from debugging during development.

> +
> +	mutex_lock(&data->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			break;
> +
> +		ret = ads1100_set_power_state(data, true);

As above. Make the runtime pm calls directly for better readablity.

> +		if (ret < 0)
> +			goto release_direct;
> +
> +		ret = ads1100_get_adc_result(data, chan->address, val);
> +		if (ret < 0) {
> +			ads1100_set_power_state(data, false);
As you won't be checking pm_runtime_put_autosuspend() return value
(see above) you can do this as

		ret = ads110_get_adc_result(...)
		pm_runtime_put_autosuspend()
		if (ret < 0) {
		}
rather than having the autosuspend call in two places.

> +			goto release_direct;
> +		}
> +
> +		ret = ads1100_set_power_state(data, false);
> +		if (ret < 0)
> +			goto release_direct;
> +
> +		ret = IIO_VAL_INT;
> +release_direct:

labels within case statements are not nice to read. I'd just factor
some of this code out to a separate function so you don't need to
do that.  Ideally leave the claim_direct out side of the function
and then all the returns within it become simpler.


> +		iio_device_release_direct_mode(indio_dev);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(data->reg_vdd);
> +		if (ret > 0) {
> +			/* full-scale is the supply voltage (microvolts now) */
> +			*val = ret / 1000; /* millivolts, range 27000..50000 */
> +			*val2 = 1000 * ads1100_full_scale(data);

This doesn't seem to take into account the PGA gain?  Userspace is only going
to apply _raw * _scale to get the real world units.


> +			ret = IIO_VAL_FRACTIONAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ads1100_data_rate[ads1100_data_rate_index(data)];
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*val = ads1100_gain[ads1100_pga_index(data)];
> +		*val2 = 0;
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int ads1100_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = ads1100_set_gain(data, val);

As above, would expect this to be SCALE for an ADC.

> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads1100_set_data_rate(data, chan->address, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ads1100_info = {
> +	.read_avail	= ads1100_read_avail,
> +	.read_raw	= ads1100_read_raw,
> +	.write_raw	= ads1100_write_raw,
> +};
> +
> +static int ads1100_setup(struct ads1100_data *data)
> +{
> +	int ret;
> +	u8 buffer[3];
> +
> +	/* Setup continuous sampling mode at 8sps */
> +	buffer[0] = ADS1100_DR_MASK | ADS1100_CONTINUOUS;
> +	ret = i2c_master_send(data->client, buffer, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(data->client, buffer, sizeof(buffer));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Config register returned in third byte, strip away the busy status */
> +	data->config = buffer[2] & ~ADS1100_CFG_ST_BSY;
> +
> +	/* Detect the sample rate capability by checking the DR bits */
> +	data->supports_data_rate = !!(buffer[2] & ADS1100_DR_MASK);

FIELD_GET() != 0
is probably more readable.

> +
> +	return 0;
> +}
> +
> +static int ads1100_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1100_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = ADS1100_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &ads1100_channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ads1100_info;
> +
> +	data->reg_vdd = devm_regulator_get(&client->dev, "vdd");
> +	if (IS_ERR(data->reg_vdd))
> +		return PTR_ERR(data->reg_vdd);
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret < 0)
> +		return ret;

As below. You should be able to use devm_add_action_or_reset()
to disable the regulator in the remove path (and on error after this
point).

> +
> +	ret = ads1100_setup(data);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to communicate with device\n");
> +		goto exit_regulator;
> +	}
> +
> +	ret = pm_runtime_set_active(&client->dev);
> +	if (ret)
> +		goto exit_regulator;
> +
> +	pm_runtime_set_autosuspend_delay(&client->dev, ADS1100_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_enable(&client->dev);
As below comment suggests, you can use devm_pm_runtime_enable()
which also fixes that fact you aren't turning off autosuspend
(which is a bug as the documentation for use_autosuspend states)

> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +exit_regulator:
> +	regulator_disable(data->reg_vdd);
> +	return ret;
> +}
> +
> +static void ads1100_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
Always read a remove path with it in mind that runtime pm might not
be in use at all.  Everything must still work.
As such, I'd expect to see a disable of the regulator in here
(or even better in a devm_add_action_or_reset())

Also would expect to first ensure the device is in a known
state with a pm_runtime_get() - which will be a noop if
runtime pm isn't in use (and hence the device is powered up between
probe and remove) 


> +	iio_device_unregister(indio_dev);
> +
> +	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
> +
> +	pm_runtime_disable(&client->dev);

I'd expect runtime pm to be disable before messing with the conv mode.
With a little care you can use devm_runtime_pm_enable()

> +	pm_runtime_set_suspended(&client->dev);
I'd expect this to be handled immediately after the 
set of the conv mode to suspended.  Which will be fine if you
have moved the runtime pm before that.

Once those are together you can just group them in a devm_add_action_or_reset()
callback and make the whole remove process devm managed.

> +}
> +
> +#ifdef CONFIG_PM

Addressed in other branch of this thread. So I won't comment more.

> +static int ads1100_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +
> +	ads1100_set_conv_mode(data, ADS1100_SINGLESHOT);
> +	regulator_disable(data->reg_vdd);
> +
> +	return 0;
> +}
> +
> +static int ads1100_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1100_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->reg_vdd);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to enable Vdd\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * We'll always change the mode bit in the config register, so there is
> +	 * no need here to "force" a write to the config register. If the device
> +	 * has been power-cycled, we'll re-write its config register now.
> +	 */
> +	return ads1100_set_conv_mode(data, ADS1100_CONTINUOUS);
> +}
> +#endif
> +
> +static const struct dev_pm_ops ads1100_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ads1100_runtime_suspend,
> +			   ads1100_runtime_resume, NULL)
> +};
> +
