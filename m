Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7861E553
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKFSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKFSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 13:35:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE83FAE1;
        Sun,  6 Nov 2022 10:35:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6224EB80C82;
        Sun,  6 Nov 2022 18:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39357C433C1;
        Sun,  6 Nov 2022 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667759725;
        bh=dOHccBCrw8Uo0W0YEh2ONWM7UU+HdqTRdU2cOq4GAH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sa0eMvga2aJRO/SdwnorNntCqAjVgyl/i0XzEYRPKgeK/nmEtfDUgN4HTP9WYQql3
         nXqtFWX6kaXbD2F2Us+AoW7BIv75U4o/q8KGf3QuYbEUDbxZIicbWKXe79BkhgdNQk
         LORvOgcwZ0oMUhYAv8CPswTFORQEWRDau3B2HQFMHrCRATkCEiQIszLw/jmX8wJ0du
         Up62Gfck4bd19cCbkBrA+E7vcE639DPf01X9jcdmWF+YX+7+5CJqC0A1WcecneP+js
         ZN8CmH61iYZwsAEzVXSLtqxpcvoh4CEVqLcA/+fLwx2JYW4UY4bCH6xNUR8vB96RvN
         xq5aiXrXRFocQ==
Date:   Sun, 6 Nov 2022 18:35:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: frequency: adf4377: add support for ADF4377
Message-ID: <20221106183515.6ab0b435@jic23-huawei>
In-Reply-To: <20221104092802.90725-3-antoniu.miclaus@analog.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
        <20221104092802.90725-3-antoniu.miclaus@analog.com>
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

On Fri, 4 Nov 2022 11:28:00 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADF4377 is a high performance, ultralow jitter, dual output integer-N
> phased locked loop (PLL) with integrated voltage controlled oscillator
> (VCO) ideally suited for data converter and mixed signal front end (MxFE)
> clock applications.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4377.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Mainly because I can't remember the argument, though I clearly accepted it in
the past ;)  Why do we have these PLL devices in IIO rather than via the clk framework?


A few comments inline to add to those of the other reviewers - I've tried not
to overlap too much!

> ---
>  drivers/iio/frequency/Kconfig   |   10 +
>  drivers/iio/frequency/Makefile  |    1 +
>  drivers/iio/frequency/adf4377.c | 1154 +++++++++++++++++++++++++++++++
>  3 files changed, 1165 insertions(+)
>  create mode 100644 drivers/iio/frequency/adf4377.c
>
...
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> new file mode 100644
> index 000000000000..1901dde1003e
> --- /dev/null
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -0,0 +1,1154 @@
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
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <linux/gpio/consumer.h>

Why singled out for it's own block?
That would kind of make sense for the iio headers because this is an IIO
driver but not this one.

> +
> +/* ADF4377 REG0000 Map */
Normally we'd somehow encode which register it is
within the field defines.  Seems this particular part
doesn't bother with register names. Maybe..

#define ADF4377_0000_SOFT_RESET_R_MSK
 etc? Ideally then dropping the comments, perhaps with the
exception of one at the top saying the datasheet doesn't give
any registers names so we have to use the address.

> +#define ADF4377_SOFT_RESET_R_MSK	BIT(7)
> +#define ADF4377_LSB_FIRST_R_MSK		BIT(6)
> +#define ADF4377_ADDRESS_ASC_R_MSK	BIT(5)
> +#define ADF4377_SDO_ACTIVE_R_MSK	BIT(4)
> +#define ADF4377_SDO_ACTIVE_MSK		BIT(3)
> +#define ADF4377_ADDRESS_ASC_MSK		BIT(2)
> +#define ADF4377_LSB_FIRST_MSK		BIT(1)
> +#define ADF4377_SOFT_RESET_MSK		BIT(0)
> +
> +/* ADF4377 REG0000 Bit Definition */
> +#define ADF4377_SDO_ACTIVE_SPI_3W	0x0
> +#define ADF4377_SDO_ACTIVE_SPI_4W	0x1
These would need the register address prefix as well.
I'd also be tempted to just ignore the docs and call that
bit ADF4377_0000_4_WIRE
That way you won't need to define the values of the field.
Might be able to do similar with some of the others.

> +
> +#define ADF4377_ADDR_ASC_AUTO_DECR	0x0
> +#define ADF4377_ADDR_ASC_AUTO_INCR	0x1
> +
> +#define ADF4377_LSB_FIRST_MSB		0x0
> +#define ADF4377_LSB_FIRST_LSB		0x1
Again, you can probably make this a flag with the 1 value and 0 value
having obvious meaning.
> +
> +#define ADF4377_SOFT_RESET_N_OP		0x0
I'd define the bit as SOFT_RESET_EN then value of 1 and 0 is obvious
without needing defines.

Same might be doable for later fields, but I haven't looked closely.

