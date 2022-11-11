Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE6625D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiKKOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiKKOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:55:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04377DEB6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:55:13 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N81vf1g5LzmVpN;
        Fri, 11 Nov 2022 22:54:54 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 22:55:09 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <stefanha@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <sgarzare@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <linux-kernel@vger.kernel.org>,
        <xiehong@huawei.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH] vp_vdpa: harden the logic of set status
Date:   Fri, 11 Nov 2022 22:55:05 +0800
Message-ID: <20221111145505.1232-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

1. We should not set status to 0 when invoking vp_vdpa_set_status().

2. The driver MUST wait for a read of device_status to return 0 before
   reinitializing the device.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0c4de3..d35fac5cde11 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -212,8 +212,12 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
-	u8 s = vp_vdpa_get_status(vdpa);
+	u8 s;
+
+	/* We should never be setting status to 0. */
+	BUG_ON(status == 0);
 
+	s = vp_vdpa_get_status(vdpa);
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
 		vp_vdpa_request_irq(vp_vdpa);
@@ -229,6 +233,11 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
 	u8 s = vp_vdpa_get_status(vdpa);
 
 	vp_modern_set_status(mdev, 0);
+	/* After writing 0 to device_status, the driver MUST wait for a read of
+	 * device_status to return 0 before reinitializing the device.
+	 */
+	while (vp_modern_get_status(mdev))
+		msleep(1);
 
 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
 		vp_vdpa_free_irq(vp_vdpa);
-- 
2.23.0

