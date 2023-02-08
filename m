Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1A68E5B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBHB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjBHB5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1DF3D901
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C052F60DD1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0139C433EF;
        Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiG-006dS6-2C;
        Tue, 07 Feb 2023 20:57:32 -0500
Message-ID: <20230208015732.497961665@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [for-next][PATCH 11/11] tracing: Allow boot instances to have snapshot buffers
References: <20230208015633.791198913@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
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

Link: https://lkml.kernel.org/r/20230207173026.792774721@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++
 kernel/trace/trace.c                          | 79 +++++++++++++++++--
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 40304dc3d319..7fa1ee4ba910 100644
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
index 9918bf7441ed..97c88711f270 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -191,6 +191,9 @@ static bool snapshot_at_boot;
 static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
 static int boot_instance_index;
 
+static char boot_snapshot_info[COMMAND_LINE_SIZE] __initdata;
+static int boot_snapshot_index;
+
 static int __init set_cmdline_ftrace(char *str)
 {
 	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
@@ -227,9 +230,22 @@ __setup("traceoff_on_warning", stop_trace_on_warning);
 
 static int __init boot_alloc_snapshot(char *str)
 {
-	allocate_snapshot = true;
-	/* We also need the main ring buffer expanded */
-	ring_buffer_expanded = true;
+	char *slot = boot_snapshot_info + boot_snapshot_index;
+	int left = sizeof(boot_snapshot_info) - boot_snapshot_index;
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
@@ -9254,10 +9270,6 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	}
 	tr->allocated_snapshot = allocate_snapshot;
 
-	/*
-	 * Only the top level trace array gets its snapshot allocated
-	 * from the kernel command line.
-	 */
 	allocate_snapshot = false;
 #endif
 
@@ -10173,6 +10185,47 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
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
+	ret = strstr(boot_snapshot_info, test) == NULL;
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
+#else
+static inline void do_allocate_snapshot(const char *name) { }
+#endif
+
 __init static void enable_instances(void)
 {
 	struct trace_array *tr;
@@ -10188,6 +10241,9 @@ __init static void enable_instances(void)
 
 		tok = strsep(&curr_str, ",");
 
+		if (IS_ENABLED(CONFIG_TRACER_MAX_TRACE))
+			do_allocate_snapshot(tok);
+
 		tr = trace_array_get_by_name(tok);
 		if (!tr) {
 			pr_warn("Failed to create instance buffer %s\n", curr_str);
@@ -10335,10 +10391,19 @@ __init static int tracer_alloc_buffers(void)
 
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
2.39.1
