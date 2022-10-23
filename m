Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CE460928B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJWMEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJWMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:04:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DD613D68;
        Sun, 23 Oct 2022 05:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44A6FB80D1A;
        Sun, 23 Oct 2022 12:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB4EC433C1;
        Sun, 23 Oct 2022 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666526672;
        bh=VBEDnUizawM3v5qJp/hMBfZ9FFOsCmytSIScDi1z/ZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g9PsfKk4rS8upDU4JdGT8xLJfSA6RtIdHyZHzChe4ykZf5NSiMz+vp26NpJZ1dFvC
         cQnjVom7Eq46ISLhf3gdI2DuL9QSE1URAng6B8ZkSNwdRl0Po01QzuqxN5id5MzEwG
         04xmjMQJbPXuQfEN6qzljxiCcjk7WzY31V4yBmNpC1IDBz7e25DpDk3M4ChhtA67NJ
         lT4SmEZ/hTMWy1eQ0fubgECzFbRQlpMvYmnsb5YVD8OZDMVLru2fng22vGUSpk/Ygv
         /PtpWoeaec6Ymyr7Ay1BG7lBEdk0Fx3QiZE5LdpXYSmNlEHBIFJKIzB2VVmKAOQTJz
         hVsGuVX6Esjsw==
Date:   Sun, 23 Oct 2022 13:05:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: temperature: Add driver support for Maxim MAX30208
Message-ID: <20221023130506.6eefcfde@jic23-huawei>
In-Reply-To: <CO1PR11MB4835A5C17C3D72395C45850B96279@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221013151203.406113-1-rajat.khandelwal@linux.intel.com>
        <20221014141027.00004905@huawei.com>
        <CO1PR11MB4835A5C17C3D72395C45850B96279@CO1PR11MB4835.namprd11.prod.outlook.com>
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

On Sat, 15 Oct 2022 17:57:19 +0000
"Khandelwal, Rajat" <rajat.khandelwal@intel.com> wrote:

> Hi Jonathan,
> Thanks for the suggestions and remarks.=20
> Couple of things before I send out v2.=20
>=20
> Yes, I agree that hwmon could also be a receptacle for this. AFAIK,
> IIO is directed towards devices which are ADC/DAC converters in some sens=
e, which
> makes the driver I wrote also fall in the category.=20
> I am not a better judge but personally, I would choose iio over hwmon any=
time since
> the interface is something which has fancied me and enamored me to it. :)
>=20
> FYI, I am also writing another driver in parallel (a temperature sensor a=
gain) in IIO
> subsystem, so will ask you in this thread itself if it is considerable?
>=20
> Nevertheless, I genuinely would be grateful if you consider this driver t=
o be a part of IIO
> subsystem. As a maintainer for this, I would be happy to shift this to a =
better subsystem
> if something comes in the future or even hwmon.=20

Shifting drivers is hard, because of the resulting userspace ABI breakage. =
We need
to get this right from the start.

Key thing here is to engage with the hwmon list and maintainers and check t=
hat they are
happy for this driver to be in IIO.  So I'll take a quick look at your late=
st version
but it the version after that needs to go to the hwmon list and maintainers=
 as well
with an open question about whether they are fine with it being an IIO driv=
er rather than
a HWMON one.=20

>=20
> Switching to another topic, I have answered your comments and have some d=
oubts which
> I would like you to answer before I send out v2.=20

Sorry, didn't get back to most of my IIO email during the week - was rather=
 hectic.

>=20
> >> That's a large todo.  Why set it up if the support to actually use it =
=20
> isn't there?  Is there no mode where these GPIOs are disabled that would
> be more suitable until you add support (optionally as gpios may well
> not be wired up).
> 	There is no specific mode to "disable" the GPIOs. I wanted to trigger
> temperature conversion having GPIO1 as a trigger interrupt so I put this =
as
> TODO. Yes, its possible that GPIOs are not wired up but this would provid=
e a
> feature for this sensor for the GPIO to use.=20
> Also, I don't intend to keep the TODO for long. The device tables and ker=
nel code
> are already in process to remove the TODO.=20

Ok.  I would add that support before we take the driver.  Having a half imp=
lementation
is much worse than either no implementation of a feature, or full implement=
ation.
Whilst we always hope the feature will be completed, the nature of life is =
sometimes
that doesn't happen however good the intentions!

