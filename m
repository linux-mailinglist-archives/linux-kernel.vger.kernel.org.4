Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC264232E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiLEG6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:58:18 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1564CB;
        Sun,  4 Dec 2022 22:58:14 -0800 (PST)
X-UUID: 5f5c10f909ca4b99938310a92920325c-20221205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1WMPHgGT2Vc06cNDWGV7eQXxRmPqVm37oCGD2yTJxvQ=;
        b=DOLBopSdwrxYRACR642xEdclstPqvpiA15BQILD3PwlcKb9dYkhO9ZHgwReZgPTj2hG5d2I1MM+cmcg9/YvWSSMIlCY7IM3JaswwpivhfEDHtEniCOitZogRYfClAFMRbcmQX52eus4zpeskonYOegjmiHzzEmoEUBq+AvXYudQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0cc62d45-d4b9-46d9-9f18-81fe86a57a79,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.14,REQID:0cc62d45-d4b9-46d9-9f18-81fe86a57a79,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:dcaaed0,CLOUDID:af1f916c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221205145809XW7S9LTG,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5f5c10f909ca4b99938310a92920325c-20221205
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1479084019; Mon, 05 Dec 2022 14:58:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Dec 2022 14:58:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 5 Dec 2022 14:58:08 +0800
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
Subject: [PATCH v2 1/9] spi: mtk-snfi: Add snfi support for MT7986 IC
Date:   Mon, 5 Dec 2022 14:57:48 +0800
Message-ID: <20221205065756.26875-2-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
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

Add snfi support for MT7986 IC.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
---
 drivers/spi/spi-mtk-snfi.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index d66bf9762557..fa8412ba20e2 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -126,7 +126,8 @@
 #define STR_DATA BIT(0)
 
 #define NFI_STA 0x060
-#define NFI_NAND_FSM GENMASK(28, 24)
+#define NFI_NAND_FSM_7622 GENMASK(28, 24)
+#define NFI_NAND_FSM_7986 GENMASK(29, 23)
 #define NFI_FSM GENMASK(19, 16)
 #define READ_EMPTY BIT(12)
 
@@ -158,6 +159,7 @@
 #define MAS_WR GENMASK(5, 3)
 #define MAS_RDDLY GENMASK(2, 0)
 #define NFI_MASTERSTA_MASK_7622 (MAS_ADDR | MAS_RD | MAS_WR | MAS_RDDLY)
+#define NFI_MASTERSTA_MASK_7986 3
 
 // SNFI registers
 #define SNF_MAC_CTL 0x500
@@ -220,6 +222,11 @@
 
 static const u8 mt7622_spare_sizes[] = { 16, 26, 27, 28 };
 
+static const u8 mt7986_spare_sizes[] = {
+	16, 26, 27, 28, 32, 36, 40, 44, 48, 49, 50, 51, 52, 62, 61, 63, 64, 67,
+	74
+};
+
 struct mtk_snand_caps {
 	u16 sector_size;
 	u16 max_sectors;
@@ -230,6 +237,7 @@ struct mtk_snand_caps {
 	bool bbm_swap;
 	bool empty_page_check;
 	u32 mastersta_mask;
+	u32 nandfsm_mask;
 
 	const u8 *spare_sizes;
 	u32 num_spare_size;
@@ -244,6 +252,7 @@ static const struct mtk_snand_caps mt7622_snand_caps = {
 	.bbm_swap = false,
 	.empty_page_check = false,
 	.mastersta_mask = NFI_MASTERSTA_MASK_7622,
+	.nandfsm_mask = NFI_NAND_FSM_7622,
 	.spare_sizes = mt7622_spare_sizes,
 	.num_spare_size = ARRAY_SIZE(mt7622_spare_sizes)
 };
@@ -257,10 +266,25 @@ static const struct mtk_snand_caps mt7629_snand_caps = {
 	.bbm_swap = true,
 	.empty_page_check = false,
 	.mastersta_mask = NFI_MASTERSTA_MASK_7622,
+	.nandfsm_mask = NFI_NAND_FSM_7622,
 	.spare_sizes = mt7622_spare_sizes,
 	.num_spare_size = ARRAY_SIZE(mt7622_spare_sizes)
 };
 
+static const struct mtk_snand_caps mt7986_snand_caps = {
+	.sector_size = 1024,
+	.max_sectors = 8,
+	.fdm_size = 8,
+	.fdm_ecc_size = 1,
+	.fifo_size = 64,
+	.bbm_swap = true,
+	.empty_page_check = true,
+	.mastersta_mask = NFI_MASTERSTA_MASK_7986,
+	.nandfsm_mask = NFI_NAND_FSM_7986,
+	.spare_sizes = mt7986_spare_sizes,
+	.num_spare_size = ARRAY_SIZE(mt7986_spare_sizes)
+};
+
 struct mtk_snand_conf {
 	size_t page_size;
 	size_t oob_size;
@@ -360,7 +384,7 @@ static int mtk_nfi_reset(struct mtk_snand *snf)
 	}
 
 	ret = readl_poll_timeout(snf->nfi_base + NFI_STA, val,
-				 !(val & (NFI_FSM | NFI_NAND_FSM)), 0,
+				 !(val & (NFI_FSM | snf->caps->nandfsm_mask)), 0,
 				 SNFI_POLL_INTERVAL);
 	if (ret) {
 		dev_err(snf->dev, "Failed to reset NFI\n");
@@ -1295,6 +1319,7 @@ static irqreturn_t mtk_snand_irq(int irq, void *id)
 static const struct of_device_id mtk_snand_ids[] = {
 	{ .compatible = "mediatek,mt7622-snand", .data = &mt7622_snand_caps },
 	{ .compatible = "mediatek,mt7629-snand", .data = &mt7629_snand_caps },
+	{ .compatible = "mediatek,mt7986-snand", .data = &mt7986_snand_caps },
 	{},
 };
 
-- 
2.25.1

