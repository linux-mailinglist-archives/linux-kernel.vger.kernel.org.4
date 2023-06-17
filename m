Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681D4734365
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjFQT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC71116;
        Sat, 17 Jun 2023 12:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03AA060F28;
        Sat, 17 Jun 2023 19:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33CFC433C0;
        Sat, 17 Jun 2023 19:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687031829;
        bh=oS5PfpiieRpSgabpO6Y6Mrd4jp+Z+L0qoELXKssFs2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VOFWq6nPjXud2kpD3lUm20QjXYcXA87MO6MvR3e0XcmHKg5FS5RfL3dguJmVkFvGh
         yALSI/nUavqnhvgqHrtFGo7bQNtOnVgjh4oGd5zfY3tu75Xln8tpbvMO4UB4k54DqP
         sLSAFgqor5oK60RaVdbin4UWa1BoBX1Mn/FuF6/X6N09LLFw0S1NTq3aVw3lITLgrh
         mnrDdAVhMOpWuTDDDMnqsXAbTyFUFGClq2OWaaRL+lwbqeqbi7xTSQY/swRW7H7QE+
         FYQlRLfi5vTf3viiM2TnJlgDr9VMiSOl5g1/q0NFBoRfHvVtPsYWUkexDtb5Dzf1fT
         pgvneMDSYIrpw==
Date:   Sat, 17 Jun 2023 20:57:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: bd27008: Support BD27010 RGB
Message-ID: <20230617205702.29bdd84a@jic23-huawei>
In-Reply-To: <327fde7f6e5e76908af474de3e348fe7626f39b2.1686651445.git.mazziesaccount@gmail.com>
References: <cover.1686650184.git.mazziesaccount@gmail.com>
        <327fde7f6e5e76908af474de3e348fe7626f39b2.1686651445.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 13:20:26 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
> RGBC+IR sensor functionality is largely similar to what the BU27008 has.
> There are some notable things though:
>   - gain setting is once again new and exotic. Now, there is 6bit gain
>     setting where 4 of the bits are common to all channels and 2 bits
>     can be configured separately for each channel. The BU27010 has
>     similar "1X on other channels vs 2X on IR when selector is 0x0"
>     gain design as BU27008 had. So, we use same gain setting policy for
>     BU27010 as we did for BU27008 - driver sets same gain selector for all
>     channels but shows the gains separately for all channels so users
>     can (at least in theory) detect this 1X vs 2X madness...
>   - BU27010 has suffled all the control register bitfields to new
>     addresses and bit positions while still keeping the register naming
>     same.
>   - Some more power/reset control is added.
>   - FIFO for "flickering detection" is added.
> 
> The control register suffling made this slightly nasty. Still, it is
> easier for maintenance perspective to add the BU27010 support in BU27008
> driver because - even though the bit positions/addresses were changed -
> most of the driver structure can be re-used. Writing own driver for
> BU27010 would mean plenty of duplicate code albeit a tad more clarity.
> 
> The flickering FIFO is not supported by the driver.
> 
> Add BU27010 RGBC+IR support to rohm-bu27008 driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Resulting code looks more or less fine, but there is stuff in here that
belongs in previous patch - so send a v2 with the refactors all done
there and just support for the new part in here.

Thanks,

Jonathan

...


