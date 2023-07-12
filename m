Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A888750BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjGLPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjGLPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040371FDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:08:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EC361868
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334A8C433CC;
        Wed, 12 Jul 2023 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174490;
        bh=baWU82tteE6wohLuYV2acd4eWNdncxCiiHvc8i4RT7E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=JBXodkwGHRR6MuN1KLNe7Ym/WLACVHm+RSFcodWRO2lUSuTPalJkM50LuUGqRBqGL
         KvIgScZF/T2mFqpZksP0t00odQOXGFHKDOPhsAc6LmKPp4G5H9F9/Va8XGvOKJAZyE
         UwGtP8O0o2I9/03/yaAmnD0mtPlJOYo0flt1rnkXN3HSHgxwbislgXOsdNlf8DNW3F
         GmbfkWGdPFUoTW6xfWVKloLzasgwlVsoyGbTEuVMjObIl63xMAZSGQ6aRCoJ+U86Pt
         r++tMaqxdoasxEKjKWO164MAon7A7D9D2T0J4xeD9roFfdtlaABHDpUbvuwdbO32Ti
         TpSCgnSOvxhdA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:11 +0200
Subject: [PATCH net-next v3 11/11] net: mdio: support C45-over-C22 when
 probed via OF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-11-9eb37edf7be0@kernel.org>
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

Fall back to C45-over-C22 when the MDIO bus isn't capable of doing C45
transfers. This might be the case if there are broken PHYs on the bus or
if the MDIO controller cannot do C45 transactions at all.

For this to work, split the PHY registration into three steps, as done
in the generic PHY probing code:
 (1) add C22 PHYs
 (2) scan for broken C22 PHYs
 (3) add C45 PHYs

If step (2) detects a broken PHY, any PHYs will be added with
C45-over-C22 access in step (3). Step (3) also ensures, that
C45-over-C22 is used if C45 access is not supported at all on the bus.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/mdio/of_mdio.c | 63 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 7eb32ebb846d..e9d3cf6b68ee 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -100,6 +100,11 @@ static const struct of_device_id whitelist_phys[] = {
 	{}
 };
 
+static bool of_mdiobus_child_is_c45_phy(struct device_node *child)
+{
+	return of_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
+}
+
 /*
  * Return true if the child node is for a phy. It must either:
  * o Compatible string of "ethernet-phy-idX.X"
@@ -118,7 +123,7 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 	if (of_get_phy_id(child, &phy_id) != -EINVAL)
 		return true;
 
-	if (of_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
+	if (of_mdiobus_child_is_c45_phy(child))
 		return true;
 
 	if (of_device_is_compatible(child, "ethernet-phy-ieee802.3-c22"))
@@ -138,6 +143,32 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
 }
 EXPORT_SYMBOL(of_mdiobus_child_is_phy);
 
+static int of_mdiobus_register_child(struct mii_bus *mdio,
+				     struct device_node *child, bool *scanphys)
+{
+	int addr, rc;
+
+	addr = of_mdio_parse_addr(&mdio->dev, child);
+	if (addr < 0) {
+		*scanphys = true;
+		return 0;
+	}
+
+	if (mdiobus_is_registered_device(mdio, addr))
+		return 0;
+
+	if (of_mdiobus_child_is_phy(child))
+		rc = of_mdiobus_register_phy(mdio, child, addr);
+	else
+		rc = of_mdiobus_register_device(mdio, child, addr);
+
+	if (rc == -ENODEV)
+		dev_err(&mdio->dev, "MDIO device at address %d is missing.\n",
+			addr);
+
+	return rc;
+}
+
 /**
  * __of_mdiobus_register - Register mii_bus and create PHYs from the device tree
  * @mdio: pointer to mii_bus structure
@@ -178,24 +209,26 @@ int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
 	if (rc)
 		return rc;
 
-	/* Loop over the child nodes and register a phy_device for each phy */
+	/* Loop over the child nodes, skipping C45 PHYs so we can scan for
+	 * broken C22 PHYs. The C45 PHYs will be registered afterwards.
+	 */
 	for_each_available_child_of_node(np, child) {
-		addr = of_mdio_parse_addr(&mdio->dev, child);
-		if (addr < 0) {
-			scanphys = true;
+		if (of_mdiobus_child_is_c45_phy(child))
 			continue;
-		}
+		rc = of_mdiobus_register_child(mdio, child, &scanphys);
+		if (rc)
+			goto unregister;
+	}
 
-		if (of_mdiobus_child_is_phy(child))
-			rc = of_mdiobus_register_phy(mdio, child, addr);
-		else
-			rc = of_mdiobus_register_device(mdio, child, addr);
+	/* Some C22 PHYs are broken with C45 transactions. */
+	mdiobus_scan_for_broken_c45_access(mdio);
 
-		if (rc == -ENODEV)
-			dev_err(&mdio->dev,
-				"MDIO device at address %d is missing.\n",
-				addr);
-		else if (rc)
+	/* Now add any missing C45 PHYs. If C45 access is not allowed, they
+	 * will be registered with C45-over-C22 access.
+	 */
+	for_each_available_child_of_node(np, child) {
+		rc = of_mdiobus_register_child(mdio, child, &scanphys);
+		if (rc)
 			goto unregister;
 	}
 

-- 
2.39.2

