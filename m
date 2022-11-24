Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906E637BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKXOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKXOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535512E206
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02863B8283B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84BEC433D7;
        Thu, 24 Nov 2022 14:50:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYr-001X2a-2L;
        Thu, 24 Nov 2022 09:50:45 -0500
Message-ID: <20221124145045.604009892@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [for-next][PATCH 01/11] ftrace: Clean comments related to FTRACE_OPS_FL_PER_CPU
References: <20221124145019.782980678@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

Commit b3a88803ac5b ("ftrace: Kill FTRACE_OPS_FL_PER_CPU") didn't
completely remove the comments related to FTRACE_OPS_FL_PER_CPU.

Link: https://lkml.kernel.org/r/20221025153923.1995973-1-zhengyejian1@huawei.com

Fixes: b3a88803ac5b ("ftrace: Kill FTRACE_OPS_FL_PER_CPU")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 33236241f236..65a5d36463e0 100644
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
@@ -3071,8 +3071,6 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	/*
 	 * Dynamic ops may be freed, we must make sure that all
 	 * callers are done before leaving this function.
-	 * The same goes for freeing the per_cpu data of the per_cpu
-	 * ops.
 	 */
 	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
 		/*
@@ -7519,8 +7517,6 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		/*
 		 * Check the following for each ops before calling their func:
 		 *  if RCU flag is set, then rcu_is_watching() must be true
-		 *  if PER_CPU is set, then ftrace_function_local_disable()
-		 *                          must be false
 		 *  Otherwise test if the ip matches the ops filter
 		 *
 		 * If any of the above fails then the op->func() is not executed.
@@ -7570,8 +7566,8 @@ NOKPROBE_SYMBOL(arch_ftrace_ops_list_func);
 
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
2.35.1


