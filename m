Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D860E73C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiJZS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiJZS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:28:04 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB4D8EC7;
        Wed, 26 Oct 2022 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666808828; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S4gvgzJyB1Nn3RQF2axdsIuinR+TvEXD6t9dQlEsAM=;
        b=o5FWQWzvOoDEVxTVLWwk8grKTq7EV7LlxIZsyH1ovUrT0zruX1LX0gB8/AB/kHK31Thu8p
        HPQfWAowZJ5GM2VZyyC2F3JXm6y7/JL8zAACT2kX/SLpkQN0I8EOSzUzA0PpT3h4WxgTtr
        XPdYLqb9LC9bgKc0xKqGbMYB6j13UMM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, od@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 6/7] usb: musb: jz4740: Support the generic PHY framework
Date:   Wed, 26 Oct 2022 19:26:56 +0100
Message-Id: <20221026182657.146630-7-paul@crapouillou.net>
In-Reply-To: <20221026182657.146630-1-paul@crapouillou.net>
References: <20221026182657.146630-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support PHYs implemented using the generic PHY framework instead of the
deprecated USB-PHY framework.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 62 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index d1e4e0deb753..c7b1d2a394d9 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/usb/role.h>
 #include <linux/usb/usb_phy_generic.h>
@@ -81,6 +82,9 @@ static int jz4740_musb_role_switch_set(struct usb_role_switch *sw,
 	struct jz4740_glue *glue = usb_role_switch_get_drvdata(sw);
 	struct usb_phy *phy = glue->musb->xceiv;
 
+	if (!phy)
+		return 0;
+
 	switch (role) {
 	case USB_ROLE_NONE:
 		atomic_notifier_call_chain(&phy->notifier, USB_EVENT_NONE, phy);
@@ -105,21 +109,51 @@ static int jz4740_musb_init(struct musb *musb)
 		.driver_data = glue,
 		.fwnode = dev_fwnode(dev),
 	};
+	int err;
 
 	glue->musb = musb;
 
-	if (dev->of_node)
-		musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
-	else
-		musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-	if (IS_ERR(musb->xceiv))
-		return dev_err_probe(dev, PTR_ERR(musb->xceiv),
-				     "No transceiver configured\n");
+	if (IS_ENABLED(CONFIG_GENERIC_PHY)) {
+		musb->phy = devm_of_phy_get_by_index(dev, dev->of_node, 0);
+		if (IS_ERR(musb->phy)) {
+			err = PTR_ERR(musb->phy);
+			if (err != -ENODEV) {
+				dev_err(dev, "Unable to get PHY\n");
+				return err;
+			}
+
+			musb->phy = NULL;
+		}
+	}
+
+	if (musb->phy) {
+		err = phy_init(musb->phy);
+		if (err) {
+			dev_err(dev, "Failed to init PHY\n");
+			return err;
+		}
+
+		err = phy_power_on(musb->phy);
+		if (err) {
+			dev_err(dev, "Unable to power on PHY\n");
+			goto err_phy_shutdown;
+		}
+	} else {
+		if (dev->of_node)
+			musb->xceiv = devm_usb_get_phy_by_phandle(dev, "phys", 0);
+		else
+			musb->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		if (IS_ERR(musb->xceiv)) {
+			dev_err(dev, "No transceiver configured\n");
+			return PTR_ERR(musb->xceiv);
+		}
+	}
 
 	glue->role_sw = usb_role_switch_register(dev, &role_sw_desc);
 	if (IS_ERR(glue->role_sw)) {
 		dev_err(dev, "Failed to register USB role switch\n");
-		return PTR_ERR(glue->role_sw);
+		err = PTR_ERR(glue->role_sw);
+		goto err_phy_power_down;
 	}
 
 	/*
@@ -131,6 +165,14 @@ static int jz4740_musb_init(struct musb *musb)
 	musb->isr = jz4740_musb_interrupt;
 
 	return 0;
+
+err_phy_power_down:
+	if (musb->phy)
+		phy_power_off(musb->phy);
+err_phy_shutdown:
+	if (musb->phy)
+		phy_exit(musb->phy);
+	return err;
 }
 
 static int jz4740_musb_exit(struct musb *musb)
@@ -138,6 +180,10 @@ static int jz4740_musb_exit(struct musb *musb)
 	struct jz4740_glue *glue = dev_get_drvdata(musb->controller->parent);
 
 	usb_role_switch_unregister(glue->role_sw);
+	if (musb->phy) {
+		phy_power_off(musb->phy);
+		phy_exit(musb->phy);
+	}
 
 	return 0;
 }
-- 
2.35.1

