Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F05648F13
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLJN7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiLJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3453186E9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC3260C4C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B366C43398;
        Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40N0-000kur-1x;
        Sat, 10 Dec 2022 08:58:26 -0500
Message-ID: <20221210135826.472515575@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Subject: [for-next][PATCH 21/25] tracing: Fix some checker warnings
References: <20221210135750.425719934@goodmis.org>
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

From: David Howells <dhowells@redhat.com>

Fix some checker warnings in the trace code by adding __printf attributes
to a number of trace functions and their declarations.

Changes:
========
ver #2)
 - Dropped the fix for the unconditional tracing_max_lat_fops decl[1].

Link: https://lore.kernel.org/r/20221205180617.9b9d3971cbe06ee536603523@kernel.org/ [1]
Link: https://lore.kernel.org/r/166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk/ # v1
Link: https://lkml.kernel.org/r/167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 3 ++-
 include/linux/trace_seq.h    | 3 ++-
 kernel/trace/trace.h         | 2 +-
 kernel/trace/trace_output.c  | 5 +++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index bb2053246d6a..4342e996bcdb 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -234,7 +234,8 @@ void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
 void tracing_record_cmdline(struct task_struct *task);
 void tracing_record_tgid(struct task_struct *task);
 
-int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...);
+int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
+	 __printf(3, 4);
 
 struct event_filter;
 
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 5a2c650d9e1c..0c4c7587d6c3 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -97,7 +97,8 @@ extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      const void *buf, size_t len, bool ascii);
 
 #else /* CONFIG_TRACING */
-static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
+static inline __printf(2, 3)
+void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
 }
 static inline void
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9dc920b01c17..e46a49269be2 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -614,7 +614,7 @@ void trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 bool trace_is_tracepoint_string(const char *str);
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
-			 va_list ap);
+			 va_list ap) __printf(2, 0);
 
 int trace_empty(struct trace_iterator *iter);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index f0ba97121345..57a13b61f186 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -322,8 +322,9 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
 }
 EXPORT_SYMBOL(trace_event_printf);
 
-static int trace_output_raw(struct trace_iterator *iter, char *name,
-			    char *fmt, va_list ap)
+static __printf(3, 0)
+int trace_output_raw(struct trace_iterator *iter, char *name,
+		     char *fmt, va_list ap)
 {
 	struct trace_seq *s = &iter->seq;
 
-- 
2.35.1


