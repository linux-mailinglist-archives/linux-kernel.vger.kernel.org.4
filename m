Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D72E62E057
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiKQPvf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Nov 2022 10:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiKQPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:51:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F871769F0;
        Thu, 17 Nov 2022 07:51:27 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCkqG1k7Tz6HJKS;
        Thu, 17 Nov 2022 23:48:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 16:51:25 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 15:51:24 +0000
Date:   Thu, 17 Nov 2022 15:51:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v9] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221117155124.000062a9@Huawei.com>
In-Reply-To: <CO1PR11MB483513883EAFED0AD6F2D4B596069@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221109135949.734180-1-rajat.khandelwal@linux.intel.com>
        <20221113114905.2b2dd891@jic23-huawei>
        <CO1PR11MB483513883EAFED0AD6F2D4B596069@CO1PR11MB4835.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Thu, 17 Nov 2022 15:13:44 +0000
"Khandelwal, Rajat" <rajat.khandelwal@intel.com> wrote:

> Hi Jonathan,
> It took time for me to again go back and analyze everything. :)
> The page 16 of the datasheet is absolutely correct. If overflow
> happens, we will have a total of 32 samples to read - not denying
> that. I will try to explain with an example here. Lets say the read
> pointer and write pointer are both at 0x04. Now I triggered the
> conversion several times which lead to write pointer increasing to
> 0x31 and then again rotating back and finishing at 0x04. Now again I
> triggered the conversion 2 more times. At this time, the overflow
> counter will read - 2. This time I thought that values at 0x04 and
> 0x05 are overflowed and write pointer comes at 0x06. And thus I was
> keeping the data count as 2 and popping out 2 values to reach the
> latest one. 
> 
> However, I checked this time triggering the conversion a myriad
> amount of times. Actually, if write pointer comes back at 0x04 and if
> I again trigger the conversions, the value at 0x04 only gets
> overwritten that many times and write pointer stays at 0x04. Thus
> triggering 2 times will still keep the write pointer at 0x04 and log
> 2 in overflow counter. Thus actually, in order to reach the recent
> most value, it won't be 0x04  + overflow counter, rather 0x04 itself
> as 0x04 gets overwritten after FIFO gets full. 
> 
> Ok, so now according to me, if I want the recent most reading, I
> would only have to pop 1 time to read the value at 0x04 with read
> pointer increasing to 0x05 and overflow counter coming back to 0.

I'd expect it to have pushed the read pointer to 0x5 at this stage, but
you have the hardware so can check this.  If it stays at 0x4 then the
hardware is even more esoteric than I thought..  I suppose it does
provide an interesting cheap way to effectively turn off the buffer.
Let it fill up initially - from then on just read one value. It will overflow
one write later and you can read one more value etc. Horrible!


> 
> Have incorporated in v10 for your perusal. Apologies for the
> incorrect understanding. IIO is relatively new domain to me and how
> these devices behave and datasheet is laid out gets interpreted by me
> sometimes in a wrong manner. 

This is a particularly odd device so don't worry about it!

Jonathan

> 

