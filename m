Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3E6C4008
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCVBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCVBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:51:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F259E50;
        Tue, 21 Mar 2023 18:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 420C6CE1BAB;
        Wed, 22 Mar 2023 01:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A6DC433EF;
        Wed, 22 Mar 2023 01:51:25 +0000 (UTC)
Date:   Tue, 21 Mar 2023 21:51:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] tracing: Trace instrumentation begin and end
Message-ID: <20230321215121.71b339c5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

I do a lot of analysis on how much the kernel is interfering with user
space and why. One measurement was to trace the length of page faults.
That was done with:

 trace-cmd start -p function_graph --max-graph_depth 1

Which would produce output like:

 3)   4.429 us    | __do_page_fault();
 3)   8.208 us    | __do_page_fault();
 3)   6.877 us    | __do_page_fault();
 3)   + 10.033 us | __do_page_fault();
 3)   8.013 us    | __do_page_fault();

But now that entry into the kernel is all protected with noinstr, function
graph tracing no longer catches entry into the kernel, and
__do_page_fault() is no longer traced.

Even trying just:

 trace-cmd start -p function_graph --max-graph_depth 1 -e page_fault_user

produces:

 2)   0.764 us    |  exit_to_user_mode_prepare();
 2)               |  /* page_fault_user: address=0x7fadaba40fd8 ip=0x7fadaba40fd8 error_code=0x14 */
 2)   0.581 us    |  down_read_trylock();

The "page_fault_user" event is not encapsulated around any function, which
means it probably triggered and went back to user space without any trace
to know how long that page fault took (the down_read_trylock() is likely to
be part of the page fault function, but that's besides the point).

To help bring back the old functionality, two trace points are added. One
just after instrumentation begins, and one just before it ends. This way,
we can see all the time that the kernel can do something meaningful, and we
will trace it.

 trace-cmd start -e instrumentation -e page_fault_user

produces:

       trace-cmd-911     [001] d....  2616.730120: instrumentation_begin: exc_page_fault+0x2e/0x250 <- asm_exc_page_fault+0x26/0x30
       trace-cmd-911     [001] d....  2616.730121: page_fault_user: address=0x7fcadc16ab70 ip=0x7fcadc16ab70 error_code=0x14
       trace-cmd-911     [001] d....  2616.730137: instrumentation_end: exc_page_fault+0x8d/0x250 <- asm_exc_page_fault+0x26/0x30

The time between the instrumentation_begin and the instrumentation_end
that has the page_fault_user can be considered the time the page fault
took.

To even make a histogram out of this, and using sqlhist to create
synthetic events. A synthetic event can be used to join the
instrumentation_begin with page_fault_user, and then another synthetic
event can join that synthetic event to instrumentation_end, passing the
timestamp between them.

 sqlhist -e -n fault_start 'SELECT start.TIMESTAMP AS start_ts
	 FROM instrumentation_begin AS start JOIN page_fault_user AS end
         ON start.common_pid = end.common_pid'

 sqlhist -e -n fault_total 'SELECT (end.TIMESTAMP - start.start_ts) AS delta
         FROM fault_start AS start JOIN instrumentation_end AS end
         ON start.common_pid = end.common_pid'

 ># cd /sys/kernel/tracing
 ># echo 'hist:keys=ip.sym-offset,pip.sys-offset,delta.buckets=20' > events/synthetic/fault_total/trigger
 ># cat events/synthetic/fault_total/hist
 # event histogram
 #
 # trigger info: hist:keys=common_pid.execname,delta.buckets=2000:vals=hitcount:sort=common_pid.execname,delta.buckets=2000:size=2048 [active]
 #

 { common_pid: systemd-journal [       250], delta: ~ 2000-3999 } hitcount:          7
 { common_pid: systemd-journal [       250], delta: ~ 4000-5999 } hitcount:        153
 { common_pid: systemd-journal [       250], delta: ~ 6000-7999 } hitcount:          7
 { common_pid: systemd-journal [       250], delta: ~ 8000-9999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 14000-15999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 16000-17999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 20000-21999 } hitcount:          9
 { common_pid: systemd-journal [       250], delta: ~ 22000-23999 } hitcount:          5
 { common_pid: systemd-journal [       250], delta: ~ 24000-25999 } hitcount:          3
 { common_pid: systemd-journal [       250], delta: ~ 42000-43999 } hitcount:          2
 { common_pid: systemd-journal [       250], delta: ~ 44000-45999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 52000-53999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 70000-71999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 74000-75999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 162000-163999 } hitcount:          1
 { common_pid: systemd-journal [       250], delta: ~ 172000-173999 } hitcount:          1
 { common_pid: NetworkManager  [       393], delta: ~ 10000-11999 } hitcount:          1
 { common_pid: NetworkManager  [       393], delta: ~ 30000-31999 } hitcount:          1
 { common_pid: exim4           [       719], delta: ~ 8000-9999 } hitcount:          1
 { common_pid: exim4           [       719], delta: ~ 12000-13999 } hitcount:          3

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/instrumentation.h        | 34 ++++++++++++++++++++--
 include/trace/events/instrumentation.h | 40 ++++++++++++++++++++++++++
 kernel/trace/trace.c                   | 20 +++++++++++++
 3 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/instrumentation.h

diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index bc7babe91b2e..f013acfc9192 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -2,6 +2,34 @@
 #ifndef __LINUX_INSTRUMENTATION_H
 #define __LINUX_INSTRUMENTATION_H
 
+#ifdef CONFIG_TRACING
+#include <linux/kernel.h>
+#include <linux/tracepoint-defs.h>
+
+void call_trace_instrumentation_begin(unsigned long ip, unsigned long pip);
+void call_trace_instrumentation_end(unsigned long ip, unsigned long pip);
+
+DECLARE_TRACEPOINT(instrumentation_begin);
+DECLARE_TRACEPOINT(instrumentation_end);
+
+static inline void do_trace_instrumentation_begin(unsigned long ip,
+						  unsigned long pip)
+{
+	if (tracepoint_enabled(instrumentation_begin))
+		call_trace_instrumentation_begin(ip, pip);
+}
+
+static inline void do_trace_instrumentation_end(unsigned long ip,
+						unsigned long pip)
+{
+	if (tracepoint_enabled(instrumentation_end))
+		call_trace_instrumentation_end(ip, pip);
+}
+#else /* !CONFIG_TRACING */
+static inline void do_trace_instrumentation_begin(unsigned long ip, unsigned long pip) { }
+static inline void do_trace_instrumentation_end(unsigned long ip, unsigned long pip) { }
+#endif /* CONFIG_TRACING */
+
 #ifdef CONFIG_NOINSTR_VALIDATION
 
 #include <linux/stringify.h>
@@ -12,6 +40,7 @@
 		     ".pushsection .discard.instr_begin\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
 		     ".popsection\n\t" : : "i" (c));			\
