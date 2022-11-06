Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7061E36B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 17:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKFQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 11:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKFQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 11:27:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E5B647B;
        Sun,  6 Nov 2022 08:27:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03EC4B80BEC;
        Sun,  6 Nov 2022 16:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A11C433D6;
        Sun,  6 Nov 2022 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667752048;
        bh=hCJrs5Uf/yW96C3G7hDaSyXTbhTNHl+tArJdoN23ZGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p4mpAzzOeo7Bkl4uHUotf8oDMEQCVPKJErS4WY/aO2CRkr07l9etbuDQ4pdHWd0Nb
         Hv/JRxk1LPtnSUBfzU1rbU4CJSElxEbbXiiTTvPuiytH0cz+4IhxSvm07JTEVChOGb
         4hSNn0lDJ8mOFFsEXLgPcgLyDh1car5Su63hWWYayjvKjuB1+ii0zIRexvnyfl0905
         31KakgRvoIpKWIFQ65R1fDcx9NRpwghV5HcLLYIjMjkPRQfnT8SYvD5kO227FzovMA
         CPwo9eLtu95x8ax2sN4/HVBuGAvGSF04I68fG0QOWpxNop1kXY4EJZAn71vKhlASkr
         tyVeaNup8wVwA==
Date:   Sun, 6 Nov 2022 16:27:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: addac: add AD74115 driver
Message-ID: <20221106162718.05fcfd79@jic23-huawei>
In-Reply-To: <20221103094436.2136698-3-demonsingur@gmail.com>
References: <20221103094436.2136698-1-demonsingur@gmail.com>
        <20221103094436.2136698-3-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu,  3 Nov 2022 11:44:36 +0200
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

Inevitably there are a few things I noticed this time that I missed before.

I'll be looking for Linus W input on GPIO chip code.  Probably best to cc linux-gpio
on next posting so it ends up in correct filtered email locations and in
patchwork etc (not sure if gpio uses patchwork).

Biggest thing in here is around IRQ bindings and how they are handled if
the driver later supports more than one (I think the hardware has several
lines where you might do this).  We have walled ourselves into a corner
in the past by not thinking about the binding based on the fact the driver
doesn't yet support it.  Best to add to the binding now and then just not
read it in the driver.  In short, just use a named IRQ and get it by name
rather than spi->irq.

Jonathan



> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> new file mode 100644
> index 000000000000..648fa8e2496b
> --- /dev/null
> +++ b/drivers/iio/addac/ad74115.c
> @@ -0,0 +1,1901 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Analog Devices, Inc.
> + * Author: Cosmin Tanislav <cosmin.tanislav@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/crc8.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +/* 5.10 compatibility */
> +static int iio_device_id(struct iio_dev *indio_dev)
> +{
> +	return indio_dev->id;
> +}
> +
> +#include <linux/slab.h>
> +#define IIO_DMA_MINALIGN ARCH_KMALLOC_MINALIGN

This should not be in the upstream driver, though indeed will be needed for
back porting.

> +/* end 5.10 compatibility */
> +

...




> +
> +static const int ad74115_dac_rate_tbl[] = {

For these, it might be nice to have a few comments on units if relevant...

> +	0,
> +	4 * 8,
> +	4 * 15,
> +	4 * 61,
> +	4 * 222,
> +	64 * 8,
> +	64 * 15,
> +	64 * 61,
> +	64 * 222,
> +	150 * 8,
> +	150 * 15,
> +	150 * 61,
> +	150 * 222,
> +	240 * 8,
> +	240 * 15,
> +	240 * 61,
> +	240 * 222,
> +};
> +

...


...



