Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A3E61DA92
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiKENVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:20:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F28DF45;
        Sat,  5 Nov 2022 06:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14BCEB80B64;
        Sat,  5 Nov 2022 13:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42430C433D6;
        Sat,  5 Nov 2022 13:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667654454;
        bh=/L+1cEHnXuoRdQ8oKFdlzMMLuFRE5SmGeESL9m/Qm7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VGtUIoHLtQG9DW+or9/oWuaw3nA6bKjWMsQjWhD1CBcQIXwYlWmA1sQLIO4wN7eq8
         TA+rEfV1jdfjs+PAueWDfWxahjNVizrOUePRX3+rcb/iKLz21hraajbKFCG/UGdpm9
         pSrP7ZDgRzsT9gKfxGBrhttCMp//+ylxp9mho/X2bkzm6FtWx/RYP8XGiwIS0h0F9r
         gmI7nhg1uKpjCX9utGt5dROg7Ri5OIVYYL4uj3A7cl9UTItTeRE5ET2+Dehp0rf31D
         j5AVDzsnPvzWU3Tyx7F4W3AjhUGb4rJWbliaJztIlUIx3wi/NLgcdeL3Jf1tVKmBYf
         n9Ga+rlQNYQDw==
Date:   Sat, 5 Nov 2022 13:20:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] drivers: iio: dac: Add AD5754 DAC driver
Message-ID: <20221105132045.5543a43f@jic23-huawei>
In-Reply-To: <20221104172343.617690-3-ciprian.regus@analog.com>
References: <20221104172343.617690-1-ciprian.regus@analog.com>
        <20221104172343.617690-3-ciprian.regus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 19:23:43 +0200
Ciprian Regus <ciprian.regus@analog.com> wrote:

> The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial
> input, voltage output DACs. The devices operate from single-
> supply voltages from +4.5 V up to +16.5 V or dual-supply
> voltages from =C2=B14.5 V up to =C2=B116.5 V. The input coding is
> user-selectable twos complement or offset binary for a bipolar
> output (depending on the state of Pin BIN/2sComp), and straight
> binary for a unipolar output.

Trivial, but for patch descriptions, normal wrap is around 72-75 characters.
This looks a bit short so could be rewrapped to be a tiny bit nicer.
(I'd fix that up whilst applying but given you are going to be doing a v3
great if you can tidy it up!)

Some comments inline. Looking pretty good in general.

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
> ---
> changes in v2:
>  - replaced the entire supported devices list in Kconfig with 'and simila=
r'.
>  - mentioned the devices that have internal references as being supported.
>  - added the _mV suffix to the AD5754_INT_VREF macro.
>  - changed the macros by using numbers (where it was needed) instead of G=
ENMASK or BIT.
>  - declared global variables as static.
>  - added 2 different arrays for 2 and 4 channels instead of using an arra=
y of arrays.
>  - set the CLR GPIO to high.
>  - removed the dev field in the state struct.
>  - casted the chip_info struct (probe function) to void *, so the line wi=
ll look better.
>  - added the uV_PER_mV macro for vref mV conversions.
>  - removed commas from terminator lines.
>  - used module_spi_driver() instead of module_driver().
>  - powered off the internal reference or regulator and channels output on=
 remove.
>  - removed the ad5754_int_vref_enable() function.
>  - fixed some probe return values.
>  - removed the dac_max_code and sub_lsb caching.
>  - simplified the scale attribute computation.
>  - set the max_register field in the regmap_config struct.=20
>  MAINTAINERS              |   8 +
>  drivers/iio/dac/Kconfig  |  12 +
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5754.c | 647 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 668 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5754.c
>=20
...

> diff --git a/drivers/iio/dac/ad5754.c b/drivers/iio/dac/ad5754.c
> new file mode 100644
> index 000000000000..ee52fcbef3a2
> --- /dev/null
> +++ b/drivers/iio/dac/ad5754.c
> @@ -0,0 +1,647 @@

> +
> +/*
> + * The channel addresses for 2 channel chip variants are not sequential:
> + *      A2 A1 A0 Channel
> + *	0  0  0   DAC A
> + *	0  1  0   DAC B
> + *
> + * This is not the case for 4 channel chips:
> + *	A2 A1 A0 Channel
> + *	0  0  0   DAC A
> + *	0  0  1   DAC B
> + *	0  1  0   DAC C
> + *	0  1  1   DAC D
> + */

> +
> +static int ad5754_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
> +{
> +	struct ad5754_state *st =3D context;
> +	struct spi_transfer xfer[] =3D {
> +		{
> +			.tx_buf =3D st->buff,
> +			.len =3D AD5754_FRAME_SIZE,
> +		},
> +	};
> +	int ret;
> +
> +	st->buff[0] =3D AD5754_REG_RD | reg;
> +	ret =3D spi_sync_transfer(st->spi, xfer, 1);
> +	if (ret)
> +		return ret;

We have two writes in here that are ultimately triggered from userspace sys=
fs
writes.  They aren't necessarily serialized.  So I'd expect to see some
locking in here as we can't rely on the bus locking (it doesn't know the
two spi_sync_transfer() are related obviously!)

> +
> +	xfer->rx_buf =3D st->buff;
> +	st->buff[0] =3D AD5754_REG_ADDR(AD5754_CTRL_REG, AD5754_NOOP_FUNC);
> +	st->buff[1] =3D 0;
> +	st->buff[2] =3D 0;
> +	ret =3D spi_sync_transfer(st->spi, xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D get_unaligned_be16(&st->buff[1]);
> +
> +	return 0;
> +};

