Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034EA66D56B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjAQElc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjAQElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:41:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DA223102;
        Mon, 16 Jan 2023 20:41:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BD5FB80DFA;
        Tue, 17 Jan 2023 04:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1365EC433D2;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHdmP-001rsA-0I;
        Mon, 16 Jan 2023 23:41:01 -0500
Message-ID: <20230117044100.962605301@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 23:40:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 2/5] tracing: Allow stacktraces to be saved as histogram variables
References: <20230117044010.838685230@goodmis.org>
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

Allow to save stacktraces into a histogram variable. This will be used by
synthetic events to allow a stacktrace from one event to be passed and
displayed by another event.

The special keyword "stacktrace" is to be used to trigger a stack
trace for the event that the histogram trigger is attached to.

  echo 'hist:keys=pid:st=stacktrace" > events/sched/sched_waking/trigger

Currently nothing can get access to the "$st" variable above that contains
the stack trace, but that will soon change.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 35 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fcaf226b7744..5cc7873983ee 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1360,6 +1360,8 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_STACKTRACE)
+		field_name = "stacktrace";
 	else if (field->flags & HIST_FIELD_FL_HITCOUNT)
 		field_name = "hitcount";
 
@@ -1980,6 +1982,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 
 	if (flags & HIST_FIELD_FL_STACKTRACE) {
 		hist_field->fn_num = HIST_FIELD_FN_NOP;
+		hist_field->size = HIST_STACKTRACE_SIZE;
+		hist_field->type = kstrdup_const("unsigned long[]", GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
 		goto out;
 	}
 
@@ -2349,6 +2355,8 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		hist_data->enable_timestamps = true;
 		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 			hist_data->attrs->ts_in_usecs = true;
+	} else if (strcmp(field_name, "stacktrace") == 0) {
+		*flags |= HIST_FIELD_FL_STACKTRACE;
 	} else if (strcmp(field_name, "common_cpu") == 0)
 		*flags |= HIST_FIELD_FL_CPU;
 	else if (strcmp(field_name, "hitcount") == 0)
@@ -3822,7 +3830,8 @@ static void save_field_var(struct hist_trigger_data *hist_data,
 {
 	hist_data->field_vars[hist_data->n_field_vars++] = field_var;
 
-	if (field_var->val->flags & HIST_FIELD_FL_STRING)
+	/* Stack traces are saved in the string storage too */
+	if (field_var->val->flags & (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE))
 		hist_data->n_field_var_str++;
 }
 
@@ -4101,7 +4110,8 @@ static int action_create(struct hist_trigger_data *hist_data,
 			}
 
 			hist_data->save_vars[hist_data->n_save_vars++] = field_var;
-			if (field_var->val->flags & HIST_FIELD_FL_STRING)
+			if (field_var->val->flags &
+			    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE))
 				hist_data->n_save_var_str++;
 			kfree(param);
 		}
@@ -4349,7 +4359,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
 		update_var_execname(hist_data->fields[val_idx]);
 
-	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
+	if (!ret && hist_data->fields[val_idx]->flags &
+	    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE))
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
 	return ret;
@@ -5090,7 +5101,8 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
-			if (hist_field->flags & HIST_FIELD_FL_STRING) {
+			if (hist_field->flags &
+			    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE)) {
 				unsigned int str_start, var_str_idx, idx;
 				char *str, *val_str;
 				unsigned int size;
@@ -5103,9 +5115,18 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 				str = elt_data->field_var_str[idx];
 				val_str = (char *)(uintptr_t)hist_val;
 
-				size = min(hist_field->size, STR_VAR_LEN_MAX);
-				strscpy(str, val_str, size);
-
+				if (hist_field->flags & HIST_FIELD_FL_STRING) {
+					size = min(hist_field->size, STR_VAR_LEN_MAX);
+					strscpy(str, val_str, size);
+				} else {
+					int e;
+
+					e = stack_trace_save((void *)str,
+							     HIST_STACKTRACE_DEPTH,
+							     HIST_STACKTRACE_SKIP);
+					if (e < HIST_STACKTRACE_DEPTH - 1)
+						((unsigned long *)str)[e] = 0;
+				}
 				hist_val = (u64)(uintptr_t)str;
 			}
 			tracing_map_set_var(elt, var_idx, hist_val);
-- 
2.39.0


