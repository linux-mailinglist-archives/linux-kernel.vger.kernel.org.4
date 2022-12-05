Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31116424EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbiLEIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiLEIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:44:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EEE17593
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:44:02 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k79so10676660pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtcX8GDV+5HYnw5oH6dlRpWy9X8S2p+fdAeCWjD/oR8=;
        b=AogsTePtQjLNKhfa1BOWSNGungtsvGg1xdjBrcn0C/vdAT8PXPSNzcWWyaXSdXx6Kf
         zxpLv30AJ3gzOWiWeLJ4ebOQyEtwE24/1TY2rPro0i9jJuXpLbKBU4JZn7dcEm4DctPt
         iAe3wwxRLQoA85eiasCwhFnz9RtWvhPPs1JXmqxFtpFbQQLONDF5eyyi3POcvu6X2v78
         tuf2FJ+SRF0qFzHrAMh2B4YfZD55eIz7sVcGOO4XyqhlCc1zDJbqC3YKq2G3+71c11Zg
         9xrWVspRooG/0FdoL+S5pTV9ODOpGOn6R3CYXFCa/oSrPxkqSEJwzsfWJF+AJTqwi1RZ
         wWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtcX8GDV+5HYnw5oH6dlRpWy9X8S2p+fdAeCWjD/oR8=;
        b=1Oizxn7b22m4gVN33FXuUg3B+4mlqfMyFAdpcP15n5OW1bGLxb2DMUMNz6ACp5zXe9
         wx/UNtetqhnxxRb5di6RDzdgT32rKDTsqTyq2DOT24NZgjVZ04ewOomvKQANfDZR4lmp
         JooTbwzhNJG1fqjRc909LBbY1sbZax5ty9iu87tNGafiKF5OeJ+5cscL1pK2aB1oC+2E
         +6cqZ6a1YSQsJ+DzfbfzFcAJiT37AfsKQ7RQHnEr6uX3Z2huEQdJieFpR/z/iNyuWhcu
         DVb3RLrLYh1IsDAsLDB+iLARCWAdk/MZ8/F9i2Fig5M8I3DLhzlcxa+rb1fHDcuXOOVT
         7RIg==
X-Gm-Message-State: ANoB5pkCDQKIpbxNe4laB2EUvhPHhBnfYUWwWLVHoMK9O1zBMHGPZVeJ
        0pTo3x28Dh9JNtKPecNYJk5z
X-Google-Smtp-Source: AA0mqf6S6aol0QyYqOYUGSgkmMZ+Bw5Hql35kMmTbUzjamcWEEVQdxW98YRjaJxE2PbVGLAZith8yA==
X-Received: by 2002:a05:6a00:2186:b0:575:d7f8:40ad with SMTP id h6-20020a056a00218600b00575d7f840admr24477242pfi.50.1670229841959;
        Mon, 05 Dec 2022 00:44:01 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id c73-20020a624e4c000000b00575448ab0fdsm9312479pfb.114.2022.12.05.00.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:44:01 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] vduse: Refactor allocation for vduse virtqueues
Date:   Mon,  5 Dec 2022 16:41:20 +0800
Message-Id: <20221205084127.535-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205084127.535-1-xieyongji@bytedance.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate memory for vduse virtqueues one by one instead of
doing one allocation for all of them.

This is a preparation for adding sysfs interface for virtqueues.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 98 ++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee3ed56..37809bfcb7ef 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -76,7 +76,7 @@ struct vduse_umem {
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
-	struct vduse_virtqueue *vqs;
+	struct vduse_virtqueue **vqs;
 	struct vduse_iova_domain *domain;
 	char *name;
 	struct mutex lock;
@@ -434,7 +434,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	flush_work(&dev->inject);
 
 	for (i = 0; i < dev->vq_num; i++) {
-		struct vduse_virtqueue *vq = &dev->vqs[i];
+		struct vduse_virtqueue *vq = dev->vqs[i];
 
 		vq->ready = false;
 		vq->desc_addr = 0;
@@ -466,7 +466,7 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 				u64 device_area)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	vq->desc_addr = desc_area;
 	vq->driver_addr = driver_area;
@@ -500,7 +500,7 @@ static void vduse_vq_kick_work(struct work_struct *work)
 static void vduse_vdpa_kick_vq(struct vdpa_device *vdpa, u16 idx)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	if (!eventfd_signal_allowed()) {
 		schedule_work(&vq->kick);
@@ -513,7 +513,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 			      struct vdpa_callback *cb)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	spin_lock(&vq->irq_lock);
 	vq->cb.callback = cb->callback;
@@ -524,7 +524,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 static void vduse_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	vq->num = num;
 }
@@ -533,7 +533,7 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 					u16 idx, bool ready)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	vq->ready = ready;
 }
@@ -541,7 +541,7 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
 static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	return vq->ready;
 }
