Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82936318BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiKUC43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKUC41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:56:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6412F393
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:56:18 -0800 (PST)
X-UUID: 585cc66bde9647dfa2ab50e4e3336118-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VDymyQAetc3WEtO27z94FAZO4pTlwjOlBCBrAhSOXn4=;
        b=M/P5kBGzr4bhgHeJZwiQQ+DgsKAtZie1OlNDY9eDagvbrPCet5xeS7mxAGUB0gyIj9UQ7gcszi9SvHa2FXw4jfN8EXObbqdyTApnMkK5kfSK9FIvTefO3BN3Uqm9RCZXMYGvU3tPUqCzQF0ddQkgWTeK3dFl8jOeacJW863UOHw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:886e6531-8a5e-4fec-a503-7fc0fd2060f5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:95
X-CID-INFO: VERSION:1.1.13,REQID:886e6531-8a5e-4fec-a503-7fc0fd2060f5,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:95
X-CID-META: VersionHash:d12e911,CLOUDID:bd9a512f-2938-482e-aafd-98d66723b8a9,B
        ulkID:221121105616SQ0WFPLA,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 585cc66bde9647dfa2ab50e4e3336118-20221121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <sujuan.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 67850096; Mon, 21 Nov 2022 10:56:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 21 Nov 2022 10:56:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 10:56:11 +0800
From:   Sujuan Chen <sujuan.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [PATCH] net: ethernet: mtk_wed: add wcid overwritten support for wed v1
Date:   Mon, 21 Nov 2022 10:54:27 +0800
Message-ID: <217932f091aa9d9cb5e876a2e958ca25f80f80b2.1668997816.git.sujuan.chen@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All wed versions should enable wcid overwritten feature,
since the wcid size is controlled by the wlan driver.

Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c      | 9 ++++++---
 drivers/net/ethernet/mediatek/mtk_wed_regs.h | 2 ++
 include/linux/soc/mediatek/mtk_wed.h         | 3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 7d8842378c2b..a20093803e04 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -526,9 +526,9 @@ mtk_wed_dma_disable(struct mtk_wed_device *dev)
 			MTK_WED_WPDMA_RX_D_RX_DRV_EN);
 		wed_clr(dev, MTK_WED_WDMA_GLO_CFG,
 			MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
-
-		mtk_wed_set_512_support(dev, false);
 	}
+
+	mtk_wed_set_512_support(dev, false);
 }
 
 static void
@@ -1290,9 +1290,10 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 		if (mtk_wed_rro_cfg(dev))
 			return;
 
-		mtk_wed_set_512_support(dev, dev->wlan.wcid_512);
 	}
 
+	mtk_wed_set_512_support(dev, dev->wlan.wcid_512);
+
 	mtk_wed_dma_enable(dev);
 	dev->running = true;
 }
@@ -1338,6 +1339,8 @@ mtk_wed_attach(struct mtk_wed_device *dev)
 	dev->irq = hw->irq;
 	dev->wdma_idx = hw->index;
 	dev->version = hw->version;
+	if (hw->version != 1)
+		dev->rev_id = wed_r32(dev, MTK_WED_REV_ID);
 
 	if (hw->eth->dma_dev == hw->eth->dev &&
 	    of_dma_is_coherent(hw->eth->dev->of_node))
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index 9e39dace95eb..873d50b9a6e6 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -20,6 +20,8 @@ struct mtk_wdma_desc {
 	__le32 info;
 } __packed __aligned(4);
 
+#define MTK_WED_REV_ID					0x004
+
 #define MTK_WED_RESET					0x008
 #define MTK_WED_RESET_TX_BM				BIT(0)
 #define MTK_WED_RESET_TX_FREE_AGENT			BIT(4)
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index 8294978f4bca..1b1ef57609f7 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -85,6 +85,9 @@ struct mtk_wed_device {
 	int irq;
 	u8 version;
 
+	/* used by wlan driver */
+	u32 rev_id;
+
 	struct mtk_wed_ring tx_ring[MTK_WED_TX_QUEUES];
 	struct mtk_wed_ring rx_ring[MTK_WED_RX_QUEUES];
 	struct mtk_wed_ring txfree_ring;
-- 
2.18.0

