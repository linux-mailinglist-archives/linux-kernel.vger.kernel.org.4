Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6165642555
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLEJEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiLEJD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:03:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB84DE9D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:02:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so14144342pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3uhbY4lwU4y8TtkVG7MMu4/x3HSVOU76J0Hc6lokBs=;
        b=YuTQGk3JDlJpZX2nnGWEHpINdwahi2g6qU1MNJgM2MuruYoqwUnhnDun/NqZtLGx85
         2scII5gmfhp1Lk+HDUCM2Pub+Gqi/ejEos4w2gCXkQFlLCPyw5ynvAlG0RIT840XrQIs
         PrLbfUy4J2mmDLwLYOpZwtTnZofyMIpsmF4xghhYyW+dhHky5jqdWBI7bMg3LjOwqyV7
         1lzzh3WXgVL1pVvRGf0aQH+cjKkR9K6Ps5kt1edzHHy9eZm/wltZ6q5HqGok3/2BQoCV
         37OTLymIRuSGViC1xjPJZ8U9Nj888vfA9abrkYMQicZf7W4ljlR99reJfTUvwiCxwbXK
         oOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3uhbY4lwU4y8TtkVG7MMu4/x3HSVOU76J0Hc6lokBs=;
        b=BmJXs27fI43Qhc0+vNKOD6lop2aO7JTz2IVgods1grSVqMoigWZbAM51fOcAU/lvQu
         vYK/KgvkLG6Bq0SIaDS04BTwi6svULqXhyFIO4PF8wJC5Zk21Ru+tPnOlNNKpZpBvnVX
         vHhtnS4PU3alsExX9DPnAxzmtwRgZu4mNXluri4lVlCqruiY3TD7T5N+zaZP2fe6tKfH
         WWTtslxSR9rNeajzxnj5PhNxQtpiz9HqUKaUBWLBTYLdCiGCe8I1ioInNPvJIlkJL7wD
         7P504zAHePHY/Vop0sgug5j1TXim30h1yC4S0AwrLdB/Vb+ygoZEGsVJWWDZMV6zHSwa
         7yqg==
X-Gm-Message-State: ANoB5pmSgzqoGYbSjKFtrNW/3m7XxassBQ3zwr7GuZVih9jEyflfENmZ
        3KF93d1sluJM7T/4daPO/qAR
X-Google-Smtp-Source: AA0mqf5P9zert5fZnkW6dHgsFoqfMgTaya2I0c3CSqg9RJBi23nSSzQt3OzuATuTABG41oU8P2ZN4A==
X-Received: by 2002:a17:90b:11d6:b0:219:ce92:17a1 with SMTP id gv22-20020a17090b11d600b00219ce9217a1mr4975256pjb.235.1670230978187;
        Mon, 05 Dec 2022 01:02:58 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id y14-20020a62640e000000b0056bb4bbfb9bsm6709398pfb.95.2022.12.05.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 01:02:57 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] vduse: Add sysfs interface for irq callback affinity
Date:   Mon,  5 Dec 2022 17:02:40 +0800
Message-Id: <20221205090243.791-2-xieyongji@bytedance.com>
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

Add sysfs interface for each vduse virtqueue to
show the affinity and effective affinity for irq
callback.

And we can also use this interface to change the
effective affinity which must be a subset of the
irq callback affinity mask for the virtqueue. This
might be useful for performance tuning when the irq
callback affinity mask contains more than one CPU.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
 1 file changed, 137 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6507a78abc9d..c65f84100e30 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -61,6 +61,7 @@ struct vduse_virtqueue {
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
 	spinlock_t irq_affinity_lock;
+	struct kobject kobj;
 };
 
 struct vduse_dev;
@@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
 	.llseek		= noop_llseek,
 };
 
