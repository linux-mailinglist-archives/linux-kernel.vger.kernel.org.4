Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660B76641E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbjAJNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbjAJNbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:31:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4E3F120;
        Tue, 10 Jan 2023 05:31:45 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A6796602D78;
        Tue, 10 Jan 2023 13:31:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673357504;
        bh=nU+9tDyRUi5VH2nG2ng3G2MunVx5ogxNNUVZZkeyweo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MBSFiqnFkqymXPVHM4PSJRYeKX5CShiIOTQDI+g42dl51/zC67q5KWPTHoTzsmCjx
         tZMZI266wArfaNginE7dSUrQfvU5war2EgRlqiK1GN72mlBTnV459UYy+JvkIWuwnD
         obMPwbADdt2mOKLw0jcFlc3Jrk9J6eY/jcckshSJj/50J654DmdJvC2vgJRBk5x6f5
         UU18clv9bw3i402F1I7qyUibC0eeCrp5wqzswMNwlVe9Bwh+NY8Q6L9zgAFuqv5WbA
         rAnf/1eFFWJLZJS5Errxu0r8s7/jldJbw2elAwuVrMwatiEKYxzAo79usy4ReIOB8V
         +yKm3hjYUxBmQ==
Message-ID: <cba61b03-7e54-09e2-b1bd-8352f583a81b@collabora.com>
Date:   Tue, 10 Jan 2023 14:31:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 11/23] clk: mediatek: Switch to mtk_clk_simple_probe()
 where possible
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-12-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GYk2wr-UnnshT3R2uDUSn7-i5KifyJ4qDDZbptSQ9G7A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5GYk2wr-UnnshT3R2uDUSn7-i5KifyJ4qDDZbptSQ9G7A@mail.gmail.com>
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

