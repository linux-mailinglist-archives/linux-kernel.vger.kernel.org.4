Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2744607401
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJUJ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJUJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:26:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340081119E7;
        Fri, 21 Oct 2022 02:26:11 -0700 (PDT)
X-UUID: 0018b82e76504adeb0a5f38c6ad7ce51-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TDfh+x5FytpWi0W8sYJ9u2fBze82/hHd4fVkyhEFTUQ=;
        b=NTG13TMMFoUnQYSCCW/LMGVc27cDGpcJLh9ICuV9waD/NVwDn2krFD3tM7M+TJl1J/OEpIcD8iJCZSuZM8Xr9ljuVBMbCJV2JoQkwAXJoMu5ICxAaE7COk8LAHOsKH9x/XTd7MMYUpeXKnWISJBYTHhq5r82i1+UILLY4ijFFUM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a9e61a8e-06a9-4544-867f-9bd59ba28860,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:f3bfae6c-89d3-4bfa-baad-dc632a24bca3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0018b82e76504adeb0a5f38c6ad7ce51-20221021
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <zhichao.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1252444914; Fri, 21 Oct 2022 17:26:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 21 Oct 2022 17:26:05 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 21 Oct 2022 17:26:05 +0800
From:   Zhichao Liu <zhichao.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <zhichao.liu@mediatek.com>
Subject: [PATCH] spi: mediatek: Fix package division error
Date:   Fri, 21 Oct 2022 17:16:53 +0800
Message-ID: <20221021091653.18297-1-zhichao.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "zhichao.liu" <zhichao.liu@mediatek.com>

Commit 7e963fb2a33ce ("spi: mediatek: add ipm design support
for MT7986") makes a mistake on package dividing operation
(one change is missing), need to fix it.

Background:
Ipm design is expanding the HW capability of dma (adjust package
length from 1KB to 64KB), and using "dev_comp->ipm_support" flag
to indicate it.

Issue description:
Ipm support patch (said above) is missing to handle remainder at
package dividing operation.
One case, a transmission length is 65KB, is will divide to 1K
(package length) * 65(package loop) in non-ipm desgin case, and
will divide to 64K(package length) * 1(package loop) + 1K(remainder)
in ipm design case. And the 1K remainder will be lost with the
current SW flow, and the transmission will be failure.
So, it should be fixed.

Solution:
Add "ipm_design" flag in function "mtk_spi_get_mult_delta()" to
indicate HW capability, and modify the parameters corespondingly.

fixes: 7e963fb2a33ce ("spi: mediatek: add ipm design support for MT7986")
Signed-off-by: zhichao.liu <zhichao.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 11aeae7fe7fc..a33c9a3de395 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -551,14 +551,17 @@ static void mtk_spi_enable_transfer(struct spi_master *master)
 	writel(cmd, mdata->base + SPI_CMD_REG);
 }
 
-static int mtk_spi_get_mult_delta(u32 xfer_len)
+static int mtk_spi_get_mult_delta(struct mtk_spi *mdata, u32 xfer_len)
 {
-	u32 mult_delta;
+	u32 mult_delta = 0;
 
-	if (xfer_len > MTK_SPI_PACKET_SIZE)
-		mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
-	else
-		mult_delta = 0;
+	if (mdata->dev_comp->ipm_design) {
+		if (xfer_len > MTK_SPI_IPM_PACKET_SIZE)
+			mult_delta = xfer_len % MTK_SPI_IPM_PACKET_SIZE;
+	} else {
+		if (xfer_len > MTK_SPI_PACKET_SIZE)
+			mult_delta = xfer_len % MTK_SPI_PACKET_SIZE;
+	}
 
 	return mult_delta;
 }
@@ -570,22 +573,22 @@ static void mtk_spi_update_mdata_len(struct spi_master *master)
 
 	if (mdata->tx_sgl_len && mdata->rx_sgl_len) {
 		if (mdata->tx_sgl_len > mdata->rx_sgl_len) {
-			mult_delta = mtk_spi_get_mult_delta(mdata->rx_sgl_len);
+			mult_delta = mtk_spi_get_mult_delta(mdata, mdata->rx_sgl_len);
 			mdata->xfer_len = mdata->rx_sgl_len - mult_delta;
 			mdata->rx_sgl_len = mult_delta;
 			mdata->tx_sgl_len -= mdata->xfer_len;
 		} else {
-			mult_delta = mtk_spi_get_mult_delta(mdata->tx_sgl_len);
+			mult_delta = mtk_spi_get_mult_delta(mdata, mdata->tx_sgl_len);
 			mdata->xfer_len = mdata->tx_sgl_len - mult_delta;
 			mdata->tx_sgl_len = mult_delta;
 			mdata->rx_sgl_len -= mdata->xfer_len;
 		}
 	} else if (mdata->tx_sgl_len) {
-		mult_delta = mtk_spi_get_mult_delta(mdata->tx_sgl_len);
+		mult_delta = mtk_spi_get_mult_delta(mdata, mdata->tx_sgl_len);
 		mdata->xfer_len = mdata->tx_sgl_len - mult_delta;
 		mdata->tx_sgl_len = mult_delta;
 	} else if (mdata->rx_sgl_len) {
-		mult_delta = mtk_spi_get_mult_delta(mdata->rx_sgl_len);
+		mult_delta = mtk_spi_get_mult_delta(mdata, mdata->rx_sgl_len);
 		mdata->xfer_len = mdata->rx_sgl_len - mult_delta;
 		mdata->rx_sgl_len = mult_delta;
 	}
-- 
2.18.0

