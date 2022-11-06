Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD561E1F0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 12:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKFL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKFL5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 06:57:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CB64D2;
        Sun,  6 Nov 2022 03:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9655960C4E;
        Sun,  6 Nov 2022 11:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F56C433D6;
        Sun,  6 Nov 2022 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667735835;
        bh=fr9FkkFDI27wAoltAHiaWA8M5Jc3Dj+n0qJxDQ37eko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y//eQKmW3HdmFaHifPAJQAAuEP7WQCwIpC32qGXXI1ZdL0e0uHGyTSSbc4leF8XQ3
         /kO+Qn9kB7Qx+PwfIGTTYaKLPsKDykl6Q8WI1FVUVGLL2jhPxW7gUS3QdI5svfKmaq
         Ix3Yy36LmB1wO+XU6zzfbPNMUjL8SKbXu0LEZFrv6DB7mDOw60fo0qOOBOQgc+l/Ip
         9Z4mcDTSoiLN4fWuO1dy/9nlq2gTSkcHTJ3pNSQ7LziqCpqTu/d3J44GKNF7NkLja3
         KqU7y1oQHOcK0xs9AgteIX5cd6qSDVl22C5FfiCykez5W8B0fRtpfIs5eXX4ovi8d7
         vkgfdvH9CsbYA==
Date:   Sun, 6 Nov 2022 11:57:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v6] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221106115705.623503c3@jic23-huawei>
In-Reply-To: <CO1PR11MB4835BF50AD0BED735350F5B196379@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221025171858.225242-1-rajat.khandelwal@linux.intel.com>
        <20221029160353.3999849b@jic23-huawei>
        <CO1PR11MB4835BF50AD0BED735350F5B196379@CO1PR11MB4835.namprd11.prod.outlook.com>
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

On Mon, 31 Oct 2022 17:24:51 +0000
"Khandelwal, Rajat" <rajat.khandelwal@intel.com> wrote:


>=20
> >I agree with Guenter's comment that this is a bit overly noisy. We don't=
 expect
> >random register reads to fail + IIRC there is tracing in the i2c subsyst=
em if we
> >are getting such errors.   Hence probably reduce the error to cover only=
 larger
> >blocks of code.  Reasonable to report that the temperature request faile=
d perhaps. =20
> So, I kind of just started upstreaming matches in the IIO community also =
for change of
> domains and on seeing other drivers which were returning on each error, I=
 thought
> maybe its required in IIO? Thanks for this comment. I have removed them.=
=20

It's a question of balance.  Mostly I don't complain too much on where an i=
ndividual
author decides that balance lies (as it doesn't really matter, but seeing a=
s Guenter
had already raised it I commented this time ;)
>=20
> >dev_err()  Failing isn't expected so it's a device error not something
> >we should merely warn about. =20
> Ok, so here I have incorporated dev_err but what I wanted was if MAX30208=
_STATUS_TEMP_RDY
> is written successfully and any error happens after that, the user still =
gets returned the most recent
> reading when this operation fails. So, I have changed it into dev_err wit=
h printing
> "Temperature conversion failed, reporting the last known reading...") Wil=
l that be ok?

It is a condition that we really don't expect to happen and we don't know h=
ow stale
the reading is.  So I'd just report an error.  Userspace can read again if =
it thinks
the error is likely to be resolved.

>=20
> > Error return to indicate what happened - there is one for timeouts. =20
> As indicated above, if you are in for that, then here we should ideally r=
eturn 0 since even after
> the error, we want update_temp to do its job and return the last reading.=
=20
>=20
> >Whilst you debated this logic with Guenter in v5, I don't follow the con=
clusion.
> >If FIFO_OVF_CNTR > 0 then FIFO_DATA_CNTR =3D=3D maximum value.  Logic of=
 this is
> >given in FIFO_DATA Read Example (Page 16 of the spec)  It doesn't matter=
 as such
> >because you read FIFO_DATA_CNTR again anyway, but it would be more obvio=
us what
> >is going on if you just set data_count =3D 32 if overflow has occured.
> >
> >The only thing I would argue you 'might' want to do with the overflow co=
unter
> >is to use it to indicate we need to read at least the number of elements=
 in the fifo.
> >If there are no additional elements at the end, wait until there is one.=
 Otherwise
> >you potentially get very stale data - it might have been overflowing for=
 a long time)
> >This decrease by more than 1 is worrying.  I can understand it not decre=
asing, or even
> >increasing (new data came in), but this condition sounds either like we =
are doing something
> >wrong or there is a hardware bug. =20
> Ok, even I started doubting the nature of the device I encountered when I=
 tested it.
