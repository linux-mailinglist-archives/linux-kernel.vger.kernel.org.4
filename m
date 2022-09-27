Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E15ECF00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiI0U4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiI0U4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:56:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AE6149D2F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:56:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h194so8737384iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NLdmA2G3+4LKjzOS2LFvW4d2eEyJUZSkBqrqnf9gmSE=;
        b=d1Eg4jHVT/hoyfN4G8pEbWok3WM/2/ssBADJdX+s1k09eszH+2IJGiujEJsmn1tq/e
         VqrBk/jCxqglGBZBeEj2x7RTWYESs+WVgIf6in/vWWUYMEWbkY0bl7PdhRVUcVuIezeY
         rFkSZDv2RyXAcvj+6suBVErOmsyS/sVc77OdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NLdmA2G3+4LKjzOS2LFvW4d2eEyJUZSkBqrqnf9gmSE=;
        b=IiAO4eP4eK73qgLWL/OmHvWa2VltgkfAL+I5x0PcrPbcAjKBX3X5C6UX5mpsvct/YC
         5qnqc+BFJEOdf7+mVf5mwvUC31KByMlS1WhmjdXnWGSsvnOvpbq8mDBfgT34k9PqrQMT
         LwILg59jZKRmqgpFrSYD0RFEBcqeKtqkV+hs35wuwYF85uCI2D2uSB1M9jWQhqHtym64
         LOIsXCbadmnlwS1bizFjr/kUDInSLO+KpBVV+/9vqOm3zbSHbbujJfRdcAaADF5waVzf
         rtQvJKAAR6zq6bKJC0C5dWUbTCPwchGVGJgMUADpVaYKLtHdDH40gTatDCC18F81JfRd
         oWAQ==
X-Gm-Message-State: ACrzQf26/pD00ZQV+nElFCoLqRyUBUsRBCwn4FFeYgQyPzMkWmAC17xF
        0klJ7PPSjBXtyAjy9WEWIkT9txxfomysSQ==
X-Google-Smtp-Source: AMsMyM7hvmXiBFA4XsfgP5YBRDTE/73QXRBT/fFeicer5obGPDJfco3H/6ZM7S+xFVVK7jWXounMoQ==
X-Received: by 2002:a05:6638:4304:b0:343:5953:5fc8 with SMTP id bt4-20020a056638430400b0034359535fc8mr15406481jab.123.1664312178016;
        Tue, 27 Sep 2022 13:56:18 -0700 (PDT)
Received: from jrosenth45.lan (c-73-217-34-248.hsd1.co.comcast.net. [73.217.34.248])
        by smtp.gmail.com with ESMTPSA id p6-20020a0566022b0600b006a10d068d39sm1151901iov.41.2022.09.27.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:56:17 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        gregkh@linuxfoundation.org
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [RESEND PATCH v10] firmware: google: Implement cbmem in sysfs driver
Date:   Tue, 27 Sep 2022 14:55:51 -0600
Message-Id: <20220927205551.2017473-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
via sysfs under /sys/firmware/coreboot/cbmem/<id>.

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
/sys/firmware/coreboot/cbmem/<id>/mem, as the existing cbmem tooling
updates this memory region, and envisioned use cases with crossystem
can benefit from updating memory regions.

Link: https://issuetracker.google.com/239604743
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
 .../ABI/testing/sysfs-firmware-coreboot       |  49 ++++
 drivers/firmware/google/Kconfig               |   8 +
 drivers/firmware/google/Makefile              |   3 +
 drivers/firmware/google/cbmem.c               | 225 ++++++++++++++++++
 drivers/firmware/google/coreboot_table.c      |  10 +
 drivers/firmware/google/coreboot_table.h      |  16 ++
 6 files changed, 311 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
 create mode 100644 drivers/firmware/google/cbmem.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
new file mode 100644
index 000000000000..c003eb515d0c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
@@ -0,0 +1,49 @@
+What:		/sys/firmware/coreboot/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Kernel objects associated with the Coreboot-based BIOS firmware.
+
+What:		/sys/firmware/coreboot/cbmem/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Coreboot provides a variety of information in CBMEM.  This
+		directory contains each CBMEM entry, which can be found via
+		Coreboot tables.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Each CBMEM entry is given a directory based on the id
+		corresponding to the entry.  A list of ids known to coreboot can
+		be found in the coreboot source tree at
+		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/address
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The memory address that the CBMEM entry's data begins at.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/size
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The size of the data being stored.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/id
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The CBMEM id corresponding to the entry.
+
+What:		/sys/firmware/coreboot/cbmem/<id>/mem
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		A file exposing read/write access to the entry's data.  Note
+		that this file does not support mmap(), and should be used for
+		basic data access only.  Users requiring mmap() should read the
+		address and size files, and mmap() /dev/mem.
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 983e07dc022e..b0f7a24fd90a 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -19,6 +19,14 @@ config GOOGLE_SMI
 	  driver provides an interface for reading and writing NVRAM
 	  variables.
 
