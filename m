Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508096A3302
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBZQ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBZQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:59:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722ECC22;
        Sun, 26 Feb 2023 08:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E51B80B4A;
        Sun, 26 Feb 2023 16:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A27C433EF;
        Sun, 26 Feb 2023 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677430748;
        bh=9rk4L89EqWvBEBrR3Fz3WmuIYDlt5Wb8V41+0wQdUVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SioZtASnrsoFcD11zv1hBykOitF2uJQdQNXTMRTBOhJ2Jird8tynAk34jieWEN4i8
         VSqVuMgeiDf1ABxK87nczPCwpW/N6KKTmJ3ySEC9ruCmnCzDSM+PMBOBER8l1ks7Gc
         hZVulI9+8WB9MxuVmuSxoVZfS/ve9b+b/uSfIivDq6BNhoJLB/r8Ph1TilfqMXtmfD
         LTwEe+nq8xmoHrqldgPh06XxQ/dyXnNsHMNphevM5fDlK34PHLPiyLXwXgRZ6Dy1Qb
         09+kwJnvK6sQVqTKbF6y5ANN5FuHC+t6c9xoJMpUdyfYkymkNByzFIzAyFpAD+vCGQ
         qGzG0G/jqPL8w==
Date:   Sun, 26 Feb 2023 17:13:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230226171329.4ff6ac8b@jic23-huawei>
In-Reply-To: <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
        <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
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

On Wed, 22 Feb 2023 18:15:58 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. Additionally 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has adjustible GAIN values ranging from 1x to 4096x.
> 	- Sensor has adjustible measurement times 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment only can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property which can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to adjust the GAIN so that the overall scale
> 	  is not changed.
> 	- Runtime PM is not implemented.
> 	- Driver starts the measurement on the background when it is
> 	  probed. This improves the respnse time to read-requests
> 	  compared to starting the read only when data is requested.
> 	  When the most accurate 400 mS measurement time is used, data reads
> 	  would last quite long if measurement was started only on
> 	  demand. This, however, is not appealing for users who would
> 	  prefere power saving over measurement response time.

I didn't dive into the maths in the luminance calculation ( I rarely do
as those things are horrible!), but otherwise just a few comments inline.

Thanks,

Jonathan

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> ---
>  drivers/iio/light/Kconfig        |   13 +
>  drivers/iio/light/Makefile       |    1 +
>  drivers/iio/light/rohm-bu27034.c | 1212 ++++++++++++++++++++++++++++++
>  3 files changed, 1226 insertions(+)
>  create mode 100644 drivers/iio/light/rohm-bu27034.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 671d84f98c56..594228bd1f7f 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -292,6 +292,19 @@ config JSA1212
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called jsa1212.
>  
> +config ROHM_BU27034
> +	tristate "ROHM BU27034 ambient light sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_GTS_HELPER
> +	help
> +	  Enable support for the ROHM BU27034 ambient light sensor.
> +	  ROHM BU27034 is an ambient light sesnor with 3 channels and
> +	  3 photo diodes capable of detecting a very wide range of
> +	  illuminance.
> +	  Typical application is adjusting LCD and backlight power
> +	  of TVs and mobile phones.

Short lines.  Wrap nearer 80 chars.

> +

> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> new file mode 100644
> index 000000000000..235be7dee6e0
> --- /dev/null
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -0,0 +1,1212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * BU27034 ROHM Ambient Light Sensor
> + *
> + * Copyright (c) 2023, ROHM Semiconductor.
> + * https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bu27034nuc-e.pdf
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I didn't see any custom attrs, so you shouldn't need this header.
Sometimes I think the main purpose of that header these days is to highlight drivers
where a careful look at the ABI is needed :)



