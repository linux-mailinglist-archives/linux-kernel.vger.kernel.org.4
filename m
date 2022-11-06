Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD70661E0A9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 08:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKFH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 02:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 02:59:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38EC632B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 00:59:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f5so22961208ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEl0YoVvN1GJsGvoYdE/zZMGJkQaLgmsjIXP9qXuCAI=;
        b=LJzK8R9MUBPh/lnWgwkcDa8XwTsRsmarGIFD4QbFRjb7bL6Oec4dgApvBOiv9zBe8K
         xt6NRbv0M48x0P5ckgtoYUPuQFfO7/k9Aa9IVjoy8aZMudQuCrzW3Erz/cLbqjrBlS4p
         7tumT/IdYLBktwlzgbfk2O9mq6zsEfjeBt8VNRnqtqhJXdzCd3nmh05n1/3YZNLEAJGe
         TjNSfEU8qpuWEKtEL3838hnhxYIYQ8i7mPSNEpow+E5jVLLGp8Kc+9WZsJR8HOY/3iB6
         cSIaGGTgESMdLUga3mQZ+FNBvEzX2UQr2banbAi1poNGRDyTrlLwGNl0yS3uPC9MK4N/
         FhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEl0YoVvN1GJsGvoYdE/zZMGJkQaLgmsjIXP9qXuCAI=;
        b=6cGo2jU0kGLJDMO+ubF9lUzNcXjFJERwM1Y8wnuBlIq5HvAnWxc+tFMcOhywioyaKi
         /XMcD/eSTclB/LpuYXbCoIUHgK2JWRbvNBLgPo2s+HVy+kMGaJJgKb7yUm6sYOUdmQPd
         3JURF6FQl/7y0pxfl/ytOzx2lz8jAMmk/3PFT/tE5d9Y4A8mLWfjzkXLlx7/dvjwoUxD
         gvjNC0fm/TKk42bqxm72S0ELtgGIbGHVkpXdnD6BAdr7xZkMWhlqTcrgpe1Cj2YY0E0b
         votLWoi/tBL39Qnr4odjvUsoQk37E2OlcV+KyIgerdFh2EtlNDkvrXg6ot3CGLsmOlhj
         sG1A==
X-Gm-Message-State: ACrzQf1ONK0y7SW1n+IiRE+6Lsyf/3F29KULwTqq1z8ZwS+erukjTfsT
        rrB9gb0g0DzXYlYo0tXS+N0=
X-Google-Smtp-Source: AMsMyM6O8l3UwemZ6wmmPkcNymeefDRnN36hQtQGDJEp6CVOsyOnHCh4Mv6ioFI0PF5X1nuZ2loqBg==
X-Received: by 2002:a17:907:708:b0:77e:ff47:34b1 with SMTP id xb8-20020a170907070800b0077eff4734b1mr39640765ejb.493.1667721582364;
        Sun, 06 Nov 2022 00:59:42 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id en6-20020a056402528600b0044e937ddcabsm2280859edb.77.2022.11.06.00.59.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Nov 2022 00:59:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] bus: sunxi-rsb: Remove shutdown callback
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20221105191954.14360-1-samuel@sholland.org>
 <20221105191954.14360-2-samuel@sholland.org>
 <2652299.mvXUDI8C0e@jernej-laptop>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <7a1bd36c-87c1-16ab-65a6-8d104489d84b@gmail.com>
Date:   Sun, 6 Nov 2022 09:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2652299.mvXUDI8C0e@jernej-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.11.22 г. 21:29 ч., Jernej Škrabec wrote:
> Dne sobota, 05. november 2022 ob 20:19:52 CET je Samuel Holland napisal(a):
>> Shutting down the RSB controller prevents communicating with a PMIC
>> inside pm_power_off(), so it breaks system poweroff on some boards.
>>
>> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> Fixes: 843107498f91 ("bus: sunxi-rsb: Implement suspend/resume/shutdown
>> callbacks") Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 

Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Thanks,
Ivo

> Best regards,
> Jernej
> 
>> ---
>>
>>   drivers/bus/sunxi-rsb.c | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
>> index 4cd2e127946e..17343cd75338 100644
>> --- a/drivers/bus/sunxi-rsb.c
>> +++ b/drivers/bus/sunxi-rsb.c
>> @@ -812,14 +812,6 @@ static int sunxi_rsb_remove(struct platform_device
>> *pdev) return 0;
>>   }
>>
>> -static void sunxi_rsb_shutdown(struct platform_device *pdev)
>> -{
>> -	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
>> -
>> -	pm_runtime_disable(&pdev->dev);
>> -	sunxi_rsb_hw_exit(rsb);
>> -}
>> -
>>   static const struct dev_pm_ops sunxi_rsb_dev_pm_ops = {
>>   	SET_RUNTIME_PM_OPS(sunxi_rsb_runtime_suspend,
>>   			   sunxi_rsb_runtime_resume, NULL)
>> @@ -835,7 +827,6 @@ MODULE_DEVICE_TABLE(of, sunxi_rsb_of_match_table);
>>   static struct platform_driver sunxi_rsb_driver = {
>>   	.probe = sunxi_rsb_probe,
>>   	.remove	= sunxi_rsb_remove,
>> -	.shutdown = sunxi_rsb_shutdown,
>>   	.driver	= {
>>   		.name = RSB_CTRL_NAME,
>>   		.of_match_table = sunxi_rsb_of_match_table,
> 
> 
> 
> 