> +
>  static int bu27008_chip_init(struct bu27008_data *data);
>  static int bu27008_write_gain_sel(struct bu27008_data *data, int sel);
>  static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel);
>  
> +static int bu27010_chip_init(struct bu27008_data *data);
> +static int bu27010_get_gain_sel(struct bu27008_data *data, int *sel);
> +static int bu27010_write_gain_sel(struct bu27008_data *data, int sel);
> +
> +static const struct bu27_chip_data bu27010_chip = {
> +	.name = "bu27010",
> +	.chip_init = bu27010_chip_init,
> +	.get_gain_sel = bu27010_get_gain_sel,
> +	.write_gain_sel = bu27010_write_gain_sel,
> +	.scale1x = BU27010_SCALE_1X,
> +	.part_id = BU27010_ID,
> +	.regmap_cfg = &bu27010_regmap,
> +	.drdy_en_reg = BU27010_REG_MODE_CONTROL4,
> +	.drdy_en_mask = BU27010_DRDY_EN,
> +	.valid_reg = BU27010_REG_MODE_CONTROL5,
> +	.meas_en_reg = BU27010_REG_MODE_CONTROL5,
> +	.meas_en_mask = BU27010_MASK_MEAS_EN,
> +	.chan_sel_reg = BU27008_REG_MODE_CONTROL1,
> +	.chan_sel_mask = BU27010_MASK_CHAN_SEL,
> +	.int_time_mask = BU27010_MASK_MEAS_MODE,
> +	.gains = &bu27010_gains[0],
> +	.num_gains = ARRAY_SIZE(bu27010_gains),
> +	.gains_ir = &bu27010_gains_ir[0],
> +	.num_gains_ir = ARRAY_SIZE(bu27010_gains_ir),
> +	.itimes = &bu27010_itimes[0],
> +	.num_itimes = ARRAY_SIZE(bu27010_itimes),
> +};
> +
>  static const struct bu27_chip_data bu27008_chip = {
>  	.name = "bu27008",
>  	.chip_init = bu27008_chip_init,
> @@ -332,6 +529,8 @@ static const struct bu27_chip_data bu27008_chip = {
>  	.num_gains = ARRAY_SIZE(bu27008_gains),
>  	.gains_ir = &bu27008_gains_ir[0],
>  	.num_gains_ir = ARRAY_SIZE(bu27008_gains_ir),
> +	.itimes = &bu27008_itimes[0],
> +	.num_itimes = ARRAY_SIZE(bu27008_itimes),
>  };
>  
>  #define BU27008_MAX_VALID_RESULT_WAIT_US	50000
> @@ -358,6 +557,31 @@ static int bu27008_chan_read_data(struct bu27008_data *data, int reg, int *val)
>  	return ret;
>  }
>  
> +static int bu27010_get_gain_sel(struct bu27008_data *data, int *sel)
> +{
> +	int ret;
> +
> +	/*
> +	 * We always "lock" the gain selectors for all channels to prevent
> +	 * unsupported configs. It does not matter which channel is used
> +	 * we can just return selector from any of them.
> +	 */
> +	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, sel);
> +	if (!ret) {
	if (ret)
		return ret;

	....

> +		int tmp;
> +
> +		*sel = FIELD_GET(BU27010_MASK_DATA0_GAIN, *sel);
> +
> +		ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		*sel |= FIELD_GET(BU27010_MASK_RGBC_GAIN, tmp) << fls(BU27010_MASK_DATA0_GAIN);
> +	}
> +
> +	return ret;
> +}
> +
>  static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel)
>  {
>  	int ret;
> @@ -388,7 +612,7 @@ static int bu27008_get_gain(struct bu27008_data *data, struct iio_gts *gts, int
>  {
>  	int ret, sel;
>  
> -	ret = bu27008_get_gain_sel(data, &sel);
> +	ret = data->cd->get_gain_sel(data, &sel);
Again, belongs in previous patch.
>  	if (ret)
>  		return ret;
>  
> @@ -403,6 +627,35 @@ static int bu27008_get_gain(struct bu27008_data *data, struct iio_gts *gts, int
>  	return 0;
>  }
>  
> +static int bu27010_write_gain_sel(struct bu27008_data *data, int sel)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	/*
> +	 * Gain 'selector' is composed of two registers. Selector is 6bit value,
> +	 * 4 high bits being the RGBC gain fieild in MODE_CONTROL1 register and
> +	 * two low bits being the channel specific gain in MODE_CONTROL2.
> +	 *
> +	 * Let's take the 4 high bits of whole 6 bit selector, and prepare
> +	 * the MODE_CONTROL1 value (RGBC gain part).
> +	 */
> +	regval = FIELD_PREP(BU27010_MASK_RGBC_GAIN, (sel >> 2));
> +
> +	ret = regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
> +				  BU27010_MASK_RGBC_GAIN, regval);

ret not checked.

> +	/*
> +	 * Two low two bits must be set for all 4 channels in the
> +	 * MODE_CONTROL2 register. Copy these two bits for all channels.
> +	 */
> +	regval = sel & GENMASK(1, 0);

FIELD_PREP and all fields explicitly set.

> +	regval = regval | regval >> 2 | regval >> 4 | regval >> 6;
> +
> +	ret = regmap_write(data->regmap, BU27008_REG_MODE_CONTROL2, regval);
return regmap_write...

> +
> +	return ret;
> +}
> +
>  static int bu27008_write_gain_sel(struct bu27008_data *data, int sel)
>  {
>  	int regval;
> @@ -452,7 +705,7 @@ static int bu27008_set_gain(struct bu27008_data *data, int gain)
>  	if (ret < 0)
>  		return ret;
>  
> -	return bu27008_write_gain_sel(data, ret);
> +	return data->cd->write_gain_sel(data, ret);
Another one that wants to be in the refactor patch  - not here.

>  }
>  
>  static int bu27008_get_int_time_sel(struct bu27008_data *data, int *sel)
> @@ -460,13 +713,15 @@ static int bu27008_get_int_time_sel(struct bu27008_data *data, int *sel)
>  	int ret, val;
>  
>  	ret = regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &val);
> +	if (ret)
> +		return ret;
>  
>  	val &= data->cd->int_time_mask;
>  	val >>= ffs(data->cd->int_time_mask) - 1;
>  
>  	*sel = val;
>  
> -	return ret;
> +	return 0;

