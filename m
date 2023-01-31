Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D0682670
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjAaIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjAaIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:33:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D93C16F;
        Tue, 31 Jan 2023 00:33:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F017D6602EB0;
        Tue, 31 Jan 2023 08:33:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675153985;
        bh=8znNGnB3SZ5cMbqV4jYJqOpR3KhVL1tOkUowpw7M7lI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QR6WyMzjxsw8hGag04dgpgrY88QAtxbgvKqMCA7HAk5/4CKFfp3XFXPD4poTOry+3
         kBlxjC3qHq4r1EpXxJOqwqVrvjZgrZwfsxGxHCvi35GTktfsQ0wAVMvwta6LxYJMfL
         HRMov1gkLvu5WQVPQciv3i2IVl3rf/RWWY4urQh44lcU9nlfByExrMz0WTXabdqwol
         Ic4rI7pwy+xUhCSP2vSF8dWVY/NFCfFKwiadqRcJMmhGpamv+dpcGJZQGId6BMJiWN
         uMF9XVf16eOTtJsqqg+/WRNQPbSM8RAsO+7Bwt0hTkiqqnoCao81C7FyczQNSfx/b2
         NFp+/csgiCgew==
Message-ID: <d3d913f3-d898-26c5-7c05-01b67826e662@collabora.com>
Date:   Tue, 31 Jan 2023 09:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1
 simple_probe
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-4-moudy.ho@mediatek.com>
 <fe49e8b642c4c33fee37e97d957c37a3.sboyd@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <fe49e8b642c4c33fee37e97d957c37a3.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/01/23 20:36, Stephen Boyd ha scritto:
> Quoting Moudy Ho (2023-01-17 19:15:08)
>> diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
>> index bf2939c3a023..6d5800f69f6c 100644
>> --- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
>> +++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
>> @@ -86,26 +86,54 @@ static const struct mtk_gate vpp0_clks[] = {
>>          GATE_VPP0_2(CLK_VPP0_WARP1_MDP_DL_ASYNC, "vpp0_warp1_mdp_dl_async", "top_wpe_vpp", 3),
>>   };
>>   
>> -static const struct mtk_clk_desc vpp0_desc = {
>> -       .clks = vpp0_clks,
>> -       .num_clks = ARRAY_SIZE(vpp0_clks),
>> -};
>> +static int clk_mt8195_vpp0_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *node = dev->parent->of_node;
>> +       struct clk_onecell_data *clk_data;
>> +       int r;
>>   
>> -static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
>> -       {
>> -               .compatible = "mediatek,mt8195-vppsys0",
>> -               .data = &vpp0_desc,
>> -       }, {
>> -               /* sentinel */
>> -       }
>> -};
>> +       clk_data = mtk_alloc_clk_data(CLK_VPP0_NR_CLK);
>> +       if (!clk_data)
>> +               return -ENOMEM;
>> +
>> +       r = mtk_clk_register_gates(node, vpp0_clks, ARRAY_SIZE(vpp0_clks), clk_data);
> 
> This API is wrecked by a patch from AngeloGioacchino. Can you resend, or
> tell me which device should be used here?

mtk_clk_register_gates(&pdev->dev, node, vpp0_clks, ......);


...with that change, for this patch:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: Next cleanup round will introduce mtk_clk_pdev_simple_probe()

Cheers,
Angelo
