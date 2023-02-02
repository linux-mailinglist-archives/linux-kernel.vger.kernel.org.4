Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D226688035
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjBBOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjBBOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:33:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B048394B;
        Thu,  2 Feb 2023 06:33:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mc11so6427181ejb.10;
        Thu, 02 Feb 2023 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9YVbgCsA6jXjiCngtb3WKdMb4shRdxAuHTH3z71NIs=;
        b=bI4+QzpNgMb76N2jAaLVJRnwKESrPvVjfoDD900pgrOqxce/HTt6ucaQSiVOSUj9z/
         g0c0xptO6xSWyasVsDK9G9CDy52Y76TcK2wxUwMDIshXtTug77o5Gw4SmNxA1XiMtxrJ
         mCotGxSsaiQHvypbV+4jqzL5gag12DKZNpecA7lQK5zGtIsA0IVJv/5PAA3xHb8BqD26
         m46IVZuirRNXxj5V4AtNg9zjSOZb1nqG4qsujgpJdrKPol4+NKQFC+kQgyEBTPe7pPk3
         iGaP4UrFf3W/KblNnVZySCoTgc5oEwzfWvPQer+FULhcVz6SRRyOXX1efCxPF35P/dYN
         CCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9YVbgCsA6jXjiCngtb3WKdMb4shRdxAuHTH3z71NIs=;
        b=1yVxQanbntlaVW/AWy27psZPU6uQGLTYC5JIfbU5Y2zrZwN67oo33uXxYbyFJ1bjZ8
         wB3bqxhaG9io42LIZjkq9PbV0k+1nmNdUNh9YrxACRvGybFYyckukKQIGTAy36ZhwkoD
         xfSZpDbbQ0nFBmtSu8Dv03o1FSaIQnIWhV70dvxd+vZVG8VfHiKaehYCfmg58aUbDO4i
         3+1Ir1YOTOF0uKXDcwE0kuZnP5zbWrDoONoVObzEd40ypx+ZjRzvfiWF0AEiHu/qE3+E
         +erZD736O1XU8TV9i/occc96CEGjbz4KkbKc6sDfqu6WHFvLEUjKSDAxPMvgVIuDZjM/
         /W3Q==
X-Gm-Message-State: AO0yUKXqZDItHbeZg4iignJ7kHD0UjCyniE8EcLSi0joFSrxun+cv4YM
        uGyUn7d/8crMz0FMiV52JwljxP+2aCbmow==
X-Google-Smtp-Source: AK7set/Fkj6jE98paJWFR8Qy48nnliXeRTiEzG1AjlRChdkyQeF/ekgZZIWT4xRvBQfL/VxFzylYcA==
X-Received: by 2002:a17:907:78d4:b0:878:7a0e:5730 with SMTP id kv20-20020a17090778d400b008787a0e5730mr6187505ejc.56.1675348393539;
        Thu, 02 Feb 2023 06:33:13 -0800 (PST)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709066d9100b0087856bd9dbbsm11814237ejt.97.2023.02.02.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 06:33:13 -0800 (PST)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, martin.petersen@oracle.com,
        beanhuo@micron.com, arnd@arndb.de, avri.altman@wdc.com,
        iwona.winiarska@intel.com, fmdefrancesco@gmail.com,
        dipenp@nvidia.com, ogabbay@kernel.org, bvanassche@acm.org,
        mathieu.poirier@linaro.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv2 2/4] wiegand: add Wiegand bus driver