This looks unrelated / fix for previous patch?

>  }
>  
>  static int bu27008_set_int_time_sel(struct bu27008_data *data, int sel)
> @@ -759,7 +1014,7 @@ static int bu27008_set_scale(struct bu27008_data *data,
>  			goto unlock_out;
>  
>  	}
> -	ret = bu27008_write_gain_sel(data, gain_sel);
> +	ret = data->cd->write_gain_sel(data, gain_sel);

As below - make all these sort of refactoring changes in previous patch.

>  
>  unlock_out:
>  	mutex_unlock(&data->mutex);
> @@ -867,6 +1122,55 @@ static const struct iio_info bu27008_info = {
>  	.validate_trigger = iio_validate_own_trigger,
>  };
>  
> +static int bu27010_chip_init(struct bu27008_data *data)
> +{
> +	int ret;
> +
> +	/* Reset the IC to initial power-off state */

I'd argue the code is clear enough the comment adds little.

> +	ret = regmap_write_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
> +				BU27010_MASK_SW_RESET, BU27010_MASK_SW_RESET);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> +
> +	msleep(1);
> +
> +	/* Power ON*/
> +	ret = regmap_write_bits(data->regmap, BU27010_REG_POWER,
> +				BU27010_MASK_POWER, BU27010_MASK_POWER);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Sensor power-on failed\n");
> +
> +	msleep(1);
> +
> +	/* Release blocks from reset */
> +	ret = regmap_write_bits(data->regmap, BU27010_REG_RESET,
> +				BU27010_MASK_RESET, BU27010_RESET_RELEASE);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Sensor powering failed\n");
> +
> +	msleep(1);
> +
> +	/*
> +	 * The IRQ enabling on BU27010 is done in a peculiar way. The IRQ
> +	 * enabling is not a bit mask where individual IRQs could be enabled but
> +	 * a field which values are:
> +	 * 00 => IRQs disabled
> +	 * 01 => Data-ready (RGBC/IR)
> +	 * 10 => Data-ready (flicker)
> +	 * 11 => Flicker FIFO
> +	 *

That's nasty :)

> +	 * So, only one IRQ can be enabled at a time and enabling for example
> +	 * flicker FIFO would automagically disable data-ready IRQ.
> +	 *
> +	 * Currently the driver does not support the flicker. Hence, we can
> +	 * just treat the RGBC data-ready as single bit which can be enabled /
> +	 * disabled. This works for as long as the second bit in the field
> +	 * stays zero. Here we ensure it gets zeroed.
> +	 */
> +	return regmap_clear_bits(data->regmap, BU27010_REG_MODE_CONTROL4,
> +				 BU27010_IRQ_DIS_ALL);
> +}
> +
>  static int bu27008_chip_init(struct bu27008_data *data)
>  {
>  	int ret;
> @@ -1068,14 +1372,14 @@ static int bu27008_probe(struct i2c_client *i2c)
>  		dev_warn(dev, "unknown device 0x%x\n", part_id);
>  
>  	ret = devm_iio_init_iio_gts(dev, data->cd->scale1x, 0, data->cd->gains,
> -				    data->cd->num_gains, bu27008_itimes,
> -				    ARRAY_SIZE(bu27008_itimes), &data->gts);
> +				    data->cd->num_gains, data->cd->itimes,
> +				    data->cd->num_itimes, &data->gts);
>  	if (ret)
>  		return ret;
>  
>  	ret = devm_iio_init_iio_gts(dev, data->cd->scale1x, 0, data->cd->gains_ir,
> -				    data->cd->num_gains_ir, bu27008_itimes,
> -				    ARRAY_SIZE(bu27008_itimes), &data->gts_ir);
> +				    data->cd->num_gains_ir, data->cd->itimes,
> +				    data->cd->num_itimes, &data->gts_ir);

I'd expect the changes to make things part specific to all be in previous patch
- not mixed across that one and this one.


>  	if (ret)
>  		return ret;


