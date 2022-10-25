Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9960C586
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiJYHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJYHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:39:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC4BA02D5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:39:52 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxP0K0RvyzJnBX;
        Tue, 25 Oct 2022 15:37:05 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 15:39:50 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 15:39:50 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
CC:     <zhengyejian1@huawei.com>
Subject: [PATCH] ftrace: Clean comments related to FTRACE_OPS_FL_PER_CPU
Date:   Tue, 25 Oct 2022 15:39:23 +0000
Message-ID: <20221025153923.1995973-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Commit b3a88803ac5b ("ftrace: Kill FTRACE_OPS_FL_PER_CPU") didn't
completely remove the comments related to FTRACE_OPS_FL_PER_CPU.

Fixes: b3a88803ac5b ("ftrace: Kill FTRACE_OPS_FL_PER_CPU")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/ftrace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fbf2543111c0..214de83458b9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -163,7 +163,7 @@ static void ftrace_sync_ipi(void *data)
 static ftrace_func_t ftrace_ops_get_list_func(struct ftrace_ops *ops)
 {
 	/*
-	 * If this is a dynamic, RCU, or per CPU ops, or we force list func,
+	 * If this is a dynamic or RCU ops, or we force list func,
 	 * then it needs to call the list anyway.
 	 */
 	if (ops->flags & (FTRACE_OPS_FL_DYNAMIC | FTRACE_OPS_FL_RCU) ||
@@ -3030,7 +3030,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 
 	if (!command || !ftrace_enabled) {
 		/*
-		 * If these are dynamic or per_cpu ops, they still
+		 * If these are dynamic ops, they still
 		 * need their data freed. Since, function tracing is
 		 * not currently active, we can just free them
 		 * without synchronizing all CPUs.
@@ -3079,8 +3079,6 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	/*
 	 * Dynamic ops may be freed, we must make sure that all
 	 * callers are done before leaving this function.
-	 * The same goes for freeing the per_cpu data of the per_cpu
-	 * ops.
 	 */
 	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
 		/*
@@ -7528,8 +7526,6 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		/*
 		 * Check the following for each ops before calling their func:
 		 *  if RCU flag is set, then rcu_is_watching() must be true
-		 *  if PER_CPU is set, then ftrace_function_local_disable()
-		 *                          must be false
 		 *  Otherwise test if the ip matches the ops filter
 		 *
 		 * If any of the above fails then the op->func() is not executed.
@@ -7579,8 +7575,8 @@ NOKPROBE_SYMBOL(arch_ftrace_ops_list_func);
 
 /*
  * If there's only one function registered but it does not support
- * recursion, needs RCU protection and/or requires per cpu handling, then
- * this function will be called by the mcount trampoline.
+ * recursion, needs RCU protection, then this function will be called
+ * by the mcount trampoline.
  */
 static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 				   struct ftrace_ops *op, struct ftrace_regs *fregs)
-- 
2.25.1

