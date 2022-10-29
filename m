Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF2612403
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ2OwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ2OwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E096178B9;
        Sat, 29 Oct 2022 07:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0CE860AE5;
        Sat, 29 Oct 2022 14:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F7C433C1;
        Sat, 29 Oct 2022 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667055119;
        bh=Pn7IIZXFkinUahUFKZD/aEPc20VbwQM7r+xySpZPQD4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gF5pXnSnkoq1/zs2woqbPYNNalla/t26Ec8otWenL2hdJQ5dCQr7smc3p+b3rpbgD
         X+Aog1VueVBjkQLnRgxdu7+938877tq5p5AbGVpH9DPMBKthAN43VCXihBRrPYuv6C
         Odoqe2EJbxrRrSQ3ZTQA/tefgqd0UAV7sdCwnSekx7XWGA16e/RTJ6m8DKSUXJ2h3p
         3410qkQvafjMNOdfBXt9ZCi0JpXv2lmL9IcLzoff/zTv1VeTjYoBge98C/NWycqL1F
         TwXz9Gll7vRduWkSS6woBWWS3k78Z9Gnl9S1nErK2lG5XtfSn0G45irP/w6aw5qoUT
         QQHw2H4VmrAOA==
Date:   Sat, 29 Oct 2022 16:03:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v6] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221029160353.3999849b@jic23-huawei>
In-Reply-To: <20221025171858.225242-1-rajat.khandelwal@linux.intel.com>
References: <20221025171858.225242-1-rajat.khandelwal@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 22:48:58 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Maxim MAX30208 is a digital temperature sensor with 0.1=C2=B0C accuracy.
>=20
> Add support for max30208 driver in iio subsystem.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Hi Rajat,

Consider using regmap for this. It will provide you with some helpful
utility functions.  I don't mind you sticking to direct i2c calls though
if you prefer.

Quite a few things inline that have been commented on in previous reviews.
Make sure you incorporate all feedback or you'll end up going through more
versions than would otherwise be necessary.

Jonathan

> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/M=
akefile
> index dd08e562ffe0..dfec8c6d3019 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) +=3D iqs620at-temp.o
>  obj-$(CONFIG_LTC2983) +=3D ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
> +obj-$(CONFIG_MAX30208) +=3D max30208.o
>  obj-$(CONFIG_MAX31856) +=3D max31856.o
>  obj-$(CONFIG_MAX31865) +=3D max31865.o
>  obj-$(CONFIG_MLX90614) +=3D mlx90614.o
> diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature=
/max30208.c
> new file mode 100644
> index 000000000000..41b26755ce27
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> + *
> + * Maxim MAX30208 digital temperature sensor with 0.1=C2=B0C accuracy
> + * (7-bit I2C slave address (0x50 - 0x53))
> + *
> + * Note: This driver sets GPIO1 to behave as input for temperature
> + * conversion and GPIO0 to act as interrupt for temperature conversion.

It doesn't use them, so unless you have to be in that state to use the curr=
ent
method, drop the note and don't set them to do that.

You can add that support if / when the driver supports it.

> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +#define MAX30208_DRV_NAME		"max30208"

Mentioned below, but I'd prefer to see the string directly inline.

> +
> +#define MAX30208_STATUS			0x00
> +#define MAX30208_STATUS_TEMP_RDY	BIT(0)
> +#define MAX30208_INT_ENABLE		0x01
> +#define MAX30208_INT_ENABLE_TEMP_RDY	BIT(0)
> +
> +#define MAX30208_FIFO_OVF_CNTR		0x06
> +#define MAX30208_FIFO_DATA_CNTR		0x07
> +#define MAX30208_FIFO_DATA		0x08
> +
> +#define MAX30208_SYSTEM_CTRL		0x0c
> +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> +
> +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> +
> +#define MAX30208_GPIO_SETUP		0x20
> +#define MAX30208_GPIO1_SETUP		GENMASK(7, 6)
> +#define MAX30208_GPIO0_SETUP		GENMASK(1, 0)
> +#define MAX30208_GPIO_CTRL		0x21
> +#define MAX30208_GPIO1_CTRL		BIT(3)
> +#define MAX30208_GPIO0_CTRL		BIT(0)
> +
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock; /* Lock to prevent concurrent reads */

Be more explicit - reads of what?