> +/*
> + * The IC has 5 modes for sampling time. 5 mS mode is exceptional as it limits
> + * the data collection to data0-channel only and cuts the supported range to
> + * 10 bit. It is not aupported by the driver.
> + *
> + * "normal" modes are 55, 100, 200 and 400 mS modes - which do have direct
> + * multiplying impact to the register values similar to gain.
> + *
> + * This means that if meas-mode is changed for example from 400 => 200,
> + * the scale is doubled. Eg, time impact to total gain is x1, x2, x4, x8.
> + */
> +#define BU27034_MEAS_MODE_100MS		0
> +#define BU27034_MEAS_MODE_55MS		1
> +#define BU27034_MEAS_MODE_200MS		2
> +#define BU27034_MEAS_MODE_400MS		4
> +
> +static const struct iio_itime_sel_mul bu27034_itimes[] = {
> +	GAIN_SCALE_ITIME_MS(400, BU27034_MEAS_MODE_400MS, 8),
> +	GAIN_SCALE_ITIME_MS(200, BU27034_MEAS_MODE_200MS, 4),
> +	GAIN_SCALE_ITIME_MS(100, BU27034_MEAS_MODE_100MS, 2),
> +	GAIN_SCALE_ITIME_MS(50, BU27034_MEAS_MODE_55MS, 1),
> +};
> +
> +#define BU27034_CHAN_DATA(_name, _ch2)					\
> +{									\
> +	.type = IIO_INTENSITY,						\
> +	.channel = BU27034_CHAN_##_name,				\
> +	.channel2 = (_ch2),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),	\
> +	.address = BU27034_REG_##_name##_LO,				\
> +	.scan_index = BU27034_CHAN_##_name,				\
> +	.scan_type = {							\
> +		.sign = 'u',						\
> +		.realbits = 16,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_LE,					\

Unless you have buffered support, anything scan_* is unused and shouldn't be
set.

> +	},								\
> +	.indexed = 1							\
> +}
> +
> +static const struct iio_chan_spec bu27034_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.channel = BU27034_CHAN_ALS,
> +	},
> +	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
> +	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),

That's unusual. Why does it have two clear channels?
Perhaps add a comment on how they differ.  From a quick glance at the
datasheet they have different sensitivities, but indeed both in the visible
light range (mostly)

You could argue one is blue and one is red based on peaks of the curves but
they are very broad so perhaps clear is the best naming. 


> +	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
> +};

> +
> +static int bu27034_get_gain_sel(struct bu27034_data *data, int chan)
> +{
> +	int ret, val;
> +
> +	switch (chan) {
> +	case BU27034_CHAN_DATA0:
> +	case BU27034_CHAN_DATA1:
> +	{
> +		int reg[] = {
> +			[BU27034_CHAN_DATA0] = BU27034_REG_MODE_CONTROL2,
> +			[BU27034_CHAN_DATA1] = BU27034_REG_MODE_CONTROL3,
> +		};
> +		ret = regmap_read(data->regmap, reg[chan], &val);
> +		if (ret)
> +			return ret;
> +
> +		val &= BU27034_MASK_D01_GAIN;
> +		return val >> BU27034_SHIFT_D01_GAIN;
> +	}
> +	case BU27034_CHAN_DATA2:
> +		ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL2, &val);
> +		if (ret)
> +			return ret;
> +
> +		return (val & BU27034_MASK_D2_GAIN_HI) >> BU27034_SHIFT_D2_GAIN
> +		       | (val & BU27034_MASK_D2_GAIN_LO);
> +	}
> +
> +	dev_err(data->dev, "Can't get gain for channel %d\n", chan);

Given you should never get here, I'd drop the dev_err()

> +
> +	return -EINVAL;
> +}
> +


...

