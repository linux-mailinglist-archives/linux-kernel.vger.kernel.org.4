Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856425E9C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiIZIgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiIZIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:36:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2612C3AB38;
        Mon, 26 Sep 2022 01:36:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A1736600367;
        Mon, 26 Sep 2022 09:36:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664181392;
        bh=iEoRw3EBXEXCxH+5KZlOyq/CLV8b3I2xCDSEHHW8R3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a3/TGAL0UiIflez2BxYVWJJvXIuLzzeGkYrbkx77l7TxrAwo5YTX75GpsV2OEIdIV
         5NL+vRX/pe6eZE6OFDa58XxcPp8MUStn77QMZqh7GtHntprUtyGLulgRW2DiiEHgIT
         l7f/DfnvCD1qwiXRMTKIuV74YbpFTsym0f6dwCNE8vb2JVPUR12tFJAKPis74rE8cG
         ImDf4cQaMaoCRysEEgVS4l1J6jmXYdeVU4XGb4a4Zn+O0ZZLsUWy65z+RdIOAZKRaZ
         wS1BFIhiSewUR5goCMZcSnf16U5b03Zw68k1SlrNNeeEjBQlvaJn2f+VK9wrczoUZz
         zqb2zFwqooZsQ==
Message-ID: <9f7d1eda-cdf3-5108-7e9d-a10937fe224e@collabora.com>
Date:   Mon, 26 Sep 2022 10:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 05/10] clk: mediatek: clk-mt8195-mfg: Reparent mfg_bg3d
 and propagate rate changes
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
 <20220915072458.18232-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5HxEWPmLLi0zRrJ+T7bVcpoQoFt81+_ciXNDXRrGmfU6w@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HxEWPmLLi0zRrJ+T7bVcpoQoFt81+_ciXNDXRrGmfU6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/09/22 05:27, Chen-Yu Tsai ha scritto:
> On Thu, Sep 15, 2022 at 3:25 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The MFG_BG3D is a gate to enable/disable clock output to the GPU,
>> but the actual output is decided by multiple muxes; in particular:
>> mfg_ck_fast_ref muxes between "slow" (top_mfg_core_tmp) and
>> "fast" (MFGPLL) clock, while top_mfg_core_tmp muxes between the
>> 26MHz clock and various system PLLs.
>>
>> This also implies that "top_mfg_core_tmp" is a parent of the
>> "mfg_ck_fast_ref" mux (and not vice-versa), so reparent the
> 
> I don't see where this was the case though? I think what you meant
> was that the direct parent for "mfg_bg3d" is "mfg_ck_fast_ref, not
> "top_mfg_core_tmp"?
> 

MFG_BG3D's direct parent is mfg_ck_fast_ref - yes - but in the commit message
I am explaining how the clock tree for MFG_BG3D really is and, in particular,
I'm then explaining that:
* parenting MFG_BG3D to "top_mfg_core_tmp" is wrong; because
* "top_mfg_core_tmp" is a parent of "mfg_ck_fast_ref" (not the other way around).

So, the question in your comment is addressed just a little later....

>> MFG_BG3D gate to the latter and add the CLK_SET_RATE_PARENT

...here, where I say "reparent MFG_BG3D to the latter", where "the latter" is,
exactly "mfg_ck_fast_ref".

I hope you now understand what I am trying to communicate :-)

However, if even after that you still think that the commit description should
be rewritten in some less tangled and/or more understandable way, I definitely
can do that.

Please confirm :-)

>> flag to it: this way we ensure propagating rate changes that
>> are requested on MFG_BG3D along its entire clock tree.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> 
>> ---
>>   drivers/clk/mediatek/clk-mt8195-mfg.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
>> index 9411c556a5a9..c94cb71bd9b9 100644
>> --- a/drivers/clk/mediatek/clk-mt8195-mfg.c
>> +++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
>> @@ -17,10 +17,12 @@ static const struct mtk_gate_regs mfg_cg_regs = {
>>   };
>>
>>   #define GATE_MFG(_id, _name, _parent, _shift)                  \
>> -       GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
>> +       GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs,       \
>> +                      _shift, &mtk_clk_gate_ops_setclr,        \
>> +                      CLK_SET_RATE_PARENT)
>>
>>   static const struct mtk_gate mfg_clks[] = {
>> -       GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "top_mfg_core_tmp", 0),
>> +       GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_ck_fast_ref", 0),
>>   };
>>
>>   static const struct mtk_clk_desc mfg_desc = {
>> --
>> 2.37.2
>>


