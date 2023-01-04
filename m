Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466165CC5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 05:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjADEZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 23:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjADEZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 23:25:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB3102D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 20:25:26 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NmxH14VVyzqTLB;
        Wed,  4 Jan 2023 12:20:45 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 12:25:23 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <sgarzare@redhat.com>
CC:     <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v3] vp_vdpa: harden the logic of set status
Date:   Wed, 4 Jan 2023 12:25:19 +0800
Message-ID: <20230104042519.170-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

1. We should not set status to 0 when invoking vp_vdpa_set_status(),
   trigger a warning in that case.

2. The driver MUST wait for a read of device_status to return 0 before
   reinitializing the device. But we also don't want to keep us in an
   infinite loop forever, so wait for 5s if we try to reset the device.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
Changes v3->v2:
 - move VP_VDPA_RESET_TIMEOUT_US near the other macros. [Stefano]
 - refer v1.2 in comments. [Stefano]
 - s/keep/keeping/  [Jason]
 - use readx_poll_timeout. [Jason]

Changes v1->v2:
 - use WARN_ON instead of BUG_ON. [Stefano]
 - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
 - use usleep_range instead of msleep (checkpatch). [Longpeng]

---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0c4de3..3fc496aea456 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <linux/vdpa.h>
 #include <linux/virtio.h>
@@ -22,6 +23,7 @@
 #define VP_VDPA_QUEUE_MAX 256
 #define VP_VDPA_DRIVER_NAME "vp_vdpa"
 #define VP_VDPA_NAME_SIZE 256
+#define VP_VDPA_RESET_TIMEOUT_US 5000000 /* 5s */
 
 struct vp_vring {
 	void __iomem *notify;
@@ -214,6 +216,9 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
 	u8 s = vp_vdpa_get_status(vdpa);
 
+	/* We should never be setting status to 0. */
+	WARN_ON(status == 0);
+
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
 		vp_vdpa_request_irq(vp_vdpa);
@@ -226,10 +231,25 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
-	u8 s = vp_vdpa_get_status(vdpa);
+	u8 tmp, s = vp_vdpa_get_status(vdpa);
+	int ret;
 
 	vp_modern_set_status(mdev, 0);
 
+	/*
+	 * As the virtio v1.1/v1.2 spec (4.1.4.3.2) says: After writing 0 to
+	 * device_status, the driver MUST wait for a read of device_status
+	 * to return 0 before reinitializing the device.
+	 * To avoid keeping us here forever, we only wait for 5 seconds.
+	 */
+	ret = readx_poll_timeout(vp_ioread8, &mdev->common->device_status, tmp,
+				 tmp == 0, 1000, VP_VDPA_RESET_TIMEOUT_US);
+	if (ret) {
+		dev_err(&mdev->pci_dev->dev,
+			"vp_vdpa: fail to reset device, %d\n", ret);
+		return ret;
+	}
+
 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
 		vp_vdpa_free_irq(vp_vdpa);
 
-- 
2.23.0

