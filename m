Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F33E663EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjAJLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbjAJLFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:05:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246DDEA8;
        Tue, 10 Jan 2023 03:05:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6EFD36602D76;
        Tue, 10 Jan 2023 11:05:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673348727;
        bh=npkTfw5AkuKfVozPXHhlB8Rn+FzOl8AfixjbglEYM5E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g8mf7PG7JBP8XJNBtWZ8xgKI0tOPJZokIWTbOEYuVJkOn5DbhJxaSJNBUO2Q1bfmK
         y1cMK33sW6/WquNq39qtJ+odJJSftGycmg4aztwS874/mPrMof0lYm+fsOrT5Nwq3m
         XnH22BPZ3qXZeaD8iU9PxqrEuIq9uU/28KPoxfuz6lIefi1XhBECgx/F1zSWa3QYd6
         O8SATtKZfIVM6gP8Dbp4oVWKgnhmhGHx8mh24o8yFg0qe82SJMc0J2wNSJlPzhtsBA
         8YRHsF805A+5id8/DCqbidHCpsqprOFHMyUNHvuTAtsYxRnwpJUAkqoFwxh6d1Bs8L
         GKudUCJsH8MLQ==
Message-ID: <4dbaf8a4-21df-8a7e-89ef-9ad2580ff341@collabora.com>
Date:   Tue, 10 Jan 2023 12:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 03/23] clk: mediatek: clk-gate: Propagate struct device
 with mtk_clk_register_gates()
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, fparent@baylibre.com,
        chun-jie.chen@mediatek.com, sam.shih@mediatek.com,
        y.oudjana@protonmail.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, ryder.lee@kernel.org,
        daniel@makrotopia.org, jose.exposito89@gmail.com,
        yangyingliang@huawei.com, pablo.sun@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-4-angelogioacchino.delregno@collabora.com>
 <20230104112144.n2mx33xqavigxwa2@blmsp>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230104112144.n2mx33xqavigxwa2@blmsp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/01/23 12:21, Markus Schneider-Pargmann ha scritto:
