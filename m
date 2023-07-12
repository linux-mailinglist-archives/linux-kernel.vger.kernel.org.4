Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF3750BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjGLPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjGLPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E191BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:08:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A0561834
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD2AC43397;
        Wed, 12 Jul 2023 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174479;
        bh=Tmc5/2UDtcEs1h9nUuWx0TMjoX+wVWZ/iIzgviv/ihY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bWQkTKEu/azFAhv0ExF44BMt0pVAE/GaEaSoH2V4gxkqVsIxasS+Hows5vkonQ6IC
         Kk6JF6t4u6SnodPOthl/EndkbqYhBdL8Rd+hnEVTgrlU3hLMwBD8br3LUIKZBylbtB
         5WzikoSmK8EIOYuMijSHeCu7FeaofYQrteuxGvLFdU2toTVFtoUgRSXYPCbbUQUcZC
         hZ5lw32aCy+e8ihJZDTKbujRPKgGx5a+0Ai1WGS9C0mStZ0eCoPjfWlj+ARz2m3EUe
         lI06dIE5aeGNrfeMFJYqL/hviER9dDinMsetW99PN9GgTWTR77pTQHiKc1hB1tS1im
         YsAOsEPt7O53w==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:08 +0200
Subject: [PATCH net-next v3 08/11] net: phy: add support for C45-over-C22
 transfers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-8-9eb37edf7be0@kernel.org>
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
v3:
 - instead of the boolean c45_over_c22 flag pass an enum access_mode
 - use new low-level helper phy_mdiobus_read_mmd()
---
 drivers/net/phy/phy-core.c   | 25 ++++++++++++++++++++-----
 drivers/net/phy/phy_device.c | 41 +++++++++++++++++++++++++++--------------
 include/linux/phy.h          |  3 +++
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 4863a85f8385..17ad118edbf1 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -550,12 +550,20 @@ static int __phy_mdiobus_read_mmd(struct mii_bus *bus, int phy_addr,
 				  enum phy_access_mode access_mode,
 				  int devad, u32 regnum)
 {
+	bool check_rc = true;
+	int ret;
+
 	switch (access_mode) {
 	case PHY_ACCESS_C45:
 		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
 	case PHY_ACCESS_C22:
 		/* ignore return value for legacy reasons */
-		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+		check_rc = false;
+		fallthrough;
+	case PHY_ACCESS_C45_OVER_C22:
+		ret = mmd_phy_indirect(bus, phy_addr, devad, regnum, check_rc);
+		if (check_rc && ret)
+			return ret;
 
 		/* Read the content of the MMD's selected register */
 		return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
@@ -597,17 +605,24 @@ static int __phy_mdiobus_write_mmd(struct mii_bus *bus, int phy_addr,
 				   enum phy_access_mode mode,
 				   int devad, u32 regnum, u16 val)
 {
+	bool check_rc = true;
+	int ret;
+
 	switch (mode) {
 	case PHY_ACCESS_C45:
 		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
 	case PHY_ACCESS_C22:
-		/* ignore return value for legacy reasons */
-		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+		check_rc = false;
+		fallthrough;
+	case PHY_ACCESS_C45_OVER_C22:
+		ret = mmd_phy_indirect(bus, phy_addr, devad, regnum, check_rc);
+		if (check_rc && ret)
+			return ret;
 
 		/* Write the data into MMD's selected register */
-		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+		ret = __mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
 
-		return 0;
+		return check_rc ? ret : 0;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6254212d65a5..01c41ecb63a7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -726,11 +726,12 @@ EXPORT_SYMBOL(phy_device_create);
  * Returns: negative error number on bus access error, zero if no device
  * is responding, or positive if a device is present.
  */
-static int phy_c45_probe_present(struct mii_bus *bus, int prtad, int devad)
+static int phy_c45_probe_present(struct mii_bus *bus, int prtad,
+				 enum phy_access_mode mode, int devad)
 {
 	int stat2;
 
-	stat2 = mdiobus_c45_read(bus, prtad, devad, MDIO_STAT2);
+	stat2 = phy_mdiobus_read_mmd(bus, prtad, mode, devad, MDIO_STAT2);
 	if (stat2 < 0)
 		return stat2;
 
@@ -748,17 +749,18 @@ static int phy_c45_probe_present(struct mii_bus *bus, int prtad, int devad)
  *
  * Returns: 0 on success, -EIO on failure.
  */
-static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
+static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr,
+				   enum phy_access_mode mode, int dev_addr,
 				   u32 *devices_in_package)
 {
 	int phy_reg;
 
-	phy_reg = mdiobus_c45_read(bus, addr, dev_addr, MDIO_DEVS2);
+	phy_reg = phy_mdiobus_read_mmd(bus, addr, mode, dev_addr, MDIO_DEVS2);
 	if (phy_reg < 0)
 		return -EIO;
 	*devices_in_package = phy_reg << 16;
 
-	phy_reg = mdiobus_c45_read(bus, addr, dev_addr, MDIO_DEVS1);
+	phy_reg = phy_mdiobus_read_mmd(bus, addr, mode, dev_addr, MDIO_DEVS1);
 	if (phy_reg < 0)
 		return -EIO;
 	*devices_in_package |= phy_reg;
@@ -780,6 +782,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
  * the "devices in package" is invalid.
  */
 static int get_phy_c45_ids(struct mii_bus *bus, int addr,
+			   enum phy_access_mode mode,
 			   struct phy_c45_device_ids *c45_ids)
 {
 	const int num_ids = ARRAY_SIZE(c45_ids->device_ids);
@@ -798,14 +801,15 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 			 * Some PHYs (88x3310) vendor space is not IEEE802.3
 			 * compliant.
 			 */
-			ret = phy_c45_probe_present(bus, addr, i);
+			ret = phy_c45_probe_present(bus, addr, mode, i);
 			if (ret < 0)
 				return -EIO;
 
 			if (!ret)
 				continue;
 		}
-		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, i, &devs_in_pkg);
+		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, mode, i,
+						  &devs_in_pkg);
 		if (phy_reg < 0)
 			return -EIO;
 	}
@@ -815,7 +819,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 		 * MMD 0, as some 10G PHYs have zero Devices In package,
 		 * e.g. Cortina CS4315/CS4340 PHY.
 		 */
-		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, 0, &devs_in_pkg);
+		phy_reg = get_phy_c45_devs_in_pkg(bus, addr, mode, 0,
+						  &devs_in_pkg);
 		if (phy_reg < 0)
 			return -EIO;
 
@@ -834,7 +839,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 			 * to ignore these if they do not contain IEEE 802.3
 			 * registers.
 			 */
-			ret = phy_c45_probe_present(bus, addr, i);
+			ret = phy_c45_probe_present(bus, addr, mode, i);
 			if (ret < 0)
 				return ret;
 
@@ -842,12 +847,14 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 				continue;
 		}
 
