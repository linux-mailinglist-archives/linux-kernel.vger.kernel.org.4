Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4996570EB21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbjEXCLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjEXCL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE7913E;
        Tue, 23 May 2023 19:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8ACB637ED;
        Wed, 24 May 2023 02:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC7C433EF;
        Wed, 24 May 2023 02:11:21 +0000 (UTC)
Date:   Tue, 23 May 2023 22:11:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] tracing/histograms: Allow variables to have some modifiers
Message-ID: <20230523221108.064a5d82@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Modifiers are used to change the behavior of keys. For instance, they
can grouped into buckets, converted to syscall names (from the syscall
identifier), show task->comm of the current pid, be an array of longs
that represent a stacktrace, and more.

It was found that nothing stopped a value from taking a modifier. As
values are simple counters. If this happened, it would call code that
was not expecting a modifier and crash the kernel. This was fixed by
having the ___create_val_field() function test if a modifier was present
and fail if one was. This fixed the crash.

Now there's a problem with variables. Variables are used to pass fields
from one event to another. Variables are allowed to have some modifiers,
as the processing may need to happen at the time of the event (like
stacktraces and comm names of the current pid). The issue is that it too
uses __create_val_field(). Now that fails on modifiers, variables can no
longer use them (this is a regression).

As not all modifiers are for variables, have them use a separate check.

Cc: stable@vger.kernel.org
Fixes: e0213434fe3e4 ("tracing: Do not let histogram values have some modifiers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 486cca3c2b75..543cb7dc84ad 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4238,13 +4238,19 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	/* Some types cannot be a value */
-	if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
-				 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
-				 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
-				 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE)) {
-		hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
-		ret = -EINVAL;
+	/* values and variables should not have some modifiers */
+	if (hist_field->flags & HIST_FIELD_FL_VAR) {
+		/* Variable */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2))
+			goto err;
+	} else {
+		/* Value */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
+					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
+			goto err;
 	}
 
 	hist_data->fields[val_idx] = hist_field;
@@ -4256,6 +4262,9 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		ret = -EINVAL;
  out:
 	return ret;
+ err:
+	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+	return -EINVAL;
 }
 
 static int create_val_field(struct hist_trigger_data *hist_data,
-- 
2.39.2

