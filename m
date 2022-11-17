Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986AC62E6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240981AbiKQVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiKQVSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:18:41 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E9E87A49
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:16:43 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id vmFUoQx51FUJ3vmFUoimeH; Thu, 17 Nov 2022 22:16:41 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 17 Nov 2022 22:16:41 +0100
X-ME-IP: 86.243.100.34
Message-ID: <4fe0c7c3-f5eb-4c01-8607-ce79a768cb06@wanadoo.fr>
Date:   Thu, 17 Nov 2022 22:16:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] Input: cyttsp5 - add vddio regulator
Content-Language: fr, en-US
To:     linmengbo0689@protonmail.com
Cc:     alistair@alistair23.me, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
 <20221117190507.87535-3-linmengbo0689@protonmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221117190507.87535-3-linmengbo0689@protonmail.com>
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

Le 17/11/2022 à 20:05, Lin, Meng-Bo a écrit :
> The Samsung touchscreen controllers are often used with external pull-up
> for the interrupt line and the I2C lines, so we might need to enable
> a regulator to bring the lines into usable state. Otherwise, this might
> cause spurious interrupts and reading from I2C will fail.
> 
> Implement support for a "vddio-supply" that is enabled by the cyttsp5
> driver so that the regulator gets enabled when needed.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689-g/b1ySJe57IN+BqQ9rBEUg@public.gmane.org>
> ---
>   drivers/input/touchscreen/cyttsp5.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index 24ab1df9fc07..d02fdb940edf 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -190,7 +190,7 @@ struct cyttsp5 {
>   	int num_prv_rec;
>   	struct regmap *regmap;
>   	struct touchscreen_properties prop;
> -	struct regulator *vdd;
> +	struct regulator_bulk_data supplies[2];
>   };
>   
>   /*
> @@ -767,7 +767,7 @@ static void cyttsp5_cleanup(void *data)
>   {
>   	struct cyttsp5 *ts = data;
>   
> -	regulator_disable(ts->vdd);
> +	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
>   }
>   
>   static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
> @@ -790,9 +790,12 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
>   	init_completion(&ts->cmd_done);
>   
>   	/* Power up the device */
> -	ts->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(ts->vdd)) {
> -		error = PTR_ERR(ts->vdd);
> +	ts->supplies[0].supply = "vdd";
> +	ts->supplies[1].supply = "vddio";
> +	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies),
> +				      ts->supplies);
> +	if (error < 0) {
> +		dev_err(ts->dev, "Failed to get regulators, error %d\n", error);

Hi,

dev_err_probe()?
I think that devm_regulator_bulk_get() can return -EPROBE_DEFER;

>   		return error;
>   	}
>   
> @@ -800,9 +803,11 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
>   	if (error)
>   		return error;
>   
> -	error = regulator_enable(ts->vdd);
> -	if (error)
> +	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
> +	if (error < 0) {
> +		dev_err(ts->dev, "Failed to enable regulators, error %d\n", error);

Eventually, the same here in order to be consistent.

CJ

>   		return error;
> +	}
>   
>   	ts->input = devm_input_allocate_device(dev);
>   	if (!ts->input) {

