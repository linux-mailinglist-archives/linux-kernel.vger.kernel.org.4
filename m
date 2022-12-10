Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF90648F19
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLJOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLJN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AEF18391
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 429C6CE1E88
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44169C433F0;
        Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40My-000knM-0w;
        Sat, 10 Dec 2022 08:58:24 -0500
Message-ID: <20221210135824.151436116@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 06/25] tracing: Add .graph suffix option to histogram value
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

Add the .graph suffix which shows the bar graph of the histogram value.

For example, the below example shows that the bar graph
of the histogram of the runtime for each tasks.

------
  # cd /sys/kernel/debug/tracing/
  # echo hist:keys=pid:vals=runtime.graph:sort=pid > \
   events/sched/sched_stat_runtime/trigger
  # sleep 10
  # cat events/sched/sched_stat_runtime/hist
 # event histogram
 #
 # trigger info: hist:keys=pid:vals=hitcount,runtime.graph:sort=pid:size=2048 [active]
 #

 { pid:         14 } hitcount:          2  runtime:
 { pid:         16 } hitcount:          8  runtime:
 { pid:         26 } hitcount:          1  runtime:
 { pid:         57 } hitcount:          3  runtime:
 { pid:         61 } hitcount:         20  runtime: ###
 { pid:         66 } hitcount:          2  runtime:
 { pid:         70 } hitcount:          3  runtime:
 { pid:         72 } hitcount:          2  runtime:
 { pid:        145 } hitcount:         14  runtime: ####################
 { pid:        152 } hitcount:          5  runtime: #######
 { pid:        153 } hitcount:          2  runtime: ####

 Totals:
     Hits: 62
     Entries: 11
     Dropped: 0
-------

Link: https://lore.kernel.org/linux-trace-kernel/166610813953.56030.10944148382315789485.stgit@devnote2

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c             |  3 +-
 kernel/trace/trace_events_hist.c | 77 +++++++++++++++++++++++++-------
 2 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 08e9568849b1..55aec4616d8b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5725,7 +5725,8 @@ static const char readme_msg[] =
 	"\t            .log2       display log2 value rather than raw number\n"
 	"\t            .buckets=size  display values in groups of size rather than raw number\n"
 	"\t            .usecs      display a common_timestamp in microseconds\n"
-	"\t            .percent    display a number of percentage value\n\n"
+	"\t            .percent    display a number of percentage value\n"
+	"\t            .graph      display a bar-graph of a value\n\n"
 	"\t    The 'pause' parameter can be used to pause an existing hist\n"
 	"\t    trigger or to start a hist trigger but not log any events\n"
 	"\t    until told to do so.  'continue' can be used to start or\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 35b0e956f06e..946b2b8f0f2c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -507,6 +507,7 @@ enum hist_field_flags {
 	HIST_FIELD_FL_BUCKET		= 1 << 17,
 	HIST_FIELD_FL_CONST		= 1 << 18,
 	HIST_FIELD_FL_PERCENT		= 1 << 19,
+	HIST_FIELD_FL_GRAPH		= 1 << 20,
 };
 
 struct var_defs {
@@ -1710,6 +1711,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "usecs";
 	else if (hist_field->flags & HIST_FIELD_FL_PERCENT)
 		flags_str = "percent";
+	else if (hist_field->flags & HIST_FIELD_FL_GRAPH)
+		flags_str = "graph";
 
 	return flags_str;
 }
@@ -2322,6 +2325,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
 				goto error;
 			*flags |= HIST_FIELD_FL_PERCENT;
+		} else if (strncmp(modifier, "graph", 5) == 0) {
+			if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
+				goto error;
+			*flags |= HIST_FIELD_FL_GRAPH;
 		} else {
  error:
 			hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
@@ -5316,20 +5323,52 @@ static inline unsigned int __get_percentage(u64 val, u64 total)
 	return val ? UINT_MAX : 0;
 }
 
