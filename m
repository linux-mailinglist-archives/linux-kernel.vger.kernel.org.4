Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2885F8C31
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJIQLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJIQL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE03237E4;
        Sun,  9 Oct 2022 09:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD2D60B93;
        Sun,  9 Oct 2022 16:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A1DC433C1;
        Sun,  9 Oct 2022 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665331885;
        bh=d020kOTHbsoAb8tDeaW7778lCDywtCHTta6Jvpt7NzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iaj9G8Te2djB/dhGHqIYJie/86nBlqQTcMl0RYNYVtrGrakvFeEcoa95tgZ3PfZpM
         Q9YnfxEdoCgcKvWJtRXPy5b6kNsNdTRpZ72mGFA1cVx6i5cCIgPvQGnHMpycLHv7Ud
         0Ah5KPW0lFpUJ2tEBmTrFYmE6pxRJCDXxHUmDXwdgR/XVQHSitdSDGeZJnX93fxG7w
         K3BA21uOUHbrid2kZqdnogC6GbF4mFlaGAOF9pE3bGQEsTsnD1vOLYgeKMFZm1PA15
         3cWxthyAROmDtQH+nRUBSUkvQGLWxVY/ziYa3fRvxvI59e9f7nshmrHAuj/ZIsLH8e
         GUiR9uGBLJquQ==
Date:   Sun, 9 Oct 2022 17:11:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI LMP92064
 controller
Message-ID: <20221009171147.34fc1db0@jic23-huawei>
In-Reply-To: <20221004134238.3144326-2-l.goehrs@pengutronix.de>
References: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
        <20221004134238.3144326-2-l.goehrs@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue,  4 Oct 2022 15:42:38 +0200
Leonard G=C3=B6hrs <l.goehrs@pengutronix.de> wrote:

> The TI LMP92064 is a dual 12 Bit ADC connected via SPI.
> The two channels are intended for simultaneous measurements of the voltage
> across- and current through a load to allow accurate instantaneous power
> measurements.
> The driver does not yet take advantage of this feature, as buffering is n=
ot yet
> implemented.
>=20
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>

Hi Leonard,

Welcome to IIO!

Various comments inline.

It might be a good idea to also include support for supply regulators
- I'm guessing they are fixed on your board, but it's probably the most
common follow up patch for a new driver, and is very easy to deal with
from the start + ensures the bindings cover the regulators as well.

I see there are two on this device.  We can use the new
devm_regulator_get_enable() to handle those very simply.


Jonathan


> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1772a549a3c80..10a9c1d470336 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -109,6 +109,7 @@ obj-$(CONFIG_TI_ADS8688) +=3D ti-ads8688.o
>  obj-$(CONFIG_TI_ADS124S08) +=3D ti-ads124s08.o
>  obj-$(CONFIG_TI_ADS131E08) +=3D ti-ads131e08.o
>  obj-$(CONFIG_TI_AM335X_ADC) +=3D ti_am335x_adc.o
> +obj-$(CONFIG_TI_LMP92064) +=3D ti-lmp92064.o
>  obj-$(CONFIG_TI_TLC4541) +=3D ti-tlc4541.o
>  obj-$(CONFIG_TI_TSC2046) +=3D ti-tsc2046.o
>  obj-$(CONFIG_TWL4030_MADC) +=3D twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
> new file mode 100644
> index 0000000000000..b70193fc2c841
> --- /dev/null
> +++ b/drivers/iio/adc/ti-lmp92064.c
> @@ -0,0 +1,317 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments LMP92064 SPI ADC driver
> + *
> + * Copyright (c) 2022 Leonard G=C3=B6hrs <kernel@pengutronix.de>, Pengut=
ronix
> + *
> + * Based on linux/drivers/iio/adc/ti-tsc2046.c
> + * Copyright (c) 2021 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +
> +#define TI_LMP92064_NAME "lmp92064"
> +
> +#define TI_LMP92064_CMD_READ BIT(15)
> +#define TI_LMP92064_CMD_WRITE 0
> +
> +#define TI_LMP92064_REG_CONFIG_A 0x0000
> +#define TI_LMP92064_REG_CONFIG_B 0x0001
> +#define TI_LMP92064_REG_STATUS 0x0103
> +
> +#define TI_LMP92064_REG_DATA_VOUT_LSB 0x0200
> +#define TI_LMP92064_REG_DATA_VOUT_MSB 0x0201
> +#define TI_LMP92064_REG_DATA_COUT_LSB 0x0202
> +#define TI_LMP92064_REG_DATA_COUT_MSB 0x0203
> +
> +#define TI_LMP92064_VAL_CONFIG_A 0x99
> +#define TI_LMP92064_VAL_CONFIG_B 0x00
> +#define TI_LMP92064_VAL_STATUS_OK 0x01
> +
> +#define TI_LMP92064_CHAN_INC 0
> +#define TI_LMP92064_CHAN_INV 1
> +
> +struct lmp92064_adc_priv {
> +	struct spi_device *spi;
> +	int shunt_resistor;
> +};
> +
> +static const struct iio_chan_spec lmp92064_adc_channels[] =3D {
> +	{
> +		.type =3D IIO_CURRENT,
> +		.address =3D TI_LMP92064_CHAN_INC,
> +		.info_mask_separate =3D
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.datasheet_name =3D "INC",
> +	},
> +	{
> +		.type =3D IIO_VOLTAGE,
> +		.address =3D TI_LMP92064_CHAN_INV,
> +		.info_mask_separate =3D
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.datasheet_name =3D "INV",
> +	},
> +};
> +
> +static int lmp92064_write_reg(struct lmp92064_adc_priv *priv, u16 reg, u=
8 val)
> +{
> +	u16 cmd =3D TI_LMP92064_CMD_WRITE | reg;
> +	int ret;
> +	u8 __aligned(IIO_DMA_MINALIGN) tx_buf[3];

Not DMA safe - see below.  As this isn't typically a hot path, a simple sol=
ution
is to use spi_write_then_read() with no read.

> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D tx_buf,
> +		.rx_buf =3D NULL,
> +		.len =3D 3,
> +	};
> +
> +	tx_buf[0] =3D cmd >> 8;
> +	tx_buf[1] =3D cmd & 0xff;
> +	tx_buf[2] =3D val;
> +
> +	ret =3D spi_sync_transfer(priv->spi, &xfer, 1);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "spi_sync_transfer failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lmp92064_read_reg(struct lmp92064_adc_priv *priv, u16 reg, u8=
 *val)
> +{
> +	u16 cmd =3D TI_LMP92064_CMD_READ | reg;
> +	int ret;
> +	u8 __aligned(IIO_DMA_MINALIGN) tx_buf[3] =3D { 0 };
> +	u8 __aligned(IIO_DMA_MINALIGN) rx_buf[3] =3D { 0 };
> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D tx_buf,
> +		.rx_buf =3D rx_buf,
> +		.len =3D 3,
> +	};
> +
> +	tx_buf[0] =3D cmd >> 8;
> +	tx_buf[1] =3D cmd & 0xff;
Similar comments to below.
Use spi_write_then_read() and appropriate types + endian conversions.

> +
> +	ret =3D spi_sync_transfer(priv->spi, &xfer, 1);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "spi_sync_transfer failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	*val =3D rx_buf[2];
> +
> +	return 0;
> +}
> +
> +static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, int *cout,
> +			      int *vout)
> +{
> +	/*
> +         * The ADC only latches in new samples if all DATA registers are=
 read
> +         * in descending sequential order.
> +         * The ADC auto-decrements the register index with each clocked =
byte.
> +         * Read both channels in single SPI transfer by selecting the hi=
ghest
> +         * register using the command below and clocking out all four da=
ta
> +         * bytes.
> +         */
> +	u16 cmd =3D TI_LMP92064_CMD_READ | TI_LMP92064_REG_DATA_COUT_MSB;
> +	u8 __aligned(IIO_DMA_MINALIGN) tx_buf[6] =3D { 0 };
> +	u8 __aligned(IIO_DMA_MINALIGN) rx_buf[6] =3D { 0 };

That doesn't work for DMA safety. You've ensure the start of the storage
is appropriately aligned, but you've no way (on the stack) of sensibly ensu=
ring
nothing else is in the rest of the cacheline.  That's why you'll see that
we always either:
1) Use an appropriate allocation on the heap. Their is some discussion of
   relaxing the rules around this by using a bounce buffer for small alloca=
