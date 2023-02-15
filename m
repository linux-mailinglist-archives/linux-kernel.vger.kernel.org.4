Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AEE697D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBONbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBONbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:31:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC710242
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:30:55 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A680F6602181;
        Wed, 15 Feb 2023 13:30:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676467854;
        bh=4S1WQba0JD7XAPBod8AxUdkmD30ZD+yesX7r+1i66B8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ne9ApZnuW3dpqROHsWnugIDFNxkOLSyTMd4GB4w6pGQ2stCfVR7w3JxmTVBwLLBtL
         7QZCpKNbzGiPP0TIN+NOt8F3TzCwKycax+TCIK6onbOUHYx3bSP/y9i/XHWW2bjgIb
         rGBn6V207Ui00X8ArYcso4bnWIbOSvql2bbtIj63DKpwQSu9aUJisFDRPJq6jVCsf/
         iyr+wQQ7f9dr4r8OD2XXRnUJG3h834XomhJLmM9zpTStwSrGMnxzhXePWLRG4SNmvr
         7d1a1JGw4Y1hQapt3QCeVZ37qjLgtjXXPAo5o6/YYOOuWlqVklNhDrTuLeX4eU5hjB
         btAJL3tPl/XHw==
Message-ID: <53f0e612-b5cc-262e-df98-add1e8a06573@collabora.com>
Date:   Wed, 15 Feb 2023 14:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 4/4] clocksource/drivers/timer-mediatek: Make
 timer-mediatek become loadable module
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     walter.chang@mediatek.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        John Stultz <jstultz@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        Chun-hung.Wu@mediatek.com, Freddy.Hsin@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230214105412.5856-1-walter.chang@mediatek.com>
 <20230214105412.5856-5-walter.chang@mediatek.com>
 <20230214222021.k3tsfwezhnh7tdlx@bogus>
 <996b4e61-8486-d939-7367-1240b3c5c5fa@collabora.com>
 <20230215131849.mcgz53jf24atialp@bogus>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215131849.mcgz53jf24atialp@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/23 14:18, Sudeep Holla ha scritto:
> On Wed, Feb 15, 2023 at 01:43:19PM +0100, AngeloGioacchino Del Regno wrote:
>> Il 14/02/23 23:20, Sudeep Holla ha scritto:
>>> On Tue, Feb 14, 2023 at 06:53:14PM +0800, walter.chang@mediatek.com wrote:
>>>> From: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>>
>>>> Make the timer-mediatek driver which can register
>>>> an always-on timer as tick_broadcast_device on
>>>> MediaTek SoCs become loadable module in GKI.
>>>>
>>>> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
>>>> ---
>>>>    drivers/clocksource/Kconfig          |  2 +-
>>>>    drivers/clocksource/timer-mediatek.c | 43 ++++++++++++++++++++++++++++
>>>>    2 files changed, 44 insertions(+), 1 deletion(-)
>>>
>>> [...]
>>>
>>>> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
>>>> index d5b29fd03ca2..3358758ea694 100644
>>>> --- a/drivers/clocksource/timer-mediatek.c
>>>> +++ b/drivers/clocksource/timer-mediatek.c
>>>
>>> [...]
>>>
>>>> +static const struct of_device_id mtk_timer_match_table[] = {
>>>> +	{
>>>> +		.compatible = "mediatek,mt6577-timer",
>>>> +		.data = mtk_gpt_init,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "mediatek,mt6765-timer",
>>>> +		.data = mtk_syst_init,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "mediatek,mt6795-systimer",
>>>> +		.data = mtk_cpux_init,
>>>> +	},
>>>> +	{}
>>>> +};
>>>> +
>>>> +static struct platform_driver mtk_timer_driver = {
>>>> +	.probe = mtk_timer_probe,
>>>> +	.driver = {
>>>> +		.name = "mtk-timer",
>>>> +		.of_match_table = mtk_timer_match_table,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(mtk_timer_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("MediaTek Module Timer driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> +#else
>>>>    TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>>>>    TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
>>>>    TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
>>>
>>> Why do you need these ? If this driver can work as a module, it can be
>>> built-in module and doesn't need to be initialised early using of_timer_init
>>> (can't recall the exact name)
>>>
>>
>> Some platforms need early initialization; this is seen on ones for which the
>> bootloader does not initialize the "CPUXGPT" timer, which is used as the ARM
>> arch timer. (No, on those platforms you can't upgrade the bootloader, as it's
>> signed with a OEM key which is not obtainable, and signature verified earlier
>> in the bootchain).
>>
> 
> Is this arm32 or arm64 platform? Do you mean that these platforms don't have
> working architected timers ?
> 

Both. I mean that these platforms do have architected timers, but they are stopped
before the bootloader jumps to the kernel, or they are never started at all.

Please refer to:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/clocksource/timer-mediatek.c?h=next-20230215&id=327e93cf9a59b0d04eb3a31a7fdbf0f11cf13ecb

For a nice explanation.

> Quick grep suggests the below list of platforms/SoC:
> 
>   | arch/arm64/boot/dts/mediatek/mt6795.dtsi
>   | arch/arm64/boot/dts/mediatek/mt8173.dtsi
>   | arch/arm64/boot/dts/mediatek/mt8183.dtsi
>   | arch/arm64/boot/dts/mediatek/mt8186.dtsi
>   | arch/arm64/boot/dts/mediatek/mt8192.dtsi
>   | arch/arm64/boot/dts/mediatek/mt8195.dtsi
>   | arch/arm64/boot/dts/mediatek/mt8516.dtsi
>   | arch/arm/boot/dts/mt7623.dtsi
>   | arch/arm/boot/dts/mt7629.dtsi
>   | arch/arm/boot/dts/mt8127.dtsi
>   | arch/arm/boot/dts/mt8135.dtsi
> 
> All the above has architected timers and can have the other timer initialised
> at module_initcall level.
> 
>   | arch/arm/boot/dts/mt2701.dtsi
>   | arch/arm/boot/dts/mt6580.dtsi
>   | arch/arm/boot/dts/mt6582.dtsi
>   | arch/arm/boot/dts/mt6589.dtsi
>   | arch/arm/boot/dts/mt6592.dtsi
> 
> The above ones have cortex-a7 but still don't have architected timers listed
> in the DT. Anyways all use "mediatek,mt6577-timer", so except that other
> 2 can be dropped from the else and force them to be initialised later.
> 
>> As a matter of fact (and somehow obvious), on those platforms (for example,
>> MT6795.. but many other as well, really), you *need* this driver to be
>> built-in and, well, initialize the CPUX timer as early as possible :-)
>>
> 
> Built-in is not a problem, you can still remove TIMER_OF_DECLARE as
> the initialisation happens later at module_initcall level.
> 



