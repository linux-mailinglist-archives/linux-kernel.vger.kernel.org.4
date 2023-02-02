Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF86873D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjBBDcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjBBDcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:32:31 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCD24C9D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:32:30 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6knX5rsYznVxv;
        Thu,  2 Feb 2023 11:30:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 11:32:28 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH -next 3/3] devtmpfs: remove return value of devtmpfs_*_node() & devtmpfs_submit_req()
Date:   Thu, 2 Feb 2023 03:32:03 +0000
Message-ID: <20230202033203.1239239-4-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202033203.1239239-1-xialonglong1@huawei.com>
References: <20230202033203.1239239-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the return value of devtmpfs_*_node() and devtmpfs_submit_req()
are not used by their callers, change them into void functions.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 drivers/base/base.h     |  8 ++++----
 drivers/base/devtmpfs.c | 20 +++++++++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2208af509ce8..ffb7321e39cf 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -198,11 +198,11 @@ extern void fw_devlink_drivers_done(void);
 void device_pm_move_to_tail(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
-int devtmpfs_create_node(struct device *dev);
-int devtmpfs_delete_node(struct device *dev);
+void devtmpfs_create_node(struct device *dev);
+void devtmpfs_delete_node(struct device *dev);
 #else
-static inline int devtmpfs_create_node(struct device *dev) { return 0; }
-static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
+static inline void devtmpfs_create_node(struct device *dev) { }
+static inline void devtmpfs_delete_node(struct device *dev) { }
 #endif
 
 void software_node_notify(struct device *dev);
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 77ca64f708ce..3c4e61c99b77 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -103,7 +103,7 @@ static inline int is_blockdev(struct device *dev)
 static inline int is_blockdev(struct device *dev) { return 0; }
 #endif
 
-static int devtmpfs_submit_req(struct req *req, const char *tmp)
+static void devtmpfs_submit_req(struct req *req, const char *tmp)
 {
 	init_completion(&req->done);
 
@@ -116,24 +116,22 @@ static int devtmpfs_submit_req(struct req *req, const char *tmp)
 	wait_for_completion(&req->done);
 
 	kfree(tmp);
-
-	return req->err;
 }
 
-int devtmpfs_create_node(struct device *dev)
+void devtmpfs_create_node(struct device *dev)
 {
 	const char *tmp = NULL;
 	struct req req;
 
 	if (!thread)
-		return 0;
+		return;
 
 	req.mode = 0;
 	req.uid = GLOBAL_ROOT_UID;
 	req.gid = GLOBAL_ROOT_GID;
 	req.name = device_get_devnode(dev, &req.mode, &req.uid, &req.gid, &tmp);
 	if (!req.name)
-		return -ENOMEM;
+		return;
 
 	if (req.mode == 0)
 		req.mode = 0600;
@@ -144,25 +142,25 @@ int devtmpfs_create_node(struct device *dev)
 
 	req.dev = dev;
 
-	return devtmpfs_submit_req(&req, tmp);
+	devtmpfs_submit_req(&req, tmp);
 }
 
-int devtmpfs_delete_node(struct device *dev)
+void devtmpfs_delete_node(struct device *dev)
 {
 	const char *tmp = NULL;
 	struct req req;
 
 	if (!thread)
-		return 0;
+		return;
 
 	req.name = device_get_devnode(dev, NULL, NULL, NULL, &tmp);
 	if (!req.name)
-		return -ENOMEM;
+		return;
 
 	req.mode = 0;
 	req.dev = dev;
 
-	return devtmpfs_submit_req(&req, tmp);
+	devtmpfs_submit_req(&req, tmp);
 }
 
 static int dev_mkdir(const char *name, umode_t mode)
-- 
2.25.1

