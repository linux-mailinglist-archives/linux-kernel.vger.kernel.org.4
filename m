Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04E1619CD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiKDQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKDQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:16:01 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8911148
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:15:59 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s10so2312190ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWTf7k+61X34xVJrLGHLO3LmlT6B/Bo1w5lh2zH4rdM=;
        b=E3g1jxcYyf0493ZLe6ETL4bYGCdlUPQq5+sxv2YZp2JvhaCA8JkMBpI+6mRYRWwQn+
         fU7j4Bd5D7Inhpif2INq6Wqc6r48y/G0Bf8R3rxrBUzruRzmDi4ubdlVbdg36s7U/EWm
         BMJOZZC+/ZXEvO4LH3+deUZ3cQPMzQwP2OBXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWTf7k+61X34xVJrLGHLO3LmlT6B/Bo1w5lh2zH4rdM=;
        b=R4CiXVfEWGEfxKNfzvM3cCwurFWpd8bbOyVHTWR7HRREPRUX0CMIzMmt4Nz6BlOVRl
         oyxXJbFhNHP0Zcz9U5BoIV2GVXn+ztgc25FlvIauF21PaE7BspQEm6yedceA4YWzN/QE
         AjZx+fs32hmqh9V/rUTvKhl4my0leHdbTX0JNcXJZhEg8hcBFgb9M9eyeHMQfDl4IN4g
         mHVlztzl3Pf9YStUuvWiabBDAr0Jho7xHhSLEgwmaQXGYhlSJ1BgMAnz1Nm7GeEx0NKN
         arSv9OeAfRZziCPGVVl+ClwUnMQBEJJwzLbG8iY2odoRkHPzKPezHMPGRprdNGGEyPW+
         Dtmg==
X-Gm-Message-State: ACrzQf2bkJk3j4/lsADHNT1TmlAjdUh5yLiU05W7dyu73AqhQovZSkKW
        Z++M/H8S5QW47Nz+T0uRjjuAXt9WrWyLwmEq
X-Google-Smtp-Source: AMsMyM6NtgvEBetRe0GUbj9ZSyVcObmweOCbkGl4My/9sgQvxQvzcsYJfCFaJwSv91ysm1btxNnQyg==
X-Received: by 2002:a02:5147:0:b0:375:9c59:7825 with SMTP id s68-20020a025147000000b003759c597825mr3812043jaa.51.1667578558353;
        Fri, 04 Nov 2022 09:15:58 -0700 (PDT)
Received: from jrosenth45.lan ([2601:285:8300:c23:5d3f:d17e:daca:764e])
        by smtp.gmail.com with ESMTPSA id g26-20020a02271a000000b00374f8a0ed3csm1350763jaa.103.2022.11.04.09.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:15:57 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        gregkh@linuxfoundation.org
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [RESEND PATCH v13] firmware: google: Implement cbmem in sysfs driver
Date:   Fri,  4 Nov 2022 10:15:28 -0600
Message-Id: <20221104161528.531248-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CBMEM area is a downward-growing memory region used by coreboot to
dynamically allocate tagged data structures ("CBMEM entries") that
remain resident during boot.

This implements a driver which exports access to the CBMEM entries
via sysfs under /sys/bus/coreboot/devices/cbmem-<id>.

This implementation is quite versatile.  Examples of how it could be
used are given below:

* Tools like util/cbmem from the coreboot tree could use this driver
  instead of finding CBMEM in /dev/mem directly.  Alternatively,
  firmware developers debugging an issue may find the sysfs interface
  more ergonomic than the cbmem tool and choose to use it directly.

* The crossystem tool, which exposes verified boot variables, can use
  this driver to read the vboot work buffer.

* Tools which read the BIOS SPI flash (e.g., flashrom) can find the
  flash layout in CBMEM directly, which is significantly faster than
  searching the flash directly.

Write access is provided to all CBMEM regions via
/sys/bus/coreboot/devices/cbmem-<id>/mem, as the existing cbmem
tooling updates this memory region, and envisioned use cases with
crossystem can benefit from updating memory regions.