Note, please avoid cropping comments out this much - leave them with some c=
ontext.
I'm looking at this about a week later and can't recall what I was referrin=
g to!

>=20
> >>> +static void max30208_gpio_setup(struct max30208_data *data) =20
> int return so you can indicate an error to the caller.
> 	Here, I am configuring GPIOs to act as interrupt and temperature
> conversion events. But if configuration fails, I don't want to fail the d=
river probe
> as this is secondary and not absolutely necessary. Thus, there is no poin=
t to even
> check the return value.=20

If they are unnecessary then a void return is fine.

> Can we proceed with the function as 'void'? I will give a warning if any =
of the GPIO fails
> to be configured as interrupt/conversion event. That would suffice.  Will=
 that be ok?
Given the driver 'works' either way, perhaps dev_info() or dev_dbg() more a=
ppropriate than
a warning.

>=20
> >>That leaves is in nasy unknown state. Error out.  If the device fails =
=20
> the i2c call because it resets quicker than sending the Ack (quite
> a few drivers do this), just drop the error check.
> 	The failure to perform reset will not considerable affect the device. So=
me things
> like FIFO buffer could be not empty initially but since temperature readi=
ngs are taken
> at the end of the buffer, those shouldn't affect. Hence, I have implement=
ed dev_warn.=20

No. Failure to reset the device indicates the device is broken (or the driv=
er perhaps).
As such, error out. Working with a device that has already failed something=
 like this
is just a recipe for unstable results and bug reports.=20

> The warning indicates that if the user thinks that on triggering temperat=
ure conversion 'n'
> times, there would be 'n' FIFO readings, then he is wrong as device faile=
d to reset.
> This is the only motive of giving warning on reset.=20
>=20
> >>> +	max30208_gpio_setup(data); =20
>=20
> As mentioned above, this should return an error if it hits one and
> probe should fail if so.  It is very unwise to carry on once we have
> a device in known state because an error occurred during setup.
> 	The GPIO configuration error won't affect the device's usability.=20
> Hence, I haven't returned an error on failure. The main objective is to
> provide readings. GPIO functionality is secondary. Nevertheless, I will i=
ssue
> a warning if GPIO configuration fails to let user know GPIO's won't work.=
=20
> Would that be ok?

Not providing the GPIOs from firmware is fine as that's a valid 'good'
configuration.  Having them provided and then failing to configure them=20
is not as it indicates a hardware problem.=20

Any time you paper over a hardware problem you introduce a new set of
states to a driver.  (All states with failure to set gpio up, all states wi=
thout).
Add another such condition like the rest one and you now have 4x the number=
 of
states that the driver / device can enter.   That rapid becomes untestable
and prone to bugs.  Hence we make it simpler, but having any hardware failu=
re
that effects state a hard fail that results in the driver not probing.

Jonathan

>=20
> >>I'd prefer seeing the of_match_table() as well. =20
> Otherwise we rely on the fallback matching and lose the advantage
> of having the vendor name in there.
> 	Sure Jonathan. The device table is in the process of testings. However,
> I am implementing acpi_match_table in the driver. Will that work? Is the
> of_match_table necessary?

Have both.  Someone may use the driver with ACPI PRP0001 based bindings that
use the of_match_table (fun corner of ACPI handling :)

Jonathan


