Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD17365AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjFTIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFTIFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:05:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E91739;
        Tue, 20 Jun 2023 01:05:16 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 357066606F57;
        Tue, 20 Jun 2023 09:05:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687248314;
        bh=zFYnaavyn4NmpZM6dhni0PzwKPg7fxu53se1DsR5BOw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NSlSvcCRR2+TmcJXKoE0F1oVkSZDm4c0LABWU8uiGa8cMijMXvrIw5saZutmOi11u
         Z4CVstbSyqAVYUT6eqaOiWwMFOIK5WVh+G6cQE1juURCM0i8/nsIHaJZHjzgo40XSa
         EdPQjzKbwwLHx/zCTEgo/rxEUcztP071suDg7IxBiEDg99O4xCILwQ/xJbt3dKvECC
         iRD59impe0jc1nsqDbt4gdVROfw+TKrqLWPO+TQDRicoztJc1THZUtc/kFZfnVHTpg
         diQ+5/Xz3liCQ7nZK/srdgjBcQ+1TsEmC2E2eOndYFb60IOoeS3UCtqPhXOBH4RRPU
         /ZpvQXp8QgNRg==
Message-ID: <50ca3e03-2d4d-f385-6405-990fd9619661@collabora.com>
Date:   Tue, 20 Jun 2023 10:05:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 5/6] media: mediatek: vcodec: Read HW active status
 from syscon on MT8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-6-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230620000349.2122191-6-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/06/23 02:03, Nícolas F. R. A. Prado ha scritto:
> Remove the requirement of a VDEC_SYS reg iospace for MT8183. To achieve
> that, rely on a vdecsys syscon to be passed through the DT, and use it
> to directly read the VDEC_HW_ACTIVE bit during IRQ handling to check
> whether the HW is active.
> 
> The old behavior is still present when reg-names aren't supplied, as
> MT8173 still relies on it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> I dropped the tags from this commit since a syscon is now used instead
> of an extra clock.
> 
> Changes in v3:
> - Switched handling of VDEC_HW_ACTIVE to use a syscon instead of the
>    'active' clock
> - Reworded commit
> - Removed changes to subdev part of driver, since they aren't used by
>    MT8183
> 
>   .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 71 ++++++++++++++++---
>   .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
>   2 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 83780d29a9cf..387ed26d6d5d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -8,10 +8,12 @@
>   #include <linux/slab.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/of.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>   #include <media/v4l2-event.h>
>   #include <media/v4l2-mem2mem.h>
>   #include <media/videobuf2-dma-contig.h>
> @@ -38,22 +40,37 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_dev *dev)
>   	}
>   }
>   
> +static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
> +{
> +	u32 cg_status = 0;
> +	int val, ret;
> +
> +	if (!dev->reg_base[VDEC_SYS]) {
> +		ret = regmap_read(dev->vdecsys_regmap, VDEC_HW_ACTIVE_ADDR, &val);
> +		if (ret) {
> +			mtk_v4l2_err("Failed to read VDEC active status");
> +			return false;
> +		}
> +
> +		return (val & VDEC_HW_ACTIVE_MASK) == 0;
> +	}
> +
> +	cg_status = readl(dev->reg_base[VDEC_SYS] + VDEC_HW_ACTIVE_ADDR);
> +	return (cg_status & VDEC_HW_ACTIVE_MASK) == 0;

You can either do...

{
	if (dev->vdecsys_regmap) {
		ret = regmap_read(......., &cg_status);
		if (ret) {
			mtk_v4l2_err(...)
			return false;
		}
	} else {
		cg_status = readl(....)
	}
	return !FIELD_GET(VDEC_HW_ACTIVE_MASK, cg_status);
}

.... or ....

{
	if (dev->vdecsys_regmap)
		return !regmap_test_bits(dev->vdecsys_regmap, VDEC_HW_ACTIVE_ADDR,
					 VDEC_HW_ACTIVE_MASK);

	cg_status = readl(....);
	return !FIELD_GET(VDEC_HW_ACTIVE_MASK, cg_status);
}

That's way cleaner :-)

> +}
> +
>   static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>   {
>   	struct mtk_vcodec_dev *dev = priv;
>   	struct mtk_vcodec_ctx *ctx;
> -	u32 cg_status = 0;
>   	unsigned int dec_done_status = 0;
>   	void __iomem *vdec_misc_addr = dev->reg_base[VDEC_MISC] +
>   					VDEC_IRQ_CFG_REG;
>   
>   	ctx = mtk_vcodec_get_curr_ctx(dev, MTK_VDEC_CORE);
>   
> -	/* check if HW active or not */
> -	cg_status = readl(dev->reg_base[0] + VDEC_HW_ACTIVE_ADDR);
> -	if ((cg_status & VDEC_HW_ACTIVE_MASK) != 0) {
> -		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0 (0x%08x)",
> -			     cg_status);
> +	if (!mtk_vcodec_is_hw_active(dev)) {
> +		mtk_v4l2_err("DEC ISR, VDEC active is not 0x0");
>   		return IRQ_HANDLED;
>   	}
>   
> @@ -82,6 +99,25 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
>   {
>   	struct platform_device *pdev = dev->plat_dev;
>   	int reg_num, i;
> +	struct resource *res;
> +	bool no_vdecsys_reg = false;

bool has_vdecsys_reg;

> +	static const char * const mtk_dec_reg_names[] = {
> +		"misc",
> +		"ld",
> +		"top",
> +		"cm",
> +		"ad",
> +		"av",
> +		"pp",
> +		"hwd",
> +		"hwq",
> +		"hwb",
> +		"hwg"
> +	};
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "misc");


	/*
	 * If we have reg-names in devicetree, this means that we're on a new
	 * register organization, which implies that the VDEC_SYS iospace gets
	 * R/W through a syscon (regmap).
	 * Here we try to get the "misc" iostart only to check if we have reg-names
	 */
	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "misc");
	if (res)
		has_vdecsys_reg = false;
	else
		has_vdecsys_reg = true;

