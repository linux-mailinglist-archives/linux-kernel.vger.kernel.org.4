Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3261734140
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjFQNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjFQNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:35:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF83DA;
        Sat, 17 Jun 2023 06:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B993F60A05;
        Sat, 17 Jun 2023 13:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDCEC433C8;
        Sat, 17 Jun 2023 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687008915;
        bh=n4rBRuYgiqBv2BaKNDQe2LR4xdpIGrDOm+z50NkK968=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G/jkecNOpm9BR1gwNYFg9Iy4dhEKaA1sXL5I1xqgIOJqzNw4GABgfTMHspZHmJ9iD
         obieWy3xm92Jsbos1nUgLNCaYQxQKYNv3HHNokLCgNBHU6+rAC6iHV73bxNrTeeMO/
         d2HYM/KQ2q8Ny3JcSRG3G8c3/RsAi3paSFqsKIe0uwDyWR+OWMBRatbd2tTTnQBqWt
         52Q4pMTKED9WOWQN76oRHPrEsBQWtbDAEoGQmRuKf9v+xpjNFC7dmwcIbP4kLj1LPW
         y4wy68LY8wAnsiSZIfO3IsguFvfmstPgeWT6xSkVMCs35ijciyrdXTzDZLWh8OgD5D
         60UOJ5sYa1q1A==
Date:   Sat, 17 Jun 2023 14:35:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Message-ID: <20230617143508.28309834@jic23-huawei>
In-Reply-To: <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 17:10:42 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Murata IRS-D200 is a PIR sensor for human detection. It has support for
> raw data measurements and detection event notification.
> 
> Add a driver with support for triggered buffer and events. Map the
> various settings to the `iio` framework, e.g. threshold values, sampling
> frequency, filter frequencies etc.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Hi Waqar,

Generally looks pretty good to me.
A few comments inline to add to Lars-Peter's review.

Jonathan

> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> new file mode 100644
> index 000000000000..699801d60295
> --- /dev/null
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -0,0 +1,1051 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Murata IRS-D200 PIR sensor.
> + *
> + * Copyright (C) 2023 Axis Communications AB
> + */
> +
> +#include <linux/gpio.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/types.h>
> +
> +#define IRS_DRV_NAME "irsd200"
> +
> +/* Registers. */
> +#define IRS_REG_OP		0x00	/* Operation mode. */
> +#define IRS_REG_DATA_LO		0x02	/* Sensor data LSB. */
> +#define IRS_REG_DATA_HI		0x03	/* Sensor data MSB. */
> +#define IRS_REG_STATUS		0x04	/* Interrupt status. */
> +#define IRS_REG_COUNT		0x05	/* Count of exceeding threshold. */
> +#define IRS_REG_DATA_RATE	0x06	/* Output data rate. */
> +#define IRS_REG_FILTER		0x07	/* High-pass and low-pass filter. */
> +#define IRS_REG_INTR		0x09	/* Interrupt mode. */
> +#define IRS_REG_NR_COUNT	0x0a	/* Number of counts before interrupt. */
> +#define IRS_REG_THR_HI		0x0b	/* Upper threshold. */
> +#define IRS_REG_THR_LO		0x0c	/* Lower threshold. */
> +#define IRS_REG_TIMER_LO	0x0d	/* Timer setting LSB. */
> +#define IRS_REG_TIMER_HI	0x0e	/* Timer setting MSB. */
> +
> +/* Interrupt status bits. */
> +#define IRS_INTR_DATA		0	/* Data update. */
> +#define IRS_INTR_TIMER		1	/* Timer expiration. */
> +#define IRS_INTR_COUNT_THR_AND	2	/* Count "AND" threshold. */
> +#define IRS_INTR_COUNT_THR_OR	3	/* Count "OR" threshold. */
> +
> +/*
> + * Quantization scale value for threshold. Used for conversion from/to register
> + * value.
> + */
> +#define IRS_THR_QUANT_SCALE	128
> +
> +/*
> + * The upper 4 bits in register IRS_REG_COUNT value is the upper count value
> + * (exceeding upper threshold value). The lower 4 is the lower count value
> + * (exceeding lower threshold value).

Code makes this obvious.  This is just a comment that might become wrong in
future (adds little) - so I'd drop it.

> + */
> +#define IRS_UPPER_COUNT(count)	(count >> 4)
> +#define IRS_LOWER_COUNT(count)	(count & GENMASK(3, 0))

