Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE95BE15B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiITJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiITJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:04:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE586CF4A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:02:35 -0700 (PDT)
X-UUID: 739241b92700425fb050b6d8116f4a3d-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=n7wZIkuPTiLOQCOIwIcXYf+aRsn+eYjwunznMxBD8LE=;
        b=bg80GbEXsNm2zgebjg5+y33/TWxfzQoALDN5bQeYuFQ6ePOTHSeETBGb9FC6SO58Y8pxZoNFBv2B/KlIBRkqJI8kyXWzRBrOUxnhmzSyZmnYkJK/m4CC98dUf//JLWKVdCrGKRZ4I5BRmXHdja+9DVUPLBDlPUxP3JSM7tbmWFg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:5d6c19f4-325a-4b39-9f0f-3faff0cfa651,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:5d6c19f4-325a-4b39-9f0f-3faff0cfa651,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:67fc03f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220920170227EQ818G7Z,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,
        COL:0
X-UUID: 739241b92700425fb050b6d8116f4a3d-20220920
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1168922529; Tue, 20 Sep 2022 17:02:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 17:00:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 17:00:42 +0800
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
Subject: [PATCH 04/18] phy: mediatek: ufs: use common register access helpers
Date:   Tue, 20 Sep 2022 17:00:24 +0800
Message-ID: <20220920090038.15133-5-chunfeng.yun@mediatek.com>
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

No need define private register access helpers, use common ones defined
in phy-mtk-io.h

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-ufs.c | 78 +++++++++++-------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-ufs.c b/drivers/phy/mediatek/phy-mtk-ufs.c
index a6af06941203..fc19e0fa8ed5 100644
--- a/drivers/phy/mediatek/phy-mtk-ufs.c
+++ b/drivers/phy/mediatek/phy-mtk-ufs.c
@@ -11,6 +11,8 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
+#include "phy-mtk-io.h"
+
 /* mphy register and offsets */
 #define MP_GLB_DIG_8C               0x008C
 #define FRC_PLL_ISO_EN              BIT(8)
@@ -39,34 +41,6 @@ struct ufs_mtk_phy {
 	struct clk_bulk_data clks[UFSPHY_CLKS_CNT];
 };
 
