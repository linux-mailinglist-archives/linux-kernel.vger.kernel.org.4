Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64B63A001
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiK1DNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK1DNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:13:36 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA118CE0A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:13:34 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NL9Wr0qtZz15MZT;
        Mon, 28 Nov 2022 11:12:56 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:13:32 +0800
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 11:13:32 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <john.garry@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v3 1/5] vfio/migration: Add debugfs to live migration driver
Date:   Mon, 28 Nov 2022 11:11:56 +0800
Message-ID: <20221128031200.11017-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221128031200.11017-1-liulongfang@huawei.com>
References: <20221128031200.11017-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple devices, software and operational steps involved
in the process of live migration. An error occurred on any node may
cause the live migration operation to fail.
This complex process makes it very difficult to locate and analyze
the cause when the function fails.

In order to quickly locate the cause of the problem when the
live migration fails, I added a set of debugfs to the vfio
live migration driver.

 +------------------------------------------+
 |                                          |
 |                                          |
 |                 QEMU                     |
 |                                          |
 |                                          |
 +-----+-------------------------+----------+
       |   ^                     |   ^
       v   |                     v   |
     +-----+--+                +-----+--+
     | src VF |                | dst VF |
     +-+------+                +-+------+
       |   ^                     |   ^
       v   |                     v   |
 +-------+-+------+        +-------+-+------+
 |       |state   |        |       |state   |
 |       +--------+        |       +--------+
 |       |mig_data|        |       |mig_data|
 |Debugfs+--------+        |Debugfs+--------+
 |       |mig_attr|        |       |mig_attr|
 |       +--------+        |       +--------+
 |       |debug   |        |       |debug   |
 +-------+--------+        +-------+--------+

debugfs will create a public root directory vfio_mig.
Then create four debug files for each live migration driven VF.
state file: used to get the status of the live migration device.
mig_data file: used to get the migration data of the live migration device
mig_attr file: used to get device attributes of the live migration device
debug file: used to test migration-related functions, specific test
commands and test functions are added by device drivers.

The live migration function of the current device can be tested by
operating the debug file, and the functional status of the equipment
and software at each stage can be tested step by step without
performing the complete live migration function. And after the live
migration is performed, the migration device data of the live migration
can be obtained through the debug file.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/Makefile           |   4 +
 drivers/vfio/pci/vfio_pci_core.c    |   3 +
 drivers/vfio/pci/vfio_pci_debugfs.c | 230 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_debugfs.h |  30 ++++
 include/linux/vfio.h                |  16 ++
 5 files changed, 283 insertions(+)
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 24c524224da5..efe032623664 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -4,6 +4,10 @@ vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_con
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
+ifneq ($(CONFIG_DEBUG_FS),)
+	vfio-pci-core-y += vfio_pci_debugfs.o
+endif
+
 vfio-pci-y := vfio_pci.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
 obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 189d4930c276..1d6dd61aef7d 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -28,6 +28,7 @@
 #include <linux/nospec.h>
 #include <linux/sched/mm.h>
 
+#include "vfio_pci_debugfs.h"
 #include "vfio_pci_priv.h"
 
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -2548,11 +2549,13 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
 
 static void vfio_pci_core_cleanup(void)
 {
+	vfio_pci_debugfs_remove_root();
 	vfio_pci_uninit_perm_bits();
 }
 
 static int __init vfio_pci_core_init(void)
 {
+	vfio_pci_debugfs_create_root();
 	/* Allocate shared config space permission data used by all devices */
 	return vfio_pci_init_perm_bits();
 }
