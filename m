Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40E95F8C78
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJIRJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJIRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865E2870D;
        Sun,  9 Oct 2022 10:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A522B60C4E;
        Sun,  9 Oct 2022 17:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F52C433C1;
        Sun,  9 Oct 2022 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665335343;
        bh=nLGuKf27m1CbKlPZX9NjCxJID1OLpqv43gMpO/mF9Y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CP6uWCr3y0q+V/Y8mI/FChUeNk1MRgMcZ/GksSFmU9bB5+r0KVKHGwKk1Fn66jEmm
         q7xK0d8hx5TTw/wDLEDRloavzfw6lLTCTrO0QVG/4u9GtBGMS4/hb4Rd19c6sEEjrI
         EbJlT4Qf6+4JmVAHDwacWYfHbbOfeD5KW/KlONgbBHqa5oq8r1mtku/ueRHrf8dRX9
         +xMcpnn1Acrrm5EpQCk/puKXIlZgI6vITQN/K80xEoN8EVC8ga5CNmpo7lCcjBPw78
         oBL2bj+HJ3LjiFY85JH0zljlhu5t5tNiq9sEE7aH3HfQp//WKZISgQheiSGIAXUbQu
         kF9EMua4Fm8LQ==
Date:   Sun, 9 Oct 2022 18:09:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] drivers: iio: dac: Add AD5754 DAC driver
Message-ID: <20221009180925.441795c0@jic23-huawei>
In-Reply-To: <20221004071825.791307-3-ciprian.regus@analog.com>
References: <20221004071825.791307-1-ciprian.regus@analog.com>
        <20221004071825.791307-3-ciprian.regus@analog.com>
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

On Tue, 4 Oct 2022 10:18:25 +0300
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial
> input, voltage output DACs. The devices operate from single-
> supply voltages from +4.5 V up to +16.5 V or dual-supply
> voltages from =C2=B14.5 V up to =C2=B116.5 V. The input coding is
> user-selectable twos complement or offset binary for a bipolar
> output (depending on the state of Pin BIN/2sComp), and straight
> binary for a unipolar output.
>=20
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD5724_5734_5754.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad5722_5732_5752.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad5724r_5734r_5754r.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD5722R_5732R_5752R.pdf
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Hi Ciprian

I'll try and avoid to much duplication of the comments of others!

> ---
>  MAINTAINERS              |   8 +
>  drivers/iio/dac/Kconfig  |  12 +
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5754.c | 668 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 689 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5754.c
>=20

> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 80521bd28d0f..013278b629f9 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -170,6 +170,18 @@ config AD5696_I2C
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad5696.
> =20
> +config AD5754
> +	tristate "Analog Devices AD5752/AD5732/AD5722/AD5754/AD5734/AD5724 DAC =
driver"

This is close to the 'and similar' boundary.  We can't keep extending names
in the menu option for ever. If you judge there to be little chance of other
parts being added to this driver thine as is.=20

> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD5752, AD5732,
> +	  AD5722, AD5754, AD5734, AD5724 dual/quad channel Digital to
> +	  Analog Converter.

What are the R parts and should we mention those?

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5754.
> +
>  config AD5755
>  	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC drive=
r"
>  	depends on SPI_MASTER

> diff --git a/drivers/iio/dac/ad5754.c b/drivers/iio/dac/ad5754.c
> new file mode 100644
> index 000000000000..71623067363f
> --- /dev/null
> +++ b/drivers/iio/dac/ad5754.c
> @@ -0,0 +1,668 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Analog Devices, Inc.
> + * Author: Ciprian Regus <ciprian.regus@analog.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/unaligned.h>
> +
> +#define AD5754_INT_VREF			2500
> +#define AD5754_FRAME_SIZE		3
> +#define AD5754_MAX_CHANNELS		4
> +#define AD5754_MAX_RESOLUTION		16
> +
> +#define AD5754_DATA_MASK(_lsb)		GENMASK(15, _lsb)
> +
> +#define AD5754_RANGE_MASK		GENMASK(2, 0)
> +
> +#define AD5754_REG_RD			BIT(7)
> +
> +#define AD5754_CLEAR_FUNC		BIT(2)
> +#define AD5754_LOAD_FUNC		(BIT(2) | BIT(0))
> +#define AD5754_NOOP_FUNC		GENMASK(4, 3)
> +
> +#define AD5754_PU_ADDR			0
> +#define AD5754_PU_MASK			GENMASK(3, 0)
> +#define AD5754_PU_CH(x)			BIT(x)
> +#define AD5754_INT_REF_MASK		BIT(4)
> +#define AD5754_INT_REF			BIT(4)
> +
> +#define AD5754_DAC_REG			0
> +#define AD5754_RANGE_REG		BIT(0)
> +#define AD5754_PWR_REG			BIT(1)
> +#define AD5754_CTRL_REG			GENMASK(1, 0)

