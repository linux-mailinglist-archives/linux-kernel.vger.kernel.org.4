Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89D6654A83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 02:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLWBuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 20:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWBuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 20:50:51 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0297641;
        Thu, 22 Dec 2022 17:50:49 -0800 (PST)
X-UUID: 74ef8e6c96e74ba4a45c909e59f4e748-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BseEKJDeDeZ7+Gz+rMrpO4HRXtkR+aAiH33ITZwHI4k=;
        b=dY5fXjC/KHfMz9V+Z2TNxVKKDOWtSaLbz07FHlHKeQ53qEyow+7HR8Ee2Yj3En7NtVzx1tohuF5LDD6cYtYVdyHh1Qcl7gZqVoiajn7/sORJGX6qeOn2Y96SZLOFopXe2PzeO10PnozdEk7/iiFbO7LBSZbi/K2UxJYCVxBaa2s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:fc10bad3-513d-452c-9b12-aaf4e5dbb6f7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:fc10bad3-513d-452c-9b12-aaf4e5dbb6f7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:abadb7f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:2212230950447S00KLOZ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 74ef8e6c96e74ba4a45c909e59f4e748-20221223
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1595800957; Fri, 23 Dec 2022 09:50:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 23 Dec 2022 09:50:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 23 Dec 2022 09:50:40 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Biao Huang" <biao.huang@mediatek.com>, <macpaul.lin@mediatek.com>
Subject: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for special cases
Date:   Fri, 23 Dec 2022 09:50:28 +0800
Message-ID: <20221223015029.24978-2-biao.huang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223015029.24978-1-biao.huang@mediatek.com>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current driver, MAC will always enable 2ns delay in RGMII mode,
but that will lead to transmission failures for "rgmii-id"/"rgmii-txid"
cases.

Modify the implementation of fix_mac_speed() to ensure the 2ns delay
will only take effect for "rgmii-rxid"/"rgmii" cases, then user can
choose phy-mode freely.

Fixes: f2d356a6ab71 ("stmmac: dwmac-mediatek: add support for mt8195")
Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index d42e1afb6521..cde4fb81d596 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -447,7 +447,9 @@ static void mt8195_fix_mac_speed(void *priv, unsigned int speed)
 {
 	struct mediatek_dwmac_plat_data *priv_plat = priv;
 
-	if ((phy_interface_mode_is_rgmii(priv_plat->phy_mode))) {
+	switch (priv_plat->phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
 		/* prefer 2ns fixed delay which is controlled by TXC_PHASE_CTRL,
 		 * when link speed is 1Gbps with RGMII interface,
 		 * Fall back to delay macro circuit for 10/100Mbps link speed.
@@ -462,6 +464,9 @@ static void mt8195_fix_mac_speed(void *priv, unsigned int speed)
 					   MT8195_RGMII_TXC_PHASE_CTRL);
 		else
 			mt8195_set_delay(priv_plat);
+		break;
+	default:
+		break;
 	}
 }
 
-- 
2.25.1

