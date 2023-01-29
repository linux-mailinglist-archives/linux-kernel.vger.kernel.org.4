Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E067FC74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjA2Cuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjA2Cuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:50:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23561B571
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:50:41 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P4G0Q09JzzJq3x;
        Sun, 29 Jan 2023 10:46:14 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 10:50:39 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <stefanha@redhat.com>, <sgarzare@redhat.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <eperezma@redhat.com>,
        Longpeng <longpeng2@huawei.com>
Subject: [PATCH v3 2/2] vdpasim: support doorbell mapping
Date:   Sun, 29 Jan 2023 10:50:34 +0800
Message-ID: <20230129025034.2000-3-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20230129025034.2000-1-longpeng2@huawei.com>
References: <20230129025034.2000-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 65 ++++++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..4fcfeb6e2fb8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -39,6 +39,8 @@ MODULE_PARM_DESC(max_iotlb_entries,
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_VENDOR_ID 0
+#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
+#define VDPASIM_NOTIFY_DEFVAL 0xffff
 
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
@@ -246,6 +248,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
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
@@ -287,6 +311,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	set_dma_ops(dev, &vdpasim_dma_ops);
 	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
 
+	INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
+
+	vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
+	if (!vdpasim->notify)
+		goto err_iommu;
+	*(u16 *)vdpasim->notify = VDPASIM_NOTIFY_DEFVAL;
+
 	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
 	if (!vdpasim->config)
 		goto err_iommu;
@@ -498,16 +529,21 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
 static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	bool started = vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK;
 
 	spin_lock(&vdpasim->lock);
 	vdpasim->status = status;
 	spin_unlock(&vdpasim->lock);
+	if (!started && (status & VIRTIO_CONFIG_S_DRIVER_OK))
+		schedule_delayed_work(&vdpasim->notify_work,
+				      msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
 }
 
 static int vdpasim_reset(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
+	cancel_delayed_work_sync(&vdpasim->notify_work);
 	spin_lock(&vdpasim->lock);
 	vdpasim->status = 0;
 	vdpasim_do_reset(vdpasim);
@@ -672,11 +708,34 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
 	return 0;
 }
 
+static pgprot_t vdpasim_get_vq_notification_pgprot(struct vdpa_device *vdpa,
+						   u16 qid, pgprot_t prot)
+{
+	/*
+	 * We use normal RAM pages to emulate the vq notification area, so
+	 * just keep the pgprot as it mmaped.
+	 */
+	return prot;
+}
+
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
 
+	cancel_delayed_work_sync(&vdpasim->notify_work);
 	cancel_work_sync(&vdpasim->work);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
@@ -693,6 +752,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	vhost_iotlb_free(vdpasim->iommu);
 	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
+	if (vdpasim->notify)
+		free_page(vdpasim->notify);
 }
 
 static const struct vdpa_config_ops vdpasim_config_ops = {
@@ -704,6 +765,8 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vq_notification    = vdpasim_get_vq_notification,
+	.get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
 	.get_vq_align           = vdpasim_get_vq_align,
 	.get_vq_group           = vdpasim_get_vq_group,
 	.get_device_features    = vdpasim_get_device_features,
@@ -737,6 +800,8 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_vq_ready           = vdpasim_get_vq_ready,
 	.set_vq_state           = vdpasim_set_vq_state,
 	.get_vq_state           = vdpasim_get_vq_state,
+	.get_vq_notification    = vdpasim_get_vq_notification,
+	.get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
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

