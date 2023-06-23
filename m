Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699A73B54D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjFWKa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjFWKaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FFC2703
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBC161A11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9985C433C0;
        Fri, 23 Jun 2023 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687516186;
        bh=nhfXPWVT6hYc2KxtGUneaAM4Ns1ERr4nJhfqHxksMjA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CjeB60KXr6Ja0lTREdGBW7QOmoKBYVj5y8NJlY+i10h+8lEVZmKfAqCfrG9TsJYgY
         6v+jiiIiCKqnK9X0UmwhNzewutJpXk44NdP5B373WchEzsq6nBtzsS53EUhFIR7+y9
         O7m/wKHJsPTBhsH64k23kayeOXa8w+esriNF0ENpz9zv8Tz32RUWxNzA2twICKCCBc
         t3hm6U7IUCxVkWSsuWeKqqLxCXsqHqcjmWpGrwARrz1Y1zHPu5QeFZS1F+No9L9VSz
         bDCPb37qG8nzUy0bhvJJd1dVXTmsWg0h4ulYNUcBcVjPpLNg6pFk6wRDaKygS3OufZ
         IYcKb54WH3rrQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 23 Jun 2023 12:29:16 +0200
Subject: [PATCH net-next v2 07/10] net: phy: add support for C45-over-C22
 transfers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-7-def0ab9ccee2@kernel.org>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
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

If an MDIO bus is only capable of doing C22 transfers we can use
indirect accesses to C45 registers over C22 registers. This was already
the intention of the GPY215 driver. The author described their use case
as follows:

  Our product supports both C22 and C45.

  In the real system, we found C22 was used by customers (with indirect
  access to C45 registers when necessary).

In its probe function phy_get_c45_ids() is called but this will always
do C45 accesses and thus will fail on a C22-only bus.

Add a new transfer mode C45-over-C22. Care has to be taken for
get_phy_device() which is called by either the bus scanning code or the
network device drivers. In the former case, we must not do any
C45-over-C22 accesses because it invokes register writes and we cannot
be sure if the accessed device is a PHY. C45-over-C22 is just defined
for network PHYs, not generic MDIO devices. Therefore, the it is the
callers responsibility to choose the access mode for get_phy_device().

Due to the reasons above, the current scanning code the PHY core cannot
make use of the new transfer mode because we cannot be sure what device
is a PHY. The code will be used for the device tree scanning where we
know which device is a PHY and therefore, C45-over-C22 is safe to use.

A word on the error checking in the MMD access methods: due to legacy
reasons, we cannot check for errors if we do "normal" MMD access to a
C22 PHY without introducing possible regressions. Although, C45-over-C22
is doing essentially the same access, we can do better now and check for
any errors while doing the indirect access.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/phy/phy-core.c   | 67 +++++++++++++++++++++++++++-----------------
 drivers/net/phy/phy_device.c | 66 +++++++++++++++++++++++++++++++++----------
 include/linux/phy.h          |  3 ++
 3 files changed, 95 insertions(+), 41 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 5f73d27fe330..57062574ca04 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -575,26 +575,34 @@ EXPORT_SYMBOL(__phy_mmd_indirect);
  */
 int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 {
-	int val;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int phy_addr = phydev->mdio.addr;
+	bool check_rc = true;
+	int ret;
 
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->read_mmd) {
-		val = phydev->drv->read_mmd(phydev, devad, regnum);
-	} else if (phy_is_c45(phydev)) {
-		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
-					 devad, regnum);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
-
-		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+	if (phydev->drv && phydev->drv->read_mmd)
+		return phydev->drv->read_mmd(phydev, devad, regnum);
+
+	switch (phydev->access_mode) {
+	case PHY_ACCESS_C45:
+		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
+	case PHY_ACCESS_C22:
+		/* ignore return value for legacy reasons */
+		check_rc = false;
+		fallthrough;
+	case PHY_ACCESS_C45_OVER_C22:
+		ret = mmd_phy_indirect(bus, phy_addr, devad, regnum, check_rc);
+		if (check_rc && ret)
+			return ret;
 
 		/* Read the content of the MMD's selected register */
-		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+		return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
 	}
-	return val;
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(__phy_read_mmd);
 