> Hi Angelo,
> 
> On Fri, Dec 23, 2022 at 10:42:39AM +0100, AngeloGioacchino Del Regno wrote:
>> Commit e4c23e19aa2a ("clk: mediatek: Register clock gate with device")
>> introduces a helper function for the sole purpose of propagating a
>> struct device pointer to the clk API when registering the mtk-gate
>> clocks to take advantage of Runtime PM when/where needed and where
>> a power domain is defined in devicetree.
>>
>> Function mtk_clk_register_gates() then becomes a wrapper around the
>> new mtk_clk_register_gates_with_dev() function that will simply pass
>> NULL as struct device: this is essential when registering drivers
>> with CLK_OF_DECLARE instead of as a platform device, as there will
>> be no struct device to pass... but we can as well simply have only
>> one function that always takes such pointer as a param and pass NULL
>> when unavoidable.
>>
>> This commit removes the mtk_clk_register_gates() wrapper and renames
>> mtk_clk_register_gates_with_dev() to the former and all of the calls
>> to either of the two functions were fixed in all drivers in order to
>> reflect this change.
>>
>> Since a lot of MediaTek clock drivers are actually registering as a
>> platform device, but were still registering the mtk-gate clocks
>> without passing any struct device to the clock framework, they've
>> been changed to pass a valid one now, as to make all those platforms
>> able to use runtime power management where available.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> A few nitpicks, otherwise it looks good,
> 
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
> 
>> ---
>>   drivers/clk/mediatek/clk-gate.c              | 16 ++++------------
>>   drivers/clk/mediatek/clk-gate.h              |  8 ++------
>>   drivers/clk/mediatek/clk-mt2701-aud.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt2701-eth.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt2701-g3d.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt2701-hif.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt2701-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt2701.c            |  6 +++---
>>   drivers/clk/mediatek/clk-mt2712-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt2712.c            |  6 +++---
>>   drivers/clk/mediatek/clk-mt6765.c            |  6 +++---
>>   drivers/clk/mediatek/clk-mt6779-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt6779.c            |  4 ++--
>>   drivers/clk/mediatek/clk-mt6795-infracfg.c   |  3 ++-
>>   drivers/clk/mediatek/clk-mt6795-mm.c         |  3 ++-
>>   drivers/clk/mediatek/clk-mt6795-pericfg.c    |  3 ++-
>>   drivers/clk/mediatek/clk-mt6797-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt6797.c            |  2 +-
>>   drivers/clk/mediatek/clk-mt7622-aud.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt7622-eth.c        |  4 ++--
>>   drivers/clk/mediatek/clk-mt7622-hif.c        |  4 ++--
>>   drivers/clk/mediatek/clk-mt7622.c            |  9 +++++----
>>   drivers/clk/mediatek/clk-mt7629-eth.c        |  5 +++--
>>   drivers/clk/mediatek/clk-mt7629-hif.c        |  4 ++--
>>   drivers/clk/mediatek/clk-mt7629.c            |  6 +++---
>>   drivers/clk/mediatek/clk-mt7986-eth.c        |  6 +++---
>>   drivers/clk/mediatek/clk-mt7986-infracfg.c   |  2 +-
>>   drivers/clk/mediatek/clk-mt8135.c            |  4 ++--
>>   drivers/clk/mediatek/clk-mt8167-aud.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt8167-img.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  2 +-
>>   drivers/clk/mediatek/clk-mt8167-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt8167-vdec.c       |  3 ++-
>>   drivers/clk/mediatek/clk-mt8167.c            |  2 +-
>>   drivers/clk/mediatek/clk-mt8173-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt8173.c            | 12 ++++++------
>>   drivers/clk/mediatek/clk-mt8183-audio.c      |  2 +-
>>   drivers/clk/mediatek/clk-mt8183-mm.c         |  2 +-
>>   drivers/clk/mediatek/clk-mt8183.c            |  8 ++++----
>>   drivers/clk/mediatek/clk-mt8186-mm.c         |  3 ++-
>>   drivers/clk/mediatek/clk-mt8192-aud.c        |  3 ++-
>>   drivers/clk/mediatek/clk-mt8192-mm.c         |  3 ++-
>>   drivers/clk/mediatek/clk-mt8192.c            | 12 ++++++------
>>   drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  3 ++-
>>   drivers/clk/mediatek/clk-mt8195-topckgen.c   |  3 ++-
>>   drivers/clk/mediatek/clk-mt8195-vdo0.c       |  3 ++-
>>   drivers/clk/mediatek/clk-mt8195-vdo1.c       |  3 ++-
>>   drivers/clk/mediatek/clk-mt8365-mm.c         |  5 ++---
>>   drivers/clk/mediatek/clk-mt8365.c            |  2 +-
>>   drivers/clk/mediatek/clk-mt8516-aud.c        |  2 +-
>>   drivers/clk/mediatek/clk-mt8516.c            |  2 +-
>>   drivers/clk/mediatek/clk-mtk.c               |  4 ++--
>>   52 files changed, 103 insertions(+), 103 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
>> index 7868c0728e96..765df117afa6 100644
>> --- a/drivers/clk/mediatek/clk-mt7986-eth.c
>> +++ b/drivers/clk/mediatek/clk-mt7986-eth.c
>> @@ -85,7 +85,7 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
>>   	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
>>   
>>   	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
>> -			       clk_data);
>> +			       clk_data, NULL);
>>   
>>   	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>   	if (r)
>> @@ -103,7 +103,7 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
>>   	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
>>   
>>   	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
>> -			       clk_data);
>> +			       clk_data, NULL);
>>   
>>   	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>   
>> @@ -121,7 +121,7 @@ static void __init mtk_ethsys_init(struct device_node *node)
>>   
>>   	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
>>   
>> -	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
>> +	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data, NULL);
> 
> You kept within 80c nearly everywhere, but there are a few calls where
> you added 'NULL' that go over the 80c now. Not sure if that was
> intended?!
> 

Yeah that's intended. It's 86 columns, and one more line just for a NULL doesn't
really look good to my eyes.
Besides, we're using 80c terminals from the 1980's anymore in 2023, so that's
fine :-)

>>   
>>   	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>   
> 
> [...]
> 
>> diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
>> index 11ecc6fb0065..f93043da26c0 100644
>> --- a/drivers/clk/mediatek/clk-mt8183-mm.c
>> +++ b/drivers/clk/mediatek/clk-mt8183-mm.c
>> @@ -91,7 +91,7 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
>>   	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
>>   
>>   	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
>> -			clk_data);
>> +			clk_data, &pdev->dev);
> 
> This is not aligned with the opening bracket here and a few below. Maybe
> you can fix it with your patch as well.
> 

Keeping in mind the size of the series, I wanted to reduce the changes to the bone
and to avoid touching indentation as well, but I guess the TAB key on my keyboard
can handle one more keypress :-P

>>   
>>   	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>   }
> [...]
>> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
>> index 991d78a71644..e1b625b86911 100644
>> --- a/drivers/clk/mediatek/clk-mt8192.c
>> +++ b/drivers/clk/mediatek/clk-mt8192.c
>> @@ -1127,7 +1127,7 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
>>   	if (r)
>>   		goto unregister_top_composites;
>>   
>> -	r = mtk_clk_register_gates_with_dev(node, top_clks, ARRAY_SIZE(top_clks),
>> +	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
>>   					    top_clk_data, &pdev->dev);
> 
> Here and below, the function call got shorter, please fix the
> indentation in the following lines.
> 

More keypresses to do!

Thanks for the review, will fix for v3 :-)

Regards,
Angelo


