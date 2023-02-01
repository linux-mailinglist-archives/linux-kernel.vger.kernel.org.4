Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC20685D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjBACKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjBACKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:10:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A325658678;
        Tue, 31 Jan 2023 18:09:38 -0800 (PST)
X-UUID: 77265e02a1d511ed945fc101203acc17-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v0RLYJNNjOaZwIF3K4Tu0NmZq0XJJx6TB5aHEi73l4Y=;
        b=M9G3DXjNqRIou93ppeyELlWNgaIB0hz137+/bbjixulZyKapeapkUwZrkAr7PfAlOc6SC5NAVFCRfB3KkKMVT0+oTmDMMx9KW+w4GoBbPqmfW+WEj3V8tvdN7MM6+ymb1OtqKsCqCbkL2Auc3Y0lXDk543xsJfrAbuojogxzFQ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:2032cd59-f9a8-46cc-bcb1-56425e4a293b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:3ca2d6b,CLOUDID:f103858d-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 77265e02a1d511ed945fc101203acc17-20230201
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1251141084; Wed, 01 Feb 2023 10:09:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Feb 2023 10:09:30 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Feb 2023 10:09:29 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chuanhong Guo <gch981213@gmail.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benliang.zhao@mediatek.com>,
        <bin.zhang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 4/5] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
Date:   Wed, 1 Feb 2023 10:09:20 +0800
Message-ID: <20230201020921.26712-5-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201020921.26712-1-xiangsheng.hou@mediatek.com>
References: <20230201020921.26712-1-xiangsheng.hou@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add snfi sample delay and read latency adjustment which can get
from dts property.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-mtk-snfi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 85644308df23..f3f95eb37365 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -195,6 +195,8 @@
 #define DATA_READ_MODE_X4 2
 #define DATA_READ_MODE_DUAL 5
 #define DATA_READ_MODE_QUAD 6
+#define DATA_READ_LATCH_LAT GENMASK(9, 8)
+#define DATA_READ_LATCH_LAT_S 8
 #define PG_LOAD_CUSTOM_EN BIT(7)
 #define DATARD_CUSTOM_EN BIT(6)
 #define CS_DESELECT_CYC_S 0
@@ -205,6 +207,9 @@
 
 #define SNF_DLY_CTL3 0x548
 #define SFCK_SAM_DLY_S 0
+#define SFCK_SAM_DLY GENMASK(5, 0)
+#define SFCK_SAM_DLY_TOTAL 9
+#define SFCK_SAM_DLY_RANGE 47
 
 #define SNF_STA_CTL1 0x550
 #define CUS_PG_DONE BIT(28)
@@ -1368,6 +1373,8 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	const struct of_device_id *dev_id;
 	struct spi_controller *ctlr;
 	struct mtk_snand *ms;
+	unsigned long spi_freq;
+	u32 val = 0;
 	int ret;
 
 	dev_id = of_match_node(mtk_snand_ids, np);
@@ -1446,6 +1453,19 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	// switch to SNFI mode
 	nfi_write32(ms, SNF_CFG, SPI_MODE);
 
+	ret = of_property_read_u32(np, "rx-sample-delay-ns", &val);
+	if (!ret)
+		nfi_rmw32(ms, SNF_DLY_CTL3, SFCK_SAM_DLY,
+			  val * SFCK_SAM_DLY_RANGE / SFCK_SAM_DLY_TOTAL);
+
+	ret = of_property_read_u32(np, "mediatek,rx-latch-latency-ns", &val);
+	if (!ret) {
+		spi_freq = clk_get_rate(ms->pad_clk);
+		val = DIV_ROUND_CLOSEST(val, NSEC_PER_SEC / spi_freq);
+		nfi_rmw32(ms, SNF_MISC_CTL, DATA_READ_LATCH_LAT,
+			  val << DATA_READ_LATCH_LAT_S);
+	}
+
 	// setup an initial page format for ops matching page_cache_op template
 	// before ECC is called.
 	ret = mtk_snand_setup_pagefmt(ms, SZ_2K, SZ_64);
-- 
2.25.1

