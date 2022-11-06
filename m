Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860DE61E2E2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKFPPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFPPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:15:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E9DECF;
        Sun,  6 Nov 2022 07:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02605CE0A37;
        Sun,  6 Nov 2022 15:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127E7C433D6;
        Sun,  6 Nov 2022 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667747713;
        bh=YmanpNjIwv4WV1HtfdJP52uiRxZpFufwWeMXTJaWbIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D08T5WMcq36L9HbGexgiLOhI9pj6lLTvZdUfi3KkYV6gZXUMyFxsUwu7jzlxzWnG6
         5omf5UtPmq8FdUwuw9iaxVpA7P5mVugIaWmvUP1ohu2AeVf7gzC4UH51vd6WRAPYSb
         bH91RaDC6m3d1ysdQk4ZG7sGBvVXrS5f7ZENsl3/NOMBXWALUx3jj/JVKPeCkI8epc
         J0aNJOQPtmo8Qr/h1LOQE0arp+wZWxgg8vfTjW/XFZg6u1+pQ+BcCfzs5o8Z099GiZ
         WLcyZyr1gQnd3XAfJHC53GXwN6qxHPbll94OtYfwysUlqLnmvkfsLG3xQCf0CEJdWO
         mAmkVOSrC5DXw==
Date:   Sun, 6 Nov 2022 15:15:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add ADC driver for the TI LMP92064
 controller
Message-ID: <20221106151503.57bc924b@jic23-huawei>
In-Reply-To: <20221101064804.720050-2-l.goehrs@pengutronix.de>
References: <20221101064804.720050-1-l.goehrs@pengutronix.de>
        <20221101064804.720050-2-l.goehrs@pengutronix.de>
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

On Tue,  1 Nov 2022 07:48:04 +0100
Leonard G=C3=B6hrs <l.goehrs@pengutronix.de> wrote:

> The TI LMP92064 is a dual 12 Bit ADC connected via SPI.
> The two channels are intended for simultaneous measurements of the voltage
> across- and current through a load to allow accurate instantaneous power
> measurements.
> The driver does not yet take advantage of this feature, as buffering is n=
ot
> yet implemented.
>=20
> Changes from v1 -> v2:

Hi Leonard,

As with the previous patch, please move the change logs below the ---

>=20
>  - Rebase from 6.0 to 6.1-rc2 to get access to devm_regulator_get_enable.
>  - Use regmap instead of raw SPI commands.
>    This fixes multiple issues in the v1:
>    - Remove need to assemble register address using bit shifts.
>    - Remove non DMA-safe stack-allocated buffers.
>    - Regmap has internal lock handling, removing the need for locking in =
the
>      driver read code using mlock.
>  - Use be16_to_cpu() instead of manually assembling values using bit shif=
ts.
>  - Use generic device_property_read_u32() instead of devicetree specific
>    of_property_read_u32().
>  - Rename the "shunt-resistor" device property to "shunt-resistor-micro-o=
hms".
>  - Add supply regulator support for the two voltage domains of the chip
>    (vdd and vdig).
>  - Only perform soft reset if no GPIO line for hard resets is available.
>  - Change the error returned if the device does not respond after a reset
>    from "EBUSY" to "ENXIO" to indicate that this is likely a persistent
>    error (like a broken connection).
>  - Don't set the SPI mode manually.
>  - Provide a spi_device_id table.
>  - Declare local variables in reverse christmas tree order.
>  - Fix formatting of multi-line comments and some whitespace issues.
>=20
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> ---
If you weren't going to need to do a v3 anyway for the DT binding, I'd
probably just have fixed up the comments inline and applied it.
Ah well, will be easy to pick up as v3!  We have a few more weeks this
cycle, so hopefully you can do a quick update in next week or so.

Some of the comments are more for reference (probably by me)
a later date than suggestions for changes.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
> new file mode 100644
> index 000000000000..0e49e0c2c9db
> --- /dev/null
> +++ b/drivers/iio/adc/ti-lmp92064.c
> @@ -0,0 +1,316 @@

> +
> +#define TI_LMP92064_CHAN_INC 0
> +#define TI_LMP92064_CHAN_INV 1

These abbreviations are a bit unfortunate as INC commonly means increment
and INV commonly means invert. Still they are used on the datasheet so
perhaps better to leave them as you have it.