tions
   but for now we are still sure that the smallest heap allocation is DMA s=
afe.
2) Use the fact we carefully enforce the alignment of the iio_priv() region
   so that you can put an aligned entry at the end of that.  The rules of
   c structure sizing mean that the structure is always big enough to ensure
   no problem with anything after the memory in question.

Also, this doesn't look like a bi directional transfer, but rather like
a 2 byte write followed by 4 byte read.  It would be cleaner handled
as two spi_transfers. If you have a strong performance reason to do it
this way then state it here.

Even better use spi_write_then_read() which uses bounce buffers internally =
so
doesn't need DMA safe buffers (IIRC it's documented as doing so hence we'll
always be safe relying on that behaviour)

> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D tx_buf,
> +		.rx_buf =3D rx_buf,
> +		.len =3D sizeof(tx_buf),
> +	};
> +	int ret;
> +
> +	tx_buf[0] =3D cmd >> 8;
> +	tx_buf[1] =3D cmd & 0xff;

	cpu_to_be16()  Even better, just make tx_buf __be16[3]=20

> +
> +	ret =3D spi_sync_transfer(priv->spi, &xfer, 1);
> +	if (ret < 0) {
> +		dev_err(&priv->spi->dev, "spi_sync_transfer failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	if (cout)
> +		*cout =3D (rx_buf[2] << 8) | (rx_buf[3]);

be16_to_cpu()?  Better yet make rx_buf a __be16 array.

> +
> +	if (vout)
> +		*vout =3D (rx_buf[4] << 8) | (rx_buf[5]);
> +
As you have to read both anyway, I'd be tempted to make the 'selection'
of which channel to return a job for the caller.

Pass a 2 element array in here and always set both. At the caller, just pick
the one you want to use.

> +	return 0;
> +}
> +
> +static int lmp92064_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct lmp92064_adc_priv *priv =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);

Don't use mlock for a driver specific purpose. It's been documented
that you shouldn't do that for years and we are finally getting rid
of the last few cases that predate that documentation!

This patch set will probably go in after those anyway so this wouldn't
even work as we'll have hidden mlock away in an opaque structure.

If you need a lock, create one locally in iio_priv() and clearly document
what it is protecting.

> +		if (chan->address =3D=3D TI_LMP92064_CHAN_INC)
> +			ret =3D lmp92064_read_meas(priv, val, NULL);
> +		else
> +			ret =3D lmp92064_read_meas(priv, NULL, val);
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->address =3D=3D TI_LMP92064_CHAN_INC) {
> +			/*
> +                         * processed (mA) =3D raw * current_lsb (mA)
> +                         * current_lsb (mA) =3D shunt_voltage_lsb (nV) /=
 shunt_resistor (uOhm)
> +                         * shunt_voltage_lsb (nV) =3D 81920000 / 4096 =
=3D 20000
> +                         */
> +			*val =3D 20000;
> +			*val2 =3D priv->shunt_resistor;
> +		} else {
> +			/*
> +                         * processed (mV) =3D raw * voltage_lsb (mV)
> +                         * voltage_lsb (mV) =3D 2048 / 4096
> +                         */
> +			*val =3D 2048;
> +			*val2 =3D 4096;
> +		}
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int lmp92064_reset(struct lmp92064_adc_priv *priv,
> +			  struct gpio_desc *gpio_reset)
> +{
> +	u8 status;
> +	int ret, i;
> +
> +	/* Perform a hard reset if possible */
> +	if (gpio_reset) {
> +		gpiod_set_value_cansleep(gpio_reset, 1);
> +		usleep_range(1, 10);
> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		usleep_range(500, 750);
> +	}
> +
> +	/* Perform a soft-reset and write default values to config registers
> +         * that are not affected by soft reset */

Why do this if a hard reset occurred + fix comment syntax.

> +	ret =3D lmp92064_write_reg(priv, TI_LMP92064_REG_CONFIG_A,
> +				 TI_LMP92064_VAL_CONFIG_A);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D lmp92064_write_reg(priv, TI_LMP92064_REG_CONFIG_B,
> +				 TI_LMP92064_VAL_CONFIG_B);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait for the device to signal readiness */
> +	for (i =3D 0; i < 10; i++) {
> +		ret =3D lmp92064_read_reg(priv, TI_LMP92064_REG_STATUS, &status);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		if (status =3D=3D TI_LMP92064_VAL_STATUS_OK)
> +			return 0;
> +
> +		usleep_range(1000, 2000);
> +	}
> +
> +	return -EBUSY;

Probably use a return value that indicates a timeout.  EBUSY tends to imply=
 that
it won't be busy for ever, whereas this probably will fail for ever if it f=
ails
initially.

> +}
> +
> +static const struct iio_info lmp92064_adc_info =3D {
> +	.read_raw =3D lmp92064_read_raw,
> +};
> +
> +static int lmp92064_adc_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct lmp92064_adc_priv *priv;
> +	struct iio_dev *indio_dev;
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +	u32 shunt_resistor;

