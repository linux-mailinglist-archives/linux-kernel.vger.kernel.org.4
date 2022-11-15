Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64462A087
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKORjt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 12:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiKORjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:39:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A502E9C1;
        Tue, 15 Nov 2022 09:39:40 -0800 (PST)
Received: from frapeml500007.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBYGX6BfYz686vL;
        Wed, 16 Nov 2022 01:35:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 18:39:37 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 17:39:37 +0000
Date:   Tue, 15 Nov 2022 17:39:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <20221115173935.0000508a@Huawei.com>
In-Reply-To: <20221115073718.2377311-3-gerald.loacker@wolfvision.net>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
        <20221115073718.2377311-3-gerald.loacker@wolfvision.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 08:37:18 +0100
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.
> 
> Datasheet: https://www.ti.com/lit/gpn/tmag5273
> 
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
Hi Gerald,

Some comments inline.

Jonathan


> diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
> new file mode 100644
> index 000000000000..549ed1ddba61
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tmag5273.c
> @@ -0,0 +1,809 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor
> + *
> + * Copyright (C) 2022 WolfVision GmbH
> + *
> + * Author: Gerald Loacker <gerald.loacker@wolfvision.net>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define TMAG5273_DEVICE_CONFIG_1	 0x00
> +#define TMAG5273_DEVICE_CONFIG_2	 0x01
> +#define TMAG5273_SENSOR_CONFIG_1	 0x02
> +#define TMAG5273_SENSOR_CONFIG_2	 0x03
> +#define TMAG5273_X_THR_CONFIG		 0x04
> +#define TMAG5273_Y_THR_CONFIG		 0x05
> +#define TMAG5273_Z_THR_CONFIG		 0x06
> +#define TMAG5273_T_CONFIG		 0x07
> +#define TMAG5273_INT_CONFIG_1		 0x08
> +#define TMAG5273_MAG_GAIN_CONFIG	 0x09
> +#define TMAG5273_MAG_OFFSET_CONFIG_1	 0x0A
> +#define TMAG5273_MAG_OFFSET_CONFIG_2	 0x0B
> +#define TMAG5273_I2C_ADDRESS		 0x0C
> +#define TMAG5273_DEVICE_ID		 0x0D
> +#define TMAG5273_MANUFACTURER_ID_LSB	 0x0E
> +#define TMAG5273_MANUFACTURER_ID_MSB	 0x0F
> +#define TMAG5273_T_MSB_RESULT		 0x10
> +#define TMAG5273_T_LSB_RESULT		 0x11
> +#define TMAG5273_X_MSB_RESULT		 0x12
> +#define TMAG5273_X_LSB_RESULT		 0x13
> +#define TMAG5273_Y_MSB_RESULT		 0x14
> +#define TMAG5273_Y_LSB_RESULT		 0x15
> +#define TMAG5273_Z_MSB_RESULT		 0x16
> +#define TMAG5273_Z_LSB_RESULT		 0x17
> +#define TMAG5273_CONV_STATUS		 0x18
> +#define TMAG5273_ANGLE_RESULT_MSB	 0x19
> +#define TMAG5273_ANGLE_RESULT_LSB	 0x1A
> +#define TMAG5273_MAGNITUDE_RESULT	 0x1B
> +#define TMAG5273_DEVICE_STATUS		 0x1C
> +
> +#define TMAG5273_MANUFACTURER_ID	 0x5449
> +
> +#define TMAG5273_AUTOSLEEP_DELAY	 5000
> +
> +/* Bits in the TMAG5273_DEVICE_CONFIG_1 register */
> +#define TMAG5273_AVG_MODE_MASK		 GENMASK(4, 2)
> +#define TMAG5273_AVG_1_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 0)
> +#define TMAG5273_AVG_2_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 1)
> +#define TMAG5273_AVG_4_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 2)
> +#define TMAG5273_AVG_8_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 3)
> +#define TMAG5273_AVG_16_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 4)
> +#define TMAG5273_AVG_32_MODE		 FIELD_PREP(TMAG5273_AVG_MODE_MASK, 5)
> +
> +/* bits in the TMAG5273_DEVICE_CONFIG_2 register */
> +#define TMAG5273_OP_MODE_MASK		 GENMASK(1, 0)
> +#define TMAG5273_OP_MODE_STANDBY	 FIELD_PREP(TMAG5273_OP_MODE_MASK, 0)
> +#define TMAG5273_OP_MODE_SLEEP		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 1)
> +#define TMAG5273_OP_MODE_CONT		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 2)
> +#define TMAG5273_OP_MODE_WAKEUP		 FIELD_PREP(TMAG5273_OP_MODE_MASK, 3)
> +
> +/* bits in the TMAG5273_SENSOR_CONFIG_1 register */
> +#define TMAG5273_MAG_CH_EN_MASK		 GENMASK(7, 4)
> +#define TMAG5273_MAG_CH_EN_X_Y_Z	 0x07
> +
> +/* bits in the TMAG5273_SENSOR_CONFIG_2 register */
> +#define TMAG5273_Z_RANGE_MASK		 BIT(0)
> +#define TMAG5273_X_Y_RANGE_MASK		 BIT(1)
> +#define TMAG5273_ANGLE_EN_MASK		 GENMASK(3, 2)
> +#define TMAG5273_ANGLE_EN_X_Y		 1
> +#define TMAG5273_ANGLE_EN_Y_Z		 2
> +#define TMAG5273_ANGLE_EN_X_Z		 3
> +
> +/* bits in the TMAG5273_T_CONFIG register */
> +#define TMAG5273_T_CH_EN		 BIT(0)
> +
> +/* bits in the TMAG5273_DEVICE_ID register */
> +#define TMAG5273_VERSION_MASK		 GENMASK(1, 0)
> +
> +/* bits in the TMAG5273_CONV_STATUS register */
> +#define TMAG5273_CONV_STATUS_COMPLETE	 BIT(0)
> +
> +/* state container for the TMAG5273 driver */
> +struct tmag5273_data {
> +	struct device *dev;
> +	unsigned int devid;
> +	unsigned int version;
> +	char name[16];
> +	int conv_avg;
> +	int max_avg;
> +	int range;
> +	u32 angle_en;
> +	struct regmap *map;
> +	struct regulator *vcc;
> +	/* Locks the sensor for exclusive use during a measurement (which
> +	 * involves several register transactions so the regmap lock is not
> +	 * enough) so that measurements get serialized in a first-come-first-
> +	 * serve manner.
> +	 */
> +	struct mutex lock;
> +};
> +
> +static const struct {
> +	int avg;
> +	u8 reg_val;
> +} tmag5273_avg_table[] = {
> +	{ 1, 0x00 }, { 2, 0x01 },  { 4, 0x02 },
> +	{ 8, 0x03 }, { 16, 0x04 }, { 32, 0x05 },
> +};
> +
> +/*
> + * magnetic range in mT for different TMAG5273 versions
> + * only version 1 and 2 are valid, version 0 and 3 are reserved
> + */
> +static const struct {
> +	int range;
> +	u8 reg_val;
> +} tmag5273_range_table[4][2] = {
> +	{ { 0, 0 }, { 0, 3 } },
> +	{ { 40, 0 }, { 80, 3 } },
> +	{ { 133, 0 }, { 266, 3 } },
> +	{ { 0, 0 }, { 0, 3 } },
> +};
> +
> +/*
/**

It's kernel doc style, so mark it as such, but also run the kernel doc
script over it and fix any warnings.

> + * tmag5273_measure() - Make a measure from the hardware
> + * @tmag5273: The device state
> + * @t: the processed temperature measurement
> + * @x: the raw x axis measurement
> + * @y: the raw x axis measurement
> + * @z: the raw x axis measurement
> + * @angle: the calculated angle
> + * @magnitude: the calculated magnitude
> + * @return: 0 on success or error code
> + */
> +static int tmag5273_measure(struct tmag5273_data *data, u16 *t, u16 *x, u16 *y,
> +			    u16 *z, u16 *angle, u16 *magnitude)
> +{
> +	unsigned int status;
> +	u8 reg_data[12];
> +	int ret;
> +	u16 val;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_read(data->map, TMAG5273_CONV_STATUS, &status);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	/*
> +	 * Conversion time is 2425 us in 32x averaging mode for all three
> +	 * channels. Since we are in continuous measurement mode, a measurement
> +	 * may already be there, so poll for completed measurement with
> +	 * timeout.

Ideally adjust timeout to match what we expect for current mode. Can be a later
optimization if you prefer.

> +	 */
> +	ret = regmap_read_poll_timeout(data->map, TMAG5273_CONV_STATUS, status,
> +				       status & TMAG5273_CONV_STATUS_COMPLETE,
> +				       100, 10000);
> +	if (ret) {
> +		dev_err_probe(data->dev, ret, "timeout waiting for measurement\n");
> +		goto out_unlock;
> +	}
> +
> +	ret = regmap_bulk_read(data->map, TMAG5273_T_MSB_RESULT, reg_data,
> +			       sizeof(reg_data));
Is there a need to read it in bulk?  Seems like it makes sense for the first 8 registers.
If you split it there those can go directly into __be16 reg_data[4]
then you can do a 2 byte read to get the angle and a separate one byte read to get the
magnitude.

Not as efficient though so maybe this dance is worthwhile.

> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = regmap_read(data->map, TMAG5273_CONV_STATUS, &status);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	mutex_unlock(&data->lock);
> +
> +	*t = get_unaligned_be16(&reg_data[0]);
> +	*x = get_unaligned_be16(&reg_data[2]);
> +	*y = get_unaligned_be16(&reg_data[4]);
> +	*z = get_unaligned_be16(&reg_data[6]);
As below - drop these directly into the s16 variables rather than going via a u16.
> +	/*
> +	 * angle has 9 bits integer value and 4 bits fractional part
> +	 * 15 14 13 12 11 10 9  8  7  6  5  4  3  2  1  0
> +	 * 0  0  0  a  a  a  a  a  a  a  a  a  f  f  f  f
> +	 */
> +	val = get_unaligned_be16(&reg_data[9]);
> +	*angle = FIELD_GET(GENMASK(12, 0), val);
> +	*magnitude = reg_data[11];
> +	return ret;
> +
> +out_unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/*
> + * tmag5273_get_measure() - Measure a sample of all axis and process
> + * @tmag5273: The device state
> + * @to: Temperature out
> + * @xo: X axis out
> + * @yo: Y axis out
> + * @zo: Z axis out
> + * @ao: Angle out
> + * @mo: Magnitude out
> + * @return: 0 on success or error code
> + */
> +static int tmag5273_get_measure(struct tmag5273_data *data, s32 *to, s32 *xo,
> +				s32 *yo, s32 *zo, u16 *ao, u16 *mo)
> +{
> +	u16 t, x, y, z, angle, magnitude;

If these are signed, use signed variables.

> +	int ret;
> +
> +	ret = tmag5273_measure(data, &t, &x, &y, &z, &angle, &magnitude);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * convert device specific value to millicelsius
> +	 * use multiply by 16639 and divide by 10000 to achieve divide by 60.1
> +	 *   and convert to millicelsius
> +	 */
> +	*to = (((s32)t - 17508) * 16639) / 1000 + 25000;

That looks like it should be presented as a _raw channel and the offset
and scale exported to userspace (which is much better at doign this sort of maths)

> +	*xo = (s16)x;
> +	*yo = (s16)y;
> +	*zo = (s16)z;

If these are 16 bit, why expand to 32 bits?  Also if you are doing that
do it with sign_extend32() not like this so it is clear wht is going on.

> +	*ao = angle;
> +	*mo = magnitude;
> +	return 0;
> +}
> +
> +static int tmag5273_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	s32 t, x, y, z;
> +	u16 angle, magnitude;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pm_runtime_resume_and_get(data->dev);
> +		if (ret < 0)
> +			return ret;

blank line here.

> +		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle,
> +					   &magnitude);
> +		if (ret)
> +			return ret;

