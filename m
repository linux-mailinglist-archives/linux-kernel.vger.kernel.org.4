Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505706F4E96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjECBc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjECBcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4E2700;
        Tue,  2 May 2023 18:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 447BF629D9;
        Wed,  3 May 2023 01:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17A2C433EF;
        Wed,  3 May 2023 01:32:35 +0000 (UTC)
Date:   Tue, 2 May 2023 21:32:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Add MODIFIED flag to show if IPMODIFY or direct was
 attached
Message-ID: <20230502213233.004e3ae4@gandalf.local.home>
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

If a function had ever had IPMODIFY or DIRECT attached to it, where this
is how live kernel patching and BPF overrides work, mark them and display
an "M" in the enabled_functions and touched_functions files. This can be
used for debugging. If a function had been modified and later there's a bug
in the code related to that function, this can be used to know if the cause
is possibly from a live kernel patch or a BPF program that changed the
behavior of the code.

Also update the documentation on the enabled_functions and
touched_functions output, as it was missing direct callers and CALL_OPS.
And include this new modify attribute.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 25 +++++++++++++++++++++++++
 include/linux/ftrace.h         |  4 +++-
 kernel/trace/ftrace.c          | 12 +++++++++---
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index aaebb821912e..d5766229c71a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -350,6 +350,19 @@ of ftrace. Here is a list of some of the key files:
 	an 'I' will be displayed on the same line as the function that
 	can be overridden.
 
+	If a non ftrace trampoline is attached (BPF) a 'D' will be displayed.
+	Note, normal ftrace trampolines can also be attached, but only one
+	"direct" trampoline can be attached to a given function at a time.
+
+	Some architectures can not call direct trampolines, but instead have
+	the ftrace ops function located above the function entry point. In
+	such cases an 'O' will be displayed.
+
+	If a function had either the "ip modify" or a "direct" call attached to
+	it in the past, a 'M' will be shown. This flag is never cleared. It is
+	used to know if a function was every modified by the ftrace infrastructure,
+	and can be used for debugging.
+
 	If the architecture supports it, it will also show what callback
 	is being directly called by the function. If the count is greater
 	than 1 it most likely will be ftrace_ops_list_func().
@@ -359,6 +372,18 @@ of ftrace. Here is a list of some of the key files:
 	its address will be printed as well as the function that the
 	trampoline calls.
 
+  touched_functions:
+
+	This file contains all the functions that ever had a function callback
+	to it via the ftrace infrastructure. It has the same format as
+	enabled_functions but shows all functions that have every been
+	traced.
+
+	To see any function that has every been modified by "ip modify" or a
+	direct trampoline, one can perform the following command:
+
+	grep ' M ' /sys/kernel/tracing/touched_functions
+
   function_profile_enabled:
 
 	When set it will enable all functions with either the function
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 327046f1278d..7dffd740e784 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -549,6 +549,7 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  CALL_OPS - the record can use callsite-specific ops
  *  CALL_OPS_EN - the function is set up to use callsite-specific ops
  *  TOUCHED  - A callback was added since boot up
+ *  MODIFIED - The function had IPMODIFY or DIRECT attached to it
  *
  * When a new ftrace_ops is registered and wants a function to save
  * pt_regs, the rec->flags REGS is set. When the function has been
@@ -569,9 +570,10 @@ enum {
 	FTRACE_FL_CALL_OPS	= (1UL << 22),
 	FTRACE_FL_CALL_OPS_EN	= (1UL << 21),
 	FTRACE_FL_TOUCHED	= (1UL << 20),
+	FTRACE_FL_MODIFIED	= (1UL << 19),
 };
 
-#define FTRACE_REF_MAX_SHIFT	20
+#define FTRACE_REF_MAX_SHIFT	19
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
 
 #define ftrace_rec_count(rec)	((rec)->flags & FTRACE_REF_MAX)
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index db8532a4d5c8..885845fc851d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -46,7 +46,8 @@
 #include "trace_stat.h"
 
 /* Flags that do not get reset */
-#define FTRACE_NOCLEAR_FLAGS	(FTRACE_FL_DISABLED | FTRACE_FL_TOUCHED)
+#define FTRACE_NOCLEAR_FLAGS	(FTRACE_FL_DISABLED | FTRACE_FL_TOUCHED | \
+				 FTRACE_FL_MODIFIED)
 
 #define FTRACE_INVALID_FUNCTION		"__ftrace_invalid_address__"
 
@@ -2273,6 +2274,10 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 					rec->flags &= ~FTRACE_FL_TRAMP_EN;
 			}
 
+			/* Keep track of anything that modifies the function */
+			if (rec->flags & (FTRACE_FL_DIRECT | FTRACE_FL_IPMODIFY))
+				rec->flags |= FTRACE_FL_MODIFIED;
+
 			if (flag & FTRACE_FL_DIRECT) {
 				/*
 				 * If there's only one user (direct_ops helper)
@@ -3866,12 +3871,13 @@ static int t_show(struct seq_file *m, void *v)
 	if (iter->flags & (FTRACE_ITER_ENABLED | FTRACE_ITER_TOUCHED)) {
 		struct ftrace_ops *ops;
 
-		seq_printf(m, " (%ld)%s%s%s%s",
+		seq_printf(m, " (%ld)%s%s%s%s%s",
 			   ftrace_rec_count(rec),
 			   rec->flags & FTRACE_FL_REGS ? " R" : "  ",
 			   rec->flags & FTRACE_FL_IPMODIFY ? " I" : "  ",
 			   rec->flags & FTRACE_FL_DIRECT ? " D" : "  ",
-			   rec->flags & FTRACE_FL_CALL_OPS ? " O" : "  ");
+			   rec->flags & FTRACE_FL_CALL_OPS ? " O" : "  ",
+			   rec->flags & FTRACE_FL_MODIFIED ? " M " : "   ");
 		if (rec->flags & FTRACE_FL_TRAMP_EN) {
 			ops = ftrace_find_tramp_ops_any(rec);
 			if (ops) {
-- 
2.39.2

