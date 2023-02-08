Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2236368E5B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBHB5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBHB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFCF23675
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F807B81B9E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A5AC433A7;
        Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiF-006dNc-07;
        Tue, 07 Feb 2023 20:57:31 -0500
Message-ID: <20230208015730.847877889@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [for-next][PATCH 03/11] tracing: Acquire buffer from temparary trace sequence
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

From: Linyu Yuan <quic_linyyuan@quicinc.com>

there is one dwc3 trace event declare as below,
DECLARE_EVENT_CLASS(dwc3_log_event,
	TP_PROTO(u32 event, struct dwc3 *dwc),
	TP_ARGS(event, dwc),
	TP_STRUCT__entry(
		__field(u32, event)
		__field(u32, ep0state)
		__dynamic_array(char, str, DWC3_MSG_MAX)
	),
	TP_fast_assign(
		__entry->event = event;
		__entry->ep0state = dwc->ep0state;
	),
	TP_printk("event (%08x): %s", __entry->event,
			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
				__entry->event, __entry->ep0state))
);
the problem is when trace function called, it will allocate up to
DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
during fast assignment, it only fill the buffer when output function are
called, so this means if output function are not called, the buffer will
never used.

add __get_buf(len) which acquiree buffer from iter->tmp_seq when trace
output function called, it allow user write string to acquired buffer.

the mentioned dwc3 trace event will changed as below,
DECLARE_EVENT_CLASS(dwc3_log_event,
	TP_PROTO(u32 event, struct dwc3 *dwc),
	TP_ARGS(event, dwc),
	TP_STRUCT__entry(
		__field(u32, event)
		__field(u32, ep0state)
	),
	TP_fast_assign(
		__entry->event = event;
		__entry->ep0state = dwc->ep0state;
	),
	TP_printk("event (%08x): %s", __entry->event,
		dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
				__entry->event, __entry->ep0state))
);.

Link: https://lore.kernel.org/linux-trace-kernel/1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_seq.h                  |  5 +++++
 include/trace/stages/stage3_trace_output.h |  3 +++
 include/trace/stages/stage7_class_define.h |  1 +
 kernel/trace/trace_seq.c                   | 23 ++++++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 0c4c7587d6c3..6be92bf559fe 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -95,6 +95,7 @@ extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      int prefix_type, int rowsize, int groupsize,
 			      const void *buf, size_t len, bool ascii);
+char *trace_seq_acquire(struct trace_seq *s, unsigned int len);
 
 #else /* CONFIG_TRACING */
 static inline __printf(2, 3)
@@ -139,6 +140,10 @@ static inline int trace_seq_path(struct trace_seq *s, const struct path *path)
 {
 	return 0;
 }
+static inline char *trace_seq_acquire(struct trace_seq *s, unsigned int len)
+{
+	return NULL;
+}
 #endif /* CONFIG_TRACING */
 
 #endif /* _LINUX_TRACE_SEQ_H */
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 66374df61ed3..c1fb1355d309 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -139,3 +139,6 @@
 		u64 ____val = (u64)(value);		\
 		(u32) do_div(____val, NSEC_PER_SEC);	\
 	})
+
+#undef __get_buf
+#define __get_buf(len)		trace_seq_acquire(p, (len))
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8795429f388b..bcb960d16fc0 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -23,6 +23,7 @@
 #undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
+#undef __get_buf
 
 /*
  * The below is not executed in the kernel. It is only what is
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 9c90b3a7dce2..e5e299260d0c 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -403,3 +403,26 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 	return 1;
 }
 EXPORT_SYMBOL(trace_seq_hex_dump);
+
+/*
+ * trace_seq_acquire - acquire seq buffer with size len
+ * @s: trace sequence descriptor
+ * @len: size of buffer to be acquired
+ *
+ * acquire buffer with size of @len from trace_seq for output usage,
+ * user can fill string into that buffer.
+ *
+ * Returns start address of acquired buffer.
+ *
+ * it allow multiple usage in one trace output function call.
+ */
+char *trace_seq_acquire(struct trace_seq *s, unsigned int len)
+{
+	char *ret = trace_seq_buffer_ptr(s);
+
+	if (!WARN_ON_ONCE(seq_buf_buffer_left(&s->seq) < len))
+		seq_buf_commit(&s->seq, len);
+
+	return ret;
+}
+EXPORT_SYMBOL(trace_seq_acquire);
-- 
2.39.1