> +	if (res)
> +		no_vdecsys_reg = true;
>   
>   	/* Sizeof(u32) * 4 bytes for each register base. */
>   	reg_num = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
> @@ -91,12 +127,22 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_dev *dev)
>   		return -EINVAL;
>   	}
>   
> -	for (i = 0; i < reg_num; i++) {
> -		dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
> -		if (IS_ERR(dev->reg_base[i]))
> -			return PTR_ERR(dev->reg_base[i]);
> +	if (!no_vdecsys_reg) {

...so here you invert the branch

	if (has_vdecsys_reg) {
		.... byname ioremap ....
		parse syscon regmap here, not later!
	} else {
		.... by id ioremap ....
	}

> +		for (i = 0; i < reg_num; i++) {
> +			dev->reg_base[i] = devm_platform_ioremap_resource(pdev, i);
> +			if (IS_ERR(dev->reg_base[i]))
> +				return PTR_ERR(dev->reg_base[i]);
> +
> +			mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
> +		}
> +	} else {
> +		for (i = 0; i < reg_num; i++) {
> +			dev->reg_base[i+1] = devm_platform_ioremap_resource_byname(pdev, mtk_dec_reg_names[i]);
> +			if (IS_ERR(dev->reg_base[i+1]))
> +				return PTR_ERR(dev->reg_base[i+1]);
>   
> -		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
> +			mtk_v4l2_debug(2, "reg[%d] base=%p", i+1, dev->reg_base[i+1]);
> +		}
>   	}
>   
>   	return 0;
> @@ -118,6 +164,9 @@ static int mtk_vcodec_init_dec_resources(struct mtk_vcodec_dev *dev)
>   	if (dev->dec_irq < 0)
>   		return dev->dec_irq;
>   
> +	dev->vdecsys_regmap = syscon_regmap_lookup_by_phandle_optional(pdev->dev.of_node,
> +								       "mediatek,vdecsys");
> +

It makes no sense to try to get a handle to this syscon if we're on the older
layout with vdecsys in the `reg` list: in that case, we can safely assume that
we don't have any mediatek,vdecsys syscon.

Cheers,
Angelo
