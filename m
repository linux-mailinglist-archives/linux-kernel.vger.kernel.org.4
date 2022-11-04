Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A56193CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKDJrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKDJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:46:53 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4946317
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:46:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id qtHkoE990iBgAqtHkogqeF; Fri, 04 Nov 2022 10:46:49 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Nov 2022 10:46:49 +0100
X-ME-IP: 86.243.100.34
Message-ID: <1325d0d4-1bff-af36-08c2-b4a9f01a4cd0@wanadoo.fr>
Date:   Fri, 4 Nov 2022 10:46:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/4] iio: frequency: adf4377: add support for ADF4377
Content-Language: fr
To:     antoniu.miclaus@analog.com
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
 <20221104092802.90725-3-antoniu.miclaus@analog.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20221104092802.90725-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/11/2022 à 10:28, Antoniu Miclaus a écrit :
> The ADF4377 is a high performance, ultralow jitter, dual output integer-N
> phased locked loop (PLL) with integrated voltage controlled oscillator
> (VCO) ideally suited for data converter and mixed signal front end (MxFE)
> clock applications.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4377.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---

[]

> +static int adf4377_properties_parse(struct adf4377_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +
> +	st->clkin = devm_clk_get(&spi->dev, "ref_in");

Hi,

this could be devm_clk_get_enabled() in order to...

> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the reference input clock\n");
> +
> +	st->gpio_ce = devm_gpiod_get_optional(&st->spi->dev, "ce-en",
> +					      GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_ce))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_ce),
> +				     "failed to get the CE GPIO\n");
> +
> +	st->gpio_enclk1 = devm_gpiod_get_optional(&st->spi->dev, "enclk1",
> +						  GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_enclk1))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
> +				     "failed to get the CE GPIO\n");
> +
> +	if (st->type == ADF4377) {
> +		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "enclk2",
> +							  GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->gpio_enclk2))
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> +					     "failed to get the CE GPIO\n");
> +	}
> +
> +	return 0;
> +}
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
> +static void adf4377_clk_disable(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}

... remove this...

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
> +	st->type = spi_get_device_id(spi)->driver_data;
> +	mutex_init(&st->lock);
> +
> +	ret = adf4377_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;

... and this...

> +
> +	ret = devm_add_action_or_reset(&spi->dev, adf4377_clk_disable, st->clkin);
> +	if (ret)
> +		return ret;

... and this.

CJ

> +
> +	st->nb.notifier_call = adf4377_freq_change;
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = adf4377_init(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "adf4377 init failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

[]