-static inline u32 mphy_readl(struct ufs_mtk_phy *phy, u32 reg)
-{
-	return readl(phy->mmio + reg);
-}
-
-static inline void mphy_writel(struct ufs_mtk_phy *phy, u32 val, u32 reg)
-{
-	writel(val, phy->mmio + reg);
-}
-
-static void mphy_set_bit(struct ufs_mtk_phy *phy, u32 reg, u32 bit)
-{
-	u32 val;
-
-	val = mphy_readl(phy, reg);
-	val |= bit;
-	mphy_writel(phy, val, reg);
-}
-
-static void mphy_clr_bit(struct ufs_mtk_phy *phy, u32 reg, u32 bit)
-{
-	u32 val;
-
-	val = mphy_readl(phy, reg);
-	val &= ~bit;
-	mphy_writel(phy, val, reg);
-}
-
 static struct ufs_mtk_phy *get_ufs_mtk_phy(struct phy *generic_phy)
 {
 	return (struct ufs_mtk_phy *)phy_get_drvdata(generic_phy);
@@ -84,57 +58,61 @@ static int ufs_mtk_phy_clk_init(struct ufs_mtk_phy *phy)
 
 static void ufs_mtk_phy_set_active(struct ufs_mtk_phy *phy)
 {
+	void __iomem *mmio = phy->mmio;
+
 	/* release DA_MP_PLL_PWR_ON */
-	mphy_set_bit(phy, MP_GLB_DIG_8C, PLL_PWR_ON);
-	mphy_clr_bit(phy, MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
+	mtk_phy_set_bits(mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
+	mtk_phy_clear_bits(mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
 
 	/* release DA_MP_PLL_ISO_EN */
-	mphy_clr_bit(phy, MP_GLB_DIG_8C, PLL_ISO_EN);
-	mphy_clr_bit(phy, MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
+	mtk_phy_clear_bits(mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
+	mtk_phy_clear_bits(mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
 
 	/* release DA_MP_CDR_PWR_ON */
-	mphy_set_bit(phy, MP_LN_RX_44, CDR_PWR_ON);
-	mphy_clr_bit(phy, MP_LN_RX_44, FRC_CDR_PWR_ON);
+	mtk_phy_set_bits(mmio + MP_LN_RX_44, CDR_PWR_ON);
+	mtk_phy_clear_bits(mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
 
 	/* release DA_MP_CDR_ISO_EN */
-	mphy_clr_bit(phy, MP_LN_RX_44, CDR_ISO_EN);
-	mphy_clr_bit(phy, MP_LN_RX_44, FRC_CDR_ISO_EN);
+	mtk_phy_clear_bits(mmio + MP_LN_RX_44, CDR_ISO_EN);
+	mtk_phy_clear_bits(mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
 
 	/* release DA_MP_RX0_SQ_EN */
-	mphy_set_bit(phy, MP_LN_DIG_RX_AC, RX_SQ_EN);
-	mphy_clr_bit(phy, MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
+	mtk_phy_set_bits(mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
+	mtk_phy_clear_bits(mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
 
 	/* delay 1us to wait DIFZ stable */
 	udelay(1);
 
 	/* release DIFZ */
-	mphy_clr_bit(phy, MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
+	mtk_phy_clear_bits(mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
 }
 
 static void ufs_mtk_phy_set_deep_hibern(struct ufs_mtk_phy *phy)
 {
+	void __iomem *mmio = phy->mmio;
+
 	/* force DIFZ */
-	mphy_set_bit(phy, MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
+	mtk_phy_set_bits(mmio + MP_LN_DIG_RX_9C, FSM_DIFZ_FRC);
 
 	/* force DA_MP_RX0_SQ_EN */
-	mphy_set_bit(phy, MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
-	mphy_clr_bit(phy, MP_LN_DIG_RX_AC, RX_SQ_EN);
+	mtk_phy_set_bits(mmio + MP_LN_DIG_RX_AC, FRC_RX_SQ_EN);
+	mtk_phy_clear_bits(mmio + MP_LN_DIG_RX_AC, RX_SQ_EN);
 
 	/* force DA_MP_CDR_ISO_EN */
-	mphy_set_bit(phy, MP_LN_RX_44, FRC_CDR_ISO_EN);
-	mphy_set_bit(phy, MP_LN_RX_44, CDR_ISO_EN);
+	mtk_phy_set_bits(mmio + MP_LN_RX_44, FRC_CDR_ISO_EN);
+	mtk_phy_set_bits(mmio + MP_LN_RX_44, CDR_ISO_EN);
 
 	/* force DA_MP_CDR_PWR_ON */
-	mphy_set_bit(phy, MP_LN_RX_44, FRC_CDR_PWR_ON);
-	mphy_clr_bit(phy, MP_LN_RX_44, CDR_PWR_ON);
+	mtk_phy_set_bits(mmio + MP_LN_RX_44, FRC_CDR_PWR_ON);
+	mtk_phy_clear_bits(mmio + MP_LN_RX_44, CDR_PWR_ON);
 
 	/* force DA_MP_PLL_ISO_EN */
-	mphy_set_bit(phy, MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
-	mphy_set_bit(phy, MP_GLB_DIG_8C, PLL_ISO_EN);
+	mtk_phy_set_bits(mmio + MP_GLB_DIG_8C, FRC_PLL_ISO_EN);
+	mtk_phy_set_bits(mmio + MP_GLB_DIG_8C, PLL_ISO_EN);
 
 	/* force DA_MP_PLL_PWR_ON */
-	mphy_set_bit(phy, MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
-	mphy_clr_bit(phy, MP_GLB_DIG_8C, PLL_PWR_ON);
+	mtk_phy_set_bits(mmio + MP_GLB_DIG_8C, FRC_FRC_PWR_ON);
+	mtk_phy_clear_bits(mmio + MP_GLB_DIG_8C, PLL_PWR_ON);
 }
 
 static int ufs_mtk_phy_power_on(struct phy *generic_phy)
-- 
2.18.0

