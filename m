Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D968DEEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjBGRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBGRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:30:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932B421948;
        Tue,  7 Feb 2023 09:30:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA7B1B81A60;
        Tue,  7 Feb 2023 17:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94954C433A1;
        Tue,  7 Feb 2023 17:30:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPRnW-006RxJ-1o;
        Tue, 07 Feb 2023 12:30:26 -0500
Message-ID: <20230207173026.386114535@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 12:28:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH v2 2/4] tracing: Add enabling of events to boot instances
References: <20230207172849.461894073@goodmis.org>
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

Add the format of:

  trace_instance=foo,sched:sched_switch,irq_handler_entry,initcall

That will create the "foo" instance and enable the sched_switch event
(here were the "sched" system is explicitly specified), the
irq_handler_entry event, and all events under the system initcall.

Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 kernel/trace/trace.c                            |  4 ++++
 kernel/trace/trace.h                            |  2 ++
 kernel/trace/trace_events.c                     |  9 ++++-----
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9545da5ed849..40304dc3d319 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6278,6 +6278,20 @@
 
 				/sys/kernel/tracing/instances
 
+			Events can be enabled at the time the instance is created
+			via:
+
+				trace_instance=<name>,<system1>:<event1>,<system2>:<event2>
+
+			Note, the "<system*>:" portion is optional if the event is
+			unique.
+
+				trace_instance=foo,sched:sched_switch,irq_handler_entry,initcall
+
+			will enable the "sched_switch" event (note, the "sched:" is optional, and
+			the same thing would happen if it was left off). The irq_handler_entry
+			event, and all events under the "initcall" system.
+
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
 			The option-list is a comma delimited list of options
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 863716fcca49..5b16af9e7d30 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10188,6 +10188,10 @@ __init static void enable_instances(void)
 		}
 		/* Allow user space to delete it */
 		trace_array_put(tr);
+
+		while ((tok = strsep(&curr_str, ","))) {
+			early_enable_events(tr, tok, true);
+		}
 	}
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d16929dd0f08..f10bf804dd2b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1334,6 +1334,8 @@ DECLARE_PER_CPU(int, trace_buffered_event_cnt);
 void trace_buffered_event_disable(void);
 void trace_buffered_event_enable(void);
 
+void early_enable_events(struct trace_array *tr, char *buf, bool disable_first);
+
 static inline void
 __trace_event_discard_commit(struct trace_buffer *buffer,
 			     struct ring_buffer_event *event)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b07931ad97de..cf3fd74fa675 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3750,10 +3750,9 @@ static __init int event_trace_memsetup(void)
 	return 0;
 }
 
-static __init void
-early_enable_events(struct trace_array *tr, bool disable_first)
+__init void
+early_enable_events(struct trace_array *tr, char *buf, bool disable_first)
 {
-	char *buf = bootup_event_buf;
 	char *token;
 	int ret;
 
@@ -3806,7 +3805,7 @@ static __init int event_trace_enable(void)
 	 */
 	__trace_early_add_events(tr);
 
-	early_enable_events(tr, false);
+	early_enable_events(tr, bootup_event_buf, false);
 
 	trace_printk_start_comm();
 
@@ -3834,7 +3833,7 @@ static __init int event_trace_enable_again(void)
 	if (!tr)
 		return -ENODEV;
 
-	early_enable_events(tr, true);
+	early_enable_events(tr, bootup_event_buf, true);
 
 	return 0;
 }
-- 
2.39.1
