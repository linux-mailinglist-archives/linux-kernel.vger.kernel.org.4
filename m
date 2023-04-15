Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82F6E32E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDORfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDORfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AB35AB;
        Sat, 15 Apr 2023 10:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1A86100E;
        Sat, 15 Apr 2023 17:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337B8C433EF;
        Sat, 15 Apr 2023 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681580143;
        bh=TVcUHPpaPtO8tLeCFDqDSsODBDxSsYZH3kpiTWT9uuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VDb//7zK/9oRx/Yz5lUHDmUZZwgCrDdpBsD2eJdkO7Uzxf0Rf3eGtw2NVSLLenJUs
         MvgvGO5CNk6dIRkkfmiqrQvs2j0hMPPBbHU93ldQM/Bbv8sfyDYQ1e9yalEEIizrD4
         5ecpeC+EPw6aeSJRR6lyWM0479mt8BAPSARbNodBAn5IQcBfBjY9l1fSUd2VeWUbu4
         xPk5D2t3+3kiiP6cxJEGEc5+/YyUvUpVfluTh83OHl3mFphBTZT2uiBCfdRaGVuX4L
         W0Y6aE8zD3ysesRliOlF5LRz77Yi9T9F9LXKzy8Io8KIWndM+7a8JaM6oyoIzDljzI
         5PTeeyaS1ugNw==
Date:   Sat, 15 Apr 2023 18:35:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20230415183543.6d5e3392@jic23-huawei>
In-Reply-To: <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
        <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 09:12:03 +0800
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> Driver support for Avago (Broadcom) APDS9306
> Ambient Light Sensor with als and clear channels.
> This driver exposes raw values for both the channels.
> 
> Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
> ---
> 
> Software reset feature is not implemented as it causes I2C bus error,
> the I2C bus driver throws an ugly error message.

That's unfortunate and perhaps something we should consider fixing
at the i2c layer.  Could you point to where it happens?

We have a lot of drivers where reset causes an error (Ack missing normally
due to simple state machines in the devices).

> 
> Could not locate the Lux calculations from datasheet, only exporting
> raw values.

Ah. That's annoying as userspace is generally not able to do much with
the raw values.  Any other known code supporting this device that you
can raid for info?

If not, then this ist he best we can do.

> 
> Reading of the Status register clears the Data Ready and the Interrupt
> Status flags. It makes it tricky to read oneshot values together with
> interrupts enabled as the IRQ handler clears the status on receipt
> of an interrupt signal.
>  
> Not checking the status in IRQ handler will make the interrupt line
> unsharable and it does not reset the interrupt line if the Interrupt
> status flag is not cleared.

Definitely need to check it but I'm not sure I follow why you can't
use it for both purposes with a slightly complex interrupt handler design.
Maybe the code makes it clear what the issue is here.

> 
> Many applications don't need interrupts. It is good to have support
> for both in the driver.

Agreed.
> 
> Sysfs structure with interrupt line defined in DT:
> root@stm32mp1:~# tree -I 'dev|name|of_node|power|subsystem|uevent' \
>   /sys/bus/iio/devices/iio:device0/
> /sys/bus/iio/devices/iio:device0/
> |-- events

These should include the channel they apply to...

> |   |-- thresh_adaptive_either_en
> |   |-- thresh_adaptive_either_value
> |   |-- thresh_adaptive_either_values_available
> |   |-- thresh_channel_select

Non standards ABI needs documentation.
Guessing somewhat but do you have a single set of threshold detectors
that are fed by a mux off the channels?  So can only check one channel
at a time?  If so then you present one set of controls for each channel
and either
a) return -EBUSY if someone tries to turn more on than you support
b) operating in a fifo way - so always enable last one that was enabled.
   reading back values of the attributes will allow userspace to see what
   is turned on.