>=20
> Thanks
> Rajat
>=20
> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=20
> Sent: Friday, October 14, 2022 6:40 PM
> To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Cc: jic23@kernel.org; lars@metafoo.de; linux-kernel@vger.kernel.org; linu=
x-iio@vger.kernel.org; Khandelwal, Rajat <rajat.khandelwal@intel.com>
> Subject: Re: [PATCH] iio: temperature: Add driver support for Maxim MAX30=
208
>=20
> On Thu, 13 Oct 2022 20:42:03 +0530
> Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:
>=20
> > Maxim MAX30208 is a digital temperature sensor with 0.1=C2=B0C accuracy.
> > Add support for max30208 driver in iio subsystem. =20
>=20
> Hi Rajat,
>=20
> Opening question for all temperature drivers is why IIO rather than hwmon?
>=20
> There are a couple of standard reasons why the existing temp sensors are =
there.
>=20
> 1) They are weird.  E.g. the infrared sensors.
> 2) They are very industrially oriented (read expensive).  Usually things =
like
>    high precision thermocouple front ends.
> 3) (this one is a bit nasty) they share silicon with more complex sensors.
>    This sometimes happens with things like pressure sensors. Same interfa=
ce
>    covers devices with an without the pressure part.
>=20
> Definitely hwmon if typically used for monitoring temp in a PC etc.
> Other cases are somewhat trickier to answer.  We have iio-hwmon bridge fo=
r the really unclear cases (so it can appear in both ;)
>=20
> Either way I did a quick review. Comments inline.
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf =20
> No blank line here.  Datasheet is part of the tags block that can be scra=
ped by automated tools so it needs to be in that block, not on it's own.
>=20
> >=20
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com> =20
>=20
>=20
> > ---
> >  MAINTAINERS                        |   6 +
> >  drivers/iio/temperature/Kconfig    |  10 ++
> >  drivers/iio/temperature/Makefile   |   1 +
> >  drivers/iio/temperature/max30208.c | 273=20
> > +++++++++++++++++++++++++++++
> >  4 files changed, 290 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max30208.c
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS index=20
> > f1390b8270b2..7f1fd2e31b94 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12373,6 +12373,12 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/regulator/maxim,max20086.yaml
> >  F:	drivers/regulator/max20086-regulator.c
> > =20
> > +MAXIM MAX30208 TEMPERATURE SENSOR DRIVER
> > +M:	Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/iio/temperature/max30208.c
> > +
> >  MAXIM MAX77650 PMIC MFD DRIVER
> >  M:	Bartosz Golaszewski <brgl@bgdev.pl>
> >  L:	linux-kernel@vger.kernel.org
> > diff --git a/drivers/iio/temperature/Kconfig=20
> > b/drivers/iio/temperature/Kconfig index e8ed849e3b76..ed384f33e0c7=20
> > 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -128,6 +128,16 @@ config TSYS02D
> >  	  This driver can also be built as a module. If so, the module will
> >  	  be called tsys02d.
> > =20
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
> > diff --git a/drivers/iio/temperature/Makefile=20
> > b/drivers/iio/temperature/Makefile
> > index dd08e562ffe0..dfec8c6d3019 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -7,6 +7,7 @@ obj-$(CONFIG_IQS620AT_TEMP) +=3D iqs620at-temp.o
> >  obj-$(CONFIG_LTC2983) +=3D ltc2983.o
> >  obj-$(CONFIG_HID_SENSOR_TEMP) +=3D hid-sensor-temperature.o
> >  obj-$(CONFIG_MAXIM_THERMOCOUPLE) +=3D maxim_thermocouple.o
> > +obj-$(CONFIG_MAX30208) +=3D max30208.o
> >  obj-$(CONFIG_MAX31856) +=3D max31856.o
> >  obj-$(CONFIG_MAX31865) +=3D max31865.o
> >  obj-$(CONFIG_MLX90614) +=3D mlx90614.o
> > diff --git a/drivers/iio/temperature/max30208.c=20
> > b/drivers/iio/temperature/max30208.c
> > new file mode 100644
> > index 000000000000..e16c31621065
> > --- /dev/null
> > +++ b/drivers/iio/temperature/max30208.c
> > @@ -0,0 +1,273 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > + *
> > + * Maxim MAX30208 digital temperature sensor with 0.1=C2=B0C accuracy
> > + * (7-bit I2C slave address (0x50 - 0x53))
> > + *
> > + * Note: This driver sets GPIO1 to behave as input for temperature
> > + * conversion and GPIO0 to act as interrupt for temperature conversion.
> > + *
> > + * TODO: trigger temperature conversion via GPIO1 =20
>=20
> That's a large todo.  Why set it up if the support to actually use it isn=
't there?  Is there no mode where these GPIOs are disabled that would be mo=
re suitable until you add support (optionally as gpios may well not be wire=
d up).
>=20
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +
> > +#define MAX30208_DRV_NAME		"max30208"
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
> > +#define MAX30208_SYSTEM_CTRL		0x0c
> > +#define MAX30208_SYSTEM_CTRL_RESET	0x01
> > +
> > +#define MAX30208_TEMP_SENSOR_SETUP	0x14
> > +#define MAX30208_TEMP_SENSOR_SETUP_CONV	BIT(0)
> > +
> > +#define MAX30208_GPIO_SETUP		0x20
> > +#define MAX30208_GPIO1_SETUP		GENMASK(7, 6)
> > +#define MAX30208_GPIO0_SETUP		GENMASK(1, 0)
> > +#define MAX30208_GPIO_CTRL		0x21
> > +#define MAX30208_GPIO1_CTRL		BIT(3)
> > +#define MAX30208_GPIO0_CTRL		BIT(0)
> > +
> > +#define MAX30208_RESOLUTION_MC		5 =20
>=20
> I would spell out as MILLICELCIUS
>=20
> MC is not a standard abbreviation.
>=20
>=20
> > +
> > +struct max30208_data {
> > +	struct i2c_client *client;
> > +	struct iio_dev *indio_dev;
> > +	struct mutex lock; =20
>=20
> All locks need a comment to say what data / device state they are protect=
ing.
>=20
> > +};
> > +
> > +static const struct iio_chan_spec max30208_channels[] =3D {
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_S=
CALE) |
> > +				      BIT(IIO_CHAN_INFO_PROCESSED),
> > +	},
> > +};
> > +
> > +static int max30208_request(struct max30208_data *data) =20
>=20
> I'd like a comment on what exactly this causes to happen.  Single reading=
 or lots of readings?  If lots, how do we turn it off again?