> The thing is, this driver also comes with an EV kit wherein you can plug =
into
> PC, download the software and interface it via USB. Whenever I emulated r=
eads from the
> OS, I encountered erroneous counter decrements.=20
> However, I have tested it using native I2C on my microcontroller and I do=
n't ever encounter
> such readings, thus concluding that the spurious erroneous zones only exi=
st when the EV kit
> is interfaced via USB.=20
> Thanks for creating this doubt. I have solved it by only decrementing dat=
a_count unless it
> becomes 0.=20
> Regarding data_count variable, so when overflow counter is >0, I want to =
decrease 'overflow counter'
> number of times to get the required reading and when overflow counter is =
=3D0, I want to decrease
> 'data counter' number of times to get the reading. Hope it makes sense no=
w in the new version.

That isn't how I read the datasheet.=20

OVF_COUNTER (address 0x06), Overflow Counter
OVF_COUNTER[4:0] logs the number of words lost if new words are written aft=
er the
FIFO is full. ... Each time a complete word is popped from the FIFO,
the OVF_COUNTER is reset to zero.

so if you get overflow counter set, then you should drain the fifo complete=
ly (it is stale)
and wait for one new reading to turn up so that we know we have something f=
resh.
That reading may well turn up whilst you are busy draining the fifo and if =
so that is fine
to use - if not you should wait a bit longer until one does.


Please reply inline rather than pulling comments to top of email to reply t=
o them.
Pulling them to the top removes the context that can be crucial in understa=
nding the comment.

Jonathan

>=20
> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>=20
> Sent: Saturday, October 29, 2022 8:34 PM
> To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Cc: lars@metafoo.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.=
org; jdelvare@suse.com; linux@roeck-us.net; linux-hwmon@vger.kernel.org; Kh=
andelwal, Rajat <rajat.khandelwal@intel.com>
> Subject: Re: [PATCH v6] iio: temperature: Add driver support for Maxim MA=
X30208
>=20
> On Tue, 25 Oct 2022 22:48:58 +0530
> Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:
>=20
> > Maxim MAX30208 is a digital temperature sensor with 0.1=C2=B0C accuracy.
> >=20
> > Add support for max30208 driver in iio subsystem.
> > Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
> >=20
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com> =20
>=20
> Hi Rajat,
>=20
> Consider using regmap for this. It will provide you with some helpful uti=
lity functions.  I don't mind you sticking to direct i2c calls though if yo=
u prefer.
>=20
> Quite a few things inline that have been commented on in previous reviews.
> Make sure you incorporate all feedback or you'll end up going through mor=
e versions than would otherwise be necessary.
>=20
> Jonathan
>=20
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
> > index 000000000000..41b26755ce27
> > --- /dev/null
> > +++ b/drivers/iio/temperature/max30208.c
> > @@ -0,0 +1,323 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright (c) Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > + *
> > + * Maxim MAX30208 digital temperature sensor with 0.1=C2=B0C accuracy
> > + * (7-bit I2C slave address (0x50 - 0x53))
> > + *
> > + * Note: This driver sets GPIO1 to behave as input for temperature
> > + * conversion and GPIO0 to act as interrupt for temperature conversion=
. =20
>=20
> It doesn't use them, so unless you have to be in that state to use the cu=
rrent method, drop the note and don't set them to do that.
>=20
> You can add that support if / when the driver supports it.
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
> > +#define MAX30208_DRV_NAME		"max30208" =20
>=20
> Mentioned below, but I'd prefer to see the string directly inline.
>=20
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
> > +struct max30208_data {
> > +	struct i2c_client *client;
> > +	struct iio_dev *indio_dev;
> > +	struct mutex lock; /* Lock to prevent concurrent reads */ =20
>=20
> Be more explicit - reads of what?
>=20
> > +};
> > +
> > +static const struct iio_chan_spec max30208_channels[] =3D {
> > +	{
> > +		.type =3D IIO_TEMP,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_S=
CALE),
> > +	},
> > +};
> > +
> > +/**
> > + * max30208_request() - Request a reading
> > + * @data: Struct comprising member elements of the device
> > + *
> > + * Requests a reading from the device and waits until the conversion i=
s ready.
> > + */
> > +static int max30208_request(struct max30208_data *data) {
> > +	/*
> > +	 * Sensor can take up to 500 ms to respond so execute a total of
> > +	 * 10 retries to give the device sufficient time.
> > +	 */
> > +	int retries =3D 10;
> > +	u8 regval;
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_TEMP_SENSOR_S=
ETUP);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error reading reg temperature=20
> > +setup\n"); =20
>=20
> I agree with Guenter's comment that this is a bit overly noisy. We don't =
expect random register reads to fail + IIRC there is tracing in the i2c sub=
system if we
> are getting such errors.   Hence probably reduce the error to cover only =
larger
> blocks of code.  Reasonable to report that the temperature request failed=
 perhaps.