> Thanks
> Rajat
> 
> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org> 
> Sent: Sunday, November 13, 2022 5:19 PM
> To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Cc: lars@metafoo.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; jdelvare@suse.com; linux@roeck-us.net; linux-hwmon@vger.kernel.org; Khandelwal, Rajat <rajat.khandelwal@intel.com>
> Subject: Re: [PATCH v9] iio: temperature: Add driver support for Maxim MAX30208
> 
> On Wed,  9 Nov 2022 19:29:49 +0530
> Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:
> 
> > Maxim MAX30208 is a digital temperature sensor with 0.1°C accuracy.
> > 
> > Add support for max30208 driver in iio subsystem.
> > Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
> > 
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>  
> 
> Hi Rajat,
> 
> Alongside some trivial stuff I would have either fixed up when applying or not worried about...
> 
> The overflow counter handling still looks wrong to me and doesn't follow the pseudo code on page 16 of the data sheet:
> FIFO_DATA read example.
> 
> I thought about just applying this with the change I'm suggesting, but probably better if you test it works as expected and spin a v10.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> > 
> > v9: Repositioning register data
> > 
> > v8:
> > 1. Returning time out if conversion fails to happen 2. Setting 
> > rollover bit to '1' to allow FIFO overwriting 3. Dropping ACPI_PTR
> > 
> > v7:
> > 1. Dropped GPIOs use for now
> > 2. Driver name string directly used
> > 3. Mutex lock description added
> > 4. Removed noisy errors and only kept errors on larger code blocks 5. 
> > dev_warn -> dev_err for temperature conversion failure 6. Improvised 
> > the logic of popping out values 7. Fixed line breaks 8. 
> > module_i2c_driver
> > 
> > v6: Converted usleep_range to msleep as delay is quite large
> > 
> > v5:
> > 1. Fixed comment position in max30208_request 2. Use of local u8 
> > variable to build register values 3. Using u8 instead of s8 in 
> > data_count 4. Removed global MAX30208_RES_MILLICELCIUS 5. Removed 
> > 'comma' on NULL terminators
> > 
> > v4: Version comments go below line separator of signed-off-by
> > 
> > v3: Release the mutex lock after error gets returned
> > 
> > v2:
> > 1. Removed TODO
> > 2. Removed unnecessary blank spaces
> > 3. Corrected MC->MILLICELCIUS
> > 4. Comments added wherever required
> > 5. dev_err on i2c fails
> > 6. Rearranged some flows
> > 7. Removed PROCESSED
> > 8. int error return on gpio setup
> > 9. device_register at the end of probe 10. Return on unsuccessful 
> > reset 11. acpi_match_table and of_match_table added 12. Minor quirks
> > 
> >  MAINTAINERS                        |   6 +
> >  drivers/iio/temperature/Kconfig    |  10 ++
> >  drivers/iio/temperature/Makefile   |   1 +
> >  drivers/iio/temperature/max30208.c | 251 
> > +++++++++++++++++++++++++++++
> >  4 files changed, 268 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max30208.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS index 
> > f1390b8270b2..7f1fd2e31b94 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12373,6 +12373,12 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
> >  F:	drivers/regulator/max20086-regulator.c
> >  
> > +MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> > +M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/iio/temperature/max30208.c
> > +
> >  MAXIM MAX77650 PMIC MFD DRIVER
> >  M:	Bartosz Golaszewski <brgl@bgdev.pl>
> >  L:	linux-kernel@vger.kernel.org
> > diff --git a/drivers/iio/temperature/Kconfig 
> > b/drivers/iio/temperature/Kconfig index e8ed849e3b76..ed384f33e0c7 
> > 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -128,6 +128,16 @@ config TSYS02D
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called tsys02d.
> >  
> > +config MAX30208
> > +	tristate "Maxim MAX30208 digital temperature sensor"
> > +	depends on I2C
> > +	help
> > +	  If you say yes here you get support for Maxim MAX30208
> > +	  digital temperature sensor connected via I2C.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called max30208.
> > +
> >  config MAX31856
> >  	tristate "MAX31856 thermocouple sensor"
> >  	depends on SPI
> > diff --git a/drivers/iio/temperature/Makefile 
> > b/drivers/iio/temperature/Makefile
> > index dd08e562ffe0..dfec8c6d3019 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
> >  obj-$(CONFIG_LTC2983) += ltc2983.o
> >  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
> >  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> > +obj-$(CONFIG_MAX30208) += max30208.o
> >  obj-$(CONFIG_MAX31856) += max31856.o
> >  obj-$(CONFIG_MAX31865) += max31865.o
> >  obj-$(CONFIG_MLX90614) += mlx90614.o
> > diff --git a/drivers/iio/temperature/max30208.c 
> > b/drivers/iio/temperature/max30208.c
> > new file mode 100644
> > index 000000000000..102eb2b77dbe
> > --- /dev/null
> > +++ b/drivers/iio/temperature/max30208.c
> > @@ -0,0 +1,251 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > + *
> > + * Maxim MAX30208 digital temperature sensor with 0.1°C accuracy
> > + * (7-bit I2C slave address (0x50 - 0x53))  */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +
> > +#define MAX30208_STATUS			0x00
> > +#define MAX30208_STATUS_TEMP_RDY	BIT(0)
> > +#define MAX30208_INT_ENABLE		0x01
> > +#define MAX30208_INT_ENABLE_TEMP_RDY	BIT(0)
> > +
> > +#define MAX30208_FIFO_OVF_CNTR		0x06
> > +#define MAX30208_FIFO_DATA_CNTR		0x07
> > +#define MAX30208_FIFO_DATA		0x08
> > +
> > +#define MAX30208_FIFO_CONFIG		0x0a
> > +#define MAX30208_FIFO_CONFIG_RO		BIT(1)
> > +
> > +#define MAX30208_SYSTEM_CTRL		0x0c
> > +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> > +
> > +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> > +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> > +
> > +struct max30208_data {
> > +	struct i2c_client *client;
> > +	struct iio_dev *indio_dev;
> > +	struct mutex lock; /* Lock to prevent concurrent reads of 
> > +temperature readings */ };
> > +
> > +static const struct iio_chan_spec max30208_channels[] = {
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +};
> > +
> > +/**
> > + * max30208_request() - Request a reading
> > + * @data: Struct comprising member elements of the device  
> 
> Trivial, but perhaps better as
> 	@data: struct containing per device instance data.
> 
> Device can both mean the linux driver model device and the actual piece of hardware and in this case I don't think it is clear which!
> This applies to other instances of the same comment.
> 
> > + *
> > + * Requests a reading from the device and waits until the conversion is ready.
> > + */
> > +static int max30208_request(struct max30208_data *data) {
> > +	/*
> > +	 * Sensor can take up to 500 ms to respond so execute a total of
> > +	 * 10 retries to give the device sufficient time.
> > +	 */
> > +	int retries = 10;
> > +	u8 regval;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	regval = ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_SETUP, regval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	while (retries--) {
> > +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (ret & MAX30208_STATUS_TEMP_RDY)
> > +			return 0;
> > +
> > +		msleep(50);
> > +	}
> > +	dev_err(&data->client->dev, "Temperature conversion failed\n");
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int max30208_update_temp(struct max30208_data *data) {
> > +	u8 data_count;
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	ret = max30208_request(data);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> > +	if (ret < 0)
> > +		goto unlock;  
> 
> I'm fairly sure this still doesn't work.  If an overflow has occurred we need to read the full fifo.  OVF_CNTR contains the number of readings that overflowed, not the number we need to read.  Hence in the overflow condition it may read anything between 1 and 0x1f depending on how much we have overflowed.
> 
> What we want data_count to be is the size of the fifo not this number.
> From the datasheet:
> 
> Number of samples available in the FIFO after the last read can be obtained by reading the OVF_COUNTER[4:0] and FIFO_DATA_COUNT[5:0] registers using the following pseudo-code:
> read the OVF_COUNTER register
> read the FIFO_DATA_COUNT register
> if OVF_COUNTER == 0 //no overflow occurred
> 	NUM_AVAILABLE_SAMPLES = FIFO_DATA_COUNT else,
> 	NUM_AVAILABLE_SAMPLES = 32 // overflow occurred and data has been lost
> 
> What you re missing is this = 32 branch.
> 
> Code should probably look like...
> 
> 	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
> 	if (ret < 0) {
> 		goto unlock;
> 	// Fine to not do an else after the error path as it is inherently different from
> 	// the next two which are in some way 'equal' in importance.   If you prefer it
> 	// that's fine too.
> 	if (ret > 0) {
> 		data_count = 32;
> 	} else {
> 		ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_DATA_CNTR);
> 		if (ret < 0)
> 			goto unlock;
> 		data_count = ret;
> 	}
> 
> 
> 
> > +	else if (!ret) {
> > +		ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_DATA_CNTR);
> > +		if (ret < 0)
> > +			goto unlock;
> > +	}
> > +
> > +	data_count = ret;
> > +
> > +	while (data_count) {
> > +		ret = i2c_smbus_read_word_swapped(data->client, MAX30208_FIFO_DATA);
> > +		if (ret < 0)
> > +			goto unlock;
> > +
> > +		data_count--;
> > +	}
> > +
> > +unlock:
> > +	mutex_unlock(&data->lock);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * max30208_config_setup() - Set up FIFO configuration register
> > + * @data: Struct comprising member elements of the device
> > + *
> > + * Sets the rollover bit to '1' to enable overwriting FIFO during overflow.
> > + */
> > +static int max30208_config_setup(struct max30208_data *data) {
> > +	u8 regval;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_CONFIG);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	regval = ret | MAX30208_FIFO_CONFIG_RO;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, MAX30208_FIFO_CONFIG, regval);
> > +	if (ret)
> > +		return ret;  
> 
> Trivial but can be simplified to
> 
> 	return i2c_smbus_write_byte_data(...);
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int max30208_read(struct iio_dev *indio_dev,
> > +			 struct iio_chan_spec const *chan,
> > +			 int *val, int *val2, long mask)
> > +{
> > +	struct max30208_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = max30208_update_temp(data);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = sign_extend32(ret, 15);
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 5;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}  
> 

