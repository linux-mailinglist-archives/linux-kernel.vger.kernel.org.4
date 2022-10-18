Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AEF603008
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJRPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiJRPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:49:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A2C97D6;
        Tue, 18 Oct 2022 08:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567A8615E1;
        Tue, 18 Oct 2022 15:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7B0C433D7;
        Tue, 18 Oct 2022 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108150;
        bh=cLjL2m5ZM1Avq6VanJIjfB0auwkZC9i9cNAbWUKDzpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+Iyk2p3Qe4BS7WDPbsAdnQs6XNVOvn13FBhhVWHtYkScEX9vkUKig0FuW2c1icAq
         krEwn/fE8rnAgPH/1iHg4lrDBr7zs31w7oz14UfmOSGgJzfAitSe/1EIZcZFtZLWh5
         bYSbmed5vJ6dXYjUcbRN+bSvrA3L0ojSvw7GX9HleXPCQnFJe0dw0I3GeuldhUzhac
         TkQ23iO5YRtSrPu2meD7jW8QdKXYVw4/Rz/JBaBP70S1DM/J8F8UAPdqKKrNrA0A/a
         fvphMwC/iSeZHapbk3Y/QgrXwaXnQBEatxAbxB/A72HkRdu0LqzYyItwCq6SOWYua2
         are8pWPYxmTKA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] tracing: Add nohitcount option for suppressing display of raw hitcount
Date:   Wed, 19 Oct 2022 00:49:08 +0900
Message-Id: <166610814787.56030.4980636083486339906.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <166610811353.56030.10023036046735082272.stgit@devnote2>
References: <166610811353.56030.10023036046735082272.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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


Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c             |    3 +++
 kernel/trace/trace_events_hist.c |   34 ++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 98936d951aaa..feac58307684 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5669,6 +5669,7 @@ static const char readme_msg[] =
 	"\t            [:size=#entries]\n"
 	"\t            [:pause][:continue][:clear]\n"
 	"\t            [:name=histname1]\n"
+	"\t            [:nohitcount]\n"
 	"\t            [:<handler>.<action>]\n"
 	"\t            [if <filter>]\n\n"
 	"\t    Note, special fields can be used as well:\n"
@@ -5725,6 +5726,8 @@ static const char readme_msg[] =
 	"\t    The 'clear' parameter will clear the contents of a running\n"
 	"\t    hist trigger and leave its current paused/active state\n"
 	"\t    unchanged.\n\n"
+	"\t    The 'nohitcount' (or NOHC) parameter will suppress display of\n"
+	"\t    raw hitcount in the histogram.\n\n"
 	"\t    The enable_hist and disable_hist triggers can be used to\n"
 	"\t    have one event conditionally start and stop another event's\n"
 	"\t    already-attached hist trigger.  The syntax is analogous to\n"
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f7d77fba91d7..125d68718bad 100644
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
 
@@ -5385,13 +5396,13 @@ static void hist_trigger_entry_print(struct seq_file *m,
 
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
 
@@ -5836,6 +5847,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 	struct hist_trigger_data *hist_data = data->private_data;
 	struct hist_field *field;
 	bool have_var = false;
+	bool show_val = false;
 	unsigned int i;
 
 	seq_puts(m, HIST_PREFIX);
@@ -5866,12 +5878,16 @@ static int event_hist_trigger_print(struct seq_file *m,
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
@@ -5922,6 +5938,8 @@ static int event_hist_trigger_print(struct seq_file *m,
 	seq_printf(m, ":size=%u", (1 << hist_data->map->map_bits));
 	if (hist_data->enable_timestamps)
 		seq_printf(m, ":clock=%s", hist_data->attrs->clock);
+	if (hist_data->attrs->no_hitcount)
+		seq_puts(m, ":nohitcount");
 
 	print_actions_spec(m, hist_data);
 

