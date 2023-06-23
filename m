Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4373B548
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjFWK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjFWK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD91BD2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7389E61A17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABE2C43397;
        Fri, 23 Jun 2023 10:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687516170;
        bh=Y6cTng4sB3ljn5S+j92xxJk0426djdJ4J90vclqWu28=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aegJOsCPs/KVKg3ATjRfSC6ANHZO+2teCEwsHxw/uaJ3KEsFHmv36DlosLbUjiTlK
         AWF4zyTpCQp8LmOvSTESu+Obv9hST8WlA13JHEBcOVMuFBwmrnEiRgIDAF+7KbtMSn
         u/GAT9oqOwTzxaWoifQ/1r9pVL9Ysy+WPv0CzqgvToPYfM0MSQz+g6Hu1PeC+lo6PL
         lvexR2A1tEVLE6xz9M9UCJG7qDwCWLDUQVipfGWR/HBd9jxLFRcQ+rSrnSjNHcJ8kN
         eXHJmJy1YXb6A5gHNinoqRFGiS9hyXXF6Q+jjUlME1AXKCNQ5TJoJTA81jmdXSQebU
         708vq8Av0/42g==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 23 Jun 2023 12:29:12 +0200
Subject: [PATCH net-next v2 03/10] net: phy: introduce phy_is_c45()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-3-def0ab9ccee2@kernel.org>
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

