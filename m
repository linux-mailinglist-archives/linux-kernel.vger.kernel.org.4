Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2A626F8C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiKMMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiKMMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:45:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B4F1276A;
        Sun, 13 Nov 2022 04:45:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B09A9B80945;
        Sun, 13 Nov 2022 12:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B31BC433D6;
        Sun, 13 Nov 2022 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668343552;
        bh=dtda/lTghIpjDpKgv6NwU09Q5COHwGXaOpPJYTvOuug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vIVvQaDSJcrcQedTKr4vazVZTUjLXD44UiqyUzH7Zxy3HoqjfO1edvUaGE6gAXhor
         QxpsDrzqvNLAYAF3DmNPdvxAVofU5zF+GYnhE99dUHA/Jcs9/bA8p9aFC8eexfld6D
         RBJXO3wtEbu72rj5sosbAhX9ipjFinsMx5af2zPuY5nJdgWwJ81H25LAn9bBIkHBb3
         E6Z+ZprONKYd34XlmHo0iiAMC2H+WhU6tk0zf2002eVrpiYW+RjJVpvEfbMk/fhCH0
         bQgoULC/kdYg9iCeNGfpJy2baaJcGbaoK7shAkXqdL4bKeLg3QCegP9iNE2Gti6atj
         QeOoWz6B/gbUQ==
Date:   Sun, 13 Nov 2022 12:58:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: frequency: adf4377: add support for ADF4377
Message-ID: <20221113125806.2c52a696@jic23-huawei>
In-Reply-To: <20221107120243.57344-2-antoniu.miclaus@analog.com>
References: <20221107120243.57344-1-antoniu.miclaus@analog.com>
        <20221107120243.57344-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 14:02:42 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADF4377 is a high performance, ultralow jitter, dual output integer-N
> phased locked loop (PLL) with integrated voltage controlled oscillator
> (VCO) ideally suited for data converter and mixed signal front end (MxFE)
> clock applications.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4377.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

Not sure if you got my v1 review but a few things seem to have slipped through and
are still here.

https://lore.kernel.org/all/20221106183515.6ab0b435@jic23-huawei/

Jonathan


> ---
>  - use `devm_clk_get_enabled()`
>  - return in place for `adf4377_read` and `adf4377_write`
>  - remove adf4378 support since datasheet is not public yet.
>  - print errors inside `adf4377_init`
>  - remove enable/disable related defines and use 0/1 inline with field_prep
>  - remove powerdown bit defines
>  - use `regmap_multi_reg_write` to set the default registers
>  - remove `adf4377_set_default` function
>  - drive gpios to low state by default
>  - remove redundant comments
>  - remove muxout from userspace, move it as devicetree property
>  - remove custom set of the Charge Pump current
>  - remove comma on NULL terminators
>  drivers/iio/frequency/Kconfig   |  10 +
>  drivers/iio/frequency/Makefile  |   1 +
>  drivers/iio/frequency/adf4377.c | 971 ++++++++++++++++++++++++++++++++
>  3 files changed, 982 insertions(+)
>  create mode 100644 drivers/iio/frequency/adf4377.c
> 

> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> new file mode 100644
> index 000000000000..542299f0d47d
> --- /dev/null
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -0,0 +1,971 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADF4377 driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* ADF4377 REG0000 Map */
> +#define ADF4377_SOFT_RESET_R_MSK	BIT(7)

As per review of v1.
I'd prefer it if these were named to make it clear which register they
are in.  That makes it much easier to line things up with the datasheet
and to be sure that writes are to the corresponding register address.

> +#define ADF4377_LSB_FIRST_R_MSK		BIT(6)
> +#define ADF4377_ADDRESS_ASC_R_MSK	BIT(5)
> +#define ADF4377_SDO_ACTIVE_R_MSK	BIT(4)
> +#define ADF4377_SDO_ACTIVE_MSK		BIT(3)
> +#define ADF4377_ADDRESS_ASC_MSK		BIT(2)
> +#define ADF4377_LSB_FIRST_MSK		BIT(1)
> +#define ADF4377_SOFT_RESET_MSK		BIT(0)

