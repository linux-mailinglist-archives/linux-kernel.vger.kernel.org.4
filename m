Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4230C6C5EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCWFdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCWFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:32:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2953250B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c18so21301547ple.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679549495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TL2Dnn/bucJdLF0dm9z8HJ4wRhbVCYyNvRp5emR3AUo=;
        b=i3Quh5FdSnsK5S8yceJvpITNjicWODJB65IpP5laC2v+d9NcrwzKw/WQfHDMT9Ji97
         MkPTfdS913ShF1NuItbU+hJpE1X76gey4LsAKWecnaE22peXx4HaX1Xj/YgnNbVHnj2/
         EkQIxPHo0ZjbaGbDk4BbG7vaSC2JjODW4O/D+0x0z24SdNxLv86wynLP5OL4DtTK2VuQ
         Y3mqYJJosdXQ9tnufUDnf8iWplzP8CZbrVKcUSs/1ONccQGc8fFzq69b2m+BW2ak5YUT
         rJHmzu7y3iSDu+Q9YF37M6NM2TENqWpNutdn5Nfmn56vVVC3TFcsk3afeTv51914FNdL
         TUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TL2Dnn/bucJdLF0dm9z8HJ4wRhbVCYyNvRp5emR3AUo=;
        b=0GZhU1rWrVgSGxALuDvVOMxUVt7rfGYkZh6IluXQcVX45WZB9tixbp8NgzI6smuImh
         mDOP0QkotTpX/qj1v+ta1rPhgGjkKxYH3SyBfDCf5NjYdKTuJsesoFmnOS7aFOglhCrf
         OyDFzM/57Taw6VvNHE8dS7MaJobFBDPsv6dn2YNJ5NBkX0CgeHrrLWOl3hUt/HjOZ0mG
         UvBx8J5ej7IXDBKmeZ6ToeEqFJUISZhJs2WHAKddODP+qgdlR+Qo6ZKvLVNIqfH5o1Ya
         JCoTQvmgwU8cwLwGDCKjARECKhbx8uCpBarPDOlPMPjBTaO9aclAdSA6AtZgl9iQZ158
         DwRA==
X-Gm-Message-State: AO0yUKXQpZw4CznEVuAJ/kyWzKuqtMI8TBLL7CVdWBpG6Hr8M5jNcQhh
        hFEyrmCxOBm6hILLuFXRBVd2paEpZ0JDX//T8g==
X-Google-Smtp-Source: AK7set/ovmZijmAZnGNe/xaFmDi6W+0WyEWy8huXYQGuQP47+C6qF6+NwTrw08TzYiaaRNtlsK0Hkg==
X-Received: by 2002:a17:90b:33c2:b0:23f:7ff6:eba with SMTP id lk2-20020a17090b33c200b0023f7ff60ebamr7028841pjb.0.1679549494930;
        Wed, 22 Mar 2023 22:31:34 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b0019aafc422fcsm11407530plo.240.2023.03.22.22.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:31:34 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] vduse: Add sysfs interface for irq callback affinity
Date:   Thu, 23 Mar 2023 13:30:39 +0800
Message-Id: <20230323053043.35-8-xieyongji@bytedance.com>
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

Add sysfs interface for each vduse virtqueue to
get/set the affinity for irq callback. This might
be useful for performance tuning when the irq callback
affinity mask contains more than one CPU.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 124 ++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index cefabd0dab9c..77da3685568a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -61,6 +61,7 @@ struct vduse_virtqueue {
 	struct work_struct kick;
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
+	struct kobject kobj;
 };
 
 struct vduse_dev;
@@ -1387,6 +1388,96 @@ static const struct file_operations vduse_dev_fops = {
 	.llseek		= noop_llseek,
 };
 
+static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
+{
+	return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
+}
+
+static ssize_t irq_cb_affinity_store(struct vduse_virtqueue *vq,
+				     const char *buf, size_t count)
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
+	if (!cpumask_intersects(new_value, cpu_online_mask))
+		goto free_mask;
+
+	cpumask_copy(&vq->irq_affinity, new_value);
+	ret = count;
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
+static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RW(irq_cb_affinity);
+
+static struct attribute *vq_attrs[] = {
+	&irq_cb_affinity_attr.attr,
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
+static const struct kobj_type vq_type = {
+	.release	= vq_release,
+	.sysfs_ops	= &vq_sysfs_ops,
+	.default_groups	= vq_groups,
+};
+
 static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
 {
 	int i;
@@ -1395,13 +1486,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
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
@@ -1411,8 +1502,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 
 	for (i = 0; i < vq_num; i++) {
 		dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
-		if (!dev->vqs[i])
+		if (!dev->vqs[i]) {
+			ret = -ENOMEM;
 			goto err;
+		}
 
 		dev->vqs[i]->index = i;
 		dev->vqs[i]->irq_effective_cpu = IRQ_UNBOUND;
@@ -1421,15 +1514,23 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 		spin_lock_init(&dev->vqs[i]->kick_lock);
 		spin_lock_init(&dev->vqs[i]->irq_lock);
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
@@ -1607,10 +1708,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->config = config_buf;
 	dev->config_size = config->config_size;
 
-	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
-	if (ret)
-		goto err_vqs;
-
 	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto err_idr;
@@ -1624,14 +1721,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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

