Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE77612458
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ2QBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ2QBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:01:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9E2EF1B;
        Sat, 29 Oct 2022 09:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6632DB80B26;
        Sat, 29 Oct 2022 16:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D796C433C1;
        Sat, 29 Oct 2022 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667059304;
        bh=RMnQxQLboifB1vAehNLHSy1heX1Iqr9i7TnyW6bU4dg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qPKpaTciIW45ZpA33WKkF+6ItLVxXEFn0OswuswrAOw1PyikffRUl5DdgwtU40BPt
         inFfbzB6Wv7zLfpfchy8Vzdc/KMH+Yx28dgIdT3YUtCnSSdyYsdPQJ/AqO4En8FCqM
         pRyY+G5LzMp8SzWg9oDqImiebg0333ZAV68blG093C18Pkkdhkd0I4TD+svBiTnZvl
         9/aE0oVeRMos89aT8HkIGRSwNn4D5rAwvMKUxy6uvC3x/3btBVDuVvCvMaccKhilNY
         2vh0VCKbCD9ZDp+px7Z5AYIRq5Mt5Qwn6Tu1ycHFP0i0MW98WCFIcbjsEhPC6UD7HJ
         S5+f54k7wii9A==
Date:   Sat, 29 Oct 2022 17:13:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: addac: add AD74115 driver
Message-ID: <20221029171337.43e9d845@jic23-huawei>
In-Reply-To: <20221003103016.195805-3-demonsingur@gmail.com>
References: <20221003103016.195805-1-demonsingur@gmail.com>
        <20221003103016.195805-3-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Oct 2022 13:30:15 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The AD74115H is a single-channel, software-configurable, input and
> output device for industrial control applications. The AD74115H
> provides a wide range of use cases, integrated on a single chip.
> 
> These use cases include analog output, analog input, digital output,
> digital input, resistance temperature detector (RTD), and thermocouple
> measurement capability. The AD74115H also has an integrated HART modem.
> 
> A serial peripheral interface (SPI) is used to handle all communications
> to the device, including communications with the HART modem. The digital
> input and digital outputs can be accessed via the SPI or the
> general-purpose input and output (GPIO) pins to support higher
> speed data rates.
> 
> The device features a 16-bit, sigma-delta analog-to-digital converter
> (ADC) and a 14-bit digital-to-analog converter (DAC).
> The AD74115H contains a high accuracy 2.5 V on-chip reference that can
> be used as the DAC and ADC reference.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin,

Took me a touch longer than expected to get back to this.

Anyhow, a few minor comments inline. It's a huge driver so I'm not going
to looks super closely at individual register settings etc (I rarely
do unless something 'smells' off!)

Biggest additional thing in here is a suggest to change the fw parsing
code to make it clear when we are just parsing and when applying the
result.

Rest looked good to me.

Jonathan



