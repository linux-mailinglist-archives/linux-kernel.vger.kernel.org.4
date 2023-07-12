Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241B750BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjGLPIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjGLPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:08:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B5B1BFB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54AE66186B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E83C433CD;
        Wed, 12 Jul 2023 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174486;
        bh=tGVbgShLqia6tBA8cE55D5pDAK2IrF4I9EWmknCRjh0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oOzUC8AP2YHXm+L+tlHSymOisnyM1agFYfwujCdepkeQxwmw0HuXbVP5yPmHO4uM6
         AmoVAhx/inZg3P/zdkeBy8nL4eOmT9eArENLn2qdX8hXRP6Lko6AY+D0AOo08r3iSl
         iK6MxIUdU5SbV4LjklkEOCbXO8tLIhemOPP/xpNJTZSjN9oQIP05LxBDBLaCX+5UUk
         WFzLAPju8LJucJTcnAilU1wykcZHMv8paOWDsGZy0SRvbscPWOIj9FJsweXnvRxvu9
         CkLungnJklyoB5aa8bFpogsauNedeJCj1hTO5Vqs6R4lqCocv6Cho5y27JW5Ys/9f/
         ZKhxR1xu5o0jA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Wed, 12 Jul 2023 17:07:10 +0200
Subject: [PATCH net-next v3 10/11] net: mdio: add C45-over-C22 fallback to
 fwnode_mdiobus_register_phy()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v3-10-9eb37edf7be0@kernel.org>
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

If trying to register a C45 PHY on an MDIO bus which isn't capable of
C45 (either because the MDIO controller doesn't support it or because
C45 accesses are prohibited due to faulty C22 PHYs) we can fall back to
the new C45-over-C22 access method.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Please note, that both with the old and the new code compatible =
"ethernet-phy-idNNNN.NNNN" only works for the C22 case. I'm wondering if
compatible = "ethernet-phy-idNNNN.NNNN", "ethernet-phy-ieee802.3-c45
even makes sense because there might be multiple C45 ids. At least it is
an allowed pattern according to the device tree bindings. But with the
current code, the ethernet-phy-idNNNN.NNNN is ignored in the c45 case.
---
 drivers/net/mdio/fwnode_mdio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 972c8932c2fe..fed056d82b4e 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -115,7 +115,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	struct mii_timestamper *mii_ts = NULL;
 	struct pse_control *psec = NULL;
 	struct phy_device *phy;
-	bool is_c45;
 	u32 phy_id;
 	int rc;
 
@@ -129,13 +128,19 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		goto clean_pse;
 	}
 
-	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
-		phy = get_phy_device(bus, addr,
-				     is_c45 ? PHY_ACCESS_C45 : PHY_ACCESS_C22);
-	else
+	if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45")) {
+		if (mdiobus_supports_c45(bus))
+			phy = get_phy_device(bus, addr, PHY_ACCESS_C45);
+		else
+			phy = get_phy_device(bus, addr,
+					     PHY_ACCESS_C45_OVER_C22);
+	} else if (fwnode_get_phy_id(child, &phy_id) == 0) {
 		phy = phy_device_create(bus, addr, phy_id, PHY_ACCESS_C22,
 					NULL);
+	} else {
+		phy = get_phy_device(bus, addr, PHY_ACCESS_C22);
+	}
+
 	if (IS_ERR(phy)) {
 		rc = PTR_ERR(phy);
 		goto clean_mii_ts;

-- 
2.39.2