What Lars said on this one ((count) & GENMAKS(3, 0)

or better yet FIELD_GET() with appropriately defined mask for each of these
as that is more readable in general.



> +/*
> + * Index corresponds to the (field) value of IRS_REG_FILTER register. Contains
> + * only the fractional part (since the integer part is 0, e.g the first value
> + * corresponds to 0.3 Hz).
> + */
> +static const unsigned int irsd200_hp_filter_freq[2] = {

[] probably easier.  Means reviewer doesn't need to sanity the length.

> +	3,
> +	5,
> +};

> +
> +static int irsd200_setup(struct irsd200_data *data)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* Disable all interrupt sources. */

I assume the device doesn't provide any means of resetting it to get a known
register state?  Bit unusual to need to disable interrupts rather than be
able to assume they are already disabled.

> +	ret = regmap_write(data->regmap, IRS_REG_INTR, 0);
> +	if (ret) {
> +		dev_err(data->dev, "Could not set interrupt sources (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Set operation to active. */
> +	ret = regmap_write(data->regmap, IRS_REG_OP, 0x00);

That 0 value probably wants a define.

> +	if (ret) {
> +		dev_err(data->dev, "Could not set operation mode (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Clear threshold count. */
> +	ret = regmap_read(data->regmap, IRS_REG_COUNT, &val);
> +	if (ret) {
> +		dev_err(data->dev, "Could not clear threshold count (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Clear status. */
> +	ret = regmap_write(data->regmap, IRS_REG_STATUS, 0x0f);
> +	if (ret) {
> +		dev_err(data->dev, "Could not clear status (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

> +
> +static int irsd200_read_data(struct irsd200_data *data, s16 *val)
> +{
> +	unsigned int tmpval;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, IRS_REG_DATA_HI, &tmpval);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not read hi data (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*val = (s16)(tmpval << 8);
> +
> +	ret = regmap_read(data->regmap, IRS_REG_DATA_LO, &tmpval);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not read lo data (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*val |= tmpval;

As below - bulk read and endian conversion if possible.

> +
> +	return 0;
> +}
> +
> +stan 0;
> +}
> +
> +static int irsd200_write_data_rate(struct irsd200_data *data, int val)
> +{
> +	size_t idx;
> +	int ret;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(irsd200_data_rates); ++idx) {
> +		if (irsd200_data_rates[idx] == val)
> +			break;
> +	}
> +
> +	if (idx == ARRAY_SIZE(irsd200_data_rates))
> +		return -ERANGE;
> +
> +	ret = regmap_write(data->regmap, IRS_REG_DATA_RATE, idx);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not write data rate (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Data sheet says the device needs 3 seconds of settling time. */
> +	ssleep(3);
You aren't preventing other userspace reads / writes during that time so
this is a light protection at best.

> +
> +	return 0;
> +}
> +
> +static int irsd200_read_timer(struct irsd200_data *data, int *val, int *val2)
> +{
> +	unsigned int tmpval;
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, IRS_REG_TIMER_HI, &tmpval);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not read hi timer (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/* Value is 10 bits. IRS_REG_TIMER_HI is the two MSBs. */
> +	regval = tmpval << 8;
> +
> +	ret = regmap_read(data->regmap, IRS_REG_TIMER_LO, &tmpval);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Could not read lo timer (%d)\n", ret);
> +		return ret;
> +	}

Bulk read and endian conversion preferred for this as Lars pointed out.
Help with various thing including preventing tearing of the value if someone
else is writing whilst it is being read.

In general, you may want to look at using a local lock to ensure consistent
state whenever there are multiple reads / writes in a given function that userspace
can cause to be called.

> +
> +	regval |= tmpval;
> +
> +	ret = irsd200_read_data_rate(data, val2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = regval;
> +
> +	return 0;
> +}


...

> +
> +static int irsd200_write_hp_filter(struct irsd200_data *data, int val, int val2)
> +{
> +	size_t idx;
> +	int ret;
> +
> +	/* Truncate fractional part to one digit. */
> +	val2 /= 100000;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(irsd200_hp_filter_freq); ++idx) {
> +		if (irsd200_hp_filter_freq[idx] == val2)
> +			break;
> +	}
> +
> +	if (idx == ARRAY_SIZE(irsd200_hp_filter_freq) || val != 0)
> +		return -ERANGE;
> +
> +	ret = regmap_field_write(data->regfields[IRS_REGF_HP_FILTER], idx);
> +	if (ret < 0) {

For regmap calls, they are (I think) all documented as returning 0 for success
and negative otherwise.  That lets you both check the simpler if (ret) and ...

> +		dev_err(data->dev, "Could not write hp filter frequency (%d)\n",
> +			ret);
> +		return ret;

drop this return ret out of the if block here.

In general being able to ignore possibility of ret > 0 simplifies handling.

> +	}
> +
> +	return 0;
> +}
> +
> +static int irsd200_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	int ret;
> +	s16 buf;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = irsd200_read_data(data, &buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = buf;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = irsd200_read_data_rate(data, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int irsd200_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = irsd200_data_rates;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(irsd200_data_rates);
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int irsd200_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = irsd200_write_data_rate(data, val);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int irsd200_write_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info, int val, int val2)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		return irsd200_write_threshold(data, dir, val);
> +	case IIO_EV_INFO_TIMEOUT:
> +		return irsd200_write_timer(data, val, val2);
> +	case IIO_EV_INFO_PERIOD:
> +		return irsd200_write_nr_count(data, val);
> +	case IIO_EV_INFO_LOW_PASS_FILTER_3DB:
> +		return irsd200_write_lp_filter(data, val);
> +	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
> +		return irsd200_write_hp_filter(data, val, val2);

Just to check - filtering is only on the data being used for events? Not
on the direct readback of the data?  Whilst that happens, it's not all that
common - hence the check.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int irsd200_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir != IIO_EV_DIR_RISING && dir != IIO_EV_DIR_FALLING)
> +			return -EINVAL;
> +
> +		ret = regmap_field_read(
> +			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return val;
> +	case IIO_EV_TYPE_CHANGE:
> +		ret = regmap_field_read(
> +			data->regfields[IRS_REGF_INTR_TIMER], &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return val;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int irsd200_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		/*
> +		 * There is no way to tell the hardware to only signal for a
> +		 * single direction. Let's just group IIO_EV_DIR_RISING and
> +		 * IIO_EV_DIR_FALLING together instead of doing extra
> +		 * (unnecessary) post-processing after an interrupt.
> +		 */
If you can't control them separately then you should use the EITHER direction
for the enable.  That means you get in_proximity_thresh_en
covering both thresholds.

> +
> +		/* Clear the count register (by reading from it). */
> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val = !!state;
> +		ret = regmap_field_write(
> +			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return val;
> +	case IIO_EV_TYPE_CHANGE:
> +		val = !!state;
> +		ret = regmap_field_write(data->regfields[IRS_REGF_INTR_TIMER],
> +					 val);
> +		if (ret < 0)
> +			return ret;
> +
> +		return val;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	unsigned int lower_count;
> +	unsigned int upper_count;
> +	unsigned int status = 0;
> +	unsigned int source = 0;
> +	unsigned int clear = 0;
> +	unsigned int count = 0;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, IRS_REG_INTR, &source);
> +	if (ret) {
> +		dev_err(data->dev, "Could not read interrupt source (%d)\n",
> +			ret);
> +		return IRQ_NONE;
> +	}
> +
> +	ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
> +	if (ret) {
> +		dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
> +			ret);
> +		return IRQ_NONE;
> +	}
> +
> +	if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
> +		iio_trigger_poll_nested(indio_dev->trig);
> +		clear |= BIT(IRS_INTR_DATA);
> +	}
> +
> +	if (status & BIT(IRS_INTR_TIMER) && source & BIT(IRS_INTR_TIMER)) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_CHANGE,
> +						    IIO_EV_DIR_NONE),

As below, I'd like more explanation of what this is.
I can't find a datasheet to look it up in.

> +			       iio_get_time_ns(indio_dev));
> +		clear |= BIT(IRS_INTR_TIMER);
> +	}
> +
> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
> +		/*
> +		 * The register value resets to zero after reading. We therefore
> +		 * need to read once and manually extract the lower and upper
> +		 * count register fields.
> +		 */
> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
> +		if (ret)
> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
> +
> +		upper_count = IRS_UPPER_COUNT(count);
> +		lower_count = IRS_LOWER_COUNT(count);
> +
> +		/*
> +		 * We only check the OR mode to be able to push events for
> +		 * rising and falling thresholds. AND mode is covered when both
> +		 * upper and lower count is non-zero, and is signaled with
> +		 * IIO_EV_DIR_EITHER.

Whey you say AND, you mean that both thresholds have been crossed but also that
in that configuration either being crossed would also have gotten us to here?
(as opposed to the interrupt only occurring if value is greater than rising threshold
 and less than falling threshold?)

If it's the first then just report two events.  Either means we don't know, rather
than we know both occurred.  We don't document that well though - so something
we should improved there. whilst a bit confusing: 
https://elixir.bootlin.com/linux/v6.4-rc6/source/Documentation/ABI/testing/sysfs-bus-iio#L792
talks about this.

The bracketed case is more annoying to deal with so I hope you don't mean that.
Whilst we've had sensors that support it in hardware for years, I don't think we
ever came up with a usecase that really justified describing it.

> +		 */
> +		if (upper_count && !lower_count)
> +			dir = IIO_EV_DIR_RISING;
> +		else if (!upper_count && lower_count)
> +			dir = IIO_EV_DIR_FALLING;
> +		else
> +			dir = IIO_EV_DIR_EITHER;
> +
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH, dir),
> +			       iio_get_time_ns(indio_dev));
> +
> +		/*
> +		 * The OR mode will always trigger when the AND mode does, but
> +		 * not vice versa. However, it seems like the AND bit needs to
> +		 * be cleared if data capture _and_ threshold count interrupts
> +		 * are desirable, even though it hasn't explicitly been selected
> +		 * (with IRS_REG_INTR). Either way, it doesn't hurt...
> +		 */
> +		clear |= BIT(IRS_INTR_COUNT_THR_OR) |
> +			 BIT(IRS_INTR_COUNT_THR_AND);
> +	}
> +
> +	if (clear) {
> +		ret = regmap_write(data->regmap, IRS_REG_STATUS, clear);
> +		if (ret)
> +			dev_err(data->dev,
> +				"Could not clear interrupt status (%d)\n", ret);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
> +{
> +	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	s16 buf = 0;
> +	int ret;
> +
> +	ret = irsd200_read_data(data, &buf);
> +	if (ret)
> +		goto end;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
> +					   iio_get_time_ns(indio_dev));
> +
> +end:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return ret ? IRQ_NONE : IRQ_HANDLED;
> +}
> +
> +static int irsd200_buf_postenable(struct iio_dev *indio_dev)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_field_write(data->regfields[IRS_REGF_INTR_DATA], 1);

This looks to be turning on the interrupt.
Whilst the abstract trigger driving capture into a buffer model doesn't always
cleanly fit a driver architecture, in this case this seems like it should be
in the set_trigger_state() callback not here.


> +	if (ret) {
> +		dev_err(data->dev,
> +			"Could not enable data interrupt source (%d)\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int irsd200_buf_predisable(struct iio_dev *indio_dev)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_field_write(data->regfields[IRS_REGF_INTR_DATA], 0);
> +	if (ret) {
> +		dev_err(data->dev,
> +			"Could not disable data interrupt source (%d)\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info irsd200_info = {
> +	.read_raw = irsd200_read_raw,
> +	.read_avail = irsd200_read_avail,
> +	.write_raw = irsd200_write_raw,
> +	.read_event_value = irsd200_read_event,
> +	.write_event_value = irsd200_write_event,
> +	.read_event_config = irsd200_read_event_config,
> +	.write_event_config = irsd200_write_event_config,
> +};
> +
> +static const struct iio_buffer_setup_ops irsd200_buf_ops = {
> +	.postenable = &irsd200_buf_postenable,
> +	.predisable = &irsd200_buf_predisable,
> +};
> +
> +static const struct iio_trigger_ops irsd200_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static const struct iio_event_spec irsd200_event_spec[] = {
> +	/* Upper threshold value. */
As below, the code is pretty much self documenting, so I'd drop
comments that can just become out of date.  Comments are good when they
add information but here I don't think they do.
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate =
> +			BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	/* Lower threshold value. */
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate =
> +			BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	/* Window time. */
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_NONE,
> +		.mask_separate =
> +			BIT(IIO_EV_INFO_TIMEOUT) | BIT(IIO_EV_INFO_ENABLE),

This is unusual use of ABI. Please given some more detail on what it is.

> +	},
> +	/* Number of counts (exceeding thresholds) before interrupt. */
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +	/* Low-pass filter frequency. */

Documentation doesn't add anything over code, so drop it.
Also combined all these cases where type and dir match into one entry
with multiple bits set in mask_separate etc.

> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_LOW_PASS_FILTER_3DB),
> +	},
> +	/* High-pass filter frequency. */
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB),
> +	},
> +};

