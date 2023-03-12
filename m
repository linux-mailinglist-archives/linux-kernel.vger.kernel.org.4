Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32E6B672C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCLOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47BB5597;
        Sun, 12 Mar 2023 07:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F81A60F1A;
        Sun, 12 Mar 2023 14:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267B6C4339B;
        Sun, 12 Mar 2023 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678631694;
        bh=oac2fdYqDxmMrUC4PVZKwkKEycN5lb/57MI7TSw81ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s5mHfhrK8lYrPK1dGXjKHC0SOpGsKEPKiP3OAdIF/f4igUunGotE5vfH+vSN/bZRt
         m65t4jJ6QQ8xUrDwXoz0Iil4dndMD06O6QuHI5q2x1jpSuVZ8GqMHSb9ZAoDf2eYSQ
         huRL/sr8GpxpT1GEuc7kk+/VN6tWmx535EpbtB3vMUpO8d+CR2+wzZOlfyQqzgV+51
         lCtlb3UL1SWHyEKmdzlaU399Ih2U37Sbn6Dmnrej1UMu5uggQKGkvWXJKi2qNBtNBy
         lz2+9h4ENPeaiti0jne+AsVehyQutJShESiiHLUsHYPq6pVE5daJ6CC1C1BNUzwfJS
         YNutIfi0tThXw==
Date:   Sun, 12 Mar 2023 14:34:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] misc: apds990x: convert to IIO
Message-ID: <20230312143459.0fe735d7@jic23-huawei>
In-Reply-To: <20230308090219.12710-4-clamor95@gmail.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
        <20230308090219.12710-4-clamor95@gmail.com>
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

On Wed,  8 Mar 2023 11:02:18 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Convert old sysfs export to an IIO look.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

This needs ABI documentation for all the custom ABI.
Documentation/ABI/testing/sysfs-bus-iio-adps9900

Note that we generally reluctant to add custom ABI if we can possibly
avoid it because it can't be used by generic code.
We are open to adding new standard ABI, but for that we need to clearly understand
the current gap.

Things are more complex for moves from other subsystems because
of a need for backwards compatibility.  That does concern me here as
there may be users who are relying on the misc interface who will be completely
broken by that changing.  Do we have good reason to assume that won't
be a problem here?

Jonathan



