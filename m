Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECD6A6E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCAO27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCAO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:28:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16D4696;
        Wed,  1 Mar 2023 06:28:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so54616924edb.3;
        Wed, 01 Mar 2023 06:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0yVA58GaC3n6H36VuEv9LWqoXqWPCxUn0npZ2+wTRI=;
        b=pY40YaTk+Xcb+lMTso2R8DYrEwMbMLZqIM4d9UjwlFdAxOFRRRV0BmmxXKORPm+a87
         Hn8CyiD57ZqUMyHc0DSdGC9uW1qRtA6US7NvuOhjKf0XErNh1C9MZX5z92cFvtmzhHRT
         L9IOHb6pzo4i21mhZZHmj+WtLA+Tn3rcR6zOYjxJqmlH9sZsY28oRDHXq8HMb7b011R8
         +puSw7V3jZRESK/f6N3vyj2bShNOvDAsljIv9QXfFYqEHCpNrMPbjxBUQEU/ICEzOhqx
         7iE9ynY0BLt+XTZUbhshXakz/Zb12TMHXn35Ws/tyvYdKrxTgRFd2Czeubl/oiZTAwRi
         OpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0yVA58GaC3n6H36VuEv9LWqoXqWPCxUn0npZ2+wTRI=;
        b=sbM/5q7XpS8iqp0y1oI/+oEYZq9JsoGCahtrhy708ADw3ywOguEdALlc+A0bPG8njs
         hyvQGTfxT2piudTjd3pOzUkDZ0dmJe+85OFifz34k41q6oPTj0Djv/s73oWuTBpBdGjw
         TuIRufL/vtoNoNXqiUB+b+mHewvreLgA2iVd4eNTodx3CjwvBvGzXH8TX3jqrxnFg0lX
         be/ulttXSyAZpF7FYtNjd/zTJU07d5X5YZpOxS2Gkhb4YoQep5Wz3FcLODHTQpK0P0Ng
         yEg1kh4ZwtoOL3AtCXWlLQ/ymErb+MK+Z/tFA21Ike1OBz0nUkyAtR1IuIRrkSkqd/gK
         aUXA==
X-Gm-Message-State: AO0yUKVYC/GVad4xel3c9K6kX5/JidrsFqAUC9DWrhN3I2/7gC3COuPL
        sjDuKwuN4mSMiJhNo7yqlK26C6jd7IgMDA==
X-Google-Smtp-Source: AK7set+RFKTftp5tNZG0AI2Vu2F6X/6l+ZziCwaMtTe/VkcfXLjCXFsXDTughXLYSeGbRWjqFeF/iw==
X-Received: by 2002:a05:6402:1b06:b0:4af:7f6e:297b with SMTP id by6-20020a0564021b0600b004af7f6e297bmr7767856edb.35.1677680932565;
        Wed, 01 Mar 2023 06:28:52 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id t8-20020a170906178800b008dcf89a72d7sm5972282eje.147.2023.03.01.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:28:52 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@redhat.com, dipenp@nvidia.com,
        treding@nvidia.com, mwen@igalia.com, fmdefrancesco@gmail.com,
        arnd@arndb.de, bvanassche@acm.org, ogabbay@kernel.org,
        axboe@kernel.dk, mathieu.poirier@linaro.org, linux@zary.sk,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, jacek.lawrynowicz@linux.intel.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        furong.zhou@linux.intel.com, andriy.shevchenko@intel.com,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv3 2/4] wiegand: add Wiegand bus driver
Date:   Wed,  1 Mar 2023 15:28:33 +0100
Message-Id: <20230301142835.19614-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301142835.19614-1-m.zatovic1@gmail.com>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/wiegand/wiegand.c | 500 ++++++++++++++++++++++++++++++++++++++
 include/linux/wiegand.h   | 155 ++++++++++++
 7 files changed, 681 insertions(+)
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f6f6d236f0c..23a67b32f095 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22516,6 +22516,8 @@ WIEGAND BUS DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+F:	drivers/wiegand/wiegand.c
+F:	include/linux/wiegand.h
 
 WIIMOTE HID DRIVER
 M:	David Rheinsberg <david.rheinsberg@gmail.com>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 968bd0a6fd78..bedc5a9fecba 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -67,6 +67,8 @@ source "drivers/spi/Kconfig"
 
 source "drivers/spmi/Kconfig"
 
+source "drivers/wiegand/Kconfig"
+
 source "drivers/hsi/Kconfig"
 
 source "drivers/pps/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 20b118dca999..ef96e937eacc 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
