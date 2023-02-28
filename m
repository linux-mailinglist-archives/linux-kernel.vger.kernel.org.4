Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5BE6A560D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjB1JnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjB1Jm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57E2DE48
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so13073368pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JacAVd/i9tXSpaabrsRjnKulqjP+fEUdOpIlt3tr++8=;
        b=LuAfBPCvlasAcVen2ZhsGCkdyZErAX9iEnoSEYLj2O7XbQmhaibZzLocjTV4/KxuRd
         lwpeNFGgQSY+V4149nU4yia/uSu6rW6b0MpnHByhBL//kU4gnEXNhvDTbEQtrJbL2Z/X
         0FUhl0V6433Ta7+3GLz+FZvtGgFkt5vK2oGGpdBem8tiQ2FvVsq9Fx8ykhyQdDiuROsr
         cCz/E7gCtmw59PqcLtRxwxoZLevwZJ65iOqGlt0cEvz5wSDTFuOC5jgliWE9nPUykX2E
         P/W3wQU7vvLtP78mo/omTs6X0veopqGjniWCbocG3M2dah4fZnQESo0ompkwyxYmaRCo
         yH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JacAVd/i9tXSpaabrsRjnKulqjP+fEUdOpIlt3tr++8=;
        b=K43vl4JLuJDUaPzbErSaix8szuTbAKJ5lsIO39wVP592p6ZTYeJa9MsYAII44ORjf8
         x4jnMe1d+9Xx3dF5OdFmFdndEPuQgqQ3K2MY4FWSDgkukfHrJ1iEPfsFKCwGuynJ9ljN
         7cvApYu1+bMBlwr0slrLCTfaaIeKy/CTMJxNGq2VfG90WRUWHl8L8/FGepnG7g1QJhIj
         MdykPC94NgrOeznmVcnehepv5HajokuMJcZgA6Sa5UXI/5OtOVHVe1+WE+6/Vz0U6tsY
         0oqH33kHhX2hZYty7niTqFwGt+1o5gO9ka+dk1AogqQix4TZdwnenDaU05S5lbJ+YVIi
         IVug==
X-Gm-Message-State: AO0yUKWFn0DJf46fAxgZTgPyCh+IE0Gp+9sortYJNzLbpnMQkv/F1zgS
        2hx32QgJeF1WzxDEJpVBKoQL
X-Google-Smtp-Source: AK7set/thexCOt6TuD/Pzrnk/gebCdkrp4+xSuFQb8I+DPEs6jtN/Q8s+1UB01rtLTc5LVzlfxrMyA==
X-Received: by 2002:a05:6a20:a692:b0:c7:5cb6:2ff7 with SMTP id ba18-20020a056a20a69200b000c75cb62ff7mr2310016pzb.22.1677577364850;
        Tue, 28 Feb 2023 01:42:44 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id x25-20020a63b219000000b00502ecc282e2sm5314344pge.5.2023.02.28.01.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:44 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] vduse: Delay iova domain creation
Date:   Tue, 28 Feb 2023 17:41:09 +0800
Message-Id: <20230228094110.37-11-xieyongji@bytedance.com>
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

Delay creating iova domain until the vduse device is
registered to vdpa bus.

