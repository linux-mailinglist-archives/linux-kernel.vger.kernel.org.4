Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E34640352
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiLBJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiLBJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:28:34 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A560B58
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:28:33 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NNnfX5nqzz15N5f;
        Fri,  2 Dec 2022 17:27:48 +0800 (CST)
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 17:28:30 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <john.garry@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v4 2/5] hisi_acc_vfio_pci: extract public functions for container_of
Date:   Fri, 2 Dec 2022 17:26:22 +0800
Message-ID: <20221202092625.35075-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221202092625.35075-1-liulongfang@huawei.com>
References: <20221202092625.35075-1-liulongfang@huawei.com>
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

In the current driver, vdev is obtained from struct
hisi_acc_vf_core_device through the container_of function.
This method is used in many places in the driver. In order to
reduce this repetitive operation, I extracted a public function
to replace it.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 0c0c0c7f0521..eb18edffbd5f 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -633,6 +633,12 @@ static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vde
 	}
 }
 
+static struct hisi_acc_vf_core_device *hisi_acc_get_vf_dev(struct vfio_device *vdev)
+{
+	return container_of(vdev, struct hisi_acc_vf_core_device,
+			    core_device.vdev);
+}
+
 /*
  * This function is called in all state_mutex unlock cases to
  * handle a 'deferred_reset' if exists.
@@ -927,8 +933,7 @@ static struct file *
 hisi_acc_vfio_pci_set_device_state(struct vfio_device *vdev,
 				   enum vfio_device_mig_state new_state)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
 	enum vfio_device_mig_state next_state;
 	struct file *res = NULL;
 	int ret;
@@ -969,8 +974,7 @@ static int
 hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
 				   enum vfio_device_mig_state *curr_state)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
 
 	mutex_lock(&hisi_acc_vdev->state_mutex);
 	*curr_state = hisi_acc_vdev->mig_state;
@@ -1186,8 +1190,7 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
 
 static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
 	int ret;
 
@@ -1210,8 +1213,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 
 static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 
 	iounmap(vf_qm->io_base);
@@ -1226,8 +1228,7 @@ static const struct vfio_migration_ops hisi_acc_vfio_pci_migrn_state_ops = {
 
 static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
 	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
 
-- 
2.24.0

