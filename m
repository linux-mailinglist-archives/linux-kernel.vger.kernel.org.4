Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE75B7649
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIMQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiIMQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:18:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576FD786DB;
        Tue, 13 Sep 2022 08:14:16 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E4C96601BF7;
        Tue, 13 Sep 2022 16:12:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663081925;
        bh=cf5hsjYOn6G7Lc7ENq6TOpInHHzZ+vJ1oGSDMkkGGoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opt4PqghLEWF31cLHWZlQ1sB9rHwqyMNSHmi1XoesYTyF2l2SAcSwq0LnS6gL57/V
         RPmLJ6EywqP0QH0CB9Hxjf35T9bQqIph37aqYE5cXezUPo0Cnq4FtFChrMjQ9yYq3w
         fRNCRzOyC9+sn+TEyZdM80Hc1S0D9v2EzDkm6g9YYLm3wyFtoyohJ82XNCZBSWE5oE
         kGzNJ1Q3wTL/TLhTuzS1uLn9vI3k8HKNeeROUSszwtoAbWxAo+lRkU8hkz4ehPv0YG
         8LUzF9OtIaAFnUznYh6nmt0tjfMiHlq9FZvIqY3n8MfrDEUzqayyPJDdC1/m86YPDj
         a64xbFxWRlzFg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 2/3] iommu/mediatek: Introduce new flag TF_PORT_TO_ADDR_MT8173
Date:   Tue, 13 Sep 2022 17:11:47 +0200
Message-Id: <20220913151148.412312-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
References: <20220913151148.412312-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for MT6795, add a new flag named
TF_PORT_TO_ADDR_MT8173 and use that instead of checking for m4u_plat
type in mtk_iommu_hw_init() to avoid seeing a long list of m4u_plat
checks there in the future.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..b511359376f4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -138,6 +138,7 @@
 #define PM_CLK_AO			BIT(15)
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 #define PGTABLE_PA_35_EN		BIT(17)
+#define TF_PORT_TO_ADDR_MT8173		BIT(18)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -955,7 +956,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int ban
 	 * Global control settings are in bank0. May re-init these global registers
 	 * since no sure if there is bank0 consumers.
 	 */
-	if (data->plat_data->m4u_plat == M4U_MT8173) {
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, TF_PORT_TO_ADDR_MT8173)) {
 		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
 	} else {
@@ -1427,7 +1428,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
-			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
+			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM |
+			TF_PORT_TO_ADDR_MT8173,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.banks_num    = 1,
 	.banks_enable = {true},
-- 
2.37.2

