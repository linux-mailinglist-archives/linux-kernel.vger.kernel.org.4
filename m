Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922F64693E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLHGab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiLHGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:30:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9677B9AE13;
        Wed,  7 Dec 2022 22:30:12 -0800 (PST)
X-UUID: e8cc351188b945b7bcea00ffc7100d64-20221208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hVi9EpIqUGu5hM1nwlZ9chU7gT1LcCd3BvW0rXQFN+4=;
        b=mgNy2yLNPQe/mLNQa8QEUyZLJT4V4lQM80Scc7Tmz4aKD/oGofgjbC5WdRFqO/gfs/YLMWeJZatDHH289ayt7Fz8XVbc/eVFPuCj3+jgwMO5eUD4Dkz1UuzWes6kFWuqiWnuj7s/CE6gsGgjN3dws3HKywlpEM/RVeJEQ7bpExw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:aa9532d7-091b-47b6-911e-503c98573a60,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:86c7a924-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e8cc351188b945b7bcea00ffc7100d64-20221208
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1668680293; Thu, 08 Dec 2022 14:30:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Dec 2022 14:30:04 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 8 Dec 2022 14:30:03 +0800
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
Subject: [PATCH v3 3/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Date:   Thu, 8 Dec 2022 14:29:49 +0800
Message-ID: <20221208062955.2546-4-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
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

Add ECC support fot MT7986 IC, and change err_mask value with
GENMASK macro.

Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
---
 drivers/mtd/nand/ecc-mtk.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
index 9f9b201fe706..c75bb8b80cc1 100644
--- a/drivers/mtd/nand/ecc-mtk.c
+++ b/drivers/mtd/nand/ecc-mtk.c
@@ -40,6 +40,10 @@
 #define ECC_IDLE_REG(op)	((op) == ECC_ENCODE ? ECC_ENCIDLE : ECC_DECIDLE)
 #define ECC_CTL_REG(op)		((op) == ECC_ENCODE ? ECC_ENCCON : ECC_DECCON)
 
+#define ECC_ERRMASK_MT7622	GENMASK(4, 0)
+#define ECC_ERRMASK_MT2701	GENMASK(5, 0)
+#define ECC_ERRMASK_MT2712	GENMASK(6, 0)
+
 struct mtk_ecc_caps {
 	u32 err_mask;
 	u32 err_shift;
@@ -79,6 +83,10 @@ static const u8 ecc_strength_mt7622[] = {
 	4, 6, 8, 10, 12
 };
 
+static const u8 ecc_strength_mt7986[] = {
+	4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24
+};
+
 enum mtk_ecc_regs {
 	ECC_ENCPAR00,
 	ECC_ENCIRQ_EN,
@@ -451,7 +459,7 @@ unsigned int mtk_ecc_get_parity_bits(struct mtk_ecc *ecc)
 EXPORT_SYMBOL(mtk_ecc_get_parity_bits);
 
 static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
-	.err_mask = 0x3f,
+	.err_mask = ECC_ERRMASK_MT2701,
 	.err_shift = 8,
 	.ecc_strength = ecc_strength_mt2701,
 	.ecc_regs = mt2701_ecc_regs,
@@ -462,7 +470,7 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
 };
 
 static const struct mtk_ecc_caps mtk_ecc_caps_mt2712 = {
-	.err_mask = 0x7f,
+	.err_mask = ECC_ERRMASK_MT2712,
 	.err_shift = 8,
 	.ecc_strength = ecc_strength_mt2712,
 	.ecc_regs = mt2712_ecc_regs,
@@ -473,7 +481,7 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt2712 = {
 };
 
 static const struct mtk_ecc_caps mtk_ecc_caps_mt7622 = {
-	.err_mask = 0x1f,
+	.err_mask = ECC_ERRMASK_MT7622,
 	.err_shift = 5,
 	.ecc_strength = ecc_strength_mt7622,
 	.ecc_regs = mt7622_ecc_regs,
@@ -483,6 +491,17 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt7622 = {
 	.pg_irq_sel = 0,
 };
 
+static const struct mtk_ecc_caps mtk_ecc_caps_mt7986 = {
+	.err_mask = ECC_ERRMASK_MT7622,
+	.err_shift = 8,
+	.ecc_strength = ecc_strength_mt7986,
+	.ecc_regs = mt2712_ecc_regs,
+	.num_ecc_strength = 11,
+	.ecc_mode_shift = 5,
+	.parity_bits = 14,
+	.pg_irq_sel = 1,
+};
+
 static const struct of_device_id mtk_ecc_dt_match[] = {
 	{
 		.compatible = "mediatek,mt2701-ecc",
@@ -493,6 +512,9 @@ static const struct of_device_id mtk_ecc_dt_match[] = {
 	}, {
 		.compatible = "mediatek,mt7622-ecc",
 		.data = &mtk_ecc_caps_mt7622,
+	}, {
+		.compatible = "mediatek,mt7986-ecc",
+		.data = &mtk_ecc_caps_mt7986,
 	},
 	{},
 };
-- 
2.25.1