blank line here.

> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +		switch (chan->scan_index) {
Better to use chan->addr and put enum values in there for the
different channels.  scan_index has a different purpose that you
aren't yet supporting in this driver (buffered mode / chardev
access).

> +		case 0:
> +			*val = t;
return IIO_VAL_INT;
in each of these rather than break.

> +			break;
> +		case 1:
> +			*val = x;
> +			break;
> +		case 2:
> +			*val = y;
> +			break;
> +		case 3:
> +			*val = z;
> +			break;
> +		case 4:
> +			*val = angle;
> +			break;
> +		case 5:
> +			*val = magnitude;
> +			break;
> +		default:
> +			return dev_err_probe(data->dev, -EINVAL, "unknown channel\n");

Not in probe, so not appropriate to use dev_err_probe().

> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/* 1 LSB = 1 millidegree Celsius */

Don't expose scale if it's already in the base units.
You can't get here anyway as you haven't set relevant bit in the mask 
for the temp channesl.

> +			*val = 1;
> +			return IIO_VAL_INT;
> +		case IIO_MAGN:
> +			/*
> +			 * The axis values are in stored in 2^15 / range LSB/mT.
> +			 * Since 1 mT = 10 Gauss, we need to multiply by 10 and
> +			 * divide by [range] to get Gauss from the raw value.
> +			 */
> +			*val = data->range * 10;
> +			*val2 = 32768;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_ANGL:
> +			/*
> +			 * Angle is in degrees and has four fractional bits,
> +			 * therefore use 1/16 * pi/180 to convert to radiants.
> +			 */
> +			*val = 1000;
> +			*val2 = 916732;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_DISTANCE:
> +			/* Magnitude is unscaled */

