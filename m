Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05E6429DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbiLENvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLENvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:51:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0A1D0CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:51:36 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NQlHT3qPGzkXnk;
        Mon,  5 Dec 2022 21:48:05 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 21:51:33 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <stefanha@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <sgarzare@redhat.com>, <eperezma@redhat.com>
CC:     <cohuck@redhat.com>, <arei.gonglei@huawei.com>,
        <yechuan@huawei.com>, <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v2] vdpasim: support doorbell mapping
Date:   Mon, 5 Dec 2022 21:51:30 +0800
Message-ID: <20221205135130.2336-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Support doorbell mapping for vdpasim devices, then we can test the notify
passthrough feature even if there's no real hardware on hand.

Allocates a dummy page which is used to emulate the notify page of the device,
all VQs share the same notify register  that initiated to 0xffff. A  periodic
work will check whether there're requests need to process ( the value of the
notify register is 0xffff or not ).

This cap is disabled as default, users can enable it as follow:
  modprobe vdpa_sim notify_passthrough=true

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
Changes v1->v2:
  - support both kick mode and passthrough mode. [Jason]
  - poll the notify register first. [Jason, Michael]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 77 ++++++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
 2 files changed, 80 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 7438a89ce939..07096a04dabb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/dma-map-ops.h>
+#include <asm/set_memory.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
 #include <linux/vhost_iotlb.h>
@@ -36,9 +37,16 @@ module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 		 "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
 
+static bool notify_passthrough;
+module_param(notify_passthrough, bool, 0444);
+MODULE_PARM_DESC(notify_passthrough,
+		 "Enable vq notify(doorbell) area mapping. (default: false)");
+
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_VENDOR_ID 0
+#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
+#define VDPASIM_NOTIFY_DEFVAL 0xffff
 
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
@@ -246,6 +254,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
+static void vdpasim_notify_work(struct work_struct *work)
+{
+	struct vdpasim *vdpasim;
+	u16 *val;
+
+	vdpasim = container_of(work, struct vdpasim, notify_work.work);
+
+	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto out;
+
+	if (!vdpasim->running)
+		goto out;
+
+	val = (u16 *)vdpasim->notify;
+	if (xchg(val, VDPASIM_NOTIFY_DEFVAL) != VDPASIM_NOTIFY_DEFVAL)
+		schedule_work(&vdpasim->work);
+
+out:
+	schedule_delayed_work(&vdpasim->notify_work,
+			      msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
+}
+
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 			       const struct vdpa_dev_set_config *config)
 {
@@ -287,6 +317,18 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	set_dma_ops(dev, &vdpasim_dma_ops);
 	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
 
+	if (notify_passthrough) {
+		INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
+
+		vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!vdpasim->notify)
+			goto err_iommu;
+#ifdef CONFIG_X86
+		set_memory_uc(vdpasim->notify, 1);
+#endif
+		*(u16 *)vdpasim->notify = VDPASIM_NOTIFY_DEFVAL;
+	}
+
 	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
 	if (!vdpasim->config)
 		goto err_iommu;
@@ -495,6 +537,18 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 	return status;
 }
 
+static void vdpasim_set_notify_work(struct vdpasim *vdpasim, bool start)
+{
+	if (!notify_passthrough)
+		return;
+
+	if (start)
+		schedule_delayed_work(&vdpasim->notify_work,
+				      msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
+	else
+		cancel_delayed_work_sync(&vdpasim->notify_work);
+}
+
 static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -502,12 +556,14 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 	spin_lock(&vdpasim->lock);
 	vdpasim->status = status;
 	spin_unlock(&vdpasim->lock);
+	vdpasim_set_notify_work(vdpasim, status & VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
 static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
+	vdpasim_set_notify_work(vdpasim, false);
 	spin_lock(&vdpasim->lock);
 	vdpasim->status = 0;
 	vdpasim_do_reset(vdpasim);
@@ -672,11 +728,24 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
 	return 0;
 }
 
+static struct vdpa_notification_area
+vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	struct vdpa_notification_area notify;
+
+	notify.addr = virt_to_phys((void *)vdpasim->notify);
+	notify.size = PAGE_SIZE;
+
+	return notify;
+}
+
 static void vdpasim_free(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
+	vdpasim_set_notify_work(vdpasim, false);
 	cancel_work_sync(&vdpasim->work);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
@@ -693,6 +762,12 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	vhost_iotlb_free(vdpasim->iommu);
 	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
+	if (vdpasim->notify) {
+#ifdef CONFIG_X86
+		set_memory_wb(vdpasim->notify, 1);
+#endif
+		free_page(vdpasim->notify);
+	}
 }
 
 static const struct vdpa_config_ops vdpasim_config_ops = {
@@ -704,6 +779,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vq_notification    = vdpasim_get_vq_notification,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
 	.get_device_features    = vdpasim_get_device_features,
@@ -737,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vq_notification    = vdpasim_get_vq_notification,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
 	.get_device_features    = vdpasim_get_device_features,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 0e78737dcc16..0769ccbd3911 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -69,6 +69,9 @@ struct vdpasim {
 	bool running;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
+	/* dummy notify page */
+	unsigned long notify;
+	struct delayed_work notify_work;
 };
 
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
-- 
2.23.0

