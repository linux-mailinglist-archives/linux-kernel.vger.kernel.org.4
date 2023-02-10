Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C65692952
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjBJVdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjBJVdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53681CE7;
        Fri, 10 Feb 2023 13:33:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B75F61EB0;
        Fri, 10 Feb 2023 21:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2AEC4339B;
        Fri, 10 Feb 2023 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676064795;
        bh=Q+mebY4c3zacwP7iUcduIJ55Eb1P+wduM9Mf8TUntHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9pU2S78+U+gZL7D3AKlX4gDAtMTXPiXRcu4Q9p5d2UyenduaIpDmvjMaiDXhPp6b
         Un8mra23/uOYi+nv1kIzOgljgCFrXAOdhdoeIZrVRzU+aT9vx1rf58iSG+EDht5Wk2
         w+M52S4Lwq7zjYkiEQQYw2fWj4HKxb07h/+kcNuZKUNI3NaDU5mAJAdhFKU0KMUi/F
         nLjtpSxs1gWeo6AdXs2hCewduhNm4SUfRY1AVMeXv0w9MsD0FfOp3rE+rQYx95ZEwp
         BTtYoiveqt3MS+q0ssy1Al5S1bJM9R81IuHWi//U/mBIXD4Dm5P8+u5xyrVOt+EdHG
         52E2rRdhlZhkQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org,
        zwisler@google.com, chinglinyu@google.com
Subject: [PATCH 1/4] tracing/histogram: Don't use strlen to find length of stacktrace variables
Date:   Fri, 10 Feb 2023 15:33:03 -0600
Message-Id: <1ed6906cd9d6477ef2bd8e63c61de20a9ffe64d7.1676063532.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676063532.git.zanussi@kernel.org>
References: <cover.1676063532.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because stacktraces are saved in dynamic strings,
trace_event_raw_event_synth() uses strlen to determine the length of
the stack.  Stacktraces may contain 0-bytes, though, in the saved
addresses, so the length found and passed to reserve() will be too
small.

Fix this by using the first unsigned long in the stack variables to
store the actual number of elements in the stack and have
trace_event_raw_event_synth() use that to determine the length of the
stack.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c  | 12 ++++++++----
 kernel/trace/trace_events_synth.c |  7 ++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 888b7a394ce5..76bd105988c6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3135,13 +3135,15 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
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
@@ -5133,13 +5135,15 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
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
index d458d7a0dfd7..6209b23c863f 100644
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
2.34.1

