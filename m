Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2D642556
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiLEJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLEJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:03:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6161FD31
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:03:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14171560pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F4aYFXGksQtN5NYEODlVl4Bem8OEWuiuWQxHQeKgGE=;
        b=sSKC7gm8zRkAoVolXgWwlic+bvrd4CBsX+FKLhQCPFbXrSE8ntYCq5UdeliPa8D05J
         0YMmvSG2P33BN6mUU7ELEG6JrfbhRF5q6JH9ANXTQlFjHhOy/qH8GN0iIozIE0qwBnZN
         i/GUVYoB21hXkIX/Ky4/JI6FkaPw1vJiqukaLZhqX/A2Hx0RxTIBCib/TbO17+voDGCE
         EpqTQOBCyn8+IYbWeahD6HmHhb72hjirua9v6ou8Ues8ON0gqGOd3bkxvfeDOox9/T5E
         OccwffpJ+FahYu+qRoXDRIhhtCVi7gUO+htOEDHcQ4WPtRo5vniEYPlZ5lyGkLZDI4tz
         MWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0F4aYFXGksQtN5NYEODlVl4Bem8OEWuiuWQxHQeKgGE=;
        b=5/+2denMbjJBFJy/IRE/FpHJbzYeZjKwkz0hamAHSySzlkvzmKgPPKhoKPr27ZV13T
         yLN0YuNpc7Zz3vwpcqJVGB0CuuFIoivei511sihS+RXqDM1y3B/We2UUETMczUTS6EIW
         mdBvGc7akvx2Ij9RSHVWAdnTmN7qONOjcnHfbBoL1VZZMLFZZ50wEHxh2TxKegxbPWDv
         zx3MgyrcPeJT89NtXaiSU2KYvo5zwE20pTpQCHqlVKntIlQOIoy5p+xZEZZjpUSQr1pv
         mbPn9oOzLYz5Cdm35qniBqPLtvssKZO3UAHpZYFfWNqCaEPIF+qWHGvzDY1OtkNYo916
         i5GQ==
X-Gm-Message-State: ANoB5plmqgdOJglyDv4oybbmnjtnTxZQGxozWaZlAjJQ6frNznAXN2Tv
        YZrYQkrkwZBGmQzkg6OBZsRo
X-Google-Smtp-Source: AA0mqf5IoN51YQnfLisA+oT6wS/LYhSB4Fzm4X/TFdvbGd8+atxuWTLRRLDBIMlEIL+18Hmw0kMPaw==
X-Received: by 2002:a17:903:240a:b0:188:abb9:290 with SMTP id e10-20020a170903240a00b00188abb90290mr63732725plo.86.1670230981430;
        Mon, 05 Dec 2022 01:03:01 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id z189-20020a6365c6000000b00460c67afbd5sm7900683pgb.7.2022.12.05.01.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:03:01 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] vduse: Add enable_irq_wq sysfs interface for virtqueues
Date:   Mon,  5 Dec 2022 17:02:41 +0800
Message-Id: <20221205090243.791-3-xieyongji@bytedance.com>
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

Add enable_irq_wq sysfs interface to control whether
use workqueue to inject irq or not. The vhost-vdpa case
can benefit from it.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 50 +++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index c65f84100e30..ed06c7afd484 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -62,6 +62,7 @@ struct vduse_virtqueue {
 	struct cpumask irq_affinity;
 	spinlock_t irq_affinity_lock;
 	struct kobject kobj;
+	bool enable_irq_wq;
 };
 
 struct vduse_dev;
@@ -1013,6 +1014,26 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
+static int vduse_dev_inject_vq_irq(struct vduse_dev *dev,
+				   struct vduse_virtqueue *vq)
+{
+	int ret = -EINVAL;
+
+	down_read(&dev->rwsem);
+	if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto unlock;
+
+	ret = 0;
+	spin_lock_irq(&vq->irq_lock);
+	if (vq->ready && vq->cb.callback)
+		vq->cb.callback(vq->cb.private);
+	spin_unlock_irq(&vq->irq_lock);
+unlock:
+	up_read(&dev->rwsem);
+
+	return ret;
+}
+
 static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 				u64 iova, u64 size)
 {
@@ -1278,8 +1299,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		index = array_index_nospec(index, dev->vq_num);
-		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
+		if (dev->vqs[index]->enable_irq_wq)
+			ret = vduse_dev_queue_irq_work(dev,
+					&dev->vqs[index]->inject,
 					dev->vqs[index]->irq_effective_cpu);
+		else
+			ret = vduse_dev_inject_vq_irq(dev, dev->vqs[index]);
 		break;
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
@@ -1420,6 +1445,26 @@ static const struct file_operations vduse_dev_fops = {
 	.llseek		= noop_llseek,
 };
 
+static ssize_t enable_irq_wq_show(struct vduse_virtqueue *vq, char *buf)
+{
+	return sprintf(buf, "%d\n", vq->enable_irq_wq);
+}
+
+static ssize_t enable_irq_wq_store(struct vduse_virtqueue *vq,
+				   const char *buf, size_t count)
+{
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	vq->enable_irq_wq = enabled;
+
+	return count;
+}
+
 static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
 {
 	return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
@@ -1480,10 +1525,12 @@ struct vq_sysfs_entry {
 static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RO(irq_cb_affinity);
 static struct vq_sysfs_entry irq_cb_effective_affinity_attr =
 					__ATTR_RW(irq_cb_effective_affinity);
+static struct vq_sysfs_entry enable_irq_wq_attr = __ATTR_RW(enable_irq_wq);
 
 static struct attribute *vq_attrs[] = {
 	&irq_cb_affinity_attr.attr,
 	&irq_cb_effective_affinity_attr.attr,
+	&enable_irq_wq_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(vq);
@@ -1565,6 +1612,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 
 		dev->vqs[i]->index = i;
 		dev->vqs[i]->irq_effective_cpu = -1;
+		dev->vqs[i]->enable_irq_wq = true;
 		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
 		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
 		spin_lock_init(&dev->vqs[i]->kick_lock);
-- 
2.20.1

