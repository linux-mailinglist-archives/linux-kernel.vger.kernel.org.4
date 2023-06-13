Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2B72E4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjFMNzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjFMNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD4A6;
        Tue, 13 Jun 2023 06:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D44C063149;
        Tue, 13 Jun 2023 13:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F6AC433D9;
        Tue, 13 Jun 2023 13:55:38 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:55:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2] tracing: Add a debug_trace_printk() function
Message-ID: <20230613095537.0ecf2459@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

While doing some tracing and kernel debugging, I found that some of my
trace_printk()s were being lost in the noise of the other code that was
being traced. Having a way to write trace_printk() not in the top level
trace buffer would have been useful.

There was also a time I needed to debug ftrace itself, where
trace_printk() did not hit the paths that were being debugged. But because
the trace that was being debugged, was going into the top level ring
buffer, it was causing issues for seeing what is to be traced.

To solve both of the above, add a debug_trace_printk() that can be used
just like trace_printk() except that it goes into a "debug" instance
buffer instead. This can be used at boot up as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230612193337.0fb0d3ca@gandalf.local.home/

  - I had added a prompt to the kconfig but never committed it.
    It's now part of the patch.

 include/linux/kernel.h | 14 ++++++++++++++
 kernel/trace/Kconfig   | 20 ++++++++++++++++++++
 kernel/trace/trace.c   | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d91e0af0125..594c9ba17fd4 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -432,6 +432,20 @@ __ftrace_vbprintk(unsigned long ip, const char *fmt, va_list ap);
 extern __printf(2, 0) int
 __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
 
+#ifdef CONFIG_FTRACE_DEBUG_PRINT
+extern __printf(2,0) void do_debug_trace_printk(unsigned long ip, const char *fmt, ...);
+#define debug_trace_printk(fmt, ...) \
+do {							\
+	do_debug_trace_printk(_THIS_IP_, fmt, ##__VA_ARGS__);	\
+} while (0)
+
+extern void debug_tracing_stop(void);
+#else
+#define debug_trace_printk(fmt, ...) do { } while (0)
+static inline void debug_tracing_stop(void) { }
+#endif
+
+
 extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
 #else
 static inline void tracing_start(void) { }
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index abe5c583bd59..e07bca39dec9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -974,6 +974,26 @@ config GCOV_PROFILE_FTRACE
 	  Note that on a kernel compiled with this config, ftrace will
 	  run significantly slower.
 
+config FTRACE_DEBUG_PRINT
+	bool "Enable debug_trace_printk()"
+	depends on TRACING
+	help
+	  This option enables the use of debug_trace_printk() instead of
+	  using trace_printk(). The difference between the two is that
+	  debug_trace_printk() traces are visible in the "debug" instance
+	  found in:
+
+	  /sys/kernel/tracing/instances/debug
+
+	  This is useful when the trace printks should not interfere with
+	  the normal top level tracing. It is also useful if the top level
+	  tracing is very noisy and critical trace printks are dropped.
+	  By using debug_trace_printk() the traces goes into as separate
+	  ring buffer that will not be overridden by other trace events.
+
+	  If unsure say N (In fact, only say Y if you are debugging a
+	                   kernel and require this)
+
 config FTRACE_SELFTEST
 	bool
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 64a4dde073ef..c21a93cf5fd8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -490,6 +490,10 @@ static struct trace_array global_trace = {
 	.trace_flags = TRACE_DEFAULT_FLAGS,
 };
 
+#ifdef CONFIG_FTRACE_DEBUG_PRINT
+static struct trace_array *debug_trace;
+#endif
+
 LIST_HEAD(ftrace_trace_arrays);
 
 int trace_array_get(struct trace_array *this_tr)
@@ -10455,8 +10459,33 @@ void __init early_trace_init(void)
 	tracer_alloc_buffers();
 
 	init_events();
+
+#ifdef CONFIG_FTRACE_DEBUG_PRINT
+	debug_trace = trace_array_get_by_name("debug");
+	if (WARN_ON(!debug_trace))
+		return;
+	trace_array_init_printk(debug_trace);
+#endif
 }
 
+#ifdef CONFIG_FTRACE_DEBUG_PRINT
+__printf(2, 0)
+void do_debug_trace_printk(unsigned long ip, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	trace_array_vprintk(debug_trace, ip, fmt, ap);
+	va_end(ap);
+}
+
+void debug_tracing_stop(void)
+{
+	debug_trace_printk("Stopping debug tracing\n");
+	tracing_stop_tr(debug_trace);
+}
+#endif
+
 void __init trace_init(void)
 {
 	trace_event_init();
-- 
2.39.2