> +};
> +
> +static int irsd200_probe(struct i2c_client *client)
> +{
> +	struct iio_trigger *trigger;
> +	struct irsd200_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	size_t i;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &irsd200_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Could not initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "Could not allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +	data->dev = &client->dev;
> +	i2c_set_clientdata(client, indio_dev);

I'm not seeing any where this is ready back... Don't set it unless you need
it.

> +
> +	for (i = 0; i < IRS_REGF_MAX; ++i) {
> +		data->regfields[i] = devm_regmap_field_alloc(
> +			data->dev, data->regmap, irsd200_regfields[i]);
> +		if (IS_ERR(data->regfields[i])) {
> +			dev_err(data->dev,
> +				"Could not allocate register field %zu\n", i);
> +			return PTR_ERR(data->regfields[i]);
> +		}
> +	}
> +
> +	ret = irsd200_setup(data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &irsd200_info;
> +	indio_dev->name = IRS_DRV_NAME;
> +	indio_dev->channels = irsd200_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(irsd200_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "No irq available\n");
> +		return -ENXIO;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +					      irsd200_trigger_handler,
> +					      &irsd200_buf_ops);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Could not setup iio triggered buffer (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					irsd200_irq_thread,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					NULL, indio_dev);
> +	if (ret) {
> +		return dev_err_probe(&client->dev, ret,
> +				     "Could not request irq (%d)\n", ret);
> +	}
Brackets not needed.  Doesn't matter as a one off, but if you take
a lot more of these to dev_err_probe() like here then it will shorten
your code a fair bit and make it slightly easier to review (more on the
screen at a time etc).

As noted in DT binding review, it's definitely a good thing to support
basic operation in the absence of the interrupt line being wired up.
Normally that involves not registering all the stuff that needs the interrupt
and providing alternative iio_info, channels and some polling code to
us for data ready detection.  On majority of hardware you can make triggered
buffers work without interrupts (driven by an hrtimer trigger or similar)
so you keep that available for both interrupt and non interrupt cases.


> +
> +	trigger = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +					 indio_dev->name,
> +					 iio_device_id(indio_dev));
> +	if (!trigger) {
> +		dev_err(&client->dev, "Could not allocate iio trigger\n");
> +		return -ENOMEM;
> +	}
> +
> +	trigger->ops = &irsd200_trigger_ops;
> +	iio_trigger_set_drvdata(trigger, indio_dev);
> +
> +	ret = devm_iio_trigger_register(&client->dev, trigger);
> +	if (ret) {
> +		dev_err(&client->dev, "Could not register iio trigger (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "Could not register iio device (%d)\n",
> +			ret);
> +		return ret;

Lars pointed this out already. It is fine (and generally a good idea) to
use dev_err_probe() for paths like this in probe.   Some of it's functionality 
is irrelevant (the deferred handling) but it does no harm in other paths and
makes the code more compact and easier to review.

> +	}
> +
> +	return 0;
> +}

