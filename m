Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A56EEC33
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjDZCCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjDZCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:01:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE6194;
        Tue, 25 Apr 2023 19:01:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b60365f53so8074018b3a.0;
        Tue, 25 Apr 2023 19:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682474514; x=1685066514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fDBWc2Jci3ByCZAXYT2uFU75V6idrbDgVgdGp8Pn78Y=;
        b=JNcSev90MBeK9O9j9mXNeYZL9tUn34BksL993UWdNSs0VZ1pXWAnjzqJ5UMqc+WUdq
         H2JXbuVdOAodRCvtBT84S/PQTWaX2b1FPpj7xSemULqcjK9PdH4WhMZ7WWgwO71b2mkl
         ae8GlHtsXPjl/Cm1g8nqyZVoGpK2/YoP1whWx0atq4cVCdWkL74F++dpw3cUF1xRiMje
         +ub96q8KLjdV2dUqvLS4pnKDxhI+OyU4QjT1Up9oRSVZr/YmGp+wnLfqdaf5mAO0Fx/L
         2WL9xR0k+62iE8xne+wLKsM/UvEYj4iuJ2W6YOgcqVpbzDolA94ZgQj9hAmWWNj4NfGg
         ihcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682474514; x=1685066514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDBWc2Jci3ByCZAXYT2uFU75V6idrbDgVgdGp8Pn78Y=;
        b=fkOxI1dGW097/8yqt7t/o4QksNzsekhkGSCF9mgQIspRF9SV1HRUTDAJihSsFx5rbe
         am8pQTWPUjfyJVL3X1Tp8WCoJQEPBXybPxx1BTZvxnkh49w0Nnd1Wn1yf4MXk7FKPIiR
         95/Q89WNsMRsxS4j58DOcoH+Kn3qS2OWTGyud3/cTaxL5cc/5YaTqwuYpaanfh9mXM0d
         l50joKf+2qrktFYwF9hcIjJEX1H711GJVeKUuwpj25v3j0i133dVPN8pdFtz6ZhDAkz1
         +R/W2qNopUqveFRixxeL9/T44KDWgaHCXJU4cHSm70FxSbO+pvC9ZAYwhh6xE4OZe9VN
         yh9g==
X-Gm-Message-State: AAQBX9dF4BLOmDggvUcsm0R0KkSaM6hVd57rL02Fz0IVeHN0fExhk+oD
        RXbWMMhBG4JKQcT1j99bijGNFchs40U=
X-Google-Smtp-Source: AKy350Y4Toipetj2b1+6+nOeBdn8/44ZtfOqD2LjCP0aZZ55jw8J8QlOt9vI1V0Su7XBgdWUDs+Hxw==
X-Received: by 2002:aa7:88d0:0:b0:636:f899:46a0 with SMTP id k16-20020aa788d0000000b00636f89946a0mr27114297pff.15.1682474514425;
        Tue, 25 Apr 2023 19:01:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fd20-20020a056a002e9400b0063d336629e5sm9974775pfb.59.2023.04.25.19.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 19:01:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4477e33b-85c6-81e3-b7d4-9df6ce2aa273@roeck-us.net>
Date:   Tue, 25 Apr 2023 19:01:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] watchdog: starfive: Fix the probe return error if PM
 and early_enable are both disabled
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230425100456.32718-1-xingyu.wu@starfivetech.com>
 <2ea16959-4525-90fb-b928-d652a4613574@roeck-us.net>
 <dca081d0-cc06-3e65-ec9b-3885baf5dcde@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <dca081d0-cc06-3e65-ec9b-3885baf5dcde@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 18:49, Xingyu Wu wrote:
> On 2023/4/25 22:06, Guenter Roeck wrote:
>> On 4/25/23 03:04, Xingyu Wu wrote:
>>> When the starfive watchdog driver uses 'pm_runtime_put_sync()' as probe
>>> return value at last and 'early_enable' is disabled, it could return the
>>> error '-ENOSYS' if the CONFIG_PM is disabled, but the driver should works
>>> normally.
>>>
>>> Add a check to make sure the PM is enabled and then use
>>> 'pm_runtime_put_sync()' as return value when 'early_enable' is disabled.
>>>
>>> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> ---
>>>
>>> Hi, Guenter and Wim,
>>>
>>> This patch fixes the issue of StarFive watchdog driver and rebases on
>>> the master branch of linux-next.
>>>
>>> Thanks.
>>>    ---
>>>    drivers/watchdog/starfive-wdt.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
>>> index 1995cceca51e..51e487e09960 100644
>>> --- a/drivers/watchdog/starfive-wdt.c
>>> +++ b/drivers/watchdog/starfive-wdt.c
>>> @@ -492,7 +492,8 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>>>            goto err_exit;
>>>          if (!early_enable)
>>> -        return pm_runtime_put_sync(&pdev->dev);
>>> +        if (pm_runtime_enabled(&pdev->dev))
>>> +            return pm_runtime_put_sync(&pdev->dev);
>>>    
>>
>> Why not just
>>
>>      if (!early_enable)
>>          pm_runtime_put_sync(&pdev->dev)
>>
>> like almost every other caller of pm_runtime_put_sync() ?
>>
> 
> The function of pm_runtime_put_sync() is that:
> 
> static inline int pm_runtime_put_sync(struct device *dev)
> {
> 	return __pm_runtime_idle(dev, RPM_GET_PUT);
> }
> 
> and when do not enable CONFIG_PM, the __pm_runtime_idle() is that:
> 
> static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
> {
> 	return -ENOSYS;
> }
> 
> If I do not open PM, it will return error saying probe failed
> but it works fine without PM. I had tested that and probe really
> was failed. So I should add this check before using pm_runtime_put_sync().
> 

You did not answer my question.

Guenter