+static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
+{
+	return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
+}
+
+static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
+					      char *buf)
+{
+	struct cpumask all_mask = CPU_MASK_ALL;
+	const struct cpumask *mask = &all_mask;
+
+	if (vq->irq_effective_cpu != -1)
+		mask = get_cpu_mask(vq->irq_effective_cpu);
+
+	return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
+}
+
+static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
+					       const char *buf, size_t count)
+{
+	cpumask_var_t new_value;
+	int ret;
+
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = cpumask_parse(buf, new_value);
+	if (ret)
+		goto free_mask;
+
+	ret = -EINVAL;
+	if (!cpumask_intersects(new_value, &vq->irq_affinity))
+		goto free_mask;
+
+	spin_lock(&vq->irq_affinity_lock);
+
+	if (vq->irq_effective_cpu != -1)
+		per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
+
+	vq->irq_effective_cpu = cpumask_first(new_value);
+	per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) += 1;
+
+	spin_unlock(&vq->irq_affinity_lock);
+	ret = count;
+
+free_mask:
+	free_cpumask_var(new_value);
+	return ret;
+}
+
+struct vq_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct vduse_virtqueue *vq, char *buf);
+	ssize_t (*store)(struct vduse_virtqueue *vq, const char *buf,
+			 size_t count);
+};
+
+static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RO(irq_cb_affinity);
+static struct vq_sysfs_entry irq_cb_effective_affinity_attr =
+					__ATTR_RW(irq_cb_effective_affinity);
+
+static struct attribute *vq_attrs[] = {
+	&irq_cb_affinity_attr.attr,
+	&irq_cb_effective_affinity_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(vq);
+
+static ssize_t vq_attr_show(struct kobject *kobj, struct attribute *attr,
+			    char *buf)
+{
+	struct vduse_virtqueue *vq = container_of(kobj,
+					struct vduse_virtqueue, kobj);
+	struct vq_sysfs_entry *entry = container_of(attr,
+					struct vq_sysfs_entry, attr);
+
+	if (!entry->show)
+		return -EIO;
+
+	return entry->show(vq, buf);
+}
+
+static ssize_t vq_attr_store(struct kobject *kobj, struct attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct vduse_virtqueue *vq = container_of(kobj,
+					struct vduse_virtqueue, kobj);
+	struct vq_sysfs_entry *entry = container_of(attr,
+					struct vq_sysfs_entry, attr);
+
+	if (!entry->store)
+		return -EIO;
+
+	return entry->store(vq, buf, count);
+}
+
+static const struct sysfs_ops vq_sysfs_ops = {
+	.show = vq_attr_show,
+	.store = vq_attr_store,
+};
+
+static void vq_release(struct kobject *kobj)
+{
+	struct vduse_virtqueue *vq = container_of(kobj,
+					struct vduse_virtqueue, kobj);
+	kfree(vq);
+}
+
+static struct kobj_type vq_type = {
+	.release	= vq_release,
+	.sysfs_ops	= &vq_sysfs_ops,
+	.default_groups	= vq_groups,
+};
+
 static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
 {
 	int i;
@@ -1427,13 +1542,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
 		return;
 
 	for (i = 0; i < dev->vq_num; i++)
-		kfree(dev->vqs[i]);
+		kobject_put(&dev->vqs[i]->kobj);
 	kfree(dev->vqs);
 }
 
 static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 {
-	int i;
+	int ret, i;
 
 	dev->vq_align = vq_align;
 	dev->vq_num = vq_num;
@@ -1443,8 +1558,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 
 	for (i = 0; i < vq_num; i++) {
 		dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
-		if (!dev->vqs[i])
+		if (!dev->vqs[i]) {
+			ret = -ENOMEM;
 			goto err;
+		}
 
 		dev->vqs[i]->index = i;
 		dev->vqs[i]->irq_effective_cpu = -1;
@@ -1454,15 +1571,23 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 		spin_lock_init(&dev->vqs[i]->irq_lock);
 		spin_lock_init(&dev->vqs[i]->irq_affinity_lock);
 		cpumask_setall(&dev->vqs[i]->irq_affinity);
+
+		kobject_init(&dev->vqs[i]->kobj, &vq_type);
+		ret = kobject_add(&dev->vqs[i]->kobj,
+				  &dev->dev->kobj, "vq%d", i);
+		if (ret) {
+			kfree(dev->vqs[i]);
+			goto err;
+		}
 	}
 
 	return 0;
 err:
 	while (i--)
-		kfree(dev->vqs[i]);
+		kobject_put(&dev->vqs[i]->kobj);
 	kfree(dev->vqs);
 	dev->vqs = NULL;
-	return -ENOMEM;
+	return ret;
 }
 
 static struct vduse_dev *vduse_dev_create(void)
@@ -1637,10 +1762,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->config = config_buf;
 	dev->config_size = config->config_size;
 
-	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
-	if (ret)
-		goto err_vqs;
-
 	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto err_idr;
@@ -1654,14 +1775,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 		ret = PTR_ERR(dev->dev);
 		goto err_dev;
 	}
+
+	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
+	if (ret)
+		goto err_vqs;
+
 	__module_get(THIS_MODULE);
 
 	return 0;
+err_vqs:
+	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-	vduse_dev_deinit_vqs(dev);
-err_vqs:
 	vduse_domain_destroy(dev->domain);
 err_domain:
 	kfree(dev->name);
-- 
2.20.1

