Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6D768D642
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjBGMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGMOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:14:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F913DEF;
        Tue,  7 Feb 2023 04:14:54 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04B8C660207F;
        Tue,  7 Feb 2023 12:14:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675772093;
        bh=L0/T/7mYU2a6r4txVoxLosoJmH3FkDFA5tvP+rxF8Og=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dEZE2vT4OwG3P66WvrYpMwfdRchqT1Jr+WhxHIsiCd39pm2a4RjvzZD24pxPJ4rE+
         /Xvjd/808xPFiInZQJmEogEzuTH9ysPUglGpbeLzor2NG5zpfLtr8wy7eGjUzQ98fv
         yysRHQEfyeeBELhOgVAd96UlVhUyLWXimKS5OEfrUcZUPI5KPkDYWoIy45sDDnpwkp
         BJv2Dzpf5Ecu7Ogfs329O9WJpaA5YqHj7BYr1FdMO6fmiDOTsW61XZWdNtplnPplai
         4vNkmCKxibbdISVZz+ChIknChQ6xfHdA7LGPIURUx/5A086izgAFPcsZ7hizyyR8Mm
         iAv89b9DCwDkg==
Message-ID: <7adadf24-c14f-6eb4-edfd-265dca93e907@collabora.com>
Date:   Tue, 7 Feb 2023 13:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 19/45] clk: mediatek: mt8183: Convert all remaining
 clocks to common probe
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-20-angelogioacchino.delregno@collabora.com>
 <CAGXv+5G0ksgGMXUGk-=CXUANtGQa2M5RLY+wG7c-0cMSKS5DJQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5G0ksgGMXUGk-=CXUANtGQa2M5RLY+wG7c-0cMSKS5DJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/02/23 10:58, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Switch to mtk_clk_simple_{probe,remove}() for infracfg and topckgen
>> clocks on MT8183 to allow full module build for clock drivers.
>> In order to do this, like done for other MediaTek clock drivers, it
>> was necessary to join top_early_divs with top_divs and to stop
>> registering the `clk13m` clock early.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt8183.c | 160 ++++++------------------------
>>   1 file changed, 28 insertions(+), 132 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
>> index 0fad2cf7f41b..035fdd02f0be 100644
>> --- a/drivers/clk/mediatek/clk-mt8183.c
>> +++ b/drivers/clk/mediatek/clk-mt8183.c
>> @@ -25,11 +25,8 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
>>          FIXED_CLK(CLK_TOP_UNIVP_192M, "univpll_192m", "univpll", 192000000),
>>   };
>>
>> -static const struct mtk_fixed_factor top_early_divs[] = {
>> -       FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
>> -};
>> -
>>   static const struct mtk_fixed_factor top_divs[] = {
>> +       FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
> 
> A clock with the same name is now present in the DT, and so this clock
> would fail to register. We should drop this one completely and point
> any references to it internally to "csw_f26m_ck_d2".
> 
>>          FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
> 
> MT8192 and MT8195 aren't affected because they only have "csw_f26m_ck_d2",
> which systimer was referencing.
> 
>>          FACTOR_FLAGS(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1, 0),
>>          FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2, 0),
>> @@ -809,26 +806,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
>>          .rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
>>   };
>>
>> -static struct clk_hw_onecell_data *top_clk_data;
>> -
>> -static void clk_mt8183_top_init_early(struct device_node *node)
>> -{
>> -       int i;
>> -
>> -       top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
>> -
>> -       for (i = 0; i < CLK_TOP_NR_CLK; i++)
>> -               top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
>> -
>> -       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
>> -                       top_clk_data);
> 
> And since we used to not do error checking, the name conflict was OK.
> With the new common probe, it's not.
> 

That makes me proud of my changes to extend the new common probe mechanism,
as this is one of (hopefully not) many wrongs that slipped through without
any apparent issue.
Anyway, there was no reference to this clk13m (nor CLK_TOP_CLK13M) anywhere
so I changed this commit to just "forget about this clock" (advertising the
reason in the commit description, of course).

Is MT8183's cpufreq working after this change, or is it still not behaving?

If not, can you please provide a log for me to check?
I don't have any MT8183 device locally, for now at least.

Thanks,
Angelo