If it's unscaled then don't provide a scale and make it a raw reading
not a processed one.  This is common for various types of proximity sensor
where we don't have any way to know the scaling.

> +			*val = 1;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		/* Unknown request */
> +		return -EINVAL;
> +	}
> +}

> +static struct attribute *tmag5273_attributes[] = {
> +	&iio_dev_attr_conv_avg.dev_attr.attr,
> +	&iio_dev_attr_conv_avg_available.dev_attr.attr,

Needs documentation so we can review what it is for and see if it either
fits with existing ABI or we need new generic ABI.
Documentation/ABI/testing/sysfs-bus-iio-*

Superficially I'm guessing this is an oversampling control and we
have standard ABI for that.


> +	&iio_dev_attr_range.dev_attr.attr,
> +	&iio_dev_attr_range_available.dev_attr.attr,

It's rare we allow a range attribute. I most cases the same can be derived
from SCALE plus available for the raw channel.
There have been a few really obscure corner cases where it has been only way
of exposing things, but those always came with detailed justification.

> +	NULL,

No trailing comma on NULL terminators.

> +};
> +
> +static const struct attribute_group tmag5273_attrs_group = {
> +	.attrs = tmag5273_attributes,
> +};
> +
> +#define TMAG5273_AXIS_CHANNEL(axis, index)                         \
> +	{                                                          \
> +		.type = IIO_MAGN,				   \
> +		.modified = 1,					   \
> +		.channel2 = IIO_MOD_##axis,                        \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |     \
> +				      BIT(IIO_CHAN_INFO_SCALE),    \
> +		.scan_index = index,                               \
> +		.scan_type = {                                     \
> +			.sign = 's',                               \
> +			.realbits = 32,                            \
> +			.storagebits = 32,                         \

From above these seem to be 16 bit...

> +			.endianness = IIO_CPU,                     \
> +		},                                                 \
> +	}
> +
> +static const struct iio_chan_spec tmag5273_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	TMAG5273_AXIS_CHANNEL(X, 1),
> +	TMAG5273_AXIS_CHANNEL(Y, 2),
> +	TMAG5273_AXIS_CHANNEL(Z, 3),
> +	{
> +		.type = IIO_ANGL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 4,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
Is it processed, or is it 
> +		.scan_index = 5,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(6),
> +};