Huh.  A really strange datasheet table for these as it breaks them
down into 3 separate 1 bit fields that are next to each other.
I'd ignore that and treat them as a 3 bit field.

Then these are just 0, 1, 2, 3 within that field.



> +
> +enum ad5754_num_channels {
> +	AD5754_2_CHANNELS,
> +	AD5754_4_CHANNELS,
> +};

This can go after you move away from an array of arrays of channels.


> +
> +const struct iio_chan_spec ad5754_channels[][AD5754_MAX_CHANNELS] =3D {
> +	[AD5754_2_CHANNELS] =3D {
> +		AD5754_CHANNEL(0),
> +		AD5754_CHANNEL(1),
> +	},
No real point in having these in an array.  Have
const struct iio_chan_spec ad5754_2_channels[] =3D { ... };
const struct iio_chan_spec ad5754_4_channels[] =3D { ... }

Storage is smaller and easier code also shorter as you don't
have to index the array.

> +	[AD5754_4_CHANNELS] =3D {
> +		AD5754_CHANNEL(0),
> +		AD5754_CHANNEL(1),
> +		AD5754_CHANNEL(2),
> +		AD5754_CHANNEL(3),
> +	},
> +};
> +
> +const struct ad5754_chip_info ad5754_chip_info_data[] =3D {
> +	[AD5722] =3D {
> +		.name =3D "ad5722",
> +		.resolution =3D 12,
> +		.data_mask =3D AD5754_DATA_MASK(4),
> +		.internal_vref =3D false,
> +		.num_channels =3D 2,
> +		.channels =3D ad5754_channels[AD5754_2_CHANNELS],
> +	},
> +	[AD5732] =3D {
> +		.name =3D "ad5732",
> +		.resolution =3D 14,
> +		.data_mask =3D AD5754_DATA_MASK(2),
> +		.internal_vref =3D false,
> +		.num_channels =3D 2,
> +		.channels =3D ad5754_channels[AD5754_2_CHANNELS],
> +	},
> +	[AD5752] =3D {
> +		.name =3D "ad5752",
> +		.resolution =3D 16,
> +		.data_mask =3D AD5754_DATA_MASK(0),
> +		.internal_vref =3D false,
> +		.num_channels =3D 2,
> +		.channels =3D ad5754_channels[AD5754_2_CHANNELS],
> +	},
> +	[AD5724] =3D {
> +		.name =3D "ad5724",
> +		.resolution =3D 12,
> +		.data_mask =3D AD5754_DATA_MASK(4),
> +		.internal_vref =3D false,
> +		.num_channels =3D 4,
> +		.channels =3D ad5754_channels[AD5754_4_CHANNELS],
> +	},
> +	[AD5734] =3D {
> +		.name =3D "ad5734",
> +		.resolution =3D 14,
> +		.data_mask =3D AD5754_DATA_MASK(2),
> +		.internal_vref =3D false,
> +		.num_channels =3D 4,
> +		.channels =3D ad5754_channels[AD5754_4_CHANNELS],
> +	},
> +	[AD5754] =3D {
> +		.name =3D "ad5754",
> +		.resolution =3D 16,
> +		.data_mask =3D AD5754_DATA_MASK(0),
> +		.internal_vref =3D false,
> +		.num_channels =3D 4,
> +		.channels =3D ad5754_channels[AD5754_4_CHANNELS],
> +	},
> +	[AD5722R] =3D {
> +		.name =3D "ad5722r",
> +		.resolution =3D 12,
> +		.data_mask =3D AD5754_DATA_MASK(4),
> +		.internal_vref =3D true,
> +		.num_channels =3D 2,
> +		.channels =3D ad5754_channels[AD5754_2_CHANNELS],
> +	},
> +	[AD5732R] =3D {
> +		.name =3D "ad5732r",
> +		.resolution =3D 14,
> +		.data_mask =3D AD5754_DATA_MASK(2),
> +		.internal_vref =3D true,
> +		.num_channels =3D 2,
> +		.channels =3D ad5754_channels[AD5754_2_CHANNELS],
> +	},
> +	[AD5752R] =3D {
> +		.name =3D "ad5752r",
> +		.resolution =3D 16,
> +		.data_mask =3D AD5754_DATA_MASK(0),
> +		.internal_vref =3D true,
> +		.num_channels =3D 2,
> +		.channels =3D ad5754_channels[AD5754_2_CHANNELS],
> +	},
> +	[AD5724R] =3D {
> +		.name =3D "ad5724r",
> +		.resolution =3D 12,
> +		.data_mask =3D AD5754_DATA_MASK(4),
> +		.internal_vref =3D true,
> +		.num_channels =3D 4,
> +		.channels =3D ad5754_channels[AD5754_4_CHANNELS],
> +	},
> +	[AD5734R] =3D {
> +		.name =3D "ad5734r",
> +		.resolution =3D 14,
> +		.data_mask =3D AD5754_DATA_MASK(2),
> +		.internal_vref =3D true,
> +		.num_channels =3D 4,
> +		.channels =3D ad5754_channels[AD5754_4_CHANNELS],
> +	},
> +	[AD5754R] =3D {
> +		.name =3D "ad5754r",
> +		.resolution =3D 16,
> +		.data_mask =3D AD5754_DATA_MASK(0),
> +		.internal_vref =3D true,
> +		.num_channels =3D 4,
> +		.channels =3D ad5754_channels[AD5754_4_CHANNELS],
> +	}

Add a comma here as we may add more entries in future and that will reduce
the noise in such a patch set

> +};
> +



