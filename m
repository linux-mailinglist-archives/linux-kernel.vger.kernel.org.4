Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD46691944
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjBJHfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjBJHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:35:03 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A8574312
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:35:02 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PClqh6pVfzdb9x;
        Fri, 10 Feb 2023 15:34:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Feb 2023 15:34:59 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <chenwandun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>, <xialonglong1@huawei.com>
Subject: [PATCH -next 3/3] devtmpfs: remove return value of devtmpfs_delete_node()
Date:   Fri, 10 Feb 2023 07:33:09 +0000
Message-ID: <20230210073309.4050841-4-xialonglong1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210073309.4050841-1-xialonglong1@huawei.com>
References: <Y9t0pqN/1PaUlKoT@kroah.com>
 <20230210073309.4050841-1-xialonglong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of device_del() does not check the return value. And
there's nothing we can do when cleaning things up on a remove path.
Let's make it a void function.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 drivers/base/base.h     | 4 ++--
 drivers/base/devtmpfs.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0e806f641079..f7996bf8d28b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -201,10 +201,10 @@ void device_pm_move_to_tail(struct device *dev);
 
 #ifdef CONFIG_DEVTMPFS
 int devtmpfs_create_node(struct device *dev);
-int devtmpfs_delete_node(struct device *dev);
+void devtmpfs_delete_node(struct device *dev);
 #else
 static inline int devtmpfs_create_node(struct device *dev) { return 0; }
-static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
+static inline void devtmpfs_delete_node(struct device *dev) { return 0; }
 #endif
 
 void software_node_notify(struct device *dev);
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 7789b7be4ee5..e5c4d3e98ec9 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -147,22 +147,22 @@ int devtmpfs_create_node(struct device *dev)
 	return devtmpfs_submit_req(&req, tmp);
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

