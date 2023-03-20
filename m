Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46F6C0D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCTJ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjCTJ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:27:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7DD24BDD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:26:49 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pg8Ry2YM9z17MZW;
        Mon, 20 Mar 2023 17:23:42 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 17:26:45 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [PATCH v9 5/5] vfio: update live migration device status
Date:   Mon, 20 Mar 2023 17:23:38 +0800
Message-ID: <20230320092338.2889-6-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20230320092338.2889-1-liulongfang@huawei.com>
References: <20230320092338.2889-1-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migration debugfs needs to perform debug operations based on the
status of the current device. If the device is not loaded or has
stopped, debugfs does not allow operations.

so, after the live migration function is executed and the device is
turned off, the device no longer needs to be accessed. At this time,
the status of the device needs to be set to stop.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 +++
 drivers/vfio/pci/mlx5/main.c                   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 22ebe0e8f90f..54573b4f7f6d 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1615,6 +1615,9 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
 	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 
+	if (core_vdev->mig_ops)
+		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_STOP;
+
 	iounmap(vf_qm->io_base);
 	vfio_pci_core_close_device(core_vdev);
 }
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index e897537a9e8a..dc3564436946 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -1269,6 +1269,9 @@ static void mlx5vf_pci_close_device(struct vfio_device *core_vdev)
 	struct mlx5vf_pci_core_device *mvdev = container_of(
 		core_vdev, struct mlx5vf_pci_core_device, core_device.vdev);
 
+	if (mvdev->migrate_cap)
+		mvdev->mig_state = VFIO_DEVICE_STATE_STOP;
+
 	mlx5vf_cmd_close_migratable(mvdev);
 	vfio_pci_core_close_device(core_vdev);
 }
-- 
2.24.0

