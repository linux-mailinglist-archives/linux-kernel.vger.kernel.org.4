Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0886AAC5E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 21:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCDURc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 15:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:17:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA561A94D;
        Sat,  4 Mar 2023 12:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C46AB808D4;
        Sat,  4 Mar 2023 20:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8F9C4339B;
        Sat,  4 Mar 2023 20:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677961044;
        bh=UPWWG28xiD4Wa2BojHdTbZvwSmg4mMO5WVJYHCtMkFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jvCAsRgOIbV3pTjuy/KkkJuL1K4BG9wsfMS/w1zhX2T+duqNNDa/Suj3SxW3+y8Jh
         78Eksv2chM9W4TpeSvyZFcAW8NGCuQ78NfZzO6OmdoF/7CLCOT2uATqTNazLaLw8zg
         cpgQW5VADg2j4Ycd/VXNHdhyQ8tyZV4oYnh+iL9wbWglb6omUv2tpW+T6DQRHkCyfN
         CXTvShDo543BgPBlIReXbFaqln3JDm7L4UkxgDIZ84TpMi7IhlvKaT9jktCmH0Iy6d
         l2GetHVG3oedvxIFBkbw6CS05phHfNDKXblUCX7K/0zpDgnlA0YFcn/Fffvh4ztlVW
         JJiPZZ2QvpLTQ==
Date:   Sat, 4 Mar 2023 20:17:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230304201720.2d554f07@jic23-huawei>
In-Reply-To: <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Thu, 2 Mar 2023 12:58:59 +0200
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

Probably want a 'where possible' note here.

> 	- Runtime PM is not implemented.

I wouldn't bother noting things that are not implemented. That's a long list!

> 	- Driver starts the measurement on the background when it is
> 	  probed. This improves the respnse time to read-requests

Spell check.  (I often forget to do this myself)

> 	  compared to starting the read only when data is requested.
> 	  When the most accurate 400 mS measurement time is used, data reads
> 	  would last quite long if measurement was started only on
> 	  demand. This, however, is not appealing for users who would
> 	  prefere power saving over measurement response time.
As you noted this needs updating

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Some comments inline to add to Andy's review.#
It's a big driver so we may well need a few more versions to converge completely.

Jonathan


> 
> ---
> Changes since RFCv1
> - (really) protect read-only registers
> - fix get and set gain
> - buffered mode
> - Protect the whole sequences including meas_en/meas_dis to avoid messing
>   up the enable / disable order
> - typofixes / doc improvements
> - change dropped GAIN_SCALE_ITIME_MS() to GAIN_SCALE_ITIME_US()
> - use more accurate scale for lux channel (milli lux)
> - provide available scales / integration times (using helpers).
> - adapt to renamed iio-gts-helpers.h file
> - bu27034 - longer lines in Kconfig
> - Drop bu27034_meas_en and bu27034_meas_dis wrappers.
> - Change device-name from bu27034-als to bu27034
> ---
>> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
> new file mode 100644
> index 000000000000..b8ca29af22e7
> --- /dev/null
> +++ b/drivers/iio/light/rohm-bu27034.c
> @@ -0,0 +1,1491 @@