>=20
> > +{
> > +	int retries =3D 10; =20
>=20
> Any retry counter needs a comment explaining why it is the particular val=
ue chosen..
> I'd guess here because sensor can take up to half a second to read?
>=20
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_S=
ETUP);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret |=3D MAX30208_TEMP_SENSOR_SETUP_CONV;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_=
SETUP, ret);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	while (retries--) {
> > +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> > +		if (ret < 0)
> > +			goto sleep; =20
>=20
> The device fails to respond to i2c reads?  That's nasty.  Add a comment o=
n what is going on here.
>=20
> > +
> > +		if (ret & MAX30208_STATUS_TEMP_RDY)
> > +			return 0;
> > +
> > +		msleep(50);
> > +	}
> > +	dev_warn(&data->client->dev, "Temperature conversion failed\n");
> > +
> > +	return 0;
> > +
> > +sleep:
> > +	usleep_range(50000, 60000);
> > +	return 0;
> > +}
> > +
> > +static int max30208_update_temp(struct max30208_data *data) {
> > +	u16 temp_raw =3D 0; =20
>=20
> Value isn't used, so don't assign it.
>=20
> > +	s8 data_count;
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	ret =3D max30208_request(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR=
);
> > +	if (ret < 0)
> > +		return ret;
> > +	else if (!ret)
> > +		data_count =3D i2c_smbus_read_byte_data(data->client,
> > +						      MAX30208_FIFO_DATA_CNTR); =20
>=20
> See below, the error check should be here.
>=20
> > +	else
> > +		data_count =3D ret; =20
> I'd like a comment here to explain what this flow is. =20
> > +
> > +	if (data_count < 0) =20
> Can only happen after the read, so move the error check up there...^^^ Al=
so, use ret =3D i2c_smbus ... there and then unconditionally set data_count=
 =3D ret after the error check.
>=20
> > +		return data_count;
> > +
> > +	while (data_count) {
> > +		ret =3D i2c_smbus_read_word_swapped(data->client,
> > +						  MAX30208_FIFO_DATA);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		data_count =3D i2c_smbus_read_byte_data(data->client,
> > +						      MAX30208_FIFO_DATA_CNTR); =20
>=20
> I'd guess that the counter never goes down other than due to reads?  If s=
o perhaps save on i2c_reads of the fifo count, but first clearing the ones =
we
> know about, then checking the count again.   Arguably, if they are new th=
ey
> are after we asked for a reading anyway, so perhaps we shouldn't be looki=
ng at them - but instead using the most recent one before we starting readi=
ng?
>=20
>=20
> > +		if (data_count < 0)
> > +			return data_count;
> > +	}
> > +	temp_raw =3D ret;
> > +
> > +	mutex_unlock(&data->lock);
> > +
> > +	return temp_raw;
> > +}
> > +
> > +static int max30208_read(struct iio_dev *indio_dev,
> > +			 struct iio_chan_spec const *chan,
> > +			 int *val, int *val2, long mask)
> > +{
> > +	struct max30208_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D max30208_update_temp(data);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val =3D sign_extend32(ret, 15);
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D MAX30208_RESOLUTION_MC;
> > +		*val2 =3D 1;
> > +
> > +		return IIO_VAL_FRACTIONAL; =20
>=20
> return IIO_VAL_INT;=20
>=20
> > +
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		ret =3D max30208_update_temp(data);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val =3D sign_extend32(ret, 15) * MAX30208_RESOLUTION_MC; =20
>=20
> Don't have PROCESSED.  Drivers should never provide both raw and processe=
d.
> There are a few obscure reasons why they sometimes do, but non are applic=
able here that I can see.
>=20
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static void max30208_gpio_setup(struct max30208_data *data) =20
> int return so you can indicate an error to the caller.
>=20
> > +{
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client,
> > +				       MAX30208_GPIO_SETUP);
> > +	if (ret >=3D 0) { =20
>=20
> 	if (ret < 0)
> 		return ret;  //An error is an error, if you hit one fail the probe.
>=20
> > +		/*
> > +		 * Setting GPIO1 to trigger temperature conversion
> > +		 * when driven low.
> > +		 * Setting GPIO0 to trigger interrupt when temperature
> > +		 * conversion gets completed.
> > +		 */
> > +		ret |=3D MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP;
> > +		i2c_smbus_write_byte_data(data->client,
> > +					  MAX30208_GPIO_SETUP, ret); =20
> check error on that.
> > +	}
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client,
> > +				       MAX30208_INT_ENABLE);
> > +	if (ret >=3D 0) { =20
> if (ret < 0)
> 	reutrn ret;
>=20
> > +		/* Enabling GPIO0 interrupt */
> > +		ret |=3D MAX30208_INT_ENABLE_TEMP_RDY;
> > +		i2c_smbus_write_byte_data(data->client,
> > +					  MAX30208_INT_ENABLE, ret); =20
> check for error on that.
> > +	} =20
>=20
>=20
> > +}
> > +
> > +static const struct iio_info max30208_info =3D {
> > +	.read_raw =3D max30208_read,
> > +};
> > +
> > +static int max30208_probe(struct i2c_client *i2c) {
> > +	struct device *dev =3D &i2c->dev;
> > +	struct max30208_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data =3D iio_priv(indio_dev);
> > +	data->client =3D i2c;
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->name =3D MAX30208_DRV_NAME;
> > +	indio_dev->channels =3D max30208_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(max30208_channels);
> > +	indio_dev->info =3D &max30208_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	ret =3D devm_iio_device_register(dev, indio_dev); =20
>=20
> This exposes user interfaces of the driver so to avoid races it must be l=
ast thing done in probe.
>=20
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register IIO device\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Reset the device after registering */
> > +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> > +					MAX30208_SYSTEM_CTRL_RESET);
> > +	if (ret)
> > +		dev_warn(dev, "Proceeding without successful reset\n"); =20
>=20
> That leaves is in nasy unknown state. Error out.  If the device fails the=
 i2c call because it resets quicker than sending the Ack (quite a few drive=
rs do this), just drop the error check.
>=20
> > +
> > +	usleep_range(50000, 60000);
> > +
> > +	max30208_gpio_setup(data); =20
>=20
> As mentioned above, this should return an error if it hits one and probe =
should fail if so.  It is very unwise to carry on once we have a device in =
known state because an error occurred during setup.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id max30208_id_table[] =3D {
> > +	{ "max30208", 0 }, =20
>=20
> If data is always 0, don't bother setting it.
> 	{ "max30208" },
> is fine.
>=20
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> > +
> > +static struct i2c_driver max30208_driver =3D {
> > +	.driver =3D {
> > +		.name =3D MAX30208_DRV_NAME,
> > +	},
> > +	.probe_new =3D max30208_probe,
> > +	.id_table =3D max30208_id_table, =20
>=20
> I'd prefer seeing the of_match_table() as well.
> Otherwise we rely on the fallback matching and lose the advantage of havi=
ng the vendor name in there.
>=20
>=20
> > +};
> > +
> > +static int __init max30208_init(void) {
> > +	return i2c_add_driver(&max30208_driver); }=20
> > +module_init(max30208_init);
> > +
> > +static void __exit max30208_exit(void) {
> > +	i2c_del_driver(&max30208_driver);
> > +}
> > +module_exit(max30208_exit); =20
>=20
> module_i2c_driver()
>=20
> > +
> > +MODULE_AUTHOR("Rajat Khandelwal <rajat.khandelwal@linux.intel.com>");
> > +MODULE_DESCRIPTION("Maxim MAX30208 digital temperature sensor");=20
> > +MODULE_LICENSE("GPL"); =20
>=20

