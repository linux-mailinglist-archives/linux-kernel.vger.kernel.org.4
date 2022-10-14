Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FC5FE733
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJNC7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:59:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7783F15F918
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:58:58 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpWGl5wpTzpVxm;
        Fri, 14 Oct 2022 10:55:43 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 10:58:56 +0800
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 10:58:55 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to migration driver
Date:   Fri, 14 Oct 2022 10:57:56 +0800
Message-ID: <20221014025757.39415-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221014025757.39415-1-liulongfang@huawei.com>
References: <20221014025757.39415-1-liulongfang@huawei.com>
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
live migration fails, I added a set of debugfs to the accelerator
live migration driver.

 +-----------------------------------+
 |                                   |
 |                QEMU               |
 |                                   |
 +---+--^--------------------+--^----+
     |  |                    |  |
     |  |                    |  |
 +---v--+----+           +---v--+----+
 |           |           |           |
 |   src VF  |           |  dest VF  |
 |           |           |           |
 +---+--^----+           +---+--^----+
     |  |                    |  |
     |  |                    |  |
 +---v--+----+           +---v--+----+
 |  Debugfs  |           |  Debugfs  |
 +-----+-----+           +-----+-----+
 |state|debug|           |state|debug|
 +-----+-----+           +-----+-----+

This set of debugfs will create two files for each VF device:
a state file and a debug file.

The migration status of the current VF device can be obtained by
reading the status file.

The live migration function of the current device can be tested by
operating the debug file, and the functional status of the equipment
and software at each stage can be tested step by step without
performing the complete live migration function. And after the live
migration is performed, the migration device data of the live migration
can be obtained through the debug file.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 296 ++++++++++++++++++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |  14 +
 2 files changed, 310 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 39eeca18a0f7..bed54e8e3a64 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021, HiSilicon Ltd.
  */
 
+#include <linux/anon_inodes.h>
 #include <linux/device.h>
 #include <linux/eventfd.h>
 #include <linux/file.h>
@@ -16,6 +17,9 @@
 
 #include "hisi_acc_vfio_pci.h"
 
+static struct dentry *hisi_acc_debugfs_root;
+static atomic_t hisi_acc_root_ref;
+
 /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_dev_not_ready(struct hisi_qm *qm)
 {
@@ -609,6 +613,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 	}
 }
 
+static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *src_migf,
+	struct hisi_acc_vf_migration_file *dst_migf)
+{
+	if (!dst_migf)
+		return;
+
+	dst_migf->disabled = false;
+	dst_migf->total_length = src_migf->total_length;
+	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
+		    sizeof(struct acc_vf_data));
+}
+
 static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
 {
 	mutex_lock(&migf->lock);
@@ -621,12 +637,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
 static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 {
 	if (hisi_acc_vdev->resuming_migf) {
+		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
+						hisi_acc_vdev->debug_migf);
 		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
 		fput(hisi_acc_vdev->resuming_migf->filp);
 		hisi_acc_vdev->resuming_migf = NULL;
 	}
 
 	if (hisi_acc_vdev->saving_migf) {
+		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
+						hisi_acc_vdev->debug_migf);
 		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
 		fput(hisi_acc_vdev->saving_migf->filp);
 		hisi_acc_vdev->saving_migf = NULL;
@@ -1176,6 +1196,277 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
 	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
 }
 
