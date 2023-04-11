Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4776DDB17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDKMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDKMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:44:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CCB1FE4;
        Tue, 11 Apr 2023 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681217038; x=1712753038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vwYPGYgidIyOeVKDbqVxWvaXlk1Hi4vk7iSFw75N2Gk=;
  b=gNstNlKcoBjhjPFD/L70fOPGTgb8hhEW2cKVDow+IWKOXWdYOavhDmyw
   saSUBmP4EizLlb3DAz1qgZusGnEc2Lq9XanWZnYOTdjUGm/7DC6iGLd+Z
   Nyl0GpsBRwxHvyE0ohrzYEkqO9b3Hxerf/RS9xYQSkj3YI5QYRTSQCcLy
   bIhw4buSExa41P/AYAIFpu0IWe7HJJ2KwyAMUrVciHlBu+h/rBGC44YeR
   WB9YxZhSZQXS8L8Bi5NVa2pmTrItlV3p9SNEFinQ7PbZSOsdxHiod2fS2
   YYkgoMgU2ai9ifuQ/sOERP+yhSYChcxmIqvyFdQzdpHyOFnu7Ki6g/+jl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="406431110"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="406431110"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 05:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="812554445"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812554445"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2023 05:43:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pmDLk-00FGKw-09;
        Tue, 11 Apr 2023 15:43:52 +0300
Date:   Tue, 11 Apr 2023 15:43:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [RFC PATCH 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZDVWB9xV9Cdbwyqd@smile.fi.intel.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411011203.5013-3-subhajit.ghosh@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 09:12:03AM +0800, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306
> Ambient Light Sensor with als and clear channels.
> This driver exposes raw values for both the channels.

...

> Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>

Drop a blank line and make Datasheet: to be a tag.
Datasheet: https://docs.broadcom.com/doc/AV02-4755EN

...

> +/*
> + * APDS-9306/APDS-9306-065 Ambient Light Sensor
> + *
> + * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> + *
> + * I2C Address: 0x52

I guess this can be reordered and condensed a bit:

 * APDS-9306/APDS-9306-065 Ambient Light Sensor
 * I2C Address: 0x52
 * Datasheet: https://docs.broadcom.com/doc/AV02-4755EN

> + * Copyright (C) 2023 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> + */

...

> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/regulator/consumer.h>

Sorted?

+ Blank line.

> +#include <asm/unaligned.h>

...

> +enum apds9306_power_states {
> +	standby,
> +	active,

Namespace? Capital letters?

> +};
> +
> +enum apds9306_int_channels {
> +	clear,
> +	als,

Ditto.

> +};

...

> +/* Sampling Frequency in uSec */
> +static const int apds9306_repeat_rate_period[] = {
> +	25000, 50000, 100000, 200000, 500000, 1000000,
> +	2000000

Can be on a single line.

> +};

...

Perhaps you want to add a few static_asserts() to be sure that the ARRAY_SIZE()
of the tables are all greater or equal to each others.

...

> +struct apds9306_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	/*
> +	 * Protect single als reads and device
> +	 * power states.
> +	 */
> +	struct mutex mutex;
> +
> +	struct regmap *regmap;
> +	/* Reg: MAIN_CTRL, Field: SW_Reset */
> +	struct regmap_field *regfield_sw_reset;
> +	/* Reg: MAIN_CTRL, Field: ALS_EN */
> +	struct regmap_field *regfield_en;
> +	/* Reg: ALS_MEAS_RATE, Field: ALS Resolution/Bit Width */

Why not converting all comments to a kernel-doc for the entire structure?

> +	struct regmap_field *regfield_intg_time;
> +	/* Reg: ALS_MEAS_RATE, Field: ALS Measurement Rate */
> +	struct regmap_field *regfield_repeat_rate;
> +	/* Reg: ALS_GAIN, Field: ALS Gain Range */
> +	struct regmap_field *regfield_scale;
> +	/* Reg: INT_CFG, Field: ALS Interrupt Source */
> +	struct regmap_field *regfield_int_src;
> +	/* Reg: INT_CFG, Field: ALS Variation Interrupt Mode */
> +	struct regmap_field *regfield_int_thresh_var_en;
> +	/* Reg: INT_CFG, Field: ALS Interrupt Enable */
> +	struct regmap_field *regfield_int_en;
> +	/* Reg: INT_PERSISTENCE, Field: ALS_PERSIST */
> +	struct regmap_field *regfield_int_persist_val;
> +	/* Reg: ALS_THRESH_VAR, Field: ALS_THRES_VAR */
> +	struct regmap_field *regfield_int_thresh_var_val;
> +
> +	u8 intg_time_idx;
> +	u8 repeat_rate_idx;
> +	u8 gain_idx;
> +	u8 int_ch;
> +};

...

> +static const struct regmap_config apds9306_regmap = {
> +	.name = "apds9306_regmap",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &apds9306_readable_table,
> +	.wr_table = &apds9306_writable_table,
> +	.volatile_table = &apds9306_volatile_table,
> +	.precious_table = &apds9306_precious_table,
> +	.max_register = APDS9306_ALS_THRES_VAR,
> +	.cache_type = REGCACHE_RBTREE,

Do you need an internal regmap lock? If so, why?

> +};

...

> +static ssize_t thresh_channel_select_show(struct device *dev,
> +		struct device_attribute *attr, char *buff)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (data->int_ch == 1)
> +		ret = sprintf(buff, "als\n");