+config GOOGLE_CBMEM
+	tristate "CBMEM entries in sysfs"
+	depends on GOOGLE_COREBOOT_TABLE
+	help
+	  This option enables the kernel to search for Coreboot CBMEM
+	  entries, and expose the memory for each entry in sysfs under
+	  /sys/firmware/coreboot/cbmem.
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
index 000000000000..835950a14fa6
--- /dev/null
+++ b/drivers/firmware/google/cbmem.c
@@ -0,0 +1,225 @@
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
+#define LB_TAG_CBMEM_ENTRY 0x31
+
+static struct kobject *cbmem_kobj;
+
+struct cbmem_entry;
+struct cbmem_entry_attr {
+	struct kobj_attribute kobj_attr;
+	struct cbmem_entry *entry;
+};
+
+struct cbmem_entry {
+	struct kobject *kobj;
+	struct coreboot_device *dev;
+	struct bin_attribute mem_file;
+	char *mem_file_buf;
+	struct cbmem_entry_attr address_file;
+	struct cbmem_entry_attr size_file;
+	struct cbmem_entry_attr id_file;
+};
+
+static struct cbmem_entry_attr *to_cbmem_entry_attr(struct kobj_attribute *a)
+{
+	return container_of(a, struct cbmem_entry_attr, kobj_attr);
+}
+
+static ssize_t cbmem_entry_mem_read(struct file *filp, struct kobject *kobp,
+				    struct bin_attribute *bin_attr, char *buf,
+				    loff_t pos, size_t count)
+{
+	struct cbmem_entry *entry = bin_attr->private;
+
+	return memory_read_from_buffer(buf, count, &pos, entry->mem_file_buf,
+				       bin_attr->size);
+}
+
+static ssize_t cbmem_entry_mem_write(struct file *filp, struct kobject *kobp,
+				     struct bin_attribute *bin_attr, char *buf,
+				     loff_t pos, size_t count)
+{
+	struct cbmem_entry *entry = bin_attr->private;
+
+	if (pos < 0 || pos >= bin_attr->size)
+		return -EINVAL;
+	if (count > bin_attr->size - pos)
+		count = bin_attr->size - pos;
+
+	memcpy(entry->mem_file_buf + pos, buf, count);
+	return count;
+}
+
+static ssize_t cbmem_entry_address_show(struct kobject *kobj,
+					struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "0x%llx\n",
+			  entry_attr->entry->dev->cbmem_entry.address);
+}
+
+static ssize_t cbmem_entry_size_show(struct kobject *kobj,
+				     struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "0x%x\n",
+			  entry_attr->entry->dev->cbmem_entry.entry_size);
+}
+
+static ssize_t cbmem_entry_id_show(struct kobject *kobj,
+				   struct kobj_attribute *a, char *buf)
+{
+	struct cbmem_entry_attr *entry_attr = to_cbmem_entry_attr(a);
+
+	return sysfs_emit(buf, "0x%08x\n",
+			  entry_attr->entry->dev->cbmem_entry.id);
+}
+
+static int cbmem_entry_probe(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry;
+	char *kobj_name;
+	int ret;
+
+	entry = devm_kzalloc(&dev->dev, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dev->dev, entry);
+	entry->dev = dev;
+	entry->mem_file_buf =
+		devm_memremap(&entry->dev->dev, entry->dev->cbmem_entry.address,
+			      entry->dev->cbmem_entry.entry_size, MEMREMAP_WB);
+	if (!entry->mem_file_buf)
+		return -ENOMEM;
+
+	kobj_name = devm_kasprintf(&entry->dev->dev, GFP_KERNEL, "%08x",
+				   entry->dev->cbmem_entry.id);
+	if (!kobj_name)
+		return -ENOMEM;
+
+	entry->kobj = kobject_create_and_add(kobj_name, cbmem_kobj);
+	if (!entry->kobj)
+		return -ENOMEM;
+
+	sysfs_bin_attr_init(&entry->mem_file);
+	entry->mem_file.attr.name = "mem";
+	entry->mem_file.attr.mode = 0600;
+	entry->mem_file.size = entry->dev->cbmem_entry.entry_size;
+	entry->mem_file.read = cbmem_entry_mem_read;
+	entry->mem_file.write = cbmem_entry_mem_write;
+	entry->mem_file.private = entry;
+	ret = sysfs_create_bin_file(entry->kobj, &entry->mem_file);
+	if (ret)
+		goto free_kobj;
+
+	sysfs_attr_init(&entry->address_file.kobj_attr.attr);
+	entry->address_file.kobj_attr.attr.name = "address";
+	entry->address_file.kobj_attr.attr.mode = 0444;
+	entry->address_file.kobj_attr.show = cbmem_entry_address_show;
+	entry->address_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj,
+				&entry->address_file.kobj_attr.attr);
+	if (ret)
+		goto free_mem_file;
+
+	sysfs_attr_init(&entry->size_file.kobj_attr.attr);
+	entry->size_file.kobj_attr.attr.name = "size";
+	entry->size_file.kobj_attr.attr.mode = 0444;
+	entry->size_file.kobj_attr.show = cbmem_entry_size_show;
+	entry->size_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+	if (ret)
+		goto free_address_file;
+
+	sysfs_attr_init(&entry->id_file.kobj_attr.attr);
+	entry->id_file.kobj_attr.attr.name = "id";
+	entry->id_file.kobj_attr.attr.mode = 0444;
+	entry->id_file.kobj_attr.show = cbmem_entry_id_show;
+	entry->id_file.entry = entry;
+	ret = sysfs_create_file(entry->kobj, &entry->id_file.kobj_attr.attr);
+	if (ret)
+		goto free_size_file;
+
+	return 0;
+
+free_size_file:
+	sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+free_address_file:
+	sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
+free_mem_file:
+	sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
+free_kobj:
+	kobject_put(entry->kobj);
+	return ret;
+}
+
+static void cbmem_entry_remove(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry = dev_get_drvdata(&dev->dev);
+
+	sysfs_remove_bin_file(entry->kobj, &entry->mem_file);
+	sysfs_remove_file(entry->kobj, &entry->address_file.kobj_attr.attr);
+	sysfs_remove_file(entry->kobj, &entry->size_file.kobj_attr.attr);
+	sysfs_remove_file(entry->kobj, &entry->id_file.kobj_attr.attr);
+	kobject_put(entry->kobj);
+}
+
+static struct coreboot_driver cbmem_entry_driver = {
+	.probe = cbmem_entry_probe,
+	.remove = cbmem_entry_remove,
+	.drv = {
+		.name = "cbmem",
+		.owner = THIS_MODULE,
+	},
+	.tag = LB_TAG_CBMEM_ENTRY,
+};
+
+static int __init cbmem_init(void)
+{
+	int ret;
+
+	cbmem_kobj = kobject_create_and_add("cbmem", coreboot_kobj);
+	if (!cbmem_kobj)
+		return -ENOMEM;
+
+	ret = coreboot_driver_register(&cbmem_entry_driver);
+	if (ret) {
+		kobject_put(cbmem_kobj);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(cbmem_init);
+
+static void __exit cbmem_exit(void)
+{
+	kobject_put(cbmem_kobj);
+	coreboot_driver_unregister(&cbmem_entry_driver);
+}
+module_exit(cbmem_exit);
+
+MODULE_AUTHOR("Jack Rosenthal <jrosenth@chromium.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index c52bcaa9def6..a3e2720e4638 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -14,16 +14,21 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "coreboot_table.h"
 
 #define CB_DEV(d) container_of(d, struct coreboot_device, dev)
 #define CB_DRV(d) container_of(d, struct coreboot_driver, drv)
 
+struct kobject *coreboot_kobj;
+EXPORT_SYMBOL(coreboot_kobj);
+
 static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct coreboot_device *device = CB_DEV(dev);
@@ -157,6 +162,10 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	}
 	memunmap(ptr);
 
+	coreboot_kobj = kobject_create_and_add("coreboot", firmware_kobj);
+	if (!coreboot_kobj)
+		return -ENOMEM;
+
 	return ret;
 }
 
@@ -170,6 +179,7 @@ static int coreboot_table_remove(struct platform_device *pdev)
 {
 	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
 	bus_unregister(&coreboot_bus_type);
+	kobject_put(coreboot_kobj);
 	return 0;
 }
 
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index beb778674acd..76c31e6e5376 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -14,6 +14,11 @@
 
 #include <linux/device.h>
 
+struct kobject;
+
+/* This is /sys/firmware/coreboot */
+extern struct kobject *coreboot_kobj;
+
 /* Coreboot table header structure */
 struct coreboot_table_header {
 	char signature[4];
@@ -39,6 +44,16 @@ struct lb_cbmem_ref {
 	u64 cbmem_addr;
 };
 
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
@@ -65,6 +80,7 @@ struct coreboot_device {
 	union {
 		struct coreboot_table_entry entry;
 		struct lb_cbmem_ref cbmem_ref;
+		struct lb_cbmem_entry cbmem_entry;
 		struct lb_framebuffer framebuffer;
 	};
 };
-- 
2.37.3.998.g577e59143f-goog

