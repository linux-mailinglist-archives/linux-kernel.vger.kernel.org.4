Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F88273B541
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjFWK3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFWK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A4E9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:29:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4586196E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F899C433C0;
        Fri, 23 Jun 2023 10:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687516163;
        bh=vEp6e9pd3I6Zdh/O1E/anlFi8UY82+4KI4u5fMcKVkw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=fl2VzWeGxHzb+H7YHngnlyV15as9Bo0BUqKBKHwIksx/JXSbfP39UPJDN8kM7VS7Z
         /2zNRz6PFZ8hCxpvWr/6ACVaLwRcbQQth00pjag1gTwzBCGHGSGUXUyCr93jf5HlID
         dskHpg/6Aa7ejr2L/JExuOKs1tjtLha8wXGva3K+b8YeWvI+8YoFT9QT1IECPE3Hy8
         a40vA93nnHbq5c7oVevU7/JiBsWN3mPHXIaJCcQ8A2Ybht6VKD9j6PIZuDCnqhoxpe
         oZolzu8I4VVaqfuG0GH/KbYRcK1o37iTDZIWnUrOc4YmV2Sq4zlBuVozGmxnU0oUXD
         FwLAIAxRma7hA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 23 Jun 2023 12:29:10 +0200
Subject: [PATCH net-next v2 01/10] net: phy: add error checks in
 mmd_phy_indirect() and export it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-1-def0ab9ccee2@kernel.org>
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

Add missing error checks in mmd_phy_indirect(). The error checks need to
be disabled to retain the current behavior in phy_read_mmd() and
phy_write_mmd(). Therefore, add a new parameter to enable the error
checks. Add a thin wrapper __phy_mmd_indirect() which is then exported.

Regarding the legacy handling, Russell states:

| The reason for that goes back to commit a59a4d192166 ("phy: add the
| EEE support and the way to access to the MMD registers.")
|
| and to maintain compatibility with that; if we start checking for
| errors now, we might trigger a kernel regression sadly.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/phy/phy-core.c | 42 ++++++++++++++++++++++++++++++++++--------
 include/linux/phy.h        |  2 ++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index a64186dc53f8..65ff58b36fc0 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -524,19 +524,45 @@ int phy_speed_down_core(struct phy_device *phydev)
 	return 0;
 }
 
-static void mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
-			     u16 regnum)
+static int mmd_phy_indirect(struct mii_bus *bus, int phy_addr, int devad,
+			    u16 regnum, bool check_rc)
 {
+	int ret;
+
 	/* Write the desired MMD Devad */
-	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL, devad);
+	ret = __mdiobus_write(bus, phy_addr, MII_MMD_CTRL, devad);
+	if (check_rc && ret)
+		return ret;
 
 	/* Write the desired MMD register address */
-	__mdiobus_write(bus, phy_addr, MII_MMD_DATA, regnum);
+	ret = __mdiobus_write(bus, phy_addr, MII_MMD_DATA, regnum);
+	if (check_rc && ret)
+		return ret;
 
 	/* Select the Function : DATA with no post increment */
-	__mdiobus_write(bus, phy_addr, MII_MMD_CTRL,
-			devad | MII_MMD_CTRL_NOINCR);
+	ret = __mdiobus_write(bus, phy_addr, MII_MMD_CTRL,
+			      devad | MII_MMD_CTRL_NOINCR);
+
+	return check_rc ? ret : 0;
+}
+
+/**
+ * __phy_mmd_indirect - prepare an indirect C45 register access
+ *
+ * @bus: the target MII bus
+ * @phy_addr: PHY address on the MII bus
+ * @devad: The target MMD (0..31)
+ * @regnum: The target register on the MMD (0..65535)
+ *
+ * Prepare an indirect C45 read or write transfer using the MII_MMD_CTRL and
+ * MII_MMD_DATA registers in C22 space.
+ */
+int __phy_mmd_indirect(struct mii_bus *bus, int phy_addr, int devad,
+		       u16 regnum)
+{
+	return mmd_phy_indirect(bus, phy_addr, devad, regnum, true);
 }
+EXPORT_SYMBOL(__phy_mmd_indirect);
 
 /**
  * __phy_read_mmd - Convenience function for reading a register
@@ -563,7 +589,7 @@ int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 		struct mii_bus *bus = phydev->mdio.bus;
 		int phy_addr = phydev->mdio.addr;
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
+		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
 
 		/* Read the content of the MMD's selected register */
 		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
@@ -619,7 +645,7 @@ int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 		struct mii_bus *bus = phydev->mdio.bus;
 		int phy_addr = phydev->mdio.addr;
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
+		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
 
 		/* Write the data into MMD's selected register */
 		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d4..9521b815d3f0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1316,6 +1316,8 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
 	__ret; \
 })
 
+int __phy_mmd_indirect(struct mii_bus *bus, int phy_addr, int devad,
+		       u16 regnum);
 /*
  * __phy_read_mmd - Convenience function for reading a register
  * from an MMD on a given PHY.

-- 
2.39.2

