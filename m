Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9AB65DE1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbjADVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjADVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:14:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723A71CB24;
        Wed,  4 Jan 2023 13:14:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E43D61826;
        Wed,  4 Jan 2023 21:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078F6C433EF;
        Wed,  4 Jan 2023 21:14:15 +0000 (UTC)
Date:   Wed, 4 Jan 2023 16:14:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] tracing: Make sure trace_printk() can output as soon as it
 can be used
Message-ID: <20230104161412.019f6c55@gandalf.local.home>
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

Currently trace_printk() can be used as soon as early_trace_init() is
called from start_kernel(). But if a crash happens, and
"ftrace_dump_on_oops" is set on the kernel command line, all you get will
be:

  [    0.456075]   <idle>-0         0dN.2. 347519us : Unknown type 6
  [    0.456075]   <idle>-0         0dN.2. 353141us : Unknown type 6
  [    0.456075]   <idle>-0         0dN.2. 358684us : Unknown type 6

This is because the trace_printk() event (type 6) hasn't been registered
yet. That gets done via an early_initcall(), which may be early, but not
early enough.

Instead of registering the trace_printk() event (and other ftrace events,
which are not trace events) via an early_initcall(), have them registered at
the same time that trace_printk() can be used. This way, if there is a
crash before early_initcall(), then the trace_printk()s will actually be
useful.

Cc: stable@vger.kernel.org
Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Fixes: e725c731e3bb1 ("tracing: Split tracing initialization into two for early initialization")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 2 ++
 kernel/trace/trace.h        | 1 +
 kernel/trace/trace_output.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3005279165d..80de338f1277 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10196,6 +10196,8 @@ void __init early_trace_init(void)
 			static_key_enable(&tracepoint_printk_key.key);
 	}
 	tracer_alloc_buffers();
+
+	init_events();
 }
 
 void __init trace_init(void)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 900e75d96c84..11c4918ff202 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1504,6 +1504,7 @@ extern void trace_event_enable_cmd_record(bool enable);
 extern void trace_event_enable_tgid_record(bool enable);
 
 extern int event_trace_init(void);
+extern int init_events(void);
 extern int event_trace_add_tracer(struct dentry *parent, struct trace_array *tr);
 extern int event_trace_del_tracer(struct trace_array *tr);
 extern void __trace_early_add_events(struct trace_array *tr);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 67f47ea27921..5cd4fb656306 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1568,7 +1568,7 @@ static struct trace_event *events[] __initdata = {
 	NULL
 };
 
-__init static int init_events(void)
+__init int init_events(void)
 {
 	struct trace_event *event;
 	int i, ret;
@@ -1581,4 +1581,3 @@ __init static int init_events(void)
 
 	return 0;
 }
-early_initcall(init_events);
-- 
2.35.1