+#define BAR_CHAR '#'
+
+static inline const char *__fill_bar_str(char *buf, int size, u64 val, u64 max)
+{
+	unsigned int len = __get_percentage(val, max);
+	int i;
+
+	if (len == UINT_MAX) {
+		snprintf(buf, size, "[ERROR]");
+		return buf;
+	}
+
+	len = len * size / 10000;
+	for (i = 0; i < len && i < size; i++)
+		buf[i] = BAR_CHAR;
+	while (i < size)
+		buf[i++] = ' ';
+	buf[size] = '\0';
+
+	return buf;
+}
+
+struct hist_val_stat {
+	u64 max;
+	u64 total;
+};
+
 static void hist_trigger_print_val(struct seq_file *m, unsigned int idx,
 				   const char *field_name, unsigned long flags,
-				   u64 *totals, struct tracing_map_elt *elt)
+				   struct hist_val_stat *stats,
+				   struct tracing_map_elt *elt)
 {
 	u64 val = tracing_map_read_sum(elt, idx);
 	unsigned int pc;
+	char bar[21];
 
 	if (flags & HIST_FIELD_FL_PERCENT) {
-		pc = __get_percentage(val, totals[idx]);
+		pc = __get_percentage(val, stats[idx].total);
 		if (pc == UINT_MAX)
 			seq_printf(m, " %s (%%):[ERROR]", field_name);
 		else
 			seq_printf(m, " %s (%%): %3u.%02u", field_name,
 					pc / 100, pc % 100);
+	} else if (flags & HIST_FIELD_FL_GRAPH) {
+		seq_printf(m, " %s: %20s", field_name,
+			   __fill_bar_str(bar, 20, val, stats[idx].max));
 	} else if (flags & HIST_FIELD_FL_HEX) {
 		seq_printf(m, " %s: %10llx", field_name, val);
 	} else {
@@ -5339,7 +5378,7 @@ static void hist_trigger_print_val(struct seq_file *m, unsigned int idx,
 
 static void hist_trigger_entry_print(struct seq_file *m,
 				     struct hist_trigger_data *hist_data,
-				     u64 *totals,
+				     struct hist_val_stat *stats,
 				     void *key,
 				     struct tracing_map_elt *elt)
 {
@@ -5350,7 +5389,7 @@ static void hist_trigger_entry_print(struct seq_file *m,
 	hist_trigger_print_key(m, hist_data, key, elt);
 
 	/* At first, show the raw hitcount always */
-	hist_trigger_print_val(m, i, "hitcount", 0, totals, elt);
+	hist_trigger_print_val(m, i, "hitcount", 0, stats, elt);
 
 	for (i = 1; i < hist_data->n_vals; i++) {
 		field_name = hist_field_name(hist_data->fields[i], 0);
@@ -5360,7 +5399,7 @@ static void hist_trigger_entry_print(struct seq_file *m,
 			continue;
 
 		seq_puts(m, " ");
-		hist_trigger_print_val(m, i, field_name, flags, totals, elt);
+		hist_trigger_print_val(m, i, field_name, flags, stats, elt);
 	}
 
 	print_actions(m, hist_data, elt);
@@ -5374,7 +5413,8 @@ static int print_entries(struct seq_file *m,
 	struct tracing_map_sort_entry **sort_entries = NULL;
 	struct tracing_map *map = hist_data->map;
 	int i, j, n_entries;
-	u64 *totals = NULL;
+	struct hist_val_stat *stats = NULL;
+	u64 val;
 
 	n_entries = tracing_map_sort_entries(map, hist_data->sort_keys,
 					     hist_data->n_sort_keys,
@@ -5382,28 +5422,33 @@ static int print_entries(struct seq_file *m,
 	if (n_entries < 0)
 		return n_entries;
 
+	/* Calculate the max and the total for each field if needed. */
 	for (j = 0; j < hist_data->n_vals; j++) {
-		if (!(hist_data->fields[j]->flags & HIST_FIELD_FL_PERCENT))
+		if (!(hist_data->fields[j]->flags &
+			(HIST_FIELD_FL_PERCENT | HIST_FIELD_FL_GRAPH)))
 			continue;
-		if (!totals) {
-			totals = kcalloc(hist_data->n_vals, sizeof(u64),
-					 GFP_KERNEL);
-			if (!totals) {
+		if (!stats) {
+			stats = kcalloc(hist_data->n_vals, sizeof(*stats),
+				       GFP_KERNEL);
+			if (!stats) {
 				n_entries = -ENOMEM;
 				goto out;
 			}
 		}
-		for (i = 0; i < n_entries; i++)
-			totals[j] += tracing_map_read_sum(
-					sort_entries[i]->elt, j);
+		for (i = 0; i < n_entries; i++) {
+			val = tracing_map_read_sum(sort_entries[i]->elt, j);
+			stats[j].total += val;
+			if (stats[j].max < val)
+				stats[j].max = val;
+		}
 	}
 
 	for (i = 0; i < n_entries; i++)
-		hist_trigger_entry_print(m, hist_data, totals,
+		hist_trigger_entry_print(m, hist_data, stats,
 					 sort_entries[i]->key,
 					 sort_entries[i]->elt);
 
-	kfree(totals);
+	kfree(stats);
 out:
 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
 
-- 
2.35.1


