Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D08665E97
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjAKO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbjAKO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:58:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF663C6;
        Wed, 11 Jan 2023 06:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C7E61D52;
        Wed, 11 Jan 2023 14:58:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AD3C433F2;
        Wed, 11 Jan 2023 14:58:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pFcYs-000M8d-3B;
        Wed, 11 Jan 2023 09:58:42 -0500
Message-ID: <20230111145842.847715402@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Jan 2023 09:56:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 4/4] tracing: Allow boot instances to have snapshot buffers
References: <20230111145636.450953217@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add to ftrace_boot_snapshot, "=<instance>" name, where the instance will
get a snapshot buffer, and will take a snapshot at the end of boot (which
will save the boot traces).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++
 kernel/trace/trace.c                          | 77 +++++++++++++++++--
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7a7f41652719..f4e87b17427f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1532,6 +1532,15 @@
 			boot up that is likely to be overridden by user space
 			start up functionality.
 
+			Optionally, the snapshot can also be defined for a tracing
+			instance that was created by the trace_instance= command
+			line parameter.
+
+			trace_instance=foo,sched_switch ftrace_boot_snapshot=foo
+
+			The above will cause the "foo" tracing instance to trigger
+			a snapshot at the end of boot up.
+
 	ftrace_dump_on_oops[=orig_cpu]
 			[FTRACE] will dump the trace buffers on oops.
 			If no parameter is passed, ftrace will dump
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3cb9bbc0f076..d445789dc247 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -192,6 +192,9 @@ static bool snapshot_at_boot;
 static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
 static int boot_instance_index;
 
+static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
+static int boot_snapshot_index;
+
 static int __init set_cmdline_ftrace(char *str)
 {
 	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
@@ -228,9 +231,22 @@ __setup("traceoff_on_warning", stop_trace_on_warning);
 
 static int __init boot_alloc_snapshot(char *str)
 {
-	allocate_snapshot = true;
-	/* We also need the main ring buffer expanded */
-	ring_buffer_expanded = true;
+	char *slot = boot_snapshot_info + boot_snapshot_index;
+	int left = COMMAND_LINE_SIZE - boot_snapshot_index;
+	int ret;
+
+	if (str[0] == '=') {
+		str++;
+		if (strlen(str) >= left)
+			return -1;
+
+		ret = snprintf(slot, left, "%s\t", str);
+		boot_snapshot_index += ret;
+	} else {
+		allocate_snapshot = true;
+		/* We also need the main ring buffer expanded */
+		ring_buffer_expanded = true;
+	}
 	return 1;
 }
 __setup("alloc_snapshot", boot_alloc_snapshot);
@@ -9255,10 +9271,6 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	}
 	tr->allocated_snapshot = allocate_snapshot;
 
-	/*
-	 * Only the top level trace array gets its snapshot allocated
-	 * from the kernel command line.
-	 */
 	allocate_snapshot = false;
 #endif
 
@@ -10174,6 +10186,45 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 	return ret;
 }
 
+#ifdef CONFIG_TRACER_MAX_TRACE
+__init static bool tr_needs_alloc_snapshot(const char *name)
+{
+	char *test;
+	int len = strlen(name);
+	bool ret;
+
+	if (!boot_snapshot_index)
+		return false;
+
+	if (strncmp(name, boot_snapshot_info, len) == 0 &&
+	    boot_snapshot_info[len] == '\t')
+		return true;
+
+	test = kmalloc(strlen(name) + 3, GFP_KERNEL);
+	if (!test)
+		return false;
+
+	sprintf(test, "\t%s\t", name);
+	ret = strstr(boot_snapshot_info, test) == 0;
+	kfree(test);
+	return ret;
+}
+
+__init static void do_allocate_snapshot(const char *name)
+{
+	if (!tr_needs_alloc_snapshot(name))
+		return;
+
+	/*
+	 * When allocate_snapshot is set, the next call to
+	 * allocate_trace_buffers() (called by trace_array_get_by_name())
+	 * will allocate the snapshot buffer. That will alse clear
+	 * this flag.
+	 */
+	allocate_snapshot = true;
+}
+#endif
+
 __init static void enable_instances(void)
 {
 	struct trace_array *tr;
@@ -10189,6 +10240,9 @@ __init static void enable_instances(void)
 
 		tok = strsep(&curr_str, ",");
 
+		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
+			do_allocate_snapshot(tok);
+
 		tr = trace_array_get_by_name(tok);
 		if (!tr) {
 			pr_warn("Failed to create instance buffer %s\n", curr_str);
@@ -10336,10 +10390,19 @@ __init static int tracer_alloc_buffers(void)
 
 void __init ftrace_boot_snapshot(void)
 {
+	struct trace_array *tr;
+
 	if (snapshot_at_boot) {
 		tracing_snapshot();
 		internal_trace_puts("** Boot snapshot taken **\n");
 	}
+
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr == &global_trace)
+			continue;
+		trace_array_puts(tr, "** Boot snapshot taken **\n");
+		tracing_snapshot_instance(tr);
+	}
 }
 
 void __init early_trace_init(void)
-- 
2.39.0