> +#define ADF4377_SOFT_RESET_EN		0x1
> +
> +/* ADF4377 REG0001 Map */
> +#define ADF4377_SINGLE_INSTR_MSK	BIT(7)
> +#define ADF4377_MASTER_RB_CTRL_MSK	BIT(5)
> +
> +/* ADF4377 REG0001 Bit Definition */
> +#define ADF4377_SPI_STREAM_EN		0x0
> +#define ADF4377_SPI_STREAM_DIS		0x1
Just call the bit SPI_STREAM_DIS and use FIELD_PREP(ADF4377_00001_SPI_STREAM_DIS, 0) etc.

> +
> +#define ADF4377_RB_SLAVE_REG		0x0
subordinate on datasheet.

> +#define ADF4377_RB_MASTER_REG		0x1
main on datasheet.
> +
...


> +/* ADF4377 REG001A Map */
> +#define ADF4377_PD_ALL_MSK		BIT(7)
> +#define ADF4377_PD_RDIV_MSK		BIT(6)
> +#define ADF4377_PD_NDIV_MSK		BIT(5)
> +#define ADF4377_PD_VCO_MSK		BIT(4)
> +#define ADF4377_PD_LD_MSK		BIT(3)
> +#define ADF4377_PD_PFDCP_MSK		BIT(2)
> +#define ADF4377_PD_CLKOUT1_MSK		BIT(1)
> +#define ADF4377_PD_CLKOUT2_MSK		BIT(0)
> +
> +/* ADF4377 REG001A Bit Definition */
> +#define ADF4377_PD_ALL_N_OP		0x0
Don't bother with normal operation defines. Also
just define the mask.

#define ADF4377_001A_PD_ALL  BIT(7)

FIELD_PREP(ADF4377_001A_PD_ALL, 0 or 1)
is then clear with fewer defines and short lines at call site.

Anyhow, I've picked out a few examples. Similar approaches may
make other parts of the code more readable.

> +#define ADF4377_PD_ALL_PD		0x1
> +
...

> +struct adf4377_state {
> +	struct spi_device	*spi;
> +	enum adf4377_dev_type	type;
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
> +	struct gpio_desc	*gpio_ce;
> +	struct gpio_desc	*gpio_enclk1;
> +	struct gpio_desc	*gpio_enclk2;
> +	u8			buf[2] ____cacheline_aligned;
__aligned(IIO_DMA_MINALIGN)

Cacheline line alignment isn't enough on few obsure ARM cores where
that reflects the l1 cacheline, but coherency needs handling at
a slower cache level which has longer cachelines.

> +};
> +


> +static int adf4377_set_default(struct adf4377_state *st)

regmap has infrastructure to do this from a table.  Use that rather
than hand coding it. If there is a strong reason to do otherwise
then add a comment here.

...

> +
> +int adf4377_set_freq(struct adf4377_state *st, u64 freq)

This is awfully involved.  Perhaps a comment or spec reference for the register
write sequence?

> +{
> +	unsigned int read_val;
> +	u64 f_vco;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_EN_DNCLK_MSK | ADF4377_EN_DRCLK_MSK,
> +				 FIELD_PREP(ADF4377_EN_DNCLK_MSK, ADF4377_EN_DNCLK_ON) |
> +				 FIELD_PREP(ADF4377_EN_DRCLK_MSK, ADF4377_EN_DRCLK_ON));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x11, ADF4377_EN_AUTOCAL_MSK | ADF4377_DCLK_DIV2_MSK,
> +				 FIELD_PREP(ADF4377_EN_AUTOCAL_MSK, ADF4377_VCO_CALIB_EN) |
> +				 FIELD_PREP(ADF4377_DCLK_DIV2_MSK, st->dclk_div2));
> +	if (ret)
> +		return ret;
> +
... lots more ...