> +
> +static int bu27034_set_scale(struct bu27034_data *data, int chan,
> +			    int val, int val2)
> +{
> +	int ret, time_sel, gain_sel, i;
> +	bool found = false;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL1, &time_sel);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
> +						val, val2 * 1000, &gain_sel);
> +	if (ret) {
> +		/* We need to maintain the scale for all channels */
> +		int new_time_sel;
> +		struct bu27034_gain_check gains[2];
> +
> +		if (chan == BU27034_CHAN_DATA0) {
> +			gains[0].chan = BU27034_CHAN_DATA1;
> +			gains[1].chan = BU27034_CHAN_DATA2;
> +		} else if (chan == BU27034_CHAN_DATA1) {
> +			gains[0].chan = BU27034_CHAN_DATA0;
> +			gains[1].chan = BU27034_CHAN_DATA2;
> +		} else {
> +			gains[0].chan = BU27034_CHAN_DATA0;
> +			gains[1].chan = BU27034_CHAN_DATA1;
> +		}
> +		for (i = 0; i < 2; i++) {
> +			ret = bu27034_get_gain(data, gains[i].chan,
> +					       &gains[i].old_gain);
> +			if (ret)
> +				goto unlock_out;
> +		}
> +
> +		for (i = 0; i < data->gts.num_itime; i++) {
> +			new_time_sel = data->gts.itime_table[i].sel;
> +
> +			if (new_time_sel == time_sel)
> +				continue;
> +
> +			ret = iio_gts_find_gain_sel_for_scale_using_time(
> +				&data->gts, new_time_sel, val, val2 * 1000,
> +				&gain_sel);
> +			if (ret)
> +				continue;
> +
> +			ret = iio_gts_find_new_gain_sel_by_old_gain_time(
> +				&data->gts, gains[0].old_gain, time_sel,
> +				new_time_sel, &gains[0].new_gain);
> +			if (ret)
> +				continue;
> +
> +			ret = iio_gts_find_new_gain_sel_by_old_gain_time(
> +				&data->gts, gains[1].old_gain, time_sel,
> +				new_time_sel, &gains[1].new_gain);
> +			if (!ret) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			dev_err(data->dev,
> +				"Can't set scale maintaining other channels\n");
> +			ret = -EINVAL;
> +
> +			goto unlock_out;
> +		}
> +
> +		for (i = 0; i < 2; i++) {

Why twice?

> +			ret = _bu27034_set_gain(data, gains[0].chan,
> +						gains[0].new_gain);
> +			if (ret)
> +				goto unlock_out;
> +
> +			ret = _bu27034_set_gain(data, gains[1].chan,
> +						gains[1].new_gain);
> +			if (ret)
> +				goto unlock_out;
> +		}
> +
> +		ret = regmap_update_bits(data->regmap, BU27034_REG_MODE_CONTROL1,
> +				  BU27034_MASK_MEAS_MODE, new_time_sel);
> +		if (ret)
> +			goto unlock_out;
> +	}
> +
> +	ret = bu27034_write_gain_sel(data, chan, gain_sel);
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +

> +
> +static u64 bu27034_fixp_calc_t1(unsigned int coeff, unsigned int ch0,
> +				unsigned int ch1, unsigned int gain0,
> +				unsigned int gain1)
> +{
> +	unsigned int helper, tmp;
> +	u64 helper64;
> +
> +	/*
> +	 * Here we could overflow even the 64bit value. Hence we
> +	 * multiply with gain0 only after the divisions - even though
> +	 * it may result loss of accuracy
> +	 */
> +	helper64 = (u64)coeff * (u64)ch1 * (u64)ch1; /* * (u64)gain0 */
> +	helper = coeff * ch1 * ch1; /* * gain0*/
> +	tmp = helper * gain0;
> +
> +	if (helper == helper64 && (tmp / gain0 == helper))
> +		return tmp / (gain1 * gain1) / ch0;
> +
> +	helper = gain1 * gain1;
> +	if (helper > ch0) {
> +		do_div(helper64, helper);
> +		/*
> +		 * multiplication with max gain may overflow
> +		 * if helper64 is greater than 0xFFFFFFFFFFFFF.
> +		 *
> +		 * If this is the case we divide first.
> +		 */
> +		if (helper64 < 0xFFFFFFFFFFFFFLLU) {
as below.

> +			helper64 *= gain0;
> +			do_div(helper64, ch0);
> +		} else {
> +			do_div(helper64, ch0);
> +			helper64 *= gain0;
> +		}
> +
> +		return helper64;
> +	}
> +
> +	do_div(helper64, ch0);
> +	/* Same overflow check here */
> +	if (helper64 < 0xFFFFFFFFFFFFFLLU) {

Any simple bit of maths that can let us know why that is the overflow check?

> +		helper64 *= gain0;
> +		do_div(helper64, helper);
> +	} else {
> +		do_div(helper64, helper);
> +		helper64 *= gain0;
> +	}
> +
> +	return helper64;
> +}
> +

