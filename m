Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D88262772E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiKNIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiKNIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:14:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1131A210;
        Mon, 14 Nov 2022 00:14:02 -0800 (PST)
X-UUID: 06a3de3d523242739635f57692033022-20221114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=16ql8s7UXjz7QayRZm19LzIg6ERRvCYLZDA5lHE/kUI=;
        b=ttFZPNcKo29ZvIlbZeKZbUTxeLqC1lGuSef9jhMhrtqKci8yvLH9AmeG0C/PDbLO1gdII++uOiwrGDiLudRfrcAFh2KDqYpDh61FioWL6CMcL/KjNcGekQRVRBBFNiSbapWwancHy0lhFejaW1YuSYd0cU1ftHTUdFx6c6+tTgc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:765fbccd-046a-427d-9090-c6728bf52381,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:2010df29-8055-4e28-ab7d-2959ba08645e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 06a3de3d523242739635f57692033022-20221114
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2735173; Mon, 14 Nov 2022 16:13:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 14 Nov 2022 16:13:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 14 Nov 2022 16:13:46 +0800
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
Subject: [PATCH v2] spi: spi-mtk-nor: Optimize timeout for dma read
Date:   Mon, 14 Nov 2022 16:13:27 +0800
Message-ID: <20221114081327.25750-1-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: bayi cheng <bayi.cheng@mediatek.com>

The timeout value of the current dma read is unreasonable. For example,
If the spi flash clock is 26Mhz, It will takes about 1.3ms to read a
4KB data in spi mode. But the actual measurement exceeds 50s when a
dma read timeout is encountered.

In order to be more accurately, It is necessary to use usecs_to_jiffies,
After modification, the measured timeout value is about 130ms.

Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
---
Change in v2:
  -Change the type of "timeout" from ulong to u32.
  -Replace max_t with max.
  -Replace msecs_to_jiffies with usecs_to_jiffies.
---
---
 drivers/spi/spi-mtk-nor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index d167699a1a96..58eca18b28b0 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -354,7 +354,7 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
 			    dma_addr_t dma_addr)
 {
 	int ret = 0;
-	ulong delay;
+	u32 delay, timeout;
 	u32 reg;
 
 	writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
@@ -376,15 +376,16 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
 	mtk_nor_rmw(sp, MTK_NOR_REG_DMA_CTL, MTK_NOR_DMA_START, 0);
 
 	delay = CLK_TO_US(sp, (length + 5) * BITS_PER_BYTE);
+	timeout = (delay + 1) * 100;
 
 	if (sp->has_irq) {
 		if (!wait_for_completion_timeout(&sp->op_done,
-						 (delay + 1) * 100))
+		    usecs_to_jiffies(max(timeout, 10000U))))
 			ret = -ETIMEDOUT;
 	} else {
 		ret = readl_poll_timeout(sp->base + MTK_NOR_REG_DMA_CTL, reg,
 					 !(reg & MTK_NOR_DMA_START), delay / 3,
-					 (delay + 1) * 100);
+					 timeout);
 	}
 
 	if (ret < 0)
-- 
2.25.1

