Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AD6C03B9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCSSOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCSSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:14:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3284EC42;
        Sun, 19 Mar 2023 11:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5530E61147;
        Sun, 19 Mar 2023 18:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1174C433EF;
        Sun, 19 Mar 2023 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679249686;
        bh=9sqmq/+cbtEEwQi/1Or8vBmF/zYR6AbLSDmxFTeisDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JyDkQEAaAdHRPfR91484nsNiz3lSRE9LXcWh9RhCyP31/WOfNDtBMwD2VDRtBjC5Q
         A90VfOsiJRuN+TbP0BNi55+4YwmA0ek5a7y6PNGEREnSMu/qrrZ1Y5Z8VevWL6O9c9
         pTk3Bl+4bcKEvHXxJhFNlhpef6ZUeTwpcolhz7U4vqw1hDr2gn0gvDZVxVolfizyOA
         DSwSKiRzGznyf49Qq0mxvn/fXlSmPl421GD6wNsDvA4T7ZirPKTDl1T3AVnVhdQ/5Y
         C7gjmQdENP5WK7+1mbHbvVZgvtktAn0XY0YTE5LKj9v3zoiL4R0oMV4SuBYO1Rz4t5
         hG/o/eLCSFkRQ==
Date:   Sun, 19 Mar 2023 18:29:39 +0000
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
Subject: Re: [PATCH v4 7/8] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230319182939.6b8d4aec@jic23-huawei>
In-Reply-To: <feb7e7f6785e93af45510ca22d9aecc28e436cf2.1679062529.git.mazziesaccount@gmail.com>
References: <cover.1679062529.git.mazziesaccount@gmail.com>
        <feb7e7f6785e93af45510ca22d9aecc28e436cf2.1679062529.git.mazziesaccount@gmail.com>
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

On Fri, 17 Mar 2023 16:44:40 +0200
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

I've run out of time / stamina for reviewing today, so just a few quick
comments to add to the various things discussed in the ongoing responses
to previous version.

Thanks,

Jonathan

> 
> ---
> Changes
> v3 => v4:
> - use min_t() for division by zero check
> - adapt to new GTS helper header location
> - calculate luxes not milli luxes
> - drop scale for PROCESSED channel
> - comment improvements
> - do not allow changing gain (scale) for channel 2.
>    - 'tie' channel 2 scale to channel 0 scale
>      This is because channel 0 and channel 2 GAIN settings share part of
>      the bits in the register. This means that setting one will also
>      impact the other. The v3 of the patches attempted to work-around
>      this by only disallowing the channel 2 gain setting to set the bits
>      which were shared with channel 0 gain. This does not work because
>      setting channel 0 gain (which was allowed to set also the shared
>      bits) could result unsupported bit combinations for channel 2 gain.
>      Thus it is safest to always set also the channel 2 gain to same
>      value as channel 0 gain.
> - Use the correct integration time (55 mS) in the gain table as the
>   calcuations can be done based on the time multiplier.
> - styling
> 
> v2 => v3:
> - commit message update and typofixes
> - switch warning messages to dbg
> - drop incorrect comment about unchanged scales
> - return 'no new data' if valid bit read failed
> - shorten the 'div by zero' checks
> - don't use u32 pointer when int * is epected in lux calculation
> - add a comment clarifying why it is safe to return int from lux calculation
> - simplify read_raw() by refactoring the measurement start / stop in
>   another function and dropping the goto based unlocking.
> - Styling fixes
> - select IIO_BUFFER and IIO_KFIFO_BUF
> - Alphabetical order of header includes
> - Split multipication w/ overflow check to own function
> - Do not hang in read_raw() if sensor does not return valid sample
> - Spelling fix
> - Do not require fwnode
> - Use namespace for gts helpers
> 
> RFCv1 => v2:
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

...

