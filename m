Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1457B64F7ED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 07:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLQGek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 01:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiLQGei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 01:34:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AC22528
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:34:36 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NYx0k1c8yzqT9c;
        Sat, 17 Dec 2022 14:30:14 +0800 (CST)
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 17 Dec
 2022 14:34:34 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v5 1/5] vfio/migration: Add debugfs to live migration driver
Date:   Sat, 17 Dec 2022 14:32:44 +0800
Message-ID: <20221217063248.6735-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221217063248.6735-1-liulongfang@huawei.com>
References: <20221217063248.6735-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 |Debugfs|state   |        |Debugfs|state   |
 +-------+--------+        +-------+--------+
 |   debug_root   |        |   debug_root   |
 +-------+--------+        +-------+--------+

debugfs will create a public root directory "vfio_mig" file.
then create a "debug_root" file for each live migration VF device.
state file: used to get the status of the live migration device.
debug_root: used to create your own custom debug files for live
migration device drivers.

The live migration function of the current device can be tested by
operating the debug files, and the functional status of the equipment
and software at each stage can be tested step by step without
performing the complete live migration function. And after the live
migration is performed, the migration device data of the live migration
can be obtained through the debug files.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/Makefile           |  4 ++
 drivers/vfio/pci/vfio_pci_core.c    |  3 ++
 drivers/vfio/pci/vfio_pci_debugfs.c | 76 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_debugfs.h | 30 ++++++++++++
 include/linux/vfio.h                |  6 +++
 5 files changed, 119 insertions(+)
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
index f9365a5bc961..e85df2deb8e6 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -31,6 +31,7 @@
 #include <asm/eeh.h>
 #endif
 
+#include "vfio_pci_debugfs.h"
 #include "vfio_pci_priv.h"
 
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -2555,11 +2556,13 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
 
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
index 000000000000..33d663fb04f2
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_debugfs.c
@@ -0,0 +1,76 @@
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
+static struct dentry *vfio_pci_debugfs_root;
+
+static int vfio_pci_vf_state_read(struct seq_file *seq, void *data)
+{
+	struct device *vf_dev = seq->private;
+	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
+	struct vfio_device	*vdev = &core_device->vdev;
+	enum vfio_device_mig_state state;
+
+	(void)vdev->mig_ops->migration_get_state(vdev, &state);
+	switch (state) {
+	case VFIO_DEVICE_STATE_RUNNING:
+		seq_printf(seq, "%s\n", "RUNNING");
+		break;
+	case VFIO_DEVICE_STATE_STOP_COPY:
+		seq_printf(seq, "%s\n", "STOP_COPY");
+		break;
+	case VFIO_DEVICE_STATE_STOP:
+		seq_printf(seq, "%s\n", "STOP");
+		break;
+	case VFIO_DEVICE_STATE_RESUMING:
+		seq_printf(seq, "%s\n", "RESUMING");
+		break;
+	case VFIO_DEVICE_STATE_RUNNING_P2P:
+		seq_printf(seq, "%s\n", "RESUMING_P2P");
+		break;
+	case VFIO_DEVICE_STATE_ERROR:
+		seq_printf(seq, "%s\n", "ERROR");
+		break;
+	default:
+		seq_printf(seq, "%s\n", "Invalid");
+	}
+
+	return 0;
+}
+
+void vfio_pci_vf_debugfs_init(struct vfio_device *vdev)
+{
+	struct device *dev = vdev->dev;
+
+	vdev->debug_root = debugfs_create_dir(dev_name(dev), vfio_pci_debugfs_root);
+
+	debugfs_create_devm_seqfile(dev, "state", vdev->debug_root,
+				  vfio_pci_vf_state_read);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_init);
+
+void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev)
+{
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
index 000000000000..8d1a4aef05db
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
+void vfio_pci_vf_debugfs_init(struct vfio_device *vdev);
+void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev);
+#else
+static inline void vfio_pci_debugfs_create_root(void) { }
+static inline void vfio_pci_debugfs_remove_root(void) { }
+
+static inline void vfio_pci_vf_debugfs_init(struct vfio_device *vdev) { }
+static inline void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev) { }
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* __VFIO_PCI_DEBUGFS_H */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index b4d5d4ca3d7d..7d6d02f165cf 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -54,6 +54,12 @@ struct vfio_device {
 	struct completion comp;
 	struct list_head group_next;
 	struct list_head iommu_entry;
+
+	/*
+	 * debug_root is a static property of the vfio_device
+	 * which must be set prior to registering the vfio_device.
+	 */
+	struct dentry *debug_root;
 };
 
 /**
-- 
2.24.0

