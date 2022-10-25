Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1360CC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiJYMsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiJYMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:47:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEE18C959
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:45:25 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxWqn2FkBzHv0M;
        Tue, 25 Oct 2022 20:45:09 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 20:45:21 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 20:45:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v9 1/3] uacce: supports device isolation feature
Date:   Tue, 25 Oct 2022 12:39:29 +0000
Message-ID: <20221025123931.42161-2-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025123931.42161-1-yekai13@huawei.com>
References: <20221025123931.42161-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UACCE adds the hardware error isolation API. Users can configure
the isolation frequency by this sysfs node. UACCE reports the device
isolate state to the user space. If the AER error frequency exceeds
the set value in one hour, the device will be isolated.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/misc/uacce/uacce.c | 145 +++++++++++++++++++++++++++++++++++++
 include/linux/uacce.h      |  43 ++++++++++-
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index b70a013139c7..f293fcdcf44f 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -7,10 +7,100 @@
 #include <linux/slab.h>
 #include <linux/uacce.h>
 
+#define MAX_ERR_ISOLATE_COUNT	65535
+
 static struct class *uacce_class;
 static dev_t uacce_devt;
 static DEFINE_XARRAY_ALLOC(uacce_xa);
 
+static int cdev_get(struct device *dev, void *data)
+{
+	struct uacce_device *uacce;
+	struct device **t_dev = data;
+
+	uacce = container_of(dev, struct uacce_device, dev);
+	if (uacce->parent == *t_dev) {
+		*t_dev = dev;
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * dev_to_uacce - Get structure uacce device from its parent device
+ * @dev the device
+ */
+struct uacce_device *dev_to_uacce(struct device *dev)
+{
+	struct device **tdev = &dev;
+	int ret;
+
+	ret = class_for_each_device(uacce_class, NULL, tdev, cdev_get);
+	if (ret) {
+		dev = *tdev;
+		return container_of(dev, struct uacce_device, dev);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(dev_to_uacce);
+
+/**
+ * uacce_hw_err_isolate - Try to set the isolation status of the uacce device
+ * according to user's configuration of isolation strategy.
+ * @uacce the uacce device
+ */
+int uacce_hw_err_isolate(struct uacce_device *uacce)
+{
+	struct uacce_hw_err *err, *tmp, *hw_err;
+	struct uacce_err_isolate *isolate_ctx;
+	u32 count = 0;
+
+	if (!uacce)
+		return -EINVAL;
+
+	isolate_ctx = uacce->isolate_ctx;
+
+#define SECONDS_PER_HOUR	3600
+
+	/* All the hw errs are processed by PF driver */
+	if (uacce->is_vf || isolate_ctx->is_isolate ||
+		!isolate_ctx->hw_err_isolate_hz)
+		return 0;
+
+	hw_err = kzalloc(sizeof(*hw_err), GFP_KERNEL);
+	if (!hw_err)
+		return -ENOMEM;
+
+	hw_err->timestamp = jiffies;
+	list_for_each_entry_safe(err, tmp, &isolate_ctx->hw_errs, list) {
+		if ((hw_err->timestamp - err->timestamp) / HZ >
+		    SECONDS_PER_HOUR) {
+			list_del(&err->list);
+			kfree(err);
+		} else {
+			count++;
+		}
+	}
+	list_add(&hw_err->list, &isolate_ctx->hw_errs);
+
+	if (count >= isolate_ctx->hw_err_isolate_hz)
+		isolate_ctx->is_isolate = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uacce_hw_err_isolate);
+
+static void uacce_hw_err_destroy(struct uacce_device *uacce)
+{
+	struct uacce_hw_err *err, *tmp;
+
+	list_for_each_entry_safe(err, tmp, &uacce->isolate_data.hw_errs, list) {
+		list_del(&err->list);
+		kfree(err);
+	}
+}
+
 /*
  * If the parent driver or the device disappears, the queue state is invalid and
  * ops are not usable anymore.
@@ -363,12 +453,59 @@ static ssize_t region_dus_size_show(struct device *dev,
 		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
 }
 
+static ssize_t isolate_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	int ret = UACCE_DEV_NORMAL;
+
+	if (uacce->isolate_ctx->is_isolate)
+		ret = UACCE_DEV_ISOLATE;
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+
+static ssize_t isolate_strategy_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sysfs_emit(buf, "%u\n", uacce->isolate_ctx->hw_err_isolate_hz);
+}
+
+static ssize_t isolate_strategy_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	unsigned long val;
+
+	/* must be set by PF */
+	if (uacce->is_vf)
+		return -EPERM;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > MAX_ERR_ISOLATE_COUNT)
+		return -EINVAL;
+
+	uacce->isolate_ctx->hw_err_isolate_hz = val;
+
+	/* After the policy is updated, need to reset the hardware err list */
+	uacce_hw_err_destroy(uacce);
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(api);
 static DEVICE_ATTR_RO(flags);
 static DEVICE_ATTR_RO(available_instances);
 static DEVICE_ATTR_RO(algorithms);
 static DEVICE_ATTR_RO(region_mmio_size);
 static DEVICE_ATTR_RO(region_dus_size);
+static DEVICE_ATTR_RO(isolate);
+static DEVICE_ATTR_RW(isolate_strategy);
 
 static struct attribute *uacce_dev_attrs[] = {
 	&dev_attr_api.attr,
@@ -377,6 +514,8 @@ static struct attribute *uacce_dev_attrs[] = {
 	&dev_attr_algorithms.attr,
 	&dev_attr_region_mmio_size.attr,
 	&dev_attr_region_dus_size.attr,
+	&dev_attr_isolate.attr,
+	&dev_attr_isolate_strategy.attr,
 	NULL,
 };
 
@@ -392,6 +531,9 @@ static umode_t uacce_dev_is_visible(struct kobject *kobj,
 	    (!uacce->qf_pg_num[UACCE_QFRT_DUS])))
 		return 0;
 
+	if (attr == &dev_attr_isolate_strategy.attr && !uacce->isolate_ctx)
+		return 0;
+
 	return attr->mode;
 }
 
@@ -474,6 +616,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 		goto err_with_uacce;
 
 	INIT_LIST_HEAD(&uacce->queues);
+	INIT_LIST_HEAD(&uacce->isolate_data.hw_errs);
 	mutex_init(&uacce->mutex);
 	device_initialize(&uacce->dev);
 	uacce->dev.devt = MKDEV(MAJOR(uacce_devt), uacce->dev_id);
@@ -555,6 +698,8 @@ void uacce_remove(struct uacce_device *uacce)
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
 	xa_erase(&uacce_xa, uacce->dev_id);
+
+	uacce_hw_err_destroy(uacce);
 	/*
 	 * uacce exists as long as there are open fds, but ops will be freed
 	 * now. Ensure that bugs cause NULL deref rather than use-after-free.
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 9ce88c28b0a8..c8eecaf7b16d 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -12,6 +12,28 @@
 struct uacce_queue;
 struct uacce_device;
 
+/**
+ * struct uacce_hw_err - Structure describing the device errors
+ * @list: hardware error log node
+ * @timestamp: timestamp when the error occurred
+ */
+struct uacce_hw_err {
+	struct list_head list;
+	unsigned long long timestamp;
+};
+
+/**
+ * struct uacce_err_isolate - Structure describing the isolation data
+ * @hw_err_isolate_hz: user cfg freq which triggers isolation
+ * @is_isolate: device isolate state
+ * @hw_errs: uacce hardware error list
+ */
+struct uacce_err_isolate {
+	u32 hw_err_isolate_hz;
+	bool is_isolate;
+	struct list_head hw_errs;
+};
+
 /**
  * struct uacce_qfile_region - structure of queue file region
  * @type: type of the region
@@ -57,6 +79,11 @@ struct uacce_interface {
 	const struct uacce_ops *ops;
 };
 
+enum uacce_dev_state {
+	UACCE_DEV_NORMAL,
+	UACCE_DEV_ISOLATE,
+};
+
 enum uacce_q_state {
 	UACCE_Q_ZOMBIE = 0,
 	UACCE_Q_INIT,
@@ -101,6 +128,8 @@ struct uacce_queue {
  * @dev: dev of the uacce
  * @mutex: protects uacce operation
  * @priv: private pointer of the uacce
+ * @isolate_data: device isolation data about pf and vf device
+ * @isolate_ctx: isolation ctx about current char device
  * @queues: list of queues
  * @inode: core vfs
  */
@@ -117,6 +146,8 @@ struct uacce_device {
 	struct device dev;
 	struct mutex mutex;
 	void *priv;
+	struct uacce_err_isolate isolate_data;
+	struct uacce_err_isolate *isolate_ctx;
 	struct list_head queues;
 	struct inode *inode;
 };
@@ -127,7 +158,8 @@ struct uacce_device *uacce_alloc(struct device *parent,
 				 struct uacce_interface *interface);
 int uacce_register(struct uacce_device *uacce);
 void uacce_remove(struct uacce_device *uacce);
-
+struct uacce_device *dev_to_uacce(struct device *dev);
+int uacce_hw_err_isolate(struct uacce_device *uacce);
 #else /* CONFIG_UACCE */
 
 static inline
@@ -144,6 +176,15 @@ static inline int uacce_register(struct uacce_device *uacce)
 
 static inline void uacce_remove(struct uacce_device *uacce) {}
 
+static inline struct uacce_device *dev_to_uacce(struct device *dev)
+{
+	return NULL;
+}
+
+int uacce_hw_err_isolate(struct uacce_device *uacce)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_UACCE */
 
 #endif /* _LINUX_UACCE_H */
-- 
2.17.1