> +
> +static const struct regmap_range bu27034_volatile_ranges[] = {
> +	{
> +		.range_min = BU27034_REG_MODE_CONTROL4,
> +		.range_max = BU27034_REG_MODE_CONTROL4,
> +	}, {
> +		.range_min = BU27034_REG_DATA0_LO,
> +		.range_max = BU27034_REG_DATA2_HI,
> +	},
> +};
> +
> +static const struct regmap_access_table bu27034_volatile_regs = {
> +	.yes_ranges = &bu27034_volatile_ranges[0],
> +	.n_yes_ranges = ARRAY_SIZE(bu27034_volatile_ranges),
> +};
> +
> +static const struct regmap_range bu27034_read_only_ranges[] = {
> +	{
> +		.range_min = BU27034_REG_DATA0_LO,
> +		.range_max = BU27034_REG_DATA2_HI,
> +	}, {
> +		.range_min = BU27034_REG_MANUFACTURER_ID,
> +		.range_max = BU27034_REG_MANUFACTURER_ID,
> +	}
> +};
> +
> +static const struct regmap_access_table bu27034_ro_regs = {
> +	.no_ranges = &bu27034_read_only_ranges[0],
> +	.n_no_ranges = ARRAY_SIZE(bu27034_read_only_ranges),
> +};
> +
> +static const struct regmap_config bu27034_regmap = {
> +	.reg_bits	= 8,

I wouldn't do this indenting. You don't do it consistently
(see directly above) and it so often goes wrong or makes things noisy
that I prefer people just don't try to do it.

It doesn't really make much different to readability even if it looks
pretty.

> +	.val_bits	= 8,
> +
> +	.max_register	= BU27034_REG_MAX,
> +	.cache_type	= REGCACHE_RBTREE,
> +	.volatile_table = &bu27034_volatile_regs,
> +	.wr_table	= &bu27034_ro_regs,
> +};
> +
> +struct bu27034_gain_check {
> +	int old_gain;
> +	int new_gain;
> +	int chan;
> +};

> +
> +static int bu27034_set_scale(struct bu27034_data *data, int chan,
> +			    int val, int val2)
> +{
> +	int ret, time_sel, gain_sel, i;
> +	bool found = false;
> +
> +	if (chan == BU27034_CHAN_DATA2)
> +		return -EINVAL;
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
> +		 * Could not support scale with given time. Need to change time.
> +		 * We still want to maintain the scale for all channels
> +		 */
> +		struct bu27034_gain_check gain;
> +		int new_time_sel;
> +
> +		/*
> +		 * Populate information for the other channel which should also
> +		 * maintain the scale. (Due to the HW limitations the chan2
> +		 * gets the same gain as chan0, so we only need to explicitly
> +		 * set the chan 0 and 1).
> +		 */
> +		if (chan == BU27034_CHAN_DATA0)
> +			gain.chan = BU27034_CHAN_DATA1;
> +		else if (chan == BU27034_CHAN_DATA1)
> +			gain.chan = BU27034_CHAN_DATA0;
> +
> +		ret = bu27034_get_gain(data, gain.chan, &gain.old_gain);
> +		if (ret)
> +			goto unlock_out;
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
> +			/* Can the othe channel(s) maintain scale? */
> +			ret = iio_gts_find_new_gain_sel_by_old_gain_time(
> +				&data->gts, gain.old_gain, time_sel,
> +				new_time_sel, &gain.new_gain);
> +			if (!ret) {
> +				/* Yes - we found suitable time */
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			dev_dbg(data->dev,
> +				"Can't set scale maintaining other channels\n");
> +			ret = -EINVAL;
> +
> +			goto unlock_out;
> +		}
> +
> +		for (i = 0; i < 2; i++) {

Why the loop?

> +			ret = bu27034_set_gain(data, gain.chan,
> +						gain.new_gain);
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
> +	helper64 = (u64)coeff * (u64)ch1 * (u64)ch1;
> +	helper = coeff * ch1 * ch1;
> +	tmp = helper * gain0;
> +
> +	if (helper == helper64 && (tmp / gain0 == helper))
> +		return tmp / (gain1 * gain1) / ch0;
> +
> +	helper = gain1 * gain1;
> +	if (helper > ch0) {
> +		do_div(helper64, helper);
> +
> +		return  gain_mul_div_helper(helper64, gain0, ch0);
> +	}
> +
> +	do_div(helper64, ch0);
> +
> +	return  gain_mul_div_helper(helper64, gain0, helper);

Looks like an extra space after return

+ another one just above.

> +}
...


> +static int bu27034_get_result_unlocked(struct bu27034_data *data, __le16 *res,
> +				       int size)
> +{
> +	int ret = 0, retry_cnt = 0;
> +
> +retry:
> +	/* Get new value from sensor if data is ready */
> +	if (bu27034_has_valid_sample(data)) {
> +		ret = regmap_bulk_read(data->regmap, BU27034_REG_DATA0_LO,
> +				       res, size);
> +		if (ret)
> +			return ret;
> +
> +		bu27034_invalidate_read_data(data);
> +	} else {
> +		retry_cnt++;
> +
> +		/* No new data in sensor. Wait and retry */
> +		msleep(25);
> +

Might as well do this before the msleep given erroring out anyway.

> +		if (retry_cnt > BU27034_RETRY_LIMIT) {
> +			dev_err(data->dev, "No data from sensor\n");
> +
> +			return -ETIMEDOUT;
> +		}
> +
> +		goto retry;
> +	}
> +
> +	return ret;
> +}


