Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2D630D10
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiKSHyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:54:31 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFB6167E6;
        Fri, 18 Nov 2022 23:54:29 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDmBN0jxxzRpBC;
        Sat, 19 Nov 2022 15:54:04 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 15:54:27 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 15:54:27 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH v10 1/3] uacce: supports device isolation feature
Date:   Sat, 19 Nov 2022 07:48:15 +0000
Message-ID: <20221119074817.12063-2-yekai13@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221119074817.12063-1-yekai13@huawei.com>
References: <20221119074817.12063-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UACCE adds the hardware error isolation feature. To improve service
reliability, some uacce devices that frequently encounter hardware
errors are isolated. Therefore, this feature is added.

Users can configure the hardware error threshold by 'isolate_strategy'
sysfs node. The user space can get the device isolated state by 'isolate'
sysfs node. If the number of device errors exceeds the configured error
threshold, the device will be isolated. It means the uacce device is
unavailable.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/misc/uacce/uacce.c | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/uacce.h      | 12 +++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index b70a013139c7..946f7e4b364f 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -363,12 +363,52 @@ static ssize_t region_dus_size_show(struct device *dev,
 		       uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
 }
 
+static ssize_t isolate_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+
+	return sysfs_emit(buf, "%d\n", uacce->ops->get_isolate_state(uacce));
+}
+
+static ssize_t isolate_strategy_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	u32 val;
+
+	val = uacce->ops->isolate_err_threshold_read(uacce);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
+static ssize_t isolate_strategy_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct uacce_device *uacce = to_uacce_device(dev);
+	unsigned long val;
+	int ret;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val > UACCE_MAX_ERR_THRESHOLD)
+		return -EINVAL;
+
+	ret = uacce->ops->isolate_err_threshold_write(uacce, val);
+	if (ret)
+		return ret;
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
@@ -377,6 +417,8 @@ static struct attribute *uacce_dev_attrs[] = {
 	&dev_attr_algorithms.attr,
 	&dev_attr_region_mmio_size.attr,
 	&dev_attr_region_dus_size.attr,
+	&dev_attr_isolate.attr,
+	&dev_attr_isolate_strategy.attr,
 	NULL,
 };
 
@@ -392,6 +434,14 @@ static umode_t uacce_dev_is_visible(struct kobject *kobj,
 	    (!uacce->qf_pg_num[UACCE_QFRT_DUS])))
 		return 0;
 
+	if (attr == &dev_attr_isolate_strategy.attr &&
+	    (!uacce->ops->isolate_err_threshold_read &&
+	     !uacce->ops->isolate_err_threshold_write))
+		return 0;
+
+	if (attr == &dev_attr_isolate.attr && !uacce->ops->get_isolate_state)
+		return 0;
+
 	return attr->mode;
 }
 
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 9ce88c28b0a8..0a81c3dfd26c 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -8,6 +8,7 @@
 #define UACCE_NAME		"uacce"
 #define UACCE_MAX_REGION	2
 #define UACCE_MAX_NAME_SIZE	64
+#define UACCE_MAX_ERR_THRESHOLD	65535
 
 struct uacce_queue;
 struct uacce_device;
@@ -30,6 +31,9 @@ struct uacce_qfile_region {
  * @is_q_updated: check whether the task is finished
  * @mmap: mmap addresses of queue to user space
  * @ioctl: ioctl for user space users of the queue
+ * @get_isolate_state: get the device state after set the isolate strategy
+ * @isolate_err_threshold_write: stored the isolate error threshold to the device
+ * @isolate_err_threshold_read: read the isolate error threshold value from the device
  */
 struct uacce_ops {
 	int (*get_available_instances)(struct uacce_device *uacce);
@@ -43,6 +47,9 @@ struct uacce_ops {
 		    struct uacce_qfile_region *qfr);
 	long (*ioctl)(struct uacce_queue *q, unsigned int cmd,
 		      unsigned long arg);
+	enum uacce_dev_state (*get_isolate_state)(struct uacce_device *uacce);
+	int (*isolate_err_threshold_write)(struct uacce_device *uacce, u32 num);
+	u32 (*isolate_err_threshold_read)(struct uacce_device *uacce);
 };
 
 /**
@@ -57,6 +64,11 @@ struct uacce_interface {
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
-- 
2.17.1