@@ -631,28 +639,35 @@ EXPORT_SYMBOL(phy_read_mmd);
  */
 int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 {
+	struct mii_bus *bus = phydev->mdio.bus;
+	int phy_addr = phydev->mdio.addr;
+	bool check_rc = true;
 	int ret;
 
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->write_mmd) {
-		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
-	} else if (phy_is_c45(phydev)) {
-		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
-					  devad, regnum, val);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
-
-		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+	if (phydev->drv && phydev->drv->write_mmd)
+		return phydev->drv->write_mmd(phydev, devad, regnum, val);
+
+	switch (phydev->access_mode) {
+	case PHY_ACCESS_C45:
+		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
+	case PHY_ACCESS_C22:
+		check_rc = false;
+		fallthrough;
+	case PHY_ACCESS_C45_OVER_C22:
+		ret = mmd_phy_indirect(bus, phy_addr, devad, regnum, check_rc);
+		if (check_rc && ret)
+			return ret;
 
 		/* Write the data into MMD's selected register */
-		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+		ret = __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
 
-		ret = 0;
+		return check_rc ? ret : 0;
 	}
-	return ret;
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(__phy_write_mmd);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 4fd095282ef7..13d5ec7a7c21 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -715,6 +715,28 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 }
 EXPORT_SYMBOL(phy_device_create);
 
+static int phy_probe_mmd_read(struct mii_bus *bus, int prtad, int devad,
+			      u16 regnum, bool c45_over_c22)
+{
+	int ret;
+
+	if (!c45_over_c22)
+		return mdiobus_c45_read(bus, prtad, devad, regnum);
+
+	mutex_lock(&bus->mdio_lock);
+
+	ret = __phy_mmd_indirect(bus, prtad, devad, regnum);
+	if (ret)
+		goto out;
+
+	ret = __mdiobus_read(bus, prtad, MII_MMD_DATA);
+
+out:
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret;
+}
+
 /* phy_c45_probe_present - checks to see if a MMD is present in the package
  * @bus: the target MII bus
  * @prtad: PHY package address on the MII bus
@@ -726,11 +748,13 @@ EXPORT_SYMBOL(phy_device_create);
  * Returns: negative error number on bus access error, zero if no device
  * is responding, or positive if a device is present.
  */
-static int phy_c45_probe_present(struct mii_bus *bus, int prtad, int devad)
+static int phy_c45_probe_present(struct mii_bus *bus, int prtad, int devad,
+				 bool c45_over_c22)
 {
 	int stat2;
 
-	stat2 = mdiobus_c45_read(bus, prtad, devad, MDIO_STAT2);
+	stat2 = phy_probe_mmd_read(bus, prtad, devad, MDIO_STAT2,
+				   c45_over_c22);
 	if (stat2 < 0)
 		return stat2;
 
@@ -749,16 +773,18 @@ static int phy_c45_probe_present(struct mii_bus *bus, int prtad, int devad)
  * Returns: 0 on success, -EIO on failure.
  */
 static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
-				   u32 *devices_in_package)
+				   u32 *devices_in_package, bool c45_over_c22)
 {
 	int phy_reg;
 
-	phy_reg = mdiobus_c45_read(bus, addr, dev_addr, MDIO_DEVS2);
+	phy_reg = phy_probe_mmd_read(bus, addr, dev_addr, MDIO_DEVS2,
+				     c45_over_c22);
 	if (phy_reg < 0)
 		return -EIO;
 	*devices_in_package = phy_reg << 16;
 
-	phy_reg = mdiobus_c45_read(bus, addr, dev_addr, MDIO_DEVS1);
+	phy_reg = phy_probe_mmd_read(bus, addr, dev_addr, MDIO_DEVS1,
+				     c45_over_c22);
 	if (phy_reg < 0)
 		return -EIO;
 	*devices_in_package |= phy_reg;
@@ -780,7 +806,8 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
  * the "devices in package" is invalid.
  */
 static int get_phy_c45_ids(struct mii_bus *bus, int addr,
-			   struct phy_c45_device_ids *c45_ids)
+			   struct phy_c45_device_ids *c45_ids,
+			   bool c45_over_c22)
 {
 	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
 	u32 devs_in_pkg = 0;
@@ -798,14 +825,16 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 			 * Some PHYs (88x3310) vendor space is not IEEE802.3
 			 * compliant.
 			 */
-			ret = phy_c45_probe_present(bus, addr, i);
+			ret = phy_c45_probe_present(bus, addr, i,
+						    c45_over_c22);
 			if (ret < 0)
 				return -EIO;
 
 			if (!ret)
 				continue;
 		}
