Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD99B69A324
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBQAvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjBQAu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD306582AC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:50:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ACE6B82AC1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6AAC4339E;
        Fri, 17 Feb 2023 00:50:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pSoxT-000qNi-0A;
        Thu, 16 Feb 2023 19:50:39 -0500
Message-ID: <20230217005038.870067215@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 16 Feb 2023 19:49:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 3/5] tracing/histogram: Fix a few problems with stacktrace variable
 printing
References: <20230217004954.719324747@goodmis.org>
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

From: Tom Zanussi <zanussi@kernel.org>

Currently, there are a few problems when printing hist triggers and
trace output when using stacktrace variables.  This fixes the problems
seen below:

  # echo 'hist:keys=delta.buckets=100,stack.stacktrace:sort=delta' > /sys/kernel/debug/tracing/events/synthetic/block_lat/trigger
  # cat /sys/kernel/debug/tracing/events/synthetic/block_lat/trigger
  hist:keys=delta.buckets=100,stacktrace:vals=hitcount:sort=delta.buckets=100:size=2048 [active]

  # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 2' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  # cat /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
  hist:keys=next_pid:vals=hitcount:ts=common_timestamp.usecs,st=stacktrace.stacktrace:sort=hitcount:size=2048:clock=global if prev_state == 2 [active]

and also in the trace output (should be stack.stacktrace):

  {  delta: ~ 100-199, stacktrace         __schedule+0xa19/0x1520

Link: https://lkml.kernel.org/r/60bebd4e546728e012a7a2bcbf58716d48ba6edb.1676063532.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6cef1def1da5..c4f1fe985f6f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1356,9 +1356,12 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
-	else if (field->flags & HIST_FIELD_FL_STACKTRACE)
-		field_name = "stacktrace";
-	else if (field->flags & HIST_FIELD_FL_HITCOUNT)
+	else if (field->flags & HIST_FIELD_FL_STACKTRACE) {
+		if (field->field)
+			field_name = field->field->name;
+		else
+			field_name = "stacktrace";
+	} else if (field->flags & HIST_FIELD_FL_HITCOUNT)
 		field_name = "hitcount";
 
 	if (field_name == NULL)
@@ -5339,7 +5342,10 @@ static void hist_trigger_print_key(struct seq_file *m,
 			seq_printf(m, "%s: %-30s[%3llu]", field_name,
 				   syscall_name, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
-			seq_puts(m, "stacktrace:\n");
+			if (key_field->field)
+				seq_printf(m, "%s.stacktrace", key_field->field->name);
+			else
+				seq_puts(m, "stacktrace:\n");
 			hist_trigger_stacktrace_print(m,
 						      key + key_field->offset,
 						      HIST_STACKTRACE_DEPTH);
@@ -5884,7 +5890,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags) {
 		if (!(hist_field->flags & HIST_FIELD_FL_VAR_REF) &&
-		    !(hist_field->flags & HIST_FIELD_FL_EXPR)) {
+		    !(hist_field->flags & HIST_FIELD_FL_EXPR) &&
+		    !(hist_field->flags & HIST_FIELD_FL_STACKTRACE)) {
 			const char *flags = get_hist_field_flags(hist_field);
 
 			if (flags)
@@ -5917,9 +5924,12 @@ static int event_hist_trigger_print(struct seq_file *m,
 		if (i > hist_data->n_vals)
 			seq_puts(m, ",");
 
-		if (field->flags & HIST_FIELD_FL_STACKTRACE)
-			seq_puts(m, "stacktrace");
-		else
+		if (field->flags & HIST_FIELD_FL_STACKTRACE) {
+			if (field->field)
+				seq_printf(m, "%s.stacktrace", field->field->name);
+			else
+				seq_puts(m, "stacktrace");
+		} else
 			hist_field_print(m, field);
 	}
 
-- 
2.39.1
