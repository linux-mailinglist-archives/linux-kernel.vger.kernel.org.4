Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05C25FF83F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJOD2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJOD2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:28:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF99F35B;
        Fri, 14 Oct 2022 20:28:43 -0700 (PDT)
X-UUID: e607805a5172452abdf61596c6e96f39-20221015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=45IwU2giXpRXnrpqTA7PN/8OhpTelJj2AeNgL21tKzo=;
        b=UqpG4YASHeufb5je3cES5sgcUwQFvIVaBgEfDE2SbZ1dO/KiEN7/cvbpkAZwo2N+n1gB7kMq5BMqSbJorEoEgJ9nKTD5Xm/cxOQVTPJRU1YsrBItmpGilyesvL32+lH4ka4B4OhU/Km6RT2V44snmseNS+zAbpL8iRyAxJp5//o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:cb01a9cc-0189-456e-9b44-0293a55950fa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:cb01a9cc-0189-456e-9b44-0293a55950fa,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:ee0d6adb-0379-47b3-a5dd-2ef5001d380a,B
        ulkID:221015112538DSKRIK5P,BulkQuantity:5,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: e607805a5172452abdf61596c6e96f39-20221015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1775327724; Sat, 15 Oct 2022 11:28:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 15 Oct 2022 11:28:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Sat, 15 Oct 2022 11:28:23 +0800
Message-ID: <948365ac6b88711b164ada5a1bf98ddd99340255.camel@mediatek.com>
Subject: Re: [PATCH v4 2/3] iommu/mediatek: add support for 6-bit encoded
 port IDs
From:   Yong Wu <yong.wu@mediatek.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-mediatek@lists.infradead.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        <devicetree@vger.kernel.org>, <iommu@lists.linux.dev>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 15 Oct 2022 11:28:23 +0800
In-Reply-To: <20221001-iommu-support-v4-2-f1e13438dfd2@baylibre.com>
References: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
         <20221001-iommu-support-v4-2-f1e13438dfd2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-14 at 10:45 +0200, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Until now the port ID was always encoded as a 5-bit data. On MT8365,
> the port ID is encoded as a 6-bit data. This requires to add extra
> macro F_MMU_INT_ID_LARB_ID_EXT, and F_MMU_INT_ID_PORT_ID_EXT in order
> to support 6-bit encoded port IDs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/iommu/mtk_iommu.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5a4e00e4bbbc..50195a900611 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -108,8 +108,12 @@
>  #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
>  #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
>  #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) &
> 0x7)
> +/* Macro for 5 bits length port ID field (default) */
>  #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) &
> 0x7)
>  #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) &
> 0x1f)
> +/* Macro for 6 bits length port ID field */
> +#define F_MMU_INT_ID_LARB_ID_EXT(a)		(((a) >> 8) & 0x7)
> +#define F_MMU_INT_ID_PORT_ID_EXT(a)		(((a) >> 2) & 0x3f)

So far only mt8365 use 6 bits here. We could rename more detailly:

like F_MMU_INT_ID_PORT_ID_MT8365 or keep consistent with the below flag
name: F_MMU_INT_ID_PORT_ID_WID_6.

>  
>  #define MTK_PROTECT_PA_ALIGN			256
>  #define MTK_IOMMU_BANK_SZ			0x1000
> @@ -139,6 +143,7 @@
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
>  #define PGTABLE_PA_35_EN		BIT(17)
>  #define TF_PORT_TO_ADDR_MT8173		BIT(18)
> +#define HAS_INT_ID_PORT_WIDTH_6		BIT(19)

HAS_SUB_COM means the SoC has SMI sub_common. this only indicate
port width is 6bits. No need "HAS_". I think INT_ID_PORT_WIDTH_6 is ok.

>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -441,7 +446,11 @@ static irqreturn_t mtk_iommu_isr(int irq, void
> *dev_id)
>  	fault_pa |= (u64)pa34_32 << 32;
>  
>  	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
> -		fault_port = F_MMU_INT_ID_PORT_ID(regval);
> +		if (MTK_IOMMU_HAS_FLAG(plat_data,
> HAS_INT_ID_PORT_WIDTH_6)) {
> +			fault_port = F_MMU_INT_ID_PORT_ID_EXT(regval);
> +		} else {
> +			fault_port = F_MMU_INT_ID_PORT_ID(regval);
> +		}
>  		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS))
> {
>  			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
>  			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
> @@ -449,7 +458,11 @@ static irqreturn_t mtk_iommu_isr(int irq, void
> *dev_id)
>  			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
>  			sub_comm =
> F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
>  		} else {
> -			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
> +			if (MTK_IOMMU_HAS_FLAG(plat_data,
> HAS_INT_ID_PORT_WIDTH_6)) {
> +				fault_larb =
> F_MMU_INT_ID_LARB_ID_EXT(regval);
> +			} else {
> +				fault_larb =
> F_MMU_INT_ID_LARB_ID(regval);
> +			}
>  		}

It has two checking about this new flag. How about this?

if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
    fault_larb
= x
    sub_com = x
    fault_port = F_MMU_INT_ID_PORT_ID(regval); //New add    
} else if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_3BITS)) {
    fault_larb = x
    sub_com = x
    fault_port= F_MMU_INT_ID_PORT_ID(regval); //New add 
} else if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_INT_ID_PORT_WIDTH_6)) { /*
mt8365 */
    fault_port = F_MMU_INT_ID_PORT_ID_EXT(regval);
    fault_larb =
F_MMU_INT_ID_LARB_ID_EXT(regval);
} else {
    fault_larb = F_MMU_INT_ID_LARB_ID(regval);
    fault_port = F_MMU_INT_ID_PORT_ID(regval);
}
>  		fault_larb = data->plat_data-
> >larbid_remap[fault_larb][sub_comm];
>  	}
> 

