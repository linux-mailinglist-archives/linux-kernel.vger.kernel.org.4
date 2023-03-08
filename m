Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4776B12F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCHUWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCHUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:22:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEFD13DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:22:07 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l13so19519956qtv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678306927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PD91JLCU8nqhNp2BNb4dzqOxQAgF3Zc/WPy6GVFE0p0=;
        b=ZOcl3fp7ndGiAiVoqBqBEmksP9xAYBVNjnDgRyYHemNyWdrJ4o1shbVm0pJfPfG8y5
         K9gaB9riGyqD6CxPY3XIHu9oDvETbLFpfQs6oS/9UhpddEewjAMI0M8HQiLtacWGXb7L
         fCKyJ9J1iHWJr3uLPIQ6CZ3ZWQiZIcApgEIhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678306927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PD91JLCU8nqhNp2BNb4dzqOxQAgF3Zc/WPy6GVFE0p0=;
        b=f7XILviIkceT5JjcPyT5kprAPiFodlu3ozKRBBd8JbSUz8Ikx1eFk/iCa8SguH0USs
         V7ZpzKAbrVc9IIauluiNKozdNTSPoo/FCODzYSU43hNlVaWSYrSBitgB2OvJn2SgEG5s
         +0oFcPflW3cauNkJZOSlajgtg1KnDyCK6SQ+15RvO1e2ZJ9RiQBYz4FDQmkbzKrDhKxK
         lII351vqwmtubJ2z0lawBM5YX2kTBB8QtKgqDnHDQYZdJjmYknXH2l7jpgi+0+NN6FY6
         U3KUG5XLRb/VQV9q3VUSjhV6GR5CQu53GunLTQeg8HNG7miK1rSpauNIdDhjwT/k8+Mq
         E6PA==
X-Gm-Message-State: AO0yUKVEa8N8hX+t5JkSwU7OyO76f6KyeOOcoyDQ7jQFOFt5JiaMLwrM
        WIN6LRGWbAWP4XvmcAxTwDOSvQ==
X-Google-Smtp-Source: AK7set/J04Z3urjRtlSVHyLUqlUlW1sElNNZmJ6T58htHxHtalEHFtjeEici3dJzhwjTpzZZQWdRTA==
X-Received: by 2002:ac8:4e86:0:b0:3bf:c961:9309 with SMTP id 6-20020ac84e86000000b003bfc9619309mr32554949qtp.37.1678306926826;
        Wed, 08 Mar 2023 12:22:06 -0800 (PST)
Received: from grundler-glapstation.lan ([70.134.62.80])
        by smtp.gmail.com with ESMTPSA id e16-20020ac84150000000b003b84b92052asm12180969qtm.57.2023.03.08.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:22:06 -0800 (PST)
From:   Grant Grundler <grundler@chromium.org>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        Anton Lundin <glance@acc.umu.se>
Subject: [PATCHv3 net 1/2] net: asix: fix modprobe "sysfs: cannot create duplicate filename"
Date:   Wed,  8 Mar 2023 12:21:58 -0800
Message-Id: <20230308202159.2419227-1-grundler@chromium.org>
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

Fixes: e532a096be0e ("net: usb: asix: ax88772: add phylib support")
Reported-by: Anton Lundin <glance@acc.umu.se>
Link: https://lore.kernel.org/netdev/20220623063649.GD23685@pengutronix.de/T/
Tested-by: Eizan Miyamoto <eizan@chromium.org>
Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/net/usb/asix_devices.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

V3: rebase against netdev/net.git
    remove "TEST" prefix in subject line
    added Link: tag for Reported-by tag

V2: moved mdiobus_get_phy() call back into ax88772_init_phy()
   (Lukas Wunner is entirely correct this patch is much easier
   to backport without this patch hunk.)
   Added "Fixes:" tag per request from Florian Fainelli

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 743cbf5d662c..538c84909913 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -666,8 +666,9 @@ static int asix_resume(struct usb_interface *intf)
 static int ax88772_init_mdio(struct usbnet *dev)
 {
 	struct asix_common_private *priv = dev->driver_priv;
+	int ret;
 
-	priv->mdio = devm_mdiobus_alloc(&dev->udev->dev);
+	priv->mdio = mdiobus_alloc();
 	if (!priv->mdio)
 		return -ENOMEM;
 
@@ -679,7 +680,20 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
 
-	return devm_mdiobus_register(&dev->udev->dev, priv->mdio);
+	ret = mdiobus_register(priv->mdio);
+	if (ret) {
+		netdev_err(dev->net, "Could not register MDIO bus (err %d)\n", ret);
+		mdiobus_free(priv->mdio);
+		priv->mdio = NULL;
+	}
+
+	return ret;
+}
+
+static void ax88772_mdio_unregister(struct asix_common_private *priv)
+{
+	mdiobus_unregister(priv->mdio);
+	mdiobus_free(priv->mdio);
 }
 
 static int ax88772_init_phy(struct usbnet *dev)
@@ -690,6 +704,7 @@ static int ax88772_init_phy(struct usbnet *dev)
 	priv->phydev = mdiobus_get_phy(priv->mdio, priv->phy_addr);
 	if (!priv->phydev) {
 		netdev_err(dev->net, "Could not find PHY\n");
+		ax88772_mdio_unregister(priv);
 		return -ENODEV;
 	}
 
@@ -926,6 +941,7 @@ static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 	phylink_disconnect_phy(priv->phylink);
 	rtnl_unlock();
 	phylink_destroy(priv->phylink);
+	ax88772_mdio_unregister(priv);
 	asix_rx_fixup_common_free(dev->driver_priv);
 }
 
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

