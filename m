Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDF569679A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBNPHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBNPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:07:47 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D1E869B;
        Tue, 14 Feb 2023 07:07:46 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s17so13188734ois.10;
        Tue, 14 Feb 2023 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glCFzNJEkKRAACAqSiqIghJmrnrV1EqOkux7Jq/xO/g=;
        b=G07QbLZSKGllKvuUzNJ99oYCObeUW+AHENflXsPnn1P5tvVEvNL2NoGorexAYyR9I/
         0QdY9ZLsQUFVjHYa8A5684d1NFzhSGagRwNi08tHTZ/RoU0cRhGb1kmOUcjNEcigNNx4
         PS7Gg+PvXKw1ktEtCpIokyCz6qeht46oON63Fm5AMkFoxtebMKWlQLoPEKqoezbM6mOG
         dtf65CoWhjHyAa2AOLu7+v8LaTCRqJ+0tEImcnsIaIby1L0EXhhYHZeVyNDVdBhP0qdx
         kf8VSPJdJlubB0/qal1fXuXljgmcqrKWVN33f5IoU4hjTf5uag9UiXDgzLi2z7TMW8V2
         1nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glCFzNJEkKRAACAqSiqIghJmrnrV1EqOkux7Jq/xO/g=;
        b=7OEc7GHoRy6qXBvr2S5zQATj+RBSezZtIls/7uGj13O4LBqkBD0vXjc/IoOEIrH7E+
         u3Pu7QlBhWIqC+Ct9LDTJ+phMWRBtCd9w6xBsXLfuDd1aLJX6fMvyptEdoPy19ZK2s/q
         xHbZulAk45tHkfVKlthO2WiStAP2Bl9QbSobJDLyNwcqQD4CBETe0jym9DoNKVgohGe5
         4KwHkULsfhpViKoBxK03Ln9SyZw15I7sQq+sF5heoqGAjZkfXGfLBr1TEVbjSUAJhcqM
         B55iZ1MaYu/ytQsES8m/FN765jhWhkxWWl+tnyQxlumCRxyH0hsZfLG7JT1xeyyrnnPS
         GYjw==
X-Gm-Message-State: AO0yUKUXfs1EWXitASRhZ2UUvgGK4JJhyjLNvYaySJ6amnwnp6iC5FsP
        mVxvy2yXxaZ1ENH5aGI7j0s=
X-Google-Smtp-Source: AK7set+5cU9tJLrISgLgMgOZs+hdnSHeK3AJAYrcr/aPdsTJJzbPUOPn1lywpctzs/lLCaqIPHfKoA==
X-Received: by 2002:aca:902:0:b0:37b:26d7:422 with SMTP id 2-20020aca0902000000b0037b26d70422mr1154448oij.50.1676387265643;
        Tue, 14 Feb 2023 07:07:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ev6-20020a056808290600b0037d93a7e8f6sm2495590oib.54.2023.02.14.07.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 07:07:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c815038-e3d2-dd78-26af-8a6f498a6a1e@roeck-us.net>
Date:   Tue, 14 Feb 2023 07:07:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com>
 <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
 <aa68fc8c-cfa1-902d-b95e-4fcbd3154f93@roeck-us.net>
 <c23f78fe-8ea4-1a5c-c36e-fd981a2c381d@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
