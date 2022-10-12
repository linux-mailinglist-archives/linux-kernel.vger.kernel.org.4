Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDC05FC666
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJLN2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJLN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:28:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC27A9243
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:28:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oibmD-0000J9-Jg; Wed, 12 Oct 2022 15:28:01 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oibmC-0016Pw-T1; Wed, 12 Oct 2022 15:28:00 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oibmB-001EoB-Ps; Wed, 12 Oct 2022 15:27:59 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        kernel@pengutronix.de, Mark Brown <broonie@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] usb: phy: generic: make vcc regulator optional
Date:   Wed, 12 Oct 2022 15:27:54 +0200
Message-Id: <20221012132754.292151-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy-generic uses the existance of the property "vcc-supply" to see if a
regulator is optional or not. Use devm_regulator_get_optional() instead
which exists for this purpose. Using devm_regulator_get_optional()
avoids "supply vcc not found, using dummy regulator" messages.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/phy/phy-generic.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 34b9f81401871..92d3e067067c6 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -209,7 +209,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 	int err = 0;
 
 	u32 clk_rate = 0;
-	bool needs_vcc = false, needs_clk = false;
+	bool needs_clk = false;
 
 	if (dev->of_node) {
 		struct device_node *node = dev->of_node;
@@ -217,7 +217,6 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		if (of_property_read_u32(node, "clock-frequency", &clk_rate))
 			clk_rate = 0;
 
-		needs_vcc = of_property_read_bool(node, "vcc-supply");
 		needs_clk = of_property_read_bool(node, "clocks");
 	}
 	nop->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
@@ -260,13 +259,10 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		}
 	}
 
-	nop->vcc = devm_regulator_get(dev, "vcc");
-	if (IS_ERR(nop->vcc)) {
-		dev_dbg(dev, "Error getting vcc regulator: %ld\n",
-					PTR_ERR(nop->vcc));
-		if (needs_vcc)
-			return -EPROBE_DEFER;
-	}
+	nop->vcc = devm_regulator_get_optional(dev, "vcc");
+	if (IS_ERR(nop->vcc) && PTR_ERR(nop->vcc) != -ENODEV)
+		return dev_err_probe(dev, PTR_ERR(nop->vcc),
+				     "could not get vcc regulator\n");
 
 	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
 	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
-- 
2.30.2

