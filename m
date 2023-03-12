Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60586B68DA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCLRjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCLRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:39:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241073A98;
        Sun, 12 Mar 2023 10:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9B62B80C6D;
        Sun, 12 Mar 2023 17:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB81C433EF;
        Sun, 12 Mar 2023 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678642775;
        bh=E+PU2egIY0+0uafSCjNwl9GaQy1HrLN5Kr7BA1iIrsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ODDwuklhZMTgcscKnx5Z+0eQGWDHDtGEBXR/Gxvc+0hred6FqFkwJSu3G/kI/ox7n
         9glKm5a4qWBN9wbgFuTcFZ7rIOY1FvfNPAtbs9rzc7jaJ0gXUsLpz0ABglnwV8Fgck
         dReqHvarXryBTiULMdQmzbFwpnAlS/1erjW81MNXMSzG+hXNOnnkiLKOwHCqDwG4ge
         +HwL44oosZO1Z9zPphSC5qB9t0p0OzQgvo3vRwnnMTS0Ww09z5XEJFt9spxrxF93d5
         yWC105XuMi/FflWHoZzg8MTdqXuR/ETkUL0r++yZQhCojY34LOPw9dLS0ory03retq
         uN9mlGEq9QF2w==
Date:   Sun, 12 Mar 2023 17:39:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230312173940.6528ec5a@jic23-huawei>
In-Reply-To: <286c1564216cb62cf802478ee786f2ce313df70a.1678093787.git.mazziesaccount@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
        <286c1564216cb62cf802478ee786f2ce313df70a.1678093787.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 11:23:50 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> ROHM BU27034 is an ambient light sensor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
> 
> Add initial  support for the ROHM BU27034 ambient light sensor.
> 
> NOTE:
> 	- Driver exposes 4 channels. One IIO_LIGHT channel providing the
> 	  calculated lux values based on measured data from diodes #0 and
> 	  #1. In addition, 3 IIO_INTENSITY channels are emitting the raw
> 	  register data from all diodes for more intense user-space
> 	  computations.
> 	- Sensor has GAIN values that can be adjusted from 1x to 4096x.
> 	- Sensor has adjustible measurement times of 5, 55, 100, 200 and
> 	  400 mS. Driver does not support 5 mS which has special
> 	  limitations.
> 	- Driver exposes standard 'scale' adjustment which is
> 	  implemented by:
> 		1) Trying to adjust only the GAIN
> 		2) If GAIN adjustment alone can't provide requested
> 		   scale, adjusting both the time and the gain is
> 		   attempted.
> 	- Driver exposes writable INT_TIME property that can be used
> 	  for adjusting the measurement time. Time adjustment will also
> 	  cause the driver to try to adjust the GAIN so that the
> 	  overall scale is kept as close to the original as possible.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> Please note: There are few "unfinished" discussions regarding at least:
> 
> - PROCESSED channel scale.

Hopefully the reply in the other thread covered this.
It's not PROCESSED as you need to apply the * 1000 so just
make it _RAW. 

> - Implementation details when avoiding division by zero.
> 
> I have implemented those for this version in a way that I see the best.
> It would have been better to wait for discussions to finish - but I will
> be away from the computer for a week - so I wanted to send out the v3
> with fixes so that people who are interested can do a review while I am
> away.

I'm getting behind with review anyway so a week delay on this sounds great to
me ;)  I might get to your other series as a result though don't think I'll get there today.

> 

> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> new file mode 100644
> index 000000000000..6135a8a2a4f3
> --- /dev/null
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -0,0 +1,1501 @@

...

> +
> +#include "iio-gts-helper.h"
> +
> +#define BU27034_REG_SYSTEM_CONTROL	0x40
> +#define BU27034_MASK_SW_RESET		BIT(7)
> +#define BU27034_MASK_PART_ID		GENMASK(5, 0)
> +#define BU27034_ID			0x19
> +#define BU27034_REG_MODE_CONTROL1	0x41
> +#define BU27034_MASK_MEAS_MODE		GENMASK(2, 0)
> +
> +#define BU27034_REG_MODE_CONTROL2	0x42
> +#define BU27034_MASK_D01_GAIN		GENMASK(7, 3)
> +#define BU27034_SHIFT_D01_GAIN		3

Use FIELD_GET() and you can get rid of this SHIFT.

