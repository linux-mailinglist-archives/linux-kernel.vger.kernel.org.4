Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA16A560C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjB1JnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjB1Jmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647CC2CFC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:23 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so1896249pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPERv8sXud0KxJcvENIsE+Ngn3x88OA7gINkyBoEiFY=;
        b=PDJpl+ldwuucI1/uzqbjlrW/O5HF0qhP66bBRMokCzBCnN+t3cSLIYouzDqz9Nf5Ps
         pFCsGNyykMkKM4AWTND+EAXjOsC85j6nfq9VC7ZtUeAIYaiR+TpGPPfQuHZ+vDtTL6bR
         6tMN21/xSKfJB+U272N/5FhlKZQZQURhP2H2Eas/ro9UyQh0YMNZgxCkBNTE+rOD6aw4
         +QsaqFlsBDi8fPf5UhdCL5NdLQtHo0ZvZZ6y19CoEp+Zm7RACTyUHFp6z8hG3LVFlrXC
         R0wYdsQsehOv/kHQ/Hmx2CdCeodUHGKCqAUToQeRwD86fOKid9gep9FhAh+mu0q8qGcF
         tk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPERv8sXud0KxJcvENIsE+Ngn3x88OA7gINkyBoEiFY=;
        b=4ZybLOzqj3o9UMF9Uwmxz0WBvRvIqu3h7p1wKQ9eMemgFHLIvp+HZp06cMwViDl7HP
         fcf2J+TPET2uq/tzWG43nlPBn0GMX7pO/MKy5awQAdPXSm8KeWkqrMkrZIu6FKGUQf1N
         WQlaixHpr5dhcKnmwOHPXH8ao/MdxmHTGLqPLGMFB9rSKV2PZGSSMOtXxVe55n9mUe1g
         7XsLiJsJEkmsWwIEMjMPg4k6uCYyx2rX209p+DZ42H6c08s9gH+vyB7/N1ADiBNllfXf
         CIJCCrA9amloZ1QobU9Xza2VFfdv8Win4C6rEiRi+kK3oap8vBA4U4um6rAxhKfQz8/8
         Z0iw==
X-Gm-Message-State: AO0yUKUxpKr0oz5SWfe7Rep2xgqpTu+Z2Ld4E3zTRMxq27KGqSGNYsSD
        gL2oeBkCbkIa0Yp6eGJjWs+m
X-Google-Smtp-Source: AK7set/aFITGNY+YtZ83ReOfFYQ+Ol58CDALtb3zGAzrhqo50WDsMJ08vZG4fTrooH5e98s2tRxg3Q==
X-Received: by 2002:a17:903:22ca:b0:19d:90f:6c6c with SMTP id y10-20020a17090322ca00b0019d090f6c6cmr2816251plg.17.1677577342819;
        Tue, 28 Feb 2023 01:42:22 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090331ce00b0019906c4c9dcsm5856719ple.98.2023.02.28.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:22 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] vduse: Refactor allocation for vduse virtqueues
Date:   Tue, 28 Feb 2023 17:41:03 +0800
Message-Id: <20230228094110.37-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228094110.37-1-xieyongji@bytedance.com>
References: <20230228094110.37-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate memory for vduse virtqueues one by one instead of
doing one allocation for all of them.

This is a preparation for adding sysfs interface for virtqueues.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 98 ++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0c3b48616a9f..98359d87a06f 100644
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
@@ -1486,7 +1529,7 @@ ATTRIBUTE_GROUPS(vduse_dev);
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
-	int i, ret;
+	int ret;
 	struct vduse_dev *dev;
 
 	ret = -EEXIST;
@@ -1513,19 +1556,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 
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
@@ -1546,7 +1580,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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