> +
> +static void adf4377_gpio_init(struct adf4377_state *st)
> +{
> +	if (st->gpio_ce) {
> +		gpiod_set_value(st->gpio_ce, 1);
This was driven high at the gpiod_get_optional() so we are leaving it the same.  Maybe makes
sense to drive it low at request and high here so as to force a reset?
> +
> +		/* Delay for SPI register bits to settle to their power-on reset state */
> +		usleep_range(200, 250);
> +	}
> +
> +	if (st->gpio_enclk1)
> +		gpiod_set_value(st->gpio_enclk1, 1);

So is the assumption here that if we don't have control of these they are all tied to 1?
Perhaps a comment to say that if so... 
Is turning these off a power saving thing? If so I'd expect that in the remove() path
probably via a devm_add_action_or_reset() type call.


> +
> +	if (st->gpio_enclk2 && st->type == ADF4377)
> +		gpiod_set_value(st->gpio_enclk2, 1);
> +}
> +
> +static int adf4377_init(struct adf4377_state *st)
> +{
> +	int ret;
> +
> +	/* GPIO Inititalization */
> +	adf4377_gpio_init(st);
> +
> +	/* Software reset */
> +	ret = adf4377_soft_reset(st);
If I read the datasheet right, we could have already done a hardware reset.
Normally we'd not bother doing both.
> +	if (ret)
> +		return ret;
> +
> +	/* Set Default Registers */
Name of function rather removes need for the comment. Same for the other two above.
> +	ret = adf4377_set_default(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x15, ADF4377_CP_I_MSK,
Unlike the above calls, not so obvious what this is doing so a comment would be helpful.
> +				 FIELD_PREP(ADF4377_CP_I_MSK, ADF4377_CP_10MA1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, 0x00,
> +				 ADF4377_SDO_ACTIVE_MSK | ADF4377_SDO_ACTIVE_R_MSK,
> +				 FIELD_PREP(ADF4377_SDO_ACTIVE_MSK, ADF4377_SDO_ACTIVE_SPI_4W) |
> +				 FIELD_PREP(ADF4377_SDO_ACTIVE_R_MSK, ADF4377_SDO_ACTIVE_SPI_4W));
> +	if (ret)
> +		return ret;
> +
> +	st->clkin_freq = clk_get_rate(st->clkin);
> +
> +	/* Power Up */
> +	ret = regmap_write(st->regmap, 0x1a,
> +			   FIELD_PREP(ADF4377_PD_ALL_MSK, ADF4377_PD_ALL_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_RDIV_MSK, ADF4377_PD_RDIV_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_NDIV_MSK, ADF4377_PD_NDIV_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_VCO_MSK, ADF4377_PD_VCO_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_LD_MSK, ADF4377_PD_LD_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_PFDCP_MSK, ADF4377_PD_PFDCP_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_CLKOUT1_MSK, ADF4377_PD_CLKOUT1_N_OP) |
> +			   FIELD_PREP(ADF4377_PD_CLKOUT2_MSK, ADF4377_PD_CLKOUT2_N_OP));
> +	if (ret)
> +		return ret;
> +
> +	/* Compute PFD */
> +	st->ref_div_factor = 0;
> +	do {
> +		st->ref_div_factor++;
> +		st->f_pfd = st->clkin_freq / st->ref_div_factor;
> +	} while (st->f_pfd > ADF4377_MAX_FREQ_PFD);
> +
> +	if (st->f_pfd > ADF4377_MAX_FREQ_PFD || st->f_pfd < ADF4377_MIN_FREQ_PFD)
> +		return -EINVAL;
> +
> +	st->f_div_rclk = st->f_pfd;
> +
> +	if (st->f_pfd <= ADF4377_FREQ_PFD_80MHZ) {
> +		st->dclk_div1 = ADF4377_DCLK_DIV1_1;
> +		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
> +		st->dclk_mode = ADF4377_DCLK_MODE_DIS;
> +	} else if (st->f_pfd <= ADF4377_FREQ_PFD_125MHZ) {
> +		st->dclk_div1 = ADF4377_DCLK_DIV1_1;
> +		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
> +		st->dclk_mode = ADF4377_DCLK_MODE_EN;
> +	} else if (st->f_pfd <= ADF4377_FREQ_PFD_160MHZ) {
> +		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
> +		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
> +		st->dclk_mode = ADF4377_DCLK_MODE_DIS;
> +		st->f_div_rclk /= 2;
> +	} else if (st->f_pfd <= ADF4377_FREQ_PFD_250MHZ) {
> +		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
> +		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
> +		st->dclk_mode = ADF4377_DCLK_MODE_EN;
> +		st->f_div_rclk /= 2;
> +	} else if (st->f_pfd <= ADF4377_FREQ_PFD_320MHZ) {
> +		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
> +		st->dclk_div2 = ADF4377_DCLK_DIV2_2;
> +		st->dclk_mode = ADF4377_DCLK_MODE_DIS;
> +		st->f_div_rclk /= 4;
> +	} else {
> +		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
> +		st->dclk_div2 = ADF4377_DCLK_DIV2_2;
> +		st->dclk_mode = ADF4377_DCLK_MODE_EN;
> +		st->f_div_rclk /= 4;
> +	}
> +
> +	st->synth_lock_timeout = DIV_ROUND_UP(st->f_div_rclk, 50000);
> +	st->vco_alc_timeout = DIV_ROUND_UP(st->f_div_rclk, 20000);
> +	st->vco_band_div = DIV_ROUND_UP(st->f_div_rclk, 150000 * 16 * (1 << st->dclk_mode));
> +	st->adc_clk_div = DIV_ROUND_UP((st->f_div_rclk / 400000 - 2), 4);
> +
> +	return 0;
> +}
> +



> +
> +static const struct spi_device_id adf4377_id[] = {
> +	{ "adf4377", ADF4377 },
> +	{ "adf4378", ADF4378 },
> +	{},
As below.

> +};
> +MODULE_DEVICE_TABLE(spi, adf4377_id);
> +
> +static const struct of_device_id adf4377_of_match[] = {
> +	{ .compatible = "adi,adf4377" },
> +	{ .compatible = "adi,adf4378" },
> +	{},
No comma on NULL terminators.  We shouldn't add anything after
them, so good to make that explicit.

> +};
> +MODULE_DEVICE_TABLE(of, adf4377_of_match);
> +
> +static struct spi_driver adf4377_driver = {
> +	.driver = {
> +		.name = "adf4377",
> +		.of_match_table = adf4377_of_match,
> +	},
> +	.probe = adf4377_probe,
> +	.id_table = adf4377_id,
> +};
> +module_spi_driver(adf4377_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADF4377");
> +MODULE_LICENSE("GPL");