> +};
> +
> +static const struct iio_chan_spec max30208_channels[] =3D {
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCA=
LE),
> +	},
> +};
> +
> +/**
> + * max30208_request() - Request a reading
> + * @data: Struct comprising member elements of the device
> + *
> + * Requests a reading from the device and waits until the conversion is =
ready.
> + */
> +static int max30208_request(struct max30208_data *data)
> +{
> +	/*
> +	 * Sensor can take up to 500 ms to respond so execute a total of
> +	 * 10 retries to give the device sufficient time.
> +	 */
> +	int retries =3D 10;
> +	u8 regval;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SET=
UP);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg temperature setup\n");

I agree with Guenter's comment that this is a bit overly noisy. We don't ex=
pect
random register reads to fail + IIRC there is tracing in the i2c subsystem =
if we
are getting such errors.   Hence probably reduce the error to cover only la=
rger
blocks of code.  Reasonable to report that the temperature request failed p=
erhaps.


> +		return ret;
> +	}
> +
> +	regval =3D ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SE=
TUP, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg temperature setup\n");
> +		return ret;
> +	}
> +
> +	while (retries--) {
> +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg status\n");
> +			goto sleep;

Can this happen for a documented reason?  If not treat it as a comms error =
and
return it.

> +		}
> +
> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> +			return 0;
> +
> +		msleep(50);
> +	}
> +	dev_warn(&data->client->dev, "Temperature conversion failed\n");

dev_err()  Failing isn't expected so it's a device error not something
we should merely warn about.

> +
> +	return 0;
Error return to indicate what happened - there is one for timeouts.

> +
> +sleep:

Why sleep in an error path?  It's failed - why do we think sleeping is a go=
od idea?