Must be sysfs_emit().

> +	else if (data->int_ch == 0)
> +		ret = sprintf(buff, "clear\n");

Must be sysfs_emit().

> +	else
> +		ret = -EINVAL;
> +
> +	return ret;

Make the string literal array for these and...

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
> +	else
> +		return -EINVAL;

...use sysfs_match_string().

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

> +static struct attribute *apds9306_event_attributes[] = {
> +	&iio_const_attr_thresh_either_period_available.dev_attr.attr,
> +	&iio_const_attr_thresh_channels_available.dev_attr.attr,
> +	&iio_const_attr_thresh_adaptive_either_values_available.dev_attr.attr,
> +	&iio_dev_attr_thresh_channel_select.dev_attr.attr,
> +	NULL,

No comma for a terminator entry.

> +};

...

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
> +	default:
> +		return -EINVAL;
> +	}

> +	return 0;

Move that to a single user of this line inside the switch-case.

> +}

...

> +	struct device *dev = &data->client->dev;

Why data contains I²C client pointer, what for?

...

> +	int ret = 0;

Unneeded assignment...

> +	if (en) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "runtime resume failed: %d\n", ret);
> +			return ret;
> +		}
> +		ret = 0;
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;

...just return 0 here.

...

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

regmap_read_poll_timeout().

...

> +	*val = get_unaligned_le24(&buff[0]);

buff is enough, but if you want to be too explicit...

...

> +	ret = apds9306_runtime_power(data, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

	return apds...(...);

...

> +		if (apds9306_intg_time[i][0] ==  val &&
> +				apds9306_intg_time[i][1] ==  val2) {

Too many spaces and wrong indentation.

...

> +		if (apds9306_repeat_rate_freq[i][0] ==  val &&
> +				apds9306_repeat_rate_freq[i][1] ==  val2) {

Ditto.

...

> +		if (apds9306_gain[i] ==  val) {

Too many spaces.

...

> +	if (thad > 7)
> +		return -EINVAL;

This 7 should be defined with a meaningful name.

...

> +	if (val < 0 || val > 7)
> +		return -EINVAL;

Ditto.

...

> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;

This assignment is used only once, so make it explicit in that user below.

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

...

> +	/* The interrupt line is released and the interrupt flag is
> +	 * cleared as a result of reading the status register
> +	 */

/*
 * Style of the multi-line comment
 * is wrong.
 */

...

> +	break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = apds9306_event_thresh_adaptive_get(data, val);
> +		if (ret)
> +			return ret;

> +	break;

Wrong indentation of this in entire switch-case. Why the style is different
from piece of code to piece of code?

...

> +		if (val < 0 || val > 0xFFFFF)
> +			return -EINVAL;

Definition and use some plain decimal number if it's about the upper limit of
the respective non-bitwise value.

> +		put_unaligned_le24(val, buff);
> +		return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		return apds9306_event_thresh_adaptive_set(data, val);
> +	default:
> +		return -EINVAL;
> +	}

> +	return 0;

Is it dead code?

> +}

...

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

Ditto.

...

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
> +		ret = apds9306_runtime_power(data, state);
> +		mutex_unlock(&data->mutex);
> +		if (ret)
> +			return ret;
> +		break;
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +		ret = regmap_field_write(data->regfield_int_thresh_var_en, state);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		ret = -EINVAL;

Again, use the same style, here you have no lock, so you may return directly.
No need to have this.

> +	}
> +
> +	return ret;

Why ret?

...

> +	regmap_field_write(data->regfield_int_en, 0);
> +	/* Clear status */
> +	regmap_read(data->regmap, APDS9306_MAIN_STATUS, &status);
> +	/* Put the device in standby mode */
> +	apds9306_power_state(data, standby);


No error checks at all?

...

> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +				apds9306_irq_handler, IRQF_TRIGGER_FALLING |
> +				IRQF_ONESHOT, "apds9306_event", indio_dev);

Re-indent them to have logical split on the lines.

> +		if (ret)
> +			return dev_err_probe(&client->dev, ret,
> +					"failed to assign interrupt.\n");

...

> +static int apds9306_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

WHy? Use dev_get_drvdata() directly.

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

Ditto.

> +	struct apds9306_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	regcache_cache_only(data->regmap, false);
> +	ret = regcache_sync(data->regmap);

> +	if (!ret) {

	if (ret)
		return ret;

> +		ret = apds9306_power_state(data, active);
> +		if (ret)
> +			regcache_cache_only(data->regmap, true);
> +	}
> +
> +	return ret;
> +}

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops, apds9306_runtime_suspend,
> +				apds9306_runtime_resume, NULL);

Do a logical split between lines.

static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
				 apds9306_runtime_suspend, apds9306_runtime_resume, NULL);

Alternatively

static DEFINE_RUNTIME_DEV_PM_OPS(apds9306_pm_ops,
				 apds9306_runtime_suspend,
				 apds9306_runtime_resume,
				 NULL);

...

> +static struct i2c_driver apds9306_driver = {
> +	.driver = {
> +		.name = "apds9306",
> +		.pm = pm_ptr(&apds9306_pm_ops),
> +		.of_match_table = apds9306_of_match,
> +	},
> +	.probe_new = apds9306_probe,
> +	.id_table = apds9306_id,
> +};

> +

Redundant blank line.

> +module_i2c_driver(apds9306_driver);

-- 
With Best Regards,
Andy Shevchenko