> ---
>  drivers/misc/apds990x.c | 794 ++++++++++++++++++++--------------------
>  1 file changed, 403 insertions(+), 391 deletions(-)
> 
> diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
> index c53ead5a575d..0352962d6d89 100644
> --- a/drivers/misc/apds990x.c
> +++ b/drivers/misc/apds990x.c
> @@ -20,6 +20,9 @@
>  #include <linux/slab.h>
>  #include <linux/platform_data/apds990x.h>
>  
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
>  /* Register map */
>  #define APDS990X_ENABLE	 0x00 /* Enable of states and interrupts */
>  #define APDS990X_ATIME	 0x01 /* ALS ADC time  */
> @@ -100,6 +103,21 @@
>  
>  #define APDS990X_LUX_OUTPUT_SCALE 10
>  
> +enum {
> +	APDS990X_LUX_RANGE_ATTR = 1,
> +	APDS990X_LUX_CALIB_FORMAT_ATTR,
> +	APDS990X_LUX_CALIB_ATTR,
> +	APDS990X_LUX_RATE_AVAIL_ATTR,
> +	APDS990X_LUX_RATE_ATTR,
> +	APDS990X_LUX_THRESH_ABOVE_ATTR,
> +	APDS990X_LUX_THRESH_BELOW_ATTR,
> +	APDS990X_PROX_SENSOR_RANGE_ATTR,
> +	APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR,
> +	APDS990X_PROX_REPORTING_MODE_ATTR,
> +	APDS990X_PROX_REPORTING_MODE_AVAIL_ATTR,
> +	APDS990X_CHIP_ID_ATTR,
See below.  I'm not keen on the approach of one attr callback.
There is very little shared code, so I'd rather just see
individual minimal callbacks.

> +};
> +
>  /* Reverse chip factors for threshold calculation */
>  struct reverse_factors {
>  	u32 afactor;
> @@ -116,7 +134,7 @@ struct apds990x_chip {
>  	struct regulator_bulk_data	regs[2];
>  	wait_queue_head_t		wait;
>  
> -	int	prox_en;
> +	bool	prox_en;

This change seems unrelated to the interface change, so I'd prefer to
see it as a separate patch.  However, I'm not keen on channel enable being
used for a proximity sensor.  Userspace generally only deals with specific
channel enables for functions that count over time - so things like step
counters on IMUs.  For proximity channels the fact someone is reading it
is usually the 'enable'.  If the enable is slow, then runtime_pm autosuspend
type approaches can be used to disable it only if no one reads it for a while.

>  	bool	prox_continuous_mode;
>  	bool	lux_wait_fresh_res;
>  
> @@ -235,12 +253,8 @@ static int apds990x_write_word(struct apds990x_chip *chip, u8 reg, u16 data)
>  
>  static int apds990x_mode_on(struct apds990x_chip *chip)

Not part of your patch  but mode_on is not (to me) clear naming
for what this function is doing.  If it's turning the device on
then apds990x_enable() or adps990x_xxx_enable() with description of what
is being enabled would be clearer.

>  {
> -	/* ALS is mandatory, proximity optional */
>  	u8 reg = APDS990X_EN_AIEN | APDS990X_EN_PON | APDS990X_EN_AEN |
> -		APDS990X_EN_WEN;
> -
> -	if (chip->prox_en)
> -		reg |= APDS990X_EN_PIEN | APDS990X_EN_PEN;
> +		APDS990X_EN_WEN | APDS990X_EN_PIEN | APDS990X_EN_PEN;
>  
>  	return apds990x_write_byte(chip, APDS990X_ENABLE, reg);
>  }

...


> +static const char * const reporting_modes[] = { "trigger", "periodic" };

This sort of operating mode switch is effectively useless to generic userspace.
There are too many ways this is described on datasheets and different ways
devices implement these modes (some devices have lots of different modes) to
be able to design a useful generic userspace interface.

What we try to do is to make that decision automatically based on the userspace
interfaces used. Now I haven't looked in detail, so I'm basing the following
no an educated guess as to what these mean.

Normally a triggered mode is the state used when doing slow polled reads
(sysfs reads via read_raw()).  A periodic mode is that one that should be used
either when events are enabled (threshold detection etc) or when we are using
the buffered modes that IIO supports (access via a character device)

Given there is usually a clean mapping to how it is being used, we don't
expose the details of what the device 'mode' is.
The same applies to things like low power modes that affect latency of
readings.

> +static ssize_t apds990x_lux_prox_show(struct device *dev,

This is clearly doing a lot more than showing lux so is not a good name
for the function.
As a side note, lux is the unit not a thing to measure, so it should be
illuminance if we were talking about the thing measured in lux. 

> +				      struct device_attribute *attr,
> +				      char *buf)
>  {
> -	struct apds990x_chip *chip = dev_get_drvdata(dev);
> -
> -	return sprintf(buf, "%u\n", chip->lux_calib);
> -}
> -
> -static ssize_t apds990x_lux_calib_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t len)
> -{
> -	struct apds990x_chip *chip = dev_get_drvdata(dev);
> -	unsigned long value;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 0, &value);
> -	if (ret)
> -		return ret;
> -
> -	chip->lux_calib = value;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct apds990x_chip *chip = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int i, len = 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	switch ((u32)this_attr->address) {
> +	case APDS990X_LUX_RANGE_ATTR:
> +		len = sprintf(buf, "%u\n", APDS_RANGE);

If we ignore the fact this is a lot of custom ABI which is not a good
thing...

I don't see a good reason for having this as one big hydra of a function.
Just split it up for the individual attrs.  There is very very little shared
in most of these cases. Also there is no need to take the lock in some of
them.

> +		break;
> +	case APDS990X_LUX_CALIB_FORMAT_ATTR:
> +		len = sprintf(buf, "%u\n", APDS_CALIB_SCALER);
> +		break;
> +	case APDS990X_LUX_CALIB_ATTR:
> +		len = sprintf(buf, "%u\n", chip->lux_calib);

Calibration is one area where we do allow more custom ABI because it
can be very device specific.  So this needs documentation and should look
as close as possible to other sensors with calibration controls.

> +		break;
> +	case APDS990X_LUX_RATE_AVAIL_ATTR:
> +		for (i = 0; i < ARRAY_SIZE(arates_hz); i++)
> +			len += sprintf(buf + len, "%d ", arates_hz[i]);

It's not called rate in the IIO ABI.  sampling_frequency is what
you should use and that has read_avail() to provide a list of
available sampling frequencies.

> +		len = sprintf(buf + len - 1, "\n");
> +		break;
> +	case APDS990X_LUX_RATE_ATTR:
> +		len = sprintf(buf, "%d\n", chip->arate);
> +		break;
> +	case APDS990X_LUX_THRESH_ABOVE_ATTR:
> +		len = sprintf(buf, "%d\n", chip->lux_thres_hi);

A threshold detector should map to the IIO events interface that
has standard ways to present threshold detections to userspace.

> +		break;
> +	case APDS990X_LUX_THRESH_BELOW_ATTR:
> +		len = sprintf(buf, "%d\n", chip->lux_thres_lo);
> +		break;
> +	case APDS990X_PROX_SENSOR_RANGE_ATTR:
> +		len = sprintf(buf, "%u\n", APDS_PROX_RANGE);

There is standard ABI for range though it's not heavily used because
the scaling of the raw value is usually much more useful.

> +		break;
> +	case APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR:
> +		len = sprintf(buf, "%d\n", chip->prox_thres);
> +		break;
> +	case APDS990X_PROX_REPORTING_MODE_ATTR:
> +		len = sprintf(buf, "%s\n",
> +			      reporting_modes[!!chip->prox_continuous_mode]);

As mentioned above, mode type attributes are normally a very bad idea
because generic code will never touch them.  And for light sensors most
users are going to be using generic code.

> +		break;
> +	case APDS990X_PROX_REPORTING_MODE_AVAIL_ATTR:
> +		len = sprintf(buf, "%s %s\n",
> +			      reporting_modes[0], reporting_modes[1]);
> +		break;
> +	case APDS990X_CHIP_ID_ATTR:
> +		len = sprintf(buf, "%s %d\n", chip->chipname, chip->revision);

The chip name should be in the main iio_dev->name
It is rarely useful to know chip revision at runtime as generic code doesn't
know what to do with it.  So if worth reporting we normally do that via
a print to the log at probe. If there is a good reason it's needed here then
we can discuss that once you've provided ABI docs.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
> +	mutex_unlock(&indio_dev->mlock);
>  	return len;
>  }
>  

...

> +static int apds990x_set_lux_thresh(struct apds990x_chip *chip, u32 *target,
> +				   const char *buf)
>  {
>  	unsigned long thresh;
>  	int ret;
> @@ -908,98 +738,165 @@ static ssize_t apds990x_set_lux_thresh(struct apds990x_chip *chip, u32 *target,
>  	if (!chip->lux_wait_fresh_res)
>  		apds990x_refresh_athres(chip);
>  	mutex_unlock(&chip->mutex);
> -	return ret;
>  
> +	return ret;

Make sure to scrub your patches for non related changes. They add noise
when we are trying to understand the real and complex parts of this patch.

>  }
>  

> -static ssize_t apds990x_lux_thresh_below_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t len)
> -{
> -	struct apds990x_chip *chip =  dev_get_drvdata(dev);
> -	int ret = apds990x_set_lux_thresh(chip, &chip->lux_thres_lo, buf);
> -
> -	if (ret < 0)
> -		return ret;
> -	return len;
> -}
> +	mutex_lock(&indio_dev->mlock);

An IIO driver should never be taking mlock directly.
It should only be accessed via iio_device_claim_direct_mode() etc
but I can't see why that is relevant here.

mlock is an internal subsystem implementation detail that a driver
shouldn't be aware of.

> +	switch ((u32)this_attr->address) {
> +	case APDS990X_LUX_CALIB_ATTR:
> +		chip->lux_calib = value;
> +		break;
> +	case APDS990X_LUX_RATE_ATTR:
> +		mutex_lock(&chip->mutex);
> +		ret = apds990x_set_arate(chip, value);
> +		mutex_unlock(&chip->mutex);
>  
> -static DEVICE_ATTR(lux0_thresh_above_value, S_IRUGO | S_IWUSR,
> -		apds990x_lux_thresh_above_show,
> -		apds990x_lux_thresh_above_store);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case APDS990X_LUX_THRESH_ABOVE_ATTR:
> +		ret = apds990x_set_lux_thresh(chip,
> +					      &chip->lux_thres_hi, buf);
>  
> -static DEVICE_ATTR(lux0_thresh_below_value, S_IRUGO | S_IWUSR,
> -		apds990x_lux_thresh_below_show,
> -		apds990x_lux_thresh_below_store);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case APDS990X_LUX_THRESH_BELOW_ATTR:
> +		ret = apds990x_set_lux_thresh(chip,
> +					      &chip->lux_thres_lo, buf);
>  
> -static ssize_t apds990x_prox_threshold_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> -{
> -	struct apds990x_chip *chip =  dev_get_drvdata(dev);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case APDS990X_PROX_THRESH_ABOVE_VALUE_ATTR:
> +		if (value > APDS_RANGE || value == 0 ||
> +		    value < APDS_PROX_HYSTERESIS)
> +			return -EINVAL;
>  
> -	return sprintf(buf, "%d\n", chip->prox_thres);
> -}
> +		mutex_lock(&chip->mutex);
>  
> -static ssize_t apds990x_prox_threshold_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf, size_t len)
> -{
> -	struct apds990x_chip *chip =  dev_get_drvdata(dev);
> -	unsigned long value;
> -	int ret;
> +		chip->prox_thres = value;
> +		apds990x_force_p_refresh(chip);
>  
> -	ret = kstrtoul(buf, 0, &value);
> -	if (ret)
> -		return ret;
> +		mutex_unlock(&chip->mutex);
> +		break;
> +	case APDS990X_PROX_REPORTING_MODE_ATTR:
> +		ret = sysfs_match_string(reporting_modes, buf);
> +		if (ret < 0)
> +			return ret;
>  
> -	if ((value > APDS_RANGE) || (value == 0) ||
> -		(value < APDS_PROX_HYSTERESIS))
> +		chip->prox_continuous_mode = ret;
> +		break;
> +	default:
>  		return -EINVAL;
> +	}
>  
> -	mutex_lock(&chip->mutex);
> -	chip->prox_thres = value;
> -
> -	apds990x_force_p_refresh(chip);
> -	mutex_unlock(&chip->mutex);
> +	mutex_unlock(&indio_dev->mlock);
>  	return len;
>  }
>  


