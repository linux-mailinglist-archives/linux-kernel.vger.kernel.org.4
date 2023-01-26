Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95F67D7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjAZVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjAZVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:37:54 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8393AB47A;
        Thu, 26 Jan 2023 13:37:50 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id B56FD7A0081;
        Thu, 26 Jan 2023 22:37:48 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] bpck_usb_firmware: Micro Solutions Backpack USB firmware loader
Date:   Thu, 26 Jan 2023 22:37:42 +0100
Message-Id: <20230126213742.19933-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for loading firmware into Micro Solutions USB optical and
hard drives. Once the firmware is loaded, they are USB mass storage
compliant and will be handled by the usb-storage driver.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/usb/misc/Kconfig             |   8 ++
 drivers/usb/misc/Makefile            |   1 +
 drivers/usb/misc/bpck_usb_firmware.c | 113 +++++++++++++++++++++++++++
 drivers/usb/misc/ezusb.c             |   6 --
 include/linux/usb/ezusb.h            |   3 +
 5 files changed, 125 insertions(+), 6 deletions(-)
 create mode 100644 drivers/usb/misc/bpck_usb_firmware.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index a5f7652db7da..4c4e7cf35344 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -311,3 +311,11 @@ config USB_ONBOARD_HUB
 	  this config will enable the driver and it will automatically
 	  match the state of the USB subsystem. If this driver is a
 	  module it will be called onboard_usb_hub.
+
+config USB_BACKPACK_FW
+	tristate "Micro Solutions Backpack firmware loading support"
+	select USB_EZUSB_FX2
+	help
+	  This driver loads firmware for Micro Solutions Backpack USB optical
+	  and hard drives. Once the firmware is loaded, they're USB mass
+	  storage compliant and thus handled by the usb-storage driver.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 93581baec3a8..ef13699f50cc 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
 obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
 obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
