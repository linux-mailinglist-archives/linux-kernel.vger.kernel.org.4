Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67672AFD9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 02:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjFKAmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 20:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFKAmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 20:42:15 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAB30F6;
        Sat, 10 Jun 2023 17:42:14 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1q899o-0005G6-0D;
        Sun, 11 Jun 2023 00:42:12 +0000
Date:   Sun, 11 Jun 2023 01:41:28 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH net-next 7/8] net: ethernet: mtk_eth_soc: convert clock
 bitmap to u64
Message-ID: <ZIUYOBCMEmiEbxMs@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The to-be-added MT7988 SoC adds many new clocks which need to be
controlled by the Ethernet driver, which will result in their total
number exceeding 32.
Prepare by converting clock bitmaps into 64-bit types.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 96 +++++++++++----------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9bd7261449d13..b941a136eb7e0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -673,54 +673,56 @@ enum mtk_clks_map {
 	MTK_CLK_MAX
 };
 
-#define MT7623_CLKS_BITMAP	(BIT(MTK_CLK_ETHIF) | BIT(MTK_CLK_ESW) |  \
-				 BIT(MTK_CLK_GP1) | BIT(MTK_CLK_GP2) | \
-				 BIT(MTK_CLK_TRGPLL))
-#define MT7622_CLKS_BITMAP	(BIT(MTK_CLK_ETHIF) | BIT(MTK_CLK_ESW) |  \
-				 BIT(MTK_CLK_GP0) | BIT(MTK_CLK_GP1) | \
-				 BIT(MTK_CLK_GP2) | \
-				 BIT(MTK_CLK_SGMII_TX_250M) | \
-				 BIT(MTK_CLK_SGMII_RX_250M) | \
-				 BIT(MTK_CLK_SGMII_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII_CDR_FB) | \
-				 BIT(MTK_CLK_SGMII_CK) | \
-				 BIT(MTK_CLK_ETH2PLL))
+#define MT7623_CLKS_BITMAP	(BIT_ULL(MTK_CLK_ETHIF) | BIT_ULL(MTK_CLK_ESW) |  \
+				 BIT_ULL(MTK_CLK_GP1) | BIT_ULL(MTK_CLK_GP2) | \
+				 BIT_ULL(MTK_CLK_TRGPLL))
+#define MT7622_CLKS_BITMAP	(BIT_ULL(MTK_CLK_ETHIF) | BIT_ULL(MTK_CLK_ESW) |  \
+				 BIT_ULL(MTK_CLK_GP0) | BIT_ULL(MTK_CLK_GP1) | \
+				 BIT_ULL(MTK_CLK_GP2) | \
+				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_FB) | \
+				 BIT_ULL(MTK_CLK_SGMII_CK) | \
+				 BIT_ULL(MTK_CLK_ETH2PLL))
 #define MT7621_CLKS_BITMAP	(0)
 #define MT7628_CLKS_BITMAP	(0)
-#define MT7629_CLKS_BITMAP	(BIT(MTK_CLK_ETHIF) | BIT(MTK_CLK_ESW) |  \
-				 BIT(MTK_CLK_GP0) | BIT(MTK_CLK_GP1) | \
-				 BIT(MTK_CLK_GP2) | BIT(MTK_CLK_FE) | \
-				 BIT(MTK_CLK_SGMII_TX_250M) | \
-				 BIT(MTK_CLK_SGMII_RX_250M) | \
-				 BIT(MTK_CLK_SGMII_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII_CDR_FB) | \
-				 BIT(MTK_CLK_SGMII2_TX_250M) | \
-				 BIT(MTK_CLK_SGMII2_RX_250M) | \
-				 BIT(MTK_CLK_SGMII2_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII2_CDR_FB) | \
-				 BIT(MTK_CLK_SGMII_CK) | \
-				 BIT(MTK_CLK_ETH2PLL) | BIT(MTK_CLK_SGMIITOP))
-#define MT7981_CLKS_BITMAP	(BIT(MTK_CLK_FE) | BIT(MTK_CLK_GP2) | BIT(MTK_CLK_GP1) | \
-				 BIT(MTK_CLK_WOCPU0) | \
-				 BIT(MTK_CLK_SGMII_TX_250M) | \
-				 BIT(MTK_CLK_SGMII_RX_250M) | \
-				 BIT(MTK_CLK_SGMII_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII_CDR_FB) | \
-				 BIT(MTK_CLK_SGMII2_TX_250M) | \
-				 BIT(MTK_CLK_SGMII2_RX_250M) | \
-				 BIT(MTK_CLK_SGMII2_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII2_CDR_FB) | \
-				 BIT(MTK_CLK_SGMII_CK))
-#define MT7986_CLKS_BITMAP	(BIT(MTK_CLK_FE) | BIT(MTK_CLK_GP2) | BIT(MTK_CLK_GP1) | \
-				 BIT(MTK_CLK_WOCPU1) | BIT(MTK_CLK_WOCPU0) | \
-				 BIT(MTK_CLK_SGMII_TX_250M) | \
-				 BIT(MTK_CLK_SGMII_RX_250M) | \
-				 BIT(MTK_CLK_SGMII_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII_CDR_FB) | \
-				 BIT(MTK_CLK_SGMII2_TX_250M) | \
-				 BIT(MTK_CLK_SGMII2_RX_250M) | \
-				 BIT(MTK_CLK_SGMII2_CDR_REF) | \
-				 BIT(MTK_CLK_SGMII2_CDR_FB))
+#define MT7629_CLKS_BITMAP	(BIT_ULL(MTK_CLK_ETHIF) | BIT_ULL(MTK_CLK_ESW) |  \
+				 BIT_ULL(MTK_CLK_GP0) | BIT_ULL(MTK_CLK_GP1) | \
+				 BIT_ULL(MTK_CLK_GP2) | BIT_ULL(MTK_CLK_FE) | \
+				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_FB) | \
+				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII2_CDR_FB) | \
+				 BIT_ULL(MTK_CLK_SGMII_CK) | \
+				 BIT_ULL(MTK_CLK_ETH2PLL) | BIT_ULL(MTK_CLK_SGMIITOP))
+#define MT7981_CLKS_BITMAP	(BIT_ULL(MTK_CLK_FE) | BIT_ULL(MTK_CLK_GP2) | \
+				 BIT_ULL(MTK_CLK_GP1) | \
+				 BIT_ULL(MTK_CLK_WOCPU0) | \
+				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_FB) | \
+				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII2_CDR_FB) | \
+				 BIT_ULL(MTK_CLK_SGMII_CK))
+#define MT7986_CLKS_BITMAP	(BIT_ULL(MTK_CLK_FE) | BIT_ULL(MTK_CLK_GP2) | \
+				 BIT_ULL(MTK_CLK_GP1) | \
+				 BIT_ULL(MTK_CLK_WOCPU1) | BIT_ULL(MTK_CLK_WOCPU0) | \
+				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII_CDR_FB) | \
+				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_CDR_REF) | \
+				 BIT_ULL(MTK_CLK_SGMII2_CDR_FB))
 
 enum mtk_dev_state {
 	MTK_HW_INIT,
@@ -1063,7 +1065,7 @@ struct mtk_soc_data {
 	const struct mtk_reg_map *reg_map;
 	u32             ana_rgc3;
 	u64		caps;
-	u32		required_clks;
+	u64		required_clks;
 	bool		required_pctl;
 	u8		offload_version;
 	u8		hash_offset;
-- 
2.41.0

