Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1ED6656B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjAKJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjAKJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:00:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150D10543;
        Wed, 11 Jan 2023 01:00:47 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.160])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20AD94DD;
        Wed, 11 Jan 2023 10:00:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673427644;
        bh=6utlnJ0X357mXlWi4vYGrJ90fkrktyuUMLiI+aAF0s8=;
        h=From:To:Cc:Subject:Date:From;
        b=gXQc6yeDEQOBDENSRg364LYOSvvmASshIFRQQeU7G3cye7JTRvYJDORv8yBeLLwup
         DPayAxNBHvoaPJoZZqDWn6Tg/DivHerudOjPTFF/i9Tan1u2VoZLTTI/g5bOwfD7my
         AaXg01HJI89iEM5hkXmhbr6tsUuCWOsMLfzBaYM4=
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
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Wed, 11 Jan 2023 14:30:29 +0530
Message-Id: <20230111090029.250884-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.0
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

The devices that the vchiq interface registers(bcm2835-audio,
bcm2835-camera) are implemented and exposed by the VC04 firmware.
The device tree describes the VC04 itself with the resources
required to communicate with it through a mailbox interface. However,
the vchiq interface registers these devices as platform devices. This
also means the specific drivers for these devices are also getting
registered as platform drivers. This is not correct and a blatant
abuse of platform device/driver.

Replace the platform device/driver model with a standard device driver
model. A custom bus_type, vchiq_bus_type, is created in the vchiq
interface which matches the devices to their specific device drivers
thereby, establishing driver binding. A struct vchiq_device wraps the
struct device for each device being registered on the bus by the vchiq
interface.

Each device registered will expose a 'name' read-only device attribute
in sysfs (/sys/bus/vchiq-bus/devices). New devices and drivers can be
added by registering on vchiq_bus_type and adding a corresponding
device name entry in the static list of devices, vchiq_devices. There
is currently no way to enumerate the VCHIQ devices that are available
from the firmware.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
Changes in v3:
- Rework entirely to replace platform devices/driver model

-v2:
https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/

-v1:
https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/

- Developed on top of:
[PATCH v3 0/7] staging: vc04_services: Remove custom return values

---
 .../vc04_services/bcm2835-audio/Makefile      |   5 +-
 .../vc04_services/bcm2835-audio/bcm2835.c     |  19 ++-
 .../vc04_services/bcm2835-camera/Makefile     |   2 +
 .../bcm2835-camera/bcm2835-camera.c           |  17 ++-
 .../interface/vchiq_arm/vchiq_arm.c           | 121 +++++++++++++++---
 .../interface/vchiq_arm/vchiq_arm.h           |   1 +
 6 files changed, 123 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
index d59fe4dde615..4801467be58a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
+++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
@@ -2,4 +2,7 @@
 obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
 snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
 
-ccflags-y += -I $(srctree)/$(src)/../include -D__VCCOREVER__=0x04000000
+ccflags-y += \
+	-I $(srctree)/$(src)/../include \
+	-I $(srctree)/$(src)/../interface/vchiq_arm \
+	-D__VCCOREVER__=0x04000000
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 00bc898b0189..572038ab57dc 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -1,13 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
 #include "bcm2835.h"
+#include "vchiq_arm.h"
 
 static bool enable_hdmi;
 static bool enable_headphones = true;
