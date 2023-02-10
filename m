Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD4692953
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjBJVdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjBJVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:33:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F581CF9;
        Fri, 10 Feb 2023 13:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BCA61EAC;
        Fri, 10 Feb 2023 21:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49633C433A0;
        Fri, 10 Feb 2023 21:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676064796;
        bh=8Wp51GEJhxkWAv208sw812gEC1Ns3UsGlw8XJXAOBfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RacDxOuoU9ykbZJl9ucZfUqfshpJpkZoDTumdpuwWcjQr8S8HB2GpZPXbPLcVmvpj
         YZ1Jn+b6D5VH0VCCPSloBKsQc1ATaCVMigI/+s2JScily4sPmdIRwThBpK4Jn9zs5f
         hnjptz5tcWoloGXHcpoFsHZ6QdPohOhNjDn1yoZteIb/B8y9t0g8HTrPtoBpCiHxHN
         t885swjR0SDMmh9wUHgcAojmekFxRTtH58rkFevDd4grlwDS1360GvypIB4Qvuewjy
         qDWWS0WFcmCpIThOb8mK7oitnWHHSj61IUqBEeQGGaEB8p757aGso1yyX8tfB6E9mE
         KxjwiAmgmBwiA==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org,
        zwisler@google.com, chinglinyu@google.com
Subject: [PATCH 2/4] tracing/histogram: Fix a few problems with stacktrace variable printing
Date:   Fri, 10 Feb 2023 15:33:04 -0600
Message-Id: <60bebd4e546728e012a7a2bcbf58716d48ba6edb.1676063532.git.zanussi@kernel.org>
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

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 76bd105988c6..a58380702491 100644
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
@@ -5334,7 +5337,10 @@ static void hist_trigger_print_key(struct seq_file *m,
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
@@ -5879,7 +5885,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 
 	if (hist_field->flags) {
 		if (!(hist_field->flags & HIST_FIELD_FL_VAR_REF) &&
-		    !(hist_field->flags & HIST_FIELD_FL_EXPR)) {
+		    !(hist_field->flags & HIST_FIELD_FL_EXPR) &&
+		    !(hist_field->flags & HIST_FIELD_FL_STACKTRACE)) {
 			const char *flags = get_hist_field_flags(hist_field);
 
 			if (flags)
@@ -5912,9 +5919,12 @@ static int event_hist_trigger_print(struct seq_file *m,
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
2.34.1

