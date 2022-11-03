Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAA617624
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKCF3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKCF31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:29:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2145FAA;
        Wed,  2 Nov 2022 22:29:21 -0700 (PDT)
X-UUID: e50e325deb9249638069d2e84d51f692-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=AWuhXliJf4LNGvUCz31n1TTeINGwZ1aIEvAL7BSapmI=;
        b=NjF0mb3a6LWmCRZmAQfsFlHSezhnmi4EJ40c6rjHBW3+yrDFg2u7A+sCia/qclvpyNBlllXlnOo067wdJFi+tVdoeEm/6z2kUnTnm52qGh86OWnxl7/l0wlwmNCbteTfY3u1q0ClQPw5h3/iRZTxpu5HOXDgL5nMsibSTenSZlg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:61d56722-8b60-46cf-bd20-1738581aee07,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:62cd327,CLOUDID:ea904aeb-84ac-4628-a416-bc50d5503da6,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e50e325deb9249638069d2e84d51f692-20221103
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1318099482; Thu, 03 Nov 2022 13:29:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 3 Nov 2022 13:29:13 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 3 Nov 2022 13:29:12 +0800
From:   Bayi Cheng <bayi.cheng@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        bayi cheng <bayi.cheng@mediatek.com>
Subject: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Date:   Thu, 3 Nov 2022 13:28:43 +0800
Message-ID: <20221103052843.2025-2-bayi.cheng@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103052843.2025-1-bayi.cheng@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
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

The timeout value of the current dma read is unreasonable. For example,
If the spi flash clock is 26Mhz, It will takes about 1.3ms to read a
4KB data in spi mode. But the actual measurement exceeds 50s when a
dma read timeout is encountered.

In order to be more accurately, It is necessary to use msecs_to_jiffies,
After modification, the measured timeout value is about 130ms.

Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>
---
 drivers/spi/spi-mtk-nor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index d167699a1a96..3d989db80ee9 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -354,7 +354,7 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
 			    dma_addr_t dma_addr)
 {
 	int ret = 0;
-	ulong delay;
+	ulong delay, timeout;
 	u32 reg;
 
 	writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
@@ -376,15 +376,16 @@ static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
 	mtk_nor_rmw(sp, MTK_NOR_REG_DMA_CTL, MTK_NOR_DMA_START, 0);
 
 	delay = CLK_TO_US(sp, (length + 5) * BITS_PER_BYTE);
+	timeout = (delay + 1) * 100;
 
 	if (sp->has_irq) {
 		if (!wait_for_completion_timeout(&sp->op_done,
-						 (delay + 1) * 100))
+		    msecs_to_jiffies(max_t(size_t, timeout / 1000, 10))))
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

