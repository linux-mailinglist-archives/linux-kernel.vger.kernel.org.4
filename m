Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFE65BE154
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiITJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiITJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:02:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84546CD16;
        Tue, 20 Sep 2022 02:02:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFF556601F65;
        Tue, 20 Sep 2022 10:01:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663664519;
        bh=+3Eho6vznxN6lcZbJbVvkS5KJYsPvu5pctKzlZPKMUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LJclHzWWXsCnozr4D6rWp6q57rPuakEPkNWPH4x5OppazabiA3wjTGmtPFWcgEgIj
         GR4sP0iuussi0aap1SwEamN3AIHInnQt4Y1crvC44KcN+0rKVSTNkt68tCFtcAFgHP
         HS3TRs3QGz4pde4u0r/jmuJIccKVgD1Y/4o3hls04T98y6fFdWjuThZAW7qN0rGcIc
         OkU750ey5Tj9vwjKlDYO//swC6zIN/iq6EUNiD3n5mCmT6OWvc4/WLatlhkVtbeK+s
         MqjnrDydHispgrfrj0N6PWPcfxJ5yGR6xzIIQIlFVoxfFGL1qS81oMdjy95Z24kSXU
         xwFUg1uwDjb7w==
Message-ID: <3a0ac49f-2245-fb64-aa60-e3b1a1d4afcd@collabora.com>
Date:   Tue, 20 Sep 2022 11:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 2/3] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA master
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220919082611.19824-1-chengci.xu@mediatek.com>
 <20220919082611.19824-3-chengci.xu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919082611.19824-3-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 10:26, Chengci.Xu ha scritto:
> The register which can enable IOMMU for INFRA master should be setted
> in secure world for security concerns. Therefore, we add a SMC command
> for INFRA master to enable/disable INFRA IOMMU in ATF. This function is
> prepared for MT8188.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c  | 21 +++++++++++++++++++--
>   include/soc/mediatek/smi.h |  1 +
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 552e4eb8c610..8b8a289bab2c 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2015-2016 MediaTek Inc.
>    * Author: Yong Wu <yong.wu@mediatek.com>
>    */
> +#include <linux/arm-smccc.h>
>   #include <linux/bitfield.h>
>   #include <linux/bug.h>
>   #include <linux/clk.h>
> @@ -28,6 +29,7 @@
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
>   #include <asm/barrier.h>
>   #include <soc/mediatek/smi.h>
>   
> @@ -138,6 +140,7 @@
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
>   #define PGTABLE_PA_35_EN		BIT(17)
> +#define CFG_IFA_MASTER_IN_ATF		BIT(18)
>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -553,7 +556,20 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
>   				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
>   			else
>   				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> -		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
> +		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> +			   MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
> +			struct arm_smccc_res res;
> +
> +			arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
> +				      IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,
> +				      portid, enable, 0, 0, 0, 0, &res);
> +			if (res.a0 != 0) {
> +				dev_err(dev, "%s iommu(%s) inframaster %d fail(%ld).\n",
> +					enable ? "enable" : "disable",
> +					dev_name(data->dev), portid, res.a0);
> +				ret = -EINVAL;
> +			}
> +		} else {

This one is opening a big window for future mistakes.

I think that the only way that you have to do this is...

	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
		if (MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
			arm_smcc_smc ....
		} else {
			peri_mmuen_msk ....
		}
	}

Otherwise, to reduce indentation, you'd have to do something like...

static int mtk_iommu_config_one(struct mtk_iommu_data *data, struct device *dev,
				bool enable, u32 regionid, u32 larbid, u32 portid)
{
	struct mtk_smi_larb_iommu *larb_mmu;
	............
}

static int mtk_iommu_config(struct .............)
{
	vars, etc....

	for (i = 0; i < fwspec->num_ids; ++i)
		mtk_iommu_config_one(data, dev, enable, regionid,
				     MTK_M4U_TO_LARB(...), MTK_M4U_TO_PORT(...));
}


or....

static int mtk_iommu_config_one_infra(struct ....)
{
	if (is atf) ....
	else ....
}

Your choice.

Regards,
Angelo


