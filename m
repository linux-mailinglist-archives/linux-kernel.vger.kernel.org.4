Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C49738B35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjFUQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjFUQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8B10DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8286160E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08817C433C0;
        Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iI-001yml-0K;
        Wed, 21 Jun 2023 12:29:46 -0400
Message-ID: <20230621162945.920352371@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jackie Liu <liu.yun@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 08/13] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding new available_filter_functions_addrs file that shows all available
functions (same as available_filter_functions) together with addresses,
like:

  # cat available_filter_functions_addrs | head
  ffffffff81000770 __traceiter_initcall_level
  ffffffff810007c0 __traceiter_initcall_start
  ffffffff81000810 __traceiter_initcall_finish
  ffffffff81000860 trace_initcall_finish_cb
  ...

Note displayed address is the patch-site address and can differ from
/proc/kallsyms address.

It's useful to have address avilable for traceable symbols, so we don't
need to allways cross check kallsyms with available_filter_functions
(or the other way around) and have all the data in single file.

For backwards compatibility reasons we can't change the existing
available_filter_functions file output, but we need to add new file.

The problem is that we need to do 2 passes:

 - through available_filter_functions and find out if the function is traceable
 - through /proc/kallsyms to get the address for traceable function

Having available_filter_functions symbols together with addresses allow
us to skip the kallsyms step and we are ok with the address in
available_filter_functions_addr not being the function entry, because
kprobe_multi uses fprobe and that handles both entry and patch-site
address properly.

We have 2 interfaces how to create kprobe_multi link:

  a) passing symbols to kernel

     1) user gathers symbols and need to ensure that they are
        trace-able -> pass through available_filter_functions file

     2) kernel takes those symbols and translates them to addresses
        through kallsyms api

     3) addresses are passed to fprobe/ftrace through:

         register_fprobe_ips
         -> ftrace_set_filter_ips

  b) passing addresses to kernel

     1) user gathers symbols and needs to ensure that they are
        trace-able -> pass through available_filter_functions file

     2) user takes those symbols and translates them to addresses
       through /proc/kallsyms

     3) addresses are passed to the kernel and kernel calls:

         register_fprobe_ips
         -> ftrace_set_filter_ips

The new available_filter_functions_addrs file helps us with option b),
because we can make 'b 1' and 'b 2' in one step - while filtering traceable
functions, we get the address directly.

Link: https://lore.kernel.org/linux-trace-kernel/20230611130029.1202298-1-jolsa@kernel.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jackie Liu <liu.yun@linux.dev>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst |  6 ++++++
 include/linux/ftrace.h         |  1 +
 kernel/trace/ftrace.c          | 37 ++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index df2d3e57a83f..b7308ab10c0e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -324,6 +324,12 @@ of ftrace. Here is a list of some of the key files:
 	"set_graph_function", or "set_graph_notrace".
 	(See the section "dynamic ftrace" below for more details.)
 
+  available_filter_functions_addrs:
+
+	Similar to available_filter_functions, but with address displayed
+	for each function. The displayed address is the patch-site address
+	and can differ from /proc/kallsyms address.
+
   dyn_ftrace_total_info:
 
 	This file is for debugging purposes. The number of functions that
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 49f279f4c3a1..8e59bd954153 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -633,6 +633,7 @@ enum {
 	FTRACE_ITER_MOD		= (1 << 5),
 	FTRACE_ITER_ENABLED	= (1 << 6),
 	FTRACE_ITER_TOUCHED	= (1 << 7),
+	FTRACE_ITER_ADDRS	= (1 << 8),
 };
 
 void arch_ftrace_update_code(int command);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 764668467155..b24c573934af 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3861,6 +3861,9 @@ static int t_show(struct seq_file *m, void *v)
 	if (!rec)
 		return 0;
 
+	if (iter->flags & FTRACE_ITER_ADDRS)
+		seq_printf(m, "%lx ", rec->ip);
+
 	if (print_rec(m, rec->ip)) {
 		/* This should only happen when a rec is disabled */
 		WARN_ON_ONCE(!(rec->flags & FTRACE_FL_DISABLED));
@@ -3996,6 +3999,30 @@ ftrace_touched_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int
+ftrace_avail_addrs_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_iterator *iter;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	if (unlikely(ftrace_disabled))
+		return -ENODEV;
+
+	iter = __seq_open_private(file, &show_ftrace_seq_ops, sizeof(*iter));
+	if (!iter)
+		return -ENOMEM;
+
+	iter->pg = ftrace_pages_start;
+	iter->flags = FTRACE_ITER_ADDRS;
+	iter->ops = &global_ops;
+
+	return 0;
+}
+
 /**
  * ftrace_regex_open - initialize function tracer filter files
  * @ops: The ftrace_ops that hold the hash filters
@@ -5916,6 +5943,13 @@ static const struct file_operations ftrace_touched_fops = {
 	.release = seq_release_private,
 };
 
+static const struct file_operations ftrace_avail_addrs_fops = {
+	.open = ftrace_avail_addrs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release_private,
+};
+
 static const struct file_operations ftrace_filter_fops = {
 	.open = ftrace_filter_open,
 	.read = seq_read,
@@ -6377,6 +6411,9 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 	trace_create_file("available_filter_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_avail_fops);
 
+	trace_create_file("available_filter_functions_addrs", TRACE_MODE_READ,
+			d_tracer, NULL, &ftrace_avail_addrs_fops);
+
 	trace_create_file("enabled_functions", TRACE_MODE_READ,
 			d_tracer, NULL, &ftrace_enabled_fops);
 
-- 
2.39.2
