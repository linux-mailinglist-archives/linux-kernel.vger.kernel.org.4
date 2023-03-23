Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777076C5EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCWFdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCWFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1122113
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z19so10902464plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPERv8sXud0KxJcvENIsE+Ngn3x88OA7gINkyBoEiFY=;
        b=HDo3fOcuMDvIymivNHkUpjQGPYRVKheiptaARLg89wfeHm1n0nsX1k+GwXh1pIqqpR
         xBuZlOWINzdJh+EeazlKZoYzqJnO/reSswiMHYx9loTvjvEEu9O3/ElDcZAFNi51zUm5
         3FI9fiQWLll+Skq4pkVR/6lEH6ftSo8Ez03nHZEbRxMROTzaLR1awG9pqS7CEUVkVd/+
         QGILWR0V6bQsFTi/CiGatEJqM/uSe53jXqHlfjsUT8HiUTcbn18sHN2agxiOqUYC2RK6
         aEmWpH2jRgMwIkAgWXws1j5DesbXbP+2leiFspt/7mlY/qAh1ZYgqe+NhNw7KgjntHqz
         O2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPERv8sXud0KxJcvENIsE+Ngn3x88OA7gINkyBoEiFY=;
        b=k/GlEIpHIN2Cx/YPJsETCEDxQSohpzFQIVK2r/xMrWPUaTZpUiukqP8TrEaxsyyof5
         K8mgUOeP1CDHni4y4iyEcjVLNBr9udFhSKjvaEHH3++vWsPatD8a92RPHocdAmruygRa
         sxuJHvCqLHuJ1fhL8yw3ic6vtZh/l+l/41cpzW8JFtvu1m+4CdF4LYhcxq4qFjd9oNAI
         p1ElQ6Ot3APYVzuKjRuDn+WqMa3c96yk+rVKdZSv6ePsT3hFs4KpneL7NMUmS+uM7SgU
         9EdZr5IJ7N19eHhGQDp+W+XpfSUBcbGLRn8HFfO9nOem6+3eT1fg8GJOMuXz0DgFnXlX
         ZJ3w==
X-Gm-Message-State: AO0yUKWVTUMoAwKTN294D8BRd6dfpdj5T5zEq3N0SiXVLZHr/2wmqKDe
        YREC2igCLrT99JhFQqklunOv
X-Google-Smtp-Source: AK7set+ABEABkAvfVctPP0vOcN722Nhd28rHyPU7W8TztsQ7OBokZ6cuijFAaq507irWsU+4lxhdIw==
X-Received: by 2002:a05:6a20:2098:b0:d6:7264:f44e with SMTP id b24-20020a056a20209800b000d67264f44emr1693121pza.3.1679549485470;
        Wed, 22 Mar 2023 22:31:25 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c26-20020a631c5a000000b00507249cde91sm10538807pgm.91.2023.03.22.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:25 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/11] vduse: Refactor allocation for vduse virtqueues
Date:   Thu, 23 Mar 2023 13:30:36 +0800
Message-Id: <20230323053043.35-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323053043.35-1-xieyongji@bytedance.com>
References: <20230323053043.35-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

