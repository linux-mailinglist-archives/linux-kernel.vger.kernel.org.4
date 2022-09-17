Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631255BB6F3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIQHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIQHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078C45F6A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220917072400epoutp015dea7465cec7cb880a0b95246269f124~VlPpdzDYj1986719867epoutp01u
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220917072400epoutp015dea7465cec7cb880a0b95246269f124~VlPpdzDYj1986719867epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399440;
        bh=MS0X37V41L2Pc/Buc3rhEH64RqFWy7WaL2u7nSoQVyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRNUbGdNz1FuZ+AnhNr+QS5ybA9KcpDKS3ztEzmhkYeJ/KO0mfrly2wkad32mH2ti
         Se5ek8c92h58CvFO0Hrqbe5xzt8aS05+o4jHAE24qE9dA++o9Jsd1jKfzyWgHu+diJ
         /BNtv4h+kEJZk0dIjmon+KtFevfQ1D0DlKNtnp2s=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220917072359epcas1p321fdba5115a4e3ae156ea439954cdb53~VlPod6cSn0623006230epcas1p3O;
        Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.134]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MV2Vk2lTmz4x9Pr; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.40.07146.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p2ec70909280eee82b0db5ad454247daf8~VlPnJZ01Q2419324193epcas1p21;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp28c6b5b2d1da246c47af521560fe1b6b8~VlPnIjl3W1654916549epsmtrp2x;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a35-47bfe70000021bea-7d-6325760e8cc2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.F0.18644.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip2f274a021c71b9ec66f1e3ad7fb01d64c~VlPmz3xFz2357323573epsmtip2e;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 06/13] trinity: add statistics module
Date:   Sat, 17 Sep 2022 16:23:49 +0900
Message-Id: <20220917072356.2255620-7-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTX5evTDXZoPkhn8XfScfYLaY+fMJm
        0bx4PZvF++7dzBZ7X29lt7i8aw6bxe3GFWwW+3o+Mlo8n3adxYHT4/evSYwem1Z1snncubaH
        zWP/3DXsHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQ
        l5ibaqvk4hOg65aZA3SVkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3
        uDQvXS8vtcTK0MDAyBSoMCE7o2fGUeaC9leMFXNnXWFuYFx+mLGLkZNDQsBEYs+6eWxdjFwc
        QgI7GCVWnbvHDOF8YpQ4+XofO4TzmVFiyv//cC3T5xxjB7GFBHYxSjy/LgBX1DC3ASzBJqAq
        MXPGGjBbRKBconnjCTCbWSBH4smdJmYQW1jAQuLjx2dANgcHC1D9+tNxIGFeAWuJ1Qfmgu3i
        FLCRuLmpiQUiLihxcuYTFogx8hLNW2eDXSoh8JNd4sKcI+wQx7lIXLz3kw3CFpZ4dXwLVFxK
        4vO7vVDxbIkpHYtYIOwCiXPPt4LdICFgLHFxRQqIySygKbF+lz5EhaLEzt8Q5zAL8Em8+9rD
        ClHNK9HRJgRRoiSx5M9hqEUSElNnfGOCsD0k1q1ugwZhP6PEvh39bBMY5Wch+WYWkm9mIWxe
        wMi8ilEstaA4Nz212LDAEB6ryfm5mxjBKVPLdAfjxLcf9A4xMnEwHmKU4GBWEuFV9VRJFuJN
        SaysSi3Kjy8qzUktPsRoCgzeicxSosn5wKSdVxJvaGJpYGJmZGxiYWhmqCTOq6fNmCwkkJ5Y
        kpqdmlqQWgTTx8TBKdXAJMGR5xGcfD273ELtIwNXk1akrU51WuFS62dsa677F6y7+m/FHjPf
        2d192z5sCMio3tI0w0n4nWRKYZTUPvuqqsqEV0YWEZx7dJ/KuB3Ka+mVf6TkWHSu3v646Z3X
        T18duR2cKH3sy7NfMi46XzUWMD/4eLypPtpONUM6ZVOE0+83L21OOrxoEJbSm7bvSqFG4xWZ
        rBKLw3z1y/9PFzWqTHO/f2z9gyY//kwT3cUtt+YueBWc6XNeW0o4i23a33fii9OKfebdnnJw
        a3NDxQ3ZnaeYvs78fyp4jmt9pXOGbu/xG5c51Vsfdc72nXr14SIFjXM7XpgfkDG7t/zYk4BY
        FwVerk7XP6+NMvdf97qpxFKckWioxVxUnAgAhALRHiIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywfW3uhZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAldGz4yjzAXtrxgr5s66wtzAuPwwYxcj
        J4eEgInE9DnH2LsYuTiEBHYwSjw59wMqISGx6d5y5i5GDiBbWOLw4WKImo+MEmceHmMCqWET
        UJWYOWMNO4gtIlArcfDofGYQm1mgQGL205ksILawgIXEx4/PwOawANWvPx0HEuYVsJZYfWAu
        2CpOARuJm5uawMqFgOKzp89lgqgRlDg58wkLxEh5ieats5knMPLPQpKahSS1gJFpFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcHBrae1g3LPqg94hRiYOxkOMEhzMSiK8qp4qyUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwqWW8qczimHzt
        hxan/GbflUpfcwudXPXP3jgb2St+5fPEj49sLxuaRXgHTg/aOIU116DqdetOIcF/iYU3hBrf
        R22ctFxvpz3nuRkFf2tNmKUStE/Zb5o4fecp1+8LM49Kf+v4+/ZvfDLbg0cZ+44dinSN+NoU
        oXs9/t+Hs8J7m/boT4+si743bQ2TS7vY3aAfmUdkbt27WSXw6sfWWceerpPcod55q6V23gOR
        urV7AjzFjus/bUtN3MkocnCa7pytp3nviuvvtQs89Tb81Z1Z/1QLJ7llvTlyq519b/bX+F6P
        xxlX+fm5yyRVdA/NXzb5ivimp38vpgQ+cnvVPEV590WrV+0np7b+jMkQ7TjQ7qzEUpyRaKjF
        XFScCAAj+wI03QIAAA==
