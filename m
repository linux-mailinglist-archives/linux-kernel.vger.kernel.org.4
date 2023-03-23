Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B316C5EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCWFdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCWFdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:33:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43B2F05E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso906796pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPmWWrpSgaPOGhUBOkIMLmxdo25WMNikMv3Jin+/Fz0=;
        b=btCCImtEbx8h8b5MD0xvsC/Msz/cOhLuDrbLg0UodbNPkO2mHUq11NP+bQKtb0oenJ
         ijTDX4qMzrOxRN8Q6m6QdHKsRDBa76hJsly6iCT01NSBqpkAQDe92CfLIZiuWEoBVMth
         aPzzyKYC1lrr0yhkDkhOBJCgUVryj7L3C+/W3RgS/IjjsoznZU7iTadcsrnVzciP+mpU
         wibTJbNT2kcHf4OTU7b2/kApuwKfm2BqzuBvmpHRrKqg+RIDVrZSc9iubeSdvWMR1rRR
         E50p9m2g+chyR2K+FXF/HExk9tuZNlFHaAzgDs8Hns1KSqmj9gv9dK6mg1K4OW6F83RR
         yhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPmWWrpSgaPOGhUBOkIMLmxdo25WMNikMv3Jin+/Fz0=;
        b=FdYPAAIVtjFSJzGMrKTSSyjwg7LJo6zfoduR9ocoGaZbNeP2tw6UcpwbO/YV+89ZTa
         hcdvCeVqGkK30O5PdkeZw++9r2j5RxKO4gw0VCUAFo1+iw92ewmqKHH0VkTJR53U6IKN
         iH3SovaxaMAFFMZW3WkW38i4g61Q2pu7GfjevHoVEY4BB3gOmSClE9mo3mO73m5kM8Ga
         fLCak4KVSHQdFp5ouWbjAor+c76yyg7XbD2OU5bD7w3y5kHXHos4ZjExX0cZ54ktpWAb
         A2j4X5y5AjkixjQ/JzkyrlH5OtgVWkLVaVfJLyF8fKIwmbRxsWfKm3NNGFlaATXgv/R2
         AzPA==
X-Gm-Message-State: AAQBX9eyxy66AJQgx5SRgqyxzP1UQTZK8HJENFchHv/ESH4clS1VL1KC
        tx9tSuKQgN7p58f6sUdE1bVB
X-Google-Smtp-Source: AKy350aYQXtp/fxWTfa15HOXnombEQ5hcdOFqTe4R06IwntYd5TeLT8X9GUayCtlAZZ6G7O2XGmANQ==
X-Received: by 2002:a17:903:32d1:b0:1a1:abc9:198f with SMTP id i17-20020a17090332d100b001a1abc9198fmr4732456plr.4.1679549504645;
        Wed, 22 Mar 2023 22:31:44 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id p9-20020a63f449000000b0050bf1d1cdc8sm10687768pgk.21.2023.03.22.22.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:44 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] vduse: Delay iova domain creation
Date:   Thu, 23 Mar 2023 13:30:42 +0800
Message-Id: <20230323053043.35-11-xieyongji@bytedance.com>
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
index 8c06f6ab960b..ccca84d51a28 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -111,6 +111,8 @@ struct vduse_dev {
 	u32 vq_align;
 	struct vduse_umem *umem;
 	struct mutex mem_lock;
+	unsigned int bounce_size;
+	struct mutex domain_lock;
 };
 
 struct vduse_dev_msg {
@@ -425,7 +427,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	struct vduse_iova_domain *domain = dev->domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
-	if (domain->bounce_map)
+	if (domain && domain->bounce_map)
 		vduse_domain_reset_bounce_map(domain);
 
 	down_write(&dev->rwsem);
@@ -993,6 +995,9 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 		goto unlock;
 
 	ret = -EINVAL;
+	if (!dev->domain)
+		goto unlock;
+
 	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
 		goto unlock;
 
@@ -1019,7 +1024,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain->bounce_map ||
+	if (!dev->domain || !dev->domain->bounce_map ||
 	    size != dev->domain->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
@@ -1109,7 +1114,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		struct vduse_iotlb_entry entry;
 		struct vhost_iotlb_map *map;
 		struct vdpa_map_file *map_file;
-		struct vduse_iova_domain *domain = dev->domain;
 		struct file *f = NULL;
 
 		ret = -EFAULT;
@@ -1120,8 +1124,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1131,7 +1140,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&domain->iotlb_lock);
+		spin_unlock(&dev->domain->iotlb_lock);
+		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
 			break;
@@ -1284,8 +1294,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(umem.reserved)))
 			break;
 
+		mutex_lock(&dev->domain_lock);
 		ret = vduse_dev_reg_umem(dev, umem.iova,
 					 umem.uaddr, umem.size);
+		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_DEREG_UMEM: {
@@ -1299,15 +1311,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1321,18 +1333,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
 
@@ -1355,7 +1373,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
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
@@ -1564,6 +1585,7 @@ static struct vduse_dev *vduse_dev_create(void)
 
 	mutex_init(&dev->lock);
 	mutex_init(&dev->mem_lock);
+	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
@@ -1613,7 +1635,8 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	vduse_domain_destroy(dev->domain);
+	if (dev->domain)
+		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
@@ -1722,11 +1745,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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
 
@@ -1756,8 +1775,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-	vduse_domain_destroy(dev->domain);
-err_domain:
 	kfree(dev->name);
 err_str:
 	vduse_dev_destroy(dev);
@@ -1924,9 +1941,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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

