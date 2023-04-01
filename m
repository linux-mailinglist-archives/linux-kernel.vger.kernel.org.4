Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079726D32F0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDARmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjDARmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22F1B368;
        Sat,  1 Apr 2023 10:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E68C260F63;
        Sat,  1 Apr 2023 17:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BD5C433EF;
        Sat,  1 Apr 2023 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680370929;
        bh=z0VFG6Ws2aYAM5y6tzELVrlDDBkMYDPV12bcG3YBI4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U08a+49CvP12+U9Ah/XPqKp5cRty0xuDqe6dIIBr+jlwm+aC7PH/qLJLyEfijsG+F
         NSY9PPnQ+GLYvf0phv5UztV0+ErsiQmHHkg453GoymPDmFjRvxmFoA2joFQ3DKePT8
         sH5d8mxAnDox/ItVdaaCMO03VOOxBfQiAkrKNFUtT6V+JqtSCF49As2PR8UMIzye0G
         OC0OaOTRRaNThL8U8GZEhPAqLrb1Cxgp5xBFkZH5/uuNC8MMeo24jwmOiJOKXzcjOq
         WJnqmjIBHEmOejJwFe0jTYOorg4s9ISgCcNVrSjgh/IBFDmxuCPr2V7SNkLqOi+/yS
         7JcsIuKryOkeA==
Date:   Sat, 1 Apr 2023 18:57:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Message-ID: <20230401185717.1b971617@jic23-huawei>
In-Reply-To: <ZCf085W4XL2PtQf6@arbad>
References: <ZCf085W4XL2PtQf6@arbad>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2023 11:10:11 +0200
Andreas Klinger <ak@it-klinger.de> wrote:
Hi Andreas,

Various comments inline.

> Honeywell mpr is a familiy of pressure sensors.

Spell check.

>=20
> Add initial I2C support.
>=20
> Note:
> - Buffered mode is supported
> - SPI mode is not supported
>=20
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/pressure/Kconfig  |  12 ++
>  drivers/iio/pressure/Makefile |   1 +
>  drivers/iio/pressure/mpr.c    | 307 ++++++++++++++++++++++++++++++++++
>  3 files changed, 320 insertions(+)
>  create mode 100644 drivers/iio/pressure/mpr.c
>=20
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index c9453389e4f7..e3ec94036e3c 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -148,6 +148,18 @@ config MPL3115
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mpl3115.
> =20
> +config MPR
> +	tristate "Honeywell MPR (MicroPressure sensors)"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the Honeywell MicroPressure pressure =
sensors MPR.
> +	  There are many different types with different pressure range. These r=
anges can be set up
> +	  in the device tree.
> +
> +	  To compile this driver as a module, choose M here: the module will be=
 called mpr.
> +
>  config MS5611
>  	tristate "Measurement Specialties MS5611 pressure sensor driver"
>  	select IIO_BUFFER
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 083ae87ff48f..b701d9c7187d 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_MPL115) +=3D mpl115.o
>  obj-$(CONFIG_MPL115_I2C) +=3D mpl115_i2c.o
>  obj-$(CONFIG_MPL115_SPI) +=3D mpl115_spi.o
>  obj-$(CONFIG_MPL3115) +=3D mpl3115.o
> +obj-$(CONFIG_MPR) +=3D mpr.o
>  obj-$(CONFIG_MS5611) +=3D ms5611_core.o
>  obj-$(CONFIG_MS5611_I2C) +=3D ms5611_i2c.o
>  obj-$(CONFIG_MS5611_SPI) +=3D ms5611_spi.o
> diff --git a/drivers/iio/pressure/mpr.c b/drivers/iio/pressure/mpr.c
> new file mode 100644
> index 000000000000..1728b42bee7e
> --- /dev/null
> +++ b/drivers/iio/pressure/mpr.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MPR - MicroPressure pressure sensor driver
> + *
> + * Copyright (c) Andreas Klinger <ak@it-klinger.de>
> + *
> + * Data sheet:
> + *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/=
en-us/products/sensors/  \
> + *    pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-se=
ries/documents/          \
> + *    sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
> + *
> + * 7-bit I2C default slave address: 0x18
> + *
Trivial but this blank line doesn't add anything useful to my eye
> + */
> +
> +#include <linux/of.h>
As below, should use stuff in linux/property.h not of.h

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Not seeing any custom attributes (which is pretty much only reason you'd
need iio/sysfs.h)

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +/* bits in i2c status byte */
> +#define MPR_I2C_POWER	BIT(6)	/* device is powered */
> +#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
> +#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
> +#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
> +
> +struct mpr_data {
> +	struct device		*dev;

Given it's easy to get this dev from client->dev, don't bother holding
both in here.

> +	void			*client;
> +	struct mutex		lock;

All locks should have a comment saying what exactly they protect.

> +	s32			pmin;
> +	s32			pmax;
> +	struct gpio_desc	*gpiod_reset;
> +	int			irq;
> +	struct completion	completion;
> +	s64			channel[2] __aligned(8);

Why?  Good to call out the explicit purpose of this.  Usually easiest
option is to use a structure where you can call out the two elements
with names that tell reader what is going on.


> +};
> +
> +static int mpr_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec =
const *chan, int *val,
> +									int *val2, long mask);

