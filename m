Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157DD6AACE3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCDWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 17:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCDWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 17:10:52 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32212F1F;
        Sat,  4 Mar 2023 14:10:51 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id x19-20020a4a3953000000b00525191358b6so1000699oog.12;
        Sat, 04 Mar 2023 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677967850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=emyjURM/cjyAgJld4vQ0Z6TU2e6a9bJ8XSXFO6qQhdk=;
        b=hugFh3fGM80yPOAhSLNYUt5JzlxJFvME/KXMLyqWql0rO9oGzQxd6oDPneItFan46A
         uOQ6tV2QBLySoKmIUvNKw/Zd1vnBhHuAO2vyb0aH49rp/RSRmUxHkZRaBy2YEQJCwtrf
         2wEV8Vx+MYUXnCxg7kJGz000rsxoFyNQINY0Su8xD1BTyOIK/GQPoe+3rkET3hplxrfj
         UU0z5nkd/0B81+xAmRHrxLD5eg+eEbubFVRo3rVvnz4kWdej4M5rAQENy5yf1Kl8BSy6
         qeY4ohyaxASuCG4sx6LrOvuGRDKCLpfJfD12/bTa3UQSspz7P6k71TDkNIRh24YzusqG
         yKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677967850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emyjURM/cjyAgJld4vQ0Z6TU2e6a9bJ8XSXFO6qQhdk=;
        b=hEXrmcxM6s/BpwBzLTQ79lPrPdwQECbxTWH0e3+pcxbjyT0k6qDsPVaS/2OgLMU5on
         8WHWPcnxJ/8/Y4Y5q1M3mRBzQDaJhz/MkYE2P5GcdP3zuafFm7yJkckgF+Dj25nDL1pZ
         n2+3f5YQ9Jzj/UBc38LXKzjt2CQ3m2/LzPg19PJFUBmyZS5lTkEQuf7EhMkpQnV1UI/F
         ZZSJVZSmKZJ+sh/YkczZxalJpccPwroxq1zE+eB8E2f1xYznkSczm6NH6/EgDWYxGzt4
         g4Q61oUMkRU787sFWvJ9pqTMkyBNfUvrncD19wDBGuUeOBDhNoGzuUq+cfDGySCVlSA/
         1a+g==
X-Gm-Message-State: AO0yUKUsxwYBikrU2IZZrFXjjbbodekyR03B3nC0m2D0lAgfOf2G3feh
        g3Sko+AjeFXdzS3zCVJHdjzzoPNAxDE=
X-Google-Smtp-Source: AK7set9A0gHUWhSPL2M+eiZxh8IRas8yZZFU/RVEwZKA8LkBMcFYkmDW58C2FTpaEt1ZgZwZpl4KOQ==
X-Received: by 2002:a4a:d34d:0:b0:51f:e2ab:5535 with SMTP id d13-20020a4ad34d000000b0051fe2ab5535mr2934527oos.0.1677967850442;
        Sat, 04 Mar 2023 14:10:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id zh33-20020a0568716ba100b001718e65a5d0sm2389300oab.57.2023.03.04.14.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 14:10:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <431a8ae1-54a7-e71a-484d-cab618a2a1c4@roeck-us.net>
Date:   Sat, 4 Mar 2023 14:10:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <93d115a2-702d-7d68-cd88-98f1c9f03f95@wanadoo.fr>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <93d115a2-702d-7d68-cd88-98f1c9f03f95@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/23 13:46, Christophe JAILLET wrote:
> Le 04/03/2023 à 17:56, Guenter Roeck a écrit :
>> The devm_clk_get[_optional]_enabled() helpers:
>>      - call devm_clk_get[_optional]()
>>      - call clk_prepare_enable() and register what is needed in order to
>>        call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code and avoids the calls to clk_disable_unprepare().
>>
>> While at it, use dev_err_probe consistently, and use its return value
>> to return the error code.
>>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/watchdog/s3c2410_wdt.c | 45 +++++++---------------------------
>>   1 file changed, 9 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>> index 200ba236a72e..a1fcb79b0b7c 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -661,35 +661,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>       if (IS_ERR(wdt->reg_base))
>>           return PTR_ERR(wdt->reg_base);
>> -    wdt->bus_clk = devm_clk_get(dev, "watchdog");
>> -    if (IS_ERR(wdt->bus_clk)) {
>> -        dev_err(dev, "failed to find bus clock\n");
>> -        return PTR_ERR(wdt->bus_clk);
>> -    }
>> -
>> -    ret = clk_prepare_enable(wdt->bus_clk);
>> -    if (ret < 0) {
>> -        dev_err(dev, "failed to enable bus clock\n");
>> -        return ret;
>> -    }
>> +    wdt->bus_clk = devm_clk_get_enabled(dev, "watchdog");
>> +    if (IS_ERR(wdt->bus_clk))
>> +        return dev_err_probe(dev, PTR_ERR(wdt->bus_clk), "failed to get bus clock\n");
>>       /*
>>        * "watchdog_src" clock is optional; if it's not present -- just skip it
>>        * and use "watchdog" clock as both bus and source clock.
>>        */
>> -    wdt->src_clk = devm_clk_get_optional(dev, "watchdog_src");
>> -    if (IS_ERR(wdt->src_clk)) {
>> -        dev_err_probe(dev, PTR_ERR(wdt->src_clk),
>> -                  "failed to get source clock\n");
>> -        ret = PTR_ERR(wdt->src_clk);
>> -        goto err_bus_clk;
>> -    }
>> -
>> -    ret = clk_prepare_enable(wdt->src_clk);
>> -    if (ret) {
>> -        dev_err(dev, "failed to enable source clock\n");
>> -        goto err_bus_clk;
>> -    }
>> +    wdt->src_clk = devm_clk_get_optional_enabled(dev, "watchdog_src");
>> +    if (IS_ERR(wdt->src_clk))
>> +        return dev_err_probe(dev, PTR_ERR(wdt->src_clk), "failed to get source clock\n");
>>       wdt->wdt_device.min_timeout = 1;
>>       wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt);
>> @@ -710,7 +692,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>                    S3C2410_WATCHDOG_DEFAULT_TIME);
>>           } else {
>>               dev_err(dev, "failed to use default timeout\n");
>> -            goto err_src_clk;
>> +            return ret;
> 
> Hi,
> 
> Nit: this also could be "return dev_err_probe()"
> 
>>           }
>>       }
>> @@ -718,7 +700,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>>                      pdev->name, pdev);
>>       if (ret != 0) {
>>           dev_err(dev, "failed to install irq (%d)\n", ret);
>> -        goto err_src_clk;
>> +        return ret;
> 
> Nit: this also could be "return dev_err_probe()"
> 

The primary reason to call dev_err_probe() is that the error may be
-EPROBE_DEFER, in which case the error message is suppressed.
That is not the case for those two functions; they never return
-EPROBE_DEFER. Calling dev_err_probe() would give the false impression
that the functions _might_ return -EPROBE_DEFER.

Thanks,
Guenter

