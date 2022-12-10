Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC4D648F15
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiLJN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950715A1F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84056B82A86
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51677C433F1;
        Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40My-000knq-1R;
        Sat, 10 Dec 2022 08:58:24 -0500
Message-ID: <20221210135824.309824081@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 07/25] tracing: Add nohitcount option for suppressing display of raw
 hitcount
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Add 'nohitcount' ('NOHC' for short) option for suppressing display of
the raw hitcount column in the histogram.
Note that you must specify at least one value except raw 'hitcount'
when you specify this nohitcount option.

  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=runtime.percent,runtime.graph:sort=pid:NOHC > \
        events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=runtime.percent,runtime.graph:sort=pid:size=2048:nohitcount  [active]
 #

 { pid:          8 }  runtime (%):   3.02  runtime: #
 { pid:         14 }  runtime (%):   2.25  runtime:
 { pid:         16 }  runtime (%):   2.25  runtime:
 { pid:         26 }  runtime (%):   0.17  runtime:
 { pid:         61 }  runtime (%):  11.52  runtime: ####
 { pid:         67 }  runtime (%):   1.56  runtime:
 { pid:         68 }  runtime (%):   0.84  runtime:
 { pid:         76 }  runtime (%):   0.92  runtime:
 { pid:        117 }  runtime (%):   2.50  runtime: #
 { pid:        146 }  runtime (%):  49.88  runtime: ####################
 { pid:        157 }  runtime (%):  16.63  runtime: ######
 { pid:        158 }  runtime (%):   8.38  runtime: ###

Link: https://lore.kernel.org/linux-trace-kernel/166610814787.56030.4980636083486339906.stgit@devnote2

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c             |  3 +++
 kernel/trace/trace_events_hist.c | 34 ++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 55aec4616d8b..948f321b9df1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5678,6 +5678,7 @@ static const char readme_msg[] =
 	"\t            [:size=#entries]\n"
 	"\t            [:pause][:continue][:clear]\n"
 	"\t            [:name=histname1]\n"
+	"\t            [:nohitcount]\n"
 	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
 	"\t    Note, special fields can be used as well:\n"
@@ -5734,6 +5735,8 @@ static const char readme_msg[] =
 	"\t    The 'clear' parameter will clear the contents of a running\n"
 	"\t    hist trigger and leave its current paused/active state\n"
 	"\t    unchanged.\n\n"
+	"\t    The 'nohitcount' (or NOHC) parameter will suppress display of\n"
+	"\t    raw hitcount in the histogram.\n\n"
 	"\t    The enable_hist and disable_hist triggers can be used to\n"
 	"\t    have one event conditionally start and stop another event's\n"
 	"\t    already-attached hist trigger.  The syntax is analogous to\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 946b2b8f0f2c..a0cd118af527 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -69,7 +69,8 @@
 	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"), \
 	C(EXPECT_NUMBER,	"Expecting numeric literal"),		\
 	C(UNARY_MINUS_SUBEXPR,	"Unary minus not supported in sub-expressions"), \
-	C(DIVISION_BY_ZERO,	"Division by zero"),
+	C(DIVISION_BY_ZERO,	"Division by zero"),			\
+	C(NEED_NOHC_VAL,	"Non-hitcount value is required for 'nohitcount'"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -526,6 +527,7 @@ struct hist_trigger_attrs {
 	bool		cont;
 	bool		clear;
 	bool		ts_in_usecs;
+	bool		no_hitcount;
 	unsigned int	map_bits;
 
 	char		*assignment_str[TRACING_MAP_VARS_MAX];
@@ -1550,7 +1552,10 @@ parse_hist_trigger_attrs(struct trace_array *tr, char *trigger_str)
 			ret = parse_assignment(tr, str, attrs);
 			if (ret)
 				goto free;
-		} else if (strcmp(str, "pause") == 0)
+		} else if (strcmp(str, "nohitcount") == 0 ||
+			   strcmp(str, "NOHC") == 0)
+			attrs->no_hitcount = true;
+		else if (strcmp(str, "pause") == 0)
 			attrs->pause = true;
 		else if ((strcmp(str, "cont") == 0) ||
 			 (strcmp(str, "continue") == 0))
@@ -4377,6 +4382,12 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 	if (fields_str && (strcmp(fields_str, "hitcount") != 0))
 		ret = -EINVAL;
  out:
+	/* There is only raw hitcount but nohitcount suppresses it. */
+	if (j == 1 && hist_data->attrs->no_hitcount) {
+		hist_err(hist_data->event_file->tr, HIST_ERR_NEED_NOHC_VAL, 0);
+		ret = -ENOENT;
+	}
+
 	return ret;
 }
 
@@ -5388,13 +5399,13 @@ static void hist_trigger_entry_print(struct seq_file *m,
 
 	hist_trigger_print_key(m, hist_data, key, elt);
 
-	/* At first, show the raw hitcount always */
-	hist_trigger_print_val(m, i, "hitcount", 0, stats, elt);
+	/* At first, show the raw hitcount if !nohitcount */
+	if (!hist_data->attrs->no_hitcount)
+		hist_trigger_print_val(m, i, "hitcount", 0, stats, elt);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
 		flags = hist_data->fields[i]->flags;
-
 		if (flags & HIST_FIELD_FL_VAR || flags & HIST_FIELD_FL_EXPR)
 			continue;
 
@@ -5839,6 +5850,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	struct hist_trigger_data *hist_data = data->private_data;
 	struct hist_field *field;
 	bool have_var = false;
+	bool show_val = false;
 	unsigned int i;
 
 	seq_puts(m, HIST_PREFIX);
@@ -5869,12 +5881,16 @@ static int event_hist_trigger_print(struct seq_file *m,
 			continue;
 		}
 
-		if (i == HITCOUNT_IDX)
+		if (i == HITCOUNT_IDX) {
+			if (hist_data->attrs->no_hitcount)
+				continue;
 			seq_puts(m, "hitcount");
-		else {
-			seq_puts(m, ",");
+		} else {
+			if (show_val)
+				seq_puts(m, ",");
 			hist_field_print(m, field);
 		}
+		show_val = true;
 	}
 
 	if (have_var) {
@@ -5925,6 +5941,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
 	if (hist_data->enable_timestamps)
 		seq_printf(m, ":clock=%s", hist_data->attrs->clock);
+	if (hist_data->attrs->no_hitcount)
+		seq_puts(m, ":nohitcount");
 
 	print_actions_spec(m, hist_data);
 
-- 
2.35.1


