Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7C6719C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjARK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjARKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:53:07 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6179488756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:02:22 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:4745:2e6d:e3a6:3327])
        by laurent.telenet-ops.be with bizsmtp
        id AA2F2900N2zf9gW01A2FTg; Wed, 18 Jan 2023 11:02:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5Gj-005aHF-Rw;
        Wed, 18 Jan 2023 11:02:15 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pI5Gp-001JHm-5C;
        Wed, 18 Jan 2023 11:02:15 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: Return NULL if the PHY is optional (part two)
Date:   Wed, 18 Jan 2023 11:02:12 +0100
Message-Id: <663dfcec9f703c41759dcd4cd824d00caa2dd5fb.1674036031.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're trying to get a handle to an optional PHY, then the PHY
framework being disabled shouldn't return a hard error.

Instead, return NULL just like phy_optional_get() does when there's no
PHY provided in the DT.

Based on commit 11a6e41c0ee503ff ("phy: Return NULL if the phy is
optional"), which did the same thing for devm_phy_optional_get().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
It seems there were never any in-tree users of this function since its
introduction in 788a4d56ff378bff ("drivers: phy: Add support for
optional phys") in v3.14.
Perhaps it should be removed?
---
 include/linux/phy/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index b1413757fcc3b89b..559c3da515073697 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -429,7 +429,7 @@ static inline struct phy *phy_get(struct device *dev, const char *string)
 static inline struct phy *phy_optional_get(struct device *dev,
 					   const char *string)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline struct phy *devm_phy_get(struct device *dev, const char *string)
-- 
2.34.1

