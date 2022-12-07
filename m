Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BEE6453C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLGF4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLGFzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:55:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6A58BD7;
        Tue,  6 Dec 2022 21:54:46 -0800 (PST)
X-UUID: 77947c900e254c3cabf6f9d2e91f9499-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ftv+zxGMO96uvHy3jqmtrqARC5DnXXOr5/mLoPd06k4=;
        b=PeSup/zty3kKR6OXmfasnxVKzAJc03Frnntb2Nzq+gwrij3o41Kvu7PD+DopirmZVoarRFKYMhfLTHnFfuzyhZqhG2UPXe5DLjuTekhQ2jO/Lhy5++d2ltQY8ifhHzY6ZT2dcQcBhxaC9bzSM2sMHbjm4DHYtbGnnLtbo4gC7fk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:19506cac-e56c-4c82-8a67-f160b814a8e3,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:dcaaed0,CLOUDID:6518e0d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 77947c900e254c3cabf6f9d2e91f9499-20221207
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 909069027; Wed, 07 Dec 2022 13:54:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 13:54:37 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 7 Dec 2022 13:54:37 +0800
From:   Bayi Cheng <bayi.cheng@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        bayi cheng <bayi.cheng@mediatek.com>
Subject: [PATCH v2] spi: spi-mtk-nor: Add recovery mechanism for dma read timeout
Date:   Wed, 7 Dec 2022 13:54:35 +0800
Message-ID: <20221207055435.30557-1-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 2.25.1
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

From: bayi cheng <bayi.cheng@mediatek.com>

The state machine of MTK spi nor controller may be disturbed by some
glitch signals from the relevant BUS during dma read, Although the
possibility of causing the dma read to fail is next to nothing,
However, if error-handling is not implemented, which makes the feature
somewhat risky.

Add an error-handling mechanism here, reset the state machine and
re-read the data when an error occurs.

Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
---
Change in v2:
  -Add a new function mtk_nor_reset() to reset host state machine.

Change in v1:
  -Reset the state machine when dma read fails and read again.
---
---
 drivers/spi/spi-mtk-nor.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index d167699a1a96..d07f50337f43 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -80,6 +80,9 @@
 #define MTK_NOR_REG_DMA_FADR		0x71c
 #define MTK_NOR_REG_DMA_DADR		0x720
 #define MTK_NOR_REG_DMA_END_DADR	0x724
+#define MTK_NOR_REG_CG_DIS		0x728
+#define MTK_NOR_SFC_SW_RST		BIT(2)
+
 #define MTK_NOR_REG_DMA_DADR_HB		0x738
 #define MTK_NOR_REG_DMA_END_DADR_HB	0x73c
 
@@ -147,6 +150,15 @@ static inline int mtk_nor_cmd_exec(struct mtk_nor *sp, u32 cmd, ulong clk)
 	return ret;
 }
 
+static void mtk_nor_reset(struct mtk_nor *sp)
+{
+	mtk_nor_rmw(sp, MTK_NOR_REG_CG_DIS, 0, MTK_NOR_SFC_SW_RST);
+	mb(); /* flush previous writes */
+	mtk_nor_rmw(sp, MTK_NOR_REG_CG_DIS, MTK_NOR_SFC_SW_RST, 0);
+	mb(); /* flush previous writes */
+	writel(MTK_NOR_ENABLE_SF_CMD, sp->base + MTK_NOR_REG_WP);
+}
+
 static void mtk_nor_set_addr(struct mtk_nor *sp, const struct spi_mem_op *op)
 {
 	u32 addr = op->addr.val;
@@ -616,7 +628,15 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 			mtk_nor_set_addr(sp, op);
 			return mtk_nor_read_pio(sp, op);
 		} else {
-			return mtk_nor_read_dma(sp, op);
+			ret = mtk_nor_read_dma(sp, op);
+			if (unlikely(ret)) {
+				/* Handle rare bus glitch */
+				mtk_nor_reset(sp);
+				mtk_nor_setup_bus(sp, op);
+				return mtk_nor_read_dma(sp, op);
+			}
+
+			return ret;
 		}
 	}
 
-- 
2.18.0

