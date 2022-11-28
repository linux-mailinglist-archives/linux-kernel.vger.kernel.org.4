Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3B639F47
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiK1CIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiK1CIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:08:02 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D3E60DB;
        Sun, 27 Nov 2022 18:07:58 -0800 (PST)
X-UUID: a852bec5109b4da0a1e9d7395face97e-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RAHYx+yC2L4aeoYHMLJ9WFBo8b/lAMkyPT/4vIdkWEk=;
        b=TY1jsitmzG9e5n4k6zMMRA+QxALcn4H2+2NghJVQjQbipvdvUkyIItGrwp46MyOzsOXF81BUUOBW96v2YX9Vccgh1zI24zMeKjaWBkpH8o/Go+hazf9bm6i/mN2Xz7gsOKHI4d1bxYaC3bClh950G5mOliULyFghA0SJxx5SLlc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:951e8634-83f8-4bd5-abdb-854350a8a0c0,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.14,REQID:951e8634-83f8-4bd5-abdb-854350a8a0c0,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:dcaaed0,CLOUDID:4aa861dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221128100755PT2FXFY4,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a852bec5109b4da0a1e9d7395face97e-20221128
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1644978914; Mon, 28 Nov 2022 10:07:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 10:07:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 28 Nov 2022 10:07:51 +0800
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
        <benliang.zhao@mediatek.com>, <bin.zhang@mediatek.com>
Subject: [PATCH 6/9] spi: mtk-snfi: add snfi sample delay and read latency adjustment
Date:   Mon, 28 Nov 2022 10:06:10 +0800
Message-ID: <20221128020613.14821-7-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
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
---
 drivers/spi/spi-mtk-snfi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 85644308df23..e8587cf2aff2 100644
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
@@ -205,6 +207,7 @@
 
 #define SNF_DLY_CTL3 0x548
 #define SFCK_SAM_DLY_S 0
+#define SFCK_SAM_DLY GENMASK(5, 0)
 
 #define SNF_STA_CTL1 0x550
 #define CUS_PG_DONE BIT(28)
@@ -1368,6 +1371,7 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	const struct of_device_id *dev_id;
 	struct spi_controller *ctlr;
 	struct mtk_snand *ms;
+	u32 val = 0;
 	int ret;
 
 	dev_id = of_match_node(mtk_snand_ids, np);
@@ -1446,6 +1450,15 @@ static int mtk_snand_probe(struct platform_device *pdev)
 	// switch to SNFI mode
 	nfi_write32(ms, SNF_CFG, SPI_MODE);
 
+	ret = of_property_read_u32(np, "rx-sample-delay", &val);
+	if (!ret)
+		nfi_rmw32(ms, SNF_DLY_CTL3, SFCK_SAM_DLY, val);
+
+	ret = of_property_read_u32(np, "rx-latch-latency", &val);
+	if (!ret)
+		nfi_rmw32(ms, SNF_MISC_CTL, DATA_READ_LATCH_LAT,
+			  val << DATA_READ_LATCH_LAT_S);
+
 	// setup an initial page format for ops matching page_cache_op template
 	// before ECC is called.
 	ret = mtk_snand_setup_pagefmt(ms, SZ_2K, SZ_64);
-- 
2.25.1

