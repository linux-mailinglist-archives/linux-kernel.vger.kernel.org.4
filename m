Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40A7122FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbjEZJFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbjEZJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:05:10 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417912F;
        Fri, 26 May 2023 02:05:07 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 50A667FEF;
        Fri, 26 May 2023 17:05:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 26 May
 2023 17:05:06 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 26 May 2023 17:05:05 +0800
From:   Samin Guo <samin.guo@starfivetech.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Samin Guo" <samin.guo@starfivetech.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v3 2/2] net: phy: motorcomm: Add pad drive strength cfg support
Date:   Fri, 26 May 2023 17:05:02 +0800
Message-ID: <20230526090502.29835-3-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526090502.29835-1-samin.guo@starfivetech.com>
References: <20230526090502.29835-1-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The motorcomm phy (YT8531) supports the ability to adjust the drive
strength of the rx_clk/rx_data, and the default strength may not be
suitable for all boards. So add configurable options to better match
the boards.(e.g. StarFive VisionFive 2)

Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 2fa5a90e073b..e5d6b491046e 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -236,6 +236,15 @@
  */
 #define YTPHY_WCR_TYPE_PULSE			BIT(0)
 
+#define YTPHY_PAD_DRIVE_STRENGTH_REG		0xA010
+#define YT8531_RGMII_RXC_DS_DEFAULT		0x3
+#define YT8531_RGMII_RXC_DS_MAX			0x7
+#define YT8531_RGMII_RXC_DS			GENMASK(15, 13)
+#define YT8531_RGMII_RXD_DS_DEFAULT		0x3
+#define YT8531_RGMII_RXD_DS_MAX			0x7
+#define YT8531_RGMII_RXD_DS_LOW			GENMASK(5, 4) /* Bit 1/0 of rxd_ds */
+#define YT8531_RGMII_RXD_DS_HI			BIT(12) /* Bit 2 of rxd_ds */
+
 #define YTPHY_SYNCE_CFG_REG			0xA012
 #define YT8521_SCR_SYNCE_ENABLE			BIT(5)
 /* 1b0 output 25m clock
@@ -1494,6 +1503,7 @@ static int yt8521_config_init(struct phy_device *phydev)
 static int yt8531_config_init(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
+	u32 ds, val;
 	int ret;
 
 	ret = ytphy_rgmii_clk_delay_config_with_lock(phydev);
@@ -1518,6 +1528,42 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	ds = YT8531_RGMII_RXC_DS_DEFAULT;
+	if (!of_property_read_u32(node, "motorcomm,rx-clk-driver-strength", &val)) {
+		if (val > YT8531_RGMII_RXC_DS_MAX)
+			return -EINVAL;
+
+		ds = val;
+	}
+
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YTPHY_PAD_DRIVE_STRENGTH_REG,
+					 YT8531_RGMII_RXC_DS,
+					 FIELD_PREP(YT8531_RGMII_RXC_DS, ds));
+	if (ret < 0)
+		return ret;
+
+	ds = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW, YT8531_RGMII_RXD_DS_DEFAULT);
+	if (!of_property_read_u32(node, "motorcomm,rx-data-driver-strength", &val)) {
+		if (val > YT8531_RGMII_RXD_DS_MAX)
+			return -EINVAL;
+
+		if (val > FIELD_MAX(YT8531_RGMII_RXD_DS_LOW)) {
+			ds = val & FIELD_MAX(YT8531_RGMII_RXD_DS_LOW);
+			ds = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW, ds);
+			ds |= YT8531_RGMII_RXD_DS_HI;
+		} else {
+			ds = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW, val);
+		}
+	}
+
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YTPHY_PAD_DRIVE_STRENGTH_REG,
+					 YT8531_RGMII_RXD_DS_LOW | YT8531_RGMII_RXD_DS_HI,
+					 ds);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.17.1

