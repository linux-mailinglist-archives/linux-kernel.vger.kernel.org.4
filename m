Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F076B68DEF1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjBGRax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBGRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:30:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499F21A25;
        Tue,  7 Feb 2023 09:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0279BCE1E47;
        Tue,  7 Feb 2023 17:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F72FC4339B;
        Tue,  7 Feb 2023 17:30:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPRnW-006Rwl-1B;
        Tue, 07 Feb 2023 12:30:26 -0500
Message-ID: <20230207173026.186210158@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 12:28:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/4] tracing: Add creation of instances at boot command line
References: <20230207172849.461894073@goodmis.org>
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

Add kernel command line to add tracing instances. This only creates
instances at boot but still does not enable any events to them. Later
changes will extend this command line to add enabling of events, filters,
and triggers. As well as possibly redirecting trace_printk()!

Cc: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/r/20230111145842.376427803@goodmis.org
 - Fixed document grammar (Randy Dunlap)
 - Removed extra workqueue.h include (Ross Zwisler)
 - Use sizeof(boot_instance_info) than using COMMAND_LINE_SIZE)

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
