Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3785EC8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiI0QCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiI0QBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:01:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34021B95F8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AAD7B81C62
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A81C433D6;
        Tue, 27 Sep 2022 16:01:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1odD2i-00G2rC-2o;
        Tue, 27 Sep 2022 12:02:44 -0400
Message-ID: <20220927160244.410510528@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Sep 2022 12:02:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 07/20] tracing: Move struct filter_pred into trace_events_filter.c
References: <20220927160216.349640304@goodmis.org>
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

The structure filter_pred and the typedef of the function used are only
referenced by trace_events_filter.c. There's no reason to have it in an
external header file. Move them into the only file they are used in.

Link: https://lkml.kernel.org/r/20220906225529.598047132@goodmis.org

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h               | 13 -------------
 kernel/trace/trace_events_filter.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 900e75d96c84..54ee5711c729 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1435,8 +1435,6 @@ event_trigger_unlock_commit(struct trace_event_file *file,
 struct filter_pred;
 struct regex;
 
-typedef int (*filter_pred_fn_t) (struct filter_pred *pred, void *event);
-
 typedef int (*regex_match_func)(char *str, struct regex *r, int len);
 
 enum regex_type {
@@ -1455,17 +1453,6 @@ struct regex {
 	regex_match_func	match;
 };
 
-struct filter_pred {
-	filter_pred_fn_t 	fn;
-	u64 			val;
-	struct regex		regex;
-	unsigned short		*ops;
-	struct ftrace_event_field *field;
-	int 			offset;
-	int			not;
-	int 			op;
-};
-
 static inline bool is_string_field(struct ftrace_event_field *field)
 {
 	return field->filter_type == FILTER_DYN_STRING ||
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 4b1057ab9d96..c49c689ce4ad 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -43,6 +43,19 @@ enum filter_op_ids { OPS };
 
 static const char * ops[] = { OPS };
 
+typedef int (*filter_pred_fn_t) (struct filter_pred *pred, void *event);
+
+struct filter_pred {
+	filter_pred_fn_t 	fn;
+	u64 			val;
+	struct regex		regex;
+	unsigned short		*ops;
+	struct ftrace_event_field *field;
+	int 			offset;
+	int			not;
+	int 			op;
+};
+
 /*
  * pred functions are OP_LE, OP_LT, OP_GE, OP_GT, and OP_BAND
  * pred_funcs_##type below must match the order of them above.
-- 
2.35.1