In-Reply-To: <c23f78fe-8ea4-1a5c-c36e-fd981a2c381d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 04:15, Krzysztof Kozlowski wrote:
> On 14/02/2023 13:10, Guenter Roeck wrote:
>> On 2/14/23 00:31, Krzysztof Kozlowski wrote:
>>> On 13/02/2023 21:05, Sergio Paracuellos wrote:
>>>> MT7621 SoC has a system controller node. Watchdog need to access to reset
>>>> status register. Ralink architecture and related driver are old and from
>>>> the beggining they are using some architecture dependent operations for
>>>> accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
>>>> header file. However this is not ideal from a driver perspective which can
>>>> just access to the system controller registers in an arch independent way
>>>> using regmap syscon APIs. Update Kconfig accordingly to select new added
>>>> dependencies and allow driver to be compile tested.
>>>>
>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>> ---
>>>>    drivers/watchdog/Kconfig      |  4 +++-
>>>>    drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
>>>>    2 files changed, 16 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>>> index b64bc49c7..cf752ad64 100644
>>>> --- a/drivers/watchdog/Kconfig
>>>> +++ b/drivers/watchdog/Kconfig
>>>> @@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
>>>>    config MT7621_WDT
>>>>    	tristate "Mediatek SoC watchdog"
>>>>    	select WATCHDOG_CORE
>>>> -	depends on SOC_MT7620 || SOC_MT7621
>>>> +	select REGMAP_MMIO
>>>> +	select MFD_SYSCON
>>>> +	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
>>>>    	help
>>>>    	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
>>>>    
>>>> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
>>>> index 40fb2c9ba..22e979bdd 100644
>>>> --- a/drivers/watchdog/mt7621_wdt.c
>>>> +++ b/drivers/watchdog/mt7621_wdt.c
>>>> @@ -15,8 +15,8 @@
>>>>    #include <linux/moduleparam.h>
>>>>    #include <linux/platform_device.h>
>>>>    #include <linux/mod_devicetable.h>
>>>> -
>>>> -#include <asm/mach-ralink/ralink_regs.h>
>>>> +#include <linux/mfd/syscon.h>
>>>> +#include <linux/regmap.h>
>>>>    
>>>>    #define SYSC_RSTSTAT			0x38
>>>>    #define WDT_RST_CAUSE			BIT(1)
>>>> @@ -34,6 +34,7 @@
>>>>    struct mt7621_wdt_data {
>>>>    	void __iomem *base;
>>>>    	struct reset_control *rst;
>>>> +	struct regmap *sysc;
>>>>    	struct watchdog_device wdt;
>>>>    };
>>>>    
>>>> @@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> -static int mt7621_wdt_bootcause(void)
>>>> +static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
>>>>    {
>>>> -	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
>>>> +	u32 val;
>>>> +
>>>> +	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
>>>> +	if (val & WDT_RST_CAUSE)
>>>>    		return WDIOF_CARDRESET;
>>>>    
>>>>    	return 0;
>>>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>>>>    	if (!drvdata)
>>>>    		return -ENOMEM;
>>>>    
>>>> +	drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>>>> +	if (IS_ERR(drvdata->sysc))
>>>> +		return PTR_ERR(drvdata->sysc);
>>>
>>> This should be the backup/error path for original code using syscon
>>> property. Looking up by compatible is really not portable/re-usable.
>>>
>>
>> I really disagree here.
>>
>> $ git grep syscon_regmap_lookup_by_compatible | wc
>>        90     326    8940
>>
>> I have not yet reviewed this code, but I do not accept this argument against it.
> 
> First, argument that bad pattern is being used is not an argument to
> keep it and repeat it.
> 
> Second, we already had examples that:
> 1. Author used syscon_regmap_lookup_by_compatible() and assumed "we will
> never add new variant/soc".
> 2. Then turns out that new variants are obviously added and
> syscon_regmap_lookup_by_compatible() stops scaling.
> 

Your arguments only applies if 1) there is ever going to be a new Mediatek/Ralink
chip with the same watchdog core, and 2) that chip also has the same watchdog
related registers in its syscon node.

Both is highly unlikely to happen. There already is a more generic watchdog
driver for later Mediatek chips (mtk_wdt.c). Even if Mediatek/Ralink ever
decides to revive this specific watchdog core for whatever reason,
the time to make the code more generic would have been at that time, at the same
time ensuring that the more generic code actually works and does have the
same syscon registers to obtain the boot status.

> Whether any new variant/compatible/platform can appear for this watchdog
> - I don't know.
> 
> Third, with syscon_regmap_lookup_by_compatible() you have undocumented
> (not in the binding) dependency between blocks which:
> a. stops any reusability,
> b. affects device links and probe ordering (simply - there is no, device
> must defer probe),
> c. is simply undocumented.
> 
> The usage of syscon_regmap_lookup_by_compatible() has clear drawbacks
> thus new code should rather use syscon phandles which solve all of above.
> 

"new code". Exactly. This isn't new code.

In order to make progress, I'll accept v7, assuming its updated devicetree
description is going to be accepted, but my argument still stands.

Guenter

