Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C648636870
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiKWSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbiKWSNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:13:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273E9FCF5;
        Wed, 23 Nov 2022 10:10:25 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHTgc0km7z67Q1Q;
        Thu, 24 Nov 2022 02:10:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:10:22 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 18:10:22 +0000
Date:   Wed, 23 Nov 2022 18:10:21 +0000
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
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add ti tmag5273 driver
Message-ID: <20221123181021.000046b0@Huawei.com>
In-Reply-To: <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
References: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
        <20221121123542.1322367-3-gerald.loacker@wolfvision.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Mon, 21 Nov 2022 13:35:42 +0100
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Add support for TI TMAG5273 Low-Power Linear 3D Hall-Effect Sensor.
> Additionally to temperature and magnetic X, Y and Z-axes the angle and
> magnitude are reported.
> The sensor is operating in continuous measurement mode and changes to sleep
> mode if not used for 5 seconds.
> 
> Datasheet: https://www.ti.com/lit/gpn/tmag5273
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>

Hi Gerald,

A few additional comment from me. I quickly read Andy's and have tried
not to overlap too much!

Thanks,

Jonathan

> +static int tmag5273_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	s16 t, x, y, z;
> +	u16 angle, magnitude;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pm_runtime_resume_and_get(data->dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = tmag5273_get_measure(data, &t, &x, &y, &z, &angle,
> +					   &magnitude);
> +		if (ret)
> +			return ret;
> +
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
> +
> +		switch (chan->address) {
> +		case TEMPERATURE:
> +			*val = t;
> +			return IIO_VAL_INT;
> +		case AXIS_X:
> +			*val = x;
> +			return IIO_VAL_INT;
> +		case AXIS_Y:
> +			*val = y;
> +			return IIO_VAL_INT;
> +		case AXIS_Z:
> +			*val = z;
> +			return IIO_VAL_INT;
> +		case ANGLE:
> +			*val = angle;
> +			return IIO_VAL_INT;
> +		case MAGNITUDE:
> +			*val = magnitude;
> +			return IIO_VAL_INT;
> +		default:
> +			dev_err(data->dev, "Unknown channel %lu\n",
> +				chan->address);

Should be impossible to get here so no need for print.

> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/*
> +			 * Convert device specific value to millicelsius.
> +			 * Resolution from the sensor is 60.1 LSB/celsius and
> +			 * the reference value at 25 celsius is 17508 LSBs.
> +			 */
> +			*val = 10000;
> +			*val2 = 601;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_MAGN:
> +			/* Magnetic resolution in uT */
> +			*val = 0;
> +			*val2 = tmag5273_scale_table[data->version]
> +						    [data->scale_index]
> +							    .scale_micro;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ANGL:
> +			/*
> +			 * Angle is in degrees and has four fractional bits,
> +			 * therefore use 1/16 * pi/180 to convert to radiants.
> +			 */
> +			*val = 1000;
> +			*val2 = 916732;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = -266314;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = data->conv_avg;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		/* Unknown request */
> +		return -EINVAL;
> +	}
> +}
> +
> +static int tmag5273_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct tmag5273_data *data = iio_priv(indio_dev);
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val == data->conv_avg)
> +			return 0;
> +		return regmap_update_bits(data->map, TMAG5273_DEVICE_CONFIG_1,
> +					  TMAG5273_AVG_MODE_MASK, val);

Update conv_avg?  Or don't store cached value at all, and always read it from
the device (or regmap cache possibly if you have that enabled)

> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			if (val != 0)
> +				return -EINVAL;
> +
> +			for (i = 0; i < ARRAY_SIZE(tmag5273_scale_table[0]);
> +			     i++) {

What Andy said.  Sometimes wrapping is just too ugly!

> +				if (tmag5273_scale_table[data->version][i]
> +					    .scale_micro == val2)
This line break is nasty as well.  The whole thing is deeply enough nested
I'd just rip it out to a helper function called something like
tmag5273_write_scale() (or _magn_scale())

> +					break;
> +			}
> +			if (i == ARRAY_SIZE(tmag5273_scale_table[0]))
> +				return -EINVAL;
> +			data->scale_index = i;
> +
> +			ret = regmap_update_bits(
> +				data->map, TMAG5273_SENSOR_CONFIG_2,
> +				TMAG5273_Z_RANGE_MASK | TMAG5273_X_Y_RANGE_MASK,
> +				data->scale_index == MAGN_LOW ? 0 :
> +					(TMAG5273_Z_RANGE_MASK |
> +					 TMAG5273_X_Y_RANGE_MASK));
> +			if (ret)
> +				return ret;
> +
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static void tmag5273_read_device_property(struct tmag5273_data *data)
> +{
> +	const char *angle_measurement;
> +
> +	data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
> +
> +	if (!device_property_read_string(data->dev, "ti,angle-measurement",
> +					 &angle_measurement)) {
> +		if (!strcmp(angle_measurement, "off"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_OFF;
> +		else if (!strcmp(angle_measurement, "x-y"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
> +		else if (!strcmp(angle_measurement, "y-z"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_Y_Z;
> +		else if (!strcmp(angle_measurement, "x-z"))
> +			data->angle_measurement = TMAG5273_ANGLE_EN_X_Z;
> +		else
> +			dev_warn(data->dev,
> +				 "failed to read angle-measurement\n");
Somewhat inaccurate warning.   I'd print something like
"unexpected read angle-measurement property: %s\n", angle_measurement);

We read it. We just have no idea what it means! :)

> +	}
> +}
> +