+obj-$(CONFIG_USB_BACKPACK_FW)		+= bpck_usb_firmware.o
diff --git a/drivers/usb/misc/bpck_usb_firmware.c b/drivers/usb/misc/bpck_usb_firmware.c
new file mode 100644
index 000000000000..d579a8cdc3ae
--- /dev/null
+++ b/drivers/usb/misc/bpck_usb_firmware.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for loading firmware into Micro Solutions USB optical and hard drives
+ *
+ * Copyright (C) 2023 Ondrej Zary <linux@zary.sk>
+ *
+ * Most Micro Solutions external drives are parallel port devices that can be
+ * connected directly to a parallel port or a PCMCIA card (Model 836 - also acts
+ * as a parallel port) - and handled by pata_parport driver.
+ *
+ * There are also special USB cables that translate the Backpack parallel
+ * protocol to standard USB mass storage protocol.
+ * Model 839 - based on Cypress EZ-USB FX (USB 1.1)
+ * Model 840 - based on Cypress EZ-USB FX2 (USB 2.0)
+ * Newer drives have integrated USB 2.0 port.
+ *
+ * All these USB devices require a firmware to be downloaded to chip's RAM after
+ * each USB (re)connect. Once the firmware is loaded, they are USB mass storage
+ * compliant and will be handled by the usb-storage driver.
+ *
+ * The cables need various firmware depending on the drive type connected. The
+ * cable appears first with USB device ID 0x0000 or 0x0001. First, a "scan"
+ * firmware is loaded that identifies the drive type and changes the USB device
+ * ID appropriately. Then a final firmware is loaded, depending on the chip
+ * type, drive version (5 or 6) and drive type (CD or HDD).
+ *
+ * The cable is pretty intelligent - if there's no drive connected (or it's not
+ * powered up), it keeps trying (and blinking its LED), eventually detecting a
+ * connected drive and changing the USB ID. When the drive is disconnected, the
+ * cable does an USB reconnect so the "scan" firmware is loaded again.
+ * This means that drives can be hot-pluggged at the parallel port end of the
+ * cable.
+ */
+
+#include <linux/usb.h>
+#include <linux/errno.h>
+#include <linux/usb/ezusb.h>
+
+static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x0ac9, 0x0000), .driver_info = (unsigned long) "backpack/BP1SCAN.fw" },
+	{ USB_DEVICE(0x0ac9, 0x0001), .driver_info = (unsigned long) "backpack/BP2SCAN.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1000), .driver_info = (unsigned long) "backpack/BP1CD5.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1001), .driver_info = (unsigned long) "backpack/BP1CD6.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1002), .driver_info = (unsigned long) "backpack/BP1HD5.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1003), .driver_info = (unsigned long) "backpack/BP1HD6.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1004), .driver_info = (unsigned long) "backpack/BP2CD5.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1005), .driver_info = (unsigned long) "backpack/BP2CD6.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1006), .driver_info = (unsigned long) "backpack/BP2HD5.fw" },
+	{ USB_DEVICE(0x0ac9, 0x1007), .driver_info = (unsigned long) "backpack/BP2HD6.fw" },
+	{ USB_DEVICE(0x0ac9, 0x0010), .driver_info = (unsigned long) "backpack/BPINTCD.fw" },
+	{ USB_DEVICE(0x0ac9, 0x0011), .driver_info = (unsigned long) "backpack/BPINTHD.fw" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(usb, id_table);
+
+static int bpck_usb_fw_load(struct usb_interface *intf,
+			    const struct usb_device_id *id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	char *fw_name = (char *)id->driver_info;
+	int ret;
+
+	if (le16_to_cpu(dev->descriptor.bcdUSB) >= 0x0200) {
+		ezusb_fx2_set_reset(dev, 1);
+		ret = ezusb_fx2_ihex_firmware_download(dev, fw_name);
+	} else {
+		ezusb_fx1_set_reset(dev, 1);
+		ret = ezusb_fx1_ihex_firmware_download(dev, fw_name);
+	}
+
+	if (ret < 0) {
+		dev_err(&dev->dev, "failed to load firmware \"%s\"\n", fw_name);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+/* scan firmware */
+MODULE_FIRMWARE("backpack/BP1SCAN.fw"); /* USB 1.1 cable */
+MODULE_FIRMWARE("backpack/BP2SCAN.fw"); /* USB 2.0 cable */
+/* for USB 1.1 chips (integrated in cable) */
+MODULE_FIRMWARE("backpack/BP1CD5.fw"); /* series 5 optical drives */
+MODULE_FIRMWARE("backpack/BP1CD6.fw"); /* series 6 optical drives */
+MODULE_FIRMWARE("backpack/BP1HD5.fw"); /* series 5 hard drives */
+MODULE_FIRMWARE("backpack/BP1HD6.fw"); /* series 6 hard drives */
+/* for USB 2.0 chips (integrated in cable) */
+MODULE_FIRMWARE("backpack/BP2CD5.fw"); /* series 5 optical drives */
+MODULE_FIRMWARE("backpack/BP2CD6.fw"); /* series 6 optical drives */
+MODULE_FIRMWARE("backpack/BP2HD5.fw"); /* series 5 hard drives */
+MODULE_FIRMWARE("backpack/BP2HD6.fw"); /* series 6 hard drives */
+/* for device-integrated USB 2.0 chips */
+MODULE_FIRMWARE("backpack/BPINTCD.fw"); /* optical drives */
+MODULE_FIRMWARE("backpack/BPINTHD.fw"); /* hard drives */
+
+static void bpck_usb_fw_disconnect(struct usb_interface *intf)
+{
+	/* nothing to do here but mandatory */
+}
+
+static struct usb_driver bpck_usb_fw_driver = {
+	.name = "bpck_usb_firwmare",
+	.probe = bpck_usb_fw_load,
+	.disconnect = bpck_usb_fw_disconnect,
+	.id_table = id_table,
+};
+
+module_usb_driver(bpck_usb_fw_driver);
+
+MODULE_AUTHOR("Ondrej Zary");
+MODULE_DESCRIPTION("Micro Solutions Backpack USB firmware loader");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/misc/ezusb.c b/drivers/usb/misc/ezusb.c
index 78aaee56c2b7..30d6b1d8e265 100644
--- a/drivers/usb/misc/ezusb.c
+++ b/drivers/usb/misc/ezusb.c
@@ -124,11 +124,6 @@ int ezusb_fx1_ihex_firmware_download(struct usb_device *dev,
 }
 EXPORT_SYMBOL_GPL(ezusb_fx1_ihex_firmware_download);
 
-#if 0
-/*
- * Once someone one needs these fx2 functions, uncomment them
- * and add them to ezusb.h and all should be good.
- */
 static struct ezusb_fx_type ezusb_fx2 = {
 	.cpucs_reg = 0xE600,
 	.max_internal_adress = 0x3FFF,
@@ -146,6 +141,5 @@ int ezusb_fx2_ihex_firmware_download(struct usb_device *dev,
 	return ezusb_ihex_firmware_download(dev, ezusb_fx2, firmware_path);
 }
 EXPORT_SYMBOL_GPL(ezusb_fx2_ihex_firmware_download);
-#endif
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/usb/ezusb.h b/include/linux/usb/ezusb.h
index 487047162ca8..f00895cc7a8e 100644
--- a/include/linux/usb/ezusb.h
+++ b/include/linux/usb/ezusb.h
@@ -5,5 +5,8 @@
 extern int ezusb_fx1_set_reset(struct usb_device *dev, unsigned char reset_bit);
 extern int ezusb_fx1_ihex_firmware_download(struct usb_device *dev,
 					    const char *firmware_path);
+extern int ezusb_fx2_set_reset(struct usb_device *dev, unsigned char reset_bit);
+extern int ezusb_fx2_ihex_firmware_download(struct usb_device *dev,
+				     const char *firmware_path);
 
 #endif /* __EZUSB_H */
-- 
Ondrej Zary