> |   |-- thresh_channels_available
> |   |-- thresh_either_en
> |   |-- thresh_either_period
> |   |-- thresh_either_period_available
> |   |-- thresh_falling_value
> |   `-- thresh_rising_value
> |-- in_illuminance_raw
> |-- in_intensity_clear_raw
> |-- integration_time
> |-- integration_time_available
> |-- sampling_frequency
> |-- sampling_frequency_available
> |-- scale
> `-- scale_available
> 
> Sysfs structure with no interrupt:
> root@stm32mp1:~# tree -I 'dev|name|of_node|power|subsystem|uevent' \
>   /sys/bus/iio/devices/iio:device0/
> /sys/bus/iio/devices/iio:device0/
> |-- in_illuminance_raw
> |-- in_intensity_clear_raw
> |-- integration_time
> |-- integration_time_available
> |-- sampling_frequency
> |-- sampling_frequency_available
> |-- scale
> `-- scale_available
> 
> As there is a single interrupt enable option, using the existing
> IIO bitmasks to cater for channel selection - als or clear and
> interrupt type selection - threshold or adaptive
> was looking ambiguous. I am open to any other implementations.

This sort of dependency is common but it is effectively impossible
to design a usable ABI that covers all combinations that can occur.
As a result the ABI defines that a write to any sysfs attribute
'might' change the value of any other.   Hence you just have two enables
and enabling 1 turns them both on.

> 
> I could not find any _available implementations for the event
> interface.

Yes - we haven't yet added support except by creating the attributes
manually.  It might be worth doing. I've never checked how useful
it would be.

> 
> Created one sysfs attribute for interrupt channel selection
> and one RO attribute for channel availability.
> 
> Created two RO attributes for interrupt period and threshold
> adaptive value available ranges.
> 
> The ALS Measurement Rate (Sampling Frequency) has max values
> of 2000ms and 2000ms for both 110b and 111b respectively.
> This is not a typo. Found out experimentally that assigning
> either values, interrupt is generated 2 secs apart when
> interrupt conditions are met.
> 

Some comments inline.  Given we have these big questions, I didn't focus
too much on details. That can come later once the big stuff looks right.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> new file mode 100644
> index 000000000000..d57fb7aaa24d
> --- /dev/null
> +++ b/drivers/iio/light/apds9306.c
> @@ -0,0 +1,1146 @@

> +static struct iio_event_spec apds9306_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH_ADAPTIVE,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 20,
> +			.storagebits = 32,
> +		},
> +		.event_spec = apds9306_event_spec,
> +		.num_event_specs = ARRAY_SIZE(apds9306_event_spec),
You'll end up with event specs for both channels.

> +	},
> +	{
	}, { 

is fine and more compact. Can use this in all similar places.

> +		.type = IIO_INTENSITY,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 20,
> +			.storagebits = 32,
> +		},
> +		.modified = 1,
> +	},
> +};
> +
> +static struct iio_chan_spec apds9306_channels_no_events[] = {
> +	{
> +		.type = IIO_LIGHT,

LIGHT is an illumiance measure.  Given you don't have the info to get anywhere
near that and the absorption characteristics are unlikely to be such that
this channel alone can be used to work out the value LIGHT is not the right
type.  This is just another INTENSITY channel. 

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 20,
> +			.storagebits = 32,
> +		},
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all =  BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 20,
> +			.storagebits = 32,
> +		},
> +		.modified = 1,
> +	},
> +};
> +
> +static ssize_t thresh_channel_select_show(struct device *dev,
> +		struct device_attribute *attr, char *buff)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (data->int_ch == 1)
> +		ret = sprintf(buff, "als\n");
> +	else if (data->int_ch == 0)
> +		ret = sprintf(buff, "clear\n");
> +	else
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static ssize_t thresh_channel_select_store(struct device *dev,
> +		struct device_attribute *attr, const char *buff, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, channel;
> +
> +	if (len <= 0 || len > 6)
> +		return -EINVAL;
> +
> +	if (!strncmp(buff, "als", 3))
> +		channel = 1;
> +	else if (!strncmp(buff, "clear", 5))
> +		channel = 0;

As above, provide an event for each channel.  Only one can be enabled
at a time.

> +	else
> +		return -EINVAL;
> +
> +	ret = regmap_field_write(data->regfield_int_src, channel);
> +	if (ret)
> +		return ret;
> +
> +	data->int_ch = channel;
> +
> +	return len;
> +}

...


>
> +static int apds9306_power_state(struct apds9306_data *data,
> +		enum apds9306_power_states state)
> +{
> +	int ret;
> +
> +	/* Reset not included as it causes ugly I2C bus error */
> +	switch (state) {
> +	case standby:
> +		return regmap_field_write(data->regfield_en, 0);
> +	case active:
> +		ret = regmap_field_write(data->regfield_en, 1);
> +		if (ret)
> +			return ret;
> +		/* 5ms wake up time */
> +		usleep_range(5000, 10000);
> +		break;
		return 0;

> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int apds9306_runtime_power(struct apds9306_data *data, int en)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret = 0;
> +
> +	if (en) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "runtime resume failed: %d\n", ret);
> +			return ret;
> +		}
> +		ret = 0;
		return 0;
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
		return 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret, delay, status, int_en;
> +	int retries = 4;
> +	u8 buff[3];
> +
> +	ret = apds9306_runtime_power(data, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Whichever is greater - integration time period or
> +	 * sampling period.
> +	 */
> +	delay = max(apds9306_intg_time[data->intg_time_idx][1],
> +			apds9306_repeat_rate_period[data->repeat_rate_idx]);
> +
> +	/*
> +	 * If interrupts are enabled then Status resistor cannot be
> +	 * relied upon as all the status bits are cleared by the
> +	 * interrupt handler in case of an event.

Ah.  I was assuming sane hardware (always an error :) that would issue
an interrupt on the data being ready.  I think we can make this work
but it is ugly.  Add some flags to the state structure. Then whenever
you read this register, set whether the two status flags are set of not.
Thus in the interrupt handler you can tell if this got there first and
here you can tell if the interrupt handler got their first.

One messy corner.  A status read resets the interrupt line, potentially before
we saw the interrupt. Oh goody - normally this silliness only happens as
a result of complex interrupt migration or errata. However it is understood
what to do about it.

If you see the interrupt status flag here, you have no way of knowing
if the interrupt line was high for long enough that the interrupt controller
saw it.  As such your only option is to assume it didn't and inject an extra
one.  Given a passing of the threshold could in theory have been noisy enough
to trigger two actual interrupts very close together userspace should be fine
with the extra event - we probably just wasted some cycles doing something twice.

The annoying bit will be testing as these races will be somewhat rare.

> +	 */
> +	ret = regmap_field_read(data->regfield_int_en, &int_en);
> +	if (ret) {
> +		dev_err(dev, "read interrupt status failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!int_en) {
> +		while (retries--) {
> +			ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS,
> +					&status);
> +			if (ret) {
> +				dev_err(dev, "read status failed: %d\n", ret);
> +				return ret;
> +			}
> +			if (status & APDS9306_ALS_DATA_STAT_MASK)
> +				break;
> +			/*
> +			 * In case of continuous one-shot read from userspace,
> +			 * new data is available after sampling period.
> +			 * Delays are in the range of 25ms to 2secs.
> +			 */
> +			fsleep(delay);
> +		}
> +	} else
> +		fsleep(delay);
> +
> +	if (!retries)
> +		return -EBUSY;
> +
> +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> +	if (ret) {
> +		dev_err(&data->client->dev, "read data failed\n");
> +		return ret;
> +	}
> +
> +	*val = get_unaligned_le24(&buff[0]);
> +
> +	ret = apds9306_runtime_power(data, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +

> +static int apds9306_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, reg;
> +
> +	mutex_lock(&data->mutex);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->channel2 == IIO_MOD_LIGHT_CLEAR)
> +			reg = APDS9306_CLEAR_DATA_0;
> +		else
> +			reg = APDS9306_ALS_DATA_0;
> +		ret = apds9306_read_data(data, val, reg);
> +		if (!ret)
> +			ret = IIO_VAL_INT;
> +		*val2 = 0;
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = apds9306_intg_time_get(data, val, val2);
> +		if (!ret)
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = apds9306_sampling_freq_get(data, val, val2);
> +		if (!ret)
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = apds9306_gain_get(data, val);
> +		if (!ret)

Please keep the errors out of line.
		if (ret)
			break;
		ret = IIO_VAL_INT;
		*val2 = 0;
		break;

> +			ret = IIO_VAL_INT;
> +		*val2 = 0;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +};
> +
> +static int apds9306_read_avail(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan, const int **vals,
> +			int *type, int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(apds9306_intg_time) * 2;
> +		*vals = (const int *)apds9306_intg_time;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*length = ARRAY_SIZE(apds9306_repeat_rate_freq) * 2;
> +		*vals = (const int *)apds9306_repeat_rate_freq;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*length = ARRAY_SIZE(apds9306_gain);
> +		*vals = apds9306_gain;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Can't get here.

> +}
> +
> +static int apds9306_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val, int val2, long mask)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&data->mutex);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = apds9306_intg_time_set(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = apds9306_sampling_freq_set(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val2 != 0)
> +			break;
> +		ret = apds9306_gain_set(data, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info apds9306_info_no_events = {
> +		.read_raw = apds9306_read_raw,
> +		.read_avail = apds9306_read_avail,
> +		.write_raw = apds9306_write_raw,
> +};
> +
> +static irqreturn_t apds9306_irq_handler(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, status;
> +
> +	/* The interrupt line is released and the interrupt flag is

	/*
	 * The interrupt.

> +	 * cleared as a result of reading the status register
> +	 */
> +	ret = regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "status reg read failed\n");
> +		return IRQ_HANDLED;
> +	}
> +
> +	if ((status & APDS9306_ALS_INT_STAT_MASK)) {
> +		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +				data->int_ch, IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> +		iio_get_time_ns(indio_dev));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int apds9306_read_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int *val, int *val2)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	u8 buff[3];
> +	int var, ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD) {
> +			ret = apds9306_event_period_get(data, val);
> +			if (ret)
> +				return ret;
> +			break;
> +		}
> +
> +		if (dir == IIO_EV_DIR_RISING)
> +			var = APDS9306_ALS_THRES_UP_0;
> +		else if (dir == IIO_EV_DIR_FALLING)
> +			var = APDS9306_ALS_THRES_LOW_0;
> +		else
> +			return -EINVAL;
> +
> +		ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_le24(&buff[0]);
> +	break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = apds9306_event_thresh_adaptive_get(data, val);
> +		if (ret)
> +			return ret;
> +	break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	*val2 = 0;
> +	return IIO_VAL_INT;

Pull this into the cases above so you can return directly.

> +}
> +
> +static int apds9306_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	unsigned int var;
> +	u8 buff[3];
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
> +			return apds9306_event_period_set(data, val);
> +		if (dir == IIO_EV_DIR_RISING)
> +			var = APDS9306_ALS_THRES_UP_0;
> +		else if (dir == IIO_EV_DIR_FALLING)
> +			var = APDS9306_ALS_THRES_LOW_0;
> +		else
> +			return -EINVAL;
> +
> +		if (val < 0 || val > 0xFFFFF)
> +			return -EINVAL;
> +
> +		put_unaligned_le24(val, buff);
> +		return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return apds9306_event_thresh_adaptive_set(data, val);
> +	default:
> +		return -EINVAL;
> +	}
> +

Can't get here.

> +	return 0;
> +}
> +
> +static int apds9306_read_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		ret = regmap_field_read(data->regfield_int_en, &val);
> +		if (ret)
> +			return ret;
> +		return val;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_read(data->regfield_int_thresh_var_en, &val);
> +		if (ret)
> +			return ret;
> +		return val;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Can't get here so don't have this final return. 

> +}
> +
> +static int apds9306_write_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					int state)
> +{
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret, curr_state;
> +
> +	state = !!state;
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		ret = regmap_field_read(data->regfield_int_en, &curr_state);
> +		if (ret)
> +			return ret;
> +		if (curr_state == state)
> +			return 0;
> +		ret = regmap_field_write(data->regfield_int_en, state);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->mutex);

This seems unusual.  I don't follow why lock is needed here.

> +		ret = apds9306_runtime_power(data, state);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;

		return ret;

> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_write(data->regfield_int_thresh_var_en, state);
> +		if (ret)
> +			return ret;

		return regmap...

> +		break;
> +	default:
> +		ret = -EINVAL;

Early returns are more readable.
		return -EINVAL;

> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info apds9306_info = {
> +		.event_attrs = &apds9306_event_attr_group,

Indented one tab more than needed.

> +		.read_raw = apds9306_read_raw,
> +		.read_avail = apds9306_read_avail,
> +		.write_raw = apds9306_write_raw,
> +		.read_event_value = apds9306_read_event,
> +		.write_event_value = apds9306_write_event,
> +		.read_event_config = apds9306_read_event_config,
> +		.write_event_config = apds9306_write_event_config,
> +};
> +
> +static void apds9306_powerdown(void *ptr)
> +{
> +	struct apds9306_data *data = (struct apds9306_data *)ptr;
> +	int status;
> +
> +	/* Disable interrupts */
> +	regmap_field_write(data->regfield_int_thresh_var_en, 0);
> +	regmap_field_write(data->regfield_int_en, 0);
> +	/* Clear status */

Why?

> +	regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
> +	/* Put the device in standby mode */
> +	apds9306_power_state(data, standby);
> +}
> +
> +static int apds9306_init_device(struct apds9306_data *data)

If an error occurs, this function should be as side effect free
as we can make it easily.  So I'd expect to see the power
state disabled on error. Some of the register writes look harmless
to leave in place on error though so can skip those.



> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +
> +	ret = apds9306_power_state(data, active);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 5000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = regmap_reinit_cache(data->regmap, &apds9306_regmap);
> +	if (ret)
> +		return ret;
> +
> +	/* Integration time: 100 msec */
> +	ret = apds9306_intg_time_set(data, 0, 100000);
> +	if (ret)
> +		return ret;
> +
> +	/* Sampling frequency: 100 msec, 10 Hz */
> +	ret = apds9306_sampling_freq_set(data, 10, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Scale: x3 */
> +	ret = apds9306_gain_set(data, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* Interrupt source channel: als */
> +	ret = regmap_field_write(data->regfield_int_src, 1);
> +	if (ret)
> +		return ret;
> +	data->int_ch = 1;
> +
> +	/* Interrupts disabled */
> +	ret = regmap_field_write(data->regfield_int_en, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Threshold Variance disabled */
> +	ret = regmap_field_write(data->regfield_int_thresh_var_en, 0);
> +	if (ret)
> +		return ret;
return regmap_field_write()

one of the static analysis tools loves this, so if we don't tidy it up
we'll probably get a patch soon to 'fix' it.  Better to do it from the
start.
> +
> +	return 0;
> +}
> +
> +static int apds9306_probe(struct i2c_client *client)
> +{
> +	struct apds9306_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->indio_dev = indio_dev;
> +
> +	mutex_init(&data->mutex);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &apds9306_regmap);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +					"regmap initialization failed\n");
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	ret = apds9306_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"regfield initialization failed\n");
> +
> +	ret = devm_regulator_get_enable(&client->dev, "vin");
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +					"Failed to enable regulator\n");
> +
> +	indio_dev->name = "apds9306";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	if (client->irq) {
> +		indio_dev->info = &apds9306_info;
> +		indio_dev->channels = apds9306_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels);
> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +				apds9306_irq_handler, IRQF_TRIGGER_FALLING |
> +				IRQF_ONESHOT, "apds9306_event", indio_dev);
> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					"failed to assign interrupt.\n");
> +	} else {
> +		indio_dev->info = &apds9306_info_no_events;
> +		indio_dev->channels = apds9306_channels_no_events;
> +		indio_dev->num_channels = ARRAY_SIZE(apds9306_channels_no_events);
> +	}
> +
> +	ret = devm_add_action_or_reset(&client->dev, apds9306_powerdown, data);
What is this paired with?  Normally a devm action has to be undoing something
that it follows.  Here I'm not immediately seeing a power up.  Perhaps it should
follow init below?  

> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				"failed to add action on driver unwind\n");
> +
> +	ret = apds9306_init_device(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "failed to init device\n");
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static int apds9306_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = apds9306_power_state(data, standby);
> +	if (ret)
> +		regcache_cache_only(data->regmap, true);
> +
> +	return ret;
> +}
> +
> +static int apds9306_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	regcache_cache_only(data->regmap, false);
> +	ret = regcache_sync(data->regmap);
> +	if (!ret) {
> +		ret = apds9306_power_state(data, active);

Add a comment on why this might be needed only sometimes. Not obvious to me.

> +		if (ret)
> +			regcache_cache_only(data->regmap, true);
> +	}
> +
> +	return ret;
> +}