> +#define BU27034_MASK_D2_GAIN_HI		GENMASK(7, 6)
> +#define BU27034_MASK_D2_GAIN_LO		GENMASK(2, 0)
> +#define BU27034_SHIFT_D2_GAIN		3
Mentioned below. I don't like this.  It's not obvious
at all that the shift only applies to the HI part.
Perhaps renaming the shift is enough. 
> +
> +#define BU27034_REG_MODE_CONTROL3	0x43
> +#define BU27034_REG_MODE_CONTROL4	0x44
> +#define BU27034_MASK_MEAS_EN		BIT(0)
> +#define BU27034_MASK_VALID		BIT(7)
> +#define BU27034_REG_DATA0_LO		0x50
> +#define BU27034_REG_DATA1_LO		0x52
> +#define BU27034_REG_DATA2_LO		0x54
> +#define BU27034_REG_DATA2_HI		0x55
> +#define BU27034_REG_MANUFACTURER_ID	0x92
> +#define BU27034_REG_MAX BU27034_REG_MANUFACTURER_ID
> +
> +/*
> + * The BU27034 does not have interrupt or any other mechanism of triggering
I'd drop the 'other means' bit as no idea what they might be.
"does not have interrupt to trigger the data read.."

> + * the data read when measurement has finished. Hence we poll the VALID bit in
> + * a thread. We will try to wake the thread BU27034_MEAS_WAIT_PREMATURE_MS
> + * milliseconds before the expected sampling time to prevent the drifting. Eg,
> + * If we constantly wake up a bit too late we would eventually skip a sample.
> + * And because the sleep can't wake up _exactly_ at given time this would be
> + * inevitable even if the sensor clock would be perfectly phase-locked to CPU
> + * clock - which we can't say is the case.
> + *
> + * This is still fragile. No matter how big advance do we have, we will still
> + * risk of losing a sample because things can in a rainy-day skenario be
> + * delayed a lot. Yet, more we reserve the time for polling, more we also lose
> + * the performance by spending cycles polling the register. So, selecting this
> + * value is a balancing dance between severity of wasting CPU time and severity
> + * of losing samples.
> + *
> + * In most cases losing the samples is not _that_ crucial because light levels
> + * tend to change slowly.
> + */
> +#define BU27034_MEAS_WAIT_PREMATURE_MS	5
> +#define BU27034_DATA_WAIT_TIME_US	1000
> +#define BU27034_TOTAL_DATA_WAIT_TIME_US (BU27034_MEAS_WAIT_PREMATURE_MS * 1000)
...

> +static const struct iio_chan_spec bu27034_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |

Not processed because scale needs to be applied.

> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.channel = BU27034_CHAN_ALS,
> +		.scan_index = BU27034_CHAN_ALS,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	/*
> +	 * The BU27034 DATA0 and DATA1 channels are both on the visible light
> +	 * area (mostly). The data0 sensitivity peaks at 500nm, DATA1 at 600nm.
> +	 * These wave lengths are pretty much on the border of colours making
> +	 * these a poor candidates for R/G/B standardization. Hence they're both
> +	 * marked as clear channels
> +	 */
> +	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
> +	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),
> +	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),

...

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

FIELD_GET() and get rid of separation SHIFT definitions.

> +	}
> +	case BU27034_CHAN_DATA2:
> +		ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL2, &val);
> +		if (ret)
> +			return ret;
> +
> +		return (val & BU27034_MASK_D2_GAIN_HI) >> BU27034_SHIFT_D2_GAIN
> +		       | (val & BU27034_MASK_D2_GAIN_LO);

This one is messy but I'd prefer it as two field extractions that are then combined.
The shift of 3 is a weird artefact of the field layout and not easily described via a define.
The current name is definitely not descriptive enough.

FIELD_GET(val, BU27034_MASK_D2_GAIN_HI) << 3 |
FIELD_GET(val, BU27034_MASK_D2_GAIN_LO)

> +	}
> +
> +	return -EINVAL;
> +}