+static int hisi_acc_vf_debug_create(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct hisi_acc_vf_migration_file *migf;
+
+	migf = kzalloc(sizeof(*migf), GFP_KERNEL);
+	if (!migf)
+		return -ENOMEM;
+
+	migf->disabled = false;
+	hisi_acc_vdev->debug_migf = migf;
+	mutex_init(&migf->lock);
+
+	return 0;
+}
+
+static void hisi_acc_vf_debug_release(struct hisi_acc_vf_migration_file *migf)
+{
+	migf->disabled = true;
+	migf->total_length = 0;
+	mutex_destroy(&migf->lock);
+	kfree(migf);
+}
+
+static int hisi_acc_vf_debug_test(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
+	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
+	u64 data;
+	int ret;
+
+	data = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
+	dev_info(dev, "debug mailbox val: 0x%llx\n", data);
+
+	ret = qm_wait_dev_not_ready(vf_qm);
+	if (ret)
+		dev_err(dev, "VF device not ready!\n");
+
+	return ret;
+}
+
+static ssize_t hisi_acc_vf_debug_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	char buf[VFIO_DEV_DBG_LEN];
+	int len;
+
+	len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"echo 0: test vf state save\n"
+			"echo 1: test vf state resume\n"
+			"echo 2: test vf send mailbox\n"
+			"echo 3: dump vf config data\n"
+			"echo 4: dump vf migration state\n");
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static void hisi_acc_vf_dev_data_dump(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
+	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
+
+	if (hisi_acc_vdev->debug_migf &&
+	    hisi_acc_vdev->debug_migf->total_length) {
+		print_hex_dump(KERN_INFO, "dev mig data:",
+				DUMP_PREFIX_OFFSET, 16, 1,
+				(u8 *)&hisi_acc_vdev->debug_migf->vf_data,
+				vf_data_sz, false);
+	} else {
+		dev_info(dev, "device not migrated!\n");
+	}
+}
+
+static void hisi_acc_vf_dev_attr_show(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
+
+	if (hisi_acc_vdev->debug_migf &&
+	    hisi_acc_vdev->debug_migf->total_length) {
+		dev_info(dev, "acc device:\n"
+			 "device  state: %d\n"
+			 "device  ready: %u\n"
+			 "data    valid: %d\n"
+			 "data     size: %lu\n",
+			 hisi_acc_vdev->mig_state,
+			 hisi_acc_vdev->vf_qm_state,
+			 hisi_acc_vdev->debug_migf->disabled,
+			 hisi_acc_vdev->debug_migf->total_length);
+	}  else {
+		dev_info(dev, "device not migrated!\n");
+	}
+}
+
+static int hisi_acc_vf_debug_resume(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
+	int ret;
+
+	ret = vf_qm_state_save(hisi_acc_vdev, migf);
+	if (ret) {
+		dev_err(dev, "failed to save device data!\n");
+		return -EINVAL;
+	}
+
+	ret = vf_qm_check_match(hisi_acc_vdev, migf);
+	if (ret) {
+		dev_err(dev, "failed to match the VF!\n");
+		return -EINVAL;
+	}
+
+	ret = vf_qm_load_data(hisi_acc_vdev, migf);
+	if (ret) {
+		dev_err(dev, "failed to recover the VF!\n");
+		return -EINVAL;
+	}
+
+	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
+	dev_info(dev, "successful to resume device data!\n");
+
+	return 0;
+}
+
+static int hisi_acc_vf_debug_save(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+	struct device *dev = &hisi_acc_vdev->vf_dev->dev;
+	int ret;
+
+	ret = vf_qm_state_save(hisi_acc_vdev, migf);
+	if (ret) {
+		dev_err(dev, "failed to save device data!\n");
+		return -EINVAL;
+	}
+	dev_info(dev, "successful to save device data!\n");
+
+	return 0;
+}
+
+static ssize_t hisi_acc_vf_debug_write(struct file *filp, const char __user *buffer,
+			    size_t count, loff_t *pos)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = filp->private_data;
+	char tbuf[VFIO_DEV_DBG_LEN];
+	unsigned long val;
+	int len, ret;
+
+	if (*pos)
+		return 0;
+
+	if (count >= VFIO_DEV_DBG_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, VFIO_DEV_DBG_LEN - 1,
+					pos, buffer, count);
+	if (len < 0 || len > VFIO_DEV_DBG_LEN - 1)
+		return -EINVAL;
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	switch (val) {
+	case STATE_SAVE:
+		ret = hisi_acc_vf_debug_save(hisi_acc_vdev);
+		if (ret)
+			return ret;
+		break;
+	case STATE_RESUME:
+		ret = hisi_acc_vf_debug_resume(hisi_acc_vdev);
+		if (ret)
+			return ret;
+		break;
+	case MB_TEST:
+		ret = hisi_acc_vf_debug_test(hisi_acc_vdev);
+		if (ret)
+			return -EINVAL;
+		break;
+	case MIG_DATA_DUMP:
+		hisi_acc_vf_dev_data_dump(hisi_acc_vdev);
+		break;
+	case MIG_DEV_SHOW:
+		hisi_acc_vf_dev_attr_show(hisi_acc_vdev);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations hisi_acc_vf_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = hisi_acc_vf_debug_read,
+	.write = hisi_acc_vf_debug_write,
+};
+
+static ssize_t hisi_acc_vf_state_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = filp->private_data;
+	char buf[VFIO_DEV_DBG_LEN];
+	u32 state;
+	int len;
+
+	state = hisi_acc_vdev->mig_state;
+	switch (state) {
+	case VFIO_DEVICE_STATE_RUNNING:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"RUNNING\n");
+		break;
+	case VFIO_DEVICE_STATE_STOP_COPY:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"STOP and COPYING\n");
+		break;
+	case VFIO_DEVICE_STATE_STOP:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"STOP\n");
+		break;
+	case VFIO_DEVICE_STATE_RESUMING:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"RESUMING\n");
+		break;
+	default:
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"Error\n");
+	}
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static const struct file_operations hisi_acc_vf_state_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = hisi_acc_vf_state_read,
+};
+
+static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
+	struct device *dev = &vf_pdev->dev;
+	int ret;
+
+	if (!atomic_read(&hisi_acc_root_ref))
+		hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc", NULL);
+	atomic_inc(&hisi_acc_root_ref);
+
+	hisi_acc_vdev->debug_root = debugfs_create_dir(dev_name(dev), hisi_acc_debugfs_root);
+	debugfs_create_file("state", 0444, hisi_acc_vdev->debug_root,
+			    hisi_acc_vdev, &hisi_acc_vf_state_fops);
+
+	ret = hisi_acc_vf_debug_create(hisi_acc_vdev);
+	if (ret) {
+		dev_err(dev, "failed to alloc migration debug node\n");
+		return;
+	}
+	debugfs_create_file("debug", 0644, hisi_acc_vdev->debug_root,
+			    hisi_acc_vdev, &hisi_acc_vf_debug_fops);
+}
+
+static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	if (hisi_acc_vdev->debug_migf)
+		hisi_acc_vf_debug_release(hisi_acc_vdev->debug_migf);
+
+	debugfs_remove_recursive(hisi_acc_vdev->debug_root);
+
+	atomic_dec(&hisi_acc_root_ref);
+	if (!atomic_read(&hisi_acc_root_ref))
+		debugfs_remove_recursive(hisi_acc_debugfs_root);
+}
+
 static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
