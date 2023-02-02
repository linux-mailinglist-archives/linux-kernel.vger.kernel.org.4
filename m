Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256936873D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjBBDcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjBBDca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:32:30 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9697524C98
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:32:29 -0800 (PST)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P6knX6xkCz16NJr;
        Thu,  2 Feb 2023 11:30:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 11:32:27 +0800
From:   Longlong Xia <xialonglong1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenwandun@huawei.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, Longlong Xia <xialonglong1@huawei.com>
Subject: [PATCH -next 2/3] devtmpfs: add debug info to handle()
Date:   Thu, 2 Feb 2023 03:32:02 +0000
Message-ID: <20230202033203.1239239-3-xialonglong1@huawei.com>
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

The devtmpfs_*_node() are used to mount/unmount devices to /dev, but their
callers don't check their return value, so we don't know the reason for
the failure. Let's add some debug info in handle() to help users know
why failed.

Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
---
 drivers/base/devtmpfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index ae72d4ba8547..77ca64f708ce 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -389,10 +389,18 @@ static __initdata DECLARE_COMPLETION(setup_done);
 static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 		  struct device *dev)
 {
+	int ret;
+
 	if (mode)
-		return handle_create(name, mode, uid, gid, dev);
+		ret = handle_create(name, mode, uid, gid, dev);
 	else
-		return handle_remove(name, dev);
+		ret = handle_remove(name, dev);
+
+	if (ret)
+		pr_err_ratelimited("failed to %s %s, ret = %d\n",
+				   mode ? "create" : "remove", name, ret);
+
+	return ret;
 }
 
 static void __noreturn devtmpfs_work_loop(void)
-- 
2.25.1