...

> +
> +static int tmag5273_chip_init(struct tmag5273_data *data)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->map, TMAG5273_DEVICE_CONFIG_1,
> +			   TMAG5273_AVG_32_MODE);
> +	if (ret)
> +		return ret;
> +	data->conv_avg = 32;
Blank line here to separate blocks doing more or less unconnected things.

> +	ret = regmap_write(data->map, TMAG5273_DEVICE_CONFIG_2,
> +			   TMAG5273_OP_MODE_CONT);

Register a devm_add_action_or_reset() to handle putting it in 
sleep in error paths / remove().

> +	if (ret)
> +		return ret;
Blank line here helps readability a little.
> +	ret = regmap_write(data->map, TMAG5273_SENSOR_CONFIG_1,
> +			   FIELD_PREP(TMAG5273_MAG_CH_EN_MASK,
> +				      TMAG5273_MAG_CH_EN_X_Y_Z));
> +	if (ret)
> +		return ret;
and here

> +	ret = regmap_write(data->map, TMAG5273_SENSOR_CONFIG_2,
> +			   FIELD_PREP(TMAG5273_ANGLE_EN_MASK, data->angle_en));
> +	if (ret)
> +		return ret;
> +
> +	data->range = tmag5273_range_table[data->version][0].range;
> +	return regmap_write(data->map, TMAG5273_T_CONFIG, TMAG5273_T_CH_EN);
> +}
> +
> +static int tmag5273_probe(struct i2c_client *i2c,
> +			  const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &i2c->dev;
> +	struct device_node *node = dev->of_node;
> +	struct tmag5273_data *data;
> +	int val, ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(i2c, indio_dev);
> +	data->dev = dev;
> +	mutex_init(&data->lock);
> +
> +	data->vcc = devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(data->vcc))
> +		return dev_err_probe(dev, PTR_ERR(data->vcc),
> +				     "failed to get VCC regulator\n");
> +
> +	/* Operating voltage 1.7V .. 3.6V according to datasheet */

