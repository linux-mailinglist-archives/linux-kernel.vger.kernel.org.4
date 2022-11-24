Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F87637BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiKXOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKXOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:50:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB664D9B82
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7921862187
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D20C43146;
        Thu, 24 Nov 2022 14:50:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYs-001X3Y-00;
        Thu, 24 Nov 2022 09:50:46 -0500
Message-ID: <20221124145045.881004349@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 03/11] tracing: Add trace_trigger kernel command line option
References: <20221124145019.782980678@goodmis.org>
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

Allow triggers to be enabled at kernel boot up. For example:

  trace_trigger="sched_switch.stacktrace if prev_state == 2"

The above will enable the stacktrace trigger on top of the sched_switch
event and only trigger if its prev_state is 2 (TASK_UNINTERRUPTIBLE). Then
at boot up, a stacktrace will trigger and be recorded in the tracing ring
buffer every time the sched_switch happens where the previous state is
TASK_INTERRUPTIBLE.

Another useful trigger would be "traceoff" which can stop tracing on an
event if a field of the event matches a certain value defined by the
filter ("if" statement).

Link: https://lore.kernel.org/linux-trace-kernel/20221020210056.0d8d0a5b@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 19 +++++
 kernel/trace/trace_events.c                   | 72 ++++++++++++++++++-
 2 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774..ccf91a4bf113 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6257,6 +6257,25 @@
 			See also Documentation/trace/ftrace.rst "trace options"
 			section.
 
+	trace_trigger=[trigger-list]
+			[FTRACE] Add a event trigger on specific events.
+			Set a trigger on top of a specific event, with an optional
+			filter.
+
+			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			Where more than one trigger may be specified that are comma deliminated.
+
+			For example:
+
+			  trace_trigger="sched_switch.stacktrace if prev_state == 2"
+
+			The above will enable the "stacktrace" trigger on the "sched_switch"
+			event but only trigger it if the "prev_state" of the "sched_switch"
+			event is "2" (TASK_UNINTERUPTIBLE).
+
+			See also "Event triggers" in Documentation/trace/events.rst
+
+
 	traceoff_on_warning
 			[FTRACE] enable this option to disable tracing when a
 			warning is hit. This turns off "tracing_on". Tracing can
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f71ea6e79b3c..3bfaf560ecc4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2796,6 +2796,44 @@ trace_create_new_event(struct trace_event_call *call,
 	return file;
 }
 
+#ifdef CONFIG_HIST_TRIGGERS
+#define MAX_BOOT_TRIGGERS 32
+
+static struct boot_triggers {
+	const char		*event;
+	char			*trigger;
+} bootup_triggers[MAX_BOOT_TRIGGERS];
+
+static char bootup_trigger_buf[COMMAND_LINE_SIZE];
+static int nr_boot_triggers;
+
+static __init int setup_trace_triggers(char *str)
+{
+	char *trigger;
+	char *buf;
+	int i;
+
+	strlcpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	ring_buffer_expanded = true;
+	disable_tracing_selftest("running event triggers");
+
+	buf = bootup_trigger_buf;
+	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
+		trigger = strsep(&buf, ",");
+		if (!trigger)
+			break;
+		bootup_triggers[i].event = strsep(&trigger, ".");
+		bootup_triggers[i].trigger = strsep(&trigger, ".");
+		if (!bootup_triggers[i].trigger)
+			break;
+	}
+
+	nr_boot_triggers = i;
+	return 1;
+}
+__setup("trace_trigger=", setup_trace_triggers);
+#endif
+
 /* Add an event to a trace directory */
 static int
 __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
@@ -2812,6 +2850,28 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 		return event_define_fields(call);
 }
 
+#ifdef CONFIG_HIST_TRIGGERS
+static void trace_early_triggers(struct trace_event_file *file, const char *name)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < nr_boot_triggers; i++) {
+		if (strcmp(name, bootup_triggers[i].event))
+			continue;
+		mutex_lock(&event_mutex);
+		ret = trigger_process_regex(file, bootup_triggers[i].trigger);
+		mutex_unlock(&event_mutex);
+		if (ret)
+			pr_err("Failed to register trigger '%s' on event %s\n",
+			       bootup_triggers[i].trigger,
+			       bootup_triggers[i].event);
+	}
+}
+#else
+static inline void trace_early_triggers(struct trace_event_file *file, const char *name) { }
+#endif
+
 /*
  * Just create a descriptor for early init. A descriptor is required
  * for enabling events at boot. We want to enable events before
@@ -2822,12 +2882,19 @@ __trace_early_add_new_event(struct trace_event_call *call,
 			    struct trace_array *tr)
 {
 	struct trace_event_file *file;
+	int ret;
 
 	file = trace_create_new_event(call, tr);
 	if (!file)
 		return -ENOMEM;
 
-	return event_define_fields(call);
+	ret = event_define_fields(call);
+	if (ret)
+		return ret;
+
+	trace_early_triggers(file, trace_event_name(call));
+
+	return 0;
 }
 
 struct ftrace_module_file_ops;
@@ -3735,6 +3802,8 @@ static __init int event_trace_enable(void)
 			list_add(&call->list, &ftrace_events);
 	}
 
+	register_trigger_cmds();
+
 	/*
 	 * We need the top trace array to have a working set of trace
 	 * points at early init, before the debug files and directories
@@ -3749,7 +3818,6 @@ static __init int event_trace_enable(void)
 
 	register_event_cmds();
 
-	register_trigger_cmds();
 
 	return 0;
 }
-- 
2.35.1


