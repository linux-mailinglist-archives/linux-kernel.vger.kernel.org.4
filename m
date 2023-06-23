Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A173B549
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjFWKaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFWK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC07211D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD5A61A17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C08C433C8;
        Fri, 23 Jun 2023 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687516175;
        bh=ehSuoLZghcZW1yKiUB0M1IR3WQ5jy4tA9bTfMTbRBDI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HNfoafwUCHzTITdApnHi/iZO3PsmhY198i7gYphSIX23mdcCtn7+xzYt3DSk2CygX
         Kw2YVlw+CttucssWUlhgSwSyF8kIgDBxkhcJFz/KoaDSZfrnvpT0muhU7iiWhjx2ch
         1Qe81SEGRgXsubV3ohPR7jqc4lde6/pNKroV03WXHWEkeGSm97VeZdYbeqeEimwZzq
         YhlsmHLYvj5yPU6F7Yy8rdvJeEmkCuroGLB8AShYS+1KKp2wkETfkRvqkkh7Y77IU0
         6yfT2YQmk6xGy4N769VrI+3R3I9FwAj+hjp5EPhuRVs0F/WbIRGtXyQBxYAr3zzmrQ
         +VERbxJuRaDSQ==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 23 Jun 2023 12:29:13 +0200
Subject: [PATCH net-next v2 04/10] net: phy: replace is_c45 with
 phy_accces_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-4-def0ab9ccee2@kernel.org>
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

Instead of tracing whether the PHY is a C45 one, use the method how the
PHY is accessed. For now, that is either by C22 or by C45 transactions.
There is no functional change, just a semantical difference.

This is a preparation patch to add a third access method C45-over-C22.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c |  8 +++---
 drivers/net/mdio/fwnode_mdio.c                    |  6 ++--
 drivers/net/phy/mdio_bus.c                        |  9 +++---
 drivers/net/phy/nxp-tja11xx.c                     |  3 +-
 drivers/net/phy/phy_device.c                      | 34 +++++++++++++++--------
 drivers/net/phy/sfp.c                             | 12 ++++----
 include/linux/phy.h                               | 28 ++++++++++++++-----
 7 files changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 928d934cb21a..74cd6197735b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -687,9 +687,9 @@ static int
 hns_mac_register_phydev(struct mii_bus *mdio, struct hns_mac_cb *mac_cb,
 			u32 addr)
 {
+	enum phy_access_mode mode;
 	struct phy_device *phy;
 	const char *phy_type;
-	bool is_c45;
 	int rc;
 
 	rc = fwnode_property_read_string(mac_cb->fw_port,
@@ -698,13 +698,13 @@ hns_mac_register_phydev(struct mii_bus *mdio, struct hns_mac_cb *mac_cb,
 		return rc;
 
 	if (!strcmp(phy_type, phy_modes(PHY_INTERFACE_MODE_XGMII)))
-		is_c45 = true;
+		mode = PHY_ACCESS_C45;
 	else if (!strcmp(phy_type, phy_modes(PHY_INTERFACE_MODE_SGMII)))
-		is_c45 = false;
+		mode = PHY_ACCESS_C22;
 	else
 		return -ENODATA;
 
-	phy = get_phy_device(mdio, addr, is_c45);
+	phy = get_phy_device(mdio, addr, mode);
 	if (!phy || IS_ERR(phy))
 		return -EIO;
 
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1183ef5e203e..972c8932c2fe 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -131,9 +131,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
-		phy = get_phy_device(bus, addr, is_c45);
+		phy = get_phy_device(bus, addr,
+				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
 	else
-		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
+		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
+					NULL);
 	if (IS_ERR(phy)) {
 		rc = PTR_ERR(phy);
 		goto clean_mii_ts;
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 8b3618d3da4a..a31eb1204f63 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -513,12 +513,13 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	return ret;
 }
 
-static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
+static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr,
+				       enum phy_access_mode mode)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
 	int err;
 
-	phydev = get_phy_device(bus, addr, c45);
+	phydev = get_phy_device(bus, addr, mode);
 	if (IS_ERR(phydev))
 		return phydev;
 
@@ -550,7 +551,7 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
  */
 struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, false);
+	return mdiobus_scan(bus, addr, PHY_ACCESS_C22);
 }
 EXPORT_SYMBOL(mdiobus_scan_c22);
 
