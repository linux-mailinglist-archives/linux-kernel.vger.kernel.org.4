Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F70642557
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiLEJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiLEJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:03:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276421055E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:03:05 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jn7so10186277plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5ByNntoTnvRrZGf2VdRrzzDsX9jfz3UQsAUMXVoxFo=;
        b=Y64X0WsAeSkieU6J+IqVSvE0B3KAWXcuKX9mnMKzqJTkrkdg/78DNUN59qfLbkopOo
         qIYgTfztE6TSf0Qy905iUqYOq99g7R8+iLvx1ZiqE4E3rzmxZIyIeE2c+RXCmpkhT53L
         C5CGa0hsM9s5S7gtUl6tYNiiaqWT9QBW6+RuJKSGbcpB75H5ANMc+M+zIx+oeXNHDyLx
         2CKiX8Xfnr/jVo9IQ+qLCjtzZPKz2R9sMqm8VkE/Dqp+wDCIOchvAFFv8SacHZ6w9b+7
         0xLSFrmDeGZ4CaC6WxjzN4nh6BTf1da5SNUHNhs80RCTpwwnOnuNcHRTEengQ6k38kGU
         IeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5ByNntoTnvRrZGf2VdRrzzDsX9jfz3UQsAUMXVoxFo=;
        b=DzcHMB4TqaYsPSVy0QHduLCJAraR/pefP1+QWe+mLslRFlOZORXVZXe0isN2Te4HnG
         rme/Se/1Rq1uQ0xNIPzs2oMesO05YoUCZCPiyHpZqXAktmeBprXP+edR9v+fI2rVeCpY
         svlwB5dYziw21d1GAjnEza3rxBVaPUOK8zBWFAlh6ufK8SwSt5UbgLSG9tVa/LKZ8dhk
         EonKs5xZ9OLsfZUNzrmpqFHIdkIIlQQn8Lj+EPhgGc1LKZkrI1RPD7u0Hb4wEmQl5Clo
         J4GvuTuPU0CPL+kOmVR+XKdEddbesCLZtNkinaCzcBzwDF7JcxmQzkmFiVrkjdqnuogK
         FQtQ==
X-Gm-Message-State: ANoB5pnzeBHpAfyseKtHw/2uWEDWns8iqQ9GdQYfW0B2OWh4xeRWeJ9Z
        wFRdX0SdElewXzotx/4Zgkv8
X-Google-Smtp-Source: AA0mqf5qtdinklk7jv4r8lbGVnjHgzKcUhr25GgAiNf3fVv04RNcw0oN3KNhTC29kyynb3cow/RD+g==
X-Received: by 2002:a17:90a:a591:b0:219:2926:372a with SMTP id b17-20020a17090aa59100b002192926372amr43048774pjq.110.1670230984614;
        Mon, 05 Dec 2022 01:03:04 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7962d000000b00576d4d69909sm2223087pfg.8.2022.12.05.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:03:04 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] vduse: Delay iova domain creation
Date:   Mon,  5 Dec 2022 17:02:42 +0800
Message-Id: <20221205090243.791-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205090243.791-1-xieyongji@bytedance.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205090243.791-1-xieyongji@bytedance.com>
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

Delay creating iova domain until the vduse device is binded
to vdpa bus.

This is a preparation for adding sysfs interface to support
specifying bounce buffer size for the iova domain.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 75 +++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ed06c7afd484..bd1ba6c33e09 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -112,6 +112,8 @@ struct vduse_dev {
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
@@ -1045,6 +1047,9 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 		goto unlock;
 
 	ret = -EINVAL;
+	if (!dev->domain)
+		goto unlock;
+
 	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
 		goto unlock;
 
@@ -1071,7 +1076,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain->bounce_map ||
+	if (!dev->domain || !dev->domain->bounce_map ||
 	    size != dev->domain->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
@@ -1145,7 +1150,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		struct vduse_iotlb_entry entry;
 		struct vhost_iotlb_map *map;
 		struct vdpa_map_file *map_file;
-		struct vduse_iova_domain *domain = dev->domain;
 		struct file *f = NULL;
 
 		ret = -EFAULT;
@@ -1156,8 +1160,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1167,7 +1176,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&domain->iotlb_lock);
+		spin_unlock(&dev->domain->iotlb_lock);
+		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
 			break;
@@ -1319,8 +1329,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(umem.reserved)))
 			break;
 
+		mutex_lock(&dev->domain_lock);
 		ret = vduse_dev_reg_umem(dev, umem.iova,
 					 umem.uaddr, umem.size);
+		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_DEREG_UMEM: {
@@ -1334,15 +1346,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1356,18 +1368,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
 
@@ -1390,7 +1408,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
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
@@ -1647,6 +1668,7 @@ static struct vduse_dev *vduse_dev_create(void)
 
 	mutex_init(&dev->lock);
 	mutex_init(&dev->mem_lock);
+	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
@@ -1696,7 +1718,8 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	vduse_domain_destroy(dev->domain);
+	if (dev->domain)
+		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
@@ -1802,11 +1825,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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
 
@@ -1836,8 +1855,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-	vduse_domain_destroy(dev->domain);
-err_domain:
 	kfree(dev->name);
 err_str:
 	vduse_dev_destroy(dev);
@@ -2004,9 +2021,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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