@@ -550,7 +550,7 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
 				const struct vdpa_vq_state *state)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED)) {
 		vq->state.packed.last_avail_counter =
@@ -569,7 +569,7 @@ static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
-	struct vduse_virtqueue *vq = &dev->vqs[idx];
+	struct vduse_virtqueue *vq = dev->vqs[idx];
 
 	if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED))
 		return vduse_dev_get_vq_state_packed(dev, vq, &state->packed);
@@ -624,8 +624,8 @@ static u16 vduse_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
 	int i;
 
 	for (i = 0; i < dev->vq_num; i++)
-		if (num_max < dev->vqs[i].num_max)
-			num_max = dev->vqs[i].num_max;
+		if (num_max < dev->vqs[i]->num_max)
+			num_max = dev->vqs[i]->num_max;
 
 	return num_max;
 }
@@ -863,7 +863,7 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
 		return -EINVAL;
 
 	index = array_index_nospec(eventfd->index, dev->vq_num);
-	vq = &dev->vqs[index];
+	vq = dev->vqs[index];
 	if (eventfd->fd >= 0) {
 		ctx = eventfd_ctx_fdget(eventfd->fd);
 		if (IS_ERR(ctx))
@@ -889,7 +889,7 @@ static bool vduse_dev_is_ready(struct vduse_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->vq_num; i++)
-		if (!dev->vqs[i].num_max)
+		if (!dev->vqs[i]->num_max)
 			return false;
 
 	return true;
@@ -1130,7 +1130,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		index = array_index_nospec(config.index, dev->vq_num);
-		dev->vqs[index].num_max = config.max_size;
+		dev->vqs[index]->num_max = config.max_size;
 		ret = 0;
 		break;
 	}
@@ -1148,7 +1148,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		index = array_index_nospec(vq_info.index, dev->vq_num);
-		vq = &dev->vqs[index];
+		vq = dev->vqs[index];
 		vq_info.desc_addr = vq->desc_addr;
 		vq_info.driver_addr = vq->driver_addr;
 		vq_info.device_addr = vq->device_addr;
@@ -1198,7 +1198,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		index = array_index_nospec(index, dev->vq_num);
-		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
+		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject);
 		break;
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
@@ -1339,6 +1339,49 @@ static const struct file_operations vduse_dev_fops = {
 	.llseek		= noop_llseek,
 };
 
+static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
+{
+	int i;
+
+	if (!dev->vqs)
+		return;
+
+	for (i = 0; i < dev->vq_num; i++)
+		kfree(dev->vqs[i]);
+	kfree(dev->vqs);
+}
+
+static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
+{
+	int i;
+
+	dev->vq_align = vq_align;
+	dev->vq_num = vq_num;
+	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
+	if (!dev->vqs)
+		return -ENOMEM;
+
+	for (i = 0; i < vq_num; i++) {
+		dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
+		if (!dev->vqs[i])
+			goto err;
+
+		dev->vqs[i]->index = i;
+		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
+		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
+		spin_lock_init(&dev->vqs[i]->kick_lock);
+		spin_lock_init(&dev->vqs[i]->irq_lock);
+	}
+
+	return 0;
+err:
+	while (i--)
+		kfree(dev->vqs[i]);
+	kfree(dev->vqs);
+	dev->vqs = NULL;
+	return -ENOMEM;
+}
+
 static struct vduse_dev *vduse_dev_create(void)
 {
 	struct vduse_dev *dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -1396,7 +1439,7 @@ static int vduse_destroy_dev(char *name)
 	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
-	kfree(dev->vqs);
+	vduse_dev_deinit_vqs(dev);
 	vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
 	vduse_dev_destroy(dev);
@@ -1483,7 +1526,7 @@ ATTRIBUTE_GROUPS(vduse_dev);
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
-	int i, ret;
+	int ret;
 	struct vduse_dev *dev;
 
 	ret = -EEXIST;
@@ -1510,19 +1553,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 
 	dev->config = config_buf;
 	dev->config_size = config->config_size;
-	dev->vq_align = config->vq_align;
-	dev->vq_num = config->vq_num;
-	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
-	if (!dev->vqs)
-		goto err_vqs;
 
-	for (i = 0; i < dev->vq_num; i++) {
-		dev->vqs[i].index = i;
-		INIT_WORK(&dev->vqs[i].inject, vduse_vq_irq_inject);
-		INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
-		spin_lock_init(&dev->vqs[i].kick_lock);
-		spin_lock_init(&dev->vqs[i].irq_lock);
-	}
+	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
+	if (ret)
+		goto err_vqs;
 
 	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
 	if (ret < 0)
@@ -1543,7 +1577,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-	kfree(dev->vqs);
+	vduse_dev_deinit_vqs(dev);
 err_vqs:
 	vduse_domain_destroy(dev->domain);
 err_domain:
-- 
2.20.1