@@ -568,7 +569,7 @@ EXPORT_SYMBOL(mdiobus_scan_c22);
  */
 static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
 {
-	return mdiobus_scan(bus, addr, true);
+	return mdiobus_scan(bus, addr, PHY_ACCESS_C45);
 }
 
 static int mdiobus_scan_bus_c22(struct mii_bus *bus)
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index b13e15310feb..1c6c1523540e 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -580,7 +580,8 @@ static void tja1102_p1_register(struct work_struct *work)
 		}
 
 		/* Real PHY ID of Port 1 is 0 */
-		phy = phy_device_create(bus, addr, PHY_ID_TJA1102, false, NULL);
+		phy = phy_device_create(bus, addr, PHY_ID_TJA1102,
+					PHY_ACCESS_C22, NULL);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "Can't create PHY device for Port 1: %i\n",
 				addr);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 660dca65f76f..4fd095282ef7 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -630,7 +630,7 @@ static int phy_request_driver_module(struct phy_device *dev, u32 phy_id)
 }
 
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
-				     bool is_c45,
+				     enum phy_access_mode mode,
 				     struct phy_c45_device_ids *c45_ids)
 {
 	struct phy_device *dev;
@@ -664,7 +664,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	dev->autoneg = AUTONEG_ENABLE;
 
 	dev->pma_extable = -ENODATA;
-	dev->is_c45 = is_c45;
+	dev->access_mode = mode;
 	dev->phy_id = phy_id;
 	if (c45_ids)
 		dev->c45_ids = *c45_ids;
@@ -926,7 +926,7 @@ EXPORT_SYMBOL(fwnode_get_phy_id);
  *		    struct
  * @bus: the target MII bus
  * @addr: PHY address on the MII bus
- * @is_c45: If true the PHY uses the 802.3 clause 45 protocol
+ * @mode: Access mode of the PHY
  *
  * Probe for a PHY at @addr on @bus.
  *
@@ -937,10 +937,16 @@ EXPORT_SYMBOL(fwnode_get_phy_id);
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
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
+struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
+				  enum phy_access_mode mode)
 {
 	struct phy_c45_device_ids c45_ids;
 	u32 phy_id = 0;
@@ -950,10 +956,16 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	c45_ids.mmds_present = 0;
 	memset(c45_ids.device_ids, 0xff, sizeof(c45_ids.device_ids));
 
-	if (is_c45)
-		r = get_phy_c45_ids(bus, addr, &c45_ids);
-	else
+	switch (mode) {
+	case PHY_ACCESS_C22:
 		r = get_phy_c22_id(bus, addr, &phy_id);
+		break;
+	case PHY_ACCESS_C45:
+		r = get_phy_c45_ids(bus, addr, &c45_ids);
+		break;
+	default:
+		return ERR_PTR(-EIO);
+	}
 
 	if (r)
 		return ERR_PTR(r);
@@ -963,15 +975,15 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	 * probe with C45 to see if we're able to get a valid PHY ID in the C45
 	 * space, if successful, create the C45 PHY device.
 	 */
-	if (!is_c45 && phy_id == 0 && bus->read_c45) {
+	if (mode == PHY_ACCESS_C22 && phy_id == 0 && bus->read_c45) {
 		r = get_phy_c45_ids(bus, addr, &c45_ids);
 		if (!r)
 			return phy_device_create(bus, addr, phy_id,
-						 true, &c45_ids);
+						 PHY_ACCESS_C45, &c45_ids);
 	}
 
-	return phy_device_create(bus, addr, phy_id, is_c45,
-				 !is_c45 ? NULL : &c45_ids);
+	return phy_device_create(bus, addr, phy_id, mode,
+				 mode == PHY_ACCESS_C22 ? NULL : &c45_ids);
 }
 EXPORT_SYMBOL(get_phy_device);
 
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index d855a18308d7..e7f8decaf3ff 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1750,12 +1750,13 @@ static void sfp_sm_phy_detach(struct sfp *sfp)
 	sfp->mod_phy = NULL;
 }
 
