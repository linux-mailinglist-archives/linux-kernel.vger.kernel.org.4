Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93150750BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjGLPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjGLPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EC1FCB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1286361866
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C87C4339A;
        Wed, 12 Jul 2023 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174465;
        bh=9aHlE7am87TlqLD7Xuy3Eq66iXaKh9SMMvVijAYss5s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kn5CtpvCv3Ea+BXNJIwGn6UeL6bfcvX21Vm6sDfAYIm9vD+bin8qSfiK495Q0i8PF
         Nr4cStIqbOGjKcrbEUyiW8qNB8FgXoh8HG0+KePvtOrBDS7K6ej+JXWFFlOkxMdNAK
         PExpypinNJBbD1wG5XfwQIqR3HqwYFIiGjohpnj8QXbiFfCbwez5hnoXfYBHs2IX6o
         n2Bl0dxfpoygrj6YPxpMNUKf/kTzNaFAXSciNaPjhcqDFO/PvKdOHGBChWu3ZqPVWY
         qYY/jnW9s89LmqAFxTtnNYuy/P0c8zmm1+ZqACIUWexZTZPDyNASd4DNdDjJzGh7Q1
         NGopup2O28XuA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:04 +0200
Subject: [PATCH net-next v3 04/11] net: phy: make the "prevent_c45_scan" a
 property of the MII bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-4-9eb37edf7be0@kernel.org>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blacklist will also be used elsewhere in the kernel, e.g. in the
DT scanning code. Make it a property of mii_bus and export the function.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - add missing EXPORT_SYMBOL_GPL() for
   mdiobus_scan_for_broken_c45_access()
---
 drivers/net/phy/mdio_bus.c | 18 +++++++++---------
 include/linux/phy.h        |  5 +++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a31eb1204f63..29ad9302fe11 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -613,9 +613,9 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  * stomping over the true devices reply, to performing a write to
  * themselves which was intended for another device. Now that C22
  * devices have been found, see if any of them are bad for C45, and if we
- * should skip the C45 scan.
+ * should prohibit any C45 transactions.
  */
-static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
+void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
 {
 	int i;
 
@@ -628,11 +628,13 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 			continue;
 		oui = phydev->phy_id >> 10;
 
-		if (oui == MICREL_OUI)
-			return true;
+		if (oui == MICREL_OUI) {
+			bus->prevent_c45_access = true;
+			break;
+		}
 	}
-	return false;
 }
+EXPORT_SYMBOL_GPL(mdiobus_scan_for_broken_c45_access);
 
 /**
  * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
@@ -652,7 +654,6 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 {
 	struct mdio_device *mdiodev;
 	struct gpio_desc *gpiod;
-	bool prevent_c45_scan;
 	int i, err;
 
 	if (!bus || !bus->name)
@@ -724,9 +725,8 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error;
 	}
 
-	prevent_c45_scan = mdiobus_prevent_c45_scan(bus);
-
-	if (!prevent_c45_scan && bus->read_c45) {
+	mdiobus_scan_for_broken_c45_access(bus);
+	if (!bus->prevent_c45_access && bus->read_c45) {
 		err = mdiobus_scan_bus_c45(bus);
 		if (err)
 			goto error;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fb7481715c3b..cd67887a7289 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -410,6 +410,9 @@ struct mii_bus {
 	/** @phy_ignore_ta_mask: PHY addresses to ignore the TA/read failure */
 	u32 phy_ignore_ta_mask;
 
+	/** @prevent_c45_access: Don't do any C45 transactions on the bus */
+	unsigned prevent_c45_access:1;
+
 	/**
 	 * @irq: An array of interrupts, each PHY's interrupt at the index
 	 * matching its address
@@ -462,6 +465,8 @@ static inline struct mii_bus *devm_mdiobus_alloc(struct device *dev)
 struct mii_bus *mdio_find_bus(const char *mdio_name);
 struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr);
 
+void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus);
+
 #define PHY_INTERRUPT_DISABLED	false
 #define PHY_INTERRUPT_ENABLED	true
 

-- 
2.39.2

