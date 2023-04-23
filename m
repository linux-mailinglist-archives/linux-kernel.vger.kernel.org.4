Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73B6EBE7D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDWKPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7375AE53;
        Sun, 23 Apr 2023 03:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E9AD60C41;
        Sun, 23 Apr 2023 10:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4273C433EF;
        Sun, 23 Apr 2023 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682244897;
        bh=ZuH3EUv2dci44DmCKqUsBkIZwLpp/6zLtgJfCy3oIe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8tCryPSjV8aBnFhce979cvRNCQoF1Z8qGzB4fUnltzmeh3XUGhpFYmVg4oO6ADno
         ToUR8NwVDViSdQSUcC1czj0q5mmjfa9oMwKCeiIQ4dmapRWGTzdSysr9Z4++YXgfo7
         u4d6VtrBVMJ7mcYBkeOylu93dONc3CBlIN9mk9c8Nj51OFJDfMBKPyF6DHXLlFK2Ly
         lcd4Lcw63+2+haBo3sqjAkscNmWBdvsKAFqdDeNlZalslCMMpVEQZPRBUke6/B5RmW
         IVjACyKYAmd4lL4ZH+Iw+T4P5Ed9yp/NXzL14VdcjxVMJo4ERshwvpfDuEiyKLN2h4
         1aPQeG7VSQ0rA==
Date:   Sun, 23 Apr 2023 11:30:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <20230423113033.7d1e2fd4@jic23-huawei>
In-Reply-To: <ZEGZ7VMrqaPNzhwj@arbad>
References: <ZEGZYiS0znC2/fZC@arbad>
        <ZEGZ7VMrqaPNzhwj@arbad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 22:00:45 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Honeywell mprls0025pa is a series of pressure sensors.
> 
> Add initial I2C support.
> 
> Note:
> - Buffered mode is supported

Maybe clarify this comment more.  You support IIO buffered modes for
example, so I'm not immediately sure what this refers to.


> - SPI mode is not supported
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Various other comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/Kconfig       |  12 +
>  drivers/iio/pressure/Makefile      |   1 +
>  drivers/iio/pressure/mprls0025pa.c | 429 +++++++++++++++++++++++++++++
>  3 files changed, 442 insertions(+)
>  create mode 100644 drivers/iio/pressure/mprls0025pa.c
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index c9453389e4f7..c51e53bd54bc 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -148,6 +148,18 @@ config MPL3115
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mpl3115.
>  
> +config MPRLS0025PA
> +	tristate "Honeywell MPRLS0025PA (MicroPressure sensors series)"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the Honeywell MicroPressure pressure sensor series.
> +	  There are many different types with different pressure range. These ranges can be set up
> +	  in the device tree.
> +
> +	  To compile this driver as a module, choose M here: the module will be called mpr.

Doesn't look like the module will have that name any more.

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
> index 000000000000..3d82f6790e6d
> --- /dev/null
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MPR - MicroPressure pressure sensor series driver
> + *
> + * Copyright (c) Andreas Klinger <ak@it-klinger.de>
> + *
> + * Data sheet:
> + *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
> + *    pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
> + *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> + *
> + * 7-bit I2C default slave address: 0x18
> + */
> +
> +#include <linux/property.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/math64.h>

Trivial, but good to keep the includes in alphabetical order.

> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
>
> +struct mpr_data {
> +	struct i2c_client	*client;
> +	struct mutex		lock;		/* i2c transactions */
> +	u32			pmin;		/* minimal pressure in pascal */
> +	u32			pmax;		/* maximal pressure in pascal */
> +	u32			function;	/* transfer function */
> +	u32			outmin;		/* minimal numerical range raw value from sensor */
> +	u32			outmax;		/* maximal numerical range raw value from sensor */
> +	int                     scale;          /* int part of scale */
> +	int                     scale2;         /* nano part of scale */
> +	int                     offset;         /* int part of offset */
> +	int                     offset2;        /* nano part of offset */
> +	struct gpio_desc	*gpiod_reset;	/* reset */
> +	int			irq;		/* end of conversion interrupt */
> +	struct completion	completion;	/* handshake from irq to read */
> +	struct mpr_chan		chan;		/* channel values for buffered mode */
> +	struct regulator	*vdd;		/* optional external voltage regulator */

It's unusual for something called vdd to be optional... see later.

> +};

