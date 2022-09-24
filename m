Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604CB5E8E95
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiIXQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiIXQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49D3BC43;
        Sat, 24 Sep 2022 09:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898FA6148D;
        Sat, 24 Sep 2022 16:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE102C433D6;
        Sat, 24 Sep 2022 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664037959;
        bh=CDCusbtzZCdsfrWo/f/JHWe00c2E9k9abFe0a7tVAps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bKf6paN/mrZxYsYKl5ouPkyqLF1b3X6Rompx1/eSx+9US7OvSLlxKzMQlpB27F0+u
         ZP9HWslRqqoZWbfPuYLoSQW4oDsbzux2b4HbtbOPA9eE0iPZHIMj+3UTXcZi5JqoX7
         5MaieVjfi8ODOxzVVsF+kFR3yPhLlouiL/qU8D1CCnfvdv7KpM/TPPpuMv7PKDVRBf
         s55m+jvA8CF8hl5Oy2/K1NWDQz+OwCN+T/xNqP7P8gDRyecwgCQyq0WZbKi6H7ydd/
         Y9J6HRPwHhsWPfVO39BGyhH/QH5arQmW2VNeqMeBRqU+8RC2VWWhPqYKkHn/F+KNaY
         uJkxv/fTrZBxQ==
Date:   Sat, 24 Sep 2022 17:46:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: mcp3911: add support to set PGA
Message-ID: <20220924174607.5cf8019f@jic23-huawei>
In-Reply-To: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
References: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 22 Sep 2022 21:46:39 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Add support for setting the Programmable Gain Amplifiers by adjust the
> scale value.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing.

I considered slipping this into my 2nd IIO pull request for this cycle
at the last minute, but wasn't happy skipping normal time being beaten on
by 0-day and time in next, so I didn't.  Hence this probably won't make
6.1, but Linus did hint he might do an rc8 in which case I may see
if GregKH will take a 3rd pull late next week.

If not, it'll be 6.2 material.

Thanks,

Jonathan

