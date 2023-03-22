Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1216C53EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCVSnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCVSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9525E298C9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25FE362276
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696FCC433AA;
        Wed, 22 Mar 2023 18:43:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qs-000pXz-1f;
        Wed, 22 Mar 2023 14:43:34 -0400
Message-ID: <20230322184334.334868243@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florent Revest <revest@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 04/11] ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florent Revest <revest@chromium.org>

Now that the original _ftrace_direct APIs are gone, the "_multi"
suffixes only add confusion.

Link: https://lkml.kernel.org/r/20230321140424.345218-5-revest@chromium.org

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h                      | 20 ++++++------
 kernel/bpf/trampoline.c                     | 12 ++++----
 kernel/trace/ftrace.c                       | 34 ++++++++++-----------
 kernel/trace/trace_selftest.c               |  9 +++---
 samples/Kconfig                             |  2 +-
 samples/ftrace/ftrace-direct-modify.c       |  8 ++---
 samples/ftrace/ftrace-direct-multi-modify.c |  8 ++---
 samples/ftrace/ftrace-direct-multi.c        |  4 +--
 samples/ftrace/ftrace-direct-too.c          |  6 ++--
 samples/ftrace/ftrace-direct.c              |  6 ++--
 10 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 2f400c9f0787..abee60865fc7 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -398,11 +398,11 @@ struct ftrace_func_entry {
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 extern int ftrace_direct_func_count;
 unsigned long ftrace_find_rec_direct(unsigned long ip);
-int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
-				   bool free_filters);
-int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+			     bool free_filters);
+int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 #else
 struct ftrace_ops;
@@ -411,20 +411,20 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
 }
-static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
-static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
-						 bool free_filters)
+static inline int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+					   bool free_filters)
 {
 	return -ENODEV;
 }
-static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
-static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
+static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
 {
 	return -ENODEV;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 88bc23f1e10a..a14d0af534b3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -45,8 +45,8 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_ops *ops, enum ftrace_ops_cmd
 		lockdep_assert_held_once(&tr->mutex);
 
 		/* Instead of updating the trampoline here, we propagate
-		 * -EAGAIN to register_ftrace_direct_multi(). Then we can
-		 * retry register_ftrace_direct_multi() after updating the
+		 * -EAGAIN to register_ftrace_direct(). Then we can
+		 * retry register_ftrace_direct() after updating the
 		 * trampoline.
 		 */
 		if ((tr->flags & BPF_TRAMP_F_CALL_ORIG) &&
@@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr, false);
+		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -215,9 +215,9 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 
 	if (tr->func.ftrace_managed) {
 		if (lock_direct_mutex)
-			ret = modify_ftrace_direct_multi(tr->fops, (long)new_addr);
+			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
 		else
-			ret = modify_ftrace_direct_multi_nolock(tr->fops, (long)new_addr);
+			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
 	}
@@ -243,7 +243,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 
 	if (tr->func.ftrace_managed) {
 		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
-		ret = register_ftrace_direct_multi(tr->fops, (long)new_addr);
+		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fbc9abfa1a3e..845c4012630f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5318,7 +5318,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
 }
 
 /**
- * register_ftrace_direct_multi - Call a custom trampoline directly
+ * register_ftrace_direct - Call a custom trampoline directly
  * for multiple functions registered in @ops
  * @ops: The address of the struct ftrace_ops object
  * @addr: The address of the trampoline to call at @ops functions
@@ -5339,7 +5339,7 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
  *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
  *  -ENOMEM  - There was an allocation failure.
  */
-int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	struct ftrace_hash *hash, *free_hash = NULL;
 	struct ftrace_func_entry *entry, *new;
@@ -5397,11 +5397,11 @@ int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	}
 	return err;
 }
-EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
+EXPORT_SYMBOL_GPL(register_ftrace_direct);
 
 /**
- * unregister_ftrace_direct_multi - Remove calls to custom trampoline
- * previously registered by register_ftrace_direct_multi for @ops object.
+ * unregister_ftrace_direct - Remove calls to custom trampoline
+ * previously registered by register_ftrace_direct for @ops object.
  * @ops: The address of the struct ftrace_ops object
  *
  * This is used to remove a direct calls to @addr from the nop locations
@@ -5412,8 +5412,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
  *  0 on success
  *  -EINVAL - The @ops object was not properly registered.
  */
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
-				   bool free_filters)
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+			     bool free_filters)
 {
 	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
@@ -5436,10 +5436,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
 		ftrace_free_filter(ops);
 	return err;
 }
-EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
 
 static int
-__modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+__modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	struct ftrace_hash *hash;
 	struct ftrace_func_entry *entry, *iter;
