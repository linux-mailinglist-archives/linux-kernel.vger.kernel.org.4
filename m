Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2753640354
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbiLBJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiLBJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:29:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE98C45E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:29:03 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNng705BDzRpl4;
        Fri,  2 Dec 2022 17:28:18 +0800 (CST)
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 17:29:01 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <john.garry@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v4 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
Date:   Fri, 2 Dec 2022 17:26:23 +0800
Message-ID: <20221202092625.35075-4-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221202092625.35075-1-liulongfang@huawei.com>
References: <20221202092625.35075-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the debugfs framework of VFIO, register the debug function
for the live migration driver of the hisilicon accelerator device.

On the basis of the original public debug function, a private debug
function is added, so that the single-step debugging function
during live migration can be realized.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 250 ++++++++++++++++++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   9 +
 drivers/vfio/pci/vfio_pci_debugfs.c           |  10 +-
 3 files changed, 268 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index eb18edffbd5f..0f35cde6e8ec 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -15,6 +15,7 @@
 #include <linux/anon_inodes.h>
 
 #include "hisi_acc_vfio_pci.h"
+#include "../vfio_pci_debugfs.h"
 
 /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_dev_not_ready(struct hisi_qm *qm)
@@ -609,6 +610,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
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
@@ -621,12 +634,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
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
@@ -1188,6 +1205,231 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
 	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
 }
 