This is a preparation for adding sysfs interface to
support specifying bounce buffer size for the iova
domain.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 75 +++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 56f3c2480c2a..1702565efc82 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -113,6 +113,8 @@ struct vduse_dev {
 	u32 vq_align;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
+	unsigned int bounce_size;
+	struct mutex domain_lock;
 };
 
 struct vduse_dev_msg {
@@ -427,7 +429,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	struct vduse_iova_domain *domain = dev->domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
-	if (domain->bounce_map)
+	if (domain && domain->bounce_map)
 		vduse_domain_reset_bounce_map(domain);
 
 	down_write(&dev->rwsem);
@@ -1069,6 +1071,9 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 		goto unlock;
 
 	ret = -EINVAL;
+	if (!dev->domain)
+		goto unlock;
+
 	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
 		goto unlock;
 
@@ -1095,7 +1100,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain->bounce_map ||
+	if (!dev->domain || !dev->domain->bounce_map ||
 	    size != dev->domain->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
@@ -1185,7 +1190,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		struct vduse_iotlb_entry entry;
 		struct vhost_iotlb_map *map;
 		struct vdpa_map_file *map_file;
-		struct vduse_iova_domain *domain = dev->domain;
 		struct file *f = NULL;
 
 		ret = -EFAULT;
@@ -1196,8 +1200,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (entry.start > entry.last)
 			break;
 
-		spin_lock(&domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(domain->iotlb,
+		mutex_lock(&dev->domain_lock);
+		if (!dev->domain) {
+			mutex_unlock(&dev->domain_lock);
+			break;
+		}
+		spin_lock(&dev->domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->domain->iotlb,
 					      entry.start, entry.last);
 		if (map) {
 			map_file = (struct vdpa_map_file *)map->opaque;
@@ -1207,7 +1216,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&domain->iotlb_lock);
+		spin_unlock(&dev->domain->iotlb_lock);
+		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
 			break;
@@ -1360,8 +1370,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(umem.reserved)))
 			break;
 
+		mutex_lock(&dev->domain_lock);
 		ret = vduse_dev_reg_umem(dev, umem.iova,
 					 umem.uaddr, umem.size);
+		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_DEREG_UMEM: {
@@ -1375,15 +1387,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (!is_mem_zero((const char *)umem.reserved,
 				 sizeof(umem.reserved)))
 			break;
-
+		mutex_lock(&dev->domain_lock);
 		ret = vduse_dev_dereg_umem(dev, umem.iova,
 					   umem.size);
+		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iova_info info;
 		struct vhost_iotlb_map *map;
-		struct vduse_iova_domain *domain = dev->domain;
 
 		ret = -EFAULT;
 		if (copy_from_user(&info, argp, sizeof(info)))
@@ -1397,18 +1409,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(info.reserved)))
 			break;
 
-		spin_lock(&domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(domain->iotlb,
+		mutex_lock(&dev->domain_lock);
+		if (!dev->domain) {
+			mutex_unlock(&dev->domain_lock);
+			break;
+		}
+		spin_lock(&dev->domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->domain->iotlb,
 					      info.start, info.last);
 		if (map) {
 			info.start = map->start;
 			info.last = map->last;
 			info.capability = 0;
-			if (domain->bounce_map && map->start == 0 &&
-			    map->last == domain->bounce_size - 1)
+			if (dev->domain->bounce_map && map->start == 0 &&
+			    map->last == dev->domain->bounce_size - 1)
 				info.capability |= VDUSE_IOVA_CAP_UMEM;
 		}
-		spin_unlock(&domain->iotlb_lock);
+		spin_unlock(&dev->domain->iotlb_lock);
+		mutex_unlock(&dev->domain_lock);
 		if (!map)
 			break;
 
@@ -1431,7 +1449,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 {
 	struct vduse_dev *dev = file->private_data;
 
-	vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	mutex_lock(&dev->domain_lock);
+	if (dev->domain)
+		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
 	list_splice_init(&dev->recv_list, &dev->send_list);
@@ -1640,6 +1661,7 @@ static struct vduse_dev *vduse_dev_create(void)
 
 	mutex_init(&dev->lock);
 	mutex_init(&dev->mem_lock);
+	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
@@ -1689,7 +1711,8 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	vduse_domain_destroy(dev->domain);
+	if (dev->domain)
+		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
@@ -1798,11 +1821,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev->name)
 		goto err_str;
 
-	dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
-					  VDUSE_BOUNCE_SIZE);
-	if (!dev->domain)
-		goto err_domain;
-
+	dev->bounce_size = VDUSE_BOUNCE_SIZE;
 	dev->config = config_buf;
 	dev->config_size = config->config_size;
 
@@ -1832,8 +1851,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-	vduse_domain_destroy(dev->domain);
-err_domain:
 	kfree(dev->name);
 err_str:
 	vduse_dev_destroy(dev);
@@ -2000,9 +2017,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret)
 		return ret;
 
+	mutex_lock(&dev->domain_lock);
+	if (!dev->domain)
+		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+						  dev->bounce_size);
+	mutex_unlock(&dev->domain_lock);
+	if (!dev->domain) {
+		put_device(&dev->vdev->vdpa.dev);
+		return -ENOMEM;
+	}
+
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
+		mutex_lock(&dev->domain_lock);
+		vduse_domain_destroy(dev->domain);
+		dev->domain = NULL;
+		mutex_unlock(&dev->domain_lock);
 		return ret;
 	}
 
-- 
2.20.1

