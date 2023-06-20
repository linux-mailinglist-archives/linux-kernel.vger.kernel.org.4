Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7C2736D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjFTNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:42:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11689FC;
        Tue, 20 Jun 2023 06:42:09 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.208])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 961DF10FE;
        Tue, 20 Jun 2023 15:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687268492;
        bh=4Opy9JNP6yhn8dEbnCMRAYK1fj5QLoYxKBNJrSXUikk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUXktzVsgil2KJP40ehE291yMhz6ihfPBUgOo+8d+Nq/ompx+sVIWaPJKek+EMDfc
         Sj4hUFHBYf9dHDI1TcCwMulmot3aShQACzxcrigbQGURlaVE7XGemn/49q9m4xhIFD
         LRn9PxBYeNWtxkbittG3Pcra6ighZVQdVcmsfZd8=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v7 1/5] staging: vc04_services: vchiq_arm: Add new bus type and device type
Date:   Tue, 20 Jun 2023 19:11:48 +0530
Message-Id: <20230620134152.383569-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620134152.383569-1-umang.jain@ideasonboard.com>
References: <20230620134152.383569-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
which will be used to migrate child devices that the vchiq interfaces
creates/registers from the platform device/driver.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/Makefile        |  1 +
 .../interface/vchiq_arm/vchiq_device.c        | 78 +++++++++++++++++++
 .../interface/vchiq_arm/vchiq_device.h        | 43 ++++++++++
 3 files changed, 122 insertions(+)
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
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
new file mode 100644
index 000000000000..e16279a25126
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
@@ -0,0 +1,78 @@
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
+struct bus_type vchiq_bus_type = {
+	.name   = "vchiq-bus",
+	.match  = vchiq_bus_type_match,
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
+	device->dev.init_name = name;
+	device->dev.parent = parent;
+	device->dev.bus = &vchiq_bus_type;
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
index 000000000000..55d242b230f9
--- /dev/null
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
@@ -0,0 +1,43 @@
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
+};
+
+struct vchiq_driver {
+        int                     (*probe)(struct vchiq_device *device);
+        void                    (*remove)(struct vchiq_device *device);
+        int                     (*resume)(struct vchiq_device *device);
+        int                     (*suspend)(struct vchiq_device *device,
+					   pm_message_t state);
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
2.39.1

