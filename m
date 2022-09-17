Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB435BB802
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIQLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 07:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIQLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 07:39:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56633E1A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 04:38:58 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MV85m0skTzpStZ;
        Sat, 17 Sep 2022 19:36:12 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 19:38:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 17 Sep
 2022 19:38:56 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tj@kernel.org>, <jiangshanlai@gmail.com>
Subject: [PATCH -next] workqueue: devres: provide device-managed allocate workqueue APIs
Date:   Sat, 17 Sep 2022 19:45:53 +0800
Message-ID: <20220917114553.1877231-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a series of device-managed allocate workqueue APIs. The
workqueue allocated by these APIs are managed by device resource,
it will be destroyed whenever the device is unbound. Drivers could
use these APIs to simpilfy the error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 .../driver-api/driver-model/devres.rst        |  7 ++++
 include/linux/workqueue.h                     | 19 ++++++++++
 kernel/workqueue.c                            | 35 +++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 2895f9ea00c4..76cc256c9e4f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -440,3 +440,10 @@ SPI
 
 WATCHDOG
   devm_watchdog_register_device()
+
+WORKQUEUE
+  devm_alloc_workqueue()
+  devm_alloc_ordered_workqueue()
+  devm_create_workqueue()
+  devm_create_freezable_workqueue()
+  devm_create_singlethread_workqueue()
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..4f6b9940acfa 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -402,6 +402,11 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
 __printf(1, 4) struct workqueue_struct *
 alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 
+__printf(2, 5) struct workqueue_struct *
+devm_alloc_workqueue(struct device *dev, const char *fmt, unsigned int flags,
+		     int max_active, ...);
+
+
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
@@ -419,15 +424,29 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED |		\
 			__WQ_ORDERED_EXPLICIT | (flags), 1, ##args)
 
+#define devm_alloc_ordered_workqueue(dev, fmt, flags, args...)		\
+	devm_alloc_workqueue(dev, fmt, WQ_UNBOUND | __WQ_ORDERED |	\
+			     __WQ_ORDERED_EXPLICIT | (flags), 1, ##args)\
+
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
+#define devm_create_workqueue(dev, name)				\
+	devm_alloc_workqueue(dev, "%s", __WQ_LEGACY | WQ_MEM_RECLAIM,	\
+			     1, (name))
 #define create_freezable_workqueue(name)				\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
 			WQ_MEM_RECLAIM, 1, (name))
+#define devm_create_freezable_workqueue(dev, name)			\
+	devm_alloc_workqueue(dev, "%s", __WQ_LEGACY | WQ_FREEZABLE |	\
+			     WQ_UNBOUND | WQ_MEM_RECLAIM, 1, (name))
 #define create_singlethread_workqueue(name)				\
 	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
+#define devm_create_singlethread_workqueue(dev, name)			\
+	devm_alloc_ordered_workqueue(dev, "%s",__WQ_LEGACY |		\
+				     WQ_MEM_RECLAIM, name)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
+extern void devm_destroy_workqueue(struct device *dev, void *res);
 
 struct workqueue_attrs *alloc_workqueue_attrs(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 39060a5d0905..418b21b4d025 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4490,6 +4490,41 @@ void destroy_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL_GPL(destroy_workqueue);
 
+void devm_destroy_workqueue(struct device *dev, void *res)
+{
+	destroy_workqueue(*(struct workqueue_struct **)res);
+}
+EXPORT_SYMBOL_GPL(devm_destroy_workqueue);
+
+__printf(2, 5) struct workqueue_struct *
+devm_alloc_workqueue(struct device *dev, const char *fmt, unsigned int flags,
+		     int max_active, ...)
+{
+	struct workqueue_struct **ptr;
+	struct workqueue_struct *wq;
+	char name[WQ_NAME_LEN];
+	va_list args;
+
+	ptr = devres_alloc(devm_destroy_workqueue, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	va_start(args, max_active);
+	vsnprintf(name, sizeof(name), fmt, args);
+	va_end(args);
+
+	wq = alloc_workqueue(name, flags, max_active);
+	if (!wq) {
+		devres_free(ptr);
+		return NULL;
+	}
+
+	*ptr = wq;
+	devres_add(dev, ptr);
+
+	return wq;
+}
+EXPORT_SYMBOL_GPL(devm_alloc_workqueue);
 /**
  * workqueue_set_max_active - adjust max_active of a workqueue
  * @wq: target workqueue
-- 
2.25.1

