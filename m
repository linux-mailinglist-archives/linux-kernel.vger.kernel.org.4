Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664AE6F92DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjEFPsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEFPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308A9E;
        Sat,  6 May 2023 08:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E53B160E8E;
        Sat,  6 May 2023 15:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CFC433D2;
        Sat,  6 May 2023 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683388107;
        bh=d0Et/CWk1WaMjcu0xg8g1bDxiLSxcPrM5uAHf6MjFRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JxMxGxQRsI1YnywfacZqAiq5cThzDVQg32E3KvjSQy0Jkt7CJqWqck+t5QBtDgIMT
         4fttRf25JKd7/ST/2xLkIsEZjJEQ0toRa/Xvvbepwkv8iM2IZVxp67UhlHiuO/f9FY
         GCGv+XzyXFMe+ximjI7BX6wPLQ7ahVbxkOw8rWXaERR4IdztUfniXb3N9haqU2k3Hj
         3V66bxn69a1PQcazdOWXwOvrijWl70RAGH7WsDcBx1TpfnzhVPZeGotUjrmj3YGh1F
         CbK0OwGMP+JyW9d6eZ6m9WYVKdgp2/mly7JQckC26E7XnHt+HZGWn/TVagxQ/Dz2Wj
         3MaBYm2mACcjA==
Date:   Sat, 6 May 2023 17:04:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <20230506170420.71bead77@jic23-huawei>
In-Reply-To: <ZFUC/3zBFQRBsYUk@arbad>
References: <ZFUCf059+PSR+3Wb@arbad>
        <ZFUC/3zBFQRBsYUk@arbad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 15:22:07 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Honeywell mprls0025pa is a series of pressure sensors.
> 
> Add initial I2C support.
> 
> Note:
> - IIO buffered mode is supported
> - SPI mode is not supported
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hi Andreas,

A few maths related questions inline + a few other bits noticed
on a fresh read through.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/Kconfig       |  13 +
>  drivers/iio/pressure/Makefile      |   1 +
>  drivers/iio/pressure/mprls0025pa.c | 441 +++++++++++++++++++++++++++++
>  3 files changed, 455 insertions(+)
>  create mode 100644 drivers/iio/pressure/mprls0025pa.c
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index c9453389e4f7..43aef35ce778 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -148,6 +148,19 @@ config MPL3115
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mpl3115.
>  
> +config MPRLS0025PA
> +	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the Honeywell MicroPressure pressure
> +	  sensor series. There are many different types with different pressure
> +	  range. These ranges can be set up in the device tree.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called mprls0025pa.
> +
>  config MS5611
>  	tristate "Measurement Specialties MS5611 pressure sensor driver"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 083ae87ff48f..c90f77210e94 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_MPL115) += mpl115.o
>  obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
>  obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
>  obj-$(CONFIG_MPL3115) += mpl3115.o
> +obj-$(CONFIG_MPRLS0025PA) += mprls0025pa.o
>  obj-$(CONFIG_MS5611) += ms5611_core.o
>  obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
>  obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> new file mode 100644
> index 000000000000..7a8736de6e87
> --- /dev/null
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -0,0 +1,441 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MPRLS0025PA - Honeywell MicroPressure pressure sensor series driver
> + *
> + * Copyright (c) Andreas Klinger <ak@it-klinger.de>
> + *
> + * Data sheet:
> + *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/
> + *    products/sensors/pressure-sensors/board-mount-pressure-sensors/
> + *    micropressure-mpr-series/documents/
> + *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> + *
> + * 7-bit I2C default slave address: 0x18
> + */
> +
> +#include <asm/unaligned.h>
Common convention is put the asm stuff after the linux includes as it's
more specific. 

Often you get:

General includes

Subsystem specific includes

asm includes

> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +/* bits in i2c status byte */
> +#define MPR_I2C_POWER	BIT(6)	/* device is powered */
> +#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
> +#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
> +#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
> +
> +#define MPR_NANO_PART	1000000000LL

NANO from units.h instead of this?