> +static int ad5754_enable_channels(struct ad5754_state *st)
> +{
> +	struct fwnode_handle *channel_node =3D NULL;
> +	u32 real_channel;
> +	u32 power_reg;
> +	u32 index;
> +	int ret;
> +
> +	fwnode_for_each_available_child_node(dev_fwnode(st->dev), channel_node)=
 {
> +		ret =3D fwnode_property_read_u32(channel_node, "reg", &index);
> +		if (ret) {
> +			dev_err(st->dev, "Failed to read channel reg: %d\n", ret);
> +			goto free_node;
> +		}
> +		if (index >=3D st->chip_info->num_channels) {
> +			dev_err(st->dev, "Channel index %u is too large\n", index);
> +			goto free_node;
> +		}
> +
> +		ret =3D ad5754_real_ch(st, index, &real_channel);
> +		if (ret)
> +			goto free_node;
> +
> +		ret =3D ad5754_get_output_range(st, channel_node, index);
> +		if (ret)
> +			goto free_node;
> +
> +		ret =3D regmap_write_bits(st->regmap,
> +					AD5754_REG_ADDR(AD5754_RANGE_REG, real_channel),
> +					AD5754_RANGE_MASK, st->range_idx[index]);
> +		if (ret)
> +			goto free_node;
> +
> +		ret =3D regmap_read(st->regmap,
> +				  AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +				  &power_reg);

I'm going to take a wild guess (without reading the datasheet) that this tu=
rned something on.
Do we not want to ensure it's turned off again in the remove / devm_ unwind=
 path?

> +		if  (ret)
> +			goto free_node;
> +
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +					 AD5754_PU_MASK, AD5754_PU_CH(real_channel) |
> +					 (power_reg & AD5754_PU_MASK));
> +		if (ret)
> +			goto free_node;
> +
> +		/* Channel power up delay */
> +		fsleep(10);
> +	}
> +
> +	return 0;
> +
> +free_node:
> +	fwnode_handle_put(channel_node);
> +
> +	return ret;
> +}
> +


> +static int ad5754_int_vref_enable(struct ad5754_state *st)
> +{
> +	return regmap_update_bits(st->regmap,
> +				  AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +				  AD5754_INT_REF_MASK,
> +				  FIELD_PREP(AD5754_INT_REF_MASK, 1));

Whilst it is going to make for a long line / less than perfect formatting
I'd prefer you don't have this wrapper, but just call the regmap_update_bit=
s()
at the call site

> +}
> +
> +static void ad5754_disable_regulator(void *regulator)
> +{
> +	regulator_disable(regulator);
> +}
> +
> +static const struct iio_info ad5754_info =3D {
> +	.read_raw =3D &ad5754_read_raw,
> +	.write_raw =3D &ad5754_write_raw,
> +};
> +
> +static int ad5754_probe(struct spi_device *spi)
> +{
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ad5754_state *st;
> +	struct device *dev;
> +	int ret;
> +
> +	dev =3D &spi->dev;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);

Used anywhere? I might have missed it.

> +
> +	st->spi =3D spi;
> +	st->dev =3D dev;

Keeping copies of dev and spi seems excessive.

> +	st->chip_info =3D device_get_match_data(dev);
> +	if (!st->chip_info)
> +		st->chip_info =3D
> +			(const struct ad5754_chip_info *)spi_get_device_id(spi)->driver_data;
> +
> +	st->regmap =3D devm_regmap_init(st->dev, NULL, st, &ad5754_regmap_confi=
g);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(st->dev, PTR_ERR(vref_reg),
> +				     "Regmap init error\n");
> +
> +	st->dac_max_code =3D BIT(st->chip_info->resolution) - 1;

Why cache this?  Just check against >=3D BIT(...) where needed

> +	st->sub_lsb =3D AD5754_MAX_RESOLUTION - st->chip_info->resolution;

Similarly, seems unnecessary to cache this value given how cheap it
is to compute.