> +
> +static int lmp92064_read_meas(struct lmp92064_adc_priv *priv, u16 *res)
> +{
> +	__be16 raw[2];
> +	int ret;
> +
> +	/*
> +	 * The ADC only latches in new samples if all DATA registers are read
> +	 * in descending sequential order.
> +	 * The ADC auto-decrements the register index with each clocked byte.
> +	 * Read both channels in single SPI transfer by selecting the highest
> +	 * register using the command below and clocking out all four data
> +	 * bytes.
> +	 */
> +
> +	ret =3D regmap_bulk_read(priv->regmap, TI_LMP92064_REG_DATA_COUT_MSB,
> +			 &raw, sizeof(raw));

Hmm. I've been a bit overly strict on this in the past.
The underlying SPI bus bulk accessors require DMA safe buffers - but the
reads are actually done use spi_write_then_read() which bounce buffers.
There is the added complication that regmap actually bounced everything
for other reasons at the moment but might not do so in future (fairly sure
it didn't a while back).  Anyhow upshot is this is (I think) fine but you'll
see me fairly recently commenting on need for DMA safe buffers for
regmap_bulk_reads(). Going forwards I'll probably only raise this for
bulk writes.

> +
> +	if (ret) {
> +		dev_err(&priv->spi->dev, "regmap_bulk_read failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	res[0] =3D be16_to_cpu(raw[0]);
> +	res[1] =3D be16_to_cpu(raw[1]);
> +
> +	return 0;
> +}
> +
> +static int lmp92064_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct lmp92064_adc_priv *priv =3D iio_priv(indio_dev);
> +	u16 raw[2];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D lmp92064_read_meas(priv, raw);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D (chan->address =3D=3D TI_LMP92064_CHAN_INC) ? raw[0] : raw[1];
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->address =3D=3D TI_LMP92064_CHAN_INC) {
> +			/*
> +			 * processed (mA) =3D raw * current_lsb (mA)
> +			 * current_lsb (mA) =3D shunt_voltage_lsb (nV) / shunt_resistor (uOhm)
> +			 * shunt_voltage_lsb (nV) =3D 81920000 / 4096 =3D 20000
> +			 */
> +			*val =3D 20000;
> +			*val2 =3D priv->shunt_resistor_uohm;
> +		} else {
> +			/*
> +			 *  processed (mV) =3D raw * voltage_lsb (mV)

Extra space before processed?

> +			 * voltage_lsb (mV) =3D 2048 / 4096
> +			 */
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
> +	unsigned int status;
> +	int ret, i;
> +
> +	if (gpio_reset) {
> +		/* Perform a hard reset if gpio_reset is available */
> +		gpiod_set_value_cansleep(gpio_reset, 1);
> +		usleep_range(1, 10);
> +		gpiod_set_value_cansleep(gpio_reset, 0);
> +		usleep_range(500, 750);
> +	} else {
> +		/*
> +		 * Perform a soft-reset if not.
> +		 * Also write default values to config registers that are not
> +		 * affected by soft reset
> +		 */
> +		ret =3D regmap_write(priv->regmap, TI_LMP92064_REG_CONFIG_A,
> +				   TI_LMP92064_VAL_CONFIG_A);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D regmap_write(priv->regmap, TI_LMP92064_REG_CONFIG_B,
> +				   TI_LMP92064_VAL_CONFIG_B);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Wait for the device to signal readiness */

Good to add a comment here on why these particular time parameters.
At minimum say how long the reset is documented to take.

> +	for (i =3D 0; i < 10; i++) {
> +		ret =3D regmap_read(priv->regmap, TI_LMP92064_REG_STATUS, &status);
> +

For style consistency no blank line here (to keep the error handler and fun=
ction
call visually in one block.

> +		if (ret < 0)
> +			return ret;
> +
> +		if (status =3D=3D TI_LMP92064_VAL_STATUS_OK)
> +			return 0;
> +
> +		usleep_range(1000, 2000);
> +	}
> +
> +	/*
> +	 * No (correct) response received.
> +	 * Device is mostly likely not connected to the bus.
> +	 */
> +	return -ENXIO;
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
> +	struct gpio_desc *gpio_reset;
> +	struct iio_dev *indio_dev;
> +	u32 shunt_resistor_uohm;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret =3D spi_setup(spi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Error in SPI setup\n");
> +
> +	regmap =3D devm_regmap_init_spi(spi, &lmp92064_spi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to set up SPI regmap\n");
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv =3D iio_priv(indio_dev);
> +
> +	priv->spi =3D spi;
> +	priv->regmap =3D regmap;
> +
> +	ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				       &shunt_resistor_uohm);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get shunt-resistor value\n");
> +
> +	/*
> +	 * The shunt resistance is passed to userspace as the denominator of an=
 iio
> +	 * fraction. Make sure it is in range for that.
> +	 */
> +	if (shunt_resistor_uohm =3D=3D 0 || shunt_resistor_uohm > INT_MAX) {
> +		dev_err(dev, "Shunt resistance is out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->shunt_resistor_uohm =3D shunt_resistor_uohm;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdig");
> +	if (ret)
> +		return ret;
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
> +	indio_dev->name =3D "lmp92064";
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D lmp92064_adc_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(lmp92064_adc_channels);
> +	indio_dev->info =3D &lmp92064_adc_info;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id lmp92064_id_table[] =3D {
> +	{ "lmp92064", 0 },

I would not set the data until you need it (i.e. when adding support for ot=
her
parts.  Setting it explicitly gives the impression we are using it.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, lmp92064_id_table);
> +
> +static const struct of_device_id lmp92064_of_table[] =3D {
> +	{ .compatible =3D "ti,lmp92064" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, lmp92064_of_table);
> +
> +static struct spi_driver lmp92064_adc_driver =3D {
> +	.driver =3D {
> +		.name =3D "lmp92064",
> +		.of_match_table =3D lmp92064_of_table,
> +	},
> +	.probe =3D lmp92064_adc_probe,

Missing the id_table being set as per the 0-day bot mail.

> +};
> +module_spi_driver(lmp92064_adc_driver);
> +
> +MODULE_AUTHOR("Leonard G=C3=B6hrs <kernel@pengutronix.de>");
> +MODULE_DESCRIPTION("TI LMP92064 ADC");
> +MODULE_LICENSE("GPL");

