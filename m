Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7C85B8B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiINPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiINPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:04:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A55F112;
        Wed, 14 Sep 2022 08:04:18 -0700 (PDT)
Received: from [185.122.133.20] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYTw0-0006kc-4b; Wed, 14 Sep 2022 17:04:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: auo-pixcir-ts - switch to using gpiod API
Date:   Wed, 14 Sep 2022 17:04:14 +0200
Message-ID: <2115487.irdbgypaU6@phil>
In-Reply-To: <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com> <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. September 2022, 16:14:25 CEST schrieb Dmitry Torokhov:
> This switches the driver to gpiod API and drops uses of of_get_gpio() API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/auo-pixcir-ts.c | 47 ++++++++++-------------
>  1 file changed, 20 insertions(+), 27 deletions(-)

[...]

> @@ -578,23 +566,28 @@ static int auo_pixcir_probe(struct i2c_client *client,
>  
>  	input_set_drvdata(ts->input, ts);
>  
> -	error = devm_gpio_request_one(&client->dev, ts->gpio_int,
> -				      GPIOF_DIR_IN, "auo_pixcir_ts_int");
> +	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
> +	error = PTR_ERR_OR_ZERO(ts->gpio_int);
>  	if (error) {
> -		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> -			ts->gpio_int, error);
> +		dev_err(&client->dev,
> +			"request of int gpio failed: %d\n", error);
>  		return error;
>  	}
>  
> -	error = devm_gpio_request_one(&client->dev, ts->gpio_rst,
> -				      GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
> -				      "auo_pixcir_ts_rst");
> +	gpiod_set_consumer_name(ts->gpio_int, "auo_pixcir_ts_int");
> +
> +	/* Take the chip out of reset */
> +	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
> +					    GPIOD_OUT_LOW);

hmm, is this really equivalent? It looks like above we're startig
with GPIOF_INIT_HIGH, while here it is LOW?

Looking at the old datasheet, yes gpio-high is the setting to
put the device into the usable state.

Interestingly there is no regulator support in the driver, the datahsheet
specifies 0.5ms for rst-low to rst-high after vdd_tp is turned on.

Heiko

Heiko


