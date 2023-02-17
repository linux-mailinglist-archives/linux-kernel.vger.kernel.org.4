Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F069A325
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBQAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjBQAu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D7E5776A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72610B82ABF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C6AC433AC;
        Fri, 17 Feb 2023 00:50:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pSoxT-000qOJ-0p;
        Thu, 16 Feb 2023 19:50:39 -0500
Message-ID: <20230217005039.070788344@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 16 Feb 2023 19:49:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 4/5] tracing/histogram: Fix stacktrace key
References: <20230217004954.719324747@goodmis.org>
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

From: Tom Zanussi <zanussi@kernel.org>

The current code will always use the current stacktrace as a key even
if a stacktrace contained in a specific event field was specified.

For example, we expect to use the 'unsigned long[] stack' field in the
below event in the histogram:

  # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > /sys/kernel/debug/tracing/dynamic_events
  # echo 'hist:keys=delta.buckets=100,stack.stacktrace:sort=delta' > /sys/kernel/debug/tracing/events/synthetic/block_lat/trigger

But in fact, when we type out the trigger, we see that it's using the
plain old global 'stacktrace' as the key, which is just the stacktrace
when the event was hit and not the stacktrace contained in the event,
which is what we want:

  # cat /sys/kernel/debug/tracing/events/synthetic/block_lat/trigger
  hist:keys=delta.buckets=100,stacktrace:vals=hitcount:sort=delta.buckets=100:size=2048 [active]

And in fact, there's no code to actually retrieve it from the event,
so we need to add HIST_FIELD_FN_STACK and hist_field_stack() to get it
and hook it into the trigger code.  For now, since the stack is just
using dynamic strings, this could just use the dynamic string
function, but it seems cleaner to have a dedicated function an be able
to tweak independently as necessary.

Link: https://lkml.kernel.org/r/11aa614c82976adbfa4ea763dbe885b5fb01d59c.1676063532.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
[ Fixed 32bit build warning reported by kernel test robot <lkp@intel.com> ]
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c4f1fe985f6f..89877a18f933 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -135,6 +135,7 @@ enum hist_field_fn {
 	HIST_FIELD_FN_DIV_NOT_POWER2,
 	HIST_FIELD_FN_DIV_MULT_SHIFT,
 	HIST_FIELD_FN_EXECNAME,
+	HIST_FIELD_FN_STACK,
 };
 
 /*
@@ -1982,7 +1983,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 	}
 
 	if (flags & HIST_FIELD_FL_STACKTRACE) {
-		hist_field->fn_num = HIST_FIELD_FN_NOP;
+		if (field)
+			hist_field->fn_num = HIST_FIELD_FN_STACK;
+		else
+			hist_field->fn_num = HIST_FIELD_FN_NOP;
 		hist_field->size = HIST_STACKTRACE_SIZE;
 		hist_field->type = kstrdup_const("unsigned long[]", GFP_KERNEL);
 		if (!hist_field->type)
@@ -4274,6 +4278,19 @@ static u64 hist_field_execname(struct hist_field *hist_field,
 	return (u64)(unsigned long)(elt_data->comm);
 }
 
+static u64 hist_field_stack(struct hist_field *hist_field,
+			    struct tracing_map_elt *elt,
+			    struct trace_buffer *buffer,
+			    struct ring_buffer_event *rbe,
+			    void *event)
+{
+	u32 str_item = *(u32 *)(event + hist_field->field->offset);
+	int str_loc = str_item & 0xffff;
+	char *addr = (char *)(event + str_loc);
+
+	return (u64)(unsigned long)addr;
+}
+
 static u64 hist_fn_call(struct hist_field *hist_field,
 			struct tracing_map_elt *elt,
 			struct trace_buffer *buffer,
@@ -4337,6 +4354,8 @@ static u64 hist_fn_call(struct hist_field *hist_field,
 		return div_by_mult_and_shift(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_EXECNAME:
 		return hist_field_execname(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_STACK:
+		return hist_field_stack(hist_field, elt, buffer, rbe, event);
 	default:
 		return 0;
 	}
@@ -5238,8 +5257,17 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
 			memset(entries, 0, HIST_STACKTRACE_SIZE);
-			stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
-					 HIST_STACKTRACE_SKIP);
+			if (key_field->field) {
+				unsigned long *stack, n_entries;
+
+				field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
+				stack = (unsigned long *)(long)field_contents;
+				n_entries = *stack;
+				memcpy(entries, ++stack, n_entries * sizeof(unsigned long));
+			} else {
+				stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
+						 HIST_STACKTRACE_SKIP);
+			}
 			key = entries;
 		} else {
 			field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
-- 
2.39.1