...

> +static bool bu27034_has_valid_sample(struct bu27034_data *data)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL4, &val);
> +	if (ret)
> +		dev_err(data->dev, "Read failed %d\n", ret);
> +
> +	return (val & BU27034_MASK_VALID);
> +}
> +
> +static void bu27034_invalidate_read_data(struct bu27034_data *data)
> +{
> +	bu27034_has_valid_sample(data);
Not obvious that a read of that register invalidates anything.  Perhaps a comment to that affect?

> +}
> +
> +static int _bu27034_get_result(struct bu27034_data *data, u16 *res, bool lock)
> +{
> +	int ret = 0;
> +
> +retry:
> +	if (lock)
> +		mutex_lock(&data->mutex);
> +	/* Get new value from sensor if data is ready - or use cached value */
> +	if (bu27034_has_valid_sample(data)) {
> +		ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
> +				       &data->raw[0], sizeof(data->raw));
> +		if (ret)
> +			goto unlock_out;
> +
> +		data->cached = true;
> +		bu27034_invalidate_read_data(data);
> +	} else if (unlikely(!data->cached)) {
> +		/* No new data in sensor and no value cached. Wait and retry */
> +		if (lock)
> +			mutex_unlock(&data->mutex);

Hmm. We don't really need to fix this in driver. Could just return -EAGAIN and let
userspace work out that it needs to try again after a while?
I guess not all userspace is going to be smart enough to handle that though and
you need this to ensure we get a new value after a parameter change.


If you do that then the locking dance gets much simpler.

> +		msleep(25);
> +
> +		goto retry;
> +	}
> +	res[0] = le16_to_cpu(data->raw[0]);
> +	res[1] = le16_to_cpu(data->raw[1]);
> +	res[2] = le16_to_cpu(data->raw[2]);
> +
> +unlock_out:
> +	if (lock)
> +		mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bu27034_get_result_unlocked(struct bu27034_data *data, u16 *res)
> +{
> +	return _bu27034_get_result(data, res, false);
> +}
> +
> +static int bu27034_get_result(struct bu27034_data *data, u16 *res)
> +{
> +	return _bu27034_get_result(data, res, true);
> +}
> +
> +/*
> + * The formula given by vendor for computing luxes out of data0 and data1
> + * (in open air) is as follows:
> + *
> + * Let's mark:
> + * D0 = data0/ch0_gain/meas_time_ms * 25600
> + * D1 = data1/ch1_gain/meas_time_ms * 25600
> + *
> + * Then:
> + * if (D1/D0 < 0.87)
> + *	lx = (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 3.45 + 1)
> + * else if (D1/D0 < 1)
> + *	lx = (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 0.385 + 1)
> + * else
> + *	lx = (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 2) * -0.05 + 1)
> + *
> + * we try implementing it here. Users who have for example some colored lens

There is no try, there is just do :)

> + * need to modify the calculation but I hope this gives a starting point for
> + * those working with such devices.

That will need some dt bindings - though for now I guess we have no idea
what they would be unless there are some hints on the datasheet?

> + *
> + * The first case (D1/D0 < 0.87) can be computed to a form:
> + * lx = 0.004521097 * D1 - 0.002663996 * D0 + 0.00012213 * D1 * D1 / D0
> + */
> +static int bu27034_get_lux(struct bu27034_data *data, int *val)
> +{
> +	unsigned int gain0, gain1, meastime;
> +	unsigned int d1_d0_ratio_scaled;
> +	u16 res[3], ch0, ch1;
> +	u64 helper64;
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = bu27034_get_result_unlocked(data, &res[0]);

res
as it is expecting a point to an array so that is more natural than pointing
to the first element even if that's the same result.

> +	if (ret)
> +		goto unlock_out;
> +
> +	/* Avoid div by zero */
> +	if (!res[0])

res[0] = max(1, res[0]); perhaps?

> +		ch0 = 1;
> +	else
> +		ch0 = res[0];
> +
> +	if (!res[1])
> +		ch1 = 1;
> +	else
> +		ch1 = res[1];
> +
> +
> +	ret = bu27034_get_gain(data, BU27034_CHAN_DATA0, &gain0);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = bu27034_get_gain(data, BU27034_CHAN_DATA1, &gain1);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = bu27034_get_int_time(data);
> +	if (ret < 0)
> +		goto unlock_out;
> +
> +	meastime = ret;
> +
> +	mutex_unlock(&data->mutex);
> +
> +	d1_d0_ratio_scaled = (unsigned int)ch1 * (unsigned int)gain0 * 100;
> +	helper64 = (u64)ch1 * (u64)gain0 * 100LLU;
> +
> +	if (helper64 != d1_d0_ratio_scaled) {
> +		unsigned int div = (unsigned int)ch0 * gain1;
> +
> +		do_div(helper64, div);
> +		d1_d0_ratio_scaled = helper64;
> +	} else {
> +		d1_d0_ratio_scaled /= ch0 * gain1;
> +	}
> +
> +	if (d1_d0_ratio_scaled < 87)
> +		*val = bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 0);
> +	else if (d1_d0_ratio_scaled < 100)
> +		*val = bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 1);
> +	else
> +		*val = bu27034_fixp_calc_lx(ch0, ch1, gain0, gain1, meastime, 2);
> +
> +	return 0;
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +

