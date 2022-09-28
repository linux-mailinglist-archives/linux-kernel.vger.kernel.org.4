Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA195ED2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiI1By3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiI1By1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:54:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D931F01B6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:54:25 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McfYr74rlzHtcy
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:49:36 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 09:54:24 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <akinobu.mita@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <wangyufen@huawei.com>
Subject: [-next RESEND] fault-injection: using debugfs_create_xul() instead of debugfs_create_xl()
Date:   Wed, 28 Sep 2022 10:14:59 +0800
Message-ID: <1664331299-4976-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using debugfs_create_xul() instead of debugfs_create_xl(), and del the
local define debugfs_create_xl().

Suggested-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/fault-inject.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 9dd1dd1..dbb5409 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -185,14 +185,6 @@ static void debugfs_create_ul(const char *name, umode_t mode,
 
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_xl, debugfs_ul_get, debugfs_ul_set, "0x%llx\n");
-
-static void debugfs_create_xl(const char *name, umode_t mode,
-			      struct dentry *parent, unsigned long *value)
-{
-	debugfs_create_file(name, mode, parent, value, &fops_xl);
-}
-
 static int debugfs_stacktrace_depth_set(void *data, u64 val)
 {
 	*(unsigned long *)data =
@@ -237,10 +229,10 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 	debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
 					&attr->stacktrace_depth);
-	debugfs_create_xl("require-start", mode, dir, &attr->require_start);
-	debugfs_create_xl("require-end", mode, dir, &attr->require_end);
-	debugfs_create_xl("reject-start", mode, dir, &attr->reject_start);
-	debugfs_create_xl("reject-end", mode, dir, &attr->reject_end);
+	debugfs_create_xul("require-start", mode, dir, &attr->require_start);
+	debugfs_create_xul("require-end", mode, dir, &attr->require_end);
+	debugfs_create_xul("reject-start", mode, dir, &attr->reject_start);
+	debugfs_create_xul("reject-end", mode, dir, &attr->reject_end);
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
 	attr->dname = dget(dir);
-- 
1.8.3.1

