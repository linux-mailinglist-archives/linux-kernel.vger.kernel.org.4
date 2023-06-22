Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B3373A895
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjFVSuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVSuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:50:00 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 11:49:58 PDT
Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92549A2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:49:58 -0700 (PDT)
Received: from localhost.localdomain ([146.241.96.150])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CPMRqVUdKoNFCCPMRqpqyA; Thu, 22 Jun 2023 20:48:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1687459733; bh=zJtpFBlzWk1ZS1ZtblEKyuxmBEYkKm450YWAO4rklz0=;
        h=From:To:Subject:Date:MIME-Version;
        b=i+Gd4A8/0DnY9VnzFNPFpf5UTVc9Wa/avbpw3796KnZUToSU76jJmCHks8Nb8w+dA
         2avDZYIfwaeRG6+DzbVWkU01xvdbjZvqlcljerCqeRC9dJ+V1bNibu/z8bDUo681r9
         UcADbZy+YHGTFS4K/9pyX/v40PrlfgTFU623EHaWEt0Q6Apxxe1od6odsQmZJVm51q
         VK8V5kLKUTIcSFN9aiaA5YG6MWejvJUsSlEv/49weiDYSlmoZLLOxha9AQCTkcBUjN
         erACfpn+Ser9+YP2qugSJZtq50qCTliWfK4tLE+ySKBR+IQB2LHQFxWHLQtXKmz1ge
         WI03A7YrNCYPA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH net-next v2] net: phy: broadcom: drop brcm_phy_setbits() and use phy_set_bits() instead
Date:   Thu, 22 Jun 2023 20:47:21 +0200
Message-Id: <20230622184721.24368-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZJRqMLepCTPqvCD9@corigine.com>
References: <ZJRqMLepCTPqvCD9@corigine.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfA47KHPQ+3VK5+xnxuA//l8ONlMRqkhsU6gSpgBYA5KtR9yOjLrnq707eHgEyL4be4ghoSu7Peoj+b69HVOA+wh2WFbSjHymKCdL1zISGO5KeEaRbmQe
 hOR5eBaARQ1OZisyyMbp2E9nz3S4FR4HuEmEgNSHNYt020EAMX/Kh7Gcv4H2t0keD6zi4J2P+e4Wl7pKfTABnRGkoOeSfvTwskROCbbKHlvrhmAqgqE2/bGH
 XEolM1GACCVx4Uap8nR7J9DDgPGaHqCKzyeDzD/GiKxHgWHbw/PUxw/Am64wCn9KagdAagdTftIf1yKb21uK8v1XJZVuFY7ihoat6YyfBt+Nct0YdSQ5D5Lh
 ynzkvP9Wq2ByFitm9/XADjzqO25qMqS5UvVmfu7tRuMGy+oVS1jZnQlocEM29Vv2zFa8ubx9Wfo3zdM0mWoqpN8EK7zGEHAtIdOTqbl/Rbe+zmPK26Y5W3oU
 oa1PjCrUVeNEATO7YYgU0Yo401pLxD/tLbOwx6rDDjJs/AoRvioNvlA9XCaGx0FGLFxyt+3RBo9vsFmJB006eBD6FqnunGRDHsLryN4X/Dxd+hmQYnkZzAsa
 /j4DAtI3/pR+n7sdnpak9yovA8uPxkjN6rlZU97t1tH299KloEet9r6YPRIJ+Wec6m0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux provides phy_set_bits() helper so let's drop brcm_phy_setbits() and
use phy_set_bits() in its place.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* fix code style and add branch net-next to subject as suggested by Simon
  Horman
---
 drivers/net/phy/broadcom.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index e81868d1830b..38a6615deaf7 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -608,17 +608,6 @@ static int bcm54616s_read_status(struct phy_device *phydev)
 	return err;
 }
 
-static int brcm_phy_setbits(struct phy_device *phydev, int reg, int set)
-{
-	int val;
-
-	val = phy_read(phydev, reg);
-	if (val < 0)
-		return val;
-
-	return phy_write(phydev, reg, val | set);
-}
-
 static int brcm_fet_config_init(struct phy_device *phydev)
 {
 	int reg, err, err2, brcmtest;
@@ -689,15 +678,15 @@ static int brcm_fet_config_init(struct phy_device *phydev)
 		goto done;
 
 	/* Enable auto MDIX */
-	err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
-				       MII_BRCM_FET_SHDW_MC_FAME);
+	err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_MISCCTRL,
+			   MII_BRCM_FET_SHDW_MC_FAME);
 	if (err < 0)
 		goto done;
 
 	if (phydev->dev_flags & PHY_BRCM_AUTO_PWRDWN_ENABLE) {
 		/* Enable auto power down */
-		err = brcm_phy_setbits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
-					       MII_BRCM_FET_SHDW_AS2_APDE);
+		err = phy_set_bits(phydev, MII_BRCM_FET_SHDW_AUXSTAT2,
+				   MII_BRCM_FET_SHDW_AS2_APDE);
 	}
 
 done:
-- 
2.34.1

