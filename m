Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9165368E5BA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBHB6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBHB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E433E601
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A00ECB81BA2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AE9C433D2;
        Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiG-006dRX-1X;
        Tue, 07 Feb 2023 20:57:32 -0500
Message-ID: <20230208015732.290763896@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [for-next][PATCH 10/11] tracing: Add trace_array_puts() to write into instance
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

Add a generic trace_array_puts() that can be used to "trace_puts()" into
an allocated trace_array instance. This is just another variant of
trace_array_printk().

Link: https://lkml.kernel.org/r/20230207173026.584717290@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace.h | 12 ++++++++++++
 kernel/trace/trace.c  | 27 +++++++++++++++++----------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace.h b/include/linux/trace.h
index 80ffda871749..2a70a447184c 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -33,6 +33,18 @@ struct trace_array;
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
+/**
+ * trace_array_puts - write a constant string into the trace buffer.
+ * @tr:    The trace array to write to
+ * @str:   The constant string to write
+ */
+#define trace_array_puts(tr, str)					\
+	({								\
+		str ? __trace_array_puts(tr, _THIS_IP_, str, strlen(str)) : -1;	\
+	})
+int __trace_array_puts(struct trace_array *tr, unsigned long ip,
+		       const char *str, int size);
+
 void trace_printk_init_buffers(void);
 __printf(3, 4)
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5b16af9e7d30..9918bf7441ed 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1023,13 +1023,8 @@ __buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *ev
 		ring_buffer_unlock_commit(buffer);
 }
 
-/**
- * __trace_puts - write a constant string into the trace buffer.
- * @ip:	   The address of the caller
- * @str:   The constant string to write
- * @size:  The size of the string.
- */
-int __trace_puts(unsigned long ip, const char *str, int size)
+int __trace_array_puts(struct trace_array *tr, unsigned long ip,
+		       const char *str, int size)
 {
 	struct ring_buffer_event *event;
 	struct trace_buffer *buffer;
@@ -1037,7 +1032,7 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 	unsigned int trace_ctx;
 	int alloc;
 
-	if (!(global_trace.trace_flags & TRACE_ITER_PRINTK))
+	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
 	if (unlikely(tracing_selftest_running || tracing_disabled))
@@ -1046,7 +1041,7 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 	alloc = sizeof(*entry) + size + 2; /* possible \n added */
 
 	trace_ctx = tracing_gen_ctx();
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	ring_buffer_nest_start(buffer);
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, alloc,
 					    trace_ctx);
@@ -1068,11 +1063,23 @@ int __trace_puts(unsigned long ip, const char *str, int size)
 		entry->buf[size] = '\0';
 
 	__buffer_unlock_commit(buffer, event);
-	ftrace_trace_stack(&global_trace, buffer, trace_ctx, 4, NULL);
+	ftrace_trace_stack(tr, buffer, trace_ctx, 4, NULL);
  out:
 	ring_buffer_nest_end(buffer);
 	return size;
 }
+EXPORT_SYMBOL_GPL(__trace_array_puts);
+
+/**
+ * __trace_puts - write a constant string into the trace buffer.
+ * @ip:	   The address of the caller
+ * @str:   The constant string to write
+ * @size:  The size of the string.
+ */
+int __trace_puts(unsigned long ip, const char *str, int size)
+{
+	return __trace_array_puts(&global_trace, ip, str, size);
+}
 EXPORT_SYMBOL_GPL(__trace_puts);
 
 /**
-- 
2.39.1
