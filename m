Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2536692954
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjBJVd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjBJVdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:33:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02481CEF;
        Fri, 10 Feb 2023 13:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D47D61EAC;
        Fri, 10 Feb 2023 21:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF72C433EF;
        Fri, 10 Feb 2023 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676064798;
        bh=sRSOdM4Wfg7Ma3bCU80sAVGk7VjXjySJtZlopisAO0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UA99pG83VqBN1lTlIczV3HRqBXJRDR8Pkom0L6SNZpPi44QqQ5NJr1IQXQ0rrmBdj
         O/3K8xmoZKQoTDNZVGE+wsmfCOkPa7AXhJK3x/GR7eQRc5LuIyKLiL1ZcwRHrReJiy
         H76jeeBC7RNBGy1aa97xUsGQYQOzBpxO065P+yOBE70Z8ZSDoxDivMjndBa6c1vxUE
         wHOE8vRUMNTZsWi94Dh8NHRwrEACsNND3AT74ackDTGBQfSoTEVSz9rMdSxRTpqWqw
         mra+2SkK3L8lBoK6Q+TxHSkD3nUTwfzvnpuam1u2lmIrlVNEhaftJzfwm1bMqhqcl2
         9fGPTWHGU/C5A==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org,
        zwisler@google.com, chinglinyu@google.com
Subject: [PATCH 3/4] tracing/histogram: Fix stacktrace key
Date:   Fri, 10 Feb 2023 15:33:05 -0600
Message-Id: <11aa614c82976adbfa4ea763dbe885b5fb01d59c.1676063532.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676063532.git.zanussi@kernel.org>
References: <cover.1676063532.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 34 +++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a58380702491..eb812cfdaa88 100644
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
@@ -4269,6 +4273,19 @@ static u64 hist_field_execname(struct hist_field *hist_field,
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
@@ -4332,6 +4349,8 @@ static u64 hist_fn_call(struct hist_field *hist_field,
 		return div_by_mult_and_shift(hist_field, elt, buffer, rbe, event);
 	case HIST_FIELD_FN_EXECNAME:
 		return hist_field_execname(hist_field, elt, buffer, rbe, event);
+	case HIST_FIELD_FN_STACK:
+		return hist_field_stack(hist_field, elt, buffer, rbe, event);
 	default:
 		return 0;
 	}
@@ -5233,8 +5252,17 @@ static void event_hist_trigger(struct event_trigger_data *data,
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
 			memset(entries, 0, HIST_STACKTRACE_SIZE);
-			stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
-					 HIST_STACKTRACE_SKIP);
+			if (key_field->field) {
+				unsigned long *stack, n_entries;
+
+				field_contents = hist_fn_call(key_field, elt, buffer, rbe, rec);
+				stack = (unsigned long *)field_contents;
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
2.34.1