> +static int ad5754_set_dac_code(struct ad5754_state *st, u32 channel, u32=
 code)
> +{
> +	u32 sub_lsb =3D AD5754_MAX_RESOLUTION - st->chip_info->resolution;
> +	struct reg_sequence xfer_seq[2] =3D {
> +		{ AD5754_REG_ADDR(AD5754_DAC_REG, channel), code << sub_lsb },
> +		{ AD5754_REG_ADDR(AD5754_CTRL_REG, AD5754_LOAD_FUNC), 0 },
> +	};
> +
> +	return regmap_multi_reg_write(st->regmap, xfer_seq, 2);
ARRAY_SIZE() for that 2.

This is nice way of doing this.  I wonder how many other drivers
would benefit from similar use of regmap_multi_reg_write().

> +}
> +
> +static int ad5754_enable_channels(struct ad5754_state *st)
> +{
> +	struct fwnode_handle *channel_node;
> +	u32 real_channel;
> +	u32 power_reg;
> +	u32 index;
> +	int ret;
> +
> +	device_for_each_child_node(&st->spi->dev, channel_node) {
> +		ret =3D fwnode_property_read_u32(channel_node, "reg", &index);
> +		if (ret) {
> +			dev_err(&st->spi->dev, "Failed to read channel reg: %d\n", ret);
> +			goto free_node;
> +		}
> +		if (index >=3D st->chip_info->num_channels) {
> +			dev_err(&st->spi->dev, "Channel index %u is too large\n", index);
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
> +		if  (ret)
> +			goto free_node;
> +
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +					 AD5754_PU_MASK, AD5754_PU_CH(real_channel) |
> +					 (power_reg & AD5754_PU_MASK));

This function should be side effect free if an error occurs on later channe=
ls.
So I'd expect to see any bits to do with enabling undone on the error path =
rather than
relying on a cleanup routine registered elsewhere.

> +		if (ret)
> +			goto free_node;
> +
> +		/* Channel power up delay */
> +		fsleep(10);

It's short enough that it probably doesn't matter, but do you need to do th=
is for each
channel, or can you turn them all on and sleep only once?

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

...

> +
> +static void ad5754_power_off(void *state)
> +{
> +	struct ad5754_state *st =3D state;
> +
> +	/* Power off the output for all channels */
> +	regmap_update_bits(st->regmap,
> +			   AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +			   AD5754_PU_MASK, FIELD_PREP(AD5754_PU_MASK, 0));

I think this first section is undoing what was configured in ad5754_enabled=
_channels()?
It presumably doesn't matter if we turn off channels when none have been tu=
rned on yet,
but from an ease of review point of view I'd prefer to see this callback sp=
lit
into 2 (maybe 3) parts. Whether to separate the regulator disable vs intern=
al ref
handling separately is less import (but might be slightly nicer) - but regi=
ster
callbacks for that bit where you current register this one + register anoth=
er callback
to do the power off above, only after ad5754_enable_channels().

That will bring the complexity that you'll need to make that function not h=
ave side effects
if an error occurs by turning these off manually there - the advantage is t=
hat the code
becomes easier to review / maintain as that is local.

> +
> +	if (!st->chip_info->internal_vref)
> +		regulator_disable(st->vref_reg);
> +	else
> +		regmap_update_bits(st->regmap,
> +				   AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +				   AD5754_INT_REF_MASK,
> +				   FIELD_PREP(AD5754_INT_REF_MASK, 0));
> +}
> +
> +static const struct iio_info ad5754_info =3D {
> +	.read_raw =3D &ad5754_read_raw,
> +	.write_raw =3D &ad5754_write_raw,
> +};
> +
> +static int ad5754_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5754_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->spi =3D spi;
> +	st->chip_info =3D device_get_match_data(dev);
> +	if (!st->chip_info)
> +		st->chip_info =3D (void *)spi_get_device_id(spi)->driver_data;
> +
> +	st->regmap =3D devm_regmap_init(dev, NULL, st, &ad5754_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Regmap init error\n");
> +
> +	st->clr_gpio =3D devm_gpiod_get_optional(dev, "clr", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->clr_gpio))
> +		return PTR_ERR(st->clr_gpio);
> +
> +	/* Clear the DAC code registers */
> +	ret =3D regmap_write(st->regmap,
> +			   AD5754_REG_ADDR(AD5754_CTRL_REG, AD5754_CLEAR_FUNC),
> +			   0);
> +	if (ret)
> +		return ret;
> +
> +	st->vref_reg =3D devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->vref_reg)) {
> +		if (!st->chip_info->internal_vref)
> +			return dev_err_probe(dev, PTR_ERR(st->vref_reg),
> +					     "Failed to get the vref regulator\n");
> +
> +		st->vref =3D AD5754_INT_VREF_mV;
> +		ret =3D regmap_update_bits(st->regmap,
> +					 AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
> +					 AD5754_INT_REF_MASK,
> +					 FIELD_PREP(AD5754_INT_REF_MASK, 1));
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regulator_enable(st->vref_reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable the vref regulator\n");

As mentioned above, I would suggest thinking about splitting the unwinding =
of the two
if/else paths here given there is really no overlap in what needs to be don=
e.
It will result in more code due to two callbacks, but be slightly easier to=
 follow.

> +
> +		ret =3D regulator_get_voltage(st->vref_reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to get vref\n");
> +
> +		st->vref =3D ret / uV_PER_mV;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, ad5754_power_off, st);
> +	if (ret)
> +		return ret;
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
> +	return devm_iio_device_register(dev, indio_dev);
> +}