If no other reason for ordering, reverse xmas tree preferred (just
have a rule, rather than because that one particularly makes sense!)


> +
> +	spi->bits_per_word =3D 8;
> +	spi->mode &=3D ~SPI_MODE_X_MASK;
> +	spi->mode |=3D SPI_MODE_0;

That is normally controlled by device tree or similar because there might w=
ell
be inverters in the path (sometimes used as cheap level converters)
Overriding the provided mode is definitely not a good thing to do!

> +	ret =3D spi_setup(spi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Error in SPI setup\n");
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv =3D iio_priv(indio_dev);
> +
> +	priv->spi =3D spi;
> +
> +	ret =3D of_property_read_u32(dev->of_node, "shunt-resistor",
> +				   &shunt_resistor);

Other reviews already covered both that this isn't a standard dt binding
(no units) and you should use generic firmware property reading rather than
device tree specific as it will allow other forms of firmware such as ACPI
via PRP0001 to be used to instantiate this driver.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get shunt-resistor value\n");
> +
> +	/* The shunt resistance is passed to userspace as the denominator of an=
 iio
> +	 * fraction. Make sure it is in range for that. */

Already covered in other reviews, but please use the
/*=20
 * Multiple lines...
 */
syntax used in most of the kernel (and definitely in IIO).

> +	if (shunt_resistor <=3D 0 || shunt_resistor > INT_MAX) {

Can't be < 0 as u32.


> +		dev_err(dev, "Shunt resistance is out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->shunt_resistor =3D shunt_resistor;
> +
> +	gpio_reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio_reset))
> +		return dev_err_probe(dev, PTR_ERR(gpio_reset),
> +				     "Failed to get GPIO reset pin\n");
> +
> +	ret =3D lmp92064_reset(priv, gpio_reset);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	indio_dev->name =3D TI_LMP92064_NAME;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D lmp92064_adc_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(lmp92064_adc_channels);
> +	indio_dev->info =3D &lmp92064_adc_info;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id lmp92064_of_table[] =3D {
> +	{ .compatible =3D "ti,lmp92064" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, lmp92064_of_table);

Also provide an spi_device_id table... See
Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT compat=
ible")
for one reason why we still need to do that.

> +
> +static struct spi_driver lmp92064_adc_driver =3D {
> +	.driver =3D {
> +		.name =3D "lmp92064",
> +		.of_match_table =3D lmp92064_of_table,
> +	},
> +	.probe =3D lmp92064_adc_probe,
> +};
> +module_spi_driver(lmp92064_adc_driver);
> +
> +MODULE_AUTHOR("Leonard G=C3=B6hrs <kernel@pengutronix.de>");
> +MODULE_DESCRIPTION("TI LMP92064 ADC");
> +MODULE_LICENSE("GPL v2");

