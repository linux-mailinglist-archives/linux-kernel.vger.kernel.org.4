Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E403B626F51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiKMLg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:36:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0531144F;
        Sun, 13 Nov 2022 03:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0240C60B6C;
        Sun, 13 Nov 2022 11:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E6C433D6;
        Sun, 13 Nov 2022 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668339411;
        bh=mIv+g6eTsKBVSoj0R/3kDc+IjLwJ7xlD9YAUMjNayDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r08zWeT6BdD21xJAheWlUfADDRY/S0VTPDmEr0KgUh7uzLqj3x/gEGUV+ZypyHbqa
         V3eWk23iIgXRxaGig8cwkUSrFmsh9HU7KHuC3XPixCcwco8EQ3QhpWNMoOOs1G4WOf
         YvAItByqnJ99KYkx/c4JGyLjZPfog2dPqqp3zaKgdA4hGk34eP4M1NRE7wrURta2w5
         qR3tE7mVkhA1/miscpcjktLPoLK9InYMS2F8X0LYhBrdWtRZYQp0ZqnfmX6Myp/eT9
         A/TN95ERclngaQBOCR8doY+AWQQASQ2ytZd8j12pJC26WEvdPPckX8D7yaoaMlaC19
         EcC5v+Vv1pUlg==
Date:   Sun, 13 Nov 2022 11:49:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v9] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221113114905.2b2dd891@jic23-huawei>
In-Reply-To: <20221109135949.734180-1-rajat.khandelwal@linux.intel.com>
References: <20221109135949.734180-1-rajat.khandelwal@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 19:29:49 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Maxim MAX30208 is a digital temperature sensor with 0.1=C2=B0C accuracy.
>=20
> Add support for max30208 driver in iio subsystem.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Hi Rajat,

Alongside some trivial stuff I would have either fixed up when applying
or not worried about...

The overflow counter handling still looks wrong to me and doesn't follow
the pseudo code on page 16 of the data sheet:
FIFO_DATA read example.

I thought about just applying this with the change I'm suggesting, but prob=
ably
better if you test it works as expected and spin a v10.

Thanks,

Jonathan

> ---
>=20
> v9: Repositioning register data
>=20
> v8:
> 1. Returning time out if conversion fails to happen
> 2. Setting rollover bit to '1' to allow FIFO overwriting
> 3. Dropping ACPI_PTR
>=20
> v7:
> 1. Dropped GPIOs use for now
> 2. Driver name string directly used
> 3. Mutex lock description added
> 4. Removed noisy errors and only kept errors on larger code blocks
> 5. dev_warn -> dev_err for temperature conversion failure
> 6. Improvised the logic of popping out values
> 7. Fixed line breaks
> 8. module_i2c_driver
>=20
> v6: Converted usleep_range to msleep as delay is quite large
>=20
> v5:
> 1. Fixed comment position in max30208_request
> 2. Use of local u8 variable to build register values
> 3. Using u8 instead of s8 in data_count
> 4. Removed global MAX30208_RES_MILLICELCIUS
> 5. Removed 'comma' on NULL terminators
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
>  MAINTAINERS                        |   6 +
>  drivers/iio/temperature/Kconfig    |  10 ++
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30208.c | 251 +++++++++++++++++++++++++++++
>  4 files changed, 268 insertions(+)
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
> index 000000000000..102eb2b77dbe
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> + *
> + * Maxim MAX30208 digital temperature sensor with 0.1=C2=B0C accuracy
> + * (7-bit I2C slave address (0x50 - 0x53))
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
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
> +#define MAX30208_FIFO_CONFIG		0x0a
> +#define MAX30208_FIFO_CONFIG_RO		BIT(1)
> +
> +#define MAX30208_SYSTEM_CTRL		0x0c
> +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> +
> +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> +
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock; /* Lock to prevent concurrent reads of temperature r=
eadings */
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

Trivial, but perhaps better as
	@data: struct containing per device instance data.

Device can both mean the linux driver model device and the actual piece of
hardware and in this case I don't think it is clear which!
This applies to other instances of the same comment.

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
> +	if (ret < 0)
> +		return ret;
> +
> +	regval =3D ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SE=
TUP, regval);
> +	if (ret)
> +		return ret;
> +
> +	while (retries--) {
> +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (ret & MAX30208_STATUS_TEMP_RDY)
> +			return 0;
> +
> +		msleep(50);
> +	}
> +	dev_err(&data->client->dev, "Temperature conversion failed\n");
> +
> +	return -ETIMEDOUT;
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
> +	if (ret)
> +		goto unlock;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> +	if (ret < 0)
> +		goto unlock;

I'm fairly sure this still doesn't work.  If an overflow has occurred we ne=
ed to read the full
fifo.  OVF_CNTR contains the number of readings that overflowed, not the nu=
mber
we need to read.  Hence in the overflow condition it may read anything betw=
een 1 and 0x1f
depending on how much we have overflowed.

What we want data_count to be is the size of the fifo not this number.
=46rom the datasheet:

Number of samples available in the FIFO after the last read can be obtained=
 by reading the OVF_COUNTER[4:0] and
FIFO_DATA_COUNT[5:0] registers using the following pseudo-code:
read the OVF_COUNTER register
read the FIFO_DATA_COUNT register
if OVF_COUNTER =3D=3D 0 //no overflow occurred
	NUM_AVAILABLE_SAMPLES =3D FIFO_DATA_COUNT
else,
	NUM_AVAILABLE_SAMPLES =3D 32 // overflow occurred and data has been lost

What you re missing is this =3D 32 branch.

Code should probably look like...

	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
	if (ret < 0) {
		goto unlock;
	// Fine to not do an else after the error path as it is inherently differe=
nt from
	// the next two which are in some way 'equal' in importance.   If you pref=
er it
	// that's fine too.
	if (ret > 0) {
		data_count =3D 32;
	} else {
		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_DATA_CNTR);
		if (ret < 0)
			goto unlock;
		data_count =3D ret;
	}



> +	else if (!ret) {
> +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_DATA_CNTR=
);
> +		if (ret < 0)
> +			goto unlock;
> +	}
> +
> +	data_count =3D ret;
> +
> +	while (data_count) {
> +		ret =3D i2c_smbus_read_word_swapped(data->client, MAX30208_FIFO_DATA);
> +		if (ret < 0)
> +			goto unlock;
> +
> +		data_count--;
> +	}
> +
> +unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/**
> + * max30208_config_setup() - Set up FIFO configuration register
> + * @data: Struct comprising member elements of the device
> + *
> + * Sets the rollover bit to '1' to enable overwriting FIFO during overfl=
ow.
> + */
> +static int max30208_config_setup(struct max30208_data *data)
> +{
> +	u8 regval;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_CONFIG);
> +	if (ret < 0)
> +		return ret;
> +
> +	regval =3D ret | MAX30208_FIFO_CONFIG_RO;
> +
> +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_FIFO_CONFIG, r=
egval);
> +	if (ret)
> +		return ret;

Trivial but can be simplified to

	return i2c_smbus_write_byte_data(...);

> +
> +	return 0;
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