Should be possible to reorder code so this isn't needed.

> +
> +static const struct iio_chan_spec mpr_channels[] =3D {
> +	{
> +		.type =3D IIO_PRESSURE,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +		.scan_index =3D 0,
> +		.scan_type =3D {
> +			.sign =3D 's',
> +			.realbits =3D 64,
> +			.storagebits =3D 64,
> +			.endianness =3D IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),

> +};
> +
> +static const struct iio_info mpr_info =3D {
> +	.read_raw =3D &mpr_read_raw,
> +};
> +
> +static void mpr_reset(struct mpr_data *data)
> +{
> +	if (data->gpiod_reset) {
> +		gpiod_set_value(data->gpiod_reset, 0);
> +		udelay(10);
> +		gpiod_set_value(data->gpiod_reset, 1);
> +	}

If there isn't a reset signal, I'd like to see an attempt at least to write
all configuration registers to a known value (same as the one you'd
get after reset). =20

> +}
> +
> +static int mpr_read_pressure(struct mpr_data *data, s64 *press)
> +{
> +	int ret, i;
> +	u8 wdata[] =3D {0xAA, 0x00, 0x00};
> +	s32 status;
> +	int nloops =3D 10;
> +	char buf[5];
> +	s64 press_cnt;
> +	s64 outputmin =3D 1677722;
> +	s64 outputmax =3D 15099494;
> +
> +	reinit_completion(&data->completion);
> +
> +	ret =3D i2c_master_send(data->client, wdata, sizeof(wdata));
> +	if (ret < 0) {
> +		dev_err(data->dev, "error while writing ret: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (data->irq > 0) {
> +		ret =3D wait_for_completion_timeout(&data->completion, HZ);
> +		if (!ret) {
> +			dev_err(data->dev, "timeout while waiting for eoc interrupt\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		/* wait until status indicates data is ready */
> +		for (i =3D 0; i < nloops; i++) {
> +			usleep_range(5000, 10000);

Add a comment on why this particular timing makes sense (reference to datas=
heet probably)

> +			status =3D i2c_smbus_read_byte(data->client);
> +			if (status < 0) {
> +				dev_err(data->dev, "error while reading, status: %d\n", status);
> +				return status;
> +			}
> +			if (!(status & MPR_I2C_BUSY))
> +				break;
> +		}
> +		if (i =3D=3D nloops) {
> +			dev_err(data->dev, "timeout while reading\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	ret =3D i2c_master_recv(data->client, buf, sizeof(buf));
> +	if (ret < 0) {
> +		dev_err(data->dev, "error in i2c_master_recv ret: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (buf[0] & MPR_I2C_BUSY) {
> +		/* it should never be the case that status still indicates business */
> +		dev_err(data->dev, "data still not ready: %08x\n", buf[0]);
> +		return -ETIMEDOUT;
> +	}
> +
> +	press_cnt =3D buf[3] + buf[2] * 256 + buf[1] * 65536;

Looks like a get_unaligned_le24() open coded?  Use the standard function for
this as that makes it easier to see what is going on.

> +
> +	*press =3D ((press_cnt - outputmin) * (s64)(data->pmax - data->pmin))
> +					/ (outputmax - outputmin) + (s64)data->pmin;

Some defines for the value of outputmin and outputmax would be better than
using local variables that happen to be constant.

Looks to me like this could be broken into=20
(raw + offset) * scale in which case you could use a _RAW interface with _O=
FFSET and
_SCALE allow you to make this into a 24 bit (well 32 bit) slot of a buffer =
should
you add buffered support later.


> +
> +	dev_dbg(data->dev, "received: %*ph cnt: %lld press: %lld\n", ret, buf, =
press_cnt, *press);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t mpr_eoc_handler(int irq, void *p)
> +{
> +	struct mpr_data *data =3D (struct mpr_data *)p;
> +
> +	complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mpr_trigger_handler(int irq, void *p)
> +{
> +	int ret;
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct mpr_data *data =3D iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +	ret =3D mpr_read_pressure(data, &data->channel[0]);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		goto err;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->channel, iio_get_ti=
me_ns(indio_dev));
> +	mutex_unlock(&data->lock);
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mpr_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec =
const *chan, int *val,
> +									int *val2, long mask)
> +{
> +	int ret;
> +	s64 pressure;
> +	struct mpr_data *data =3D iio_priv(indio_dev);
> +
> +	if (mask =3D=3D IIO_CHAN_INFO_PROCESSED) {

Given you only support one option neater to error out early if it's not a m=
atch even if you
have two do that twice.

	if (mask !=3D IIO_CHAN_INFO_PROCESSED)
		return -EINVAL;


> +		mutex_lock(&data->lock);
> +		ret =3D mpr_read_pressure(data, &pressure);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (chan->type =3D=3D IIO_PRESSURE) {

Check that earlier. Not a lot of point in reading the data if channel type
is wrong.

> +			*val =3D (s32)clamp(pressure, 0LL, 2147483648LL);

What is special about that constant?  If it's a device specific value then
given it a name.

> +			return IIO_VAL_INT;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mpr_probe(struct i2c_client *client, const struct i2c_device_=
id *id)
> +{
> +	int ret;
> +	struct mpr_data *data;
> +	struct iio_dev *indio_dev;
> +	struct device *dev =3D &client->dev;
> +	struct device_node *np =3D dev->of_node;

As below, switch to non of specific firmware handlign.

> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_BYTE))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->dev =3D &client->dev;
> +	i2c_set_clientdata(client, indio_dev);

I can't see where this is used.

> +	data->client =3D client;
> +	data->irq =3D client->irq;
> +
> +	mutex_init(&data->lock);
> +	init_completion(&data->completion);
> +
> +	indio_dev->name =3D client->name;

Should be part number.  As a string provided here (or more likely in a
device type specific structure that you are going to add).

> +	indio_dev->info =3D &mpr_info;
> +	indio_dev->channels =3D mpr_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(mpr_channels);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	if (np) {

Don't use of specific interfaces.  Use the ones from linux/property.h inste=
ad.
Lets other firmware types work 'for free' so we are trying to avoid introdu=
cing
any of specific handling into new IIO drivers (and slowly scrubbing the old=
 ones
for this)=C2=B7

if (dev_fwnode()) etc


> +		if (of_property_read_s32(np, "honeywell,pmin", &data->pmin)) {

all these need to converting to the device_property_xxx equivalents.

> +			dev_err(dev, "honeywell,pmin missing in DT\n");
> +			return -EINVAL;
> +		}
> +		if (of_property_read_s32(np, "honeywell,pmax", &data->pmax)) {
> +			dev_err(dev, "honeywell,pmax missing in DT\n");
> +			return -EINVAL;
> +		}
> +
> +		data->gpiod_reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

Whilst these are sort of fw node dependent they don't need the protection.
So drop them out of this if (np) block.

devm_gpiod_get_optional() given you support not having it.


> +		if (IS_ERR(data->gpiod_reset)) {
> +			dev_err(dev, "failed to get reset-gpios: err=3D%pe\n",
> +								data->gpiod_reset);

Not an error so dev_dbg() probably right thing to report.

> +			data->gpiod_reset =3D NULL;
> +		}
> +
> +		if (data->irq > 0) {
> +			ret =3D devm_request_irq(dev, data->irq, mpr_eoc_handler,
> +							IRQF_TRIGGER_RISING, client->name, data);
> +			if (ret) {
> +				dev_err(dev, "request irq %d failed\n", data->irq);
> +				return ret;
> +			}
> +		}
> +	} else {
> +		/* when loaded as i2c device we need to use default values */
> +		dev_warn(dev, "no dt node found; using defaults\n");

A strong argument in favour of not handling all devices via one 'compatible'
(or the the i2c_device_id version of that anyway).

> +		data->pmin =3D 0;
> +		data->pmax =3D 172369; /* 25 psi */

Perhaps worth defining the maths for that conversion so that you can just u=
se

	psi_to_milibar(25); or whatever makes sense.

> +		data->gpiod_reset =3D NULL;

Should be no need to set that as it will be NULL anyway in this path.

> +	}
> +
> +	mpr_reset(data);
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, mpr_trigg=
er_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to register iio device\n");

In general use
		return dev_err_probe(dev, ret, ...)
for all errors that only occur on probe.  That wraps up some stuff around
deferred probing but is in general a good thing to do even if a given
call can't defer.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mpr_matches[] =3D {
> +	{ .compatible =3D "honeywell,mpr", .data =3D 0 },

No point in filling data either here or in the i2c_device_id
entries until something useful is done with it.
When you do (which is likely after request to use compatibles
to indicate a lot of the per device type variability) then you should look
for having the data as a pointer to a const structure that describes what t=
hose
per device type details.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mpr_matches);
> +
> +static const struct i2c_device_id mpr_id[] =3D {
> +	{ "honeywell,mpr", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mpr_id);
> +
> +static struct i2c_driver mpr_driver =3D {
> +	.probe =3D mpr_probe,
> +	.id_table =3D mpr_id,
> +	.driver =3D {
> +		.name =3D "mpr",
> +		.of_match_table =3D mpr_matches,
> +	},
> +};
> +module_i2c_driver(mpr_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("MPR I2C driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_MPR);

Why?  You aren't exporting any symbols in that namespace that I can see.


