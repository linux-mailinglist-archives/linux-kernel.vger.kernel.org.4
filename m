Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16A743851
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjF3J1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjF3J1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:27:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EB919C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 02:27:46 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qsqg468VrzLndN;
        Fri, 30 Jun 2023 17:25:36 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 17:27:43 +0800
From:   liulongfang <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v11 2/4] hisi_acc_vfio_pci: extract public functions for container_of
Date:   Fri, 30 Jun 2023 17:24:55 +0800
Message-ID: <20230630092457.54902-3-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230630092457.54902-1-liulongfang@huawei.com>
References: <20230630092457.54902-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longfang Liu <liulongfang@huawei.com>

In the current driver, vdev is obtained from struct
hisi_acc_vf_core_device through the container_of function.
This method is used in many places in the driver. In order to
reduce this repetitive operation, I extracted a public function
to replace it.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index a117eaf21c14..a1589947e721 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -630,6 +630,12 @@ static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vde
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
@@ -1042,8 +1048,7 @@ static struct file *
 hisi_acc_vfio_pci_set_device_state(struct vfio_device *vdev,
 				   enum vfio_device_mig_state new_state)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
 	enum vfio_device_mig_state next_state;
 	struct file *res = NULL;
 	int ret;
@@ -1084,8 +1089,7 @@ static int
 hisi_acc_vfio_pci_get_device_state(struct vfio_device *vdev,
 				   enum vfio_device_mig_state *curr_state)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
 
 	mutex_lock(&hisi_acc_vdev->state_mutex);
 	*curr_state = hisi_acc_vdev->mig_state;
@@ -1301,8 +1305,7 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
 
 static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct vfio_pci_core_device *vdev = &hisi_acc_vdev->core_device;
 	int ret;
 
@@ -1325,8 +1328,7 @@ static int hisi_acc_vfio_pci_open_device(struct vfio_device *core_vdev)
 
 static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 
 	iounmap(vf_qm->io_base);
@@ -1341,8 +1343,7 @@ static const struct vfio_migration_ops hisi_acc_vfio_pci_migrn_state_ops = {
 
 static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
 {
-	struct hisi_acc_vf_core_device *hisi_acc_vdev = container_of(core_vdev,
-			struct hisi_acc_vf_core_device, core_device.vdev);
+	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
 	struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
 
-- 
2.24.0

