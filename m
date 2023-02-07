Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BFB68DCE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjBGPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjBGPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:22:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F610E6;
        Tue,  7 Feb 2023 07:22:50 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C28736602077;
        Tue,  7 Feb 2023 15:22:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675783368;
        bh=TZepTjo3+nkX5BEQbUyUdwEN1gV6gBz2EQ1M2bKFwnY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jOCPgYCsbXt8gQDxCDqMhk3LT2l7kUUGjjAmcqFWgHpsSrmi+eBZyju608AbpEQTS
         JwfANqNaoiogWq7GX08/8RSeiYYaduBrfqaXic04dQ9iipkVgU/w/5iWq+5NSkXAV4
         iO+Zo/PRQw/f7eDgoFKi5Df6Kt2AjflDk6+jLZTeLy1DyWqQ3AF+yh2hPrx7f3sGPc
         BWhyiyXKZC3Be5GoQUVEM8Y8seq4EvVIxCMHwxDVCvVYbixGXt2JPynse5fgXpBTUk
         fKQANB/aulkoAye/QTiUzhNN3vzsR3bBwBTIBTRdImfcYsmScYov9hdCjo4PswTTrQ
         bOttbVgsizukw==
Message-ID: <326154c5-0a78-31c0-2d70-1ef4a8a0c1bb@collabora.com>
Date:   Tue, 7 Feb 2023 16:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 29/45] clk: mediatek: mt7986-apmixed: Use PLL_AO flag
 to set critical clock
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-30-angelogioacchino.delregno@collabora.com>
 <Y+JjjLLYoOgSlG55@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <Y+JjjLLYoOgSlG55@makrotopia.org>
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

Il 07/02/23 15:43, Daniel Golle ha scritto:
> 
> On Mon, Feb 06, 2023 at 04:29:12PM +0100, AngeloGioacchino Del Regno wrote:
>> Instead of calling clk_prepare_enable() at probe time, add the PLL_AO
>> flag to CLK_APMIXED_ARMPLL clock: this will set CLK_IS_CRITICAL.
> 
> I've been preparing a similar change, but also splitting-off the
> apmixed part from dt headers into a file of its own, so that one of now
> identical drivers for MT7986 and MT7981 can be removed in favor of a
> shared driver.
> Should I propose this on top of this series or can you make this change?
> 
> 

That's cool!!! I'm not comfortable in stealing the idea, that's all yours.
Please go on with basing it on top of my series, but wait a couple of days
before doing that, as I have to send a v2 of this one and that'll happen
in the next one..or two days.

Cheers!
Angelo

>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/clk-mt7986-apmixed.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
>> index 62080ee4dbe3..227ca572056e 100644
>> --- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
>> +++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
>> @@ -42,7 +42,7 @@
>>   		 "clkxtal")
>>   
>>   static const struct mtk_pll_data plls[] = {
>> -	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x0, 0, 32,
>> +	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x0, PLL_AO, 32,
>>   	    0x0200, 4, 0, 0x0204, 0),
>>   	PLL(CLK_APMIXED_NET2PLL, "net2pll", 0x0210, 0x021C, 0x0, 0, 32,
>>   	    0x0210, 4, 0, 0x0214, 0),
>> @@ -77,8 +77,6 @@ static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
>>   
>>   	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>>   
>> -	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
>> -
>>   	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>   	if (r) {
>>   		pr_err("%s(): could not register clock provider: %d\n",
>> -- 
>> 2.39.1
>>
>>


