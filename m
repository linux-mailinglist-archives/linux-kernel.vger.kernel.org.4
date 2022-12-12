Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158906497E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiLLCLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiLLCLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:11:36 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0DD2EF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:11:35 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NVlTV2gzQz15NKQ;
        Mon, 12 Dec 2022 10:10:38 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:11:32 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <akinobu.mita@gmail.com>, <akpm@linux-foundation.org>,
        <nathan@kernel.org>, <peterz@infradead.org>,
        <keescook@chromium.org>, <ndesaulniers@google.com>,
        <jpoimboe@kernel.org>, <dan.j.williams@intel.com>,
        <ojeda@kernel.org>, <isabbasso@riseup.net>, <vbabka@suse.cz>,
        <linux@rasmusvillemoes.dk>
CC:     <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        Wang Yufen <wangyufen@huawei.com>
Subject: [PATCH -next v2 3/4] fault-injection: make some stack filter attrs more readable
Date:   Mon, 12 Dec 2022 10:11:15 +0800
Message-ID: <1670811076-38625-4-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1670811076-38625-1-git-send-email-wangyufen@huawei.com>
References: <1670811076-38625-1-git-send-email-wangyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attributes of stack filter are show as unsigned decimal, such
as 'require-start', 'require-end'. This patch change to
show them as unsigned hexadecimal for more readable.

Before:
  $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
  $ cat /sys/kernel/debug/failslab/require-start
  18446744072638263296

After:
  $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
  $ cat /sys/kernel/debug/failslab/require-start
  0xffffffffc0257000

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
---
 lib/fault-inject.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index fecc4d8..d7819ca 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -226,10 +226,10 @@ struct dentry *fault_create_debugfs_attr(const char *name,
 #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
 	debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
 					&attr->stacktrace_depth);
-	debugfs_create_ul("require-start", mode, dir, &attr->require_start);
-	debugfs_create_ul("require-end", mode, dir, &attr->require_end);
-	debugfs_create_ul("reject-start", mode, dir, &attr->reject_start);
-	debugfs_create_ul("reject-end", mode, dir, &attr->reject_end);
+	debugfs_create_xul("require-start", mode, dir, &attr->require_start);
+	debugfs_create_xul("require-end", mode, dir, &attr->require_end);
+	debugfs_create_xul("reject-start", mode, dir, &attr->reject_start);
+	debugfs_create_xul("reject-end", mode, dir, &attr->reject_end);
 #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
 
 	attr->dname = dget(dir);
-- 
1.8.3.1