> +
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
> +	if (st->spi->irq) {

As below. I would not rely on that being the 'right irq'.
It will make a mess of the case where someone attaches just the alert one
and not the adc ready one.  The old rule - if someone can wire up an annoying
combination of pins, they will...

> +		ret = wait_for_completion_timeout(&st->adc_data_completion,
> +						  msecs_to_jiffies(1000));
> +		if (!ret)
> +			return -ETIMEDOUT;
> +	} else {
> +		unsigned int regval, wait_time;
> +		int rate;
> +
> +		ret = ad74115_get_adc_rate(st, channel, &rate);
> +		if (ret < 0)
> +			return ret;
> +
> +		wait_time = DIV_ROUND_CLOSEST(AD74115_CONV_TIME_US, rate);
> +
> +		ret = regmap_read_poll_timeout(st->regmap, AD74115_LIVE_STATUS_REG,
> +					       regval, regval & AD74115_ADC_DATA_RDY_MASK,
> +					       wait_time, 5 * wait_time);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * The ADC_DATA_RDY bit is W1C.
> +		 * See datasheet page 98, Table 62. Bit Descriptions for
> +		 * LIVE_STATUS.
> +		 * Although the datasheet mentions that the bit will auto-clear
> +		 * when writing to the ADC_CONV_CTRL register, this does not
> +		 * seem to happen.
> +		 */
> +		ret = regmap_write_bits(st->regmap, AD74115_LIVE_STATUS_REG,
> +					AD74115_ADC_DATA_RDY_MASK,
> +					FIELD_PREP(AD74115_ADC_DATA_RDY_MASK, 1));
> +		if (ret)
> +			return ret;
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
> +


> +
> +static int ad74115_set_dac_code(struct ad74115_state *st,
> +				enum ad74115_dac_ch channel, int val)
> +{
> +	if (val < 0)
> +		return -EINVAL;
> +
> +	if (channel == AD74115_DAC_CH_COMPARATOR) {
> +		if (val > AD74115_COMP_THRESH_MAX)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(st->regmap, AD74115_DIN_CONFIG2_REG,
> +					  AD74115_COMP_THRESH_MASK,
> +					  FIELD_PREP(AD74115_COMP_THRESH_MASK, val));
> +	}
> +
> +	if (val > AD74115_DAC_CODE_MAX)
> +		return -EINVAL;
> +
> +	return regmap_write(st->regmap, AD74115_DAC_CODE_REG, val);

See below. This is another one I think would be nicer as an if /else
> +}
> +


> +
> +static int ad74115_get_adc_offset(struct ad74115_state *st,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2)
> +{
> +	unsigned int range;
> +	int ret;
> +
> +	ret = ad74115_get_adc_range(st, chan->channel, &range);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->type == IIO_RESISTANCE) {
> +		unsigned int d = 10 * AD74115_REF_RESISTOR_OHMS
> +				 * AD74115_adc_gain[range][1];
> +
> +		*val = 5;
> +
> +		if (ad74115_adc_bipolar[range])
> +			*val -= AD74115_ADC_CODE_HALF;
> +
> +		*val *= d;
> +
> +		if (!st->rtd_mode_4_wire) {
> +			/* Add 0.2 Ohm to the final result for 3-wire RTD. */
> +			unsigned int v = 2 * AD74115_adc_gain[range][0];
> +
> +			if (ad74115_adc_bipolar[range])
> +				v *= AD74115_ADC_CODE_HALF;
> +			else
> +				v *= AD74115_ADC_CODE_MAX;
> +
> +			*val += v;
> +		}
> +
> +		*val2 = d;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	}

Really minor but...

Given the indent below here isn't too high, I would prefer an else
	} else {
to make it clear that we have two equivalent branches of the code just handling
different channel types.

In other similar cases, there indent is huge, so ignore this nice to have and
indeed do it like you have done here (if block that returns then everything else
without an else statement).

> +
> +	if (ad74115_adc_bipolar[range])
> +		*val = -AD74115_ADC_CODE_HALF;
> +	else if (range == AD74115_ADC_RANGE_2_5V_NEG)
> +		*val = -AD74115_ADC_CODE_MAX;
> +	else
> +		*val = 0;
> +
> +	return IIO_VAL_INT;
> +}
> +


> +
> +static const struct iio_info ad74115_info = {
> +	.read_raw = ad74115_read_raw,
> +	.write_raw = ad74115_write_raw,
> +	.read_avail = ad74115_read_avail,
> +	.update_scan_mode = ad74115_update_scan_mode,
> +	.debugfs_reg_access = ad74115_reg_access,
> +};

> +
> +static int ad74115_setup_iio_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad74115_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels, *chans;
> +	unsigned int num_chans;
> +
> +	channels = devm_kcalloc(dev, sizeof(*channels),
> +				indio_dev->num_channels, GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +
> +	chans = ad74115_channels_map[st->ch_func].channels;

I'd find this a little more readable if you just put this parameter directly
into the memcpy call.  Having channels and chans is less clear than it could perhaps
be.

> +	num_chans = ad74115_channels_map[st->ch_func].num_channels;

Likewise with this. 

	memcpy(channels, ad74115_channels_map[st->ch_func].channels,
	       ad74115_channels_map[st->ch_func].num_channels);

isn't too bad.
> +
> +	memcpy(channels, chans, sizeof(*channels) * num_chans);
> +
> +	if (channels[0].output && channels[0].channel == AD74115_DAC_CH_MAIN &&
> +	    channels[0].type == IIO_VOLTAGE && !st->dac_hart_slew) {
> +		channels[0].info_mask_separate |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		channels[0].info_mask_separate_available |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +	}
> +
> +	return 0;
> +}



> +
> +static int ad74115_setup_trigger(struct iio_dev *indio_dev)
> +{
> +	struct ad74115_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	if (!st->spi->irq)

Unusual for a chip this complex to only have one thing that would be treated
as an IRQ.  I checked the datahsheet and there are at least two (ADC_RDY, ALERT)
Hence use a fwnode_irq_get_by_name() and require the names in the binding.

It's possible people will wire either one individually, or both together and
we need to handle that in the binding.  In the driver we can just ignore any
we don't support.

> +		return 0;
> +
> +	ret = devm_request_irq(dev, st->spi->irq, ad74115_adc_data_interrupt,
> +			       0, AD74115_NAME, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", AD74115_NAME,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad74115_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	return 0;
> +}
> +
> +static int ad74115_probe(struct spi_device *spi)
> +{

...


> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,

You store the time but then I don't immediately spot it being used.

> +					      ad74115_trigger_handler,
> +					      &ad74115_buffer_ops);


> +
> +module_driver(ad74115_driver,
> +	      ad74115_register_driver,
> +	      ad74115_unregister_driver);

Trivial but could wrap this less as:
module_driver(ad74115_driver,
	      ad74115_register_driver, ad74115_unregister_driver);

(or the other obvious combination if you prefer.


