Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA56A5609
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjB1Jmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjB1Jmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:42:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB562CFF7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so13101202pjh.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXM72I6oSJKufWn/quSJk+pwmhX/n98osWkCo8kxouU=;
        b=PgzIbtzFGF22EBlwqzvX8aiRohLZBqC02pR3pKa8B4D5vk0aOOrLo8IGekJ5gaNjYZ
         9T7OLh6JAD2wnf4tYM5nKSnLhTfltDCh/erNsMtGeecXrqibixUV/ZeFP7WBRTxwu4AI
         FbIVeAJKiEzHw7Tk68abwdOltACASmXEKOBNz11bZe+ZAZ8e8NvxUj/hrPAJtvQ42dEt
         hwb4GcL4VQHsgcpIbXX7zoiw80WUzrPYvfOtxtRdMJxJ6esToDovjXof8yTlnOesGwlt
         4744Oxt0Ev+xo4QN5J25IKiav+UpBNZ+vAbwvLEibRMRpuv8sTux7V5tePkecKACsynt
         lxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXM72I6oSJKufWn/quSJk+pwmhX/n98osWkCo8kxouU=;
        b=kScSBv65sH1CEi5VaAEcrDK5IWpo5F5kGtJyLvauS/0mwhYBG0tmaE6sCtR/uH/pum
         PPmxb9op1vHFYHyYcVh2pzP17T53w9iTvQ6bQ8Im/mX9kKsNWoIUoc7kDggyRrAckJ48
         sXPhLxw3saoNHcbViAfiFjH2jrbdgliFu2elhLbWOEvpqlCG8gs9A61+n/ovpBjWYC0k
         9V6Ue/I8hHTsWMQcTKVFn1DYzOKFbukcPyaExUky7BkmKth9Z7a5hTVEX8ViTHQ9Om2c
         UMy+VnI/+DD1QNpnDj0JUf07zioXH0YZa2eoitXDwSzhniS5UfW8Ez9JxK3SsNPbYoeN
         n6yw==
X-Gm-Message-State: AO0yUKWSV8AiG9SgMdTd3S19sxmv1O9jXskT2W7Zjb2YfQSA7Yy2MtyA
        TSGo4BN3T5NOclkGSKcKuzbd
X-Google-Smtp-Source: AK7set+4l+2/JtNFVaFrQaY796soQpS/3Zz0be4R5uLqq2Oyfmu9qUXepWUwLA70p5FFU4+qqws91g==
X-Received: by 2002:a17:902:ea0e:b0:19d:1fe3:4941 with SMTP id s14-20020a170902ea0e00b0019d1fe34941mr2586722plg.2.1677577353921;
        Tue, 28 Feb 2023 01:42:33 -0800 (PST)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00194ac38bc86sm6059429plm.131.2023.02.28.01.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 01:42:33 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] vduse: Add sysfs interface for irq callback affinity
Date:   Tue, 28 Feb 2023 17:41:06 +0800
Message-Id: <20230228094110.37-8-xieyongji@bytedance.com>
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

Add sysfs interface for each vduse virtqueue to
get/set the affinity for irq callback. This might
be useful for performance tuning when the irq callback
affinity mask contains more than one CPU.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 124 ++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e2988a1476e4..869cc7860d82 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -63,6 +63,7 @@ struct vduse_virtqueue {
 	struct work_struct kick;
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
+	struct kobject kobj;
 };
 
 struct vduse_dev;
@@ -1466,6 +1467,96 @@ static const struct file_operations vduse_dev_fops = {
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
@@ -1474,13 +1565,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
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
@@ -1490,8 +1581,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
 
 	for (i = 0; i < vq_num; i++) {
 		dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
-		if (!dev->vqs[i])
+		if (!dev->vqs[i]) {
+			ret = -ENOMEM;
 			goto err;
+		}
 
 		dev->vqs[i]->index = i;
 		dev->vqs[i]->irq_effective_cpu = -1;
@@ -1500,15 +1593,23 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
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
@@ -1686,10 +1787,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->config = config_buf;
 	dev->config_size = config->config_size;
 
-	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
-	if (ret)
-		goto err_vqs;
-
 	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
 	if (ret < 0)
 		goto err_idr;
@@ -1703,14 +1800,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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