> +
> +/*
> + * _INPUT interface:

Why _INPUT?  I kind of get what you mean, but I'd just call it sysfs
interface and talk about the units the value ends up in rather than
referring to a different sysfs interface the driver correctly isn't
supplying to userspace.

> + * Calculation formular from the datasheet:
> + * pressure = (press_cnt - outputmin) * scale + pmin
> + * with:
> + * * pressure	- measured pressure in Pascal
> + * * press_cnt	- raw value read from sensor
> + * * pmin	- minimum pressure range value of sensor (data->pmin)
> + * * pmax	- maximum pressure range value of sensor (data->pmax)
> + * * outputmin	- minimum numerical range raw value delivered by sensor
> + *							(MPR_OUT_MIN)
> + * * outputmax	- maximum numerical range raw value delivered by sensor
> + *							(MPR_OUT_MAX)
> + * * scale	- (pmax - pmin) / (outputmax - outputmin)
> + *
> + * _RAW interface:
> + * pressure = (raw + offset) * scale
> + * --> need to adjust offset for fitting into _RAW interface
> + * Values for _RAW interface:
> + * * raw	- press_cnt
> + * * scale	- (pmax - pmin) / (outputmax - outputmin)
> + * * offset	- (-1 * outputmin) - pmin / scale
> + *                note: With all sensors from the datasheet pmin = 0
> + *                which reduces the offset to (-1 * outputmin)
> + */
> +
> +/*
> + * transfer function A: 10%   to 90%   of 2^24
> + * transfer function B:  2.5% to 22.5% of 2^24
> + * transfer function C: 20%   to 80%   of 2^24
> + */
> +enum mpr_func_id {
> +	MPR_FUNCTION_A,
> +	MPR_FUNCTION_B,
> +	MPR_FUNCTION_C,
> +};
> +
> +struct mpr_func_spec {
> +	u32			output_min;
> +	u32			output_max;
> +};
> +
> +static const struct mpr_func_spec mpr_func_spec[] = {
> +	[MPR_FUNCTION_A] = {.output_min = 1677722, .output_max = 15099494},
> +	[MPR_FUNCTION_B] = {.output_min =  419430, .output_max =  3774874},
> +	[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
> +};
> +
> +struct mpr_chan {
> +	s32			pres;		/* pressure value */
> +	s64			ts;		/* timestamp */
> +};
> +
> +struct mpr_data {
> +	struct i2c_client	*client;
> +	struct mutex		lock;		/* i2c transactions */

That's a little vague.  Key bit here I think is to lock the access to the device when
waiting for an interrupt or timeout on a reading, not the transactions themselves.

> +	u32			pmin;		/* minimal pressure in pascal */
> +	u32			pmax;		/* maximal pressure in pascal */
> +	u32			function;	/* transfer function */

Why not enum mpr_func_id ?


> +	u32			outmin;		/*
> +						 * minimal numerical range raw
> +						 * value from sensor
> +						 */
> +	u32			outmax;		/*
> +						 * maximal numerical range raw
> +						 * value from sensor
> +						 */
> +	int                     scale;          /* int part of scale */
> +	int                     scale2;         /* nano part of scale */
> +	int                     offset;         /* int part of offset */
> +	int                     offset2;        /* nano part of offset */
> +	struct gpio_desc	*gpiod_reset;	/* reset */
> +	int			irq;		/* end of conversion irq */

Only needed in probe, no need for a copy in here.


> +	struct completion	completion;	/* handshake from irq to read */
> +	struct mpr_chan		chan;		/*
> +						 * channel values for buffered
> +						 * mode
> +						 */
> +};


> +/**
> + * mpr_read_pressure() - Read pressure value from sensor via I2C
> + * @data: Pointer to private data struct.
> + * @press: Output value read from sensor.
> + *
> + * Reading from the sensor by sending and receiving I2C telegrams.
> + *
> + * If there is an end of conversion (EOC) interrupt registered the function
> + * waits for a maximum of one second for the interrupt.
> + *
> + * Context: The function can sleep and data->lock should be held when calling it
> + * Return:
> + * * 0		- OK, the pressure value could be read
> + * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is
> + *		  still set after nloops attempts of reading
> + */
> +static int mpr_read_pressure(struct mpr_data *data, s32 *press)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret, i;
> +	u8 wdata[] = {0xAA, 0x00, 0x00};
> +	s32 status;
> +	int nloops = 10;
> +	u8 buf[5];
> +
> +	reinit_completion(&data->completion);
> +
> +	ret = i2c_master_send(data->client, wdata, sizeof(wdata));
> +	if (ret < 0) {
> +		dev_err(dev, "error while writing ret: %d\n", ret);
> +		return ret;
> +	}
> +	if (ret != sizeof(wdata)) {
> +		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
> +								sizeof(wdata));
> +		return -EIO;
> +	}
> +
> +	if (data->irq > 0) {
> +		ret = wait_for_completion_timeout(&data->completion, HZ);
> +		if (!ret) {
> +			dev_err(dev, "timeout while waiting for eoc irq\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		/* wait until status indicates data is ready */
> +		for (i = 0; i < nloops; i++) {
> +			/*
> +			 * datasheet only says to wait at least 5 ms for the
> +			 * data but leave the maximum response time open
> +			 * --> let's try it nloops (10) times which seems to be
> +			 *     quite long
> +			 */
> +			usleep_range(5000, 10000);
> +			status = i2c_smbus_read_byte(data->client);
> +			if (status < 0) {
> +				dev_err(dev,
> +					"error while reading, status: %d\n",
> +					status);
> +				return status;
> +			}
> +			if (!(status & MPR_I2C_BUSY))
> +				break;
> +		}
> +		if (i == nloops) {
> +			dev_err(dev, "timeout while reading\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	ret = i2c_master_recv(data->client, buf, sizeof(buf));
> +	if (ret < 0) {
> +		dev_err(dev, "error in i2c_master_recv ret: %d\n", ret);
> +		return ret;
> +	}
> +	if (ret != sizeof(buf)) {
> +		dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
> +								sizeof(buf));
> +		return -EIO;
> +	}
> +
> +	if (buf[0] & MPR_I2C_BUSY) {
> +		/*
> +		 * it should never be the case that status still indicates
> +		 * business
> +		 */
> +		dev_err(dev, "data still not ready: %08x\n", buf[0]);
> +		return -ETIMEDOUT;
> +	}
> +
> +	*press = get_unaligned_be24(&buf[1]);

Is it necessary to read the 5th byte even though it's never touched?
A quick galnce at datasheet shows no mention of that byte so I'm a little confused.

> +
> +	dev_dbg(dev, "received: %*ph cnt: %d\n", ret, buf, *press);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t mpr_eoc_handler(int irq, void *p)
> +{
> +	struct mpr_data *data = (struct mpr_data *)p;

You should never need to cast explicitly from a void * (C spec thing)
Hence I don't think that cast is necessary.

> +
> +	complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mpr_trigger_handler(int irq, void *p)
> +{
> +	int ret;
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct mpr_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	ret = mpr_read_pressure(data, &data->chan.pres);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);

Move the err label above the mutex unlock then go to that instead, allowing
you to unlock in just one place.

> +		goto err;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->chan,
> +						iio_get_time_ns(indio_dev));
> +	mutex_unlock(&data->lock);
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +


> +static int mpr_probe(struct i2c_client *client)
> +{

> +	data->outmin = mpr_func_spec[data->function].output_min;
> +	data->outmax = mpr_func_spec[data->function].output_max;
> +
> +	scale = div_s64(((s64)(data->pmax - data->pmin)) * MPR_NANO_PART,

NANO.

> +						data->outmax - data->outmin);
> +	data->scale = div_s64(scale, MPR_NANO_PART);
> +	data->scale2 = scale - data->scale * MPR_NANO_PART;

As below, I'm not seeing why div_s64_rem() isn't appropriate for this
as well as making it immediately obvious what is going on.

> +
> +	offset = ((-1LL) * (s64)data->outmin) * MPR_NANO_PART -

> +		div_s64(div_s64((s64)data->pmin * MPR_NANO_PART, scale),
> +		MPR_NANO_PART);

I'm guessing the multiply by MPR_NANO_PART then divide by it is to maintain precision?
If so I'd like a comment here explaining the logic behind it.

> +	data->offset = div_s64(offset, MPR_NANO_PART);
> +	data->offset2 = offset - data->offset * MPR_NANO_PART;

Is this a round about way of doing offset % NANO?
div_s64_rem() appropriate here?

> +
> +	if (data->irq > 0) {
> +		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> +				IRQF_TRIGGER_RISING, client->name, data);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"request irq %d failed\n", data->irq);
> +	}
> +
> +	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
> +							GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->gpiod_reset))
> +		return dev_err_probe(dev, PTR_ERR(data->gpiod_reset),
> +						"request reset-gpio failed\n");
> +
> +	mpr_reset(data);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +						mpr_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"iio triggered buffer setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"unable to register iio device\n");
> +
> +	return 0;
> +}