X-CMS-MailID: 20220917072357epcas1p2ec70909280eee82b0db5ad454247daf8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p2ec70909280eee82b0db5ad454247daf8
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p2ec70909280eee82b0db5ad454247daf8@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes statistics information module.

The information includes per-application statistics and per-request
statistics. The app statistics records total number of requests,
active requests, allocated memory and freed memory.
For request statistics, it counts number of runs and total consumed
time, and it also keeps profile data for the requests.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
---
 drivers/misc/trinity/Makefile       |   1 +
 drivers/misc/trinity/trinity.c      |   3 +
 drivers/misc/trinity/trinity_stat.c | 898 ++++++++++++++++++++++++++++
 drivers/misc/trinity/trinity_stat.h |  56 ++
 4 files changed, 958 insertions(+)
 create mode 100644 drivers/misc/trinity/trinity_stat.c
 create mode 100644 drivers/misc/trinity/trinity_stat.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index 5d3e89dd0dd7..b475938a0db6 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -6,5 +6,6 @@ trinity-y := trinity.o
 trinity-y += trinity_dma.o trinity_hwmem.o
 trinity-y += trinity_sched.o
 trinity-y += trinity_debug.o
+trinity-y += trinity_stat.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 0c75eb13967c..a785a5dca4d9 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -15,6 +15,7 @@
 
 #include "trinity_common.h"
 #include "trinity_sched.h"
+#include "trinity_stat.h"
 
 #define TRINITY_PADDR_BASE (0x0)
 
@@ -100,6 +101,8 @@ int trinity_open(struct inode *inode, struct file *f)
 	drv = container_of(miscdev, struct trinity_driver, mdev);
 	f->private_data = drv;
 
+	trinity_stat_app_set_status(drv, TRINITY_APP_STATUS_STARTED);
+
 	return 0;
 }
 
