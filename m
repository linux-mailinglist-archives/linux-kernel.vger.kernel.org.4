Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706EF68D1A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBGIpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGIpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:45:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2021E975F;
        Tue,  7 Feb 2023 00:45:50 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C62B6602063;
        Tue,  7 Feb 2023 08:45:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675759548;
        bh=bqZiPDggGgpkRR/4QMaq8dEmj6yC7YxNan82FZ1HEg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m0Qt7Y7U4EDGztoWKbo7sR7qBF5kPURAE8Sle8wtvUxDCZJLfQ+4fFZRN5h2Dd8Kb
         DC7liY2X7Ik+9W+XK3hEcatLlNBAMiHORH66o/zTht6ju0WYhU7SpjLjzxN9IYG/TQ
         hyq9tbKeXtEUVFmr1d6fF1r+YMR3gv/AA8k3ePuvLeSycWYwEBvxP1vTLzl7wMjwV8
         82y2tIbdKCZDDYKJRAxAo1gb5D2ywScj/OmU3VOHTROOXeMR2pVp7fnRHh21SQlWKG
         Jc0bu9fIWcvRFk1H3DeFi3QZXaRV0nF8RRFgq6H2bzKItjORCZWQiMovLiG1IFef9c
         CPIMVU7mn+Ybw==
Message-ID: <93d95309-84eb-16c6-b64e-b0c43d784900@collabora.com>
Date:   Tue, 7 Feb 2023 09:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 05/45] clk: mediatek: mt2712: Migrate topckgen/mcucfg
 to mtk_clk_simple_probe()
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
 <20230206152928.918562-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Gg60-4B29V9cYUw7b1OVcZvU+w9qdiiBbt10LJsAJiCA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Gg60-4B29V9cYUw7b1OVcZvU+w9qdiiBbt10LJsAJiCA@mail.gmail.com>
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

Il 07/02/23 07:15, Chen-Yu Tsai ha scritto:
> On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Now that the common mtk_clk_simple_{probe,remove}() functions can deal
>> with divider clocks it is possible to migrate more clock drivers to it:
>> in this case, it's about topckgen.
>> While at it, also perform a fast migration for mcucfg.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
>> ---
>>   drivers/clk/mediatek/clk-mt2712.c | 127 +++++-------------------------
>>   1 file changed, 21 insertions(+), 106 deletions(-)
>>

..snip..
                      __func__, r);
>> +static const struct mtk_clk_desc topck_desc = {
>> +       .clks = top_clks,
>> +       .num_clks = ARRAY_SIZE(top_clks),
>> +       .fixed_clks = top_fixed_clks,
>> +       .num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
>> +       .factor_clks = top_divs,
>> +       .num_factor_clks = ARRAY_SIZE(top_divs),
>> +       .composite_clks = top_muxes,
>> +       .num_composite_clks = ARRAY_SIZE(top_muxes),
>> +       .divider_clks = top_adj_divs,
>> +       .num_divider_clks = ARRAY_SIZE(top_adj_divs),
>> +       .clk_lock = &mt2712_clk_lock,
> 
> At some point maybe we should look into splitting up the locks to one
> per block, or converting everything to regmap.
> 

I was thinking the same about the locks... but about regmap, that would
actually add up some overhead at every R/W operation and I would really
like to measure that precisely before doing any kind of regmap conversion
for the MediaTek clocks.

Perhaps I'll even find a way to avoid any kind of (even if small) overhead
while doing that sometime in the future, which wouldn't be benefitting only
MediaTek, but also other users like Qualcomm (as they have practically all
clocks on regmap!).

Cheers,
Angelo


