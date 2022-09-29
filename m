Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CC5F0181
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiI2Xoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiI2Xon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:44:43 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FEAB7F5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:44:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id 8so164265ilj.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rxgsUzGFfaE00+2czt71ypS2ZsMq8C5jXQg7zMlFA7Y=;
        b=I0fxf0CU7LPjwnC9ncUIEK60On8YI8fv6Qh8OpTU370XWQ0kuQlNLrqNvVw6+5MGE9
         tgDq8193SdivMS9v4vWhOhEP7fZ9EoTAIjT6zzpMhLoTTupJYggemvqzizwQCXfdSHeG
         ztnL3+7TVSU9w3yF7nQ5rfdJctYM9IDyFqcac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rxgsUzGFfaE00+2czt71ypS2ZsMq8C5jXQg7zMlFA7Y=;
        b=KSOKqAjYwXDYnDbMmBRf6UlT3WxKadprdllR+kWAO5Bwla6bayGF8JlIb+tNX5QEM1
         gX3zUQh8kAt91fmlVm4wGeZscfAxvuNHZkk+zS7dzFx/hg0+rmDjtu17G9SYf4Ux9PUF
         bDyVkz3MF9Q5Zu+y6mG2EjniIjyfCWE4+chWmO3ScDVjawp2Iv6Q9DDnZTrgpoJz2Zjn
         MvQP59ORaVwrZZ2v9h5DTVNEiYwz5cIpIkda9IbS1Czji3pQ33VGs703dz9GfDGLC87Q
         woaKaLHFfMmIFZs04x8RCP7C4YJblm2QOYoeE14FQjL9/uEi4gte7cmk/55B1HcD0m1O
         NGNg==
X-Gm-Message-State: ACrzQf2Ml+8uIxxLUFTk14hAtLQaBsVTfa5VBdYlapx6XSzzyGW+mjgn
        eJc8IRy8bvTx4dx38SMtAYF6gpztIgz7Kcvr
X-Google-Smtp-Source: AMsMyM7oVz8ewVW0GH6hS1jHo9RS2ZmIyef0H17o/OZ+TlSQYKqwNzjEQJXZS7Tn7xAOibyiOX7qsg==
X-Received: by 2002:a92:2c0e:0:b0:2f5:64eb:34a4 with SMTP id t14-20020a922c0e000000b002f564eb34a4mr3095070ile.188.1664495080219;
        Thu, 29 Sep 2022 16:44:40 -0700 (PDT)
Received: from jrosenth45.lan (c-73-217-34-248.hsd1.co.comcast.net. [73.217.34.248])
        by smtp.gmail.com with ESMTPSA id c40-20020a023f68000000b00358430a719dsm319559jaf.40.2022.09.29.16.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:44:39 -0700 (PDT)
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        gregkh@linuxfoundation.org
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: [PATCH v11] firmware: google: Implement cbmem in sysfs driver
Date:   Thu, 29 Sep 2022 17:44:32 -0600
Message-Id: <20220929234432.3711480-1-jrosenth@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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
via sysfs under /sys/firmware/cbmem/<id>.

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
/sys/firmware/cbmem/<id>/mem, as the existing cbmem tooling updates
this memory region, and envisioned use cases with crossystem
can benefit from updating memory regions.

Link: https://issuetracker.google.com/239604743
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Julius Werner <jwerner@chromium.org>
Tested-by: Jack Rosenthal <jrosenth@chromium.org>
Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
---
Changes in v11:
* Changed /sys/firmware/coreboot/cbmem -> /sys/firmware/cbmem
* cbmem.c uses attribute groups to initialize files, which is much
  cleaner.  The attributes are added under the device kobject, which
  is now symlinked into /sys/firmware/cbmem.