That is normally considered a job for device tree binding or similar rather than
a driver to configure it. AS such, can probably just use
devm_regulator_get_enabled() and drop the need to manually turn it off again



> +	ret = regulator_set_voltage(data->vcc, 1700000, 3600000);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set VCC voltage\n");
> +
> +	ret = regulator_enable(data->vcc);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable VCC regulator\n");
> +
> +	/*
> +	 * Regulators have to ramp up with 3V/ms, additional time to go to
> +	 * stand-by mode is 270us typically. We give 1 ms to 2 ms time.

That should be a problem for the regulator driver, not this one.
The regulator_enable() should not return until it is powered up and we can carry
on.

> +	 */
> +	usleep_range(1000, 2000);
> +
> +	data->map = devm_regmap_init_i2c(i2c, &tmag5273_regmap_config);
> +	if (IS_ERR(data->map)) {
> +		ret = PTR_ERR(data->map);
> +		dev_err_probe(dev, ret, "failed to allocate register map\n");
> +		goto out_disable_vcc;
> +	}
> +
> +	ret = regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
> +	if (ret) {
> +		/*
> +		 * If we come from sleep with power already activated, the
> +		 * first I2C command wakes up the chip but will fail.

Minor but I'd make this unconditional. It's a small cost in probe() time but
simplifies the code flow a little.


> +		 * Time to go to stand-by mode from sleep mode is 50us
> +		 * typically. During this time no I2C access is possible.
> +		 */
> +		usleep_range(80, 200);
> +
> +		ret = regmap_read(data->map, TMAG5273_DEVICE_ID, &val);
> +		if (ret)
> +			goto out_disable_vcc;
> +	}
> +	data->version = FIELD_PREP(TMAG5273_VERSION_MASK, val);
> +
> +	ret = regmap_bulk_read(data->map, TMAG5273_MANUFACTURER_ID_LSB,
> +			       &data->devid, 2);
> +	if (ret)
> +		goto out_disable_vcc;
> +
> +	switch (data->devid) {
> +	case TMAG5273_MANUFACTURER_ID:
> +		strncpy(data->name, "TMAG5273", sizeof(data->name) - 2);

Lowercase preferred as much more common for IIO device names.
(no idea why, but we have ended up like that ;)

I'd also be lazy / efficient as there are only two names

		switch (data->version) {
		case 1:
			indio_dev->name = "tmag5273x1";
			break;
		case 2:
			indio_dev->name = "tmag5273x2";
			break;
		default:
		 	return -ENODEV; //after switch to devm for everything.
		}	
> +		switch (data->version) {
> +		case 1:
> +			strncat(data->name, "x1", 2);
> +			break;
> +		case 2:
> +			strncat(data->name, "x2", 2);
> +			break;
> +		default:
> +			break;
> +		}
> +		dev_info(dev, "%s", data->name);
		noisy so don't print it. Can read from sysfs anyway.
> +		data->max_avg = 32;

		Given this is only valid option, why is it in here?

> +		break;
> +	default:
> +		ret = -ENODEV;

We generally only warn on such cases.  Often manufacturers spin new versions
of chips that are compatible enough that we give them a fallback compatible
in device tree.  That is only a useful thing to do if they'll 'work' with old
drivers.   A warning that it might be the wrong device is considered fine though.
"Unknown device ID...

Bit tricky in this case as we have to pick between two values for some things.
Chopse a default maybe?


> +		dev_err_probe(dev, ret, "unhandled device ID 0x%x\n", data->devid);
> +		goto out_disable_vcc;
> +	}
> +
> +	/*
> +	 * Angle-enable is optional and set to 1 (enable X-Y plane) by default,
> +	 * the value is modified only if a valid u32 value can be decoded.
> +	 */
> +	data->angle_en = TMAG5273_ANGLE_EN_X_Y;
> +	of_property_read_u32(node, "tmag5273,angle-enable", &data->angle_en);