...

> +
> +static int bu27034_meas_dis(struct bu27034_data *data)
> +{
> +	return bu27034_meas_set(data, false);

Don't bother with wrappers that do so little - just call meas_set

> +}
> +
> +static int bu27034_read_raw(struct iio_dev *idev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bu27034_data *data = iio_priv(idev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
Why?

> +
> +		ret = bu27034_get_int_time(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * We use 50000 uS internally for all calculations and only
> +		 * convert it to 55000 before returning it to the user.
> +		 *
> +		 * This is becaise data-sheet says the time is 55 mS - but
> +		 * vendor provided computations used 50 mS.
> +		 */
> +		if (ret == 50000)
> +			ret = 55000;

Set val directly rather than dancing with ret here.

> +
> +		*val2 = 0;
> +		*val = ret;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;

val2 looks to always be zero in which case IIO_VAL_INT
and drop setting val2.

> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = bu27034_get_scale(data, chan->channel, val, val2);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		u16 res[3];
> +
> +		if (chan->type != IIO_INTENSITY)
> +			return -EINVAL;
> +
> +		if (chan->channel < BU27034_CHAN_DATA0 ||
> +		    chan->channel > BU27034_CHAN_DATA2)
> +			return -EINVAL;
> +		/*
> +		 * Reading one channel at a time is inefficient.
> +		 *
> +		 * Hence we run the measurement on the background and always
> +		 * read all the channels. There are following caveats:
> +		 * 1) The VALID bit handling is racy. Valid bit clearing is not
> +		 * tied to reading the data in the hardware. We clear the
> +		 * valid-bit manually _after_ we have read the data - but this
> +		 * means there is a small time-window where new result may
> +		 * arrive between read and clear. This means we can miss a
> +		 * sample. For normal use this should not be fatal because
> +		 * usually the light is changing slowly. There might be
> +		 * use-cases for measuring more rapidly changing light but this
> +		 * driver is unsuitable for those cases anyways. (Smallest
> +		 * measurement time we support is 55 mS.)

Given there is no general fix for that, not much you can do even if you don't want to
miss the data.

> +		 * 2) Data readings more frequent than the meas_time will return
> +		 * the same cached values. This should not be a problem for the
> +		 * very same reason 1) is not a problem.

Hmm. I'm never that keen on drivers doing that if we can avoid it but perhaps we
can't here.

> +		 */
> +		ret = bu27034_get_result(data, &res[0]);
> +		if (ret)
> +			return ret;
> +
> +		*val = res[chan->channel - BU27034_CHAN_DATA0];
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type != IIO_LIGHT)
> +			return -EINVAL;
> +
> +		ret = bu27034_get_lux(data, val);
> +		if (ret)
> +			return ret;

Trivial. Blank line here and in similar places after error checks and before
an unconnected statement preferred.

> +		return IIO_VAL_INT;
> +
> +	}
> +
Pull into the switch as a default for same reason given below.

> +	return -EINVAL;
> +}
> +
> +static int bu27034_write_raw(struct iio_dev *idev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct bu27034_data *data = iio_priv(idev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return bu27034_set_scale(data, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return bu27034_try_set_int_time(data, val);
one of the static analysis bots likes to complain about unhandled cases.
Cut that off by
	default:
		return -EINVAL;
and drop the one below.

Same for similar cases. It's possible the bot has become less fussy about this,
but making the default explicit is good practice anyway as helps long term maintainability
when the code gets more complex.

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info bu27034_info = {
> +	.read_raw = &bu27034_read_raw,
> +	.write_raw = &bu27034_write_raw,
> +};
> +
> +static void bu27034_meas_stop(void *data)
> +{
> +	bu27034_meas_dis(data);
> +}
> +
> +static int bu27034_chip_init(struct bu27034_data *data)
> +{
> +	int ret;
> +
> +	/* Reset */
> +	ret = regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
> +			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> +
> +	/*
> +	 * Delay to allow IC to initialize. We don't care if we delay
> +	 * for more than 1 ms so msleep() is Ok. We just don't want to
> +	 * block

The msleep bit is kind of obvious for a reset. I'd not bother documenting that
detail.

> +	 */
> +	msleep(1);
> +
> +	/*
> +	 * Consider disabling the measurement (and powering off the sensor) for
> +	 * runtime pm

Notes like this probably want to go away once the driver is 'finished'.

> +	 */
> +	ret = bu27034_meas_en(data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(data->dev, bu27034_meas_stop, data);
> +}
> +
> +static int bu27034_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct fwnode_handle *fwnode;
> +	struct bu27034_data *data;
> +	struct regmap *regmap;
> +	struct iio_dev *idev;
> +	unsigned int part_id;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &bu27034_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	fwnode = dev_fwnode(dev);

why do we care?  So far this should work fine with the other types of i2c
probe.

> +	if (!fwnode)
> +		return -ENODEV;
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vdd");
vdd isn't optional - or at least it would be an unusual device that doesn't
need that supply line.

Key here is that optional in DT is different from this call.
If not present in DT and devm_regulator_get_enable() called then we'll normally
get a stub regulator.

The aim of optional for regulators is to handle the case where the driver does
something different if a particular supply isn't there.  An example would be
a reference voltage to a device that also has an internal regulator. If the vref
isn't there, we set the device to use the internal reference.

> +	if (ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> +
> +	data = iio_priv(idev);
> +
> +	ret = regmap_read(regmap, BU27034_REG_SYSTEM_CONTROL, &part_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> +
> +	part_id &= BU27034_MASK_PART_ID;
> +
> +	if (part_id != BU27034_ID) {
> +		dev_err(dev, "unsupported device 0x%x\n", part_id);

Fallback compatibles require that on a failure to match ID we still let the driver
carry on.  However we can print something in the log to say we don't recognise
the device.  The intent is that at future part can be supported by old kernels just
be having the dt list multiple compatibles if the device really are backwards
compatible with parts already supported.

> +		return -EINVAL;
> +	}
> +
> +	ret = iio_init_iio_gts(BU27034_SCALE_1X, 0, bu27034_gains,
> +			       ARRAY_SIZE(bu27034_gains), bu27034_itimes,
> +			       ARRAY_SIZE(bu27034_itimes), &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +	data->regmap = regmap;
> +	data->dev = dev;
> +
> +	idev->channels = bu27034_channels;
> +	idev->num_channels = ARRAY_SIZE(bu27034_channels);
> +	idev->name = "bu27034-als";

If the chip doesn't have a multiple functions (and multiple iio_devs), we'd normally
not bother with the als part in the name.  Add a comment if there is a reason for
it here.

> +	idev->info = &bu27034_info;

