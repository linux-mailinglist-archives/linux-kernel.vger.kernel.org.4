Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256C6FE258
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjEJQYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjEJQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:23:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805C7ED4;
        Wed, 10 May 2023 09:22:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50b37f3e664so13224175a12.1;
        Wed, 10 May 2023 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735777; x=1686327777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHI30Q2RD/vYYr55KU45GDr+Oc48RdK1ZLccMHmNqZc=;
        b=j3n/1o9Rzo35zGP8RtRTWMb39KJQSoN4Iw4YiFgxSmSVdwnEL2kdSB/Rr6YVTZ1y6b
         m6SKUTESxLSUxlIYwbAaGxTxqob2CVLpT1h3U9/sKOOfcVkxFc/NiVawv/B0wPp+nY52
         7ir/3/H3DECgdP9Xk1MG6EqJcLskgE6e6rzV3WT1pD0vofgqwB9729ce/GPm/g1AXcQ2
         MY0/v+OFdUEMaHaSBKUtjews64+HUUbq3dt9rUH/r6wXf9OsJM85rM+k72UnhLExWIl9
         BklRVYp6xqe4wfuDpybSFiLZiCm3V5rzcq3HvXdaSHsM3RgcCTfFHYueDi1c4vEeY/mj
         EE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735777; x=1686327777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHI30Q2RD/vYYr55KU45GDr+Oc48RdK1ZLccMHmNqZc=;
        b=j4uWoDgGOsCX2JzMLsgOM6j7mhRXJWKm1xpWuU+Xlt5Hkew8RVK+pu3EIvTQ261MKW
         5wO5Z6SiclgAHrD2fuXDVM7VcHVKnNA3izXrdzSBgqJov1DbCpr9JIQ2wssFqEITbzBM
         jR6IsvS2HB5iMgTt2u0MFKEv/JKCwAGIKnyrCR2NTAVtIXZ52d7TubIOCWN+ASE2S4B6
         /Xpg1Y/cSKaS+g3+nwbC/LpBPbsOlGJYDi+WZPgETGHxF6ZmLoPVkug2g2xLExrKFwtm
         ipNxDsALb7nECD98Jw9gIRQqEu22sCC0+8I+XF2cDznsn3wOQmgEeK5BvDCuQTSbErmO
         xAnw==
X-Gm-Message-State: AC+VfDwrrRsSDduHeJoDQJ9E8nC52G2frCEyG7QGZ76sLPx+DtQ8zxCl
        89gXQkzm6UtEAxSGoU7gEGVAtAEkZEa6g+vd
X-Google-Smtp-Source: ACHHUZ6aOVzKGpj8F4/SyByhfTiSLeLHblyyNZ0RpRmW9xTUshppvwD2f6ifJh2QT+U+snfww/vCdQ==
X-Received: by 2002:a17:907:806:b0:953:47fc:3f0b with SMTP id wv6-20020a170907080600b0095347fc3f0bmr14317315ejb.53.1683735776304;
        Wed, 10 May 2023 09:22:56 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id m28-20020a17090677dc00b00947ed087a2csm2890149ejn.154.2023.05.10.09.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:22:55 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        beanhuo@micron.com, nipun.gupta@amd.com, linus.walleij@linaro.org,
        mwen@igalia.com, bvanassche@acm.org, arnd@arndb.de,
        ogabbay@kernel.org, linux@zary.sk,
        jacek.lawrynowicz@linux.intel.com, geert+renesas@glider.be,
        benjamin.tissoires@redhat.com, masahiroy@kernel.org,
        yangyicong@hisilicon.com, devicetree@vger.kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv4 2/4] wiegand: add Wiegand bus driver
Date:   Wed, 10 May 2023 18:22:41 +0200
Message-Id: <20230510162243.95820-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510162243.95820-1-m.zatovic1@gmail.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bus driver for Wiegand protocol. The bus driver handles
Wiegand controller and Wiegand device managemement and driver
matching. The bus driver defines the structures for Wiegand
controllers and Wiegand devices.

Wiegand controller structure represents a master and contains
attributes such as the payload_len for configuring the size
of a single Wiegand message in bits. It also stores the
controller attributes defined in the devicetree.

