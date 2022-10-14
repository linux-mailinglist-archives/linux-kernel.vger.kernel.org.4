Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FA5FEE68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJNNKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Oct 2022 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJNNKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:10:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607E8E709;
        Fri, 14 Oct 2022 06:10:32 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpmtD372Yz67DYR;
        Fri, 14 Oct 2022 21:08:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 14 Oct 2022 15:10:29 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 14:10:29 +0100
Date:   Fri, 14 Oct 2022 14:10:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <rajat.khandelwal@intel.com>
Subject: Re: [PATCH] iio: temperature: Add driver support for Maxim MAX30208
Message-ID: <20221014141027.00004905@huawei.com>
In-Reply-To: <20221013151203.406113-1-rajat.khandelwal@linux.intel.com>
References: <20221013151203.406113-1-rajat.khandelwal@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 20:42:03 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Maxim MAX30208 is a digital temperature sensor with 0.1°C accuracy.
> Add support for max30208 driver in iio subsystem.

Hi Rajat,

Opening question for all temperature drivers is why IIO rather than hwmon?

There are a couple of standard reasons why the existing temp sensors are there.

1) They are weird.  E.g. the infrared sensors.
2) They are very industrially oriented (read expensive).  Usually things like
   high precision thermocouple front ends.
3) (this one is a bit nasty) they share silicon with more complex sensors.
   This sometimes happens with things like pressure sensors. Same interface
   covers devices with an without the pressure part.

Definitely hwmon if typically used for monitoring temp in a PC etc.
Other cases are somewhat trickier to answer.  We have iio-hwmon bridge
for the really unclear cases (so it can appear in both ;)

Either way I did a quick review. Comments inline.

Thanks,

Jonathan

> 
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
No blank line here.  Datasheet is part of the tags block that can be
scraped by automated tools so it needs to be in that block, not on it's
own.

> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>


> ---
>  MAINTAINERS                        |   6 +
>  drivers/iio/temperature/Kconfig    |  10 ++
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/max30208.c | 273 +++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 drivers/iio/temperature/max30208.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1390b8270b2..7f1fd2e31b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12373,6 +12373,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
>  F:	drivers/regulator/max20086-regulator.c
>  
> +MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> +M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/temperature/max30208.c
> +
>  MAXIM MAX77650 PMIC MFD DRIVER
>  M:	Bartosz Golaszewski <brgl@bgdev.pl>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index e8ed849e3b76..ed384f33e0c7 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -128,6 +128,16 @@ config TSYS02D
>  	  This driver can also be built as a module. If so, the module will
>  	  be called tsys02d.
>  
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
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index dd08e562ffe0..dfec8c6d3019 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
>  obj-$(CONFIG_LTC2983) += ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> +obj-$(CONFIG_MAX30208) += max30208.o
>  obj-$(CONFIG_MAX31856) += max31856.o
>  obj-$(CONFIG_MAX31865) += max31865.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
> diff --git a/drivers/iio/temperature/max30208.c b/drivers/iio/temperature/max30208.c
> new file mode 100644
> index 000000000000..e16c31621065
> --- /dev/null
> +++ b/drivers/iio/temperature/max30208.c
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> + *
> + * Maxim MAX30208 digital temperature sensor with 0.1°C accuracy
> + * (7-bit I2C slave address (0x50 - 0x53))
> + *
> + * Note: This driver sets GPIO1 to behave as input for temperature
> + * conversion and GPIO0 to act as interrupt for temperature conversion.
> + *
> + * TODO: trigger temperature conversion via GPIO1

That's a large todo.  Why set it up if the support to actually use it
isn't there?  Is there no mode where these GPIOs are disabled that would
be more suitable until you add support (optionally as gpios may well
not be wired up).

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
> +#define MAX30208_RESOLUTION_MC		5

I would spell out as MILLICELCIUS

MC is not a standard abbreviation.


> +
> +struct max30208_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +	struct mutex lock;

All locks need a comment to say what data / device state they are protecting.

> +};
> +
> +static const struct iio_chan_spec max30208_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +static int max30208_request(struct max30208_data *data)

I'd like a comment on what exactly this causes to happen.  Single reading or lots
of readings?  If lots, how do we turn it off again?