> +static int _ad74115_get_adc_code(struct ad74115_state *st,
> +				 enum ad74115_adc_ch channel, int *val)
> +{
> +	unsigned int uval;
> +	int ret;
> +
> +	reinit_completion(&st->adc_data_completion);
> +
> +	ret = ad74115_set_adc_ch_en(st, channel, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74115_set_adc_conv_seq(st, AD74115_ADC_CONV_SEQ_SINGLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_completion_timeout(&st->adc_data_completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret) {
> +		ret = -ETIMEDOUT;
> +		return ret;

		return -ETIMEDOUT;

> +	}
> +
> +	ret = regmap_read(st->regmap, ad74115_adc_ch_data_regs[channel], &uval);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74115_set_adc_conv_seq(st, AD74115_ADC_CONV_SEQ_STANDBY);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad74115_set_adc_ch_en(st, channel, false);
> +	if (ret)
> +		return ret;
> +
> +	*val = uval;
> +
> +	return IIO_VAL_INT;
> +}
...


> +static int ad74115_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ad74115_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (ad74115_is_diag_channel(chan->channel))
> +			return ad74115_get_diag_scale(st, chan, val, val2);
> +		else if (chan->output)
> +			return ad74115_get_dac_scale(st, chan, val, val2);
> +
> +		return ad74115_get_adc_scale(st, chan, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (ad74115_is_diag_channel(chan->channel))
> +			return ad74115_get_diag_offset(st, chan, val, val2);
> +		else if (chan->output)
> +			return ad74115_get_dac_offset(st, chan, val);
> +
> +		return ad74115_get_adc_offset(st, chan, val);
> +	case IIO_CHAN_INFO_RAW:

Trivial: Perhaps order these to match the enum order.

> +		if (chan->output)
> +			return ad74115_get_dac_code(st, chan, val);
> +
> +		return ad74115_get_adc_code(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = ad74115_get_adc_code(indio_dev, chan, val);
> +		if (ret)
> +			return ret;
> +
> +		return ad74115_adc_code_to_resistance(*val, val, val2);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (chan->output)
> +			return ad74115_get_dac_rate(st, chan, val);
> +
> +		return ad74115_get_adc_rate(st, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad74115_parse_fw_prop(struct ad74115_state *st,
> +				 const struct ad74115_fw_prop *prop, u32 *retval)
> +{
> +	struct device *dev = &st->spi->dev;
> +	u32 val;
> +	int ret;
> +
> +	if (prop->is_boolean) {
> +		val = device_property_read_bool(dev, prop->name);

Maybe worth splitting this into two separate utility functions as there isn't
a lot of overlap for the is_boolean case with the others.

> +	} else {
> +		ret = device_property_read_u32(dev, prop->name, &val);
> +		if (ret)
> +			return 0;
> +	}
> +
> +	*retval = val;
> +
> +	if (prop->is_boolean) {
> +		if (prop->negate)
> +			val = !val;
> +	} else {
> +		if (prop->lookup_tbl)
> +			ret = _ad74115_find_tbl_index(prop->lookup_tbl,
> +						      prop->lookup_tbl_len,
> +						      val, &val);
> +		else if (prop->max && val > prop->max)
> +			ret = -EINVAL;
> +		else
> +			ret = 0;
> +
> +		if (ret)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid value %u for prop %s\n",
> +					     val, prop->name);
> +	}
> +
> +	if (!prop->mask)

I'm not sure I like the fact there is a mask or not controlling if this
is directly applied. That isn't obvious at the call sight.  Perhaps add
an explicit parameter to the function call - or rename it to have
ad75115_parse_fw_prop() called by ad75115_apply_fw_prop() (see below)
So at the call site it is immediately clear if a state update is an expected
side effect.

> +		return 0;
> +
> +	val = (val << __ffs(prop->mask)) & prop->mask;
> +
> +	return regmap_update_bits(st->regmap, prop->reg, prop->mask, val);
Not obvious from function naming that you will do a register update.
Perhaps rename as
	ad74115_apply_fw_prop() or something along those lines?

> +}
> +


> +static int ad74115_setup_comp_gc(struct ad74115_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD74115_DIN_CONFIG1_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!(val & AD74115_DIN_COMPARATOR_EN_MASK))
> +		return 0;
> +
> +	st->gc.owner = THIS_MODULE;

Could do a structure copy based initialization for this.

	st->gc = (struct gpio_chip) {
		.owner = 
		.label = ...
	...
	};

Up to you, but generally I think it looks a little nicer.

> +	st->gc.label = AD74115_NAME;
> +	st->gc.base = -1;
> +	st->gc.ngpio = 1;
> +	st->gc.parent = dev;
> +	st->gc.can_sleep = true;
> +	st->gc.get_direction = ad74115_comp_gpio_get_direction;
> +	st->gc.get = ad74115_comp_gpio_get;
> +	st->gc.set_config = ad74115_comp_gpio_set_config;
> +
> +	return devm_gpiochip_add_data(dev, &st->gc, st);
> +}
> +
> +static int ad74115_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad74115_state *st = iio_priv(indio_dev);
> +	unsigned int i;
> +	u32 val;
> +	int ret;
> +
> +	val = AD74115_CH_FUNC_HIGH_IMPEDANCE;
> +	ret = ad74115_parse_fw_prop(st, &ad74115_ch_func_fw_prop, &val);

As mentioned above, I'd like to see it clearer on whether these
calls apply the configuration or just parse the fw.

> +	if (ret)
> +		return ret;
> +
> +	indio_dev->num_channels += ad74115_channels_map[val].num_channels;
> +	st->ch_func = val;
> +
> +	val = false;
> +	ret = ad74115_parse_fw_prop(st, &ad74115_dac_hart_slew_prop, &val);
> +	if (ret)
> +		return ret;
> +
> +	st->dac_hart_slew = val;
> +
> +	if (val) {
> +		ret = regmap_update_bits(st->regmap, AD74115_OUTPUT_CONFIG_REG,
> +					 AD74115_OUTPUT_SLEW_EN_MASK,
> +					 FIELD_PREP(AD74115_OUTPUT_SLEW_EN_MASK,
> +						    AD74115_SLEW_MODE_HART));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	val = AD74115_DIN_THRESHOLD_MODE_AVDD;
> +	ret = ad74115_parse_fw_prop(st, &ad74115_din_threshold_mode_fw_prop, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val == AD74115_DIN_THRESHOLD_MODE_AVDD) {
> +		ret = regulator_get_voltage(st->regulators[AD74115_AVDD_REGULATOR].consumer);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->avdd_mv = ret / 1000;
> +	}
> +
> +	st->din_threshold_mode = val;
> +
> +	val = false;
> +	ret = ad74115_parse_fw_prop(st, &ad74115_dac_bipolar_fw_prop, &val);
> +	if (ret)
> +		return ret;
> +
> +	st->dac_bipolar = val;
> +
> +	val = AD74115_RTD_MODE_3_WIRE;
> +	ret = ad74115_parse_fw_prop(st, &ad74115_ch_func_fw_prop, &val);
> +	if (ret)
> +		return ret;
> +
> +	st->rtd_mode = val;
> +
> +	for (i = 0; i < AD74115_GPIO_NUM; i++) {
> +		val = AD74115_GPIO_MODE_LOGIC;
> +
> +		ret = ad74115_parse_fw_prop(st, &ad74115_gpio_mode_fw_props[i], &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val == AD74115_GPIO_MODE_LOGIC)
> +			st->gpio_valid_mask |= BIT(i);
> +	}
> +
> +	for (i = 0; i < AD74115_DIAG_NUM; i++) {
> +		val = AD74115_DIAG_FUNC_DISABLED;
> +
> +		ret = ad74115_parse_fw_prop(st, &ad74115_diag_func_fw_props[i], &val);
> +		if (ret)
> +			return ret;
> +
> +		st->diag_func[i] = val;
> +
> +		if (val != AD74115_DIAG_FUNC_DISABLED)
> +			indio_dev->num_channels++;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ad74115_fw_props); i++) {
> +		const struct ad74115_fw_prop *prop = &ad74115_fw_props[i];
> +
> +		ret = ad74115_parse_fw_prop(st, prop, &val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad74115_setup_gc(st);

gc isn't enough to make it obvious to me that this is a gpiochip.
I'd use the extra characters to just spell it out. I briefly wondered what
garbage collection was doing in here ;)

> +	if (ret)
> +		return ret;
> +
> +	ret = ad74115_setup_comp_gc(st);
> +	if (ret)
> +		return ret;
> +
> +	return ad74115_setup_iio_channels(indio_dev);
> +}
> +
>
