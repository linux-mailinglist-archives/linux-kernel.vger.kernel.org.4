Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855716426CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiLEKh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLEKhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:37:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED25E120A3;
        Mon,  5 Dec 2022 02:37:19 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62BD366015ED;
        Mon,  5 Dec 2022 10:37:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670236638;
        bh=wGqb7ACQ+MHfk+veHSj5RJ2KW3qb/huM5iIZKEw4K08=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M+JupQ1rW6I493IZz4illgYstesxy0BsgG+SqGiOupm/st42LrVWYE5Y/wgME82l4
         772FW1OS2KF388EsPf8PzShW7XUtFpBkku4jw8QMai2aS1ppMEFJjL4aDV0Ndyn58G
         3LlLEaSz+ahxygFOB4K8OyHl4VycL1GLQzJ13Df6uvJij1BJvfKWFVTRnBWOxUn9VM
         649wKVFwZOoDwIYpvSqDfLtQ8JIX5JDSM0nr9HeiR4+ZDh34W5oF3TQuE8fG4U6jDK
         uL+yUUHAQaHfy56y49BwveE6XS2UGxc2vDuCbxfAto6V06SAmxk5Tw5kLvnCP+D8GH
         5y6OmtYcjJYgw==
Message-ID: <4ab6ce42-4769-8a8b-495a-8a7edda91dea@collabora.com>
Date:   Mon, 5 Dec 2022 11:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] cpufreq: mediatek: Raise proc and sram max voltage for
 MT7622/7623
Content-Language: en-US
To:     Nick <vincent@systemli.org>, viresh.kumar@linaro.org
Cc:     rafael@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, rex-bc.chen@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, frank-w@public-files.de,
        daniel@makrotopia.org
References: <20221202095227.167492-1-angelogioacchino.delregno@collabora.com>
 <75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/22 13:37, Nick ha scritto:
> It now starts, however, with a lot of those messages (I applied the patch to 
> linux/master and not to linux-next, because next is currently not compiling anymore 
> for me):
> 
>> [   10.777041] cpufreq: __target_index: Failed to change cpu frequency: -22
>> [   10.791577] cpu cpu0: cpu0: failed to scale up voltage!
> The complete log:
> https://gist.githubusercontent.com/PolynomialDivision/267c83c7a21a359cbb4e8d99d0303201/raw/28d3568a26634bebef2d91ebe37fc5f76ae58add/mt7622-patch-cpufreq.log
> 

Thanks for the feedback!

I am totally sure that the platform_data is correct as that's based on datasheets.

Checking mt6380-regulator.c and mt6380.dtsi also confirms that the min/max volt
shift and proc/sram max voltage that I've specified is currently supported.

That "failed to scale up voltage!" is a bit strange, as this means that
the regulator_set_voltage() call returns -EINVAL for .. reasons, and that's a bit
strange, since the constraints look good in the code, unless there's anything that
I'm missing here.

Can you please try a vanilla kernel?

Also, since I don't have any MT7622/7623 board to test with, if the issue persists,
it would be helpful if you could place some debugging prints in mediatek-cpufreq.c
to specifically check which regulator_set_voltage() call fails, as to try to make
me have a better overview on the problem that you're facing.

Alternatively, we can eventually setup a debugging session on IRC to make things
a bit faster.

Cheers,
Angelo

> Bests
> Nick
> 
> On 12/2/22 10:52, AngeloGioacchino Del Regno wrote:
>> During the addition of SRAM voltage tracking for CCI scaling, this
>> driver got some voltage limits set for the vtrack algorithm: these
>> were moved to platform data first, then enforced in a later commit
>> 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
>> using these as max values for the regulator_set_voltage() calls.
>>
>> In this case, the vsram/vproc constraints for MT7622 and MT7623
>> were supposed to be the same as MT2701 (and a number of other SoCs),
>> but that turned out to be a mistake because the aforementioned two
>> SoCs' maximum voltage for both VPROC and VPROC_SRAM is 1.36V.
>>
>> Fix that by adding new platform data for MT7622/7623 declaring the
>> right {proc,sram}_max_volt parameter.
>>
>> Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
>> Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
>> index 7f2680bc9a0f..f9a9f08c75c4 100644
>> --- a/drivers/cpufreq/mediatek-cpufreq.c
>> +++ b/drivers/cpufreq/mediatek-cpufreq.c
>> @@ -695,6 +695,15 @@ static const struct mtk_cpufreq_platform_data 
>> mt2701_platform_data = {
>>       .ccifreq_supported = false,
>>   };
>> +static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
>> +    .min_volt_shift = 100000,
>> +    .max_volt_shift = 200000,
>> +    .proc_max_volt = 1360000,
>> +    .sram_min_volt = 0,
>> +    .sram_max_volt = 1360000,
>> +    .ccifreq_supported = false,
>> +};
>> +
>>   static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
>>       .min_volt_shift = 100000,
>>       .max_volt_shift = 200000,
>> @@ -717,8 +726,8 @@ static const struct mtk_cpufreq_platform_data 
>> mt8186_platform_data = {
>>   static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>>       { .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
>>       { .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
>> -    { .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
>> -    { .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
>> +    { .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
>> +    { .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
>>       { .compatible = "mediatek,mt8167", .data = &mt2701_platform_data },
>>       { .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
>>       { .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },

