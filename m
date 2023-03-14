Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870ED6BA216
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCNWNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCNWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB538EB5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:11:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072BB61A30
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FBC433EF;
        Tue, 14 Mar 2023 22:10:13 +0000 (UTC)
Date:   Tue, 14 Mar 2023 18:10:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing: Fixes for 6.3
Message-ID: <20230314181012.05baf5c7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for v6.3

- Do not allow histogram values to have modifies.
  Can cause a NULL pointer dereference if they do.

- Warn if hist_field_name() is passed a NULL.
  Prevent the NULL pointer dereference mentioned above.

- Fix invalid address look up race in lookup_rec()

- Define ftrace_stub_graph conditionally to prevent linker errors

- Always check if RCU is watching at all tracepoint locations


Please pull the latest trace-v6.3-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.3-rc1

Tag SHA1: e07d2c69309d86ea31c30de7148fb6ec57786857
Head SHA1: c2679254b9c9980d9045f0f722cf093a2b1f7590


Arnd Bergmann (1):
      ftrace,kcfi: Define ftrace_stub_graph conditionally

Chen Zhongjin (1):
      ftrace: Fix invalid address access in lookup_rec() when index is 0

Steven Rostedt (Google) (3):
      tracing: Do not let histogram values have some modifiers
      tracing: Check field value in hist_field_name()
      tracing: Make tracepoint lockdep check actually test something

----
 arch/x86/kernel/ftrace_64.S      |  2 ++
 include/linux/tracepoint.h       | 15 ++++++---------
 kernel/trace/ftrace.c            |  3 ++-
 kernel/trace/trace_events_hist.c | 12 ++++++++++++
 4 files changed, 22 insertions(+), 10 deletions(-)
---------------------------
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1265ad519249..fb4f1e01b64a 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -136,10 +136,12 @@ SYM_TYPED_FUNC_START(ftrace_stub)
 	RET
 SYM_FUNC_END(ftrace_stub)
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_TYPED_FUNC_START(ftrace_stub_graph)
 	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(ftrace_stub_graph)
+#endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index fa1004fcf810..2083f2d2f05b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -231,12 +231,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * not add unwanted padding between the beginning of the section and the
  * structure. Force alignment to the same alignment as the section start.
  *
- * When lockdep is enabled, we make sure to always do the RCU portions of
- * the tracepoint code, regardless of whether tracing is on. However,
- * don't check if the condition is false, due to interaction with idle
- * instrumentation. This lets us find RCU issues triggered with tracepoints
- * even when this tracepoint is off. This code has no purpose other than
- * poking RCU a bit.
+ * When lockdep is enabled, we make sure to always test if RCU is
+ * "watching" regardless if the tracepoint is enabled or not. Tracepoints
+ * require RCU to be active, and it should always warn at the tracepoint
+ * site if it is not watching, as it will need to be active when the
+ * tracepoint is enabled.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
 	extern int __traceiter_##name(data_proto);			\
@@ -249,9 +248,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			rcu_read_lock_sched_notrace();			\
-			rcu_dereference_sched(__tracepoint_##name.funcs);\
-			rcu_read_unlock_sched_notrace();		\
+			WARN_ON_ONCE(!rcu_is_watching());		\
 		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 750aa3f08b25..a47f7d93e32d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1537,7 +1537,8 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
 	for (pg = ftrace_pages_start; pg; pg = pg->next) {
-		if (end < pg->records[0].ip ||
+		if (pg->index == 0 ||
+		    end < pg->records[0].ip ||
 		    start >= (pg->records[pg->index - 1].ip + MCOUNT_INSN_SIZE))
 			continue;
 		rec = bsearch(&key, pg->records, pg->index,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 89877a18f933..486cca3c2b75 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1331,6 +1331,9 @@ static const char *hist_field_name(struct hist_field *field,
 {
 	const char *field_name = "";
 
+	if (WARN_ON_ONCE(!field))
+		return field_name;
+
 	if (level > 1)
 		return field_name;
 
@@ -4235,6 +4238,15 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	/* Some types cannot be a value */
+	if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+				 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+				 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
+				 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE)) {
+		hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+		ret = -EINVAL;
+	}
+
 	hist_data->fields[val_idx] = hist_field;
 
 	++hist_data->n_vals;