> +/*
> + * The BU27034 does not have interrupt or any other mechanism of triggering
> + * the data read when measurement has finished. Hence we poll the VALID bit in
> + * a thread. We will try to wake the thread BU27034_MEAS_WAIT_PREMATURE_MS
> + * milliseconds before the expected sampling time to prevent the drifting. Eg,
> + * If we constantly wake up a bit too late we would eventually skip a sample.

Lazier approach would be to just sent the sampling frequency at twice the
expected frequency and you'll never miss a sample unless you the wake up is
delayed massively for some reason.  Particularly 'fresh' data might not matter
enough that half a cycle late is a problem.

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
> +
Single blank line is enough to separate sections.
> +
> +enum {
> +	BU27034_CHAN_ALS,
> +	BU27034_CHAN_DATA0,
> +	BU27034_CHAN_DATA1,
> +	BU27034_CHAN_DATA2,
> +	BU27034_NUM_CHANS
> +};


> +static const struct iio_chan_spec bu27034_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_SCALE),

What is this scale for?
Given the channel is computed from various different inputs, is there a
clear definition of how it is scaled?  What does a write to it mean?

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
> +};


> +/* Caller should hold the lock to protect data->int_time */
> +static int bu27034_set_int_time(struct bu27034_data *data, int time)
> +{
> +	int ret;
> +
> +	ret = iio_gts_find_sel_by_int_time(&data->gts, time);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, BU27034_REG_MODE_CONTROL1,
> +				 BU27034_MASK_MEAS_MODE, ret);
> +
> +	return time;
?  Never get to this.
> +}
> +
> +/*
> + * We try to change the time in such way that the scale is maintained for
> + * given channels by adjusting gain so that it compensates the time change.
> + */
> +static int bu27034_try_set_int_time(struct bu27034_data *data, int time_us)
> +{
> +	int ret, int_time_old, int_time_new, i;
> +	struct bu27034_gain_check gains[3] = {
> +		{ .chan = BU27034_CHAN_DATA0, },
> +		{ .chan = BU27034_CHAN_DATA1, },
> +		{ .chan = BU27034_CHAN_DATA2 }
> +	};
> +	int numg = ARRAY_SIZE(gains);
> +
> +	mutex_lock(&data->mutex);
> +	ret = bu27034_get_int_time(data);
> +	if (ret < 0)
> +		goto unlock_out;
> +
> +	int_time_old = ret;
> +
> +	ret = bu27034_validate_int_time(data, time_us);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Unsupported integration time %u\n",
> +			time_us);
> +
> +		goto unlock_out;
> +	}
> +
> +	int_time_new = ret;
> +
> +	if (int_time_new == int_time_old) {
> +		ret = 0;
> +		goto unlock_out;
> +	}
> +
> +	for (i = 0; i < numg; i++) {
> +		ret = bu27034_get_gain(data, gains[i].chan,
> +				       &gains[i].old_gain);
> +		if (ret)
> +			goto unlock_out;
> +
> +		gains[i].new_gain = gains[i].old_gain * int_time_old /
> +				    int_time_new;
> +
> +		if (!iio_gts_valid_gain(&data->gts, gains[i].new_gain)) {
> +			int scale1, scale2;
> +			bool ok;
> +
> +			_bu27034_get_scale(data, gains[i].chan, &scale1, &scale2);
> +			dev_dbg(data->dev,
> +				"chan %u, can't support time %u with scale %u %u\n",
> +				gains[i].chan, time_us, scale1, scale2);
> +
> +			/*
> +			 * As Jonathan put it, if caller requests for

Probably don't reference me directly in a driver.  Keep the 'blame' for the
email threads :)  Comment is fine otherwise.

> +			 * integration time change and we can't support the
> +			 * scale - then the caller should be prepared to
> +			 * 'pick up the pieces and deal with the fact that the
> +			 * scale changed'.
> +			 */
> +			ret = iio_find_closest_gain_low(&data->gts,
> +							gains[i].new_gain, &ok);
> +
> +			if (!ok) {
> +				dev_dbg(data->dev,
> +					"optimal gain out of range for chan %u\n",
> +					gains[i].chan);
> +			}
> +			if (ret < 0) {
> +				dev_warn(data->dev,
> +					 "Total gain increase. Risk of saturation");
dev_dbg()
> +				ret = iio_gts_get_min_gain(&data->gts);
> +				if (ret < 0)
> +					goto unlock_out;
> +			}
> +			dev_warn(data->dev, "chan %u scale changed\n",
> +				 gains[i].chan);
dev_dbg()

We shouldn't convey this sort of info via the kernel log. Most users would never
see it anyway!.
> +			gains[i].new_gain = ret;
> +			dev_dbg(data->dev, "chan %u new gain %u\n",
> +				gains[i].chan, gains[i].new_gain);
> +		}
> +	}
> +
> +	/*
> +	 * The new integration time can be supported while keeping the scale of
> +	 * channels intact by tuning the gains.

This comment is in a path that is hit event if we go through the warnings
above that say this isn't true.

> +	 */
> +	for (i = 0; i < numg; i++) {
> +		ret = bu27034_set_gain(data, gains[i].chan, gains[i].new_gain);
> +		if (ret)
> +			goto unlock_out;
> +	}
> +
> +	ret = bu27034_set_int_time(data, int_time_new);
> +
> +unlock_out:
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int bu27034_set_scale(struct bu27034_data *data, int chan,
> +			    int val, int val2)
> +{
> +	int ret, time_sel, gain_sel, i;
> +	bool found = false;
> +
> +	if (chan == BU27034_CHAN_ALS) {
> +		if (val == 0 && val2 == 1000)
> +			return 0;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL1, &time_sel);
> +	if (ret)
> +		goto unlock_out;
> +
> +	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
> +						val, val2 * 1000, &gain_sel);
> +	if (ret) {
> +		/*
> +		 * Could'n support scale with given time. Need to change time.

Could not

> +		 * We still want to maintain the scale for all channels
> +		 */
> +		int new_time_sel;
> +		struct bu27034_gain_check gains[2];
> +
> +		/*
> +		 * Populate information for the two other channels which should
> +		 * maintain the scale.
> +		 */
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
> +
> +		for (i = 0; i < 2; i++) {
> +			ret = bu27034_get_gain(data, gains[i].chan,
> +					       &gains[i].old_gain);
> +			if (ret)
> +				goto unlock_out;
> +		}
> +
> +		/*
> +		 * Iterate through all the times to see if we find one which
> +		 * can support requested scale for requested channel, while
> +		 * maintaining the scale for other channels
> +		 */
> +		for (i = 0; i < data->gts.num_itime; i++) {
> +			new_time_sel = data->gts.itime_table[i].sel;
> +
> +			if (new_time_sel == time_sel)
> +				continue;
> +
> +			/* Can we provide requested scale with this time? */
> +			ret = iio_gts_find_gain_sel_for_scale_using_time(
> +				&data->gts, new_time_sel, val, val2 * 1000,
> +				&gain_sel);
> +			if (ret)
> +				continue;
> +
> +			/* Can the two other channels maintain scales? */
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
> +				/* Yes - we found suitable time */
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			dev_err(data->dev,
> +				"Can't set scale maintaining other channels\n");

We shouldn't print an error to the log in a path like this as we just gave
userspace an easy way to overflow the log.  Just return -EINVAL without the
print.  Fine to add it as dev_dbg() though if you like.

> +			ret = -EINVAL;
> +
> +			goto unlock_out;
> +		}
> +
> +		for (i = 0; i < 2; i++) {
> +			ret = bu27034_set_gain(data, gains[i].chan,
> +						gains[i].new_gain);
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

...

> +
> +static bool bu27034_has_valid_sample(struct bu27034_data *data)
> +{
> +	int ret, val;
> +
> +	ret = regmap_read(data->regmap, BU27034_REG_MODE_CONTROL4, &val);
> +	if (ret)
> +		dev_err(data->dev, "Read failed %d\n", ret);

Don't use the value if error occurred as unknown state.
Just do return false in that path.

> +
> +	return (val & BU27034_MASK_VALID);
No brackets needed.
> +}

...

> +static int bu27034_get_single_result(struct bu27034_data *data, int chan,
> +				     int *val)
> +{
> +	int ret;
> +
> +
One blank line is enough!

> +	ret = bu27034_meas_set(data, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27034_get_int_time(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(ret / 1000);
> +
> +	return bu27034_read_result(data, chan, val);
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
> + * We use it here. Users who have for example some colored lens
> + * need to modify the calculation but I hope this gives a starting point for
> + * those working with such devices.
> + */
> +
> +static int bu27034_calc_lux(struct bu27034_data *data, __le16 *res, int *val)

As you are going to put it in the buffer, make val a fixed size integer.
The current approach of calculate in an int and copy to a u32 is a bit nasty.
Of course if there is a chance of a large enough value you'll have to be careful
for the unsigned to signed conversion on 32 bit platforms. I doubt there is, but
a comment saying why not would be great in the code that is hit from read_raw()

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
> +	/*
> +	 * Avoid div by zeroi. Not using max() as the data may not be in
> +	 * native endianes
> +	 */
> +	if (!res[0])
> +		ch0 = 1;
> +	else
> +		ch0 = le16_to_cpu(res[0]);

As per other branch of the thread.

	ch0 = max(1, le16_to_cpu(res[0]);

would be cleaner.

> +
> +	if (!res[1])
> +		ch1 = 1;
> +	else
> +		ch1 = le16_to_cpu(res[1]);
> +
> +
> +	ret = bu27034_get_gain(data, BU27034_CHAN_DATA0, &gain0);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27034_get_gain(data, BU27034_CHAN_DATA1, &gain1);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27034_get_int_time(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	meastime = ret;
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
> +}
> +
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
> +		 * care here. Buffered version should be used if performance is
> +		 * an issue.
> +		 */
> +		ret = bu27034_get_single_result(data, chan->channel, val);
> +		if (ret)
> +			goto release_err_out;

Move the if (ret) after the locks are released then you don't need
the messy goto.

> +
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(idev);
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

See below. I would factor out the rest of this so that you can
unconditionally unlock and then check the return value.

> +		ret = bu27034_meas_set(data, true);
> +		if (ret)
> +			goto release_err_out;
> +
> +		ret = bu27034_get_lux(data, val);
> +		if (ret)
> +			goto release_err_out;
> +
> +		ret = bu27034_meas_set(data, false);
> +		if (ret)
> +			dev_err(data->dev, "failed to disable measurement\n");
> +
> +		mutex_unlock(&data->mutex);
> +		iio_device_release_direct_mode(idev);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +
> +	}
> +
> +release_err_out:
> +	mutex_unlock(&data->mutex);
> +	iio_device_release_direct_mode(idev);
> +

Having goto targets that are outside of case statements within the arms
of a switch is usually a strong hint that it makes sense to factor
out the code

> +	return ret;
> +}
> +


blank line here.

> +static const struct iio_info bu27034_info = {
> +	.read_raw = &bu27034_read_raw,
> +	.write_raw = &bu27034_write_raw,
> +	.read_avail = &bu27034_read_avail,
> +};
> +



...

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
> +	if (!fwnode)
> +		return -ENODEV;

You've already noted this shouldn't be here.

> +
> +	idev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> +
> +	data = iio_priv(idev);
> +
> +	ret = regmap_read(regmap, BU27034_REG_SYSTEM_CONTROL, &part_id);

As it's not all of the register I'd rename the temporary variable to
val or reg or something along those lines.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> +
> +	part_id &= BU27034_MASK_PART_ID;

FIELD_GET() even when it's lower bits as then there is no need for
a reviewer to confirm that it is the lower bits.
Then you can just do

	if (FIELD_GET(BU27034_MASK_PART_ID, reg) != BU27034_ID)

> +
> +	if (part_id != BU27034_ID)
> +		dev_warn(dev, "unsupported device 0x%x\n", part_id);

I'd adjust that to "unknown device" or "unrecognised device" as it might
well be supported just fine based on the compatible fallback, we just have
no way of knowing if it is.

> +
> +	ret = iio_init_iio_gts(BU27034_SCALE_1X, 0, bu27034_gains,
> +			       ARRAY_SIZE(bu27034_gains), bu27034_itimes,
> +			       ARRAY_SIZE(bu27034_itimes), &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_gts_build_avail_tables(dev, &data->gts);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +	data->regmap = regmap;
> +	data->dev = dev;
> +
> +	idev->channels = bu27034_channels;
> +	idev->num_channels = ARRAY_SIZE(bu27034_channels);
> +	idev->name = "bu27034";
> +	idev->info = &bu27034_info;
> +
> +	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	idev->available_scan_masks = bu27034_scan_masks;
> +
> +	ret = bu27034_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_kfifo_buffer_setup(dev, idev, &bu27034_buffer_ops);

check ret and error out on failure.

> +
> +	ret = devm_iio_device_register(dev, idev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Unable to register iio device\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id bu27034_of_match[] = {
> +	{ .compatible = "rohm,bu27034", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bu27034_of_match);
> +
> +static struct i2c_driver bu27034_i2c_driver = {
> +	.driver = {
> +		.name  = "bu27034-als",
> +		.of_match_table = bu27034_of_match,
> +	  },
> +	.probe_new    = bu27034_probe,

I'd just use a single space in all cases before the =
Attempts to align the values in this structure don't really help readability
and often end up messier over time.

> +};
> +module_i2c_driver(bu27034_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("ROHM BU27034 ambient light sensor driver");

