Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF860929A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJWMTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWMTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA872B44;
        Sun, 23 Oct 2022 05:18:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0435F60BA8;
        Sun, 23 Oct 2022 12:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE27C433D6;
        Sun, 23 Oct 2022 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666527538;
        bh=BCaXlrWWNNEGZ9fwoLcJAI8X/+YE5exZgV8DfGINEqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=an97nYnOMsvIy9PHliv7QutFO8tVDwn5IMtXJO3Mq4MNLIsenLx69ylyThAM3W89s
         CpOjmJ3bGqv1P+OrcuBQu7yyJcZzjRiDdSKMGhay0sbj6ciVXgdG9S8r6Z4kjRqGrs
         iLMZFMag7r0H6zYJ5yrGadVdKNps+rVPfh1nClIQ18nMHYDGCLoSVMf3CywTETlkjc
         IuJ0mOGl2CjlHkJP95XkuE1gpTRS8dvQ51jvoj3xFUMCaE0WzhckYI0hrOrtAOBRjv
         QsbcsY79JkfJ/l5F9wCS3k3CFxojdGtF4GC0vkFHRfCZ+1rYBzbqBdSn5/qDkevJRY
         N1ee4XoWuYcoQ==
Date:   Sun, 23 Oct 2022 13:19:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v4] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221023131933.57966858@jic23-huawei>
In-Reply-To: <20221020172218.804068-1-rajat.khandelwal@linux.intel.com>
References: <20221020172218.804068-1-rajat.khandelwal@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 20 Oct 2022 22:52:18 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Maxim MAX30208 is a digital temperature sensor with 0.1=C2=B0C accuracy.
>=20
> Add support for max30208 driver in iio subsystem.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Hi Rajat, review on basis that v5 will be cc'd to=20
HARDWARE MONITORING
M:	Jean Delvare <jdelvare@suse.com>
M:	Guenter Roeck <linux@roeck-us.net>
L:	linux-hwmon@vger.kernel.org

with the open question on whether they consider it acceptable for this driv=
er
to be in IIO. Main argument in favour is it's an expensive clinical grade s=
ensor
so fairly unlikely to be used in classic hardware monitoring circumstances.

Anyhow a few comments inline.

Thanks,

Jonathan


> ---
>=20
> v4: Version comments go below line separator of signed-off-by
>=20
> v3: Release the mutex lock after error gets returned
>=20
> v2:
> 1. Removed TODO
> 2. Removed unnecessary blank spaces
> 3. Corrected MC->MILLICELCIUS
> 4. Comments added wherever required
> 5. dev_err on i2c fails
> 6. Rearranged some flows
> 7. Removed PROCESSED
> 8. int error return on gpio setup
> 9. device_register at the end of probe
> 10. Return on unsuccessful reset
> 11. acpi_match_table and of_match_table added
> 12. Minor quirks
>=20
> module_i2c_driver() can't be added since module_init and module_exit
> are added explicitly.
>=20
>  MAINTAINERS                        |   6 +
>  drivers/iio/temperature/Kconfig    |  10 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30208.c | 322 +++++++++++++++++++++++++++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 drivers/iio/temperature/max30208.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1390b8270b2..7f1fd2e31b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12373,6 +12373,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
>  F:	drivers/regulator/max20086-regulator.c
> =20
> +MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> +M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/temperature/max30208.c
> +
>  MAXIM MAX77650 PMIC MFD DRIVER
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kc=
onfig
> index e8ed849e3b76..ed384f33e0c7 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -128,6 +128,16 @@ config TSYS02D
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys02d.
> =20
> +config MAX30208
> +	tristate "Maxim MAX30208 digital temperature sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Maxim MAX30208
> +	  digital temperature sensor connected via I2C.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called max30208.
> +
>  config MAX31856
>  	tristate "MAX31856 thermocouple sensor"
>  	depends on SPI
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
> index 000000000000..35a778ea9395
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,322 @@
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
> +#define MAX30208_RES_MILLICELCIUS	5
> +
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock; /* Lock to prevent concurrent reads */
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
> +	int retries =3D 10; /*
> +			   * Sensor can take up to 500 ms to respond so execute a
> +			   * total of 10 retries to give the device sufficient time.
> +			   */

