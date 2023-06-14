Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF972091D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjFBS10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbjFBS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:27:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E166F1A1;
        Fri,  2 Jun 2023 11:27:17 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 948CA66066EC;
        Fri,  2 Jun 2023 19:27:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685730436;
        bh=ZLEeIR50lMA4Zexpu6tsdlrk0GQ6B9wGBAwmZZ5+nBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHFb6YigBps31nHN8ucOR8VffHmwPLTr74QCMlVGEABblrqUzMl6VQr6IkbQ/iCWY
         vvAYul+ZgiV4CSD2mu0/meAgNSa0X5rXVxV6VBOyFnLotq7yrlkjuDkRTPE7sEY0JB
         OE27nIMIgEfCgLBthRBfvWegwyaXbQdhRf1xVb1gjlyGM+f7FyW69AN7Nd3XYbjwHo
         AC5i3xOxycajsKV1U9hsFezlU90YJEZ7SK9oq43FO7+SGQvUkyM0e/Bdz4cJSSvyL4
         26eOi14gAx1ZCLotL5ATwT+KJBV57ps7ZJGpnNQE7L3vvRCF/ghsDucj/Yv/Hq2N+q
         6/5UJ0QqaTA7Q==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 3/3] net: phy: realtek: Disable clock on suspend
Date:   Fri,  2 Jun 2023 14:26:59 -0400
Message-Id: <20230602182659.307876-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230602182659.307876-1-detlev.casanova@collabora.com>
References: <20230602182659.307876-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PHYs that call rtl821x_probe() where an external clock can be
configured, make sure that the clock is disabled
when ->suspend() is called and enabled on resume.

The PHY_ALWAYS_CALL_SUSPEND is added to ensure that the suspend function
is actually always called.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/net/phy/realtek.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index b13dd0b3c99e..62eac4835def 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -426,10 +426,28 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	return genphy_soft_reset(phydev);
 }
 
+static int rtl821x_suspend(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	int ret = genphy_suspend(phydev);
+
+	if (ret)
+		return ret;
+
+	if (!phydev->wol_enabled)
+		clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
 static int rtl821x_resume(struct phy_device *phydev)
 {
+	struct rtl821x_priv *priv = phydev->priv;
 	int ret;
 
+	if (!phydev->wol_enabled)
+		clk_prepare_enable(priv->clk);
+
 	ret = genphy_resume(phydev);
 	if (ret < 0)
 		return ret;
@@ -934,10 +952,11 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtlgen_read_status,
 		.config_intr	= &rtl8211f_config_intr,
 		.handle_interrupt = rtl8211f_handle_interrupt,
-		.suspend	= genphy_suspend,
+		.suspend	= rtl821x_suspend,
 		.resume		= rtl821x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8211FVD_PHYID),
 		.name		= "RTL8211F-VD Gigabit Ethernet",
@@ -946,10 +965,11 @@ static struct phy_driver realtek_drvs[] = {
 		.read_status	= rtlgen_read_status,
 		.config_intr	= &rtl8211f_config_intr,
 		.handle_interrupt = rtl8211f_handle_interrupt,
-		.suspend	= genphy_suspend,
+		.suspend	= rtl821x_suspend,
 		.resume		= rtl821x_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.flags		= PHY_ALWAYS_CALL_SUSPEND,
 	}, {
 		.name		= "Generic FE-GE Realtek PHY",
 		.match_phy_device = rtlgen_match_phy_device,
-- 
2.39.3