Each Wiegand controller should be associated with one Wiegand
device, as Wiegand is typically a point-to-point bus.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 MAINTAINERS               |   2 +
 drivers/Kconfig           |   2 +
 drivers/Makefile          |   1 +
 drivers/wiegand/Kconfig   |  20 ++
 drivers/wiegand/Makefile  |   1 +
 drivers/wiegand/wiegand.c | 609 ++++++++++++++++++++++++++++++++++++++
 include/linux/wiegand.h   | 144 +++++++++
 7 files changed, 779 insertions(+)
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55602888f084..7b7e546572e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22701,6 +22701,8 @@ WIEGAND BUS DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+F:	drivers/wiegand/wiegand.c
+F:	include/linux/wiegand.h
 
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..6609dfd6635f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -145,6 +145,8 @@ source "drivers/vdpa/Kconfig"
 
 source "drivers/vhost/Kconfig"
 
+source "drivers/wiegand/Kconfig"
+
 source "drivers/hv/Kconfig"
 
 source "drivers/xen/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 7241d80a7b29..f53f0d83195b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
+obj-$(CONFIG_WIEGAND)           += wiegand/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_STAGING)		+= staging/
diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
new file mode 100644
index 000000000000..fc99575bc3cc
--- /dev/null
+++ b/drivers/wiegand/Kconfig
@@ -0,0 +1,20 @@
+config WIEGAND
+        tristate "Wiegand Bus driver"
+        help
+	  The "Wiegand Interface" is an asynchronous low-level protocol
+	  or wiring standard. It is typically used for point-to-point
+	  communication. The data length of Wiegand messages is not defined,
+	  so the devices usually default to 26, 36 or 37 bits per message.
+	  The throughput of Wiegand depends on the selected pulse length and
+	  the intervals between pulses, in comparison to other busses it
+	  is generally rather slow.
+
+	  Despite its higher age, Wiegand remains widely used in access
+	  control systems to connect a card swipe mechanism. Such mechanisms
+	  utilize the Wiegand effect to transfer data from the card to
+	  the reader.
+
+	  Wiegand uses two wires to transmit the data D0 and D1. Both lines
+	  are initially pulled up. When a bit of value 0 is being transmitted,
+	  the D0 line is pulled down. Similarly, when a bit of value 1 is being
+	  transmitted, the D1 line is pulled down.
diff --git a/drivers/wiegand/Makefile b/drivers/wiegand/Makefile
new file mode 100644
index 000000000000..d17ecb722c6e
--- /dev/null
+++ b/drivers/wiegand/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_WIEGAND)			+= wiegand.o
diff --git a/drivers/wiegand/wiegand.c b/drivers/wiegand/wiegand.c
new file mode 100644
index 000000000000..f82091d251d0
--- /dev/null
+++ b/drivers/wiegand/wiegand.c
@@ -0,0 +1,609 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+
+static struct bus_type wiegand_bus_type;
+
+/**
+ * struct wiegand_device - Wiegand listener device
+ * @dev - drivers structure of the device
+ * @id - unique device id
+ * @controller - Wiegand controller associated with the device
+ * @modalias - Name of the driver to use with this device, or its alias.
+ */
+struct wiegand_device {
+	struct device dev;
+	u8 id;
+	struct wiegand_controller *controller;
+	char modalias[WIEGAND_NAME_SIZE];
+};
+
+DEFINE_IDA(wiegand_controller_ida);
+
+static inline void wiegand_device_put(struct wiegand_device *wiegand);
+static inline struct wiegand_device *to_wiegand_device(struct device *dev);
+
+static int wiegand_fopen(struct inode *ino, struct file *filp);
+static int wiegand_frelease(struct inode *ino, struct file *filp);
+static ssize_t wiegand_fwrite(struct file *filp, char __user const *buf, size_t len,
+				loff_t *offset);
+
+/**
+ * wiegand_controller_release - called after the final refererence decrement
+ * @dev: the controller device
+ */
+static void wiegand_controller_release(struct device *dev)
+{
+	struct wiegand_controller *ctlr;
+
+	ctlr = container_of(dev, struct wiegand_controller, dev);
+	kfree(ctlr);
+}
+
+/**
+ * wiegand_alloc_controller - allocate a new Wiegand controller
+ * @dev: the controller device
+ * @size: size of the private data to be allocated for the caller
+ * @secondary: true if the controller is a secondary controller(reads data)
+ *
+ * This function is only by Wiegand controller drivers to allocate a new Wiegand controller
+ * structure before registering it using wiegand_register_controller().
+ */
+struct wiegand_controller *wiegand_alloc_controller(struct device *dev, unsigned int size,
+						bool secondary)
+{
+	struct wiegand_controller *ctlr;
+	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
+
+	if (!dev)
+		return NULL;
+
+	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);
+	if (!ctlr)
+		return NULL;
+
+	device_initialize(&ctlr->dev);
+
+	ctlr->bus_num = -1;
+	ctlr->secondary = secondary;
+	ctlr->dev.parent = dev;
+	ctlr->dev.release = wiegand_controller_release;
+
+	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(wiegand_alloc_controller);
+
+static void devm_wiegand_release_controller(struct device *dev, void *ctlr)
+{
+	wiegand_controller_put(*(struct wiegand_controller **)ctlr);
+}
+
+/**
+ * devm_wiegand_alloc_controller - device managed allocation of a new Wiegand controller
+ * @dev: physical device of Wiegand controller
+ * @size: size of the private data to be allocated for the caller
+ * @secondary: true if the controller is a secondary controller(reads data)
+ *
+ * Device managed version of wiegand_alloc_controller(). The Wiegand controller is automatically
+ * freed on driver detach.
+ */
+struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
+							bool secondary)
+{
+	struct wiegand_controller *ctlr, **ptr;
+
+	ptr = devres_alloc(devm_wiegand_release_controller, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	ctlr = wiegand_alloc_controller(dev, size, secondary);
+	if (ctlr) {
+		ctlr->devm_allocated = true;
+		*ptr = ctlr;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(devm_wiegand_alloc_controller);
+
+static int wiegand_controller_check_ops(struct wiegand_controller *ctlr)
+{
+	if (!ctlr->transfer_message)
+		return -EINVAL;
+	return 0;
+}
+
+/**
+ * register_wiegand_device - allocates and registers a new Wiegand device
+ * @ctlr: controller structure to attach device to
+ * @nc: devicetree node for the device
+ */
+static struct wiegand_device *register_wiegand_device(struct wiegand_controller *ctlr,
+							struct fwnode_handle *fwnode)
+{
+	struct wiegand_device *wiegand;
+	int ret;
+
+	wiegand = wiegand_alloc_device(ctlr);
+	if (!wiegand) {
+		dev_err(&ctlr->dev, "wiegad_device alloc error for %pOF\n", fwnode);
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	fwnode_handle_get(fwnode);
+	wiegand->dev.fwnode = fwnode;
+
+	ret = wiegand_add_device(wiegand);
+	if (ret) {
+		dev_err(&ctlr->dev, "wiegand_device register error %pOF\n", fwnode);
+		goto err_node_put;
+	}
+
+	/* check if more devices are connected to the bus */
+	if (ctlr->device_count > 1)
+		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
+
+	return wiegand;
+
+err_node_put:
+	fwnode_handle_put(fwnode);
+err_out:
+	wiegand_device_put(wiegand);
+	return ERR_PTR(ret);
+}
+
+static void register_wiegand_devices(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+	struct fwnode_handle *fwnode;
+
+	if (!ctlr->dev.fwnode)
+		return;
+
+	fwnode_for_each_available_child_node(ctlr->dev.fwnode, fwnode) {
+		wiegand = register_wiegand_device(ctlr, fwnode);
+		if (IS_ERR(wiegand))
+			dev_warn(&ctlr->dev, "failed to create wiegand device for %pOF\n", fwnode);
+	}
+}
+
+static void wiegand_controller_parse_property(struct device *dev, const char *prop_name,
+				       u32 *cur_val_p, u32 def_val, bool use_def)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, prop_name, cur_val_p);
+	if ((ret && use_def) || *cur_val_p == 0)
+		*cur_val_p = def_val;
+
+	dev_dbg(dev, "%s: %u\n", prop_name, *cur_val_p);
+}
+
+#define USE_DEFAULT_VAL 1
+
+static void wiegand_controller_parse_properties(struct wiegand_controller *ctlr)
+{
+	wiegand_controller_parse_property(&ctlr->dev, "pulse-len-us", &ctlr->pulse_len,
+					  50, USE_DEFAULT_VAL);
+	wiegand_controller_parse_property(&ctlr->dev, "interval-len-us", &ctlr->interval_len,
+					  2000, USE_DEFAULT_VAL);
+	wiegand_controller_parse_property(&ctlr->dev, "frame-gap-us", &ctlr->frame_gap,
+					  2000, USE_DEFAULT_VAL);
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	wiegand_unregister_device(to_wiegand_device(dev));
+	return 0;
+}
+
+/**
+ * wiegand_unregister_controller - unregisters controller structure within Wiegand bus
+ *
+ * @ptr pointer to a wiegand_controller structure
+ *
+ * Frees all resources allocated by the wiegand_register_controller() function.
+ * If the controller was registered using devm_wiegand_alloc_controller() then
+ * this function is called automatically on driver detach.Otherwise the function needs
+ * to be called manually. If controller is not devm managed, then the reference to the
+ * controller structure is put.
+ */
+void wiegand_unregister_controller(void *ptr)
+{
+	struct wiegand_controller *ctlr = ptr;
+	unsigned int id = ctlr->bus_num;
+
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
+	ida_free(&wiegand_controller_ida, id);
+	device_del(&ctlr->dev);
+
+	kfree(ctlr->miscdev.name);
+	misc_deregister(&ctlr->miscdev);
+
+	if (!ctlr->devm_allocated)
+		put_device(&ctlr->dev);
+}
+EXPORT_SYMBOL_GPL(wiegand_unregister_controller);
+
+/**
+ * wiegand_register_controller - registers controller structure within bus
+ * @ctlr: controller structure to register
+ *
+ * Function checks that the message transfer functions is defined for passed controller structure,
+ * gets its attributes and finally adds the controller device and registers the controller on the
+ * bus.
+ */
+int wiegand_register_controller(struct wiegand_controller *ctlr)
+{
+	struct device *dev = ctlr->dev.parent;
+	int status, id;
+
+	if (!dev)
+		return -ENODEV;
+
+	status = wiegand_controller_check_ops(ctlr);
+	if (status)
+		return status;
+
+	id = ida_alloc(&wiegand_controller_ida, GFP_KERNEL);
+	if (WARN(id < 0, "couldn't get an id\n"))
+		return id;
+	ctlr->bus_num = id;
+
+	wiegand_controller_parse_properties(ctlr);
+
+	dev_set_name(&ctlr->dev, "wiegand%u", ctlr->bus_num);
+	ctlr->miscdev.name = kasprintf(GFP_KERNEL, "wiegand1");
+	if (!ctlr->miscdev.name)
+		return -ENOMEM;
+
+	ctlr->fops.owner = THIS_MODULE;
+	ctlr->fops.open = wiegand_fopen;
+	ctlr->fops.release = wiegand_frelease;
+	ctlr->fops.write = wiegand_fwrite;
+	ctlr->miscdev.fops = &ctlr->fops;
+	ctlr->miscdev.minor = MISC_DYNAMIC_MINOR;
+
+	status = misc_register(&ctlr->miscdev);
+	if (status) {
+		dev_err(&ctlr->dev, "couldn't register misc device\n");
+		return status;
+	}
+
+	mutex_init(&ctlr->file_lock);
+
+	status = device_add(&ctlr->dev);
+	if (status < 0)
+		goto free_bus_id;
+
+	ctlr->device_count = 0;
+	ctlr->miscdev.parent = &ctlr->dev;
+	register_wiegand_devices(ctlr);
+
+	return status;
+
+free_bus_id:
+	ida_free(&wiegand_controller_ida, ctlr->bus_num);
+	misc_deregister(&ctlr->miscdev);
+	kfree(ctlr->miscdev.name);
+	return status;
+}
+EXPORT_SYMBOL_GPL(wiegand_register_controller);
+
+int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr)
+{
+	int ret;
+
+	ret = wiegand_register_controller(ctlr);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(dev, wiegand_unregister_controller, ctlr);
+}
+EXPORT_SYMBOL_GPL(devm_wiegand_register_controller);
+
+/* Device section */
+
+static inline struct wiegand_device *to_wiegand_device(struct device *dev)
+{
+	return dev ? container_of(dev, struct wiegand_device, dev) : NULL;
+}
+
+struct wiegand_controller *wiegand_device_get_controller(struct wiegand_device *dev)
+{
+	return dev->controller;
+}
+EXPORT_SYMBOL_GPL(wiegand_device_get_controller);
+
+static inline void wiegand_device_put(struct wiegand_device *wiegand)
+{
+	if (wiegand)
+		put_device(&wiegand->dev);
+
+	if (wiegand->controller->cleanup)
+		wiegand->controller->cleanup(wiegand);
+}
+
+/**
+ * wiegand_dev_release - called after the final reference count decrement
+ * @dev: device to release
+ */
+static void wiegand_dev_release(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+
+	wiegand_controller_put(wiegand->controller);
+	kfree(wiegand);
+}
+
+struct wiegand_device *wiegand_alloc_device(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+
+	wiegand = kzalloc(sizeof(*wiegand), GFP_KERNEL);
+	if (!wiegand) {
+		wiegand_controller_put(ctlr);
+		return NULL;
+	}
+
+	wiegand->controller = ctlr;
+	wiegand->dev.parent = &ctlr->dev;
+	wiegand->dev.bus = &wiegand_bus_type;
+	wiegand->dev.release = wiegand_dev_release;
+
+	device_initialize(&wiegand->dev);
+	return wiegand;
+}
+EXPORT_SYMBOL_GPL(wiegand_alloc_device);
+
+static void wiegand_cleanup(struct wiegand_device *wiegand)
+{
+	if (wiegand->controller->cleanup)
+		wiegand->controller->cleanup(wiegand);
+}
+
+static int wiegand_dev_set_name(struct wiegand_device *wiegand, u8 id)
+{
+	int ret = dev_set_name(&wiegand->dev, "%s.%u", dev_name(&wiegand->controller->dev), id);
+	return ret;
+}
+
+static int __wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	struct device *dev = ctlr->dev.parent;
+	int status;
+
+	status = wiegand_setup(wiegand);
+	if (status < 0) {
+		dev_err(dev, "can't setup %s, status %d\n",
+			dev_name(&wiegand->dev), status);
+		return status;
+	}
+
+	status = device_add(&wiegand->dev);
+	if (status < 0) {
+		dev_err(dev, "can't add %s, status %d\n", dev_name(&wiegand->dev), status);
+		wiegand_cleanup(wiegand);
+	} else {
+		dev_dbg(dev, "registered child %s\n", dev_name(&wiegand->dev));
+	}
+
+	return status;
+}
+
+int wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	int status;
+
+	status = wiegand_dev_set_name(wiegand, ctlr->device_count);
+	if (status)
+		return status;
+
+	status = __wiegand_add_device(wiegand);
+	if (!status) {
+		ctlr->device_count++;
+		wiegand->id = wiegand->controller->device_count;
+	}
+
+	return status;
+}
+
+int wiegand_setup(struct wiegand_device *wiegand)
+{
+	int status = 0;
+
+	if (wiegand->controller->setup) {
+		status = wiegand->controller->setup(wiegand);
+		if (status) {
+			dev_err(&wiegand->controller->dev, "failed to setup device: %d\n", status);
+			return status;
+		}
+	}
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(wiegand_setup);
+
+void wiegand_unregister_device(struct wiegand_device *wiegand)
+{
+	if (!wiegand)
+		return;
+
+	if (wiegand->dev.fwnode)
+		fwnode_handle_put(wiegand->dev.fwnode);
+
+	fwnode_remove_software_node(wiegand->dev.fwnode);
+	device_del(&wiegand->dev);
+	wiegand_cleanup(wiegand);
+	put_device(&wiegand->dev);
+}
+EXPORT_SYMBOL_GPL(wiegand_unregister_device);
+
+int wiegand_send_message(struct wiegand_device *wiegand, unsigned long *msg_bmp, u8 bitlen)
+{
+	struct wiegand_primary *primary = wiegand->controller;
+
+	if (msg_bmp == NULL)
+		return -EINVAL;
+
+	if (primary->transfer_message)
+		primary->transfer_message(primary);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wiegand_send_message);
+
+static ssize_t wiegand_get_user_data(struct wiegand_controller *ctlr, char __user const *buf,
+					  size_t len)
+{
+	int i;
+	char data_buffer[WIEGAND_MAX_PAYLEN_BYTES];
+
+	if (len > WIEGAND_MAX_PAYLEN_BYTES)
+		return -EBADMSG;
+
+	if (copy_from_user(&data_buffer[0], buf, WIEGAND_MAX_PAYLEN_BYTES))
+		return -EFAULT;
+
+	for (i = 0; i < len; i++)
+		bitmap_set_value8(ctlr->data_bitmap, data_buffer[i], i * 8);
+
+	return len;
+}
+
+static int wiegand_frelease(struct inode *ino, struct file *filp)
+{
+	struct wiegand_controller *ctlr = filp->private_data;
+
+	mutex_destroy(&ctlr->file_lock);
+	return 0;
+}
+
+static ssize_t wiegand_fwrite(struct file *filp, char __user const *buf, size_t len,
+				loff_t *offset)
+{
+	int ret;
+	struct wiegand_controller *ctlr = filp->private_data;
+	u32 msg_length = ctlr->payload_len;
+
+	if (!buf || len == 0 || DIV_ROUND_UP(msg_length, 8) > len)
+		return -EINVAL;
+
+	ret = wiegand_get_user_data(ctlr, buf, len);
+	if (ret < 0)
+		return ret;
+
+	ctlr->transfer_message(ctlr);
+
+	return len;
+}
+
+static int wiegand_fopen(struct inode *ino, struct file *filp)
+{
+	int ret;
+	struct wiegand_controller *ctlr = container_of(filp->f_op, struct wiegand_controller, fops);
+
+	filp->private_data = ctlr;
+
+	mutex_lock(&ctlr->file_lock);
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
+		dev_err(ctlr->miscdev.this_device, "device is write only\n");
+		ret = -EIO;
+		goto err;
+	}
+
+	mutex_unlock(&ctlr->file_lock);
+
+	return 0;
+err:
+	mutex_unlock(&ctlr->file_lock);
+	mutex_destroy(&ctlr->file_lock);
+	return ret;
+}
+
+static int wiegand_match_device(struct device *dev, struct device_driver *drv)
+{
+	struct wiegand_device *wiegand_dev = to_wiegand_device(dev);
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return (strcmp(wiegand_dev->modalias, drv->name) == 0);
+}
+
+static int wiegand_probe(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+
+	if (wdrv->probe)
+		return wdrv->probe(wiegand);
+
+	return 0;
+}
+
+static void wiegand_remove(struct device *dev)
+{
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+
+	if (wdrv->remove)
+		wdrv->remove(to_wiegand_device(dev));
+}
+
+static struct bus_type wiegand_bus_type = {
+	.name		= "wiegand",
+	.match		= wiegand_match_device,
+	.probe		= wiegand_probe,
+	.remove		= wiegand_remove,
+};
+
+int __wiegand_register_driver(struct module *owner, struct wiegand_driver *wdrv)
+{
+	wdrv->driver.owner = owner;
+	wdrv->driver.bus = &wiegand_bus_type;
+
+	return driver_register(&wdrv->driver);
+}
+EXPORT_SYMBOL_GPL(__wiegand_register_driver);
+
+static int __init wiegand_init(void)
+{
+	int ret;
+
+	ret = bus_register(&wiegand_bus_type);
+	if (ret < 0) {
+		pr_err("Wiegand bus registration failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit wiegand_exit(void)
+{
+	ida_destroy(&wiegand_controller_ida);
+	bus_unregister(&wiegand_bus_type);
+}
+postcore_initcall_sync(wiegand_init);
+module_exit(wiegand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand bus driver");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
diff --git a/include/linux/wiegand.h b/include/linux/wiegand.h
new file mode 100644
index 000000000000..92d46114a4a8
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+
+#define WIEGAND_NAME_SIZE 32
+#define WIEGAND_MAX_PAYLEN_BYTES 256
+
+extern struct bus_type wiegand_type;
+
+struct wiegand_device;
+
+/**
+ * struct wiegand_controller - Wiegand primary or secondary interface
+ * @dev - Device interface of the controller
+ * @list - Link with the global wiegand_controller list
+ * @bus_num - Board-specific identifier for Wiegand controller
+ * @pulse_len: length of the low pulse in usec; defaults to 50us
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in usec;
+ * defaults to 2000us
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high phase) in usec;
+ * defaults to interval_len
+ * @device_count - Counter of devices connected to the same Wiegand bus(controller).
+ * @devm_allocated - Whether the allocation of this struct is devres-managed
+ * @secondary - Whether the controller is a secondary(receives data).
+ * @transfer_message - Send a message on the bus.
+ * @setup - Setup a device.
+ * @cleanup - Cleanup after a device.
+ */
+struct wiegand_controller {
+	struct device dev;
+	struct miscdevice miscdev;
+
+	struct file_operations fops;
+	struct mutex file_lock;
+
+	unsigned int bus_num;
+
+	bool secondary;
+	bool devm_allocated;
+
+	u32 pulse_len;
+	u32 interval_len;
+	u32 frame_gap;
+	u32 payload_len;
+
+	u8 device_count;
+
+	DECLARE_BITMAP(data_bitmap, WIEGAND_MAX_PAYLEN_BYTES * 8);
+
+	int (*transfer_message)(struct wiegand_controller *ctlr);
+	int (*setup)(struct wiegand_device *wiegand);
+	void (*cleanup)(struct wiegand_device *wiegand);
+};
+
+struct wiegand_driver {
+	struct device_driver driver;
+	const struct wiegand_device_id *id_table;
+	int (*probe)(struct wiegand_device *wiegand);
+	void (*remove)(struct wiegand_device *wiegand);
+};
+
+/* Wiegand controller section */
+
+#define wiegand_primary wiegand_controller
+extern struct wiegand_controller *wiegand_alloc_controller(struct device *host, unsigned int size,
+							bool secondary);
+
+extern struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev,
+								unsigned int size, bool secondary);
+static inline struct wiegand_controller *devm_wiegand_alloc_primary(struct device *dev,
+								unsigned int size)
+{
+	return devm_wiegand_alloc_controller(dev, size, false);
+}
+
+extern int wiegand_register_controller(struct wiegand_controller *ctlr);
+extern int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr);
+#define wiegand_register_primary(_ctlr) wiegand_register_controller(_ctlr)
+#define devm_wiegand_register_primary(_dev, _ctlr)devm_wiegand_register_controller(_dev, _ctlr)
+extern void wiegand_unregister_controller(void *ctlr);
+#define wiegand_unregister_primary(_ctlr) wiegand_unregister_controller(_ctlr)
+extern struct wiegand_primary *wiegand_busnum_to_primary(u16 bus_num);
+
+static inline void *wiegand_controller_get_devdata(struct wiegand_controller *ctlr)
+{
+	return dev_get_drvdata(&ctlr->dev);
+}
+
+static inline void wiegand_controller_set_devdata(struct wiegand_controller *ctlr, void *data)
+{
+	dev_set_drvdata(&ctlr->dev, data);
+}
+
+#define wiegand_primary_get_devdata(_ctlr) wiegand_controller_get_devdata(_ctlr)
+#define wiegand_primary_set_devdata(_ctlr, _data) wiegand_controller_set_devdata(_ctlr, _data)
+
+static inline struct wiegand_controller *wiegand_controller_get(struct wiegand_controller *ctlr)
+{
+	if (!ctlr || !get_device(&ctlr->dev))
+		return NULL;
+	return ctlr;
+}
+
+static inline void wiegand_controller_put(void *ptr)
+{
+	struct wiegand_controller *ctlr = ptr;
+
+	if (ctlr)
+		put_device(&ctlr->dev);
+}
+
+/* Wiegand device section */
+
+extern struct wiegand_device *wiegand_alloc_device(struct wiegand_controller *ctlr);
+extern int wiegand_add_device(struct wiegand_device *wiegand);
+extern int wiegand_setup(struct wiegand_device *wiegand);
+extern void wiegand_unregister_device(struct wiegand_device *wiegand);
+extern struct wiegand_controller *wiegand_device_get_controller(struct wiegand_device *dev);
+
+extern int wiegand_send_message(struct wiegand_device *wiegand, unsigned long *msg_bmp, u8 bitlen);
+
+/* Wiegand driver section  */
+
+extern int __wiegand_register_driver(struct module *owner, struct wiegand_driver *wdrv);
+#define wiegand_register_driver(driver) __wiegand_register_driver(THIS_MODULE, driver)
+
+static inline void wiegand_unregister_driver(struct wiegand_driver *wdrv)
+{
+	if (wdrv)
+		driver_unregister(&wdrv->driver);
+}
+
+static inline struct wiegand_driver *to_wiegand_driver(struct device_driver *drv)
+{
+	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;
+}
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
-- 
2.40.0