diff --git a/drivers/vfio/pci/vfio_pci_debugfs.c b/drivers/vfio/pci/vfio_pci_debugfs.c
new file mode 100644
index 000000000000..8faf609906c7
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_debugfs.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, HiSilicon Ltd.
+ */
+
+#include <linux/pci.h>
+#include <linux/vfio_pci_core.h>
+
+#include "vfio_pci_debugfs.h"
+
+#define VFIO_DEV_DBG_LEN		256
+static struct dentry *vfio_pci_debugfs_root;
+
+static int vfio_pci_vf_debug_create(struct vfio_device *core_vdev, size_t migf_size)
+{
+	void *migf;
+
+	migf = kzalloc(migf_size, GFP_KERNEL);
+	if (!migf)
+		return -ENOMEM;
+
+	core_vdev->vf_migration_file = migf;
+
+	return 0;
+}
+
+static void vfio_pci_vf_debug_release(struct vfio_device *core_vdev)
+{
+	if (core_vdev)
+		kfree(core_vdev->vf_migration_file);
+}
+
+static int vfio_pci_vf_debug_check(struct vfio_device *vdev)
+{
+	enum vfio_device_mig_state state;
+
+	if (!vdev->mig_ops || !vdev->mig_ops->migration_debug_operate) {
+		dev_err(vdev->dev, "device not support debugfs!\n");
+		return -EINVAL;
+	}
+
+	/* If device not opened, the debugfs operation will trigger calltrace */
+	(void)vdev->mig_ops->migration_get_state(vdev, &state);
+	if (state == VFIO_DEVICE_STATE_ERROR ||
+	     state == VFIO_DEVICE_STATE_STOP) {
+		dev_err(vdev->dev, "device not opened!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t vfio_pci_vf_debug_write(struct file *filp, const char __user *buffer,
+			    size_t count, loff_t *pos)
+{
+	struct vfio_device	*vdev = filp->private_data;
+	char tbuf[VFIO_DEV_DBG_LEN];
+	unsigned long cmd;
+	int len, ret;
+
+	if (*pos)
+		return 0;
+
+	if (count >= VFIO_DEV_DBG_LEN)
+		return -ENOSPC;
+
+	ret = vfio_pci_vf_debug_check(vdev);
+	if (ret)
+		return -EINVAL;
+
+	len = simple_write_to_buffer(tbuf, VFIO_DEV_DBG_LEN - 1,
+					pos, buffer, count);
+	if (len < 0 || len > VFIO_DEV_DBG_LEN - 1)
+		return -EINVAL;
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &cmd))
+		return -EFAULT;
+
+	ret = vdev->mig_ops->migration_debug_operate(vdev, cmd);
+	if (ret) {
+		dev_err(vdev->dev, "device debug test failed!\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations vfio_vf_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = vfio_pci_vf_debug_write,
+};
+
+static ssize_t vfio_pci_vf_data_dump(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	struct vfio_device	*vdev = filp->private_data;
+	int  len;
+
+	if (!vdev->mig_ops || !vdev->mig_ops->migration_get_data) {
+		dev_err(vdev->dev, "device not support get data!\n");
+		return -EINVAL;
+	}
+
+	len = vdev->mig_ops->migration_get_data(vdev, buffer);
+
+	return len;
+}
+
+static const struct file_operations vfio_vf_data_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = vfio_pci_vf_data_dump,
+};
+
+static ssize_t vfio_pci_vf_attr_show(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	struct vfio_device	*vdev = filp->private_data;
+	int  len;
+
+	if (!vdev->mig_ops || !vdev->mig_ops->migration_get_attr) {
+		dev_err(vdev->dev, "device not support get attribute!\n");
+		return -EINVAL;
+	}
+
+	len = vdev->mig_ops->migration_get_attr(vdev, buffer);
+
+	return len;
+}
+
+static const struct file_operations vfio_vf_attr_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = vfio_pci_vf_attr_show,
+};
+
+static ssize_t vfio_pci_vf_state_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	struct vfio_device	*vdev = filp->private_data;
+	char buf[VFIO_DEV_DBG_LEN];
+	enum vfio_device_mig_state state;
+	int  len;
+
+	(void)vdev->mig_ops->migration_get_state(vdev, &state);
+	switch (state) {
+	case VFIO_DEVICE_STATE_RUNNING:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"RUNNING\n");
+		break;
+	case VFIO_DEVICE_STATE_STOP_COPY:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"STOP_COPY\n");
+		break;
+	case VFIO_DEVICE_STATE_STOP:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"STOP\n");
+		break;
+	case VFIO_DEVICE_STATE_RESUMING:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"RESUMING\n");
+		break;
+	case VFIO_DEVICE_STATE_RUNNING_P2P:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"RESUMING_P2P\n");
+		break;
+	case VFIO_DEVICE_STATE_ERROR:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"ERROR\n");
+		break;
+	default:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"Invalid\n");
+	}
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static const struct file_operations vfio_vf_state_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = vfio_pci_vf_state_read,
+};
+
+void vfio_pci_vf_debugfs_init(struct vfio_device *vdev, size_t migf_size)
+{
+	struct device *dev = vdev->dev;
+	int ret;
+
+	vdev->debug_root = debugfs_create_dir(dev_name(dev), vfio_pci_debugfs_root);
+	debugfs_create_file("state", 0444, vdev->debug_root,
+				  vdev, &vfio_vf_state_fops);
+
+	debugfs_create_file("mig_data", 0444, vdev->debug_root,
+				  vdev, &vfio_vf_data_fops);
+
+	debugfs_create_file("mig_attr", 0444, vdev->debug_root,
+				  vdev, &vfio_vf_attr_fops);
+
+	ret = vfio_pci_vf_debug_create(vdev, migf_size);
+	if (ret) {
+		dev_err(dev, "failed to alloc migration debug node\n");
+		return;
+	}
+	debugfs_create_file("debug", 0200, vdev->debug_root,
+				  vdev, &vfio_vf_debug_fops);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_init);
+
+void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev)
+{
+	vfio_pci_vf_debug_release(vdev);
+	debugfs_remove_recursive(vdev->debug_root);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_exit);
+
+void  vfio_pci_debugfs_create_root(void)
+{
+	vfio_pci_debugfs_root = debugfs_create_dir("vfio_mig", NULL);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_debugfs_create_root);
+
+void  vfio_pci_debugfs_remove_root(void)
+{
+	debugfs_remove_recursive(vfio_pci_debugfs_root);
+	vfio_pci_debugfs_root = NULL;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_debugfs_remove_root);
+
diff --git a/drivers/vfio/pci/vfio_pci_debugfs.h b/drivers/vfio/pci/vfio_pci_debugfs.h
new file mode 100644
index 000000000000..34ae6de41a2f
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_debugfs.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * vfio_pci_debugfs.h - VFIO migration debugfs interface
+ *
+ * Copyright (c) 2022, HiSilicon Ltd.
+ *
+ * Author: Longfang Liu <liulongfang@huawei.com>
+ */
+
+#ifndef __VFIO_PCI_DEBUGFS_H
+#define __VFIO_PCI_DEBUGFS_H
+
+#include <linux/debugfs.h>
+#include <linux/vfio.h>
+
+#ifdef CONFIG_DEBUG_FS
+void  vfio_pci_debugfs_create_root(void);
+void  vfio_pci_debugfs_remove_root(void);
+
+void vfio_pci_vf_debugfs_init(struct vfio_device *vdev, size_t migf_size);
+void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev);
+#else
+static inline void vfio_pci_debugfs_create_root(void) { }
+static inline void vfio_pci_debugfs_remove_root(void) { }
+
+static inline void vfio_pci_vf_debugfs_init(struct vfio_device *vdev, size_t migf_size) { }
+static inline void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev) { }
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* __VFIO_PCI_DEBUGFS_H */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 43b67e46a2cb..dd1299acb69a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -54,6 +54,13 @@ struct vfio_device {
 	struct completion comp;
 	struct list_head group_next;
 	struct list_head iommu_entry;
+
+	/*
+	 * debug_root is a static property of the vfio_device
+	 * which must be set prior to registering the vfio_device.
+	 */
+	struct dentry *debug_root;
+	void *vf_migration_file;
 };
 
 /**
@@ -110,6 +117,12 @@ struct vfio_device_ops {
  * @migration_get_data_size: Optional callback to get the estimated data
  *          length that will be required to complete stop copy. It's mandatory for
  *          VFIO_DEVICE_FEATURE_MIGRATION migration support.
+ * @migration_get_data: Optional callback to get the migration data
+ *         that will be required by vfio debugfs.
+ * @migration_get_attr: Optional callback to get the device attributes
+ *         that will be required by vfio debugfs.
+ * @migration_debug_operate: Optional callback for step-by-step debugging
+ *         of the live migration function.
  */
 struct vfio_migration_ops {
 	struct file *(*migration_set_state)(
@@ -119,6 +132,9 @@ struct vfio_migration_ops {
 				   enum vfio_device_mig_state *curr_state);
 	int (*migration_get_data_size)(struct vfio_device *device,
 				       unsigned long *stop_copy_length);
+	int (*migration_get_data)(struct vfio_device *device, char *buffer);
+	int (*migration_get_attr)(struct vfio_device *device, char *buffer);
+	int (*migration_debug_operate)(struct vfio_device *device, unsigned int cmd);
 };
 
 /**
-- 
2.24.0

