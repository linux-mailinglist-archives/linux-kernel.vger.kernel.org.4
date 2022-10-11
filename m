Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3421D5FAB83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJKEE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJKEEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:04:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CFFDEC9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:04:49 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mmhqz1R69zHtrR;
        Tue, 11 Oct 2022 11:59:42 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 12:04:37 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 12:04:36 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <joe@perches.com>, <zhengyejian1@huawei.com>
Subject: [PATCH v2] ftrace: Fix char print issue in print_ip_ins()
Date:   Tue, 11 Oct 2022 12:03:52 +0000
Message-ID: <20221011120352.1878494-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ftrace bug happened, following log shows every hex data in
problematic ip address:
  actual:   ffffffe8:6b:ffffffd9:01:21

But so many 'f's seem a little confusing, and that is because format
'%x' being used to print signed chars in array 'ins'. As suggested
by Joe, change to use format "%*phC" to print array 'ins'.

After this patch, the log is like:
  actual:   e8:6b:d9:01:21

Fixes: 6c14133d2d3f ("ftrace: Do not blindly read the ip address in ftrace_bug()")
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

 Changes since v1:
   Use format "%*phC" to print array 'ins' as suggested by Joe.
   Link: https://lore.kernel.org/lkml/0a9453d94419991aa38d64b7a446eeba1f9c5a80.camel@perches.com/#t
   Usage of format "%*phC" can also be found in Documentation/core-api/printk-formats.rst "Raw buffer as a hex string"

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 447d2e2a8549..b838c717037a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2016,7 +2016,6 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 static void print_ip_ins(const char *fmt, const unsigned char *p)
 {
 	char ins[MCOUNT_INSN_SIZE];
-	int i;
 
 	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {
 		printk(KERN_CONT "%s[FAULT] %px\n", fmt, p);
@@ -2024,9 +2023,7 @@ static void print_ip_ins(const char *fmt, const unsigned char *p)
 	}
 
 	printk(KERN_CONT "%s", fmt);
-
-	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
-		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);
+	pr_cont("%*phC", MCOUNT_INSN_SIZE, ins);
 }
 
 enum ftrace_bug_type ftrace_bug_type;
-- 
2.25.1