> -static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> -		apds990x_power_state_show,
> -		apds990x_power_state_store);
> -
> -static ssize_t apds990x_chip_id_show(struct device *dev,
> -				   struct device_attribute *attr, char *buf)
> +static int apds990x_lux_raw(struct apds990x_chip *chip)
>  {
> -	struct apds990x_chip *chip =  dev_get_drvdata(dev);
> +	struct device *dev = &chip->client->dev;
> +	int ret;
> +	long timeout;
> +
> +	if (pm_runtime_suspended(dev))

If it's suspended you should be waking it up. Not relying on some
state having been configured somewhere else.

I think that it should be one in the call paths for this anyway
so this check is unnecessary.  Hard to tell though with the diff
in this patch.

> +		return -EIO;
> +
> +	timeout = wait_event_interruptible_timeout(chip->wait,
> +						   !chip->lux_wait_fresh_res,
> +						   msecs_to_jiffies(APDS_TIMEOUT));
> +	if (!timeout)
> +		return -EIO;
> +
> +	mutex_lock(&chip->mutex);
> +
> +	ret = (chip->lux * chip->lux_calib) / APDS_CALIB_SCALER;
> +	if (ret > (APDS_RANGE * APDS990X_LUX_OUTPUT_SCALE))
> +		ret = APDS_RANGE * APDS990X_LUX_OUTPUT_SCALE;
>  
> -	return sprintf(buf, "%s %d\n", chip->chipname, chip->revision);
> +	mutex_unlock(&chip->mutex);
> +
> +	return ret;
>  }
>  
...

