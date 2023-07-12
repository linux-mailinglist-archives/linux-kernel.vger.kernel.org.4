Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE683750BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjGLPIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjGLPIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BAE74
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D433A61852
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19723C433CB;
        Wed, 12 Jul 2023 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174483;
        bh=GAjpRvAIlM6CKm/Pe/JoMXcbUjsEHttM8EMsZkCnfVc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R74Y+0qvg5O9WE1C4wD1tQkMEZUiTm0sGGgQYdRbYvA7fGhhW3kG9fvAo1sU9nt6L
         2KkrrBCeeTLjDRyKpbO5Itc1MvBGkb5jZrM1a6CzfQEWXw+X8hn0S+GwQuls8FcUL7
         sXDoVN5vUQDIs5nsw+nQarQcfTYOUoUCSrxzYdhfIuwoG/c/FahpZaVW/k7ScLPIfA
         i9BXvblXzhYQDqTx0nxrEfcyf3+bC+h9r9y9kz/G4A5qIIvfkSISPpv9OVR3za2hjw
         aj6O2mBOZzzjtOwc56XfXut1TU8aShiLxFi2nrBs5x6ikqmp35lCKeH51ScARoNkUi
         eiIc3qyBWp2cg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:09 +0200
Subject: [PATCH net-next v3 09/11] net: phy: introduce phy_promote_to_c45()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-9-9eb37edf7be0@kernel.org>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If not explitly asked to be probed as a C45 PHY, on a bus which is
capable of doing both C22 and C45 transfers, C45 PHYs are first tried to
be probed as C22 PHYs. To be able to promote the PHY to be a C45 one,
the driver can call phy_promote_to_c45() in its probe function.

This was already done in the mxl-gpy driver by the following snippet:

   if (!phy_is_c45(phydev)) {
           ret = phy_get_c45_ids(phydev);
           if (ret < 0)
                   return ret;
   }

Move that code into the core as it could be used by other drivers, too.
If a PHY is promoted C45-over-C22 access is automatically used as a
fallback if the bus doesn't support C45 transactions.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/phy/mxl-gpy.c    |  9 ++++-----
 drivers/net/phy/phy_device.c | 36 ++++++++++++++++++++++++++++++------
 include/linux/phy.h          |  7 ++++++-
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index b4ddb9a003d9..b7fca1aae1c3 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -281,11 +281,10 @@ static int gpy_probe(struct phy_device *phydev)
 	int fw_version;
 	int ret;
 
-	if (!phy_has_c45_registers(phydev)) {
-		ret = phy_get_c45_ids(phydev);
-		if (ret < 0)
-			return ret;
-	}
+	/* This might have been probed as a C22 PHY, but this is a C45 PHY */
+	ret = phy_promote_to_c45(phydev);
+	if (ret)
+		return ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 01c41ecb63a7..97fb3cb8b54c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1057,18 +1057,42 @@ void phy_device_remove(struct phy_device *phydev)
 EXPORT_SYMBOL(phy_device_remove);
 
 /**
- * phy_get_c45_ids - Read 802.3-c45 IDs for phy device.
- * @phydev: phy_device structure to read 802.3-c45 IDs
+ * phy_promote_to_c45 - Promote to a C45 PHY
+ * @phydev: phy_device structure
+ *
+ * If a PHY supports both C22 and C45 register access and it isn't specifically
+ * asked to probe as a C45 PHY it might be probed as a C22 PHY. The driver can
+ * call this function to promote the PHY from C22 to C45.
+ *
+ * Can also be called if a PHY is already a C45 one. In that case it does
+ * nothing.
+ *
+ * If the bus isn't capable of doing C45 transfers, C45-over-C22 access will be
+ * used as a fallback.
  *
  * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
  * the "devices in package" is invalid.
  */
-int phy_get_c45_ids(struct phy_device *phydev)
+int phy_promote_to_c45(struct phy_device *phydev)
 {
-	return get_phy_c45_ids(phydev->mdio.bus, phydev->mdio.addr,
-			       PHY_ACCESS_C45, &phydev->c45_ids);
+	struct mii_bus *bus = phydev->mdio.bus;
+
+	if (phydev->access_mode != PHY_ACCESS_C22)
+		return 0;
+
+	if (dev_of_node(&phydev->mdio.dev))
+		phydev_info(phydev,
+			    "Promoting PHY to a C45 one. Please consider using compatible=\"ethernet-phy-ieee802.3-c45\".");
+
+	if (mdiobus_supports_c45(bus))
+		phydev->access_mode = PHY_ACCESS_C45;
+	else
+		phydev->access_mode = PHY_ACCESS_C45_OVER_C22;
+
+	return get_phy_c45_ids(bus, phydev->mdio.addr, phydev->access_mode,
+			       &phydev->c45_ids);
 }
-EXPORT_SYMBOL(phy_get_c45_ids);
+EXPORT_SYMBOL(phy_promote_to_c45);
 
 /**
  * phy_find_first - finds the first PHY device on the bus
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e4014972b799..180fa5ac0b29 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -467,6 +467,11 @@ struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr);
 
 void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus);
 
+static inline bool mdiobus_supports_c45(struct mii_bus *bus)
+{
+	return bus->read_c45 && !bus->prevent_c45_access;
+}
+
 #define PHY_INTERRUPT_DISABLED	false
 #define PHY_INTERRUPT_ENABLED	true
 
@@ -1701,7 +1706,7 @@ static inline int phy_device_register(struct phy_device *phy)
 static inline void phy_device_free(struct phy_device *phydev) { }
 #endif /* CONFIG_PHYLIB */
 void phy_device_remove(struct phy_device *phydev);
-int phy_get_c45_ids(struct phy_device *phydev);
+int phy_promote_to_c45(struct phy_device *phydev);
 int phy_init_hw(struct phy_device *phydev);
 int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);

-- 
2.39.2