>=20
>=20
> > +		return ret;
> > +	}
> > +
> > +	regval =3D ret | MAX30208_TEMP_SENSOR_SETUP_CONV;
> > +
> > +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_TEMP_SENSOR_=
SETUP, regval);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error writing reg temperature setup\n");
> > +		return ret;
> > +	}
> > +
> > +	while (retries--) {
> > +		ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_STATUS);
> > +		if (ret < 0) {
> > +			dev_err(&data->client->dev, "Error reading reg status\n");
> > +			goto sleep; =20
>=20
> Can this happen for a documented reason?  If not treat it as a comms erro=
r and return it.
>=20
> > +		}
> > +
> > +		if (ret & MAX30208_STATUS_TEMP_RDY)
> > +			return 0;
> > +
> > +		msleep(50);
> > +	}
> > +	dev_warn(&data->client->dev, "Temperature conversion failed\n"); =20
>=20
> dev_err()  Failing isn't expected so it's a device error not something we=
 should merely warn about.
>=20
> > +
> > +	return 0; =20
> Error return to indicate what happened - there is one for timeouts.
>=20
> > +
> > +sleep: =20
>=20
> Why sleep in an error path?  It's failed - why do we think sleeping is a =
good idea?
>=20
> > +	msleep(50);
> > +	return 0;
> > +}
> > +
> > +static int max30208_update_temp(struct max30208_data *data) {
> > +	u8 data_count;
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	ret =3D max30208_request(data);
> > +	if (ret < 0)
> > +		goto unlock;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client,=20
> > +MAX30208_FIFO_OVF_CNTR); =20
> Whilst you debated this logic with Guenter in v5, I don't follow the conc=
lusion.
> If FIFO_OVF_CNTR > 0 then FIFO_DATA_CNTR =3D=3D maximum value.  Logic of =
this is given in FIFO_DATA Read Example (Page 16 of the spec)  It doesn't m=
atter as such because you read FIFO_DATA_CNTR again anyway, but it would be=
 more obvious what is going on if you just set data_count =3D 32 if overflo=
w has occured.
>=20
> The only thing I would argue you 'might' want to do with the overflow cou=
nter is to use it to indicate we need to read at least the number of elemen=
ts in the fifo.
> If there are no additional elements at the end, wait until there is one. =
Otherwise you potentially get very stale data - it might have been overflow=
ing for a long time)
>=20
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter=
\n");
> > +		goto unlock;
> > +	} else if (!ret) {
> > +		ret =3D i2c_smbus_read_byte_data(data->client,
> > +					       MAX30208_FIFO_DATA_CNTR);
> > +		if (ret < 0) {
> > +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n"=
);
> > +			goto unlock;
> > +		}
> > +	}
> > +
> > +	data_count =3D ret;
> > +
> > +	/*
> > +	 * Ideally, counter should decrease by 1 each time a word is read fro=
m FIFO.
> > +	 * However, practically, the device behaves erroneously and counter s=
ometimes
> > +	 * decreases by more than 1. Hence, do not loop the counter until it =
becomes 0
> > +	 * rather, use the exact counter value after each FIFO word is read. =
=20
>=20
> This decrease by more than 1 is worrying.  I can understand it not decrea=
sing, or even increasing (new data came in), but this condition sounds eith=
er like we are doing something wrong or there is a hardware bug.
>=20
> > +	 * Return the last reading from FIFO as the most recently triggered=20
> > +one =20
>=20
> Not necessarily recent (even if most recent available). Imagine this runs=
 after overflow and runs really quickly.
> You may not get a new reading.
>=20
> > +	 */
> > +	while (data_count) {
> > +		ret =3D i2c_smbus_read_word_swapped(data->client,
> > +						  MAX30208_FIFO_DATA);
> > +		if (ret < 0) {
> > +			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
> > +			goto unlock;
> > +		}
> > +
> > +		data_count =3D i2c_smbus_read_byte_data(data->client,
> > +						      MAX30208_FIFO_DATA_CNTR);
> > +		if (data_count < 0) {
> > +			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n"=
);
> > +			ret =3D data_count; =20
>=20
> Flip this around so you consistently use ret for return values.  We still=
 have problem that data_count is a u8 so the above test is invalid.
>=20
> 		ret =3D i2c_smbus_read_byte_data(data->client, ...)
> 		if (ret < 0) {
> 			dev_err(..);
> 			goto unlock
> 		}
> 		data_count =3D ret;
>=20
> Guenter pointed this out in v5.
>=20
> > +			goto unlock;
> > +		}
> > +	}
> > +
> > +unlock:
> > +	mutex_unlock(&data->lock);
> > +	return ret;
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
> > +		*val =3D 5;
> > +		return IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int max30208_gpio_setup(struct max30208_data *data) {
> > +	u8 regval;
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client,
> > +				       MAX30208_GPIO_SETUP); =20
>=20
> Excessive line breaks.  This is under 80 chars.  In cases where readabili=
ty is helped by going above that (though under 100 chars) that is fine too.=
  Make sure you tidy up all similar cases.