diff --git a/drivers/misc/trinity/trinity_stat.c b/drivers/misc/trinity/trinity_stat.c
new file mode 100644
index 000000000000..0cbba08ee0b0
--- /dev/null
+++ b/drivers/misc/trinity/trinity_stat.c
@@ -0,0 +1,898 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Providing statistics for Samsung Trinity device family support
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include "trinity_stat.h"
+#include "trinity_common.h"
+
+#include <linux/bitmap.h>
+#include <linux/list_bl.h>
+
+/* maximum number of stats configurable from sysfs */
+#define TRINITY_STAT_MAX_APPS (128UL)
+#define TRINITY_STAT_MAX_REQS (4096UL)
+#define TRINITY_STAT_MAX_REQS_PER_APP (128UL)
+
+/* default number of stats */
+#define TRINITY_STAT_DEF_APPS (32UL)
+#define TRINITY_STAT_DEF_REQS (128UL)
+#define TRINITY_STAT_DEF_REQS_PER_APP (32UL)
+
+/**
+ * struct trinity_stat_pool - Statistics pool which maintain statistics for device
+ *
+ * @bitmap_app: bitmap for app
+ * @bitmap_req: bitmap for request
+ * @mem_app: reserved memory for applications
+ * @mem_req: reserved memory for request
+ * @max_stat_apps: max statistics size of applications
+ * @max_stat_reqs: max statistics size of requests.
+ * @max_stat_reqs_per_app: max statistics size of request per application
+ * @cur_stat_apps: current statistics for applications
+ * @cur_stat_reqs: current statistics for requests
+ * @drv: an instance of the trinity driver
+ */
+struct trinity_stat_pool {
+	DECLARE_BITMAP(bitmap_app, TRINITY_STAT_MAX_APPS);
+	DECLARE_BITMAP(bitmap_req, TRINITY_STAT_MAX_REQS);
+
+	struct trinity_dma mem_app;
+	struct trinity_dma mem_req;
+
+	unsigned long max_stat_apps;
+	unsigned long max_stat_reqs;
+	unsigned long max_stat_reqs_per_app;
+
+	unsigned long cur_stat_apps;
+	unsigned long cur_stat_reqs;
+
+	struct trinity_driver *drv;
+};
+
+/**
+ * trinity_stat_pool_init(): Initialize trinity statistics pool
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_stat_pool_init(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return -ENOMEM;
+
+	pool->drv = drv;
+
+	drv->stat.pdata = pool;
+
+	return 0;
+}
+
+/**
+ * trinity_stat_pool_init(): finish trinity statistics pool
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_stat_pool_fini(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+
+	if (!pool)
+		return;
+
+	trinity_dma_free(dev, &pool->mem_app);
+	trinity_dma_free(dev, &pool->mem_req);
+	kfree(pool);
+
+	drv->stat.pdata = NULL;
+}
+
+static void trinity_stat_pool_resize_apps(struct trinity_stat_pool *pool,
+					  unsigned long num_apps)
+{
+	struct device *dev = drv_to_dev_ptr(pool->drv);
+	struct trinity_dma mem;
+	unsigned long size;
+	int err;
+
+	if (num_apps > TRINITY_STAT_MAX_APPS) {
+		dev_err(dev, "The maximum number of stat apps: %lu",
+			TRINITY_STAT_MAX_APPS);
+		return;
+	}
+
+	size = sizeof(struct trinity_stat_app) * num_apps;
+	err = trinity_dma_alloc(dev, size, &mem);
+	if (err < 0) {
+		dev_warn(dev, "Unable to allocate stats for apps");
+		return;
+	}
+
+	trinity_dma_free(dev, &pool->mem_app);
+
+	bitmap_fill(pool->bitmap_app, TRINITY_STAT_MAX_APPS);
+	bitmap_zero(pool->bitmap_app, num_apps);
+
+	pool->max_stat_apps = num_apps;
+	pool->mem_app = mem;
+}
+
+static void trinity_stat_pool_resize_reqs(struct trinity_stat_pool *pool,
+					  unsigned long num_reqs)
+{
+	struct device *dev = drv_to_dev_ptr(pool->drv);
+	struct trinity_dma mem;
+	unsigned long size;
+	int err;
+
+	if (num_reqs > TRINITY_STAT_MAX_REQS) {
+		dev_err(dev, "The maximum number of stat reqs: %lu",
+			TRINITY_STAT_MAX_REQS);
+		return;
+	}
+
+	size = sizeof(struct trinity_stat_req) * num_reqs;
+	err = trinity_dma_alloc(dev, size, &mem);
+	if (err < 0) {
+		dev_warn(dev, "Unable to allocate stats for apps");
+		return;
+	}
+	trinity_dma_free(dev, &pool->mem_req);
+
+	bitmap_fill(pool->bitmap_req, TRINITY_STAT_MAX_REQS);
+	bitmap_zero(pool->bitmap_req, num_reqs);
+
+	pool->max_stat_reqs = num_reqs;
+	pool->mem_req = mem;
+}
+
+static struct trinity_stat_app *
+trinity_stat_pool_get_app(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *app = NULL;
+	unsigned long slot;
+	bool retried = false;
+
+	/* ensured that the lock is acquired */
+retry:
+	slot = find_first_zero_bit(pool->bitmap_app, TRINITY_STAT_MAX_APPS);
+	if (slot < TRINITY_STAT_MAX_APPS) {
+		app = &((struct trinity_stat_app *)pool->mem_app.addr)[slot];
+		memset(app, '\x00', sizeof(*app));
+		set_bit(slot, pool->bitmap_app);
+		app->slot = slot;
+	} else if (!retried) {
+		/* retry after destroy old stats */
+		retried = true;
+		trinity_destroy_stats(stat, true);
+		goto retry;
+	} else {
+		dev_warn(drv_to_dev_ptr(pool->drv),
+			 "Please increase stat pool limit for apps");
+	}
+
+	return app;
+}
+
+static void trinity_stat_pool_put_app(struct trinity_driver *drv,
+				      struct trinity_stat_app *app)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+
+	/* ensured that the lock is acquired */
+	clear_bit(app->slot, pool->bitmap_app);
+}
+
+static struct trinity_stat_req *
+trinity_stat_pool_get_req(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_req *req = NULL;
+	unsigned long slot;
+	bool retried = false;
+
+	/* ensured that the lock is acquired */
+retry:
+	slot = find_first_zero_bit(pool->bitmap_req, TRINITY_STAT_MAX_REQS);
+	if (slot < TRINITY_STAT_MAX_REQS) {
+		req = &((struct trinity_stat_req *)pool->mem_req.addr)[slot];
+		memset(req, '\x00', sizeof(*req));
+		set_bit(slot, pool->bitmap_req);
+		req->slot = slot;
+	} else if (!retried) {
+		/* retry after destroy old stats */
+		retried = true;
+		trinity_destroy_stats(stat, true);
+		goto retry;
+	} else {
+		dev_warn(drv_to_dev_ptr(pool->drv),
+			 "Please increase stat pool limit for reqs");
+	}
+
+	return req;
+}
+
+static void trinity_stat_pool_put_req(struct trinity_driver *drv,
+				      struct trinity_stat_req *req)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+
+	/* ensured that the lock is acquired */
+	clear_bit(req->slot, pool->bitmap_req);
+}
+
+/**
+ * trinity_stat_init(): Initialize trinity statistics
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_stat_init(struct trinity_driver *drv)
+{
+	unsigned long i;
+
+	spin_lock_init(&drv->stat.lock);
+
+	INIT_LIST_HEAD(&drv->stat.list);
+	for (i = 0; i < TRINITY_STAT_HASH_SIZE; ++i)
+		INIT_HLIST_BL_HEAD(&drv->stat.hlist[i]);
+
+	trinity_stat_pool_init(drv);
+	/* initialize to default values */
+	trinity_stat_resize(drv, TRINITY_STAT_DEF_APPS, TRINITY_STAT_DEF_REQS,
+			    TRINITY_STAT_DEF_REQS_PER_APP);
+}
+
+/**
+ * trinity_stat_fini(): Finish trinity statistics
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_stat_fini(struct trinity_driver *drv)
+{
+	trinity_stat_resize(drv, 0, 0, 0);
+	trinity_stat_pool_fini(drv);
+}
+
+/**
+ * trinity_stat_fini(): Finish trinity statistics
+ *
+ * @drv: an instance of the trinity driver
+ * @num_apps: a number of applications
+ * @num_reqs: a number of requests
+ * @num_reqs_per_app: a number of requests per application
+ */
+void trinity_stat_resize(struct trinity_driver *drv, unsigned long num_apps,
+			 unsigned long num_reqs, unsigned long num_reqs_per_app)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	unsigned long i;
+
+	if (!pool)
+		return;
+
+	trinity_stat_lock(&drv->stat);
+
+	for (i = 0; i < TRINITY_STAT_HASH_SIZE; i++) {
+		struct trinity_stat_app *stat_app;
+		struct hlist_bl_node *hn;
+
+		hlist_bl_lock(&(stat->hlist[i]));
+		hlist_bl_for_each_entry(stat_app, hn, &(stat->hlist[i]),
+					 hnode) {
+			if (stat_app->status != TRINITY_APP_STATUS_TERMINATED) {
+				dev_warn(drv_to_dev_ptr(drv),
+					 "Still busy apps detected.. waiting");
+				hlist_bl_unlock(&(stat->hlist[i]));
+				goto unlock;
+			}
+		}
+		hlist_bl_unlock(&(stat->hlist[i]));
+	}
+
+	trinity_destroy_stats(stat, true);
+
+	/* re-allocate each stat buffer */
+	if (num_apps > 0)
+		trinity_stat_pool_resize_apps(pool, num_apps);
+
+	if (num_reqs > 0)
+		trinity_stat_pool_resize_reqs(pool, num_reqs);
+
+	if (num_reqs_per_app > 0)
+		pool->max_stat_reqs_per_app = num_reqs_per_app;
+
+unlock:
+	trinity_stat_unlock(&drv->stat);
+}
+
+/**
+ * trinity_stat_get_max_apps(): Get max statistics size for application
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns max number of statistics for applications. 0 on error.
+ */
+unsigned long trinity_stat_get_max_apps(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+	unsigned long num;
+
+	if (!pool)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+	num = pool->max_stat_apps;
+	trinity_stat_unlock(&drv->stat);
+
+	return num;
+}
+
+/**
+ * trinity_stat_get_max_reqs(): Get max statistics size for requests
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns max number of statistics for requests. 0 on error.
+ */
+unsigned long trinity_stat_get_max_reqs(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+	unsigned long num;
+
+	if (!pool)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+	num = pool->max_stat_reqs;
+	trinity_stat_unlock(&drv->stat);
+
+	return num;
+}
+
+/**
+ * trinity_stat_get_max_reqs(): Get max statistics size for requests per application
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Returns max number of statistics for requests per application. 0 on error.
+ */
+unsigned long trinity_stat_get_max_reqs_per_app(struct trinity_driver *drv)
+{
+	struct trinity_stat_pool *pool = drv->stat.pdata;
+	unsigned long num;
+
+	if (!pool)
+		return 0;
+
+	trinity_stat_lock(&drv->stat);
+	num = pool->max_stat_reqs_per_app;
+	trinity_stat_unlock(&drv->stat);
+
+	return num;
+}
+
+/**
+ * trinity_stat_lock(): Lock for trinity statistics
+ *
+ * @stat: an instance of trinity statistics
+ */
+void trinity_stat_lock(struct trinity_stat *stat)
+{
+	if (stat)
+		spin_lock(&stat->lock);
+}
+
+/**
+ * trinity_stat_unlock(): Unlock for trinity statistics
+ *
+ * @stat: an instance of trinity statistics
+ */
+void trinity_stat_unlock(struct trinity_stat *stat)
+{
+	if (stat)
+		spin_unlock(&stat->lock);
+}
+
+/**
+ * trinity_create_stat_app() - Create a stat structure for the opened app
+ *
+ * @drv: An instance of the trinity driver.
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+static int trinity_create_stat_app(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *stat_app;
+	unsigned long key;
+
+	trinity_stat_lock(stat);
+	stat_app = trinity_stat_pool_get_app(drv);
+	if (IS_ERR_OR_NULL(stat_app)) {
+		trinity_stat_unlock(stat);
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to allocate stat of request");
+		return -ENOMEM;
+	}
+
+	stat_app->parent = stat;
+	stat_app->app_id = trinity_get_app_id();
+	stat_app->total_alloc_mem = 0;
+	stat_app->total_freed_mem = 0;
+	stat_app->num_total_reqs = 0;
+	stat_app->num_kept_reqs = 0;
+	stat_app->num_active_reqs = 0;
+	stat_app->status = TRINITY_APP_STATUS_STARTED;
+
+	strncpy(stat_app->name, current->comm, TASK_COMM_LEN);
+	stat_app->name[TASK_COMM_LEN - 1] = '\x00';
+
+	INIT_HLIST_BL_NODE(&stat_app->hnode);
+	INIT_LIST_HEAD(&stat_app->reqs);
+
+	key = hash_long(stat_app->app_id, TRINITY_STAT_HASH_BITS);
+
+	hlist_bl_lock(&(stat->hlist[key]));
+	hlist_bl_add_head(&stat_app->hnode, &(stat->hlist[key]));
+	hlist_bl_unlock(&(stat->hlist[key]));
+
+	list_add_tail(&stat_app->lnode, &stat->list);
+	pool->cur_stat_apps++;
+
+	/* Remove terminated stats if the number reaches the maximum */
+	trinity_destroy_stats(stat, false);
+
+	trinity_stat_unlock(stat);
+
+	return 0;
+}
+
+static void trinity_destroy_stat_req(struct trinity_stat_req *stat_req)
+{
+	struct trinity_stat_app *stat_app = stat_req->parent;
+	struct trinity_stat *stat = stat_app->parent;
+	struct trinity_driver *drv =
+		container_of(stat, struct trinity_driver, stat);
+
+	if (stat_req->profile)
+		drv->desc->destroy_profile(drv, stat_req->profile);
+	list_del(&stat_req->list);
+	trinity_stat_pool_put_req(drv, stat_req);
+}
+
+static void trinity_destroy_stat_reqs(struct trinity_stat_app *stat_app)
+{
+	struct trinity_stat_req *stat_req, *tmp;
+
+	list_for_each_entry_safe(stat_req, tmp, &stat_app->reqs, list)
+		trinity_destroy_stat_req(stat_req);
+}
+
+/**
+ * trinity_destroy_stats - Destroy terminated stat structures
+ *
+ * @drv: An instance of the trinity driver
+ * @force: force destroy
+ */
+void trinity_destroy_stats(struct trinity_stat *stat, bool force)
+{
+	struct trinity_driver *drv =
+		container_of(stat, struct trinity_driver, stat);
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *stat_app;
+	struct hlist_bl_node *hn, *tmp;
+	int i;
+
+	/* lock should be acquired before */
+	if (!force && pool->cur_stat_apps <= pool->max_stat_apps)
+		return;
+
+	for (i = 0; i < TRINITY_STAT_HASH_SIZE; i++) {
+		hlist_bl_lock(&stat->hlist[i]);
+		hlist_bl_for_each_entry_safe(stat_app, hn, tmp,
+					      &(stat->hlist[i]), hnode) {
+			enum trinity_app_status status = stat_app->status;
+
+			if (status == TRINITY_APP_STATUS_TERMINATED) {
+				hlist_bl_del(&stat_app->hnode);
+				list_del(&stat_app->lnode);
+
+				pool->cur_stat_apps--;
+
+				trinity_destroy_stat_reqs(stat_app);
+				trinity_stat_pool_put_app(drv, stat_app);
+			}
+		}
+		hlist_bl_unlock(&stat->hlist[i]);
+	}
+}
+
+static struct trinity_stat_app *
+trinity_get_stat_by_id(struct trinity_driver *drv, int32_t app_id)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	struct hlist_bl_node *hn;
+	unsigned long key;
+
+	key = hash_long(app_id, TRINITY_STAT_HASH_BITS);
+
+	hlist_bl_lock(&stat->hlist[key]);
+	hlist_bl_for_each_entry(stat_app, hn, &stat->hlist[key], hnode) {
+		if (stat_app->app_id == app_id)
+			goto out;
+	}
+	stat_app = NULL;
+out:
+	hlist_bl_unlock(&stat->hlist[key]);
+
+	return stat_app;
+}
+
+/**
+ * trinity_get_stat_app() - Get a status structure for the target app
+ *
+ * @drv: an instance of the trinity driver.
+ *
+ * Returns statistics for application on success. Otherwise, returns NULL.
+ *
+ * @note: If the stat is not allocated yet, try to create and return it.
+ */
+struct trinity_stat_app *trinity_get_stat_app(struct trinity_driver *drv)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	int app_id = trinity_get_app_id();
+
+retry:
+	trinity_stat_lock(stat);
+	stat_app = trinity_get_stat_by_id(drv, app_id);
+	trinity_stat_unlock(stat);
+
+	if (!IS_ERR_OR_NULL(stat_app))
+		return stat_app;
+
+	if (trinity_create_stat_app(drv) != 0)
+		return NULL;
+
+	goto retry;
+}
+
+/**
+ * trinity_stat_app_set_status() - Set a status structure for the target app
+ *
+ * @drv: an instance of the trinity driver.
+ * @status: application status
+ */
+void trinity_stat_app_set_status(struct trinity_driver *drv,
+				 enum trinity_app_status status)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	int app_id = trinity_get_app_id();
+
+	trinity_stat_lock(stat);
+	stat_app = trinity_get_stat_by_id(drv, app_id);
+	trinity_stat_unlock(stat);
+
+	if (IS_ERR_OR_NULL(stat_app))
+		return;
+
+	stat_app->status = status;
+}
+
+/**
+ * trinity_stat_append_req() - Append request information for statistics
+ *
+ * @drv: an instance of the trinity driver.
+ * @req: an instance of request
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_stat_append_req(struct trinity_driver *drv, struct trinity_req *req)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_pool *pool = stat->pdata;
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+
+	stat_app = trinity_get_stat_app(drv);
+	if (IS_ERR_OR_NULL(stat_app))
+		return -ENOMEM;
+
+	trinity_stat_lock(stat);
+	stat_req = trinity_stat_pool_get_req(drv);
+	if (!stat_req) {
+		trinity_stat_unlock(stat);
+		dev_err(drv_to_dev_ptr(drv),
+			"Unable to allocate stat of request");
+		return -ENOMEM;
+	}
+
+	stat_req->parent = stat_app;
+	stat_req->app_id = stat_app->app_id;
+	stat_req->req_id = req->input.config.req_id;
+	stat_req->model_id = req->input.config.model_id;
+	stat_req->submitted = ktime_get();
+	stat_req->status = TRINITY_REQ_STATUS_PENDING;
+	stat_req->priority =
+		(enum trinity_req_priority)req->input.config.priority;
+	stat_req->is_kernel = req->is_kernel;
+
+	req->stat = stat_req;
+
+	list_add_tail(&stat_req->list, &stat_app->reqs);
+
+	/* don't count kernel requests */
+	if (!req->is_kernel) {
+		if (stat_app->num_kept_reqs == pool->max_stat_reqs_per_app) {
+			struct trinity_stat_req *old_stat;
+
+			old_stat = list_first_entry(
+				&stat_app->reqs, struct trinity_stat_req, list);
+			/* skip any kernel or unfinished request */
+			while (old_stat->is_kernel ||
+			       (old_stat->status !=
+					TRINITY_REQ_STATUS_FINISHED &&
+				old_stat->status != TRINITY_REQ_STATUS_ERROR))
+				old_stat = list_next_entry(old_stat, list);
+
+			WARN_ON(old_stat == NULL);
+
+			trinity_destroy_stat_req(old_stat);
+			stat_app->num_total_reqs--;
+		} else {
+			/* total number of user requests kepted */
+			stat_app->num_kept_reqs++;
+		}
+	}
+
+	stat_app->num_total_reqs++;
+	stat_app->num_active_reqs++;
+
+	trinity_stat_unlock(stat);
+	return 0;
+}
+
+/**
+ * trinity_stat_remove_req() - Remove request information for statistics
+ *
+ * @drv: an instance of the trinity driver.
+ * @req: an instance of the request to be used for statistics
+ * @rollback: rollback statistics
+ */
+void trinity_stat_remove_req(struct trinity_driver *drv,
+			     struct trinity_req *req, bool rollback)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_req *stat_req = req->stat;
+	struct trinity_stat_app *stat_app = stat_req->parent;
+
+	trinity_stat_lock(stat);
+
+	trinity_destroy_stat_req(stat_req);
+
+	if (!req->is_kernel) {
+		WARN_ON(stat_app->num_kept_reqs == 0);
+		stat_app->num_kept_reqs--;
+	}
+
+	if (rollback) {
+		WARN_ON(stat_app->num_total_reqs == 0);
+		stat_app->num_total_reqs--;
+		WARN_ON(stat_app->num_active_reqs == 0);
+		stat_app->num_active_reqs--;
+	}
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_finish_req() - Finish request for statistics
+ *
+ * @drv: an instance of the trinity driver.
+ * @req: an instance of the request to be used for statistics
+ */
+void trinity_stat_finish_req(struct trinity_driver *drv,
+			     struct trinity_req *req)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_req *stat_req = req->stat;
+	struct trinity_stat_app *stat_app = stat_req->parent;
+
+	trinity_stat_lock(stat);
+	if (stat_app->num_active_reqs != 0)
+		stat_app->num_active_reqs--;
+	else
+		dev_err(drv_to_dev_ptr(drv),
+			"Fail to keep track of the active reqs");
+	trinity_stat_unlock(stat);
+}
+
+static void copy_stat_app_ioctl(struct trinity_stat_app *stat_app,
+				struct trinity_ioctl_stat_app *ioctl_stat_app)
+{
+	ioctl_stat_app->app_id = stat_app->app_id;
+	ioctl_stat_app->status = stat_app->status;
+	ioctl_stat_app->num_total_reqs = stat_app->num_total_reqs;
+	ioctl_stat_app->num_active_reqs = stat_app->num_active_reqs;
+	ioctl_stat_app->total_alloc_mem = stat_app->total_alloc_mem;
+	ioctl_stat_app->total_freed_mem = stat_app->total_freed_mem;
+
+	strncpy(ioctl_stat_app->name, stat_app->name, TASK_COMM_LEN);
+	ioctl_stat_app->name[TASK_COMM_LEN - 1] = '\x00';
+}
+
+static void copy_stat_req_ioctl(struct trinity_stat_req *stat_req,
+				struct trinity_ioctl_stat_req *ioctl_stat_req)
+{
+	ktime_t cur_time = ktime_get();
+	ktime_t submitted, scheduled, completed;
+
+	submitted = stat_req->submitted;
+	scheduled = stat_req->scheduled ? stat_req->scheduled : cur_time;
+	completed = stat_req->completed ? stat_req->completed : cur_time;
+
+	ioctl_stat_req->req_id = stat_req->req_id;
+	ioctl_stat_req->model_id = stat_req->model_id;
+	ioctl_stat_req->priority = stat_req->priority;
+	ioctl_stat_req->status = stat_req->status;
+
+	if (stat_req->priority == TRINITY_REQ_PRIORITY_HIGH)
+		ioctl_stat_req->sched_time = 0;
+	else
+		ioctl_stat_req->sched_time = TIME_DIFF(scheduled, submitted);
+	ioctl_stat_req->infer_time = TIME_DIFF(completed, scheduled);
+}
+
+/**
+ * trinity_stat_app_copy_ioctl() - Copy an application's statistics information to ioctl info
+ *
+ * @drv: an instance of the trinity driver.
+ * @ioctl_stat_app: ioctl statistics information for an application
+ */
+void trinity_stat_app_copy_ioctl(struct trinity_driver *drv,
+				 struct trinity_ioctl_stat_app *ioctl_stat_app)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+	int app_id = trinity_get_app_id();
+
+	trinity_stat_lock(stat);
+
+	stat_app = trinity_get_stat_by_id(drv, app_id);
+	if (IS_ERR_OR_NULL(stat_app)) {
+		ioctl_stat_app->app_id = app_id;
+		ioctl_stat_app->status = TRINITY_APP_STATUS_PENDING;
+		ioctl_stat_app->num_total_reqs = 0;
+		ioctl_stat_app->num_active_reqs = 0;
+		ioctl_stat_app->total_alloc_mem = 0;
+		ioctl_stat_app->total_freed_mem = 0;
+
+		strncpy(ioctl_stat_app->name, current->comm, TASK_COMM_LEN);
+		ioctl_stat_app->name[TASK_COMM_LEN - 1] = '\x00';
+	} else {
+		copy_stat_app_ioctl(stat_app, ioctl_stat_app);
+	}
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_apps_copy_ioctl() - Copy applications' statistics information to ioctl info
+ *
+ * @drv: an instance of the trinity driver.
+ * @ioctl_stat_apps: ioctl statistics information for applications
+ */
+void trinity_stat_apps_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_apps *ioctl_stat_apps)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_ioctl_stat_app *ioctl_stat_app;
+	struct trinity_stat_app *stat_app;
+	uint32_t idx = 0;
+
+	trinity_stat_lock(stat);
+
+	list_for_each_entry(stat_app, &stat->list, lnode) {
+		if (idx >= TRINITY_APP_STAT_MAX)
+			break;
+		ioctl_stat_app = &ioctl_stat_apps->stat[idx++];
+		copy_stat_app_ioctl(stat_app, ioctl_stat_app);
+	}
+	ioctl_stat_apps->num_apps = idx;
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_app_copy_ioctl() - Copy requests' statistics information to ioctl info
+ *
+ * @drv: an instance of the trinity driver.
+ * @ioctl_stat_reqs: ioctl statistics information for requests
+ */
+void trinity_stat_reqs_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_reqs *ioctl_stat_reqs)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_ioctl_stat_req *ioctl_stat_req;
+	struct trinity_stat_app *stat_app;
+	struct trinity_stat_req *stat_req;
+	uint32_t idx = 0;
+
+	trinity_stat_lock(stat);
+	stat_app = trinity_get_stat_by_id(drv, ioctl_stat_reqs->app_id);
+	if (IS_ERR_OR_NULL(stat_app)) {
+		ioctl_stat_reqs->num_reqs = 0;
+		trinity_stat_unlock(stat);
+		return;
+	}
+
+	list_for_each_entry(stat_req, &stat_app->reqs, list) {
+		if (idx >= TRINITY_REQ_STAT_MAX)
+			break;
+		ioctl_stat_req = &ioctl_stat_reqs->stat[idx++];
+		copy_stat_req_ioctl(stat_req, ioctl_stat_req);
+	}
+	ioctl_stat_reqs->num_reqs = idx;
+
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_app_total_alloc() - Append allocated size to application's total memory size
+ *
+ * @drv: an instance of the trinity driver.
+ * @size: allocated memory size
+ */
+void trinity_stat_app_total_alloc(struct trinity_driver *drv, size_t size)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+
+	stat_app = trinity_get_stat_app(drv);
+	if (IS_ERR_OR_NULL(stat_app))
+		return;
+
+	trinity_stat_lock(stat);
+	stat_app->total_alloc_mem += size;
+	trinity_stat_unlock(stat);
+}
+
+/**
+ * trinity_stat_app_total_alloc() - Append freed size to application's total memory size
+ *
+ * @drv: an instance of the trinity driver.
+ * @size: freed memory size
+ */
+void trinity_stat_app_total_freed(struct trinity_driver *drv, size_t size)
+{
+	struct trinity_stat *stat = &drv->stat;
+	struct trinity_stat_app *stat_app;
+
+	stat_app = trinity_get_stat_app(drv);
+	if (IS_ERR_OR_NULL(stat_app))
+		return;
+
+	trinity_stat_lock(stat);
+	stat_app->total_freed_mem += size;
+	trinity_stat_unlock(stat);
+}
diff --git a/drivers/misc/trinity/trinity_stat.h b/drivers/misc/trinity/trinity_stat.h
new file mode 100644
index 000000000000..8ae02769efa0
--- /dev/null
+++ b/drivers/misc/trinity/trinity_stat.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Statistics header for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_STAT_H__
+#define __DRIVERS_MISC_TRINITY_STAT_H__
+
+#include "trinity_common.h"
+
+void trinity_stat_init(struct trinity_driver *drv);
+void trinity_stat_fini(struct trinity_driver *drv);
+void trinity_stat_resize(struct trinity_driver *drv, unsigned long num_apps,
+			 unsigned long num_reqs,
+			 unsigned long num_reqs_per_app);
+
+void trinity_stat_lock(struct trinity_stat *stat);
+void trinity_stat_unlock(struct trinity_stat *stat);
+void trinity_destroy_stats(struct trinity_stat *stat, bool force);
+
+unsigned long trinity_stat_get_max_apps(struct trinity_driver *drv);
+unsigned long trinity_stat_get_max_reqs(struct trinity_driver *drv);
+unsigned long trinity_stat_get_max_reqs_per_app(struct trinity_driver *drv);
+
+struct trinity_stat_app *trinity_get_stat_app(struct trinity_driver *drv);
+
+void trinity_stat_app_total_alloc(struct trinity_driver *drv, size_t size);
+void trinity_stat_app_total_freed(struct trinity_driver *drv, size_t size);
+void trinity_stat_app_set_status(struct trinity_driver *drv,
+				 enum trinity_app_status status);
+
+int trinity_stat_append_req(struct trinity_driver *drv,
+			    struct trinity_req *req);
+void trinity_stat_remove_req(struct trinity_driver *drv,
+			     struct trinity_req *req, bool rollback);
+void trinity_stat_finish_req(struct trinity_driver *drv,
+			     struct trinity_req *req);
+
+void trinity_stat_app_copy_ioctl(struct trinity_driver *drv,
+				 struct trinity_ioctl_stat_app *ioctl_stat_app);
+
+void trinity_stat_apps_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_apps *ioctl_stat_apps);
+
+void trinity_stat_reqs_copy_ioctl(
+	struct trinity_driver *drv,
+	struct trinity_ioctl_stat_reqs *ioctl_stat_reqs);
+
+#endif /* __DRIVERS_MISC_TRINITY_STAT_H__ */
-- 
2.25.1