+obj-$(CONFIG_WIEGAND)		+= wiegand/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_STAGING)		+= staging/
diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
new file mode 100644
index 000000000000..d6b63250e80b
--- /dev/null
+++ b/drivers/wiegand/Kconfig
@@ -0,0 +1,20 @@
+config WIEGAND
+	tristate "Wiegand Bus driver"
+	help
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
index 000000000000..ebec2e3e4cd6
--- /dev/null
+++ b/drivers/wiegand/wiegand.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+
+static struct bus_type wiegand_bus_type;
+static DEFINE_IDR(wiegand_controller_idr);
+static DEFINE_MUTEX(board_lock);
+
+static void devm_wiegand_release_controller(struct device *dev, void *ctlr)
+{
+	wiegand_controller_put(*(struct wiegand_controller **)ctlr);
+}
+
+struct wiegand_controller *wiegand_alloc_controller(struct device *dev, unsigned int size,
+						bool slave)
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
+	ctlr->bus_num = -1;
+	ctlr->slave = slave;
+	ctlr->dev.parent = dev;
+	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(wiegand_alloc_controller);
+
+struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
+							bool slave)
+{
+	struct wiegand_controller **ptr, *ctlr;
+
+	ptr = devres_alloc(devm_wiegand_release_controller, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	ctlr = wiegand_alloc_controller(dev, size, slave);
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
+/**
+ * wiegand_controller_check_ops - checks whether message transfer function was defined for a
+ * controller
+ * @ctlr: controller structure to check
+ */
+static int wiegand_controller_check_ops(struct wiegand_controller *ctlr)
+{
+	if (!ctlr->transfer_message)
+		return -EINVAL;
+	return 0;
+}
+
+/**
+ * of_register_wiegand_device - allocates and registers a new Wiegand device based on devicetree
+ * node
+ * @ctlr: controller structure to attach device to
+ * @nc: devicetree node for the device
+ */
+static struct wiegand_device *of_register_wiegand_device(struct wiegand_controller *ctlr,
+							struct device_node *nc)
+{
+	struct wiegand_device *wiegand;
+	int rc;
+
+	wiegand = wiegand_alloc_device(ctlr);
+	if (!wiegand) {
+		dev_err(&ctlr->dev, "wiegad_device alloc error for %pOF\n", nc);
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	of_node_get(nc);
+	wiegand->dev.of_node = nc;
+	wiegand->dev.fwnode = of_fwnode_handle(nc);
+
+	rc = wiegand_add_device(wiegand);
+	if (rc) {
+		dev_err(&ctlr->dev, "wiegand_device register error %pOF\n", nc);
+		goto err_of_node_put;
+	}
+
+	/* check if more devices are connected to the bus */
+	if (ctlr->device_count > 1)
+		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
+
+	return wiegand;
+
+err_of_node_put:
+	of_node_put(nc);
+err_out:
+	wiegand_dev_put(wiegand);
+	return ERR_PTR(rc);
+}
+
+/**
+ * of_register_wiegand_devices - creates a wiegand device for all children of a controller
+ * devicetree node
+ * @ctlr: controller structure to check
+ */
+static void of_register_wiegand_devices(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+	struct device_node *nc;
+
+	if (!ctlr->dev.of_node)
+		return;
+
+	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
+		wiegand = of_register_wiegand_device(ctlr, nc);
+		if (IS_ERR(wiegand)) {
+			dev_warn(&ctlr->dev, "Failed to create wiegand device for %pOF\n", nc);
+			of_node_clear_flag(nc, OF_POPULATED);
+		}
+	}
+}
+
+/**
+ * wiegand_register_controller - registers controller structure within bus
+ * @ctlr: controller structure to register
+ *
+ * Function checks that the message transfer functions is defined for passed controller structure,
+ * gets the devicetree defined attributes and checks whether they have all been initialized and
+ * finally adds the controller device and registers the controller on the bus.
+ */
+int wiegand_register_controller(struct wiegand_controller *ctlr)
+{
+	struct device *dev = ctlr->dev.parent;
+	int status, id, first_dynamic;
+
+	if (!dev)
+		return -ENODEV;
+
+	status = wiegand_controller_check_ops(ctlr);
+	if (status)
+		return status;
+
+	if (ctlr->dev.of_node) {
+		id = of_alias_get_id(ctlr->dev.of_node, "wiegand");
+		if (id > 0) {
+			ctlr->bus_num = id;
+			mutex_lock(&board_lock);
+			id = idr_alloc(&wiegand_controller_idr, ctlr, ctlr->bus_num,
+					ctlr->bus_num + 1, GFP_KERNEL);
+			mutex_unlock(&board_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id == -ENOSPC ? -EBUSY : id;
+		}
+		device_property_read_u32(&ctlr->dev, "pulse-len-us", &ctlr->pulse_len);
+		device_property_read_u32(&ctlr->dev, "interval-len-us", &ctlr->interval_len);
+		device_property_read_u32(&ctlr->dev, "frame-gap-us", &ctlr->frame_gap);
+	}
+	if (ctlr->bus_num < 0) {
+		first_dynamic = of_alias_get_highest_id("wiegand");
+		if (first_dynamic < 0)
+			first_dynamic = 0;
+		else
+			first_dynamic++;
+
+		mutex_lock(&board_lock);
+		id = idr_alloc(&wiegand_controller_idr, ctlr, first_dynamic,
+								0, GFP_KERNEL);
+		mutex_unlock(&board_lock);
+		if (WARN(id < 0, "couldn't get idr\n"))
+			return id;
+		ctlr->bus_num = id;
+	}
+
+	if (ctlr->pulse_len == 0) {
+		dev_warn(&ctlr->dev, "pulse_len is not initialized, setting the default value 50us\n");
+		ctlr->pulse_len = 50;
+	}
+	if (ctlr->interval_len == 0) {
+		dev_warn(&ctlr->dev, "interval_len is not initialized, setting the default value 2000us\n");
+		ctlr->interval_len = 2000;
+	}
+	if (ctlr->frame_gap == 0) {
+		dev_warn(&ctlr->dev, "frame_gap is not initialized, setting the default value 2000us\n");
+		ctlr->frame_gap = 2000;
+	}
+
+	dev_set_name(&ctlr->dev, "wiegand%u", ctlr->bus_num);
+	ctlr->device_count = 0;
+
+	status = device_add(&ctlr->dev);
+	if (status < 0)
+		goto free_bus_id;
+
+	of_register_wiegand_devices(ctlr);
+
+	return status;
+
+free_bus_id:
+	mutex_lock(&board_lock);
+	idr_remove(&wiegand_controller_idr, ctlr->bus_num);
+	mutex_unlock(&board_lock);
+	return status;
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	wiegand_unregister_device(to_wiegand_device(dev));
+	return 0;
+}
+
+void wiegand_unregister_controller(struct wiegand_controller *ctlr)
+{
+	struct wiegand_controller *found;
+	int id = ctlr->bus_num;
+
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
+	found = idr_find(&wiegand_controller_idr, id);
+	device_del(&ctlr->dev);
+
+	mutex_lock(&board_lock);
+	if (found == ctlr)
+		idr_remove(&wiegand_controller_idr, id);
+	mutex_unlock(&board_lock);
+
+	if (!ctlr->devm_allocated)
+		put_device(&ctlr->dev);
+}
+EXPORT_SYMBOL_GPL(wiegand_unregister_controller);
+
+static void devm_wiegand_unregister(struct device *dev, void *res)
+{
+	wiegand_unregister_controller(*(struct wiegand_controller **)res);
+}
+
+int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr)
+{
+	struct wiegand_controller **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_wiegand_unregister, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = wiegand_register_controller(ctlr);
+	if (!ret) {
+		*ptr = ctlr;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_wiegand_register_controller);
+
+/* Device section */
+
+static void wieganddev_release(struct device *dev)
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
+	if (!wiegand_controller_get(ctlr))
+		return NULL;
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
+	wiegand->dev.release = wieganddev_release;
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
+static void wiegand_dev_set_name(struct wiegand_device *wiegand, u8 id)
+{
+	dev_set_name(&wiegand->dev, "%s.%u", dev_name(&wiegand->controller->dev), id);
+}
+
+int wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	int status;
+
+	wiegand_dev_set_name(wiegand, ctlr->device_count);
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
+			dev_err(&wiegand->controller->dev, "Failed to setup device: %d\n", status);
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
+	if (wiegand->dev.of_node) {
+		of_node_clear_flag(wiegand->dev.of_node, OF_POPULATED);
+		of_node_put(wiegand->dev.of_node);
+	}
+	device_del(&wiegand->dev);
+	wiegand_cleanup(wiegand);
+	put_device(&wiegand->dev);
+}
+EXPORT_SYMBOL_GPL(wiegand_unregister_device);
+
+int wiegand_send_message(struct wiegand_device *wiegand, u8 *message, u8 bitlen)
+{
+	struct wiegand_master *master = wiegand->controller;
+
+	if (message == NULL || message == 0)
+		return -EINVAL;
+
+	if (master->transfer_message)
+		master->transfer_message(wiegand, message, bitlen);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wiegand_send_message);
+
+static int wiegand_match_device(struct device *dev, struct device_driver *drv)
+{
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return 0;
+}
+
+static int wiegand_probe(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+	int ret = 0;
+
+	if (wdrv->probe)
+		ret = wdrv->probe(wiegand);
+
+	return ret;
+}
+
+static int wiegand_remove(struct device *dev)
+{
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+
+	if (wdrv->remove)
+		wdrv->remove(to_wiegand_device(dev));
+
+	return 0;
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
+	if (wdrv->driver.of_match_table) {
+		const struct of_device_id *of_id;
+
+		for (of_id = wdrv->driver.of_match_table; of_id->compatible[0];
+			of_id++) {
+			const char *of_name;
+
+			/* remove vendor prefix */
+			of_name = strnchr(of_id->compatible,
+						sizeof(of_id->compatible), ',');
+			if (of_name)
+				of_name++;
+			else
+				of_name = of_id->compatible;
+
+			if (wdrv->driver.name) {
+				if (strcmp(wdrv->driver.name, of_name) == 0)
+					continue;
+			}
+
+			pr_warn("Wiegand driver %s has no device_id for %s\n",
+				wdrv->driver.name, of_id->compatible);
+		}
+	}
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
index 000000000000..9dc683d91b3d
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/mod_devicetable.h>
+
+#define WIEGAND_NAME_SIZE 32
+
+extern struct bus_type wiegand_type;
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
+/**
+ * struct wiegand_controller - Wiegand master or slave interface
+ * @dev - Device interface of the controller
+ * @list - Link with the global wiegand_controller list
+ * @bus_num - Board-specific identifier for Wiegand controller
+ * @pulse_len: length of the low pulse in usec; defaults to 50us
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in usec;
+ * defaults to 2000us
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high phase) in usec;
+ * defaults to interval_len
+ * device_count - Counter of devices connected to the same Wiegand bus(controller).
+ * devm_allocated - Whether the allocation of this struct is devres-managed
+ * slave - Whether the controller is a slave(receives data).
+ * transfer_message - Send a message on the bus.
+ * setup - Setup a device.
+ * cleanup - Cleanup after a device.
+ */
+struct wiegand_controller {
+	struct device dev;
+
+	s16 bus_num;
+
+	bool slave;
+	bool devm_allocated;
+
+	u32 pulse_len;
+	u32 interval_len;
+	u32 frame_gap;
+	u32 payload_len;
+	u8 device_count;
+
+	int (*transfer_message)(struct wiegand_device *dev, u8 *message, u8 bitlen);
+	int (*setup)(struct wiegand_device *wiegand);
+	void (*cleanup)(struct wiegand_device *wiegand);
+};
+
+struct wiegand_driver {
+	const struct wiegand_device_id *id_table;
+	int (*probe)(struct wiegand_device *wiegand);
+	void (*remove)(struct wiegand_device *wiegand);
+	struct device_driver driver;
+};
+
+/* Wiegand controller section */
+
+#define wiegand_master wiegand_controller
+struct wiegand_controller *wiegand_alloc_controller(struct device *host, unsigned int size,
+							bool slave);
+
+struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
+							bool slave);
+static inline struct wiegand_controller *devm_wiegand_alloc_master(struct device *dev,
+								unsigned int size)
+{
+	return devm_wiegand_alloc_controller(dev, size, false);
+}
+
+extern int wiegand_register_controller(struct wiegand_controller *ctlr);
+extern int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr);
+#define wiegand_register_master(_ctlr) wiegand_register_controller(_ctlr)
+#define devm_wiegand_register_master(_dev, _ctlr)devm_wiegand_register_controller(_dev, _ctlr)
+extern void wiegand_unregister_controller(struct wiegand_controller *ctlr);
+#define wiegand_unregister_master(_ctlr) wiegand_unregister_controller(_ctlr)
+extern struct wiegand_master *wiegand_busnum_to_master(u16 bus_num);
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
+#define wiegand_master_get_devdata(_ctlr) wiegand_controller_get_devdata(_ctlr)
+#define wiegand_master_set_devdata(_ctlr, _data) wiegand_controller_set_devdata(_ctlr, _data)
+
+static inline struct wiegand_controller *wiegand_controller_get(struct wiegand_controller *ctlr)
+{
+	if (!ctlr || !get_device(&ctlr->dev))
+		return NULL;
+	return ctlr;
+}
+
+static inline void wiegand_controller_put(struct wiegand_controller *ctlr)
+{
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
+
+extern int wiegand_send_message(struct wiegand_device *wiegand, u8 *message, u8 bitlen);
+
+static inline struct wiegand_device *to_wiegand_device(struct device *dev)
+{
+	return dev ? container_of(dev, struct wiegand_device, dev) : NULL;
+}
+
+static inline void wiegand_dev_put(struct wiegand_device *wiegand)
+{
+	if (wiegand)
+		put_device(&wiegand->dev);
+}
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
2.39.2

