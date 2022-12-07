Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB48B64572B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiLGKIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLGKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:08:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22AF6478;
        Wed,  7 Dec 2022 02:08:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D0296602BCA;
        Wed,  7 Dec 2022 10:08:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670407721;
        bh=AyR0RJnVKrrqQBm9hFiiBr7ZIDDoQirRHSbrqdL6UgM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lt1ouqtzvN/cuiyAwGqv8hAf7z0yOZ7kKLfaiI2zvDgg+xHD+3X9XYLh4CPC+tpeE
         VhrqNI5+jpml1H8zckoIDyzdcqhFTgeSKuQxKVbtMMZOJ1poRgLRvY0Pgp1PtKd44e
         URFvFOQWTsc99dYvNbtT5MFbJcqH3/HYxxZaseaihah8pgMfxy5QD8Bo6fpBLClyM9
         F298s/We7GqPdmqjnLOpHPmWcjMMy3tCTGUjKdw/rF8yMeP8OcNFi525DTelWSPp0C
         qDH4/2Vqi0afKEOssANEbUKPrr/V+WKYSOpb7f9n5RUlKJMsORCAfAKfwhMejfodD5
         0Me9nh+W+yTYg==
Message-ID: <ff2931b5-948f-f013-056d-b0a78d7272d6@collabora.com>
Date:   Wed, 7 Dec 2022 11:08:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/9] spi: mtk-snfi: Add optional nfi_hclk which needed
 for MT7986
Content-Language: en-US
To:     =?UTF-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-4-xiangsheng.hou@mediatek.com>
 <ef2e6859-56e1-bbf0-dbde-44ea3d7d2f3f@collabora.com>
 <4db35ac3914e444b754f9075141fd69e07e7c858.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4db35ac3914e444b754f9075141fd69e07e7c858.camel@mediatek.com>
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

Il 07/12/22 02:42, Xiangsheng Hou (侯祥胜) ha scritto:
> Hi Angelo,
> 
> On Mon, 2022-12-05 at 15:21 +0100, AngeloGioacchino Del Regno wrote:
>> Il 05/12/22 07:57, Xiangsheng Hou ha scritto:
>>> Add optional nfi_hclk which needed for MT7986.
>>>
>>> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>>
>> Is there any operation for which you need NFI_HCLK enabled, but at
>> the same time
>> PAD_CLK and/or NFI_CLK can be disabled?
> 
> No, for the new IP design on MT7986, will need the
> PAD_CLK/NFI_CLK/NFI_HCLK enabled at the same time.
> 
>> If NFI_HCLK and NFI_CLK must always be ON at the same time, adding
>> this clock to
>> spi-mtk-snfi.c is *not* an optimal way of doing things: you can, at
>> this point,
>> set NFI_HCLK as parent of NFI_CLK in the MT7986 clock driver instead,
>> without
>> making any addition to this driver at all.
> 
> For some IC, there may have only NFI_CLK/PAD_CLK, and have no NFI_HCLK,
> this rely on IC design.
> 

I've just checked clk-mt7986-infracfg and we can't reparent NFI1_CK, nor SPINFI1_CK
as they have xxxx_sel parents already, which are not common with the HCK.

You're right, the addition of the nfi_hclk clock is needed, which means that for
this commit, you get my


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


P.S.: Thanks for clarifying!

Regards,
Angelo