> +struct adf4377_state {
> +	struct spi_device	*spi;
> +	struct regmap		*regmap;
> +	struct clk		*clkin;
> +	/* Protect against concurrent accesses to the device and data content */
> +	struct mutex		lock;
> +	struct notifier_block	nb;
> +	/* Reference Divider */
> +	unsigned int		ref_div_factor;
> +	/* PFD Frequency */
> +	unsigned int		f_pfd;
> +	/* Input Reference Clock */
> +	unsigned int		clkin_freq;
> +	/* CLKOUT Divider */
> +	u8			clkout_div_sel;
> +	/* Feedback Divider (N) */
> +	u16			n_int;
> +	u16			synth_lock_timeout;
> +	u16			vco_alc_timeout;
> +	u16			adc_clk_div;
> +	u16			vco_band_div;
> +	u8			dclk_div1;
> +	u8			dclk_div2;
> +	u8			dclk_mode;
> +	unsigned int		f_div_rclk;
> +	enum muxout_select_mode	muxout_select;
> +	struct gpio_desc	*gpio_ce;
> +	struct gpio_desc	*gpio_enclk1;
> +	struct gpio_desc	*gpio_enclk2;
> +	u8			buf[2] ____cacheline_aligned;

See review of v1. This is not sufficient.

> +};
> +
> +static const char * const adf4377_muxout_modes[] = {
> +	[ADF4377_MUXOUT_HIGH_Z] = "high_z",
> +	[ADF4377_MUXOUT_LKDET] = "lock_detect",
> +	[ADF4377_MUXOUT_LOW] = "muxout_low",
> +	[ADF4377_MUXOUT_DIV_RCLK_2] = "f_div_rclk_2",
> +	[ADF4377_MUXOUT_DIV_NCLK_2] = "f_div_nclk_2",
> +	[ADF4377_MUXOUT_HIGH] = "muxout_high",
> +};
> +
> +static const struct reg_sequence adf4377_reg_defaults[] = {
> +	{0x42,  ADF4377_R042_RSV1},

prefer extra spacing...

	{ 0x62, ADF4377_R042_RSV1 },

> +	{0x3B,  ADF4377_R03B_RSV1},
> +	{0x3A,  ADF4377_R03A_RSV1},
> +	{0x34,  ADF4377_R034_RSV1},
> +	{0x33,  ADF4377_R033_RSV1},
> +	{0x32,  ADF4377_R032_RSV1},
> +	{0x31,  ADF4377_R031_RSV1},
> +	{0x2C,  ADF4377_R02C_RSV1},
> +	{0x25,  ADF4377_R025_RSV1},
> +	{0x23,  ADF4377_R023_RSV1},
> +	{0x22,  ADF4377_R022_RSV1},
> +	{0x21,  ADF4377_R021_RSV1},
> +	{0x1f,  ADF4377_R01F_RSV1},
> +	{0x1c,  ADF4377_R01C_RSV1},
> +};

