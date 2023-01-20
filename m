Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358FC675EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjATUMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjATUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:12:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4496FC13F6;
        Fri, 20 Jan 2023 12:11:56 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.251.226.6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CBEF0514;
        Fri, 20 Jan 2023 21:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674245509;
        bh=8INZZ8USfo2qwFvF451N1PJs0Q18jBa0xLUVpEuT6pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2iELKIgn3t65ZO1pjda+RaLunoAlnP9bKYYKM3E1EUg6+gnd83UuHUwISsy/rA9M
         h2TvBDBHlcU5FRl9Zu3jHVSTQRk/n9I9bhwdRL6i1EWdlWY4qtMC0kWjA8Xf8HnMXn
         43dDoohSxOVIZ5ZB539fWcf+zOIh3ZFrVQTapPus=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 6/6] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Sat, 21 Jan 2023 01:41:04 +0530
Message-Id: <20230120201104.606876-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120201104.606876-1-umang.jain@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices that the vchiq interface registers (bcm2835-audio,
bcm2835-camera) are implemented and exposed by the VC04 firmware.
The device tree describes the VC04 itself with the resources required
to communicate with it through a mailbox interface. However, the
vchiq interface registers these devices as platform devices. This
also means the specific drivers for these devices are getting
registered as platform drivers. This is not correct and a blatant
abuse of platform device/driver.

Replace the platform device/driver model with a standard device driver
model. A custom bus_type, vchiq_bus_type, is created in the vchiq
interface which matches the devices to their specific device drivers
thereby, establishing driver binding. A struct vchiq_device wraps the
struct device for each device being registered on the bus by the vchiq
interface. On the other hand, struct vchiq_driver wraps the struct
device_driver and the module_vchiq_driver() macro is provided for the
driver registration.

Each device registered will expose a 'name' read-only device attribute
in sysfs (/sys/bus/vchiq-bus/devices). New devices and drivers can be
added by registering on vchiq_bus_type and adding a corresponding
device name entry in the static list of devices, vchiq_devices. There
is currently no way to enumerate the VCHIQ devices that are available
from the firmware.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/Makefile        |   1 +
 .../vc04_services/bcm2835-audio/bcm2835.c     |  27 +++--
 .../bcm2835-camera/bcm2835-camera.c           |  25 ++---
 .../interface/vchiq_arm/vchiq_arm.c           |  52 +++++----
 .../interface/vchiq_arm/vchiq_device.c        | 102 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_device.h        |  39 +++++++
 6 files changed, 192 insertions(+), 54 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index 44794bdf6173..2d071e55e175 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -5,6 +5,7 @@ vchiq-objs := \
    interface/vchiq_arm/vchiq_core.o  \
    interface/vchiq_arm/vchiq_arm.o \
    interface/vchiq_arm/vchiq_debugfs.o \
+   interface/vchiq_arm/vchiq_device.o \
    interface/vchiq_arm/vchiq_connected.o \
 
 ifdef CONFIG_VCHIQ_CDEV
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 00bc898b0189..05118dafe62d 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
 #include "bcm2835.h"
 
 static bool enable_hdmi;
@@ -268,9 +268,8 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	int err;
 
 	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
@@ -292,32 +291,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
+static int snd_bcm2835_alsa_suspend(struct device *pdev,
 				    pm_message_t state)
 {
 	return 0;
 }
 
-static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
+static int snd_bcm2835_alsa_resume(struct device *pdev)
 {
 	return 0;
 }
 
 #endif
 
