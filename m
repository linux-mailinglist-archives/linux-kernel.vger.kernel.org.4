Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55826C9629
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 17:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjCZPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 11:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 11:34:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C893C03;
        Sun, 26 Mar 2023 08:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08A4BB80C99;
        Sun, 26 Mar 2023 15:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88356C433EF;
        Sun, 26 Mar 2023 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679844857;
        bh=6N1CM0BMct/WodBmb4TqZFcmzrXrVAJtt2Z9xJ1FlL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WOBAbDa9p8nIH6V/vbzJJUEwAbwvRlQuayxNLOFzc8kTSjqgSNvYX4eKubdE3lDdc
         rmIHswANTiKXn68mFVaYEzK4yU2sjjp5T3vNtgW3bNor2tdhz8phpzpuwGBxz75M1J
         LseHEho4JL1FzpiUWohkA5Op6nqZuhdQSHjiL4Kw6lZECwUsl7Cx9gzYxe5J0215r0
         UcG0baIOhxRcu1gTuU506qocz1gHv/iFxbfvz6eRC2v73Dc/L22s9PS21Oyb/jHE9A
         3CZr+N44Lr0erd7skXt+lf5OqfNewpewh6oTCc5T2Hu20JCKRBBbBUjfeTTVN5YZLI
         Fho1yzXuJyeiA==
Date:   Sun, 26 Mar 2023 16:49:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <20230326164920.1e4575f9@jic23-huawei>
In-Reply-To: <20230324030916.396569-1-william.gray@linaro.org>
References: <20230324030916.396569-1-william.gray@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 23:09:16 -0400
William Breathitt Gray <william.gray@linaro.org> wrote:

> The regmap API supports IO port accessors so we can take advantage of
> regmap abstractions rather than handling access to the device registers
> directly in the driver.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

I would have preferred slightly if you had avoided reording the probe
(previously gpio chip was registered before iio device and now it is after)
but it make no real difference so I'm not that bothered.

A few other minor comments. Biggest one being that the defines should be
prefixed.

Thanks,

Jonathan


>  	  integrated analog PC/104 card.
> diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
> index e45b70aa5bb7..6d65c163e47f 100644
> --- a/drivers/iio/addac/stx104.c
> +++ b/drivers/iio/addac/stx104.c

> +#define AIO_BASE 0x0
> +#define SOFTWARE_STROBE AIO_BASE
> +#define ADC_DATA AIO_BASE
> +#define ADC_CHANNEL (AIO_BASE + 0x2)
> +#define DIO_REG (AIO_BASE + 0x3)
> +#define DAC_BASE (AIO_BASE + 0x4)
> +#define ADC_STATUS (AIO_BASE + 0x8)
> +#define ADC_CONTROL (AIO_BASE + 0x9)
> +#define ADC_CONFIGURATION (AIO_BASE + 0x11)
> +
> +#define AIO_DATA_STRIDE 2
> +#define DAC_OFFSET(_channel) (DAC_BASE + AIO_DATA_STRIDE * (_channel))
> +
> +/* ADC Channel */
> +#define FC GENMASK(3, 0)
> +#define LC GENMASK(7, 4)
> +#define SAME_CHANNEL(_channel) (u8_encode_bits(_channel, FC) | u8_encode_bits(_channel, LC))
> +
> +/* ADC Status */
> +#define SD BIT(5)
> +#define CNV BIT(7)
> +#define DIFFERENTIAL 1
> +
> +/* ADC Control */
> +#define ALSS GENMASK(1, 0)
> +#define SOFTWARE_TRIGGER 0
> +
> +/* ADC Configuration */
> +#define GAIN GENMASK(1, 0)
> +#define ADBU BIT(2)
> +#define BIPOLAR 0
> +#define GAIN_X1 0
> +#define GAIN_X2 1
> +#define GAIN_X4 2
> +#define GAIN_X8 3

Better to give these an STX104_ prefix to avoid potential name clash
problems in the future.

>  static int stx104_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
>  {

...

>  		/* trigger ADC sample capture by writing to the 8-bit
>  		 * Software Strobe Register and wait for completion
>  		 */
> -		iowrite8(0, &reg->ssr_ad);
> -		while (ioread8(&reg->cir_asr) & BIT(7));
> -
> -		*val = ioread16(&reg->ssr_ad);
> +		err = regmap_write(priv->aio_ctl_map, SOFTWARE_STROBE, 0);
> +		if (err)
> +			return err;
> +		do {
> +			err = regmap_read(priv->aio_ctl_map, ADC_STATUS, &adc_status);
> +			if (err)
> +				return err;
> +		} while (u8_get_bits(adc_status, CNV));

This looks like a polled regmap read.
It should probably have a timeout as well just in case the device is broken.
regmap_read_poll_timeout()?

That is a functional change however, so perhaps should be a follow up patch.
 
> +
> +		err = regmap_read(priv->aio_data_map, ADC_DATA, &value);
> +		if (err)
> +			return err;
> +		*val = value;
>  		return IIO_VAL_INT;

>  
>  static int stx104_probe(struct device *dev, unsigned int id)
>  {
>  	struct iio_dev *indio_dev;
>  	struct stx104_iio *priv;
> -	struct stx104_gpio *stx104gpio;
> +	struct gpio_regmap_config gpio_config = {};

You could fill this whole thing later with
	gpio_config = (struct gpio_regmap_config) {
		.parent = dev,
		... etc
	};
It might prove neater down there and would avoid need to
zero the whole thing up here (though hopefully the compiler
will figure out that is mostly not needed anyway).

> +	void __iomem *stx104_base;
> +	struct regmap *aio_ctl_map;
> +	struct regmap *aio_data_map;
> +	struct regmap *dio_map;
>  	int err;
> +	unsigned int adc_status;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
> -	if (!stx104gpio)
> -		return -ENOMEM;
> -
>  	if (!devm_request_region(dev, base[id], STX104_EXTENT,
>  		dev_name(dev))) {
>  		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
> @@ -332,16 +365,35 @@ static int stx104_probe(struct device *dev, unsigned int id)
>  		return -EBUSY;
>  	}
>  
> -	priv = iio_priv(indio_dev);
> -	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
> -	if (!priv->reg)
> +	stx104_base = devm_ioport_map(dev, base[id], STX104_EXTENT);
> +	if (!stx104_base)
>  		return -ENOMEM;
>  
> +	aio_ctl_map = devm_regmap_init_mmio(dev, stx104_base + AIO_BASE, &aio_ctl_regmap_config);
> +	if (IS_ERR(aio_ctl_map))
> +		return dev_err_probe(dev, PTR_ERR(aio_ctl_map),
> +				     "Unable to initialize aio_ctl register map\n");

Blank line here would slightly help readability as it keeps each set of call and error check
visually separated.

> +	aio_data_map = devm_regmap_init_mmio(dev, stx104_base + AIO_BASE, &aio_data_regmap_config);
> +	if (IS_ERR(aio_data_map))
> +		return dev_err_probe(dev, PTR_ERR(aio_data_map),
> +				     "Unable to initialize aio_data register map\n");

also here

> +	dio_map = devm_regmap_init_mmio(dev, stx104_base + DIO_REG, &dio_regmap_config);
> +	if (IS_ERR(dio_map))
> +		return dev_err_probe(dev, PTR_ERR(dio_map),
> +				     "Unable to initialize dio register map\n");
> +
> +	priv = iio_priv(indio_dev);
> +	priv->aio_ctl_map = aio_ctl_map;
> +	priv->aio_data_map = aio_data_map;