> +{
> +	int retries = 10;

Any retry counter needs a comment explaining why it is the particular value chosen..
I'd guess here because sensor can take up to half a second to read?

> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret |= MAX30208_TEMP_SENSOR_SETUP_CONV;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, ret);
> +	if (ret < 0)
> +		return ret;
> +
> +	while (retries--) {
> +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> +		if (ret < 0)
> +			goto sleep;

The device fails to respond to i2c reads?  That's nasty.  Add a comment on what
is going on here.

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
> +	u16 temp_raw = 0;

Value isn't used, so don't assign it.

> +	s8 data_count;
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = max30208_request(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> +	if (ret < 0)
> +		return ret;
> +	else if (!ret)
> +		data_count = i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);

See below, the error check should be here.

> +	else
> +		data_count = ret;
I'd like a comment here to explain what this flow is.  
> +
> +	if (data_count < 0)
Can only happen after the read, so move the error check up there...^^^
Also, use ret = i2c_smbus ... there and
then unconditionally set data_count = ret after the error check.

> +		return data_count;
> +
> +	while (data_count) {
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +						  MAX30208_FIFO_DATA);
> +		if (ret < 0)
> +			return ret;
> +
> +		data_count = i2c_smbus_read_byte_data(data->client,
> +						      MAX30208_FIFO_DATA_CNTR);

I'd guess that the counter never goes down other than due to reads?  If
so perhaps save on i2c_reads of the fifo count, but first clearing the ones we
know about, then checking the count again.   Arguably, if they are new they
are after we asked for a reading anyway, so perhaps we shouldn't be looking
at them - but instead using the most recent one before we starting reading?


> +		if (data_count < 0)
> +			return data_count;
> +	}
> +	temp_raw = ret;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return temp_raw;
> +}
> +
> +static int max30208_read(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int *val, int *val2, long mask)
> +{
> +	struct max30208_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max30208_update_temp(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret, 15);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = MAX30208_RESOLUTION_MC;
> +		*val2 = 1;
> +
> +		return IIO_VAL_FRACTIONAL;

return IIO_VAL_INT; 

> +
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = max30208_update_temp(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret, 15) * MAX30208_RESOLUTION_MC;

Don't have PROCESSED.  Drivers should never provide both raw and processed.
There are a few obscure reasons why they sometimes do, but non are applicable here
that I can see.

> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void max30208_gpio_setup(struct max30208_data *data)
int return so you can indicate an error to the caller.

> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_GPIO_SETUP);
> +	if (ret >= 0) {

	if (ret < 0)
		return ret;  //An error is an error, if you hit one fail the probe.

> +		/*
> +		 * Setting GPIO1 to trigger temperature conversion
> +		 * when driven low.
> +		 * Setting GPIO0 to trigger interrupt when temperature
> +		 * conversion gets completed.
> +		 */
> +		ret |= MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
> +		i2c_smbus_write_byte_data(data->client,
> +					  MAX30208_GPIO_SETUP, ret);
check error on that.
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       MAX30208_INT_ENABLE);
> +	if (ret >= 0) {
if (ret < 0)
	reutrn ret;

> +		/* Enabling GPIO0 interrupt */
> +		ret |= MAX30208_INT_ENABLE_TEMP_RDY;
> +		i2c_smbus_write_byte_data(data->client,
> +					  MAX30208_INT_ENABLE, ret);
check for error on that.
> +	}


> +}
> +
> +static const struct iio_info max30208_info = {
> +	.read_raw = max30208_read,
> +};
> +
> +static int max30208_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct max30208_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = i2c;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = MAX30208_DRV_NAME;
> +	indio_dev->channels = max30208_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max30208_channels);
> +	indio_dev->info = &max30208_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);

This exposes user interfaces of the driver so to avoid races it must be last
thing done in probe.

> +	if (ret) {
> +		dev_err(dev, "Failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	/* Reset the device after registering */
> +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> +					MAX30208_SYSTEM_CTRL_RESET);
> +	if (ret)
> +		dev_warn(dev, "Proceeding without successful reset\n");

That leaves is in nasy unknown state. Error out.  If the device fails
the i2c call because it resets quicker than sending the Ack (quite
a few drivers do this), just drop the error check.

> +
> +	usleep_range(50000, 60000);
> +
> +	max30208_gpio_setup(data);

As mentioned above, this should return an error if it hits one and
probe should fail if so.  It is very unwise to carry on once we have
a device in known state because an error occurred during setup.

> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max30208_id_table[] = {
> +	{ "max30208", 0 },

If data is always 0, don't bother setting it.
	{ "max30208" },
is fine.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> +
> +static struct i2c_driver max30208_driver = {
> +	.driver = {
> +		.name = MAX30208_DRV_NAME,
> +	},
> +	.probe_new = max30208_probe,
> +	.id_table = max30208_id_table,

I'd prefer seeing the of_match_table() as well.
Otherwise we rely on the fallback matching and lose the advantage
of having the vendor name in there.


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

module_i2c_driver()

> +
> +MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
> +MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");
> +MODULE_LICENSE("GPL");

