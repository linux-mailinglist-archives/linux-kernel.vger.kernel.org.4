Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB76FE5BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjEJUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjEJUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAF96EA7;
        Wed, 10 May 2023 13:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 732CC64A3C;
        Wed, 10 May 2023 20:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1460C433EF;
        Wed, 10 May 2023 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751853;
        bh=6sGfIeAH+EYa3fOLxgPHH2fMnwBuBPM3BpmYiynwUQo=;
        h=From:To:Cc:Subject:Date:From;
        b=MPvG94GTN3Afp7t1kVqNgLhbmbSkLv83HLnmbHhSbqs0phTUmpXMVWaolIAs3ADSX
         RJ2C3MDJ2I31Z+ovgotv/M64LiIAJj24zruCbKB7sIqB5soJIfnP3LZiuQMH8cb8B9
         CIDaiTxkWHj9K9diDsnnyZYYKPtkAwwnWl0iR5iAftdUc0DIH9JpYOps8lAn6vv//K
         iQlAUZmtszRgvJJMih26MlfvCmAA7nTK8UljTXcq5Eu12QThehbbE0JqYMU6F7/4km
         aIwilI8t1q8aSOEr2Q90LwMOTEtHmCH/FoETxEVqX+xY7K0belBIqgKddkyKcgeyz/
         FmA1LiMju4lHQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alain Volmat <avolmat@me.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 1/2] phy: st: miphy28lp: use _poll_timeout functions for waits
Date:   Wed, 10 May 2023 16:50:36 -0400
Message-Id: <20230510205037.105115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <avolmat@me.com>

[ Upstream commit e3be4dd2c8d8aabfd2c3127d0e2e5754d3ae82d6 ]

This commit introduces _poll_timeout functions usage instead of
wait loops waiting for a status bit.

Signed-off-by: Alain Volmat <avolmat@me.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Link: https://lore.kernel.org/r/20230210224309.98452-1-avolmat@me.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/st/phy-miphy28lp.c | 42 ++++++++--------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/st/phy-miphy28lp.c b/drivers/phy/st/phy-miphy28lp.c
index 213e2e15339c4..fe23432e5b1a6 100644
--- a/drivers/phy/st/phy-miphy28lp.c
+++ b/drivers/phy/st/phy-miphy28lp.c
@@ -13,6 +13,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -488,19 +489,11 @@ static inline void miphy28lp_pcie_config_gen(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy28lp_wait_compensation(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 val;
 
 	/* Waiting for Compensation to complete */
-	do {
-		val = readb_relaxed(miphy_phy->base + MIPHY_COMP_FSM_6);
-
-		if (time_after_eq(jiffies, finish))
-			return -EBUSY;
-		cpu_relax();
-	} while (!(val & COMP_DONE));
-
-	return 0;
+	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_COMP_FSM_6,
+					  val, val & COMP_DONE, 1, 5 * USEC_PER_SEC);
 }
 
 
@@ -809,7 +802,6 @@ static inline void miphy28lp_configure_usb3(struct miphy28lp_phy *miphy_phy)
 
 static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 {
-	unsigned long finish = jiffies + 5 * HZ;
 	u8 mask = HFC_PLL | HFC_RDY;
 	u8 val;
 
@@ -820,21 +812,14 @@ static inline int miphy_is_ready(struct miphy28lp_phy *miphy_phy)
 	if (miphy_phy->type == PHY_TYPE_SATA)
 		mask |= PHY_RDY;
 
-	do {
-		val = readb_relaxed(miphy_phy->base + MIPHY_STATUS_1);
-		if ((val & mask) != mask)
-			cpu_relax();
-		else
-			return 0;
-	} while (!time_after_eq(jiffies, finish));
-
-	return -EBUSY;
+	return readb_relaxed_poll_timeout(miphy_phy->base + MIPHY_STATUS_1,
+					  val, (val & mask) == mask, 1,
+					  5 * USEC_PER_SEC);
 }
 
 static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 {
 	struct miphy28lp_dev *miphy_dev = miphy_phy->phydev;
-	unsigned long finish = jiffies + 5 * HZ;
 	u32 val;
 
 	if (!miphy_phy->osc_rdy)
@@ -843,17 +828,10 @@ static int miphy_osc_is_ready(struct miphy28lp_phy *miphy_phy)
 	if (!miphy_phy->syscfg_reg[SYSCFG_STATUS])
 		return -EINVAL;
 
-	do {
-		regmap_read(miphy_dev->regmap,
-				miphy_phy->syscfg_reg[SYSCFG_STATUS], &val);
-
-		if ((val & MIPHY_OSC_RDY) != MIPHY_OSC_RDY)
-			cpu_relax();
-		else
-			return 0;
-	} while (!time_after_eq(jiffies, finish));
-
-	return -EBUSY;
+	return regmap_read_poll_timeout(miphy_dev->regmap,
+					miphy_phy->syscfg_reg[SYSCFG_STATUS],
+					val, val & MIPHY_OSC_RDY, 1,
+					5 * USEC_PER_SEC);
 }
 
 static int miphy28lp_get_resource_byname(struct device_node *child,
-- 
2.39.2

