Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD065BE12A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiITJBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiITJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:01:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560011146
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:01:02 -0700 (PDT)
X-UUID: 796c8b9aaf1846299a3d8a0bc60e4257-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VNtpF+pXlyEDUuZOw+4+I8vvd6HvIy7daYhRNlFOdz4=;
        b=LMdEYKmS5sJdhigbz3/Sbd02kMQMbNs9f0Y6bqmwIWoTJHXFbi51vw0sQVNnmZW+9bKSb22Cff29hTS5XoM5ck8qdfVFO4TF0pFzlnP+jssJyezryy8Jd2j/qkiXw5jNQtSawT1KNOhFLyq1454c42sLTiyBwEu5e3x51/SyrFw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:bb16d4a4-42ee-4073-805e-e8b300e3a1f7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:bb16d4a4-42ee-4073-805e-e8b300e3a1f7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:4be4435e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:22092017005849FLDOC3,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 796c8b9aaf1846299a3d8a0bc60e4257-20220920
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1632017481; Tue, 20 Sep 2022 17:00:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 17:00:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 17:00:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 05/18] phy: mediatek: pcie: use new helper to update register bits
Date:   Tue, 20 Sep 2022 17:00:25 +0800
Message-ID: <20220920090038.15133-6-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
References: <20220920090038.15133-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper will use FIELD_PREP() macro to prepare bits value
according to mask, then we no need do it anymore.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-pcie.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-pcie.c b/drivers/phy/mediatek/phy-mtk-pcie.c
index 7f29d43442bf..25dbd6e35722 100644
--- a/drivers/phy/mediatek/phy-mtk-pcie.c
+++ b/drivers/phy/mediatek/phy-mtk-pcie.c
@@ -89,14 +89,14 @@ static void mtk_pcie_efuse_set_lane(struct mtk_pcie_phy *pcie_phy,
 	addr = pcie_phy->sif_base + PEXTP_ANA_LN0_TRX_REG +
 	       lane * PEXTP_ANA_LANE_OFFSET;
 
-	mtk_phy_update_bits(addr + PEXTP_ANA_TX_REG, EFUSE_LN_TX_PMOS_SEL,
-			    FIELD_PREP(EFUSE_LN_TX_PMOS_SEL, data->tx_pmos));
+	mtk_phy_update_field(addr + PEXTP_ANA_TX_REG, EFUSE_LN_TX_PMOS_SEL,
+			     data->tx_pmos);
 
-	mtk_phy_update_bits(addr + PEXTP_ANA_TX_REG, EFUSE_LN_TX_NMOS_SEL,
-			    FIELD_PREP(EFUSE_LN_TX_NMOS_SEL, data->tx_nmos));
+	mtk_phy_update_field(addr + PEXTP_ANA_TX_REG, EFUSE_LN_TX_NMOS_SEL,
+			     data->tx_nmos);
 
-	mtk_phy_update_bits(addr + PEXTP_ANA_RX_REG, EFUSE_LN_RX_SEL,
-			    FIELD_PREP(EFUSE_LN_RX_SEL, data->rx_data));
+	mtk_phy_update_field(addr + PEXTP_ANA_RX_REG, EFUSE_LN_RX_SEL,
+			     data->rx_data);
 }
 
 /**
@@ -116,9 +116,8 @@ static int mtk_pcie_phy_init(struct phy *phy)
 		return 0;
 
 	/* Set global data */
-	mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_GLB_00_REG,
-			    EFUSE_GLB_INTR_SEL,
-			    FIELD_PREP(EFUSE_GLB_INTR_SEL, pcie_phy->efuse_glb_intr));
+	mtk_phy_update_field(pcie_phy->sif_base + PEXTP_ANA_GLB_00_REG,
+			     EFUSE_GLB_INTR_SEL, pcie_phy->efuse_glb_intr);
 
 	for (i = 0; i < pcie_phy->data->num_lanes; i++)
 		mtk_pcie_efuse_set_lane(pcie_phy, i);
-- 
2.18.0