Provide a helper to determine if the PHY is a C45 one. This is a
preparation patch to remove the is_c45 field. No functional change.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c |  4 ++--
 drivers/net/phy/bcm84881.c                       |  2 +-
 drivers/net/phy/marvell10g.c                     |  2 +-
 drivers/net/phy/mxl-gpy.c                        |  2 +-
 drivers/net/phy/phy-core.c                       |  4 ++--
 drivers/net/phy/phy.c                            |  8 +++++---
 drivers/net/phy/phy_device.c                     |  6 +++---
 drivers/net/phy/phylink.c                        | 10 +++++-----
 include/linux/phy.h                              |  5 +++++
 9 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index b54f3706fb97..7b1511edc2c5 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -916,7 +916,7 @@ static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
 		ethtool_sprintf(&buff,
 				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
-		if ((netdev->phydev) && (!netdev->phydev->is_c45))
+		if (netdev->phydev && !phy_is_c45(netdev->phydev))
 			ethtool_sprintf(&buff,
 					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
 
@@ -976,7 +976,7 @@ static int hns_get_sset_count(struct net_device *netdev, int stringset)
 		if (priv->ae_handle->phy_if == PHY_INTERFACE_MODE_XGMII)
 			cnt--;
 
-		if ((!netdev->phydev) || (netdev->phydev->is_c45))
+		if (!netdev->phydev || phy_is_c45(netdev->phydev))
 			cnt--;
 
 		return cnt;
diff --git a/drivers/net/phy/bcm84881.c b/drivers/net/phy/bcm84881.c
index 9717a1626f3f..5fd67ede6802 100644
--- a/drivers/net/phy/bcm84881.c
+++ b/drivers/net/phy/bcm84881.c
@@ -47,7 +47,7 @@ static int bcm84881_probe(struct phy_device *phydev)
 	/* This driver requires PMAPMD and AN blocks */
 	const u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 
-	if (!phydev->is_c45 ||
+	if (!phy_is_c45(phydev) ||
 	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
 		return -ENODEV;
 
diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 55d9d7acc32e..6c2cde4b87fc 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -499,7 +499,7 @@ static int mv3310_probe(struct phy_device *phydev)
 	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 	int ret;
 
-	if (!phydev->is_c45 ||
+	if (!phy_is_c45(phydev) ||
 	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
 		return -ENODEV;
 
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index ea1073adc5a1..66411e46937b 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -281,7 +281,7 @@ static int gpy_probe(struct phy_device *phydev)
 	int fw_version;
 	int ret;
 
-	if (!phydev->is_c45) {
+	if (!phy_is_c45(phydev)) {
 		ret = phy_get_c45_ids(phydev);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 65ff58b36fc0..5f73d27fe330 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -582,7 +582,7 @@ int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 
 	if (phydev->drv && phydev->drv->read_mmd) {
 		val = phydev->drv->read_mmd(phydev, devad, regnum);
-	} else if (phydev->is_c45) {
+	} else if (phy_is_c45(phydev)) {
 		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
 					 devad, regnum);
 	} else {
@@ -638,7 +638,7 @@ int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 
 	if (phydev->drv && phydev->drv->write_mmd) {
 		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
-	} else if (phydev->is_c45) {
+	} else if (phy_is_c45(phydev)) {
 		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
 					  devad, regnum, val);
 	} else {
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bdf00b2b2c1d..debd618670e6 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -182,7 +182,8 @@ int phy_restart_aneg(struct phy_device *phydev)
 {
 	int ret;
 
-	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+	if (phy_is_c45(phydev) &&
+	    !(phydev->c45_ids.devices_in_package & BIT(0)))
 		ret = genphy_c45_restart_aneg(phydev);
 	else
 		ret = genphy_restart_aneg(phydev);
@@ -203,7 +204,7 @@ int phy_aneg_done(struct phy_device *phydev)
 {
 	if (phydev->drv && phydev->drv->aneg_done)
 		return phydev->drv->aneg_done(phydev);
-	else if (phydev->is_c45)
+	else if (phy_is_c45(phydev))
 		return genphy_c45_aneg_done(phydev);
 	else
 		return genphy_aneg_done(phydev);
@@ -896,7 +897,8 @@ int phy_config_aneg(struct phy_device *phydev)
 	/* Clause 45 PHYs that don't implement Clause 22 registers are not
 	 * allowed to call genphy_config_aneg()
 	 */
-	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+	if (phy_is_c45(phydev) &&
+	    !(phydev->c45_ids.devices_in_package & BIT(0)))
 		return genphy_c45_config_aneg(phydev);
 
 	return genphy_config_aneg(phydev);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 226d5507c865..660dca65f76f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -533,7 +533,7 @@ static int phy_bus_match(struct device *dev, struct device_driver *drv)
 	if (phydrv->match_phy_device)
 		return phydrv->match_phy_device(phydev);
 
-	if (phydev->is_c45) {
+	if (phy_is_c45(phydev)) {
 		for (i = 1; i < num_ids; i++) {
 			if (phydev->c45_ids.device_ids[i] == 0xffffffff)
 				continue;
@@ -1452,7 +1452,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 * exist, and we should use the genphy driver.
 	 */
 	if (!d->driver) {
-		if (phydev->is_c45)
+		if (phy_is_c45(phydev))
 			d->driver = &genphy_c45_driver.mdiodrv.driver;
 		else
 			d->driver = &genphy_driver.mdiodrv.driver;
@@ -3227,7 +3227,7 @@ static int phy_probe(struct device *dev)
 	}
 	else if (phydrv->get_features)
 		err = phydrv->get_features(phydev);
-	else if (phydev->is_c45)
+	else if (phy_is_c45(phydev))
 		err = genphy_c45_pma_read_abilities(phydev);
 	else
 		err = genphy_read_abilities(phydev);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 97c15e1f81de..eeac36176960 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1703,7 +1703,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	 * against all interface modes, which may lead to more ethtool link
 	 * modes being advertised than are actually supported.
 	 */
-	if (phy->is_c45 && config.rate_matching == RATE_MATCH_NONE &&
+	if (phy_is_c45(phy) && config.rate_matching == RATE_MATCH_NONE &&
 	    interface != PHY_INTERFACE_MODE_RXAUI &&
 	    interface != PHY_INTERFACE_MODE_XAUI &&
 	    interface != PHY_INTERFACE_MODE_USXGMII)
@@ -2650,7 +2650,7 @@ static int phylink_phy_read(struct phylink *pl, unsigned int phy_id,
 					reg);
 	}
 
-	if (phydev->is_c45) {
+	if (phy_is_c45(phydev)) {
 		switch (reg) {
 		case MII_BMCR:
 		case MII_BMSR:
@@ -2692,7 +2692,7 @@ static int phylink_phy_write(struct phylink *pl, unsigned int phy_id,
 					 reg, val);
 	}
 
-	if (phydev->is_c45) {
+	if (phy_is_c45(phydev)) {
 		switch (reg) {
 		case MII_BMCR:
 		case MII_BMSR:
@@ -3165,8 +3165,8 @@ static void phylink_sfp_link_up(void *upstream)
  */
 static bool phylink_phy_no_inband(struct phy_device *phy)
 {
-	return phy->is_c45 && phy_id_compare(phy->c45_ids.device_ids[1],
-					     0xae025150, 0xfffffff0);
+	return phy_is_c45(phy) && phy_id_compare(phy->c45_ids.device_ids[1],
+						 0xae025150, 0xfffffff0);
 }
 
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 9521b815d3f0..787bfe8e5c45 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -766,6 +766,11 @@ static inline struct phy_device *to_phy_device(const struct device *dev)
 	return container_of(to_mdio_device(dev), struct phy_device, mdio);
 }
 
+static inline bool phy_is_c45(struct phy_device *phydev)
+{
+	return phydev->is_c45;
+}
+
 /**
  * struct phy_tdr_config - Configuration of a TDR raw test
  *

-- 
2.39.2