> ---
> 
> Notes:
>     Based on
>     Link: https://lore.kernel.org/all/20220815061625.35568-1-marcus.folkesson@gmail.com/
>     
>     But with tmp0, tmp1 and tmp2 removed as those are not needed.
>     Link: https://lore.kernel.org/all/202209220648.Wb6EtPat-lkp@intel.com/
> 
>  drivers/iio/adc/mcp3911.c | 104 +++++++++++++++++++++++++++++---------
>  1 file changed, 80 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 0151258b456c..0d768006eabb 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -29,6 +29,8 @@
>  #define MCP3911_REG_MOD			0x06
>  #define MCP3911_REG_PHASE		0x07
>  #define MCP3911_REG_GAIN		0x09
> +#define MCP3911_GAIN_MASK(ch)		(GENMASK(2, 0) << 3 * ch)
> +#define MCP3911_GAIN_VAL(ch, val)      ((val << 3 * ch) & MCP3911_GAIN_MASK(ch))
>  
>  #define MCP3911_REG_STATUSCOM		0x0a
>  #define MCP3911_STATUSCOM_DRHIZ         BIT(12)
> @@ -59,8 +61,10 @@
>  #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
>  
>  #define MCP3911_NUM_CHANNELS		2
> +#define MCP3911_NUM_SCALES		6
>  
>  static const int mcp3911_osr_table[] = { 32, 64, 128, 256, 512, 1024, 2048, 4096 };
> +static u32 mcp3911_scale_table[MCP3911_NUM_SCALES][2];
>  
>  struct mcp3911 {
>  	struct spi_device *spi;
> @@ -69,6 +73,7 @@ struct mcp3911 {
>  	struct clk *clki;
>  	u32 dev_addr;
>  	struct iio_trigger *trig;
> +	u32 gain[MCP3911_NUM_CHANNELS];
>  	struct {
>  		u32 channels[MCP3911_NUM_CHANNELS];
>  		s64 ts __aligned(8);
> @@ -145,6 +150,11 @@ static int mcp3911_read_avail(struct iio_dev *indio_dev,
>  		*vals = mcp3911_osr_table;
>  		*length = ARRAY_SIZE(mcp3911_osr_table);
>  		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*vals = (int *)mcp3911_scale_table;
> +		*length = ARRAY_SIZE(mcp3911_scale_table) * 2;
> +		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -189,29 +199,9 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
>  		break;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		if (adc->vref) {
> -			ret = regulator_get_voltage(adc->vref);
> -			if (ret < 0) {
> -				dev_err(indio_dev->dev.parent,
> -					"failed to get vref voltage: %d\n",
> -				       ret);
> -				goto out;
> -			}
> -
> -			*val = ret / 1000;
> -		} else {
> -			*val = MCP3911_INT_VREF_MV;
> -		}
> -
> -		/*
> -		 * For 24bit Conversion
> -		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> -		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> -		 */
> -
> -		/* val2 = (2^23 * 1.5) */
> -		*val2 = 12582912;
> -		ret = IIO_VAL_FRACTIONAL;
> +		*val = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][0];
> +		*val2 = mcp3911_scale_table[ilog2(adc->gain[channel->channel])][1];
> +		ret = IIO_VAL_INT_PLUS_NANO;
>  		break;
>  	}
>  
> @@ -229,6 +219,18 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&adc->lock);
>  	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> +			if (val == mcp3911_scale_table[i][0] &&
> +				val2 == mcp3911_scale_table[i][1]) {
> +
> +				adc->gain[channel->channel] = BIT(i);
> +				ret = mcp3911_update(adc, MCP3911_REG_GAIN,
> +						MCP3911_GAIN_MASK(channel->channel),
> +						MCP3911_GAIN_VAL(channel->channel, i), 1);
> +			}
> +		}
> +		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		if (val2 != 0) {
>  			ret = -EINVAL;
> @@ -264,6 +266,44 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int mcp3911_calc_scale_table(struct mcp3911 *adc)
> +{
> +	u32 ref = MCP3911_INT_VREF_MV;
> +	u32 div;
> +	int ret;
> +	u64 tmp;
> +
> +	if (adc->vref) {
> +		ret = regulator_get_voltage(adc->vref);
> +		if (ret < 0) {
> +			dev_err(&adc->spi->dev,
> +				"failed to get vref voltage: %d\n",
> +			       ret);
> +			return ret;
> +		}
> +
> +		ref = ret / 1000;
> +	}
> +
> +	/*
> +	 * For 24-bit Conversion
> +	 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
> +	 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
> +	 *
> +	 * ref = Reference voltage
> +	 * div = (2^23 * 1.5 * gain) = 12582912 * gain
> +	 */
> +	for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
> +		div = 12582912 * BIT(i);
> +		tmp = div_s64((s64)ref * 1000000000LL, div);
> +
> +		mcp3911_scale_table[i][0] = 0;
> +		mcp3911_scale_table[i][1] = tmp;
> +	}
> +
> +	return 0;
> +}
> +
>  #define MCP3911_CHAN(idx) {					\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
> @@ -273,8 +313,10 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_OFFSET) |		\
>  			BIT(IIO_CHAN_INFO_SCALE),		\
> -		.info_mask_shared_by_type_available =		\
> +		.info_mask_shared_by_type_available =           \
>  			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		.info_mask_separate_available =			\
> +			BIT(IIO_CHAN_INFO_SCALE),		\
>  		.scan_type = {					\
>  			.sign = 's',				\
>  			.realbits = 24,				\
> @@ -483,6 +525,20 @@ static int mcp3911_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = mcp3911_calc_scale_table(adc);
> +	if (ret)
> +		return ret;
> +
> +       /* Set gain to 1 for all channels */
> +	for (int i = 0; i < MCP3911_NUM_CHANNELS; i++) {
> +		adc->gain[i] = 1;
> +		ret = mcp3911_update(adc, MCP3911_REG_GAIN,
> +				MCP3911_GAIN_MASK(i),
> +				MCP3911_GAIN_VAL(i, 0), 1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mcp3911_info;

