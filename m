Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489A66C53F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCVSoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB929E07
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C081B81DA9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B47C4339B;
        Wed, 22 Mar 2023 18:43:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qs-000pWt-0M;
        Wed, 22 Mar 2023 14:43:34 -0400
Message-ID: <20230322184333.927351019@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 02/11] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florent Revest <revest@chromium.org>

The _multi API requires that users keep their own ops but can enforce
that an op is only associated to one direct call.

Link: https://lkml.kernel.org/r/20230321140424.345218-3-revest@chromium.org

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c         | 10 ++++++----
 samples/ftrace/ftrace-direct-modify.c | 12 ++++++++----
 samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
 samples/ftrace/ftrace-direct.c        | 12 +++++++-----
 4 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index ff0536cea968..9ce80b3ad06d 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -785,6 +785,7 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+static struct ftrace_ops direct;
 #ifndef CALL_DEPTH_ACCOUNT
 #define CALL_DEPTH_ACCOUNT ""
 #endif
@@ -870,8 +871,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * Register direct function together with graph tracer
 	 * and make sure we get graph trace.
 	 */
-	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				     (unsigned long) trace_direct_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -891,8 +892,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				       (unsigned long) trace_direct_tramp);
+	ret = unregister_ftrace_direct_multi(&direct,
+					     (unsigned long) trace_direct_tramp,
+					     true);
 	if (ret)
 		goto out;
 
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index d93abbcb1f4c..f01ac74bac10 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -96,6 +96,8 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
@@ -114,7 +116,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -129,7 +131,9 @@ static int __init ftrace_direct_init(void)
 {
 	int ret;
 
-	ret = register_ftrace_direct(my_ip, my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
+
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
 	return ret;
@@ -138,12 +142,12 @@ static int __init ftrace_direct_init(void)
 static void __exit ftrace_direct_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct(my_ip, my_tramp);
+	unregister_ftrace_direct_multi(&direct, my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 8139dce2a31c..05c3585ac15e 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -70,21 +70,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)handle_mm_fault,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)handle_mm_fault,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1d3d307ca33d..42ec9e39453b 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -63,21 +63,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)wake_up_process,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)wake_up_process,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
-- 
2.39.1
