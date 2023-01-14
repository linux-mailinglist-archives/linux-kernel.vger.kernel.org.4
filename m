Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690A066AA6B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjANJ1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjANJ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:27:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8137A81
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:20 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NvCZX0y6mzJrQQ;
        Sat, 14 Jan 2023 17:25:56 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 14 Jan
 2023 17:27:16 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v6 1/5] vfio/migration: Add debugfs to live migration driver
Date:   Sat, 14 Jan 2023 17:26:11 +0800
Message-ID: <20230114092615.51841-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230114092615.51841-1-liulongfang@huawei.com>
References: <20230114092615.51841-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

The entire debugfs directory will be based on the definition of
the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
interfaces in vfio_pci_debugfs.h will be empty definitions,
and the creation and initialization of the debugfs directory
will not be executed.

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
 drivers/vfio/pci/Makefile           |  1 +
 drivers/vfio/pci/vfio_pci_core.c    |  3 ++
 drivers/vfio/pci/vfio_pci_debugfs.c | 82 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_debugfs.h | 30 +++++++++++
 include/linux/vfio.h                |  6 +++
 5 files changed, 122 insertions(+)
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h

diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 24c524224da5..75fe37e72e8d 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -2,6 +2,7 @@
 
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
+vfio-pci-core-$(CONFIG_DEBUG_FS) += vfio_pci_debugfs.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
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
index 000000000000..169570de7ccb
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_debugfs.c
@@ -0,0 +1,82 @@
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
+	struct vfio_device *vdev = &core_device->vdev;
+	enum vfio_device_mig_state state;
+	int ret;
+
+	ret = vdev->mig_ops->migration_get_state(vdev, &state);
+	if (ret) {
+		dev_err("failed to get device migration state");
+		return -EINVAL;
+	}
+
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

