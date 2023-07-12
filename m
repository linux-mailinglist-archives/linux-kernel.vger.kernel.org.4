Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CDA750BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjGLPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjGLPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE6F1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:07:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2721E616F4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77381C433C7;
        Wed, 12 Jul 2023 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174472;
        bh=wG2VCl98E7sTdn8vbNFgM5GsfqltXpE2UFH1ICDLoVI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u9bv7rM/R9PXPQeYhBBV7a+UvlPuwaDwID9TEoCVyBk41ePxUv9pVkeRfkkISjx2r
         lAF9HXXppONmY9LExJ8q4APXl6aT7/paYskfdNfUOCeaTskSiAX6tZbcu9GS0ddlUY
         Ppt5eftSt8Is6HACoTj5mbpRUlD495fPtW1vnhr47Z310fusjyUevynwpMaXKIXoME
         cGSDa2cUdDIZPIKsQeb0ieNRoV8FKljeh/eaejtz0jTCzCHj6v9z7OhB3a/nxtHXeX
         VcfzL8HrLVYIxtI86DhoRjLajhNziJcdrBhaMc0dGhvRJDylEDjAEprS5c8VtoMcN4
         RcW0wtb7iwccA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:06 +0200
Subject: [PATCH net-next v3 06/11] net: phy: add error checks in
 mmd_phy_indirect()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-6-9eb37edf7be0@kernel.org>
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

Add missing error checks in mmd_phy_indirect(). The error checks need to
be disabled to retain the current behavior in phy_read_mmd() and
phy_write_mmd(). Therefore, add a new parameter to enable the error
checks.

This is a preparation patch to introduce a new C45-over-C22 access
method which will make use of the new error checking.

Regarding the legacy handling, Russell states:

| The reason for that goes back to commit a59a4d192166 ("phy: add the
| EEE support and the way to access to the MMD registers.")
|
| and to maintain compatibility with that; if we start checking for
| errors now, we might trigger a kernel regression sadly.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - don't export it anymore, instead there will be a dedicated helper
---
 drivers/net/phy/phy-core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 686a57d56885..598023610ee5 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -524,18 +524,26 @@ int phy_speed_down_core(struct phy_device *phydev)
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
 }
 
 /**
@@ -563,7 +571,7 @@ int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
 		struct mii_bus *bus = phydev->mdio.bus;
 		int phy_addr = phydev->mdio.addr;
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
+		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
 
 		/* Read the content of the MMD's selected register */
 		val = __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
@@ -619,7 +627,7 @@ int __phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
 		struct mii_bus *bus = phydev->mdio.bus;
 		int phy_addr = phydev->mdio.addr;
 
-		mmd_phy_indirect(bus, phy_addr, devad, regnum);
+		mmd_phy_indirect(bus, phy_addr, devad, regnum, false);
 
 		/* Write the data into MMD's selected register */
 		__mdiobus_write(bus, phy_addr, MII_MMD_DATA, val);

-- 
2.39.2