@@ -268,9 +267,8 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct device *dev)
 {
-	struct device *dev = &pdev->dev;
 	int err;
 
 	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
@@ -292,30 +290,29 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 
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
+static struct device_driver bcm2835_alsa_driver = {
 	.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
 	.suspend = snd_bcm2835_alsa_suspend,
 	.resume = snd_bcm2835_alsa_resume,
 #endif
-	.driver = {
-		.name = "bcm2835_audio",
-	},
+	.name = "bcm2835_audio",
+	.bus = &vchiq_bus_type,
 };
-module_platform_driver(bcm2835_alsa_driver);
+module_driver(bcm2835_alsa_driver, driver_register, driver_unregister);
 
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
diff --git a/drivers/staging/vc04_services/bcm2835-camera/Makefile b/drivers/staging/vc04_services/bcm2835-camera/Makefile
index 3a76d6ade428..4236c044390c 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/Makefile
+++ b/drivers/staging/vc04_services/bcm2835-camera/Makefile
@@ -8,4 +8,6 @@ obj-$(CONFIG_VIDEO_BCM2835) += bcm2835-v4l2.o
 ccflags-y += \
 	-I $(srctree)/$(src)/.. \
 	-I $(srctree)/$(src)/../vchiq-mmal/ \
+	-I$(srctree)/$(src)/../interface/vchiq_arm \
+	-I$(srctree)/$(src)/../include \
 	-D__VCCOREVER__=0x04000000
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 797ebe2a973a..8a74fa8304a9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -24,7 +24,6 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-common.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 
 #include "mmal-common.h"
 #include "mmal-encodings.h"
@@ -32,6 +31,7 @@
 #include "mmal-msg.h"
 #include "mmal-parameters.h"
 #include "bcm2835-camera.h"
+#include "vchiq_arm.h"
 
 #define MIN_WIDTH 32
 #define MIN_HEIGHT 32
@@ -1841,7 +1841,7 @@ static struct v4l2_format default_v4l2_format = {
 	.fmt.pix.sizeimage = 1024 * 768,
 };
 
-static int bcm2835_mmal_probe(struct platform_device *pdev)
+static int bcm2835_mmal_probe(struct device *device)
 {
 	int ret;
 	struct bcm2835_mmal_dev *dev;
@@ -1896,7 +1896,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 						       &camera_instance);
 		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
 		if (ret) {
-			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
+			dev_err(device, "%s: could not register V4L2 device: %d\n",
 				__func__, ret);
 			goto free_dev;
 		}
@@ -1976,7 +1976,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm2835_mmal_remove(struct platform_device *pdev)
+static int bcm2835_mmal_remove(struct device *device)
 {
 	int camera;
 	struct vchiq_mmal_instance *instance = gdev[0]->instance;
@@ -1990,15 +1990,14 @@ static int bcm2835_mmal_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver bcm2835_camera_driver = {
+static struct device_driver bcm2835_camera_driver = {
+	.name		= "bcm2835-camera",
 	.probe		= bcm2835_mmal_probe,
 	.remove		= bcm2835_mmal_remove,
-	.driver		= {
-		.name	= "bcm2835-camera",
-	},
+	.bus		= &vchiq_bus_type,
 };
 
-module_platform_driver(bcm2835_camera_driver)
+module_driver(bcm2835_camera_driver, driver_register, driver_unregister)
 
 MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
 MODULE_AUTHOR("Vincent Sanders");
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 22de23f3af02..86c8e5df7cf6 100644
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
@@ -65,9 +67,6 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_camera;
-static struct platform_device *bcm2835_audio;
-
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
 	struct rpi_firmware *fw;
@@ -132,6 +131,51 @@ struct vchiq_pagelist_info {
 	unsigned int scatterlist_mapped;
 };
 
+struct vchiq_device {
+	const char *name;
+	struct device dev;
+};
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
+static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
+{
+	if (dev->bus == &vchiq_bus_type &&
+	    strcmp(dev_name(dev), drv->name) == 0)
+		return 1;
+	return 0;
+}
+
+struct bus_type vchiq_bus_type = {
+	.name   = "vchiq-bus",
+	.match  = vchiq_bus_type_match,
+};
+EXPORT_SYMBOL(vchiq_bus_type);
+
+static const char *const vchiq_devices[] = {
+	"bcm2835_audio",
+	"bcm2835-camera",
+};
+
 static void __iomem *g_regs;
 /* This value is the size of the L2 cache lines as understood by the
  * VPU firmware, which determines the required alignment of the
@@ -1763,26 +1807,52 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
-static struct platform_device *
+static void
+vchiq_release_device(struct device *dev)
+{
+	struct vchiq_device *device;
+
+	device = container_of(dev, struct vchiq_device, dev);
+	kfree(device);
+}
+
+static int
 vchiq_register_child(struct platform_device *pdev, const char *name)
 {
-	struct platform_device_info pdevinfo;
-	struct platform_device *child;
+	struct vchiq_device *device = NULL;
+	int ret;
 
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
 
-	pdevinfo.parent = &pdev->dev;
-	pdevinfo.name = name;
-	pdevinfo.id = PLATFORM_DEVID_NONE;
-	pdevinfo.dma_mask = DMA_BIT_MASK(32);
+	device->name = name;
+	device->dev.init_name = name;
+	device->dev.parent = &pdev->dev;
+	device->dev.bus = &vchiq_bus_type;
+	device->dev.type = &vchiq_device_type;
+	device->dev.release = vchiq_release_device;
+
+	ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		vchiq_release_device(&device->dev);
+		return ret;
+	}
 
-	child = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(child)) {
-		dev_warn(&pdev->dev, "%s not registered\n", name);
-		child = NULL;
+	ret = device_register(&device->dev);
+	if (ret) {
+		put_device(&device->dev);
+		return -EINVAL;
 	}
 
-	return child;
+	return 0;
+}
+
+static int
+vchiq_unregister_child(struct device *dev, void *data)
+{
+	device_unregister(dev);
+	return 0;
 }
 
 static int vchiq_probe(struct platform_device *pdev)
@@ -1790,7 +1860,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
-	int err;
+	int i, err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
 	drvdata = (struct vchiq_drvdata *)of_id->data;
@@ -1832,8 +1902,12 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	for (i = 0; i < ARRAY_SIZE(vchiq_devices); i++) {
+		err = vchiq_register_child(pdev, vchiq_devices[i]);
+		if (!err)
+			dev_err(&pdev->dev, "Failed to register %s vchiq device\n",
+				vchiq_devices[i]);
+	}
 
 	return 0;
 
@@ -1845,8 +1919,8 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
-	platform_device_unregister(bcm2835_camera);
+	bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_unregister_child);
+
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 
@@ -1866,6 +1940,10 @@ static int __init vchiq_driver_init(void)
 {
 	int ret;
 
+	ret = bus_register(&vchiq_bus_type);
+	if (ret)
+		pr_err("Failed to register %s\n", vchiq_bus_type.name);
+
 	ret = platform_driver_register(&vchiq_driver);
 	if (ret)
 		pr_err("Failed to register vchiq driver\n");
@@ -1876,6 +1954,7 @@ module_init(vchiq_driver_init);
 
 static void __exit vchiq_driver_exit(void)
 {
+	bus_unregister(&vchiq_bus_type);
 	platform_driver_unregister(&vchiq_driver);
 }
 module_exit(vchiq_driver_exit);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index 2fb31f9b527f..98c3af32774a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -81,6 +81,7 @@ extern int vchiq_susp_log_level;
 
 extern spinlock_t msg_queue_spinlock;
 extern struct vchiq_state g_state;
+extern struct bus_type vchiq_bus_type;
 
 extern struct vchiq_state *
 vchiq_get_state(void);
-- 
2.39.0