> +
> +static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
> +{
> +	unsigned int read_val;
> +	u64 f_vco;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_EN_DNCLK_MSK | ADF4377_EN_DRCLK_MSK,
> +				 FIELD_PREP(ADF4377_EN_DNCLK_MSK, 1) |
> +				 FIELD_PREP(ADF4377_EN_DRCLK_MSK, 1));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x11, ADF4377_EN_AUTOCAL_MSK | ADF4377_DCLK_DIV2_MSK,
> +				 FIELD_PREP(ADF4377_EN_AUTOCAL_MSK, 1) |
> +				 FIELD_PREP(ADF4377_DCLK_DIV2_MSK, st->dclk_div2));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x2E, ADF4377_EN_ADC_CNV_MSK | ADF4377_EN_ADC_MSK |
> +				 ADF4377_ADC_A_CONV_MSK,
> +				 FIELD_PREP(ADF4377_EN_ADC_CNV_MSK, 1) |
> +				 FIELD_PREP(ADF4377_EN_ADC_MSK, 1) |
> +				 FIELD_PREP(ADF4377_ADC_A_CONV_MSK, ADF4377_ADC_A_CONV_VCO_CALIB));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x20, ADF4377_EN_ADC_CLK_MSK,
> +				 FIELD_PREP(ADF4377_EN_ADC_CLK_MSK, 1));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x2F, ADF4377_DCLK_DIV1_MSK,
> +				 FIELD_PREP(ADF4377_DCLK_DIV1_MSK, st->dclk_div1));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x24, ADF4377_DCLK_MODE_MSK,
> +				 FIELD_PREP(ADF4377_DCLK_MODE_MSK, st->dclk_mode));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_write(st->regmap, 0x27,
> +			   FIELD_PREP(ADF4377_SYNTH_LOCK_TO_LSB_MSK, st->synth_lock_timeout));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x28, ADF4377_SYNTH_LOCK_TO_MSB_MSK,
> +				 FIELD_PREP(ADF4377_SYNTH_LOCK_TO_MSB_MSK,
> +					    st->synth_lock_timeout >> 8));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_write(st->regmap, 0x29,
> +			   FIELD_PREP(ADF4377_VCO_ALC_TO_LSB_MSK, st->vco_alc_timeout));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x2A, ADF4377_VCO_ALC_TO_MSB_MSK,
> +				 FIELD_PREP(ADF4377_VCO_ALC_TO_MSB_MSK, st->vco_alc_timeout >> 8));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_write(st->regmap, 0x26,
> +			   FIELD_PREP(ADF4377_VCO_BAND_DIV_MSK, st->vco_band_div));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_write(st->regmap, 0x2D,
> +			   FIELD_PREP(ADF4377_ADC_CLK_DIV_MSK, st->adc_clk_div));
> +	if (ret)
> +		goto exit;
> +
> +	st->clkout_div_sel = 0;
> +
> +	if (freq > ADF4377_MAX_CLKPN_FREQ || freq < ADF4377_MIN_CLKPN_FREQ) {

Perhaps do this check before all the register writes?  I don't think I'm missing any
dependencies and this could even be done before taking the lock.

That way I think we can make the only failure path be comms related and I'm less bothered
about that sort of issue leaving the device in an odd state due to masking so many things
to change the frequency.

> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	f_vco = freq;
> +
> +	while (f_vco < ADF4377_MIN_VCO_FREQ) {
> +		f_vco <<= 1;
> +		st->clkout_div_sel++;
> +	}
> +
> +	st->n_int = div_u64(freq, st->f_pfd);
> +
> +	ret = regmap_update_bits(st->regmap, 0x11, ADF4377_EN_RDBLR_MSK | ADF4377_N_INT_MSB_MSK,
> +				 FIELD_PREP(ADF4377_EN_RDBLR_MSK, 0) |
> +				 FIELD_PREP(ADF4377_N_INT_MSB_MSK, st->n_int >> 8));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_update_bits(st->regmap, 0x12, ADF4377_R_DIV_MSK | ADF4377_CLKOUT_DIV_MSK,
> +				 FIELD_PREP(ADF4377_CLKOUT_DIV_MSK, st->clkout_div_sel) |
> +				 FIELD_PREP(ADF4377_R_DIV_MSK, st->ref_div_factor));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_write(st->regmap, 0x10,
> +			   FIELD_PREP(ADF4377_N_INT_LSB_MSK, st->n_int));
> +	if (ret)
> +		goto exit;
> +
> +	ret = regmap_read_poll_timeout(st->regmap, 0x49, read_val,
> +				       !(read_val & (ADF4377_FSM_BUSY_MSK)), 200, 200 * 100);
> +	if (ret)
> +		goto exit;
> +
> +	/* Disable EN_DNCLK, EN_DRCLK */
> +	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_EN_DNCLK_MSK | ADF4377_EN_DRCLK_MSK,
> +				 FIELD_PREP(ADF4377_EN_DNCLK_MSK, 0) |
> +				 FIELD_PREP(ADF4377_EN_DRCLK_MSK, 0));
> +	if (ret)
> +		goto exit;
> +
> +	/* Disable EN_ADC_CLK */
> +	ret = regmap_update_bits(st->regmap, 0x20, ADF4377_EN_ADC_CLK_MSK,
> +				 FIELD_PREP(ADF4377_EN_ADC_CLK_MSK, 0));
> +	if (ret)
> +		goto exit;
> +
> +	/* Set output Amplitude */
> +	ret = regmap_update_bits(st->regmap, 0x19, ADF4377_CLKOUT2_OP_MSK | ADF4377_CLKOUT1_OP_MSK,
> +				 FIELD_PREP(ADF4377_CLKOUT1_OP_MSK, ADF4377_CLKOUT_420MV) |
> +				 FIELD_PREP(ADF4377_CLKOUT2_OP_MSK, ADF4377_CLKOUT_420MV));
> +
> +exit:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}