-		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, i, &devs_in_pkg);
+		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, i, &devs_in_pkg,
+						  c45_over_c22);
 		if (phy_reg < 0)
 			return -EIO;
 	}
@@ -815,7 +844,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 		 * MMD 0, as some 10G PHYs have zero Devices In package,
 		 * e.g. Cortina CS4315/CS4340 PHY.
 		 */
-		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, &devs_in_pkg);
+		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, &devs_in_pkg,
+						  c45_over_c22);
 		if (phy_reg < 0)
 			return -EIO;
 
@@ -834,7 +864,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 			 * to ignore these if they do not contain IEEE 802.3
 			 * registers.
 			 */
-			ret = phy_c45_probe_present(bus, addr, i);
+			ret = phy_c45_probe_present(bus, addr, i,
+						    c45_over_c22);
 			if (ret < 0)
 				return ret;
 
@@ -842,12 +873,14 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 				continue;
 		}
 
-		phy_reg = mdiobus_c45_read(bus, addr, i, MII_PHYSID1);
+		phy_reg = phy_probe_mmd_read(bus, addr, i, MII_PHYSID1,
+					     c45_over_c22);
 		if (phy_reg < 0)
 			return -EIO;
 		c45_ids->device_ids[i] = phy_reg << 16;
 
-		phy_reg = mdiobus_c45_read(bus, addr, i, MII_PHYSID2);
+		phy_reg = phy_probe_mmd_read(bus, addr, i, MII_PHYSID2,
+					     c45_over_c22);
 		if (phy_reg < 0)
 			return -EIO;
 		c45_ids->device_ids[i] |= phy_reg;
@@ -961,7 +994,10 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
 		r = get_phy_c22_id(bus, addr, &phy_id);
 		break;
 	case PHY_ACCESS_C45:
-		r = get_phy_c45_ids(bus, addr, &c45_ids);
+		r = get_phy_c45_ids(bus, addr, &c45_ids, false);
+		break;
+	case PHY_ACCESS_C45_OVER_C22:
+		r = get_phy_c45_ids(bus, addr, &c45_ids, true);
 		break;
 	default:
 		return ERR_PTR(-EIO);
@@ -976,7 +1012,7 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
 	 * space, if successful, create the C45 PHY device.
 	 */
 	if (mode == PHY_ACCESS_C22 && phy_id == 0 && bus->read_c45) {
-		r = get_phy_c45_ids(bus, addr, &c45_ids);
+		r = get_phy_c45_ids(bus, addr, &c45_ids, false);
 		if (!r)
 			return phy_device_create(bus, addr, phy_id,
 						 PHY_ACCESS_C45, &c45_ids);
@@ -1058,7 +1094,7 @@ EXPORT_SYMBOL(phy_device_remove);
 int phy_get_c45_ids(struct phy_device *phydev)
 {
 	return get_phy_c45_ids(phydev->mdio.bus, phydev->mdio.addr,
-			       &phydev->c45_ids);
+			       &phydev->c45_ids, false);
 }
 EXPORT_SYMBOL(phy_get_c45_ids);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a7aff91f4eb0..4852651f6326 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -541,10 +541,13 @@ struct macsec_ops;
  *
  * @PHY_ACCESS_C22: use 802.3 c22 MDIO transactions
  * @PHY_ACCESS_C45: use 802.3 c45 MDIO transactions
+ * @PHY_ACCESS_C45_OVER_C22: indirectly access C45 registers by using by 802.3
+ *			     c22 MDIO transactions and registers 13 and 14.
  */
 enum phy_access_mode {
 	PHY_ACCESS_C22,
 	PHY_ACCESS_C45,
+	PHY_ACCESS_C45_OVER_C22,
 };
 
 /**

-- 
2.39.2