Move the comment to the line above int retries.  Will be more readable ther=
e and still
clear what it refers to.

> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SET=
UP);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg temperature setup\n");
> +		return ret;
> +	}
> +
> +	ret |=3D MAX30208_TEMP_SENSOR_SETUP_CONV;
As below, I'd suggest a local u8 variable for building up register values.
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SE=
TUP, ret);
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
> +		}
> +
> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> +			return 0;
> +
> +		msleep(50);
> +	}
> +	dev_warn(&data->client->dev, "Temperature conversion failed\n");
> +
> +	return 0;
> +
> +sleep:
> +	usleep_range(50000, 60000);
> +	return 0;
> +}
> +
> +static int max30208_update_temp(struct max30208_data *data)
> +{
> +	s8 data_count;

It's signed?  That's unusual for a counter...  looking quickly at datasheet
looks like it's actually a 5 bit unsigned counter so this won't matter.
Probably better to use a u8 though to avoid any confusion.


> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D max30208_request(data);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
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
> +	 * decreases by more than 1.

This is a very odd hardware bug.  Any public errata reference or similar we=
 can add
here for anyone wanting more information?

>          Hence, do not loop the counter until it becomes 0
> +	 * rather, use the exact counter value after each FIFO word is read.
> +	 * Return the last reading from FIFO as the most recently triggered one.
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
> +		*val =3D MAX30208_RES_MILLICELCIUS;

Given this define is only used in one place + isn't a magic value (it is th=
e actual
resolution!) I'd prefer to see the number directly here.

> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max30208_gpio_setup(struct max30208_data *data)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_GPIO_SETUP);
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
> +	ret |=3D MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
It is cleaner to use a local u8 variable to build up the register value rat=
her than
using the integer that is returned directly.=20

	u8 regval;

	regval =3D=20
	regval =3D ret | ....

	... write_byte_data(..., regval);

etc as it keeps the types involved clean and makes it clear to a compiler t=
hat
we are deliberately truncating the return value etc.


> +	ret =3D i2c_smbus_write_byte_data(data->client,
> +					MAX30208_GPIO_SETUP, ret);
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
> +	ret |=3D MAX30208_INT_ENABLE_TEMP_RDY;
> +	ret =3D i2c_smbus_write_byte_data(data->client,
> +					MAX30208_INT_ENABLE, ret);
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
> +	indio_dev->channels =3D max30208_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(max30208_channels);
> +	indio_dev->info =3D &max30208_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	/* Reset the device initially */
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> +					MAX30208_SYSTEM_CTRL_RESET);
> +	if (ret) {
> +		dev_err(dev, "Failure in performing reset\n");
> +		return ret;
> +	}
> +
> +	usleep_range(50000, 60000);
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
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> +
> +static const struct acpi_device_id max30208_acpi_match[] =3D {
> +	{ "MAX30208" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
> +
> +static const struct of_device_id max30208_of_match[] =3D {
> +	{ .compatible =3D "maxim,max30208" },
> +	{ },

No need for comma on 'NULL' terminators.  We won't ever add another entry
after then so it is good to make it harder to do that acccidentally.
	{ }
};

> +};
> +MODULE_DEVICE_TABLE(of, max30208_of_match);
> +
> +static struct i2c_driver max30208_driver =3D {
> +	.driver =3D {
> +		.name =3D MAX30208_DRV_NAME,
> +		.of_match_table =3D max30208_of_match,
> +		.acpi_match_table =3D ACPI_PTR(max30208_acpi_match),

As per the build warning, don't bother with ACPI_PTR().
It saves a tiny bit on the size of the driver, but at the cost of needing
to use ifdef or __maybe_unused.  Now if someone made that work in a similar
fashion to pm_ptr() that doesn't suffer this problem then I'd be happier se=
eing
it in drivers.=20

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
> +
> +MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
> +MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");
> +MODULE_LICENSE("GPL");

