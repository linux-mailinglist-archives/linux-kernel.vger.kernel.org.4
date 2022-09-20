Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6E5BE152
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiITJCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiITJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:02:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221106AA15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:01:49 -0700 (PDT)
X-UUID: 9ed9018cd4044710b4f80401ddf17ae9-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8G3jH0xJv+bba///GqBioghpU0jYsvRS/nXFP8cix+Q=;
        b=Kq4Yij1mzyKii/xf9z5hnaK/iGlCoyuIWvBbWYGoP0JancSO/YixpBODR1mUPX6apRYQWub97iaTtWPz5EyAf4apebl3ImuSwrNxCXgEJK44iBoiFVDzPPzWDNNPRyiR/P6GbhzeGomNIMsaxWLLlaCAGt9IFIhEIvKinwGymAA=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.11,REQID:f5d6aae9-21f0-4384-9e4a-3044e66538c5,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,ACT
        ION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.11,REQID:f5d6aae9-21f0-4384-9e4a-3044e66538c5,IP:0,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:120
X-CID-META: VersionHash:39a5ff1,CLOUDID:cfee435e-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:2209201701368IZIREMP,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:5,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0
X-UUID: 9ed9018cd4044710b4f80401ddf17ae9-20220920
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1441861293; Tue, 20 Sep 2022 17:01:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 17:00:54 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 17:00:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 17/18] phy: mediatek: mipi: mt8183: use common helper to access registers
Date:   Tue, 20 Sep 2022 17:00:37 +0800
Message-ID: <20220920090038.15133-18-chunfeng.yun@mediatek.com>
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

Use MediaTek phy's common helper to access registers, then we can remove
mipi-dsi's I/O helpers.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 .../phy/mediatek/phy-mtk-mipi-dsi-mt8183.c    | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 1ec71ba2407e..f021ec5a70e5 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -4,6 +4,7 @@
  * Author: jitao.shi <jitao.shi@mediatek.com>
  */
 
+#include "phy-mtk-io.h"
 #include "phy-mtk-mipi-dsi.h"
 
 #define MIPITX_LANE_CON		0x000c
@@ -46,6 +47,7 @@
 static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
 {
 	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	void __iomem *base = mipi_tx->regs;
 	unsigned int txdiv, txdiv0;
 	u64 pcw;
 
@@ -70,17 +72,16 @@ static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
 		return -EINVAL;
 	}
 
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON4, RG_DSI_PLL_IBIAS);
 
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
 	udelay(1);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
 	pcw = div_u64(((u64)mipi_tx->data_rate * txdiv) << 24, 26000000);
-	writel(pcw, mipi_tx->regs + MIPITX_PLL_CON0);
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV,
-				txdiv0 << 8);
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	writel(pcw, base + MIPITX_PLL_CON0);
+	mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, txdiv0);
+	mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
 
 	return 0;
 }
@@ -88,11 +89,12 @@ static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
 static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
 {
 	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	void __iomem *base = mipi_tx->regs;
 
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
 
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
 }
 
 static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -121,7 +123,7 @@ static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *mipi_tx)
 			mipi_tx->rt_code[i] |= 0x10 << 5;
 
 		for (j = 0; j < 10; j++)
-			mtk_mipi_tx_update_bits(mipi_tx,
+			mtk_phy_update_bits(mipi_tx->regs +
 				MIPITX_D2P_RTCODE * (i + 1) + j * 4,
 				1, mipi_tx->rt_code[i] >> j & 1);
 	}
@@ -130,44 +132,42 @@ static void mtk_mipi_tx_config_calibration_data(struct mtk_mipi_tx *mipi_tx)
 static void mtk_mipi_tx_power_on_signal(struct phy *phy)
 {
 	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+	void __iomem *base = mipi_tx->regs;
 
 	/* BG_LPF_EN / BG_CORE_EN */
-	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
-	       mipi_tx->regs + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
 	usleep_range(30, 100);
-	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN,
-	       mipi_tx->regs + MIPITX_LANE_CON);
+	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN, base + MIPITX_LANE_CON);
 
 	/* Switch OFF each Lane */
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_clear_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
 
-	mtk_mipi_tx_update_bits(mipi_tx, MIPITX_VOLTAGE_SEL,
-				RG_DSI_HSTX_LDO_REF_SEL,
-				(mipi_tx->mipitx_drive - 3000) / 200 << 6);
+	mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_HSTX_LDO_REF_SEL,
+			     (mipi_tx->mipitx_drive - 3000) / 200);
 
 	mtk_mipi_tx_config_calibration_data(mipi_tx);
 
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
+	mtk_phy_set_bits(base + MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
 }
 
 static void mtk_mipi_tx_power_off_signal(struct phy *phy)
 {
 	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+	void __iomem *base = mipi_tx->regs;
 
 	/* Switch ON each Lane */
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
-	mtk_mipi_tx_set_bits(mipi_tx, MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
-
-	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN,
-	       mipi_tx->regs + MIPITX_LANE_CON);
-	writel(RG_DSI_PAD_TIEL_SEL, mipi_tx->regs + MIPITX_LANE_CON);
+	mtk_phy_set_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL, base + MIPITX_LANE_CON);
 }
 
 const struct mtk_mipitx_data mt8183_mipitx_data = {
-- 
2.18.0