Use generic firmware properties linux/property.h so this will work with other
types of firmware.

> +
> +	ret = tmag5273_chip_init(data);
> +	if (ret)
> +		goto out_disable_vcc;
> +
> +	indio_dev->info = &tmag5273_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = data->name;
> +	indio_dev->channels = tmag5273_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tmag5273_channels);
> +
> +	pm_runtime_set_autosuspend_delay(dev, TMAG5273_AUTOSLEEP_DELAY);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		goto out_disable_vcc;
> +	pm_runtime_enable(dev);

devm_pm_runtime_enable()

> +	pm_runtime_idle(dev);

Why idle rather than a pm_runtime_put_autosuspend()?

> +
> +	ret = iio_device_register(indio_dev);
devm_iio_device_register()

> +	if (ret) {
> +		dev_err_probe(dev, ret, "device register failed\n");
> +		goto cleanup_runtime;
> +	}
> +
> +	return 0;
> +
> +cleanup_runtime:
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
> +out_disable_vcc:
> +	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
> +	regulator_disable(data->vcc);
> +	return ret;
> +}
> +
> +static void tmag5273_remove(struct i2c_client *i2c)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	struct device *dev = &i2c->dev;
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);

With use of devm_add_action_or_reset() for this you should be able to 
move to a simpler fully devm_ managed flow and not have a remove()
callback at all.

> +	regulator_disable(data->vcc);
> +}
> +
> +static int tmag5273_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +
> +	tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_SLEEP);
> +
> +	return 0;
> +}
> +
> +static int tmag5273_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
> +	if (ret) {
> +		/*
> +		 * Time to go to stand-by mode from sleep mode is 50us
> +		 * typically. During this time no I2C access is possible.
> +		 */
How would we ever not have entered sleep mode and yet be calling runtime
resume?  I'd just make the i2c access twice unconditionally.

> +		usleep_range(80, 200);
> +		ret = tmag5273_set_operating_mode(data, TMAG5273_OP_MODE_CONT);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops tmag5273_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	RUNTIME_PM_OPS(tmag5273_runtime_suspend, tmag5273_runtime_resume, NULL)
> +};

This looks familiar. 
static const DEFINE_RUNTIME_DEV_PM_OPS(...)

> +
> +static const struct i2c_device_id tmag5273_id[] = {
> +	{
> +		"tmag5273",
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i2c, tmag5273_id);
> +
> +static const struct of_device_id tmag5273_of_match[] = {
> +	{
> +		.compatible = "ti,tmag5273",
> +	},
> +	{ /* sentinel */ },

Drop the trailing commas on these entries as we can never add anything after them
so the comma never makes sense.


> +};
> +MODULE_DEVICE_TABLE(of, tmag5273_of_match);

Thanks,

Jonathan
