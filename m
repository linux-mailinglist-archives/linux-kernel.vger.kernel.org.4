Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D546679CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjAXO5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjAXO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:56:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9F76B3;
        Tue, 24 Jan 2023 06:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48616122D;
        Tue, 24 Jan 2023 14:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88650C433EF;
        Tue, 24 Jan 2023 14:56:55 +0000 (UTC)
Date:   Tue, 24 Jan 2023 09:56:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, chriscli@google.com
Subject: [PATCH] ftrace: Show a list of all functions that have ever been
 enabled
Message-ID: <20230124095653.6fd1640e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When debugging a crash that appears to be related to ftrace, but not for
sure, it is useful to know if a function was ever enabled by ftrace or
not. It could be that a BPF program was attached to it, or possibly a live
patch.

We are having crashes in the field where this information is not always
known. But having ftrace set a flag if a function has ever been attached
since boot up helps tremendously in trying to know if a crash had to do
with something using ftrace.

For analyzing crashes, the use of a kdump image can have access to the
flags. When looking at issues where the kernel did not panic, the
touched_functions file can simply be used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

[
  This patch will conflict with Mark's patch that is going through the ARM
  tree. I will hold off pulling this patch until the next merge window, and
  rebase it on top of the changes when the tracing tree merges with upstream
  that has the changes from the ARM tree.
]

 include/linux/ftrace.h |  5 ++++-
 kernel/trace/ftrace.c  | 51 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 99f1146614c0..76baba9bd21b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -563,6 +563,7 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  IPMODIFY - the record allows for the IP address to be changed.
  *  DISABLED - the record is not ready to be touched yet
  *  DIRECT   - there is a direct function to call
+ *  TOUCHED  - A callback was added since boot up
  *
  * When a new ftrace_ops is registered and wants a function to save
  * pt_regs, the rec->flags REGS is set. When the function has been
@@ -580,9 +581,10 @@ enum {
 	FTRACE_FL_DISABLED	= (1UL << 25),
 	FTRACE_FL_DIRECT	= (1UL << 24),
 	FTRACE_FL_DIRECT_EN	= (1UL << 23),
+	FTRACE_FL_TOUCHED	= (1UL << 22),
 };
 
-#define FTRACE_REF_MAX_SHIFT	23
+#define FTRACE_REF_MAX_SHIFT	22
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
 
 #define ftrace_rec_count(rec)	((rec)->flags & FTRACE_REF_MAX)
@@ -641,6 +643,7 @@ enum {
 	FTRACE_ITER_PROBE	= (1 << 4),
 	FTRACE_ITER_MOD		= (1 << 5),
 	FTRACE_ITER_ENABLED	= (1 << 6),
+	FTRACE_ITER_TOUCHED	= (1 << 7),
 };
 
 void arch_ftrace_update_code(int command);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 442438b93fe9..7687f413ab36 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -45,6 +45,9 @@
 #include "trace_output.h"
 #include "trace_stat.h"
 
+/* Flags that do not get reset */
+#define FTRACE_NOCLEAR_FLAGS	(FTRACE_FL_DISABLED | FTRACE_FL_TOUCHED)
+
 #define FTRACE_INVALID_FUNCTION		"__ftrace_invalid_address__"
 
 #define FTRACE_WARN_ON(cond)			\
@@ -2196,7 +2199,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 		flag ^= rec->flags & FTRACE_FL_ENABLED;
 
 		if (update) {
-			rec->flags |= FTRACE_FL_ENABLED;
+			rec->flags |= FTRACE_FL_ENABLED | FTRACE_FL_TOUCHED;
 			if (flag & FTRACE_FL_REGS) {
 				if (rec->flags & FTRACE_FL_REGS)
 					rec->flags |= FTRACE_FL_REGS_EN;
@@ -2251,7 +2254,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 	if (update) {
 		/* If there's no more users, clear all flags */
 		if (!ftrace_rec_count(rec))
-			rec->flags &= FTRACE_FL_DISABLED;
+			rec->flags &= FTRACE_NOCLEAR_FLAGS;
 		else
 			/*
 			 * Just disable the record, but keep the ops TRAMP
@@ -3067,7 +3070,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		struct dyn_ftrace *rec;
 
 		do_for_each_ftrace_rec(pg, rec) {
-			if (FTRACE_WARN_ON_ONCE(rec->flags & ~FTRACE_FL_DISABLED))
+			if (FTRACE_WARN_ON_ONCE(rec->flags & ~FTRACE_NOCLEAR_FLAGS))
 				pr_warn("  %pS flags:%lx\n",
 					(void *)rec->ip, rec->flags);
 		} while_for_each_ftrace_rec();
@@ -3518,7 +3521,10 @@ t_func_next(struct seq_file *m, loff_t *pos)
 		     !ftrace_lookup_ip(iter->hash, rec->ip)) ||
 
 		    ((iter->flags & FTRACE_ITER_ENABLED) &&
-		     !(rec->flags & FTRACE_FL_ENABLED))) {
+		     !(rec->flags & FTRACE_FL_ENABLED)) ||
+
+		    ((iter->flags & FTRACE_ITER_TOUCHED) &&
+		     !(rec->flags & FTRACE_FL_TOUCHED))) {
 
 			rec = NULL;
 			goto retry;
@@ -3777,7 +3783,7 @@ static int t_show(struct seq_file *m, void *v)
 		return 0;
 	}
 
-	if (iter->flags & FTRACE_ITER_ENABLED) {
+	if (iter->flags & (FTRACE_ITER_ENABLED | FTRACE_ITER_TOUCHED)) {
 		struct ftrace_ops *ops;
 
 		seq_printf(m, " (%ld)%s%s%s",
@@ -3869,6 +3875,31 @@ ftrace_enabled_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int
+ftrace_touched_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_iterator *iter;
+
+	/*
+	 * This shows us what functions have ever been enabled
+	 * (traced, direct, patched, etc). Not sure if we want lockdown
+	 * to hide such critical information for an admin.
+	 * Although, perhaps it can show information we don't
+	 * want people to see, but if something had traced
+	 * something, we probably want to know about it.
+	 */
+
+	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
+	if (!iter)
+		return -ENOMEM;
+
+	iter->pg = ftrace_pages_start;
+	iter->flags = FTRACE_ITER_TOUCHED;
+	iter->ops = &global_ops;
+
+	return 0;
+}
+
 /**
  * ftrace_regex_open - initialize function tracer filter files
  * @ops: The ftrace_ops that hold the hash filters
@@ -6137,6 +6168,13 @@ static const struct file_operations ftrace_enabled_fops = {
 	.release = seq_release_private,
 };
 
+static const struct file_operations ftrace_touched_fops = {
+	.open = ftrace_touched_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
 static const struct file_operations ftrace_filter_fops = {
 	.open = ftrace_filter_open,
 	.read = seq_read,
@@ -6601,6 +6639,9 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("enabled_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_enabled_fops);
 
+	trace_create_file("touched_functions", TRACE_MODE_READ,
+			d_tracer, NULL, &ftrace_touched_fops);
+
 	ftrace_create_filter_files(&global_ops, d_tracer);
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-- 
2.39.0