> +
> +	vref_reg =3D devm_regulator_get_optional(st->dev, "vref");
> +	if (IS_ERR(vref_reg)) {
> +		if (!st->chip_info->internal_vref)
> +			return dev_err_probe(st->dev, PTR_ERR(vref_reg),
> +			       "Failed to get the vref regulator\n");
> +
> +		st->vref =3D AD5754_INT_VREF;
> +		ret =3D ad5754_int_vref_enable(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regulator_enable(vref_reg);
> +		if (ret)
> +			return dev_err_probe(st->dev, PTR_ERR(vref_reg),

ret

> +				"Failed to enable the vref regulator\n");
> +
> +		ret =3D devm_add_action_or_reset(dev, ad5754_disable_regulator, vref_r=
eg);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regulator_get_voltage(vref_reg);

Could move this to where it's used.  Tends not to be a hot path so cost of =
asking
the supply for ti's voltage is normally fine.

> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to get vref\n");
> +
> +		st->vref =3D ret / 1000;
> +	}
> +
> +	indio_dev->name =3D st->chip_info->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad5754_info;
> +	indio_dev->channels =3D st->chip_info->channels;
> +	indio_dev->num_channels =3D st->chip_info->num_channels;
> +
> +	ret =3D ad5754_enable_channels(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(st->dev, indio_dev);
> +}
> +

> +
> +static const struct spi_device_id ad5754_id[] =3D {
> +	{ "ad5722", (kernel_ulong_t)&ad5754_chip_info_data[AD5722], },
> +	{ "ad5732", (kernel_ulong_t)&ad5754_chip_info_data[AD5732], },
> +	{ "ad5752", (kernel_ulong_t)&ad5754_chip_info_data[AD5752], },
> +	{ "ad5724", (kernel_ulong_t)&ad5754_chip_info_data[AD5724], },
> +	{ "ad5734", (kernel_ulong_t)&ad5754_chip_info_data[AD5734], },
> +	{ "ad5754", (kernel_ulong_t)&ad5754_chip_info_data[AD5754], },
> +	{ "ad5722r", (kernel_ulong_t)&ad5754_chip_info_data[AD5722R], },
> +	{ "ad5732r", (kernel_ulong_t)&ad5754_chip_info_data[AD5732R], },
> +	{ "ad5752r", (kernel_ulong_t)&ad5754_chip_info_data[AD5752R], },
> +	{ "ad5724r", (kernel_ulong_t)&ad5754_chip_info_data[AD5724R], },
> +	{ "ad5734r", (kernel_ulong_t)&ad5754_chip_info_data[AD5734R], },
> +	{ "ad5754r", (kernel_ulong_t)&ad5754_chip_info_data[AD5754R], },
> +	{},

Nice to drop commas on null terminators as nothing can ever come after them=
 anyway.

> +};
> +
> +static const struct of_device_id ad5754_dt_id[] =3D {
> +	{
> +		.compatible =3D "adi,ad5722",
> +		.data =3D &ad5754_chip_info_data[AD5722],
> +	},
> +	{

If there was ever a case for the acceptable option of=20
	}, {
this is it :)

> +		.compatible =3D "adi,ad5732",
> +		.data =3D &ad5754_chip_info_data[AD5732],
> +	},
> +	{
> +		.compatible =3D "adi,ad5752",
> +		.data =3D &ad5754_chip_info_data[AD5752],
> +	},
> +	{
> +		.compatible =3D "adi,ad5724",
> +		.data =3D &ad5754_chip_info_data[AD5724],
> +	},
> +	{
> +		.compatible =3D "adi,ad5734",
> +		.data =3D &ad5754_chip_info_data[AD5734],
> +	},
> +	{
> +		.compatible =3D "adi,ad5754",
> +		.data =3D &ad5754_chip_info_data[AD5754],
> +	},
> +	{
> +		.compatible =3D "adi,ad5722r",
> +		.data =3D &ad5754_chip_info_data[AD5722R],
> +	},
> +	{
> +		.compatible =3D "adi,ad5732r",
> +		.data =3D &ad5754_chip_info_data[AD5732R],
> +	},
> +	{
> +		.compatible =3D "adi,ad5752r",
> +		.data =3D &ad5754_chip_info_data[AD5752R],
> +	},
> +	{
> +		.compatible =3D "adi,ad5724r",
> +		.data =3D &ad5754_chip_info_data[AD5724R],
> +	},
> +	{
> +		.compatible =3D "adi,ad5734r",
> +		.data =3D &ad5754_chip_info_data[AD5734R],
> +	},
> +	{
> +		.compatible =3D "adi,ad5754r",
> +		.data =3D &ad5754_chip_info_data[AD5754R],
> +	},
> +	{},

No comma on NULL terminators.

> +};
> +MODULE_DEVICE_TABLE(of, ad5754_dt_id);