Il 30/12/22 06:12, Chen-Yu Tsai ha scritto:
> On Fri, Dec 23, 2022 at 5:43 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> mtk_clk_simple_probe() is a function that registers mtk gate clocks
>> and, if reset data is present, a reset controller and across all of
>> the MTK clock drivers, such a function is duplicated many times:
>> switch to the common mtk_clk_simple_probe() function for all of the
>> clock drivers that are registering as platform drivers.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt2701-aud.c   | 26 +++----
>>   drivers/clk/mediatek/clk-mt2701-eth.c   | 34 +++------
>>   drivers/clk/mediatek/clk-mt2701-g3d.c   | 56 +++-----------
>>   drivers/clk/mediatek/clk-mt2701-hif.c   | 36 +++------
>>   drivers/clk/mediatek/clk-mt2712.c       | 83 ++++++++-------------
>>   drivers/clk/mediatek/clk-mt6779.c       | 42 ++++++-----
>>   drivers/clk/mediatek/clk-mt7622-aud.c   | 49 +++----------
>>   drivers/clk/mediatek/clk-mt7622-eth.c   | 82 ++++-----------------
>>   drivers/clk/mediatek/clk-mt7622-hif.c   | 85 ++++-----------------
>>   drivers/clk/mediatek/clk-mt7629-hif.c   | 85 ++++-----------------
>>   drivers/clk/mediatek/clk-mt8183-audio.c | 19 +++--
>>   drivers/clk/mediatek/clk-mt8183.c       | 75 ++++++++-----------
>>   drivers/clk/mediatek/clk-mt8192-aud.c   | 25 +++----
>>   drivers/clk/mediatek/clk-mt8192.c       | 98 ++++++++-----------------
>>   14 files changed, 236 insertions(+), 559 deletions(-)
> 
> This looks mostly good, however ...
> 
>> diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
>> index ab13ab618fb5..1fd6d96b34dc 100644
>> --- a/drivers/clk/mediatek/clk-mt2701-aud.c
>> +++ b/drivers/clk/mediatek/clk-mt2701-aud.c
>> @@ -76,6 +76,7 @@ static const struct mtk_gate_regs audio3_cg_regs = {
>>   };
>>
>>   static const struct mtk_gate audio_clks[] = {
>> +       GATE_DUMMY(CLK_DUMMY, "aud_dummy"),
>>          /* AUDIO0 */
>>          GATE_AUDIO0(CLK_AUD_AFE, "audio_afe", "aud_intbus_sel", 2),
>>          GATE_AUDIO0(CLK_AUD_HDMI, "audio_hdmi", "audpll_sel", 20),
>> @@ -138,29 +139,26 @@ static const struct mtk_gate audio_clks[] = {
>>          GATE_AUDIO3(CLK_AUD_MEM_ASRC5, "audio_mem_asrc5", "asm_h_sel", 14),
>>   };
>>
>> +static const struct mtk_clk_desc audio_desc = {
>> +       .clks = audio_clks,
>> +       .num_clks = ARRAY_SIZE(audio_clks),
>> +};
>> +
>>   static const struct of_device_id of_match_clk_mt2701_aud[] = {
>> -       { .compatible = "mediatek,mt2701-audsys", },
>> -       {}
>> +       { .compatible = "mediatek,mt2701-audsys", .data = &audio_desc },
>> +       { /* sentinel */ }
>>   };
>>
>>   static int clk_mt2701_aud_probe(struct platform_device *pdev)
>>   {
>> -       struct clk_hw_onecell_data *clk_data;
>> -       struct device_node *node = pdev->dev.of_node;
>>          int r;
>>
>> -       clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
>> -
>> -       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
>> -                              clk_data, &pdev->dev);
>> -
>> -       r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>> +       r = mtk_clk_simple_probe(pdev);
>>          if (r) {
>>                  dev_err(&pdev->dev,
>>                          "could not register clock provider: %s: %d\n",
>>                          pdev->name, r);
>> -
>> -               goto err_clk_provider;
>> +               return r;
>>          }
>>
>>          r = devm_of_platform_populate(&pdev->dev);
>> @@ -170,13 +168,13 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
>>          return 0;
>>
>>   err_plat_populate:
>> -       of_clk_del_provider(node);
>> -err_clk_provider:
>> +       mtk_clk_simple_remove(pdev);
>>          return r;
>>   }
>>
>>   static struct platform_driver clk_mt2701_aud_drv = {
>>          .probe = clk_mt2701_aud_probe,
>> +       .remove = mtk_clk_simple_remove,
> 
> I'm not a big fan of mixing devres and non-devres teardown code. Automatic
> devres teardown happens after the remove callback returns, so in this
> case you could have child devices being unregistered that touch clocks
> or resets that have already been unregistered and freed in the remove
> callback.
> 

I'll add a custom remove function that calls of_platform_depopulate() and
tears everything down manually in the correct order.

Thanks for catching this one, I didn't notice at all!

>>          .driver = {
>>                  .name = "clk-mt2701-aud",
>>                  .of_match_table = of_match_clk_mt2701_aud,
> 
> [...]
> 
>> --- a/drivers/clk/mediatek/clk-mt2712.c
>> +++ b/drivers/clk/mediatek/clk-mt2712.c
> 
> [...]
> 
>> @@ -1482,7 +1459,11 @@ static struct platform_driver clk_mt2712_drv = {
>>
>>   static int __init clk_mt2712_init(void)
>>   {
>> -       return platform_driver_register(&clk_mt2712_drv);
>> +       int ret = platform_driver_register(&clk_mt2712_drv);
>> +
>> +       if (ret)
>> +               return ret;
>> +       return platform_driver_register(&clk_mt2712_simple_drv);
>>   }
>>
>>   arch_initcall(clk_mt2712_init);
> 
> Would this get cleaned up even more? I.e. have just one driver left and
> we could have the nice *_platform_driver() macros.
> 

In the future, yes - granted that I find someone that can help with the testing,
as I don't have any MT2712 hardware here.

Not in this series though (please!).

Cheers,
Angelo