Date:   Thu,  2 Feb 2023 15:33:03 +0100
Message-Id: <20230202143305.21789-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202143305.21789-1-m.zatovic1@gmail.com>
References: <20230202143305.21789-1-m.zatovic1@gmail.com>
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

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 MAINTAINERS               |   2 +
 drivers/Kconfig           |   2 +
 drivers/Makefile          |   1 +
 drivers/wiegand/Kconfig   |  20 ++
 drivers/wiegand/Makefile  |   1 +
 drivers/wiegand/wiegand.c | 543 ++++++++++++++++++++++++++++++++++++++
 include/linux/wiegand.h   | 177 +++++++++++++
 7 files changed, 746 insertions(+)
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index db9624d93af0..8119d12dac41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22432,6 +22432,8 @@ WIEGAND BUS DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+F:	drivers/wiegand/wiegand.c
+F:	include/linux/wiegand.h
 
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
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
index bdf1c66141c9..c5b613e2045a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -146,6 +146,7 @@ obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
+obj-$(CONFIG_WIEGAND)		+= wiegand/
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
index 000000000000..1147195fc256
--- /dev/null
+++ b/drivers/wiegand/wiegand.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/property.h>
+
+static struct bus_type wiegand_bus_type;
+static DEFINE_IDR(wiegand_controller_idr);
+
+static void devm_wiegand_release_controller(struct device *dev, void *ctlr)
+{
+	wiegand_controller_put(*(struct wiegand_controller **)ctlr);
+}
+
+static void wiegand_controller_release(struct device *dev)
+{
+	struct wiegand_controller *ctlr;
+
+	ctlr = container_of(dev, struct wiegand_controller, dev);
+	kfree(ctlr);
+}
+
+static struct class wiegand_controller_class = {
+	.name = "wiegand_master",
+	.owner = THIS_MODULE,
+	.dev_release = wiegand_controller_release,
+};
+
+static DEFINE_MUTEX(board_lock);
+
+struct wiegand_controller *__wiegand_alloc_controller(struct device *dev,
+						unsigned int size, bool slave)
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
+	ctlr->dev.class = &wiegand_controller_class;
+	ctlr->dev.parent = dev;
+	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
+
+	return ctlr;
+}
+EXPORT_SYMBOL_GPL(__wiegand_alloc_controller);
+
+struct wiegand_controller *__devm_wiegand_alloc_controller(struct device *dev,
+							unsigned int size,
+							bool slave)
+{
+	struct wiegand_controller **ptr, *ctlr;
+
+	ptr = devres_alloc(devm_wiegand_release_controller, sizeof(*ptr),
+								GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	ctlr = __wiegand_alloc_controller(dev, size, slave);
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
+EXPORT_SYMBOL_GPL(__devm_wiegand_alloc_controller);
+
+static int wiegand_controller_check_ops(struct wiegand_controller *ctlr)
+{
+	if (!ctlr->transfer_message)
+		return -EINVAL;
+	return 0;
+}
+
+static struct wiegand_device *of_register_wiegand_device(
+						struct wiegand_controller *ctlr,
+						struct device_node *nc)
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
+	rc = of_modalias_node(nc, wiegand->modalias, sizeof(wiegand->modalias));
+	if (rc < 0) {
+		dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
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
+			dev_warn(&ctlr->dev,
+				 "Failed to create wiegand device for %pOF\n",
+								nc);
+			of_node_clear_flag(nc, OF_POPULATED);
+		}
+	}
+}
+
+/*
+ * Controllers that do not have a devicetree entry need to initialize the
+ * following struct wiegand_controller attributes: pulse_len, interval_len and
+ * frame_gap.
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
+			id = idr_alloc(&wiegand_controller_idr, ctlr,
+							ctlr->bus_num,
+							ctlr->bus_num + 1,
+							GFP_KERNEL);
+			mutex_unlock(&board_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id == -ENOSPC ? -EBUSY : id;
+		}
+		device_property_read_u32(&ctlr->dev, "pulse-len-us",
+							&ctlr->pulse_len);
+		device_property_read_u32(&ctlr->dev, "interval-len-us",
+							&ctlr->interval_len);
+		device_property_read_u32(&ctlr->dev, "frame-gap-us",
+							&ctlr->frame_gap);
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
+	if (ctlr->pulse_len == 0)
+		dev_warn(&ctlr->dev, "pulse_len is not initialized\n");
+	if (ctlr->interval_len == 0)
+		dev_warn(&ctlr->dev, "interval_len is not initialized\n");
+	if (ctlr->frame_gap == 0)
+		dev_warn(&ctlr->dev, "frame_gap is not initialized\n");
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
+int devm_wiegand_register_controller(struct device *dev,
+				     struct wiegand_controller *ctlr)
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
+static int __wiegand_master_match(struct device *dev, const void *data)
+{
+	struct wiegand_master *master;
+	const u16 *bus_num = data;
+
+	master = container_of(dev, struct wiegand_master, dev);
+	return master->bus_num == *bus_num;
+}
+
+struct wiegand_master *wiegand_busnum_to_master(u16 bus_num)
+{
+	struct device *dev;
+	struct wiegand_master *master = NULL;
+
+	dev = class_find_device(&wiegand_controller_class, NULL, &bus_num,
+				__wiegand_master_match);
+	if (dev)
+		master = container_of(dev, struct wiegand_master, dev);
+
+	return master;
+}
+EXPORT_SYMBOL_GPL(wiegand_busnum_to_master);
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
+		dev_err(dev, "can't add %s, status %d\n",
+			dev_name(&wiegand->dev), status);
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
+	dev_set_name(&wiegand->dev, "%s.%u",
+			dev_name(&wiegand->controller->dev), id);
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
+			dev_err(&wiegand->controller->dev,
+						"Failed to setup device: %d\n",
+									status);
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
+	const struct wiegand_device *wiegand = to_wiegand_device(dev);
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return strcmp(wiegand->modalias, drv->name) == 0;
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
+	if (wdrv->driver.of_match_table) {
+		const struct of_device_id *of_id;
+
+		for (of_id = wdrv->driver.of_match_table; of_id->compatible[0];
+		     of_id++) {
+			const char *of_name;
+
+			/* remove vendor prefix */
+			of_name = strnchr(of_id->compatible,
+					  sizeof(of_id->compatible), ',');
+			if (of_name)
+				of_name++;
+			else
+				of_name = of_id->compatible;
+
+			if (strcmp(wdrv->driver.name, of_name) == 0)
+				continue;
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
+		goto err0;
+	}
+
+	ret = class_register(&wiegand_controller_class);
+	if (ret < 0)
+		goto err1;
+
+	return 0;
+
+err1:
+	bus_unregister(&wiegand_bus_type);
+err0:
+	return ret;
+}
+
+static void __exit wiegand_exit(void)
+{
+	bus_unregister(&wiegand_bus_type);
+	class_unregister(&wiegand_controller_class);
+}
+postcore_initcall_sync(wiegand_init);
+module_exit(wiegand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand bus driver");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
diff --git a/include/linux/wiegand.h b/include/linux/wiegand.h
new file mode 100644
index 000000000000..dc733af464c4
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,177 @@
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
+ * @interval_len: length of a whole bit (both the pulse and the high phase) in
+ *	usec; defaults to 2000us
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high
+ *	phase) in usec; defaults to interval_len
+ * device_count - Counter of devices connected to the same Wiegand
+ *	bus(controller).
+ * devm_allocated - Whether the allocation of this struct is devres-managed
+ * slave - Whether the controller is a slave(receives data).
+ * transfer_message - Send a message on the bus.
+ * setup - Setup a device.
+ * cleanup - Cleanup after a device.
+ */
+struct wiegand_controller {
+	struct device dev;
+	struct list_head list;
+
+	s16 bus_num;
+
+	u32 pulse_len;
+	u32 interval_len;
+	u32 frame_gap;
+
+	u32 payload_len;
+
+	u8 device_count;
+
+	bool devm_allocated;
+	bool slave;
+
+	int (*transfer_message)(struct wiegand_device *dev, u8 *message,
+								u8 bitlen);
+
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
+extern struct wiegand_controller *__wiegand_alloc_controller(
+							struct device *host,
+							unsigned int size,
+							bool slave);
+
+struct wiegand_controller *__devm_wiegand_alloc_controller(struct device *dev,
+						   unsigned int size,
+						   bool slave);
+struct wiegand_controller *__wiegand_alloc_controller(struct device *dev,
+							unsigned int size,
+							bool slave);
+static inline struct wiegand_controller *devm_wiegand_alloc_master(
+							struct device *dev,
+							unsigned int size)
+{
+	return __devm_wiegand_alloc_controller(dev, size, false);
+}
+extern int wiegand_register_controller(struct wiegand_controller *ctlr);
+extern int devm_wiegand_register_controller(struct device *dev,
+					struct wiegand_controller *ctlr);
+#define wiegand_register_master(_ctlr) wiegand_register_controller(_ctlr)
+#define devm_wiegand_register_master(_dev, _ctlr) \
+	devm_wiegand_register_controller(_dev, _ctlr)
+extern void wiegand_unregister_controller(struct wiegand_controller *ctlr);
+#define wiegand_unregister_master(_ctlr) wiegand_unregister_controller(_ctlr)
+extern struct wiegand_master *wiegand_busnum_to_master(u16 bus_num);
+
+static inline void *wiegand_controller_get_devdata(
+						struct wiegand_controller *ctlr)
+{
+	return dev_get_drvdata(&ctlr->dev);
+}
+
+static inline void wiegand_controller_set_devdata(
+						struct wiegand_controller *ctlr,
+						void *data)
+{
+	dev_set_drvdata(&ctlr->dev, data);
+}
+
+#define wiegand_master_get_devdata(_ctlr) \
+	wiegand_controller_get_devdata(_ctlr)
+#define wiegand_master_set_devdata(_ctlr, _data) \
+	wiegand_controller_set_devdata(_ctlr, _data)
+
+static inline struct wiegand_controller *wiegand_controller_get(
+						struct wiegand_controller *ctlr)
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
+extern struct wiegand_device *wiegand_alloc_device(
+					struct wiegand_controller *ctlr);
+extern int wiegand_add_device(struct wiegand_device *wiegand);
+extern int wiegand_setup(struct wiegand_device *wiegand);
+extern void wiegand_unregister_device(struct wiegand_device *wiegand);
+
+extern int wiegand_send_message(struct wiegand_device *wiegand, u8 *message,
+								u8 bitlen);
+
+static inline struct wiegand_device *to_wiegand_device(struct device *dev)
+{
+	return dev ? container_of(dev, struct wiegand_device, dev) : NULL;
+}
+static inline void wiegand_dev_put(struct wiegand_device *wiegand)
+{
+	if (wiegand)
+		put_device(&wiegand->dev);
+}
+
+/* Wiegand driver section  */
+
+static inline struct wiegand_driver *to_wiegand_driver(struct device_driver *drv)
+{
+	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;
+}
+extern int __wiegand_register_driver(struct module *owner,
+				     struct wiegand_driver *wdrv);
+#define wiegand_register_driver(driver) \
+	__wiegand_register_driver(THIS_MODULE, driver)
+
+static inline void wiegand_unregister_driver(struct wiegand_driver *wdrv)
+{
+	if (wdrv)
+		driver_unregister(&wdrv->driver);
+}
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
-- 
2.39.1