-		phy_reg = mdiobus_c45_read(bus, addr, i, MII_PHYSID1);
+		phy_reg = phy_mdiobus_read_mmd(bus, addr, mode, i,
+					       MII_PHYSID1);
 		if (phy_reg < 0)
 			return -EIO;
 		c45_ids->device_ids[i] = phy_reg << 16;
 
-		phy_reg = mdiobus_c45_read(bus, addr, i, MII_PHYSID2);
+		phy_reg = phy_mdiobus_read_mmd(bus, addr, mode, i,
+					       MII_PHYSID2);
 		if (phy_reg < 0)
 			return -EIO;
 		c45_ids->device_ids[i] |= phy_reg;
@@ -937,6 +944,11 @@ EXPORT_SYMBOL(fwnode_get_phy_id);
  * If the "devices in package" appears valid, read the ID registers for each
  * MMD, allocate and return a &struct phy_device.
  *
+ * When using %PHY_ACCESS_C45_OVER_C22 as @mode care have to be taken to not
+ * access a non-PHY device as C45-over-C22 is a property of a PHY and not a
+ * generic MDIO device. As the access involves register writes, it may be
+ * destructive on non-PHY devices. IOW, it cannot be used for bus scanning.
+ *
  * Returns an allocated &struct phy_device on success, %-ENODEV if there is
  * no PHY present, or %-EIO on bus access error.
  */
@@ -956,7 +968,8 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
 		r = get_phy_c22_id(bus, addr, &phy_id);
 		break;
 	case PHY_ACCESS_C45:
-		r = get_phy_c45_ids(bus, addr, &c45_ids);
+	case PHY_ACCESS_C45_OVER_C22:
+		r = get_phy_c45_ids(bus, addr, mode, &c45_ids);
 		break;
 	default:
 		return ERR_PTR(-EIO);
@@ -971,7 +984,7 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
 	 * space, if successful, create the C45 PHY device.
 	 */
 	if (mode == PHY_ACCESS_C22 && phy_id == 0 && bus->read_c45) {
-		r = get_phy_c45_ids(bus, addr, &c45_ids);
+		r = get_phy_c45_ids(bus, addr, PHY_ACCESS_C45, &c45_ids);
 		if (!r)
 			return phy_device_create(bus, addr, phy_id,
 						 PHY_ACCESS_C45, &c45_ids);
@@ -1053,7 +1066,7 @@ EXPORT_SYMBOL(phy_device_remove);
 int phy_get_c45_ids(struct phy_device *phydev)
 {
 	return get_phy_c45_ids(phydev->mdio.bus, phydev->mdio.addr,
-			       &phydev->c45_ids);
+			       PHY_ACCESS_C45, &phydev->c45_ids);
 }
 EXPORT_SYMBOL(phy_get_c45_ids);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a482696a17a6..e4014972b799 100644
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
 	PHY_ACCESS_C22 = 22,
 	PHY_ACCESS_C45 = 45,
+	PHY_ACCESS_C45_OVER_C22 = 4522,
 };
 
 /**

-- 
2.39.2