@@ -1194,6 +1485,8 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 			return ret;
 		}
 		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_RUNNING;
+
+		hisi_acc_vf_debugfs_init(hisi_acc_vdev);
 	}
 
 	vfio_pci_core_finish_enable(vdev);
@@ -1206,6 +1499,9 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
 			struct hisi_acc_vf_core_device, core_device.vdev);
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 
+	if (core_vdev->mig_ops)
+		hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
+
 	iounmap(vf_qm->io_base);
 	vfio_pci_core_close_device(core_vdev);
 }
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 67343325b320..ae2a686c2e4d 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -4,8 +4,11 @@
 #ifndef HISI_ACC_VFIO_PCI_H
 #define HISI_ACC_VFIO_PCI_H
 
+#include <linux/debugfs.h>
 #include <linux/hisi_acc_qm.h>
 
+#define VFIO_DEV_DBG_LEN		256
+
 #define MB_POLL_PERIOD_US		10
 #define MB_POLL_TIMEOUT_US		1000
 #define QM_CACHE_WB_START		0x204
@@ -49,6 +52,14 @@
 #define QM_EQC_DW0		0X8000
 #define QM_AEQC_DW0		0X8020
 
+enum mig_debug_cmd {
+	STATE_SAVE,
+	STATE_RESUME,
+	MB_TEST,
+	MIG_DATA_DUMP,
+	MIG_DEV_SHOW,
+};
+
 struct acc_vf_data {
 #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
 	/* QM match information */
@@ -111,5 +122,8 @@ struct hisi_acc_vf_core_device {
 	spinlock_t reset_lock;
 	struct hisi_acc_vf_migration_file *resuming_migf;
 	struct hisi_acc_vf_migration_file *saving_migf;
+	/* For debugfs */
+	struct dentry *debug_root;
+	struct hisi_acc_vf_migration_file *debug_migf;
 };
 #endif /* HISI_ACC_VFIO_PCI_H */
-- 
2.24.0