> +	msleep(50);
> +	return 0;
> +}
> +
> +static int max30208_update_temp(struct max30208_data *data)
> +{
> +	u8 data_count;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D max30208_request(data);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
Whilst you debated this logic with Guenter in v5, I don't follow the conclu=
sion.
If FIFO_OVF_CNTR > 0 then FIFO_DATA_CNTR =3D=3D maximum value.  Logic of th=
is is
given in FIFO_DATA Read Example (Page 16 of the spec)  It doesn't matter as=
 such
because you read FIFO_DATA_CNTR again anyway, but it would be more obvious =
what
is going on if you just set data_count =3D 32 if overflow has occured.

The only thing I would argue you 'might' want to do with the overflow count=
er
is to use it to indicate we need to read at least the number of elements in=
 the fifo.
If there are no additional elements at the end, wait until there is one. Ot=
herwise
you potentially get very stale data - it might have been overflowing for a =
long time)

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n=
");
> +		goto unlock;
> +	} else if (!ret) {
> +		ret =3D i2c_smbus_read_byte_data(data->client,
> +					       MAX30208_FIFO_DATA_CNTR);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +			goto unlock;
> +		}
> +	}
> +
> +	data_count =3D ret;
> +
> +	/*
> +	 * Ideally, counter should decrease by 1 each time a word is read from =
FIFO.
> +	 * However, practically, the device behaves erroneously and counter som=
etimes
> +	 * decreases by more than 1. Hence, do not loop the counter until it be=
comes 0
> +	 * rather, use the exact counter value after each FIFO word is read.

This decrease by more than 1 is worrying.  I can understand it not decreasi=
ng, or even
increasing (new data came in), but this condition sounds either like we are=
 doing something
wrong or there is a hardware bug.

> +	 * Return the last reading from FIFO as the most recently triggered one

Not necessarily recent (even if most recent available). Imagine this runs a=
fter overflow and runs really quickly.
You may not get a new reading.

> +	 */
> +	while (data_count) {
> +		ret =3D i2c_smbus_read_word_swapped(data->client,
> +						  MAX30208_FIFO_DATA);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
> +			goto unlock;
> +		}
> +
> +		data_count =3D i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);
> +		if (data_count < 0) {
> +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
> +			ret =3D data_count;

Flip this around so you consistently use ret for return values.  We still h=
ave problem
that data_count is a u8 so the above test is invalid.

		ret =3D i2c_smbus_read_byte_data(data->client, ...)
		if (ret < 0) {
			dev_err(..);
			goto unlock
		}
		data_count =3D ret;

Guenter pointed this out in v5.

> +			goto unlock;
> +		}
> +	}
> +
> +unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static int max30208_read(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int *val, int *val2, long mask)
> +{
> +	struct max30208_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D max30208_update_temp(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D sign_extend32(ret, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 5;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30208_gpio_setup(struct max30208_data *data)
> +{
> +	u8 regval;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_GPIO_SETUP);

Excessive line breaks.  This is under 80 chars.  In cases where
readability is helped by going above that (though under 100 chars) that
is fine too.  Make sure you tidy up all similar cases.

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg GPIO setup\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Setting GPIO1 to trigger temperature conversion
> +	 * when driven low.
> +	 * Setting GPIO0 to trigger interrupt when temperature
> +	 * conversion gets completed.
> +	 */
> +	regval =3D ret | MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;

If the driver 'works' in current form without setting this stuff up I would
prefer that you leave this until you have a patch actually using the GPIO s=
ignals.
That way we can review all the GPIO related code together.

> +	ret =3D i2c_smbus_write_byte_data(data->client,
> +					MAX30208_GPIO_SETUP, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg GPIO setup\n");
> +		return ret;
> +	}
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_INT_ENABLE);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg interrupt enable\n");
> +		return ret;
> +	}
> +
> +	/* Enabling GPIO0 interrupt */
> +	regval =3D ret | MAX30208_INT_ENABLE_TEMP_RDY;

This belongs in a patch adding interrupt support. It should not be here unt=
il then.

> +	ret =3D i2c_smbus_write_byte_data(data->client,
> +					MAX30208_INT_ENABLE, regval);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg interrupt enable\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info max30208_info =3D {
> +	.read_raw =3D max30208_read,
> +};
> +
> +static int max30208_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev =3D &i2c->dev;
> +	struct max30208_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->client =3D i2c;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name =3D MAX30208_DRV_NAME;

I'm not a huge fan of defines either here or in the driver structure initia=
lizer.
The reason being that we need clear visibility of these strings and there i=
s no
particular reason why they are the same.
So I'd prefer getting rid of that define and putting the strings directly i=
n both
locations.

> +	indio_dev->channels =3D max30208_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(max30208_channels);
> +	indio_dev->info =3D &max30208_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	/* Reset the device initially */

The expressive nature of the field define makes it obvious this is a reset.
so I would drop the comment.  There is a price in maintainability to commen=
ts
(they often become wrong over time as a driver evolves).  As such keep them
for places where the comment tells us something not easily seen from the co=
de.

> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> +					MAX30208_SYSTEM_CTRL_RESET);
> +	if (ret) {
> +		dev_err(dev, "Failure in performing reset\n");
> +		return ret;
> +	}
> +
> +	msleep(50);
> +
> +	ret =3D max30208_gpio_setup(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max30208_id_table[] =3D {
> +	{ "max30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> +
> +static const struct acpi_device_id max30208_acpi_match[] =3D {
> +	{ "MAX30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
> +
> +static const struct of_device_id max30208_of_match[] =3D {
> +	{ .compatible =3D "maxim,max30208" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max30208_of_match);
> +
> +static struct i2c_driver max30208_driver =3D {
> +	.driver =3D {
> +		.name =3D MAX30208_DRV_NAME,
> +		.of_match_table =3D max30208_of_match,
> +		.acpi_match_table =3D ACPI_PTR(max30208_acpi_match),

Try building without ACPI support and you should see a warning from
the compiler.  Sadly ACPI_PTR() is not as smart as it should be.
If interested, take a look at how pm_ptr() deals with the same issue.

Anyhow, best option is just don't bother with ACPI_PTR().
The saving in module size is trivial and not worth the ifdef magic needed
to make it work warning free.


> +	},
> +	.probe_new =3D max30208_probe,
> +	.id_table =3D max30208_id_table,
> +};
> +
> +static int __init max30208_init(void)
> +{
> +	return i2c_add_driver(&max30208_driver);
> +}
> +module_init(max30208_init);
> +
> +static void __exit max30208_exit(void)
> +{
> +	i2c_del_driver(&max30208_driver);
> +}
> +module_exit(max30208_exit);

module_i2c_driver() to get rid of this boilerplate.

Note this was a comment I made on v1... I wondered if I'd been half asleep =
so went
looking :)

Jonathan

