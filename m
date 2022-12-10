Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81397648F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiLJN7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B2616599
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 478A7B82A81
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080F2C4339B;
        Sat, 10 Dec 2022 13:58:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40Mx-000kmO-39;
        Sat, 10 Dec 2022 08:58:23 -0500
Message-ID: <20221210135823.843880038@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:57:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 04/25] tracing: Allow multiple hitcount values in histograms
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

From: Tom Zanussi <zanussi@kernel.org>

The hitcount is treated specially in the histograms - since it's
always expected to be there regardless of whether the user specified
anything or not, it's always added as the first histogram value.

Currently the code doesn't allow it to be added more than once as a
value, which is inconsistent with all the other possible values.  It
would seem to be a pointless thing to want to do, but other features
being added such as percent and graph modifiers don't work properly
with the current hitcount restrictions.

Fix this by allowing multiple hitcounts to be added.

Link: https://lore.kernel.org/linux-trace-kernel/166610812248.56030.16754785928712505251.stgit@devnote2

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1c82478e8dff..31d58ddcc1d9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1356,6 +1356,8 @@ static const char *hist_field_name(struct hist_field *field,
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
 		field_name = "common_timestamp";
+	else if (field->flags & HIST_FIELD_FL_HITCOUNT)
+		field_name = "hitcount";
 
 	if (field_name == NULL)
 		field_name = "";
@@ -2328,6 +2330,8 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			hist_data->attrs->ts_in_usecs = true;
 	} else if (strcmp(field_name, "common_cpu") == 0)
 		*flags |= HIST_FIELD_FL_CPU;
+	else if (strcmp(field_name, "hitcount") == 0)
+		*flags |= HIST_FIELD_FL_HITCOUNT;
 	else {
 		field = trace_find_event_field(file->event_call, field_name);
 		if (!field || !field->size) {
@@ -4328,8 +4332,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 static int create_val_fields(struct hist_trigger_data *hist_data,
 			     struct trace_event_file *file)
 {
+	unsigned int i, j = 1, n_hitcount = 0;
 	char *fields_str, *field_str;
-	unsigned int i, j = 1;
 	int ret;
 
 	ret = create_hitcount_val(hist_data);
@@ -4346,8 +4350,10 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
 		if (!field_str)
 			break;
 
-		if (strcmp(field_str, "hitcount") == 0)
-			continue;
+		if (strcmp(field_str, "hitcount") == 0) {
+			if (!n_hitcount++)
+				continue;
+		}
 
 		ret = create_val_field(hist_data, j++, file, field_str);
 		if (ret)
-- 
2.35.1