> +/**
> + * mpr_read_pressure() - Read pressure value from sensor via I2C
> + * @data: Pointer to private data struct.
> + * @press: Output value read from sensor.
> + *
> + * Reading from the sensor by sending and receiving I2C telegrams.
> + *
> + * If there is an end of conversion (EOC) interrupt registered the function waits for a maximum of
> + * one second for the interrupt.
> + *
> + * Context: The function can sleep and data->lock should be held when calling it.
> + * Return:
> + * * 0		- OK, the pressure value could be read
> + * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is still set after nloops

Very long lines.  Keep to 80 chars unless there is a strong readability reason to go up to < 100 chars.
Over that requires a very very strong reason (rarely done)

> + *		  attempts of reading
> + */

...

> +static int mpr_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan, int *val,
> +									int *val2, long mask)
> +{
> +	int ret;
> +	s32 pressure;
> +	struct mpr_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_PRESSURE)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = mpr_read_pressure(data, &pressure);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +		*val = pressure;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = data->scale;
> +		*val2 = data->scale2;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = data->offset;
> +		*val2 = data->offset2;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +

You can't get here so drop this.

> +	return -EINVAL;
> +}

> +
> +static int mpr_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct mpr_data *data;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;
> +	s64 scale, offset;
> +
> +	dev_dbg(dev, "client: %s id: %s\n", client->name, id->name);

Unlikely to be much use after initial driver development. drop it.

> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
> +		return dev_err_probe(dev, -EOPNOTSUPP, "I2C functionality not supported\n");

...

> +
> +	data->vdd = devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(data->vdd)) {
> +		dev_dbg(dev, "can't get vdd supply err: %pe\n", data->vdd);

This seems unusual.  Is VDD really optional, or are you trying to handle it
simply being always on or not provided by firmware? If the second case rely
on the stub regulators you'll get from
devm_regulator_get_enabled(dev, "vdd") to deal with that for you.

That should work however the driver was probed (I think anyway!)

> +		data->vdd = NULL;
> +	} else {
> +		ret = regulator_enable(data->vdd);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "can't enable vdd supply\n");
> +		ret = devm_add_action_or_reset(dev, mpr_vdd_disable, data->vdd);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "can't add vdd disable action\n");
> +	}
> +
> +	if (dev_fwnode(dev)) {
> +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal", &data->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "honeywell,pmin-pascal missing in DT\n");

Don't mention DT. Could be another type of firmware.  Also might not be missing, but instead
wrongly formatted.

"honeywell,pmin-pascal could not be read." perhaps?
similar for the others.


> +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal", &data->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "honeywell,pmax-pascal missing in DT\n");
> +		ret = device_property_read_u32(dev, "honeywell,transfer-function", &data->function);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +						"honeywell,transfer-function missing in DT\n");
> +		if (data->function > MPR_FUNCTION_C)
> +			return dev_err_probe(dev, -EINVAL,
> +				"honeywell,transfer-function %d not supported\n", data->function);
> +
> +		if (data->irq > 0) {

This doesn't need to be in the dev_fwnode() protection. I'd move it out of here.

> +			ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> +							IRQF_TRIGGER_RISING, client->name, data);
> +			if (ret)
> +				return dev_err_probe(dev, ret, "request irq %d failed\n",
> +										data->irq);
> +		}
> +	} else {
> +		/* when loaded as i2c device we need to use default values */
> +		dev_notice(dev, "no dt node found; using defaults\n");
> +		data->pmin = 0;
> +		data->pmax = 172369; /* 25 psi */
> +		data->function = MPR_FUNCTION_A;
> +	}
> +
> +	data->outmin = mpr_func_spec[data->function].output_min;
> +	data->outmax = mpr_func_spec[data->function].output_max;
> +
> +	scale = div_s64(((s64)(data->pmax - data->pmin)) * MPR_NANO_PART,
> +								data->outmax - data->outmin);
> +	data->scale = div_s64(scale, MPR_NANO_PART);
> +	data->scale2 = scale - data->scale * MPR_NANO_PART;
> +
> +	offset = ((-1LL) * (s64)data->outmin) * MPR_NANO_PART -
> +			div_s64(div_s64((s64)data->pmin * MPR_NANO_PART, scale), MPR_NANO_PART);
> +	data->offset = div_s64(offset, MPR_NANO_PART);
> +	data->offset2 = offset - data->offset * MPR_NANO_PART;
> +
> +	data->gpiod_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->gpiod_reset)) {
If devm_gpiod_get_optional() returns an error that doesn't mean the gpio wasn't found,
but rather that it didn't work for some reason.

If that happens you should error out and fail the probe.  Something is broken and
carrying on papers over that which is rarely a good idea.

The not wired case is handled fine by data->gpiod_reset being set to NULL anyway.

> +		dev_dbg(dev, "didn't get reset-gpios: err=%pe\n", data->gpiod_reset);
> +		data->gpiod_reset = NULL;
> +	}

