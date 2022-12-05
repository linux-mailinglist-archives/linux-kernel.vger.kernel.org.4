Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7949C642A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiLEOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiLEOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:21:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418813FAB;
        Mon,  5 Dec 2022 06:21:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA7BC6601E6A;
        Mon,  5 Dec 2022 14:21:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670250084;
        bh=NPMSgIxm/IXldzeGyabGZE0MeVSJ1WmroFFQ+QCluy8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M6aiSYUzpfsDT2/aoI8gLuXBouJWy4KNgMDRTXxHrGEEZ7r81AnVgl1fYYRHwyY+n
         ZwnArRIo9iXOdslt1Hrp+Pk5SuvMwH4pF67UF+orzFqNPVTStLOLEXBjttmSpQz4at
         /y0YNqA/sUkZirp+UiFeOjc10QyLLgALk+9gDMaY6BD3TjvfCBJUckAh2KBCAeUwjT
         4+cu/NgmaIjOLj3/cBsUc6oa1iWe2S+trfLy2OXPWXIY6vuZ4zfhBt8cnPhYhnPCQK
         5gs6sVOEdWSyD1c+DETIGLp9hVcNj2JsTSnzAQcUoZDhAafl/PPRtRysS5fwAN2ZIA
         vuQhevsJo8lgw==
Message-ID: <50ede482-7f03-ff55-5ad0-aa6249027cbe@collabora.com>
Date:   Mon, 5 Dec 2022 15:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-5-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221205065756.26875-5-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/12/22 07:57, Xiangsheng Hou ha scritto:
> Add ECC support fot MT7986 IC.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>   drivers/mtd/nand/ecc-mtk.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
> index 9f9b201fe706..c2f6cfa76a04 100644
> --- a/drivers/mtd/nand/ecc-mtk.c
> +++ b/drivers/mtd/nand/ecc-mtk.c
> @@ -79,6 +79,10 @@ static const u8 ecc_strength_mt7622[] = {
>   	4, 6, 8, 10, 12
>   };
>   
> +static const u8 ecc_strength_mt7986[] = {
> +	4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24
> +};
> +
>   enum mtk_ecc_regs {
>   	ECC_ENCPAR00,
>   	ECC_ENCIRQ_EN,
> @@ -483,6 +487,17 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt7622 = {
>   	.pg_irq_sel = 0,
>   };
>   
> +static const struct mtk_ecc_caps mtk_ecc_caps_mt7986 = {
> +	.err_mask = 0x1f,

Can't we use GENMASK() to define err_mask instead?

#define MT7986_ERRNUM	GENMASK(4, 0)

P.S.: Did I get that right? Is that referred to the ERRNUM(x) bits?

Regards,
Angelo


