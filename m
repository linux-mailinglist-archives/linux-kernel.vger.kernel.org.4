Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A15664BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjAJSxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbjAJSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:53:11 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125326CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:50:47 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id FJhqp8DrgidowFJhqp2KIp; Tue, 10 Jan 2023 19:50:45 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 10 Jan 2023 19:50:45 +0100
X-ME-IP: 86.243.100.34
Message-ID: <c4b5c190-5fb5-17f2-69ce-7137ef7f33db@wanadoo.fr>
Date:   Tue, 10 Jan 2023 19:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7924: add Texas Instruments
 ADS7924 driver
Content-Language: fr
To:     Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230110160124.3853593-1-hugo@hugovil.com>
 <20230110160124.3853593-2-hugo@hugovil.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230110160124.3853593-2-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/01/2023 à 17:01, Hugo Villeneuve a écrit :
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The Texas Instruments ADS7924 is a 4 channels, 12-bit analog to
> digital converter (ADC) with an I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads7924
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---

Hi,

should there be a v3, a few nits below.

CJ

>   MAINTAINERS                  |   7 +
>   drivers/iio/adc/Kconfig      |  11 +
>   drivers/iio/adc/Makefile     |   1 +
>   drivers/iio/adc/ti-ads7924.c | 492 +++++++++++++++++++++++++++++++++++
>   4 files changed, 511 insertions(+)
>   create mode 100644 drivers/iio/adc/ti-ads7924.c
> 

[...]

> +static int ads7924_get_channels_config(struct i2c_client *client,
> +				       struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *priv = iio_priv(indio_dev);
> +	struct device *dev = priv->dev;
> +	struct fwnode_handle *node;
> +	int num_channels = 0;
> +
> +	device_for_each_child_node(dev, node) {
> +		u32 pval;
> +		unsigned int channel;
> +
> +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n", node);
> +			continue;
> +		}
> +
> +		channel = pval;
> +		if (channel >= ADS7924_CHANNELS) {
> +			dev_err(dev, "invalid channel index %d on %pfw\n",
> +				channel, node);
> +			continue;
> +		}
> +
> +		num_channels++;
> +	}
> +
> +	if (num_channels > 0) {
> +		dev_dbg(dev, "found %d ADC channels\n", num_channels);
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}

	if (num_channels <= 0)
		return -EINVAL;

	dev_dbg(dev, "found %d ADC channels\n", num_channels);
	return 0;

is much more usual.

> +}
> +

[...]

> +static int ads7924_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads7924_data *data = iio_priv(indio_dev);
> +
> +	if (data->reset_gpio) {
> +		gpiod_set_value(data->reset_gpio, 1); /* Assert. */
> +		/* Educated guess: assert time not specified in datasheet... */
> +		mdelay(100);
> +		gpiod_set_value(data->reset_gpio, 0); /* Deassert. */
> +	} else {
> +		int ret;

having 'ret' near 'struct ads7924_data *data' is more usual and saves 1 LoC.

> +
> +		/*
> +		 * A write of 10101010 to this register will generate a
> +		 * software reset of the ADS7924.
> +		 */
> +		ret = regmap_write(data->regmap, ADS7924_RESET_REG, 0b10101010);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +};