>=20
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error reading reg GPIO setup\n");
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Setting GPIO1 to trigger temperature conversion
> > +	 * when driven low.
> > +	 * Setting GPIO0 to trigger interrupt when temperature
> > +	 * conversion gets completed.
> > +	 */
> > +	regval =3D ret | MAX30208_GPIO1_SETUP | MAX30208_GPIO0_SETUP; =20
>=20
> If the driver 'works' in current form without setting this stuff up I wou=
ld prefer that you leave this until you have a patch actually using the GPI=
O signals.
> That way we can review all the GPIO related code together.
>=20
> > +	ret =3D i2c_smbus_write_byte_data(data->client,
> > +					MAX30208_GPIO_SETUP, regval);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error writing reg GPIO setup\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D i2c_smbus_read_byte_data(data->client,
> > +				       MAX30208_INT_ENABLE);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error reading reg interrupt enable\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Enabling GPIO0 interrupt */
> > +	regval =3D ret | MAX30208_INT_ENABLE_TEMP_RDY; =20
>=20
> This belongs in a patch adding interrupt support. It should not be here u=
ntil then.
>=20
> > +	ret =3D i2c_smbus_write_byte_data(data->client,
> > +					MAX30208_INT_ENABLE, regval);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "Error writing reg interrupt enable\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
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
> > +	indio_dev->name =3D MAX30208_DRV_NAME; =20
>=20
> I'm not a huge fan of defines either here or in the driver structure init=
ializer.
> The reason being that we need clear visibility of these strings and there=
 is no particular reason why they are the same.
> So I'd prefer getting rid of that define and putting the strings directly=
 in both locations.
>=20
> > +	indio_dev->channels =3D max30208_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(max30208_channels);
> > +	indio_dev->info =3D &max30208_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	/* Reset the device initially */ =20
>=20
> The expressive nature of the field define makes it obvious this is a rese=
t.
> so I would drop the comment.  There is a price in maintainability to comm=
ents (they often become wrong over time as a driver evolves).  As such keep=
 them for places where the comment tells us something not easily seen from =
the code.
>=20
> > +	ret =3D i2c_smbus_write_byte_data(data->client, MAX30208_SYSTEM_CTRL,
> > +					MAX30208_SYSTEM_CTRL_RESET);
> > +	if (ret) {
> > +		dev_err(dev, "Failure in performing reset\n");
> > +		return ret;
> > +	}
> > +
> > +	msleep(50);
> > +
> > +	ret =3D max30208_gpio_setup(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D devm_iio_device_register(dev, indio_dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register IIO device\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id max30208_id_table[] =3D {
> > +	{ "max30208" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, max30208_id_table);
> > +
> > +static const struct acpi_device_id max30208_acpi_match[] =3D {
> > +	{ "MAX30208" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, max30208_acpi_match);
> > +
> > +static const struct of_device_id max30208_of_match[] =3D {
> > +	{ .compatible =3D "maxim,max30208" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, max30208_of_match);
> > +
> > +static struct i2c_driver max30208_driver =3D {
> > +	.driver =3D {
> > +		.name =3D MAX30208_DRV_NAME,
> > +		.of_match_table =3D max30208_of_match,
> > +		.acpi_match_table =3D ACPI_PTR(max30208_acpi_match), =20
>=20
> Try building without ACPI support and you should see a warning from the c=
ompiler.  Sadly ACPI_PTR() is not as smart as it should be.
> If interested, take a look at how pm_ptr() deals with the same issue.
>=20
> Anyhow, best option is just don't bother with ACPI_PTR().
> The saving in module size is trivial and not worth the ifdef magic needed=
 to make it work warning free.
>=20
>=20
> > +	},
> > +	.probe_new =3D max30208_probe,
> > +	.id_table =3D max30208_id_table,
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
> module_i2c_driver() to get rid of this boilerplate.
>=20
> Note this was a comment I made on v1... I wondered if I'd been half aslee=
p so went looking :)
>=20
> Jonathan
>=20

