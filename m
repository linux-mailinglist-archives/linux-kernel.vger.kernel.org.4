Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBC64430E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLFMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiLFMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:22:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682B2934B;
        Tue,  6 Dec 2022 04:22:15 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE439660035D;
        Tue,  6 Dec 2022 12:22:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670329327;
        bh=HFhsBPJUZ/W3qeEbtqj0mNmnYKJB/11JNCtWMdGTv88=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JMsgBLF19vGkI7bjFVq2yyNHu0QRemrayTu3nigu593WI7AyVTqCauD9mDxXD/hsT
         mbaMKCn1Fk40bs0z68zMZPCQimF5KjiR6da/ZD8qHC2BvOnS75PQwmj5pv+uQOKX+p
         IZbZtZkBzkqGU5pU1Qb17m0uH9snhHja5hA3vx2qKxXl98YmycaA8W/do9/AHOn17p
         /cCy46ruAiCy/THacT1AIQOuE9+JulTQF5rWLLxSCFmgBjViBTU4bASICxzpV8xtYE
         ko0tQ8tX/suIToA2tf1/OcuYZ3UCihVhGwVu6BCG9kAqLd+K+Ll+iN86jTsBIJ4+1j
         fpRs2UUzSJhXg==
Message-ID: <b55ee8fa-7ad6-3bf9-4983-41a90bd75ce4@collabora.com>
Date:   Tue, 6 Dec 2022 13:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
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
 <20221205065756.26875-5-xiangsheng.hou@mediatek.com>
 <50ede482-7f03-ff55-5ad0-aa6249027cbe@collabora.com>
 <149100d0dc205a317ed352cdfb391f2147a2afab.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <149100d0dc205a317ed352cdfb391f2147a2afab.camel@mediatek.com>
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

Il 06/12/22 10:04, Xiangsheng Hou (侯祥胜) ha scritto:
> Hi Angelo,
> 
> On Mon, 2022-12-05 at 15:21 +0100, AngeloGioacchino Del Regno wrote:
>> Il 05/12/22 07:57, Xiangsheng Hou ha scritto:
>>> Add ECC support fot MT7986 IC.
>>>
>>> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
>>> ---
>>>    drivers/mtd/nand/ecc-mtk.c | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-
>>> mtk.c
>>> index 9f9b201fe706..c2f6cfa76a04 100644
>>> --- a/drivers/mtd/nand/ecc-mtk.c
>>> +++ b/drivers/mtd/nand/ecc-mtk.c
>>> @@ -79,6 +79,10 @@ static const u8 ecc_strength_mt7622[] = {
>>>    	4, 6, 8, 10, 12
>>>    };
>>>    
>>> +static const u8 ecc_strength_mt7986[] = {
>>> +	4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24
>>> +};
>>> +
>>>    enum mtk_ecc_regs {
>>>    	ECC_ENCPAR00,
>>>    	ECC_ENCIRQ_EN,
>>> @@ -483,6 +487,17 @@ static const struct mtk_ecc_caps
>>> mtk_ecc_caps_mt7622 = {
>>>    	.pg_irq_sel = 0,
>>>    };
>>>    
>>> +static const struct mtk_ecc_caps mtk_ecc_caps_mt7986 = {
>>> +	.err_mask = 0x1f,
>>
>> Can't we use GENMASK() to define err_mask instead?
>>
>> #define MT7986_ERRNUM	GENMASK(4, 0)
>>
>> P.S.: Did I get that right? Is that referred to the ERRNUM(x) bits
> 
> Yes, you are right.
> I will change like
> #define ECC_ERRMASK(x) GENMASK(x, 0),
> since other IC driver data will use 0x3f and 0x7f err_mask.
> 

I would prefer, instead, something like

#define MT7986_ERRNUM	GENMASK(....)
#define MT7622_ERRNUM	GENMASK(....)
#define MT.... (etc)

instead of a macro calling another macro.

Regards,
Angelo


