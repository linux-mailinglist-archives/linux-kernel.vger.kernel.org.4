Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4C9750BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjGLPHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbjGLPHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B91BC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00CAE61856
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51105C433C8;
        Wed, 12 Jul 2023 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174458;
        bh=epYrE7lJCWpylSaA6z08Zv5BgEI9FHlBDfIZlfWd7MY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CLdH/kmV5NfX4WnADocwkUl3CMbKxUOvBKpzSw1pQ+6JTrBKAgi0c2bJ6Y8iqdyph
         HNNnlX+oQfc2pH/ZiBTUT5qMGr4o6Ti7OTWvRgVT2YOkazJlfMV352wU3MTJYrA3C0
         uKugr0jAN6B5FgDnp7g9n6Sql1nT2DTLV35NfkMry/41kCPEUphXwxer1HVbRtVTpR
         2C5QJ2G0Gd1nztAE0I7rFldUIcMz0tOU5VFn5TRws5U6yPhlSqiuI7bqVuc+GTEgqh
         fNz9jB2I+NtSGGAolPmnULzm1Gq3m/dk5kyULZ/BNClYSI+QTi+JoUjUKHccaGlFau
         lopqn4QK1Jbqg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:02 +0200
Subject: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
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

Provide a helper to determine if the PHY has a C45 register space. This
is a preparation patch to remove the is_c45 field. No functional change.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - rename to phy_has_c45_registers()
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c |  4 ++--
 drivers/net/phy/bcm84881.c                       |  2 +-
 drivers/net/phy/marvell10g.c                     |  2 +-
 drivers/net/phy/mxl-gpy.c                        |  2 +-
 drivers/net/phy/phy-core.c                       |  4 ++--
 drivers/net/phy/phy.c                            |  8 +++++---
 drivers/net/phy/phy_device.c                     |  6 +++---
 drivers/net/phy/phylink.c                        | 12 +++++++-----
 include/linux/phy.h                              |  5 +++++
 9 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index b54f3706fb97..387d24f195aa 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -916,7 +916,7 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
 		ethtool_sprintf(&buff,
 				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
-		if ((netdev->phydev) && (!netdev->phydev->is_c45))
+		if (netdev->phydev && !phy_has_c45_registers(netdev->phydev))
 			ethtool_sprintf(&buff,
 					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
 
@@ -976,7 +976,7 @@ static int hns_get_sset_count(struct net_device *netdev, int stringset)
 		if (priv->ae_handle->phy_if == PHY_INTERFACE_MODE_XGMII)
 			cnt--;
 
-		if ((!netdev->phydev) || (netdev->phydev->is_c45))
+		if (!netdev->phydev || phy_has_c45_registers(netdev->phydev))
 			cnt--;
 
 		return cnt;
diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 9717a1626f3f..857344260230 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -47,7 +47,7 @@ static int bcm84881_probe(struct phy_device *phydev)
 	/* This driver requires PMAPMD and AN blocks */
 	const u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 
-	if (!phydev->is_c45 ||
+	if (!phy_has_c45_registers(phydev) ||
 	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
 		return -ENODEV;
 
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 55d9d7acc32e..d1c12843462f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -499,7 +499,7 @@ static int mv3310_probe(struct phy_device *phydev)
 	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 	int ret;
 
-	if (!phydev->is_c45 ||
+	if (!phy_has_c45_registers(phydev) ||
 	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
 		return -ENODEV;
 
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index ea1073adc5a1..b4ddb9a003d9 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -281,7 +281,7 @@ static int gpy_probe(struct phy_device *phydev)
 	int fw_version;
 	int ret;
 
-	if (!phydev->is_c45) {
+	if (!phy_has_c45_registers(phydev)) {
 		ret = phy_get_c45_ids(phydev);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index a64186dc53f8..686a57d56885 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -556,7 +556,7 @@ int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 
 	if (phydev->drv && phydev->drv->read_mmd) {
 		val = phydev->drv->read_mmd(phydev, devad, regnum);
-	} else if (phydev->is_c45) {
+	} else if (phy_has_c45_registers(phydev)) {
 		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
 					 devad, regnum);
 	} else {
@@ -612,7 +612,7 @@ int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 
 	if (phydev->drv && phydev->drv->write_mmd) {
 		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
-	} else if (phydev->is_c45) {
+	} else if (phy_has_c45_registers(phydev)) {
 		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
 					  devad, regnum, val);
 	} else {
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bdf00b2b2c1d..c6059ba8b9e6 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -182,7 +182,8 @@ int phy_restart_aneg(struct phy_device *phydev)
 {
 	int ret;
 
-	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+	if (phy_has_c45_registers(phydev) &&
+	    !(phydev->c45_ids.devices_in_package & BIT(0)))
 		ret = genphy_c45_restart_aneg(phydev);
 	else
 		ret = genphy_restart_aneg(phydev);
@@ -203,7 +204,7 @@ int phy_aneg_done(struct phy_device *phydev)
 {
 	if (phydev->drv && phydev->drv->aneg_done)
 		return phydev->drv->aneg_done(phydev);
-	else if (phydev->is_c45)
+	else if (phy_has_c45_registers(phydev))
 		return genphy_c45_aneg_done(phydev);
 	else
 		return genphy_aneg_done(phydev);
@@ -896,7 +897,8 @@ int phy_config_aneg(struct phy_device *phydev)
 	/* Clause 45 PHYs that don't implement Clause 22 registers are not
 	 * allowed to call genphy_config_aneg()
 	 */
-	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+	if (phy_has_c45_registers(phydev) &&
+	    !(phydev->c45_ids.devices_in_package & BIT(0)))
 		return genphy_c45_config_aneg(phydev);
 
 	return genphy_config_aneg(phydev);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 226d5507c865..44968ea447fc 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -533,7 +533,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	if (phydrv->match_phy_device)
 		return phydrv->match_phy_device(phydev);
 
-	if (phydev->is_c45) {
+	if (phy_has_c45_registers(phydev)) {
 		for (i = 1; i < num_ids; i++) {
 			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
 				continue;
@@ -1452,7 +1452,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 * exist, and we should use the genphy driver.
 	 */
 	if (!d->driver) {
-		if (phydev->is_c45)
+		if (phy_has_c45_registers(phydev))
 			d->driver = &genphy_c45_driver.mdiodrv.driver;
 		else
 			d->driver = &genphy_driver.mdiodrv.driver;
@@ -3227,7 +3227,7 @@ static int phy_probe(struct device *dev)
 	}
 	else if (phydrv->get_features)
 		err = phydrv->get_features(phydev);
-	else if (phydev->is_c45)
+	else if (phy_has_c45_registers(phydev))
 		err = genphy_c45_pma_read_abilities(phydev);
 	else
 		err = genphy_read_abilities(phydev);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index d0aaa5cad853..54fde8252079 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1726,7 +1726,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	 * against all interface modes, which may lead to more ethtool link
 	 * modes being advertised than are actually supported.
 	 */
-	if (phy->is_c45 && config.rate_matching == RATE_MATCH_NONE &&
+	if (phy_has_c45_registers(phy) &&
+	    config.rate_matching == RATE_MATCH_NONE &&
 	    interface != PHY_INTERFACE_MODE_RXAUI &&
 	    interface != PHY_INTERFACE_MODE_XAUI &&
 	    interface != PHY_INTERFACE_MODE_USXGMII)
@@ -2673,7 +2674,7 @@ static int phylink_phy_read(struct phylink *pl, unsigned int phy_id,
 					reg);
 	}
 
-	if (phydev->is_c45) {
+	if (phy_has_c45_registers(phydev)) {
 		switch (reg) {
 		case MII_BMCR:
 		case MII_BMSR:
@@ -2715,7 +2716,7 @@ static int phylink_phy_write(struct phylink *pl, unsigned int phy_id,
 					 reg, val);
 	}
 
-	if (phydev->is_c45) {
+	if (phy_has_c45_registers(phydev)) {
 		switch (reg) {
 		case MII_BMCR:
 		case MII_BMSR:
@@ -3188,8 +3189,9 @@ static void phylink_sfp_link_up(void *upstream)
  */
 static bool phylink_phy_no_inband(struct phy_device *phy)
 {
-	return phy->is_c45 && phy_id_compare(phy->c45_ids.device_ids[1],
-					     0xae025150, 0xfffffff0);
+	return phy_has_c45_registers(phy) &&
+	       phy_id_compare(phy->c45_ids.device_ids[1],
+			      0xae025150, 0xfffffff0);
 }
 
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d4..fdb3774e99fc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -766,6 +766,11 @@ static inline struct phy_device *to_phy_device(const struct device *dev)
 	return container_of(to_mdio_device(dev), struct phy_device, mdio);
 }
 
+static inline bool phy_has_c45_registers(struct phy_device *phydev)
+{
+	return phydev->is_c45;
+}
+
 /**
  * struct phy_tdr_config - Configuration of a TDR raw test
  *

-- 
2.39.2