@@ -5486,7 +5486,7 @@ __modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 }
 
 /**
- * modify_ftrace_direct_multi_nolock - Modify an existing direct 'multi' call
+ * modify_ftrace_direct_nolock - Modify an existing direct 'multi' call
  * to call something else
  * @ops: The address of the struct ftrace_ops object
  * @addr: The address of the new trampoline to call at @ops functions
@@ -5503,19 +5503,19 @@ __modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  * Returns: zero on success. Non zero on error, which includes:
  *  -EINVAL - The @ops object was not properly registered.
  */
-int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr)
+int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr)
 {
 	if (check_direct_multi(ops))
 		return -EINVAL;
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
 
-	return __modify_ftrace_direct_multi(ops, addr);
+	return __modify_ftrace_direct(ops, addr);
 }
-EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_nolock);
 
 /**
- * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
+ * modify_ftrace_direct - Modify an existing direct 'multi' call
  * to call something else
  * @ops: The address of the struct ftrace_ops object
  * @addr: The address of the new trampoline to call at @ops functions
@@ -5529,7 +5529,7 @@ EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi_nolock);
  * Returns: zero on success. Non zero on error, which includes:
  *  -EINVAL - The @ops object was not properly registered.
  */
-int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
 	int err;
 
@@ -5539,11 +5539,11 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
-	err = __modify_ftrace_direct_multi(ops, addr);
+	err = __modify_ftrace_direct(ops, addr);
 	mutex_unlock(&direct_mutex);
 	return err;
 }
-EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
+EXPORT_SYMBOL_GPL(modify_ftrace_direct);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 9ce80b3ad06d..84cd7ba31d27 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -872,7 +872,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * and make sure we get graph trace.
 	 */
 	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
-	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
+	ret = register_ftrace_direct(&direct,
+				     (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -892,9 +893,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct_multi(&direct,
-					     (unsigned long) trace_direct_tramp,
-					     true);
+	ret = unregister_ftrace_direct(&direct,
+				       (unsigned long) trace_direct_tramp,
+				       true);
 	if (ret)
 		goto out;
 
diff --git a/samples/Kconfig b/samples/Kconfig
index 30ef8bd48ba3..fd24daa99f34 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -38,7 +38,7 @@ config SAMPLE_FTRACE_DIRECT
 	  that hooks to wake_up_process and prints the parameters.
 
 config SAMPLE_FTRACE_DIRECT_MULTI
-	tristate "Build register_ftrace_direct_multi() example"
+	tristate "Build register_ftrace_direct() on multiple ips example"
 	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
 	depends on HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	help
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index f01ac74bac10..25fba66f61c0 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -116,7 +116,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		ret = modify_ftrace_direct(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -132,7 +132,7 @@ static int __init ftrace_direct_init(void)
 	int ret;
 
 	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
-	ret = register_ftrace_direct_multi(&direct, my_tramp);
+	ret = register_ftrace_direct(&direct, my_tramp);
 
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
@@ -142,12 +142,12 @@ static int __init ftrace_direct_init(void)
 static void __exit ftrace_direct_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct_multi(&direct, my_tramp, true);
+	unregister_ftrace_direct(&direct, my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 196b43971cb5..f72623899602 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -123,7 +123,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
+		ret = modify_ftrace_direct(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -141,7 +141,7 @@ static int __init ftrace_direct_multi_init(void)
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
 
-	ret = register_ftrace_direct_multi(&direct, my_tramp);
+	ret = register_ftrace_direct(&direct, my_tramp);
 
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
@@ -151,12 +151,12 @@ static int __init ftrace_direct_multi_init(void)
 static void __exit ftrace_direct_multi_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct_multi(&direct, my_tramp, true);
+	unregister_ftrace_direct(&direct, my_tramp, true);
 }
 
 module_init(ftrace_direct_multi_init);
 module_exit(ftrace_direct_multi_exit);
 
 MODULE_AUTHOR("Jiri Olsa");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index ea0e88ee5e43..1547c2c6be02 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -73,12 +73,12 @@ static int __init ftrace_direct_multi_init(void)
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 	ftrace_set_filter_ip(&direct, (unsigned long) schedule, 0, 0);
 
-	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_multi_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp, true);
+	unregister_ftrace_direct(&direct, (unsigned long) my_tramp, true);
 }
 
 module_init(ftrace_direct_multi_init);
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 05c3585ac15e..f28e7b99840f 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -76,17 +76,17 @@ static int __init ftrace_direct_init(void)
 {
 	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
 
-	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp, true);
+	unregister_ftrace_direct(&direct, (unsigned long)my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 42ec9e39453b..d81a9473b585 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -69,17 +69,17 @@ static int __init ftrace_direct_init(void)
 {
 	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
 
-	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
+	return register_ftrace_direct(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp, true);
+	unregister_ftrace_direct(&direct, (unsigned long)my_tramp, true);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
 MODULE_LICENSE("GPL");
-- 
2.39.1