-static struct platform_driver bcm2835_alsa_driver = {
-	.probe = snd_bcm2835_alsa_probe,
+static struct vchiq_driver bcm2835_alsa_driver = {
+	.driver	= {
+		.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
-	.suspend = snd_bcm2835_alsa_suspend,
-	.resume = snd_bcm2835_alsa_resume,
+		.suspend = snd_bcm2835_alsa_suspend,
+		.resume = snd_bcm2835_alsa_resume,
 #endif
-	.driver = {
 		.name = "bcm2835_audio",
-	},
+	}
 };
-module_platform_driver(bcm2835_alsa_driver);
+module_vchiq_driver(bcm2835_alsa_driver);
 
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bcm2835_audio");
+MODULE_ALIAS("bcm2835_audio");
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 4f81765912ea..57f053de53b9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -24,8 +24,9 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
 #include "../vchiq-mmal/mmal-common.h"
 #include "../vchiq-mmal/mmal-encodings.h"
 #include "../vchiq-mmal/mmal-vchiq.h"
@@ -1841,7 +1842,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int bcm2835_mmal_probe(struct platform_device *pdev)
+static int bcm2835_mmal_probe(struct device *device)
 {
 	int ret;
 	struct bcm2835_mmal_dev *dev;
@@ -1896,7 +1897,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 						       &camera_instance);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
 		if (ret) {
-			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
+			dev_err(device, "%s: could not register V4L2 device: %d\n",
 				__func__, ret);
 			goto free_dev;
 		}
@@ -1976,7 +1977,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_mmal_remove(struct platform_device *pdev)
+static int bcm2835_mmal_remove(struct device *device)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1990,17 +1991,17 @@ static int bcm2835_mmal_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver bcm2835_camera_driver = {
-	.probe		= bcm2835_mmal_probe,
-	.remove		= bcm2835_mmal_remove,
-	.driver		= {
-		.name	= "bcm2835-camera",
-	},
+static struct vchiq_driver bcm2835_camera_driver = {
+	.driver = {
+		.name		= "bcm2835-camera",
+		.probe          = bcm2835_mmal_probe,
+		.remove         = bcm2835_mmal_remove,
+	}
 };
 
-module_platform_driver(bcm2835_camera_driver)
+module_vchiq_driver(bcm2835_camera_driver)
 
 MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bcm2835-camera");
+MODULE_ALIAS("bcm2835-camera");
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 22de23f3af02..4a57ff760106 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -12,6 +12,8 @@
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
@@ -34,6 +36,7 @@
 #include "vchiq_ioctl.h"
 #include "vchiq_arm.h"
 #include "vchiq_debugfs.h"
+#include "vchiq_device.h"
 #include "vchiq_connected.h"
 #include "vchiq_pagelist.h"
 
@@ -65,9 +68,6 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_camera;
-static struct platform_device *bcm2835_audio;
-
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
 	struct rpi_firmware *fw;
@@ -132,6 +132,11 @@ struct vchiq_pagelist_info {
 	unsigned int scatterlist_mapped;
 };
 
+static const char *const vchiq_devices[] = {
+	"bcm2835_audio",
+	"bcm2835-camera",
+};
+
 static void __iomem *g_regs;
 /* This value is the size of the L2 cache lines as understood by the
  * VPU firmware, which determines the required alignment of the
@@ -1763,33 +1768,13 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
-static struct platform_device *
-vchiq_register_child(struct platform_device *pdev, const char *name)
-{
-	struct platform_device_info pdevinfo;
-	struct platform_device *child;
-
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	pdevinfo.parent = &pdev->dev;
-	pdevinfo.name = name;
-	pdevinfo.id = PLATFORM_DEVID_NONE;
-	pdevinfo.dma_mask = DMA_BIT_MASK(32);
-
-	child = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(child)) {
-		dev_warn(&pdev->dev, "%s not registered\n", name);
-		child = NULL;
-	}
-
-	return child;
-}
 
 static int vchiq_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
+	unsigned int i;
 	int err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
@@ -1832,8 +1817,12 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	for (i = 0; i < ARRAY_SIZE(vchiq_devices); i++) {
+		err = vchiq_device_register(&pdev->dev, vchiq_devices[i]);
+		if (!err)
+			dev_err(&pdev->dev, "Failed to register %s vchiq device\n",
+				vchiq_devices[i]);
+	}
 
 	return 0;
 
@@ -1845,8 +1834,8 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
-	platform_device_unregister(bcm2835_camera);
+	bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_device_unregister);
+
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 
@@ -1866,6 +1855,12 @@ static int __init vchiq_driver_init(void)
 {
 	int ret;
 
+	ret = bus_register(&vchiq_bus_type);
+	if (ret) {
+		pr_err("Failed to register %s\n", vchiq_bus_type.name);
+		return ret;
+	}
+
 	ret = platform_driver_register(&vchiq_driver);
 	if (ret)
 		pr_err("Failed to register vchiq driver\n");
@@ -1876,6 +1871,7 @@ module_init(vchiq_driver_init);
 
 static void __exit vchiq_driver_exit(void)
 {
+	bus_unregister(&vchiq_bus_type);
 	platform_driver_unregister(&vchiq_driver);
 }
 module_exit(vchiq_driver_exit);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
new file mode 100644
index 000000000000..ec542d6bc68a
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * vchiq_device.c - VCHIQ generic device and bus-type
+ *
+ * Copyright (c) 2023 Ideas On Board Oy
+ */
+
+#include <linux/device/bus.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "vchiq_device.h"
+
+static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv);
+
+static ssize_t vchiq_dev_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct vchiq_device *device = container_of(dev, struct vchiq_device, dev);
+
+	return sprintf(buf, "%s", device->name);
+}
+
+static DEVICE_ATTR_RO(vchiq_dev);
+
+static struct attribute *vchiq_dev_attrs[] = {
+	&dev_attr_vchiq_dev.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(vchiq_dev);
+
+static const struct device_type vchiq_device_type = {
+	.groups         = vchiq_dev_groups
+};
+
+struct bus_type vchiq_bus_type = {
+	.name   = "vchiq-bus",
+	.match  = vchiq_bus_type_match,
+};
+EXPORT_SYMBOL_GPL(vchiq_bus_type);
+
+static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
+{
+	if (dev->bus == &vchiq_bus_type &&
+	    strcmp(dev_name(dev), drv->name) == 0)
+		return 1;
+	return 0;
+}
+
+static void vchiq_device_release(struct device *dev)
+{
+	struct vchiq_device *device;
+
+	device = container_of(dev, struct vchiq_device, dev);
+	kfree(device);
+}
+
+int vchiq_device_register(struct device *parent, const char *name)
+{
+	struct vchiq_device *device = NULL;
+	int ret;
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	device->name = name;
+	device->dev.init_name = name;
+	device->dev.parent = parent;
+	device->dev.bus = &vchiq_bus_type;
+	device->dev.type = &vchiq_device_type;
+	device->dev.release = vchiq_device_release;
+
+	ret = device_register(&device->dev);
+	if (ret) {
+		put_device(&device->dev);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vchiq_device_unregister(struct device *dev, void *data)
+{
+	device_unregister(dev);
+	return 0;
+}
+
+int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
+{
+	vchiq_drv->driver.bus = &vchiq_bus_type;
+
+	return driver_register(&vchiq_drv->driver);
+}
+EXPORT_SYMBOL_GPL(vchiq_driver_register);
+
+void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
+{
+	driver_unregister(&vchiq_drv->driver);
+}
+EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
new file mode 100644
index 000000000000..0848c1b353f8
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (c) 2023 Ideas On Board Oy
+ */
+
+#ifndef _VCHIQ_DEVICE_H
+#define _VCHIQ_DEVICE_H
+
+#include <linux/device.h>
+
+struct vchiq_device {
+	struct device dev;
+	const char *name;
+};
+
+struct vchiq_driver {
+	struct device_driver driver;
+};
+
+extern struct bus_type vchiq_bus_type;
+
+int vchiq_device_register(struct device *parent, const char *name);
+int vchiq_device_unregister(struct device *dev, void *data);
+
+int vchiq_driver_register(struct vchiq_driver *vchiq_drv);
+void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv);
+
+/**
+ * module_vchiq_driver() - Helper macro for registering a vchiq driver
+ * @__vchiq_driver: vchiq driver struct
+ *
+ * Helper macro for vchiq drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_vchiq_driver(__vchiq_driver) \
+	module_driver(__vchiq_driver, vchiq_driver_register, vchiq_driver_unregister)
+
+#endif /* _VCHIQ_DEVICE_H */
-- 
2.39.0

