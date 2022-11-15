Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB3629927
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiKOMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiKOMrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:47:10 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55ED27DC4;
        Tue, 15 Nov 2022 04:47:05 -0800 (PST)
X-UUID: 769bc245b5924426bf4b1b63377e16b4-20221115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=M5TRJ92JPSujVV77tXKFEvHsZ6iHftmWR79uxeFROKU=;
        b=tS4Ny40JlbmEW8uvBh/y4Y9Om/qp2ScQBGESjgKaKFephpBbuuOjeaSbHJdj+IOqfNY7O2xoIly5xzuZamcIyE9n1hF1SZDUKIxXXenF8VyXgi+Y4zGfRnx3c/ihN5CTE+mSH9Wro5bJVYtztvbB8yVBP+xoL1myXuHickckbeU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:96f47c15-5c34-418d-93ff-7e6a7a9a096a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d12e911,CLOUDID:8e7fbfac-70f0-4e5b-83e6-c0b7915231c3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 769bc245b5924426bf4b1b63377e16b4-20221115
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1703265728; Tue, 15 Nov 2022 20:46:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 15 Nov 2022 20:46:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 15 Nov 2022 20:46:57 +0800
From:   Bayi Cheng <bayi.cheng@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        bayi cheng <bayi.cheng@mediatek.com>
Subject: [PATCH v1] spi: spi-mtk-nor: Unify write buffer on/off
Date:   Tue, 15 Nov 2022 20:46:55 +0800
Message-ID: <20221115124655.10124-1-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: bayi cheng <bayi.cheng@mediatek.com>

The logical structures of mtk_nor_write_buffer_enable and
mtk_nor_write_buffer_disable are very similar, So it is necessary to
combine them into one.

Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
---
Change in v1:
  -Delete mtk_nor_write_buffer_enable.
  -Delete mtk_nor_write_buffer_disable.
  -Add mtk_nor_setup_write_buffer.
---
---
 drivers/spi/spi-mtk-nor.c | 40 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index d167699a1a96..e8b355f5be56 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -443,36 +443,28 @@ static int mtk_nor_read_pio(struct mtk_nor *sp, const struct spi_mem_op *op)
 	return ret;
 }
 
-static int mtk_nor_write_buffer_enable(struct mtk_nor *sp)
+static int mtk_nor_setup_write_buffer(struct mtk_nor *sp, bool on)
 {
 	int ret;
 	u32 val;
 
-	if (sp->wbuf_en)
+	if (!(sp->wbuf_en ^ on))
 		return 0;
 
 	val = readl(sp->base + MTK_NOR_REG_CFG2);
-	writel(val | MTK_NOR_WR_BUF_EN, sp->base + MTK_NOR_REG_CFG2);
-	ret = readl_poll_timeout(sp->base + MTK_NOR_REG_CFG2, val,
-				 val & MTK_NOR_WR_BUF_EN, 0, 10000);
-	if (!ret)
-		sp->wbuf_en = true;
-	return ret;
-}
-
-static int mtk_nor_write_buffer_disable(struct mtk_nor *sp)
-{
-	int ret;
-	u32 val;
+	if (on) {
+		writel(val | MTK_NOR_WR_BUF_EN, sp->base + MTK_NOR_REG_CFG2);
+		ret = readl_poll_timeout(sp->base + MTK_NOR_REG_CFG2, val,
+					 val & MTK_NOR_WR_BUF_EN, 0, 10000);
+	} else {
+		writel(val & ~MTK_NOR_WR_BUF_EN, sp->base + MTK_NOR_REG_CFG2);
+		ret = readl_poll_timeout(sp->base + MTK_NOR_REG_CFG2, val,
+					 !(val & MTK_NOR_WR_BUF_EN), 0, 10000);
+	}
 
-	if (!sp->wbuf_en)
-		return 0;
-	val = readl(sp->base + MTK_NOR_REG_CFG2);
-	writel(val & ~MTK_NOR_WR_BUF_EN, sp->base + MTK_NOR_REG_CFG2);
-	ret = readl_poll_timeout(sp->base + MTK_NOR_REG_CFG2, val,
-				 !(val & MTK_NOR_WR_BUF_EN), 0, 10000);
 	if (!ret)
-		sp->wbuf_en = false;
+		sp->wbuf_en = on;
+
 	return ret;
 }
 
@@ -482,7 +474,7 @@ static int mtk_nor_pp_buffered(struct mtk_nor *sp, const struct spi_mem_op *op)
 	u32 val;
 	int ret, i;
 
-	ret = mtk_nor_write_buffer_enable(sp);
+	ret = mtk_nor_setup_write_buffer(sp, true);
 	if (ret < 0)
 		return ret;
 
@@ -501,7 +493,7 @@ static int mtk_nor_pp_unbuffered(struct mtk_nor *sp,
 	const u8 *buf = op->data.buf.out;
 	int ret;
 
-	ret = mtk_nor_write_buffer_disable(sp);
+	ret = mtk_nor_setup_write_buffer(sp, false);
 	if (ret < 0)
 		return ret;
 	writeb(buf[0], sp->base + MTK_NOR_REG_WDATA);
@@ -608,7 +600,7 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	}
 
 	if ((op->data.dir == SPI_MEM_DATA_IN) && mtk_nor_match_read(op)) {
-		ret = mtk_nor_write_buffer_disable(sp);
+		ret = mtk_nor_setup_write_buffer(sp, false);
 		if (ret < 0)
 			return ret;
 		mtk_nor_setup_bus(sp, op);
-- 
2.25.1