...

> +static ssize_t adf4377_read(struct iio_dev *indio_dev, uintptr_t private,
> +			    const struct iio_chan_spec *chan, char *buf)
> +{
> +	struct adf4377_state *st = iio_priv(indio_dev);
> +	u64 val = 0;
> +
> +	switch ((u32)private) {
> +	case ADF4377_FREQ:
> +		return adf4377_get_freq(st, &val) ?: sysfs_emit(buf, "%llu\n", val);

As below, ternary operator isn't helping readability here.

> +	default:
> +		val = 0;

Already set above. Though not sure why it needs to be set at all in this path.

> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t adf4377_write(struct iio_dev *indio_dev, uintptr_t private,
> +			     const struct iio_chan_spec *chan, const char *buf,
> +			     size_t len)
> +{
> +	struct adf4377_state *st = iio_priv(indio_dev);
> +	unsigned long long freq;
> +	int ret;
> +
> +	switch ((u32)private) {
> +	case ADF4377_FREQ:
> +		ret = kstrtoull(buf, 10, &freq);
> +		if (ret)
> +			return ret;
> +
> +		return adf4377_set_freq(st, freq) ?: len;

As per another discussion on list recently, using ternary operators like this

is just not worth the loss of readability.

		ret = adf4377_set_freq(st, req);
		if (ret)
			return ret;

		return len;

is much more readable.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define _ADF4377_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = adf4377_read, \
> +		.write = adf4377_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +	}
> +
> +static const struct iio_chan_spec_ext_info adf4377_ext_info[] = {
> +	/*
> +	 * Usually we use IIO_CHAN_INFO_FREQUENCY, but there are
> +	 * values > 2^32 in order to support the entire frequency range
> +	 * in Hz.
> +	 */
> +	_ADF4377_EXT_INFO("frequency", IIO_SEPARATE, ADF4377_FREQ),
> +	{ },

'Null terminator' so no trailing comma preferred. If this is all I find, I'll tidy up
whilst applying.

> +};
> +
> +static const struct iio_chan_spec adf4377_channels[] = {
> +	{
> +		.type = IIO_ALTVOLTAGE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.ext_info = adf4377_ext_info,
> +	},
> +};
> +

> +static int adf4377_freq_change(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct adf4377_state *st = container_of(nb, struct adf4377_state, nb);
> +	int ret;
> +
> +	if (action == POST_RATE_CHANGE) {
> +		mutex_lock(&st->lock);
> +		ret = notifier_from_errno(adf4377_init(st));
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int adf4377_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct adf4377_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_spi(spi, &adf4377_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	st = iio_priv(indio_dev);
> +
> +	indio_dev->info = &adf4377_info;
> +	indio_dev->name = "adf4377";
> +	indio_dev->channels = adf4377_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
> +
> +	st->regmap = regmap;
> +	st->spi = spi;
> +	mutex_init(&st->lock);
> +
> +	ret = adf4377_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = adf4377_freq_change;
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = adf4377_init(st);
> +	if (ret)
> +		return ret;

