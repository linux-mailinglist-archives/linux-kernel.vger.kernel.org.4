Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E869A322
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBQAvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjBQAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E4C5775C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F4B0B82ABC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6733C433EF;
        Fri, 17 Feb 2023 00:50:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pSoxS-000qMe-24;
        Thu, 16 Feb 2023 19:50:38 -0500
Message-ID: <20230217005038.455296375@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 16 Feb 2023 19:49:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 1/5] tracing/histogram: Dont use strlen to find length of stacktrace
 variables
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

Because stacktraces are saved in dynamic strings,
trace_event_raw_event_synth() uses strlen to determine the length of
the stack.  Stacktraces may contain 0-bytes, though, in the saved
addresses, so the length found and passed to reserve() will be too
small.

Fix this by using the first unsigned long in the stack variables to
store the actual number of elements in the stack and have
trace_event_raw_event_synth() use that to determine the length of the
stack.

Link: https://lkml.kernel.org/r/1ed6906cd9d6477ef2bd8e63c61de20a9ffe64d7.1676063532.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c  | 12 ++++++++----
 kernel/trace/trace_events_synth.c |  7 ++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7f3e6ca6f0fa..f21e42ddba69 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3137,13 +3137,15 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 				size = min(val->size, STR_VAR_LEN_MAX);
 				strscpy(str, val_str, size);
 			} else {
+				char *stack_start = str + sizeof(unsigned long);
 				int e;
 
-				e = stack_trace_save((void *)str,
+				e = stack_trace_save((void *)stack_start,
 						     HIST_STACKTRACE_DEPTH,
 						     HIST_STACKTRACE_SKIP);
 				if (e < HIST_STACKTRACE_DEPTH - 1)
-					((unsigned long *)str)[e] = 0;
+					((unsigned long *)stack_start)[e] = 0;
+				*((unsigned long *)str) = e;
 			}
 			var_val = (u64)(uintptr_t)str;
 		}
@@ -5135,13 +5137,15 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 					size = min(hist_field->size, STR_VAR_LEN_MAX);
 					strscpy(str, val_str, size);
 				} else {
+					char *stack_start = str + sizeof(unsigned long);
 					int e;
 
-					e = stack_trace_save((void *)str,
+					e = stack_trace_save((void *)stack_start,
 							     HIST_STACKTRACE_DEPTH,
 							     HIST_STACKTRACE_SKIP);
 					if (e < HIST_STACKTRACE_DEPTH - 1)
-						((unsigned long *)str)[e] = 0;
+						((unsigned long *)stack_start)[e] = 0;
+					*((unsigned long *)str) = e;
 				}
 				hist_val = (u64)(uintptr_t)str;
 			}
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 306c89e0ce55..70bddb25d9c0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -538,7 +538,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		val_idx = var_ref_idx[field_pos];
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
-		len = kern_fetch_store_strlen((unsigned long)str_val);
+		if (event->dynamic_fields[i]->is_stack) {
+			len = *((unsigned long *)str_val);
+			len *= sizeof(unsigned long);
+		} else {
+			len = kern_fetch_store_strlen((unsigned long)str_val);
+		}
 
 		fields_size += len;
 	}
-- 
2.39.1