+	do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);		\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -47,6 +76,7 @@
  * part of the condition block and does not escape.
  */
 #define __instrumentation_end(c) ({					\
+	do_trace_instrumentation_end(_THIS_IP_, _RET_IP_);		\
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_end\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
@@ -54,8 +84,8 @@
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else /* !CONFIG_NOINSTR_VALIDATION */
-# define instrumentation_begin()	do { } while(0)
-# define instrumentation_end()		do { } while(0)
+# define instrumentation_begin() do_trace_instrumentation_begin(_THIS_IP_, _RET_IP_);
+# define instrumentation_end()	 do_trace_instrumentation_end(_THIS_IP_, _RET_IP_);
 #endif /* CONFIG_NOINSTR_VALIDATION */
 
 #endif /* __LINUX_INSTRUMENTATION_H */
diff --git a/include/trace/events/instrumentation.h b/include/trace/events/instrumentation.h
new file mode 100644
index 000000000000..6b92a205d9ae
--- /dev/null
+++ b/include/trace/events/instrumentation.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM instrumentation
+
+#if !defined(_TRACE_INSTRUMENTATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INSTRUMENTATION_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(instrumentation_template,
+
+	TP_PROTO(unsigned long ip, unsigned long pip),
+
+	TP_ARGS(ip, pip),
+
+	TP_STRUCT__entry(
+		__field( unsigned long,		ip )
+		__field( unsigned long,		pip )
+	),
+
+	TP_fast_assign(
+		__entry->ip = ip;
+		__entry->pip = pip;
+	),
+
+	TP_printk("%pS <- %pS", (void *)__entry->ip, (void *)__entry->pip)
+);
+
+DEFINE_EVENT(instrumentation_template, instrumentation_begin,
+	     TP_PROTO(unsigned long ip, unsigned long pip),
+	     TP_ARGS(ip, pip));
+
+DEFINE_EVENT(instrumentation_template, instrumentation_end,
+	     TP_PROTO(unsigned long ip, unsigned long pip),
+	     TP_ARGS(ip, pip));
+
+#endif /* _TRACE_INSTRUMENTATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 937e9676dfd4..071885824408 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -54,6 +54,26 @@
 #include "trace.h"
 #include "trace_output.h"
 
+/* Define instrumentation tracing here, as there is no real home for it */
+#define CREATE_TRACE_POINTS
+#include <trace/events/instrumentation.h>
+#undef CREATE_TRACE_POINTS
+
+void call_trace_instrumentation_begin(unsigned long ip, unsigned long pip)
+{
+	trace_instrumentation_begin(ip, pip);
+}
+EXPORT_SYMBOL_GPL(call_trace_instrumentation_begin);
+
+void call_trace_instrumentation_end(unsigned long ip, unsigned long pip)
+{
+	trace_instrumentation_end(ip, pip);
+}
+EXPORT_SYMBOL_GPL(call_trace_instrumentation_end);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(instrumentation_begin);
+EXPORT_TRACEPOINT_SYMBOL_GPL(instrumentation_end);
+
 /*
  * On boot up, the ring buffer is set to the minimum size, so that
  * we do not waste memory on systems that are not using tracing.
-- 
2.39.1

