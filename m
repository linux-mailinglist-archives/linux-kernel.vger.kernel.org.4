Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43396EEC7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbjDZCp2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZCpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:45:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88DA2;
        Tue, 25 Apr 2023 19:45:23 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4685924E214;
        Wed, 26 Apr 2023 10:45:21 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 10:45:20 +0800
Received: from [192.168.125.131] (113.72.145.137) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 26 Apr
 2023 10:45:20 +0800
Message-ID: <dc4190cd-5803-5d58-5421-a1df9c015ffc@starfivetech.com>
Date:   Wed, 26 Apr 2023 10:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] watchdog: starfive: Fix the probe return error if PM
 and early_enable are both disabled
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>
CC:     Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20230425100456.32718-1-xingyu.wu@starfivetech.com>
 <2ea16959-4525-90fb-b928-d652a4613574@roeck-us.net>
 <dca081d0-cc06-3e65-ec9b-3885baf5dcde@starfivetech.com>
 <4477e33b-85c6-81e3-b7d4-9df6ce2aa273@roeck-us.net>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <4477e33b-85c6-81e3-b7d4-9df6ce2aa273@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.137]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/26 10:01, Guenter Roeck wrote:
> On 4/25/23 18:49, Xingyu Wu wrote:
>> On 2023/4/25 22:06, Guenter Roeck wrote:
>>> On 4/25/23 03:04, Xingyu Wu wrote:
>>>> When the starfive watchdog driver uses 'pm_runtime_put_sync()' as probe
>>>> return value at last and 'early_enable' is disabled, it could return the
>>>> error '-ENOSYS' if the CONFIG_PM is disabled, but the driver should works
>>>> normally.
>>>>
>>>> Add a check to make sure the PM is enabled and then use
>>>> 'pm_runtime_put_sync()' as return value when 'early_enable' is disabled.
>>>>
>>>> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>> ---
>>>>
>>>> Hi, Guenter and Wim,
>>>>
>>>> This patch fixes the issue of StarFive watchdog driver and rebases on
>>>> the master branch of linux-next.
>>>>
>>>> Thanks.
>>>>    ---
>>>>    drivers/watchdog/starfive-wdt.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
>>>> index 1995cceca51e..51e487e09960 100644
>>>> --- a/drivers/watchdog/starfive-wdt.c
>>>> +++ b/drivers/watchdog/starfive-wdt.c
>>>> @@ -492,7 +492,8 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>>>>            goto err_exit;
>>>>          if (!early_enable)
>>>> -        return pm_runtime_put_sync(&pdev->dev);
>>>> +        if (pm_runtime_enabled(&pdev->dev))
>>>> +            return pm_runtime_put_sync(&pdev->dev);
>>>>    
>>>
>>> Why not just
>>>
>>>      if (!early_enable)
>>>          pm_runtime_put_sync(&pdev->dev)
>>>
>>> like almost every other caller of pm_runtime_put_sync() ?
>>>
>>
>> The function of pm_runtime_put_sync() is that:
>>
>> static inline int pm_runtime_put_sync(struct device *dev)
>> {
>>     return __pm_runtime_idle(dev, RPM_GET_PUT);
>> }
>>
>> and when do not enable CONFIG_PM, the __pm_runtime_idle() is that:
>>
>> static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
>> {
>>     return -ENOSYS;
>> }
>>
>> If I do not open PM, it will return error saying probe failed
>> but it works fine without PM. I had tested that and probe really
>> was failed. So I should add this check before using pm_runtime_put_sync().
>>
> 
> You did not answer my question.
> 

Oh sorry, I did not notice that you dropped the 'return'. It looks simpler.

Best regards,
Xingyu Wu
