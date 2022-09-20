Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904375BE14D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiITJDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiITJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:02:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8CB6C763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:02:01 -0700 (PDT)
X-UUID: 422a5700b4d649e795b1b0b6e54663d4-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oD+Udm6jbro+HWMaZx++gezk561ohL6Fw5km/9fQXk8=;
        b=q/wdKcz8EDeAowLm1YnAYbEbJgZoN81qHihtXvXYEFh2teEvqF6d+ENfgPXp8csLaceTKsYcr8lFZvnzSewuZbiOrr8s5M0l1iScJnHncy8m8TK+tTp16KH1ZfRzeefp3TBthOk2yz8GoAh3BmwYFjrPpMOf6EfgrGuhOk0AYeU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:c66ddc10-8613-47cd-9ea9-40867569bdaf,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:96f403f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 422a5700b4d649e795b1b0b6e54663d4-20220920
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 388253206; Tue, 20 Sep 2022 17:01:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 17:00:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 17:00:52 +0800
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
Subject: [PATCH 16/18] phy: mediatek: mipi: mt8183: use GENMASK to generate bits mask
Date:   Tue, 20 Sep 2022 17:00:36 +0800
Message-ID: <20220920090038.15133-17-chunfeng.yun@mediatek.com>
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

Use GENMASK() macro to generate bits mask

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 99108426d57c..1ec71ba2407e 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -18,7 +18,7 @@
 #define RG_DSI_PAD_TIEL_SEL		BIT(8)
 
 #define MIPITX_VOLTAGE_SEL	0x0010
-#define RG_DSI_HSTX_LDO_REF_SEL		(0xf << 6)
+#define RG_DSI_HSTX_LDO_REF_SEL		GENMASK(9, 6)
 
 #define MIPITX_PLL_PWR		0x0028
 #define MIPITX_PLL_CON0		0x002c
@@ -26,7 +26,7 @@
 #define MIPITX_PLL_CON2		0x0034
 #define MIPITX_PLL_CON3		0x0038
 #define MIPITX_PLL_CON4		0x003c
-#define RG_DSI_PLL_IBIAS		(3 << 10)
+#define RG_DSI_PLL_IBIAS		GENMASK(11, 10)
 
 #define MIPITX_D2P_RTCODE	0x0100
 #define MIPITX_D2_SW_CTL_EN	0x0144
@@ -41,7 +41,7 @@
 #define AD_DSI_PLL_SDM_ISO_EN		BIT(1)
 
 #define RG_DSI_PLL_EN			BIT(4)
-#define RG_DSI_PLL_POSDIV		(0x7 << 8)
+#define RG_DSI_PLL_POSDIV		GENMASK(10, 8)
 
 static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
 {
-- 
2.18.0