-static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
+static int sfp_sm_probe_phy(struct sfp *sfp, int addr,
+			    enum phy_access_mode mode)
 {
 	struct phy_device *phy;
 	int err;
 
-	phy = get_phy_device(sfp->i2c_mii, addr, is_c45);
+	phy = get_phy_device(sfp->i2c_mii, addr, mode);
 	if (phy == ERR_PTR(-ENODEV))
 		return PTR_ERR(phy);
 	if (IS_ERR(phy)) {
@@ -1879,15 +1880,16 @@ static int sfp_sm_probe_for_phy(struct sfp *sfp)
 		break;
 
 	case MDIO_I2C_MARVELL_C22:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, false);
+		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, PHY_ACCESS_C22);
 		break;
 
 	case MDIO_I2C_C45:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, true);
+		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR, PHY_ACCESS_C45);
 		break;
 
 	case MDIO_I2C_ROLLBALL:
-		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL, true);
+		err = sfp_sm_probe_phy(sfp, SFP_PHY_ADDR_ROLLBALL,
+				       PHY_ACCESS_C45);
 		break;
 	}
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 787bfe8e5c45..12679bbd4b91 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -531,6 +531,17 @@ struct phy_c45_device_ids {
 struct macsec_context;
 struct macsec_ops;
 
+/**
+ * enum phy_access_mode - PHY register access mode definitions
+ *
+ * @PHY_ACCESS_C22: use 802.3 c22 MDIO transactions
+ * @PHY_ACCESS_C45: use 802.3 c45 MDIO transactions
+ */
+enum phy_access_mode {
+	PHY_ACCESS_C22,
+	PHY_ACCESS_C45,
+};
+
 /**
  * struct phy_device - An instance of a PHY
  *
@@ -539,8 +550,8 @@ struct macsec_ops;
  * @devlink: Create a link between phy dev and mac dev, if the external phy
  *           used by current mac interface is managed by another mac interface.
  * @phy_id: UID for this device found during discovery
- * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
- * @is_c45:  Set to true if this PHY uses clause 45 addressing.
+ * @access_mode:  MDIO access mode of the PHY.
+ * @c45_ids: 802.3-c45 Device Identifiers if it's an C45 PHY.
  * @is_internal: Set to true if this PHY is internal to a MAC.
  * @is_pseudo_fixed_link: Set to true if this PHY is an Ethernet switch, etc.
  * @is_gigabit_capable: Set to true if PHY supports 1000Mbps
@@ -637,8 +648,9 @@ struct phy_device {
 
 	u32 phy_id;
 
+	enum phy_access_mode access_mode;
+
 	struct phy_c45_device_ids c45_ids;
-	unsigned is_c45:1;
 	unsigned is_internal:1;
 	unsigned is_pseudo_fixed_link:1;
 	unsigned is_gigabit_capable:1;
@@ -768,7 +780,7 @@ static inline struct phy_device *to_phy_device(const struct device *dev)
 
 static inline bool phy_is_c45(struct phy_device *phydev)
 {
-	return phydev->is_c45;
+	return phydev->access_mode != PHY_ACCESS_C22;
 }
 
 /**
@@ -1626,7 +1638,7 @@ int phy_modify_paged(struct phy_device *phydev, int page, u32 regnum,
 		     u16 mask, u16 set);
 
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
-				     bool is_c45,
+				     enum phy_access_mode mode,
 				     struct phy_c45_device_ids *c45_ids);
 #if IS_ENABLED(CONFIG_PHYLIB)
 int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id);
@@ -1634,7 +1646,8 @@ struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode);
 struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
 struct phy_device *device_phy_find_device(struct device *dev);
 struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
+struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
+				  enum phy_access_mode mode);
 int phy_device_register(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
 #else
@@ -1666,7 +1679,8 @@ struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
 }
 
 static inline
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
+struct phy_device *get_phy_device(struct mii_bus *bus, int addr,
+				  enum phy_access_mode mode)
 {
 	return NULL;
 }

-- 
2.39.2