+static int hisi_acc_vf_debug_io(struct vfio_device *vdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
+	struct device *dev = vdev->dev;
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
+static int hisi_acc_vf_debug_resume(struct vfio_device *vdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+	struct device *dev = vdev->dev;
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
+static int hisi_acc_vf_debug_save(struct vfio_device *vdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+	struct device *dev = vdev->dev;
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
+static int
+hisi_acc_vf_debug_operate(struct vfio_device *vdev, unsigned int cmd)
+{
+	int ret;
+
+	switch (cmd) {
+	case STATE_SAVE:
+		ret = hisi_acc_vf_debug_save(vdev);
+		if (ret)
+			return ret;
+		break;
+	case STATE_RESUME:
+		ret = hisi_acc_vf_debug_resume(vdev);
+		if (ret)
+			return ret;
+		break;
+	case RW_IO_TEST:
+		ret = hisi_acc_vf_debug_io(vdev);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hisi_acc_vf_debug_check(struct vfio_device *vdev)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
+	enum vfio_device_mig_state state;
+
+	if (!vdev->mig_ops || !migf) {
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
+static ssize_t hisi_acc_vf_debug_write(struct file *filp, const char __user *buffer,
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
+	ret = hisi_acc_vf_debug_check(vdev);
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
+	ret = hisi_acc_vf_debug_operate(vdev, cmd);
+	if (ret) {
+		dev_err(vdev->dev, "device debug test failed!\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations hisi_acc_vf_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = hisi_acc_vf_debug_write,
+};
+
+static int
+hisi_acc_vfio_pci_get_device_data(struct vfio_device *vdev, char *buff)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
+	size_t vf_data_sz = offsetofend(struct acc_vf_data, padding);
+	struct device *dev = vdev->dev;
+
+	if (debug_migf && debug_migf->total_length) {
+		memcpy(buff, &debug_migf->vf_data, vf_data_sz);
+		return vf_data_sz;
+	}
+	dev_info(dev, "device not migrated!\n");
+
+	return 0;
+}
+
+static int
+hisi_acc_vfio_pci_get_device_attr(struct vfio_device *vdev, char *buff)
+{
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
+	struct hisi_acc_vf_migration_file *debug_migf = hisi_acc_vdev->debug_migf;
+	struct device *dev = vdev->dev;
+
+	if (debug_migf && debug_migf->total_length) {
+		return scnprintf(buff, VFIO_DEV_DBG_LEN,
+			 "acc device:\n"
+			 "device  state: %d\n"
+			 "device  ready: %u\n"
+			 "data    valid: %d\n"
+			 "data     size: %lu\n",
+			 hisi_acc_vdev->mig_state,
+			 hisi_acc_vdev->vf_qm_state,
+			 debug_migf->disabled,
+			 debug_migf->total_length);
+	}
+	dev_info(dev, "device not migrated!\n");
+
+	return 0;
+}
+
+static int hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
+	void *migf = NULL;
+
+	vfio_pci_vf_debugfs_init(vdev);
+
+	migf = kzalloc(sizeof(struct hisi_acc_vf_migration_file), GFP_KERNEL);
+	if (!migf)
+		return -ENOMEM;
+
+	hisi_acc_vdev->debug_migf = migf;
+
+	debugfs_create_file("debug", 0200, vdev->debug_root,
+				  vdev, &hisi_acc_vf_debug_fops);
+
+	return 0;
+}
+
+static void hisi_acc_vf_debugfs_exit(struct hisi_acc_vf_core_device *hisi_acc_vdev)
+{
+	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
+
+	kfree(hisi_acc_vdev->debug_migf);
+	vfio_pci_vf_debugfs_exit(vdev);
+}
+
 static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
@@ -1224,6 +1466,8 @@ static const struct vfio_migration_ops hisi_acc_vfio_pci_migrn_state_ops = {
 	.migration_set_state = hisi_acc_vfio_pci_set_device_state,
 	.migration_get_state = hisi_acc_vfio_pci_get_device_state,
 	.migration_get_data_size = hisi_acc_vfio_pci_get_data_size,
+	.migration_get_data = hisi_acc_vfio_pci_get_device_data,
+	.migration_get_attr = hisi_acc_vfio_pci_get_device_attr,
 };
 
 static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
@@ -1295,6 +1539,9 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	if (IS_ERR(hisi_acc_vdev))
 		return PTR_ERR(hisi_acc_vdev);
 
+	if (ops == &hisi_acc_vfio_pci_migrn_ops)
+		hisi_acc_vfio_debug_init(hisi_acc_vdev);
+
 	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
 	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
 	if (ret)
@@ -1302,6 +1549,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	return 0;
 
 out_put_vdev:
+	if (ops == &hisi_acc_vfio_pci_migrn_ops)
+		hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
 	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
 	return ret;
 }
@@ -1310,6 +1559,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 
+	hisi_acc_vf_debugfs_exit(hisi_acc_vdev);
 	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
 	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
 }
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 67343325b320..e9d72dc0c66c 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
@@ -49,6 +49,12 @@
 #define QM_EQC_DW0		0X8000
 #define QM_AEQC_DW0		0X8020
 
+enum mig_debug_cmd {
+	STATE_SAVE,
+	STATE_RESUME,
+	RW_IO_TEST,
+};
+
 struct acc_vf_data {
 #define QM_MATCH_SIZE offsetofend(struct acc_vf_data, qm_rsv_state)
 	/* QM match information */
@@ -111,5 +117,8 @@ struct hisi_acc_vf_core_device {
 	spinlock_t reset_lock;
 	struct hisi_acc_vf_migration_file *resuming_migf;
 	struct hisi_acc_vf_migration_file *saving_migf;
+
+	/* For debugfs */
+	struct hisi_acc_vf_migration_file *debug_migf;
 };
 #endif /* HISI_ACC_VFIO_PCI_H */
diff --git a/drivers/vfio/pci/vfio_pci_debugfs.c b/drivers/vfio/pci/vfio_pci_debugfs.c
index 94a42869539e..a0cec2d17e16 100644
--- a/drivers/vfio/pci/vfio_pci_debugfs.c
+++ b/drivers/vfio/pci/vfio_pci_debugfs.c
@@ -8,7 +8,7 @@
 
 #include "vfio_pci_debugfs.h"
 
-#define VFIO_DEV_BUF_LEN		4096
+#define VFIO_DEV_BUF_LEN		1024
 static struct dentry *vfio_pci_debugfs_root;
 
 static ssize_t vfio_pci_vf_data_dump(struct file *filp, char __user *buffer,
@@ -24,6 +24,10 @@ static ssize_t vfio_pci_vf_data_dump(struct file *filp, char __user *buffer,
 	}
 
 	len = vdev->mig_ops->migration_get_data(vdev, tbuf);
+	if (len < 0 || len >= VFIO_DEV_BUF_LEN) {
+		dev_err(vdev->dev, "failed to get device data!\n");
+		return -EINVAL;
+	}
 
 	return simple_read_from_buffer(buffer, count, pos, tbuf, len);
 }
@@ -47,6 +51,10 @@ static ssize_t vfio_pci_vf_attr_show(struct file *filp, char __user *buffer,
 	}
 
 	len = vdev->mig_ops->migration_get_attr(vdev, tbuf);
+	if (len < 0 || len >= VFIO_DEV_BUF_LEN) {
+		dev_err(vdev->dev, "failed to get device attribute!\n");
+		return -EINVAL;
+	}
 
 	return simple_read_from_buffer(buffer, count, pos, tbuf, len);
 }
-- 
2.24.0