Link: https://issuetracker.google.com/239604743
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-coreboot |  45 +++++++
 drivers/firmware/google/Kconfig              |  15 +++
 drivers/firmware/google/Makefile             |   3 +
 drivers/firmware/google/cbmem.c              | 129 +++++++++++++++++++
 drivers/firmware/google/coreboot_table.c     |  11 +-
 drivers/firmware/google/coreboot_table.h     |  18 +++
 6 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coreboot
 create mode 100644 drivers/firmware/google/cbmem.c

diff --git a/Documentation/ABI/testing/sysfs-bus-coreboot b/Documentation/ABI/testing/sysfs-bus-coreboot
new file mode 100644
index 000000000000..9c5accecc470
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coreboot
@@ -0,0 +1,45 @@
+What:		/sys/bus/coreboot
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The coreboot bus provides a variety of virtual devices used to
+		access data structures created by the Coreboot BIOS.
+
+What:		/sys/bus/coreboot/devices/cbmem-<id>
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		CBMEM is a downwards-growing memory region created by Coreboot,
+		and contains tagged data structures to be shared with payloads
+		in the boot process and the OS.  Each CBMEM entry is given a
+		directory in /sys/bus/coreboot/devices based on its id.
+		A list of ids known to Coreboot can be found in the coreboot
+		source tree at
+		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
+
+What:		/sys/bus/coreboot/devices/cbmem-<id>/address
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		This is the pyhsical memory address that the CBMEM entry's data
+		begins at, in hexadecimal (e.g., ``0x76ffe000``).
+
+What:		/sys/bus/coreboot/devices/cbmem-<id>/size
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		This is the size of the CBMEM entry's data, in hexadecimal
+		(e.g., ``0x1234``).
+
+What:		/sys/bus/coreboot/devices/cbmem-<id>/mem
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		A file exposing read/write access to the entry's data.  Note
+		that this file does not support mmap(), as coreboot
+		does not guarantee that the data will be page-aligned.
+
+		The mode of this file is 0600.  While there shouldn't be
+		anything security-sensitive contained in CBMEM, read access
+		requires root privileges given this is exposing a small subset
+		of physical memory.
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 983e07dc022e..9f190eab43ed 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -19,6 +19,21 @@ config GOOGLE_SMI
 	  driver provides an interface for reading and writing NVRAM
 	  variables.
 
+config GOOGLE_CBMEM
+	tristate "CBMEM entries in sysfs"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  CBMEM is a downwards-growing memory region created by the
+	  Coreboot BIOS containing tagged data structures from the
+	  BIOS.  These data structures expose things like the verified
+	  boot firmware variables, flash layout, firmware event log,
+	  and more.
+
+	  This option enables the cbmem module, which causes the
+	  kernel to search for Coreboot CBMEM entries, and expose the
+	  memory for each entry in sysfs under
+	  /sys/bus/coreboot/devices/cbmem-<id>.
+
 config GOOGLE_COREBOOT_TABLE
 	tristate "Coreboot Table Access"
 	depends on HAS_IOMEM && (ACPI || OF)
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
index d17caded5d88..8151e323cc43 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/google/Makefile
@@ -7,5 +7,8 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
 
