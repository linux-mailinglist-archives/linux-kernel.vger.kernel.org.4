Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96D46E2E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDOCRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjDOCRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1124F55B3;
        Fri, 14 Apr 2023 19:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F4D64934;
        Sat, 15 Apr 2023 02:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBD7C433EF;
        Sat, 15 Apr 2023 02:17:05 +0000 (UTC)
Date:   Fri, 14 Apr 2023 22:17:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] tracing: Add generic test_recursion_try_acquire()
Message-ID: <20230414221702.554c44fe@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The ftrace_test_recursion_trylock() also disables preemption. This is not
required, but was a clean up as every place that called it also disabled
preemption, and making the two tightly coupled appeared to make the code
simpler.

But the recursion protection can be used for other purposes that do not
require disabling preemption. As the recursion bits are attached to the
task_struct, it follows the task, so there's no need for preemption being
disabled.

Add test_recursion_try_acquire/release() functions to be used generically,
and separate it from being associated with ftrace. It also removes the
"lock" name, as there is no lock happening. Keeping the "lock" for the
ftrace version is better, as it at least differentiates that preemption is
being disabled (hence, "locking the CPU").

Link: https://lore.kernel.org/linux-trace-kernel/20230321020103.13494-1-laoar.shao@gmail.com/

Cc: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 47 ++++++++++++++++++++++++---------
 kernel/trace/ftrace.c           |  2 ++
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92d2364..80de2ee7b4c3 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -150,9 +150,6 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 # define trace_warn_on_no_rcu(ip)	false
 #endif
 
-/*
- * Preemption is promised to be disabled when return bit >= 0.
- */
 static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsigned long pip,
 							int start)
 {
@@ -182,18 +179,11 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	val |= 1 << bit;
 	current->trace_recursion = val;
 	barrier();
-
-	preempt_disable_notrace();
-
 	return bit;
 }
 
-/*
- * Preemption will be enabled (if it was previously enabled).
- */
 static __always_inline void trace_clear_recursion(int bit)
 {
-	preempt_enable_notrace();
 	barrier();
 	trace_recursion_clear(bit);
 }
@@ -205,12 +195,18 @@ static __always_inline void trace_clear_recursion(int bit)
  * tracing recursed in the same context (normal vs interrupt),
  *
  * Returns: -1 if a recursion happened.
- *           >= 0 if no recursion.
+ *           >= 0 if no recursion and preemption will be disabled.
  */
 static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
 							 unsigned long parent_ip)
 {
-	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+	int bit;
+
+	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+	if (unlikely(bit < 0))
+		return bit;
+	preempt_disable_notrace();
+	return bit;
 }
 
 /**
@@ -220,6 +216,33 @@ static __always_inline int ftrace_test_recursion_trylock(unsigned long ip,
  * This is used at the end of a ftrace callback.
  */
 static __always_inline void ftrace_test_recursion_unlock(int bit)
+{
+	preempt_enable_notrace();
+	trace_clear_recursion(bit);
+}
+
+/**
+ * test_recursion_try_acquire - tests for recursion in same context
+ *
+ * This will detect recursion of a function.
+ *
+ * Returns: -1 if a recursion happened.
+ *           >= 0 if no recursion
+ */
+static __always_inline int test_recursion_try_acquire(unsigned long ip,
+						      unsigned long parent_ip)
+{
+	return trace_test_and_set_recursion(ip, parent_ip, TRACE_FTRACE_START);
+}
+
+/**
+ * test_recursion_release - called after a success of test_recursion_try_acquire()
+ * @bit: The return of a successful test_recursion_try_acquire()
+ *
+ * This releases the recursion lock taken by a non-negative return call
+ * by test_recursion_try_acquire().
+ */
+static __always_inline void test_recursion_release(int bit)
 {
 	trace_clear_recursion(bit);
 }
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index db8532a4d5c8..1b117ab057ed 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7299,6 +7299,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	preempt_disable();
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		/* Stub functions don't need to be called nor tested */
 		if (op->flags & FTRACE_OPS_FL_STUB)
@@ -7320,6 +7321,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 		}
 	} while_for_each_ftrace_op(op);
 out:
+	preempt_enable();
 	trace_clear_recursion(bit);
 }
 
-- 
2.39.2

