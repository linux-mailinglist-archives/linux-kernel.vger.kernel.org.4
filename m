Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317968E5B5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBHB5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBHB5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCF13EFE5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BDD61460
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105C7C433AC;
        Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiG-006dQO-0D;
        Tue, 07 Feb 2023 20:57:32 -0500
Message-ID: <20230208015731.877487562@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [for-next][PATCH 08/11] tracing: Add creation of instances at boot command line
References: <20230208015633.791198913@goodmis.org>
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

Add kernel command line to add tracing instances. This only creates
instances at boot but still does not enable any events to them. Later
changes will extend this command line to add enabling of events, filters,
and triggers. As well as possibly redirecting trace_printk()!

Link: https://lkml.kernel.org/r/20230207173026.186210158@goodmis.org

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 kernel/trace/trace.c                          | 50 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..9545da5ed849 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6272,6 +6272,12 @@
 			comma-separated list of trace events to enable. See
 			also Documentation/trace/events.rst
 
+	trace_instance=[instance-info]
+			[FTRACE] Create a ring buffer instance early in boot up.
+			This will be listed in:
+
+				/sys/kernel/tracing/instances
+
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
 			The option-list is a comma delimited list of options
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b90eecd27dfc..863716fcca49 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,8 @@
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 
+#include <asm/setup.h> /* COMMAND_LINE_SIZE */
+
 #include "trace.h"
 #include "trace_output.h"
 
@@ -186,6 +188,9 @@ static char *default_bootup_tracer;
 static bool allocate_snapshot;
 static bool snapshot_at_boot;
 
+static char boot_instance_info[COMMAND_LINE_SIZE] __initdata;
+static int boot_instance_index;
+
 static int __init set_cmdline_ftrace(char *str)
 {
 	strlcpy(bootup_tracer_buf, str, MAX_TRACER_SIZE);
@@ -239,6 +244,23 @@ static int __init boot_snapshot(char *str)
 __setup("ftrace_boot_snapshot", boot_snapshot);
 
 
+static int __init boot_instance(char *str)
+{
+	char *slot = boot_instance_info + boot_instance_index;
+	int left = sizeof(boot_instance_info) - boot_instance_index;
+	int ret;
+
+	if (strlen(str) >= left)
+		return -1;
+
+	ret = snprintf(slot, left, "%s\t", str);
+	boot_instance_index += ret;
+
+	return 1;
+}
+__setup("trace_instance=", boot_instance);
+
+
 static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
 static int __init set_trace_boot_options(char *str)
@@ -10144,6 +10166,31 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 	return ret;
 }
 
+__init static void enable_instances(void)
+{
+	struct trace_array *tr;
+	char *curr_str;
+	char *str;
+	char *tok;
+
+	/* A tab is always appended */
+	boot_instance_info[boot_instance_index - 1] = '\0';
+	str = boot_instance_info;
+
+	while ((curr_str = strsep(&str, "\t"))) {
+
+		tok = strsep(&curr_str, ",");
+
+		tr = trace_array_get_by_name(tok);
+		if (!tr) {
+			pr_warn("Failed to create instance buffer %s\n", curr_str);
+			continue;
+		}
+		/* Allow user space to delete it */
+		trace_array_put(tr);
+	}
+}
+
 __init static int tracer_alloc_buffers(void)
 {
 	int ring_buf_size;
@@ -10302,6 +10349,9 @@ void __init early_trace_init(void)
 void __init trace_init(void)
 {
 	trace_event_init();
+
+	if (boot_instance_index)
+		enable_instances();
 }
 
 __init static void clear_boot_tracer(void)
-- 
2.39.1