+# Must come after coreboot_table.o, as this driver depends on that bus type.
+obj-$(CONFIG_GOOGLE_CBMEM)		+= cbmem.o
+
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
new file mode 100644
index 000000000000..685f3070ce9d
--- /dev/null
+++ b/drivers/firmware/google/cbmem.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * cbmem.c
+ *
+ * Driver for exporting cbmem entries in sysfs.
+ *
+ * Copyright 2022 Google LLC
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include "coreboot_table.h"
+
+struct cbmem_entry {
+	char *mem_file_buf;
+	u32 size;
+};
+
+static struct cbmem_entry *to_cbmem_entry(struct kobject *kobj)
+{
+	return dev_get_drvdata(kobj_to_dev(kobj));
+}
+
+static ssize_t mem_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf, loff_t pos,
+			size_t count)
+{
+	struct cbmem_entry *entry = to_cbmem_entry(kobj);
+
+	return memory_read_from_buffer(buf, count, &pos, entry->mem_file_buf,
+				       entry->size);
+}
+
+static ssize_t mem_write(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *bin_attr, char *buf, loff_t pos,
+			 size_t count)
+{
+	struct cbmem_entry *entry = to_cbmem_entry(kobj);
+
+	if (pos < 0 || pos >= entry->size)
+		return -EINVAL;
+	if (count > entry->size - pos)
+		count = entry->size - pos;
+
+	memcpy(entry->mem_file_buf + pos, buf, count);
+	return count;
+}
+static BIN_ATTR_ADMIN_RW(mem, 0);
+
+static ssize_t address_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct coreboot_device *cbdev = dev_to_coreboot_device(dev);
+
+	return sysfs_emit(buf, "0x%llx\n", cbdev->cbmem_entry.address);
+}
+static DEVICE_ATTR_RO(address);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct coreboot_device *cbdev = dev_to_coreboot_device(dev);
+
+	return sysfs_emit(buf, "0x%x\n", cbdev->cbmem_entry.entry_size);
+}
+static DEVICE_ATTR_RO(size);
+
+static struct attribute *attrs[] = {
+	&dev_attr_address.attr,
+	&dev_attr_size.attr,
+	NULL,
+};
+
+static struct bin_attribute *bin_attrs[] = {
+	&bin_attr_mem,
+	NULL,
+};
+
+static const struct attribute_group cbmem_entry_group = {
+	.attrs = attrs,
+	.bin_attrs = bin_attrs,
+};
+
+static const struct attribute_group *dev_groups[] = {
+	&cbmem_entry_group,
+	NULL,
+};
+
+static int cbmem_entry_probe(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry;
+
+	entry = devm_kzalloc(&dev->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dev->dev, entry);
+	entry->mem_file_buf = devm_memremap(&dev->dev, dev->cbmem_entry.address,
+					    dev->cbmem_entry.entry_size,
+					    MEMREMAP_WB);
+	if (!entry->mem_file_buf)
+		return -ENOMEM;
+
+	entry->size = dev->cbmem_entry.entry_size;
+
+	return 0;
+}
+
+static struct coreboot_driver cbmem_entry_driver = {
+	.probe = cbmem_entry_probe,
+	.drv = {
+		.name = "cbmem",
+		.owner = THIS_MODULE,
+		.dev_groups = dev_groups,
+	},
+	.tag = LB_TAG_CBMEM_ENTRY,
+};
+module_coreboot_driver(cbmem_entry_driver);
+
+MODULE_AUTHOR("Jack Rosenthal <jrosenth@chromium.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index c52bcaa9def6..7748067eb9e6 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -97,12 +97,21 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
 		if (!device)
 			return -ENOMEM;
 
-		dev_set_name(&device->dev, "coreboot%d", i);
 		device->dev.parent = dev;
 		device->dev.bus = &coreboot_bus_type;
 		device->dev.release = coreboot_device_release;
 		memcpy(&device->entry, ptr_entry, entry->size);
 
+		switch (device->entry.tag) {
+		case LB_TAG_CBMEM_ENTRY:
+			dev_set_name(&device->dev, "cbmem-%08x",
+				     device->cbmem_entry.id);
+			break;
+		default:
+			dev_set_name(&device->dev, "coreboot%d", i);
+			break;
+		}
+
 		ret = device_register(&device->dev);
 		if (ret) {
 			put_device(&device->dev);
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index beb778674acd..37f4d335a606 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -39,6 +39,18 @@ struct lb_cbmem_ref {
 	u64 cbmem_addr;
 };
 
+#define LB_TAG_CBMEM_ENTRY 0x31
+
+/* Corresponds to LB_TAG_CBMEM_ENTRY */
+struct lb_cbmem_entry {
+	u32 tag;
+	u32 size;
+
+	u64 address;
+	u32 entry_size;
+	u32 id;
+};
+
 /* Describes framebuffer setup by coreboot */
 struct lb_framebuffer {
 	u32 tag;
@@ -65,10 +77,16 @@ struct coreboot_device {
 	union {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
+		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
 	};
 };
 
+static inline struct coreboot_device *dev_to_coreboot_device(struct device *dev)
+{
+	return container_of(dev, struct coreboot_device, dev);
+}
+
 /* A driver for handling devices described in coreboot tables. */
 struct coreboot_driver {
 	int (*probe)(struct coreboot_device *);
-- 
2.38.1.431.g37b22c650d-goog

