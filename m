Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4265068C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 03:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiLSClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 21:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiLSClE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 21:41:04 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267ED63A4;
        Sun, 18 Dec 2022 18:40:58 -0800 (PST)
X-UUID: d48c9bf857684ccaa246d29f7c3a3269-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v0RLYJNNjOaZwIF3K4Tu0NmZq0XJJx6TB5aHEi73l4Y=;
        b=WJoUUjcRY1IJTZnKlOjK6BZX1rK+mDsqhHZIC2OedgUntGsxC41bfPbFIYExk3Br5XDr+rx8y/ojho+aSvGD4ihqxo5eP31HmEckAvPe7M6rySArjF+Y991Mi9r0k5ccSER2m4n3wvP3iQVJ2wgoOuyuX8L4sRccS5f981/Pm7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:3014786d-699b-45ad-b1ba-cde9b6d9c9e4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:aed81952-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d48c9bf857684ccaa246d29f7c3a3269-20221219
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1763200135; Mon, 19 Dec 2022 10:40:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 10:40:51 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Dec 2022 10:40:50 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
CC:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 05/10] spi: mtk-snfi: Add snfi sample delay and read latency adjustment
Date:   Mon, 19 Dec 2022 10:40:14 +0800
Message-ID: <20221219024019.31974-6-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
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