* Changed documentation text as suggested by greg k-h

 .../ABI/testing/sysfs-firmware-cbmem          |  43 +++++
 drivers/firmware/google/Kconfig               |   8 +
 drivers/firmware/google/Makefile              |   3 +
 drivers/firmware/google/cbmem.c               | 180 ++++++++++++++++++
 drivers/firmware/google/coreboot_table.h      |  16 ++
 5 files changed, 250 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-cbmem
 create mode 100644 drivers/firmware/google/cbmem.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-cbmem b/Documentation/ABI/testing/sysfs-firmware-cbmem
new file mode 100644
index 000000000000..f769104ac4cd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-cbmem
@@ -0,0 +1,43 @@
+What:		/sys/firmware/cbmem/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Coreboot provides a variety of data structures in CBMEM.  This
+		directory contains each CBMEM entry, which can be found via
+		Coreboot tables.
+
+What:		/sys/firmware/cbmem/<id>/
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		Each CBMEM entry is given a directory based on the id
+		corresponding to the entry.  A list of ids known to coreboot can
+		be found in the coreboot source tree at
+		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
+
+What:		/sys/firmware/cbmem/<id>/address
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The pyhsical memory address that the CBMEM entry's data begins
+		at.
+
+What:		/sys/firmware/cbmem/<id>/size
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The size of the CBMEM entry's data.
+
+What:		/sys/firmware/cbmem/<id>/id
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		The CBMEM id corresponding to the entry.
+
+What:		/sys/firmware/cbmem/<id>/mem
+Date:		August 2022
+Contact:	Jack Rosenthal <jrosenth@chromium.org>
+Description:
+		A file exposing read/write access to the entry's data.  Note
+		that this file does not support mmap(), as coreboot
+		does not guarantee that the data will be page-aligned.
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index 983e07dc022e..485934cc9663 100644
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
+	  /sys/firmware/cbmem.
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
index 000000000000..fe814589f641
--- /dev/null
+++ b/drivers/firmware/google/cbmem.c
@@ -0,0 +1,180 @@
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
+struct cbmem_entry {
+	char *mem_file_buf;
+	u32 size;
+	char *link_name;
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
+static ssize_t id_show(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct coreboot_device *cbdev = dev_to_coreboot_device(dev);
+
+	return sysfs_emit(buf, "0x%08x\n", cbdev->cbmem_entry.id);
+}
+static DEVICE_ATTR_RO(id);
+
+static struct attribute *attrs[] = {
+	&dev_attr_address.attr,
+	&dev_attr_size.attr,
+	&dev_attr_id.attr,
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
+	entry->link_name = devm_kasprintf(&dev->dev, GFP_KERNEL, "%08x",
+					  dev->cbmem_entry.id);
+	if (!entry->link_name)
+		return -ENOMEM;
+
+	return sysfs_create_link(cbmem_kobj, &dev->dev.kobj, entry->link_name);
+}
+
+static void cbmem_entry_remove(struct coreboot_device *dev)
+{
+	struct cbmem_entry *entry = dev_get_drvdata(&dev->dev);
+
+	sysfs_remove_link(cbmem_kobj, entry->link_name);
+}
+
+static struct coreboot_driver cbmem_entry_driver = {
+	.probe = cbmem_entry_probe,
+	.remove = cbmem_entry_remove,
+	.drv = {
+		.name = "cbmem",
+		.owner = THIS_MODULE,
+		.dev_groups = dev_groups,
+	},
+	.tag = LB_TAG_CBMEM_ENTRY,
+};
+
+static int __init cbmem_init(void)
+{
+	int ret;
+
+	cbmem_kobj = kobject_create_and_add("cbmem", firmware_kobj);
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
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
index beb778674acd..4666fddf28d6 100644
--- a/drivers/firmware/google/coreboot_table.h
+++ b/drivers/firmware/google/coreboot_table.h
@@ -39,6 +39,16 @@ struct lb_cbmem_ref {
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
@@ -65,10 +75,16 @@ struct coreboot_device {
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
2.38.0.rc1.362.ged0d419d3c-goog

