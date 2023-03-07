Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AEA6AD377
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjCGAuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCGAug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:50:36 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25FC3B876
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:50:35 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso6356585ots.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678150235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIVEt5mzMQh+SQM5E0MwkZynQfyDVg1kmB9o93x8Uf0=;
        b=fpPKF4sFqdiFmMxkYspjx/BTyWfLJ4paQR++GOkkvNC9fNN6CDWgajgPKif6MzMpGo
         P0tC49EKCTgLlk/FH92PgIm9hcaK/NjYTPLAc9iwd6ItO9OuAj6Lto/HqyqNIBc+6eYl
         CHAn5AUqVcfnwskOp/L1cZWDOXNrynEH4sIs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678150235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIVEt5mzMQh+SQM5E0MwkZynQfyDVg1kmB9o93x8Uf0=;
        b=4FUNoq/ZM3Znlho6sR3trLQP5XAQZnU8nO+jf2LIimejw4GlQrWbIs4H1fDD6YT0xh
         nESooAxDtPmGX3adRle+F8mwr6Fy3CWj/QxJqNO/Um123XoeaJm1K4aOkgjV2ZJGRP6d
         rVDdVFOZXbULsmYlPCVCVtXwNOxVciMLjJ+E2ex6fDMEVCcpO6QKO7wwhrwiGxpJIGWI
         ooaWdgQBBdUfhyCiujkvpM5SNxn/ph8EZnkoZ6hwRYoWP/uGkbByH73mX+fmTyHNTYOi
         EyKffw3g4HRjyld6HGsGWMKRepAeJ+RaiMiP/lFzJ2U0/VYIKSerXlB9w23v7r7aiwCV
         p1Eg==
X-Gm-Message-State: AO0yUKXfcKtAk7bL2mmP44QFM+mpEVAQGA/eNcAFrRkVfh/70sW7ydla
        V1NPKF8itvUFJzHChXtGcPn9jA==
X-Google-Smtp-Source: AK7set92mm/4LBZrltp+qanqEW3SJNLtNBk738SJlyNOplLE8lgmv6wQwuHB3Huz+aahHkuXmk5nuw==
X-Received: by 2002:a9d:7149:0:b0:694:1185:c7bd with SMTP id y9-20020a9d7149000000b006941185c7bdmr5251553otj.29.1678150234943;
        Mon, 06 Mar 2023 16:50:34 -0800 (PST)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id l18-20020a9d7092000000b00693cb03e7e2sm4725373otj.81.2023.03.06.16.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:50:34 -0800 (PST)
From:   Grant Grundler <grundler@chromium.org>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Anton Lundin <glance@acc.umu.se>,
        Eizan Miyamoto <eizan@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>
Subject: [PATCH] net: asix: fix modprobe "sysfs: cannot create duplicate filename"
Date:   Mon,  6 Mar 2023 16:50:28 -0800
Message-Id: <20230307005028.2065800-1-grundler@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"modprobe asix ; rmmod asix ; modprobe asix" fails with:
   sysfs: cannot create duplicate filename \
   	'/devices/virtual/mdio_bus/usb-003:004'

Issue was originally reported by Anton Lundin on 2022-06-22 14:16 UTC:
   https://lore.kernel.org/netdev/20220623063649.GD23685@pengutronix.de/T/

Chrome OS team hit the same issue in Feb, 2023 when trying to find
work arounds for other issues with AX88172 devices.

The use of devm_mdiobus_register() with usbnet devices results in the
MDIO data being associated with the USB device. When the asix driver
is unloaded, the USB device continues to exist and the corresponding
"mdiobus_unregister()" is NOT called until the USB device is unplugged
or unauthorized. So the next "modprobe asix" will fail because the MDIO
phy sysfs attributes still exist.

The 'easy' (from a design PoV) fix is to use the non-devm variants of
mdiobus_* functions and explicitly manage this use in the asix_bind
and asix_unbind function calls. I've not explored trying to fix usbnet
initialization so devm_* stuff will work.

Reported-by: Anton Lundin <glance@acc.umu.se>
Tested-by: Eizan Miyamoto <eizan@chromium.org>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/usb/asix_devices.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 30e87389aefa1..f0a87b933062a 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -640,8 +640,9 @@ static int asix_resume(struct usb_interface *intf)
 static int ax88772_init_mdio(struct usbnet *dev)
 {
 	struct asix_common_private *priv = dev->driver_priv;
+	int ret;
 
-	priv->mdio = devm_mdiobus_alloc(&dev->udev->dev);
+	priv->mdio = mdiobus_alloc();
 	if (!priv->mdio)
 		return -ENOMEM;
 
@@ -653,7 +654,27 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
 
-	return devm_mdiobus_register(&dev->udev->dev, priv->mdio);
+	ret = mdiobus_register(priv->mdio);
+	if (ret) {
+		netdev_err(dev->net, "Could not register MDIO bus (err %d)\n", ret);
+		goto mdio_regerr;
+	}
+
+	priv->phydev = mdiobus_get_phy(priv->mdio, priv->phy_addr);
+	if (priv->phydev)
+		return 0;
+
+	netdev_err(dev->net, "Could not find PHY\n");
+	mdiobus_unregister(priv->mdio);
+mdio_regerr:
+	mdiobus_free(priv->mdio);
+	return ret;
+}
+
+static void ax88772_release_mdio(struct asix_common_private *priv)
+{
+	mdiobus_unregister(priv->mdio);
+	mdiobus_free(priv->mdio);
 }
 
 static int ax88772_init_phy(struct usbnet *dev)
@@ -661,12 +682,6 @@ static int ax88772_init_phy(struct usbnet *dev)
 	struct asix_common_private *priv = dev->driver_priv;
 	int ret;
 
-	priv->phydev = mdiobus_get_phy(priv->mdio, priv->phy_addr);
-	if (!priv->phydev) {
-		netdev_err(dev->net, "Could not find PHY\n");
-		return -ENODEV;
-	}
-
 	ret = phy_connect_direct(dev->net, priv->phydev, &asix_adjust_link,
 				 PHY_INTERFACE_MODE_INTERNAL);
 	if (ret) {
@@ -805,6 +820,7 @@ static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 	struct asix_common_private *priv = dev->driver_priv;
 
 	phy_disconnect(priv->phydev);
+	ax88772_release_mdio(priv);
 	asix_rx_fixup_common_free(dev->driver_priv);
 }
 
-- 
2.39.2