>  
>  static int apds990x_of_probe(struct i2c_client *client,
>  			     struct apds990x_chip *chip)
> @@ -1080,15 +1011,114 @@ static int apds990x_of_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int apds990x_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct apds990x_chip *chip = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		apds990x_power_state_switch(chip, true);
> +
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			*val = apds990x_lux_raw(chip);
> +			break;
> +		case IIO_PROXIMITY:
> +			*val = apds990x_prox_raw(chip);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		apds990x_power_state_switch(chip, false);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +		case IIO_PROXIMITY:
> +		default:
> +			*val = 1;
If scale is one, then the values being provided are in the correct units.
Hence you don't need to provide it.

However note that makes the INFO_PROCESSED not INFO_RAW for the sensor
measuring illumaninance at least. It's trickier for the proximity sensor
as they tend to not have well defined scales. Hence fine to leave that
as _RAW without the scale value being provided.

> +			break;
> +		}
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			*val = chip->prox_en;

Mentioned above, but this is almost never a good idea.  Someone reading
proximity should trigger this state transition.

If it is event connected, then add that support to the driver.


> +		default:
> +			break;
> +		}
> +
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +

>  static int apds990x_probe(struct i2c_client *client)
>  {
>  	struct apds990x_chip *chip;
> +	struct iio_dev *indio_dev;
>  	int err;
>  
> -	chip = kzalloc(sizeof *chip, GFP_KERNEL);
> -	if (!chip)
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	indio_dev->info = &apds990x_info;
> +	indio_dev->name = "apds990x";

No wild cards in this.  Ideally it should be the name of the actual part
used but if not, choose one supported part.

> +	indio_dev->channels = apds990x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(apds990x_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	chip = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, chip);
>  	chip->client  = client;
>  
> @@ -1140,17 +1170,17 @@ static int apds990x_probe(struct i2c_client *client)
>  	chip->regs[0].supply = reg_vcc;
>  	chip->regs[1].supply = reg_vled;
>  
> -	err = regulator_bulk_get(&client->dev,
> -				 ARRAY_SIZE(chip->regs), chip->regs);
> +	err = devm_regulator_bulk_get(&client->dev,
> +				      ARRAY_SIZE(chip->regs), chip->regs);

Unrelated to converting the driver to IIO. Please pull out as a precursort
patch.

>  	if (err < 0) {
>  		dev_err(&client->dev, "Cannot get regulators\n");
> -		goto fail1;
> +		return err;
>  	}
>  
>  	err = regulator_bulk_enable(ARRAY_SIZE(chip->regs), chip->regs);
>  	if (err < 0) {
>  		dev_err(&client->dev, "Cannot enable regulators\n");
> -		goto fail2;
> +		return err;
>  	}
>  
>  	usleep_range(APDS_STARTUP_DELAY, 2 * APDS_STARTUP_DELAY);
> @@ -1158,7 +1188,7 @@ static int apds990x_probe(struct i2c_client *client)
>  	err = apds990x_detect(chip);
>  	if (err < 0) {
>  		dev_err(&client->dev, "APDS990X not found\n");
> -		goto fail3;
> +		return err;
>  	}
>  
>  	pm_runtime_set_active(&client->dev);
> @@ -1173,39 +1203,29 @@ static int apds990x_probe(struct i2c_client *client)
>  		err = chip->pdata->setup_resources();
>  		if (err) {
>  			err = -EINVAL;
> -			goto fail3;
> +			goto fail;
>  		}
>  	}
>  
> -	err = sysfs_create_group(&chip->client->dev.kobj,
> -				apds990x_attribute_group);
> -	if (err < 0) {
> -		dev_err(&chip->client->dev, "Sysfs registration failed\n");
> -		goto fail4;
> -	}
> -
> -	err = request_threaded_irq(client->irq, NULL,
> -				apds990x_irq,
> -				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -				"apds990x", chip);
> +	err = devm_request_threaded_irq(&client->dev, client->irq,
> +					NULL, apds990x_irq,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"apds990x", indio_dev);
>  	if (err) {
>  		dev_err(&client->dev, "could not get IRQ %d\n",
>  			client->irq);
> -		goto fail5;
> +		goto fail;
>  	}
> -	return err;
> -fail5:
> -	sysfs_remove_group(&chip->client->dev.kobj,
> -			&apds990x_attribute_group[0]);
> -fail4:
> +
> +	err = iio_device_register(indio_dev);
Mix and match of devm_ and normally error handling / unregister paths
is a bad idea as it is hard to reason about as the remove() order
is scrambled compared to probe().  We have devm_add_action_or_reset()
to help with that by ensuring everything occurs in the 'obvious'
unwind order which is reverse of the order used to set things up.

I'm sure I missed a lot in reading this patch, so as mentioned for patch 4
please include the full code.  You can ask git not to detect renames
for v2 and that will mean we can see all the code easily and help
with review.  If not, just pasting the code in to a reply is fine
too.

Thanks,

Jonathan
 
> +	if (err)
> +		goto fail;
> +
> +	return 0;
> +fail:
>  	if (chip->pdata && chip->pdata->release_resources)
>  		chip->pdata->release_resources();
> -fail3:
> -	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
> -fail2:
> -	regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
> -fail1:
> -	kfree(chip);
> +
>  	return err;
>  }
>  
> @@ -1213,10 +1233,6 @@ static void apds990x_remove(struct i2c_client *client)
>  {
>  	struct apds990x_chip *chip = i2c_get_clientdata(client);
>  
> -	free_irq(client->irq, chip);
> -	sysfs_remove_group(&chip->client->dev.kobj,
> -			apds990x_attribute_group);
> -
>  	if (chip->pdata && chip->pdata->release_resources)
>  		chip->pdata->release_resources();
>  
> @@ -1225,10 +1241,6 @@ static void apds990x_remove(struct i2c_client *client)
>  
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
> -
> -	regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
> -
> -	kfree(chip);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP

