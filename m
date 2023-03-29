Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816E36CDA2E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjC2NKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2NKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:10:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F878B3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:10:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51639660316A;
        Wed, 29 Mar 2023 14:10:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680095449;
        bh=zVF05hk59CfKnrDedjRCcIbn2rciK8fjt91K0SYGKs0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kLIK6vjSO6D3vnJU2Y7GEV43CCe5hMhUPU3FsmrbVWeNYe3O8t24DRNXUTqQizhdU
         ZAlqnoByiPIvJX30W/jOXgt2jHTvDGSgVW+60vqcRDFan1dg4/z4wjb7UqK8sOAec2
         ryVNiwSiqt3/NQqpwhw0lakQN4VnwMadeDs0S385Xv4170Tvp+efdDBwvPVuv3U5FD
         NLixSbFUA8U5m+bxYm/cgN8LDSRylYG9jtYyYGzqW/dnoIKRq2VOnZizqUsYJLq6Et
         j49ucpc/ut6t/bYR8lRX4/L7LpvF58zHTqtlsfn1V9+WAHnqvJJnIcgkid6lii4SP6
         2H/zbEDSiZOIQ==
Message-ID: <75a890d1-b3b9-0316-749b-fb2bf80c3176@collabora.com>
Date:   Wed, 29 Mar 2023 15:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clocksource/drivers/timer-mediatek: Split out CPUXGPT
 timers
Content-Language: en-US
To:     =?UTF-8?B?V2FsdGVyIENoYW5nICjlvLXntq3lk7Ip?= 
        <Walter.Chang@mediatek.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        =?UTF-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?RnJlZGR5IEhzaW4gKOi+m+aBkuixkCk=?= 
        <Freddy.Hsin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230309103913.116775-1-angelogioacchino.delregno@collabora.com>
 <e5fabff45596df1e78ed781e7433687327a807dc.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e5fabff45596df1e78ed781e7433687327a807dc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/03/23 09:51, Walter Chang (張維哲) ha scritto:
> On Thu, 2023-03-09 at 11:39 +0100, AngeloGioacchino Del Regno wrote:
>> On MediaTek platforms, CPUXGPT is the source for the AArch64 System
>> Timer, read through CNTVCT_EL0.
>>
>> The handling for starting this timer ASAP was introduced in commit
>> 327e93cf9a59 ("clocksource/drivers/timer-mediatek: Implement CPUXGPT
>> timers")
>> which description also contains an important full explanation of the
>> reasons why this driver is necessary and cannot be a module.
>>
>> In preparation for an eventual conversion of timer-mediatek to a
>> platform_driver that would be possibly built as a module, split out
>> the CPUXGPT timers driver to a new timer-mediatek-cpux.c driver.
>>
>> This commit brings no functional changes.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> ---
>>
>> Note: I've added a mention to the commit that is introducing CPUXGPT
>> because it contains a broad explanation about why this is needed and
>> why it is mandatory to have it as built-in and initialized as early
>> as possible. This is mostly because this question was asked multiple
>> times and I've been pointing people to that commit to explain it all.
>>
>> This commit was made because of a discussion about the impossibility
>> to convert timer-mediatek to a module: even though that's definitely
>> not easy at all, this will make sure that whatever cannot (ever) be
>> built as module goes out of that driver.
>>
>> I tried to tackle a timer-mediatek conversion to platform_driver as
>> well, but I don't currently have the required bandwidth to do so:
>> as a first step I moved that, so I'm pushing this commit as to try
>> to reduce duplicated work.
>>
>> This commit was tested on MT6795 Sony Xperia M5.

..snip..

>> @@ -452,4 +339,3 @@ static int __init mtk_gpt_init(struct device_node
>> *node)
>>   }
>>   TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
>>   TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer",
>> mtk_syst_init);
>> -TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer",
>> mtk_cpux_init);
> 
> This patch looks good to me. Thanks for assisting us in spliting out
> the CPUX driver.
> 

Hello Walter,

thanks for checking this patch. If you have actually reviewed this one,
you could help the maintainers to know by releasing your Reviewed-by tag
on this patch.

Regards,
Angelo


