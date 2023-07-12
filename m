Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45242750BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjGLPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjGLPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF71BFC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC876186E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05537C433C8;
        Wed, 12 Jul 2023 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174476;
        bh=EFOwlRXK1V4bfqqKxN0RZOwt5jtHjodAKvcE7NEr8mc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KJc6nHjYAmS+h2/zBNSlZFCMKHZDVOumyLUchcXX0PJMHIzGiZTMR4tsZAuafKjjr
         XqJI9qqPgPw8EuO60VzRTQ/d0jeII2O9a0/vbYBBjAFMqarB2h0rVr59EgpTg805VV
         quTjrJsII9bOwtGZNvSMUIzfFEDoM6kdmndSdsqkWd27pbae79KZJzULqssXcsFBBa
         Z7uPrePOm+rq2HxcaNInvC3EP74v9f320SLfIZZrG3DG1QAoKpVtWKrBrmw18ebKvm
         6iQuY+TGi9VWqVq28sdhSZiyMUzSbaZdcpGg3WXjRRmsmS7jfAnxlRVphgZROLHGNS
         iMGH3J2RlEmLg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:07 +0200
Subject: [PATCH net-next v3 07/11] net: phy: introduce
 phy_mdiobus_read_mmd()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-7-9eb37edf7be0@kernel.org>
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

Factor out the low-level MDIO bus access code in
__phy_{read,write}_mmd() into individual helper functions. These can
then be used without a struct phy_device, which is needed in the PHY
probing code.

To decide which access - direct or indirect - is used, move away from
phy_has_c45_registers(). That function only indicates whether the PHY
has C45 registers, but not how they are accessed. Instead look at the
access_mode property.

Export a locked variant of the read for the PHY probing code.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - new patch
---
 drivers/net/phy/phy-core.c | 109 +++++++++++++++++++++++++++++++--------------
 include/linux/phy.h        |   3 ++
 2 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 598023610ee5..4863a85f8385 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -546,6 +546,73 @@ static int mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
 	return check_rc ? ret : 0;
 }
 
+static int __phy_mdiobus_read_mmd(struct mii_bus *bus, int phy_addr,
+				  enum phy_access_mode access_mode,
+				  int devad, u32 regnum)
+{
+	switch (access_mode) {
+	case PHY_ACCESS_C45:
+		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);
+	case PHY_ACCESS_C22:
+		/* ignore return value for legacy reasons */
+		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+
+		/* Read the content of the MMD's selected register */
+		return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * phy_mdiobus_read_mmd - low-level function for reading a register
+ *
+ * @bus: the target MII bus
+ * @phy_addr: PHY address on the MII bus
+ * @mode: Access mode of the PHY
+ * @devad: The target MMD (0..31)
+ * @regnum: The target register on the MMD (0..65535)
+ *
+ * Similar to phy_read_mmd() except that it can be used without a phydev and
+ * operates on the MII bus.
+ */
+int phy_mdiobus_read_mmd(struct mii_bus *bus, int phy_addr,
+			 enum phy_access_mode mode,
+			 int devad, u32 regnum)
+{
+	int ret;
+
+	if (regnum > (u16)~0 || devad > 32)
+		return -EINVAL;
+
+	mutex_lock(&bus->mdio_lock);
+	ret = __phy_mdiobus_read_mmd(bus, phy_addr, mode, devad, regnum);
+	mutex_unlock(&bus->mdio_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(phy_mdiobus_read_mmd);
+
+static int __phy_mdiobus_write_mmd(struct mii_bus *bus, int phy_addr,
+				   enum phy_access_mode mode,
+				   int devad, u32 regnum, u16 val)
+{
+	switch (mode) {
+	case PHY_ACCESS_C45:
+		return __mdiobus_c45_write(bus, phy_addr, devad, regnum, val);
+	case PHY_ACCESS_C22:
+		/* ignore return value for legacy reasons */
+		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+
+		/* Write the data into MMD's selected register */
+		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /**
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.
@@ -557,26 +624,14 @@ static int mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
  */
 int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 {
-	int val;
-
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->read_mmd) {
-		val = phydev->drv->read_mmd(phydev, devad, regnum);
-	} else if (phy_has_c45_registers(phydev)) {
-		val = __mdiobus_c45_read(phydev->mdio.bus, phydev->mdio.addr,
-					 devad, regnum);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
-
-		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
+	if (phydev->drv && phydev->drv->read_mmd)
+		return phydev->drv->read_mmd(phydev, devad, regnum);
 
-		/* Read the content of the MMD's selected register */
-		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
-	}
-	return val;
+	return __phy_mdiobus_read_mmd(phydev->mdio.bus, phydev->mdio.addr,
+				      phydev->access_mode, devad, regnum);
 }
 EXPORT_SYMBOL(__phy_read_mmd);
 
@@ -613,28 +668,14 @@ EXPORT_SYMBOL(phy_read_mmd);
  */
 int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 {
-	int ret;
-
 	if (regnum > (u16)~0 || devad > 32)
 		return -EINVAL;
 
-	if (phydev->drv && phydev->drv->write_mmd) {
-		ret = phydev->drv->write_mmd(phydev, devad, regnum, val);
-	} else if (phy_has_c45_registers(phydev)) {
-		ret = __mdiobus_c45_write(phydev->mdio.bus, phydev->mdio.addr,
-					  devad, regnum, val);
-	} else {
-		struct mii_bus *bus = phydev->mdio.bus;
-		int phy_addr = phydev->mdio.addr;
-
-		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
-
-		/* Write the data into MMD's selected register */
-		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
+	if (phydev->drv && phydev->drv->write_mmd)
+		return phydev->drv->write_mmd(phydev, devad, regnum, val);
 
-		ret = 0;
-	}
-	return ret;
+	return __phy_mdiobus_write_mmd(phydev->mdio.bus, phydev->mdio.addr,
+				       phydev->access_mode, devad, regnum, val);
 }
 EXPORT_SYMBOL(__phy_write_mmd);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index cd67887a7289..a482696a17a6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1337,6 +1337,9 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
 	__ret; \
 })
 
+int phy_mdiobus_read_mmd(struct mii_bus *bus, int phy_addr,
+			 enum phy_access_mode mode,
+			 int devad, u32 regnum);
 /*
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.

-- 
2.39.2