> +static int bu27034_get_scale(struct bu27034_data *data, int channel, int *val,
> +			      int *val2)
> +{
> +	int ret;
> +
> +	if (channel == BU27034_CHAN_ALS) {
> +		*val = 0;
> +		*val2 = 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	mutex_lock(&data->mutex);
> +	ret = _bu27034_get_scale(data, channel, val, val2);
> +	mutex_unlock(&data->mutex);
> +	if (!ret)
> +		return IIO_VAL_INT_PLUS_NANO;
Prefer this flipped so the error path is out of line.

	if (ret)
		return ret;

	return IIO_VAL_INT_PLUS_NANO;

> +
> +	return ret;
> +}



...

> +static int bu27034_calc_mlux(struct bu27034_data *data, __le16 *res, int *val)
> +{
> +	unsigned int gain0, gain1, meastime;
> +	unsigned int d1_d0_ratio_scaled;
> +	u16  ch0, ch1;
> +	u64 helper64;
> +	int ret;
> +
> +	/*
> +	 * We return 0 luxes if calculation fails. This should be reasonably
> +	 * easy to spot from the buffers especially if raw-data channels show
> +	 * valid values
> +	 */
> +	*val = 0;
> +
> +	/*  Avoid div by zero. */
> +	if (!res[0])
> +		ch0 = 1;
> +	else
> +		ch0 = le16_to_cpu(res[0]);
> +
> +	if (!res[1])
> +		ch1 = 1;
> +	else
> +		ch1 = le16_to_cpu(res[1]);
> +

As per other thread. Really don't like the check on 0 before
the endian conversion.  Sure it can be done, but it's a micro optimization that
seems unnecessary.

...

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
> +		*val = bu27034_get_int_time(data);
> +		if (*val < 0)
> +			return *val;
> +
> +		/*
> +		 * We use 50000 uS internally for all calculations and only
> +		 * convert it to 55000 before returning it to the user.
> +		 *
> +		 * This is because the data-sheet says the time is 55 mS - but
> +		 * vendor provided computations used 50 mS.

No chance of a clarification?  would be lovely to not do this!

> +		 */
> +		if (*val == 50000)
> +			*val = 55000;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		return bu27034_get_scale(data, chan->channel, val, val2);
> +
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		if (chan->type != IIO_INTENSITY)
> +			return -EINVAL;
> +
> +		if (chan->channel < BU27034_CHAN_DATA0 ||
> +		    chan->channel > BU27034_CHAN_DATA2)
> +			return -EINVAL;
> +
> +		/* Don't mess with measurement enabling while buffering */
> +		ret = iio_device_claim_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->mutex);
> +		/*
> +		 * Reading one channel at a time is ineffiecient but we don't

spell check comments.

> +		 * care here. Buffered version should be used if performance is
> +		 * an issue.
> +		 */
> +		ret = bu27034_get_single_result(data, chan->channel, val);
> +
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(idev);
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type != IIO_LIGHT)
> +			return -EINVAL;
> +
> +		/* Don't mess with measurement enabling while buffering */
> +		ret = iio_device_claim_direct_mode(idev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&data->mutex);
> +
> +		ret = bu27034_get_mlux(data, val);
> +
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(idev);
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +
> +	}
> +
> +	return ret;

I would hope you can't get here. If you can fix that so
that the lack of return here allows the compiler to know  you didn't
intend to get here and hence complain about it.




> +}
> +


> +
> +static int bu27034_wait_for_data(struct bu27034_data *data)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read_poll_timeout(data->regmap, BU27034_REG_MODE_CONTROL4,
> +				       val, val & BU27034_MASK_VALID,
> +				       BU27034_DATA_WAIT_TIME_US,
> +				       BU27034_TOTAL_DATA_WAIT_TIME_US);
> +	if (ret) {
> +		dev_err(data->dev, "data polling %s\n",
> +			!(val & BU27034_MASK_VALID) ? "timeout" : "fail");
> +		return ret;
> +	}

Blank line here to separate above error handling from this bit.

> +	ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
> +			       &data->scan.channels[0],
> +			       sizeof(data->scan.channels));

Why should we carry on if ret < 0?  Needs a comment as not obvious from
code.

> +	bu27034_invalidate_read_data(data);
> +
> +	return ret;
> +}
> +
> +static int bu27034_buffer_thread(void *arg)
> +{
> +	struct iio_dev *idev = arg;
> +	struct bu27034_data *data;
> +	int wait_ms;
> +
> +	data = iio_priv(idev);
> +
> +	wait_ms = bu27034_get_int_time(data);
> +	wait_ms /= 1000;
> +
> +	wait_ms -=  BU27034_MEAS_WAIT_PREMATURE_MS;
> +
> +	while (!kthread_should_stop()) {
> +		int ret;
> +		int64_t tstamp;
> +
> +		msleep(wait_ms);
> +		ret = bu27034_wait_for_data(data);
> +		if (ret)
> +			continue;
> +
> +		tstamp = iio_get_time_ns(idev);
> +
> +		if (*idev->active_scan_mask & BIT(BU27034_CHAN_ALS)) {

Scan mask is a bitmap so you should use the checkers for that rather than
making assumptions about it fitting in one long (even it if obviously does
fit).

test_bit()

> +			int mlux;
> +
> +			ret = bu27034_calc_mlux(data, &data->scan.channels[0],
> +					       &mlux);
> +			if (ret)
> +				dev_err(data->dev, "failed to calculate lux\n");
> +
> +			/*
> +			 * The maximum milli lux value we get with gain 1x time
> +			 * 55mS data ch0 = 0xffff ch1 = 0xffff fits in 26 bits
> +			 * so there should be no problem returning int from
> +			 * computations and casting it to u32
> +			 */
> +			data->scan.mlux = (u32)mlux;

> +		}
> +		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
> +	}
> +
> +	return 0;
> +}

...


> +static int bu27034_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct bu27034_data *data;
> +	struct regmap *regmap;
> +	struct iio_dev *idev;
> +	unsigned int part_id, reg;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &bu27034_regmap);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to initialize Regmap\n");
> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret && ret != -ENODEV)

Why the special -ENODEV handling?
You should get a stub regulator if one isn't provided by firmware.
If you don't get a stub, or a real regulator that's a failure so we should
return the error code and fail the probe.


> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> +

