Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC61B63A004
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiK1DOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiK1DOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:14:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF012085
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:14:36 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NL9Y231vnzRpQ7;
        Mon, 28 Nov 2022 11:13:58 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 11:14:35 +0800
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 28 Nov
 2022 11:14:34 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <john.garry@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v3 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon migration driver
Date:   Mon, 28 Nov 2022 11:11:58 +0800
Message-ID: <20221128031200.11017-4-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221128031200.11017-1-liulongfang@huawei.com>
References: <20221128031200.11017-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
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

On the debugfs framework of VFIO, register the debug function
for the live migration driver of the hisilicon accelerator device.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 168 ++++++++++++++++++
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   6 +
 2 files changed, 174 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index eb18edffbd5f..d683d48911d1 100644
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
@@ -620,13 +633,19 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
 
 static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
 {
+	struct vfio_device	*vdev = &hisi_acc_vdev->core_device.vdev;
+
 	if (hisi_acc_vdev->resuming_migf) {
+		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
+						vdev->vf_migration_file);
 		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
 		fput(hisi_acc_vdev->resuming_migf->filp);
 		hisi_acc_vdev->resuming_migf = NULL;
 	}
 
 	if (hisi_acc_vdev->saving_migf) {
+		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
+						vdev->vf_migration_file);
 		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
 		fput(hisi_acc_vdev->saving_migf->filp);
 		hisi_acc_vdev->saving_migf = NULL;
@@ -1188,6 +1207,145 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
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
+	struct hisi_acc_vf_migration_file *migf =
+		(struct hisi_acc_vf_migration_file *)vdev->vf_migration_file;
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
+	struct hisi_acc_vf_migration_file *migf =
+		(struct hisi_acc_vf_migration_file *)vdev->vf_migration_file;
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
+hisi_acc_vfio_pci_debug_operate(struct vfio_device *vdev, unsigned int cmd)
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
+static int
+hisi_acc_vfio_pci_get_device_data(struct vfio_device *vdev, char *buff)
+{
+	struct hisi_acc_vf_migration_file *debug_migf =
+		(struct hisi_acc_vf_migration_file *)vdev->vf_migration_file;
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
+	struct hisi_acc_vf_migration_file *debug_migf =
+		(struct hisi_acc_vf_migration_file *)vdev->vf_migration_file;
+	struct device *dev = vdev->dev;
+
+	if (debug_migf && debug_migf->total_length) {
+		scnprintf(buff, PAGE_SIZE,
+			 "acc device:\n"
+			 "device  state: %d\n"
+			 "device  ready: %u\n"
+			 "data    valid: %d\n"
+			 "data     size: %lu\n",
+			 hisi_acc_vdev->mig_state,
+			 hisi_acc_vdev->vf_qm_state,
+			 debug_migf->disabled,
+			 debug_migf->total_length);
+		return PAGE_SIZE;
+	}
+	dev_info(dev, "device not migrated!\n");
+
+	return 0;
+}
+
 static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
@@ -1224,6 +1382,9 @@ static const struct vfio_migration_ops hisi_acc_vfio_pci_migrn_state_ops = {
 	.migration_set_state = hisi_acc_vfio_pci_set_device_state,
 	.migration_get_state = hisi_acc_vfio_pci_get_device_state,
 	.migration_get_data_size = hisi_acc_vfio_pci_get_data_size,
+	.migration_get_data = hisi_acc_vfio_pci_get_device_data,
+	.migration_get_attr = hisi_acc_vfio_pci_get_device_attr,
+	.migration_debug_operate = hisi_acc_vfio_pci_debug_operate,
 };
 
 static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
@@ -1295,6 +1456,10 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	if (IS_ERR(hisi_acc_vdev))
 		return PTR_ERR(hisi_acc_vdev);
 
+	if (ops == &hisi_acc_vfio_pci_migrn_ops)
+		vfio_pci_vf_debugfs_init(&hisi_acc_vdev->core_device.vdev,
+						sizeof(struct hisi_acc_vf_migration_file));
+
 	dev_set_drvdata(&pdev->dev, &hisi_acc_vdev->core_device);
 	ret = vfio_pci_core_register_device(&hisi_acc_vdev->core_device);
 	if (ret)
@@ -1302,6 +1467,8 @@ static int hisi_acc_vfio_pci_probe(struct pci_dev *pdev, const struct pci_device
 	return 0;
 
 out_put_vdev:
+	if (ops == &hisi_acc_vfio_pci_migrn_ops)
+		vfio_pci_vf_debugfs_exit(&hisi_acc_vdev->core_device.vdev);
 	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
 	return ret;
 }
@@ -1310,6 +1477,7 @@ static void hisi_acc_vfio_pci_remove(struct pci_dev *pdev)
 {
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_drvdata(pdev);
 
+	vfio_pci_vf_debugfs_exit(&hisi_acc_vdev->core_device.vdev);
 	vfio_pci_core_unregister_device(&hisi_acc_vdev->core_device);
 	vfio_put_device(&hisi_acc_vdev->core_device.vdev);
 }
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.h
index 67343325b320..64b52fed69f2 100644
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
-- 
2.24.0

