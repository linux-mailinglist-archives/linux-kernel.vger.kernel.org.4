Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375C4701E59
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjENRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjENRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:00:47 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE303C0A
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:00:43 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id yF5Gptvct0mnzyF5HpzTYd; Sun, 14 May 2023 19:00:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684083642;
        bh=kwdEt+nhIevT/nV5jYgb0d1y6AicLUM3sr6p4iWxPOk=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=O6uo/asRYQ5IiGiP4W7iA2N11KQ5W1oZbifVuza6uohA3Q7rQl/cT9Oah+i8/wnhf
         KdJ5U8Qi4S9L/henIwJewMqGAC+drJtKMdqScxyORgm+fQB7O116Yr8d99PePWRVs3
         TO2lCDlbSPmKLm5v0aRHxO1e++ROOUNoTgNHmmHegYt7VlwEloUF3aNkUASvzNXLs5
         m5xOc3P5UGDsSWGH/7J/VblU4fFtmBXivuvfCTRncEJ7Alco4VuDwC6dMErR1Zwt4A
         9DJ6n0rAPzGBIIC7jVnIr/WH+cAYoQKbVTNgCP1NRZ1HjTP44LtweFT5/xcGFTW/Wg
         MkrgTwqFW9AZQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 May 2023 19:00:41 +0200
X-ME-IP: 86.243.2.178
Message-ID: <9ae3f111-e13b-cdd7-317d-316585390952@wanadoo.fr>
Date:   Sun, 14 May 2023 19:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] thermal/drivers/sun8i: Fix some error handling paths in
 sun8i_ths_probe()
Content-Language: fr
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <26f9e3bb3fcd0c12ea24a44c75b7960da993b68b.1684077651.git.christophe.jaillet@wanadoo.fr>
 <yd37pz2nbs2i5m4a5avonj4w7ili4kx7d7w7fgbiss7z26jnfy@rwytm26i6v7h>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <yd37pz2nbs2i5m4a5avonj4w7ili4kx7d7w7fgbiss7z26jnfy@rwytm26i6v7h>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 14/05/2023 à 17:35, Ondřej Jirman a écrit :
> Hello Christophe,
> 
> On Sun, May 14, 2023 at 05:21:35PM +0200, Christophe JAILLET wrote:
>>
>> Should an error occur after calling sun8i_ths_resource_init() in the probe
>> function, some resources need to be released, as already done in the
>> .remove() function.
>>
>> Switch to the devm_clk_get_enabled() helper and add a new devm_action to
>> turn sun8i_ths_resource_init() into a fully managed function.
>>
>> This fixes the issue and removes some LoC at the same time.
>>
>> Fixes: dccc5c3b6f30 ("thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This changes the order of the release functions, but should be fine.
>> ---
>>   drivers/thermal/sun8i_thermal.c | 43 +++++++++------------------------
>>   1 file changed, 12 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
>> index 793ddce72132..8f4c29bc85aa 100644
>> --- a/drivers/thermal/sun8i_thermal.c
>> +++ b/drivers/thermal/sun8i_thermal.c
>> @@ -319,6 +319,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
>>   	return ret;
>>   }
>>   
>> +static void sun8i_ths_reset_control_assert(void *data)
>> +{
>> +	reset_control_assert(data);
>> +}
>> +
>>   static int sun8i_ths_resource_init(struct ths_device *tmdev)
>>   {
>>   	struct device *dev = tmdev->dev;
>> @@ -339,13 +344,13 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>>   		if (IS_ERR(tmdev->reset))
>>   			return PTR_ERR(tmdev->reset);
>>   
>> -		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
>> +		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
>>   		if (IS_ERR(tmdev->bus_clk))
>>   			return PTR_ERR(tmdev->bus_clk);
>>   	}
>>   
>>   	if (tmdev->chip->has_mod_clk) {
>> -		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
>> +		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
> 
> This changes the recommeded order of reset release/clock enable steps, eg. A64
> manual says:
> 
> 	3.3.6.4. Gating and reset
> 
> 	Make sure that the reset signal has been released before the release of
> 	module clock gating;

Ok, so moving reset_control_deassert() (and my proposed 
devm_add_action_or_reset()) just after devm_reset_control_get() should 
keep the expected order, right?

CJ

> 
> kind regards,
> 	o.
> 
>>   		if (IS_ERR(tmdev->mod_clk))
>>   			return PTR_ERR(tmdev->mod_clk);
>>   	}
>> @@ -354,32 +359,20 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = clk_prepare_enable(tmdev->bus_clk);
>> +	ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
>> +				       tmdev->reset);
>>   	if (ret)
>> -		goto assert_reset;
>> +		return ret;
>>   
>>   	ret = clk_set_rate(tmdev->mod_clk, 24000000);
>>   	if (ret)
>> -		goto bus_disable;
>> -
>> -	ret = clk_prepare_enable(tmdev->mod_clk);
>> -	if (ret)
>> -		goto bus_disable;
>> +		return ret;
>>   
>>   	ret = sun8i_ths_calibrate(tmdev);
>>   	if (ret)
>> -		goto mod_disable;
>> +		return ret;
>>   
>>   	return 0;
>> -
>> -mod_disable:
>> -	clk_disable_unprepare(tmdev->mod_clk);
>> -bus_disable:
>> -	clk_disable_unprepare(tmdev->bus_clk);
>> -assert_reset:
>> -	reset_control_assert(tmdev->reset);
>> -
>> -	return ret;
>>   }
>>   
>>   static int sun8i_h3_thermal_init(struct ths_device *tmdev)
>> @@ -530,17 +523,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -static int sun8i_ths_remove(struct platform_device *pdev)
>> -{
>> -	struct ths_device *tmdev = platform_get_drvdata(pdev);
>> -
>> -	clk_disable_unprepare(tmdev->mod_clk);
>> -	clk_disable_unprepare(tmdev->bus_clk);
>> -	reset_control_assert(tmdev->reset);
>> -
>> -	return 0;
>> -}
>> -
>>   static const struct ths_thermal_chip sun8i_a83t_ths = {
>>   	.sensor_num = 3,
>>   	.scale = 705,
>> @@ -642,7 +624,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
>>   
>>   static struct platform_driver ths_driver = {
>>   	.probe = sun8i_ths_probe,
>> -	.remove = sun8i_ths_remove,
>>   	.driver = {
>>   		.name = "sun8i-thermal",
>>   		.of_match_table = of_ths_match,
>> -- 
>> 2.34.1
>>
> 

