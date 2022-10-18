Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BB0603002
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiJRPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiJRPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:48:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25719C90EA;
        Tue, 18 Oct 2022 08:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3607B81BE1;
        Tue, 18 Oct 2022 15:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6ADC433C1;
        Tue, 18 Oct 2022 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108125;
        bh=2ROdDPNbkFZUsLCIXz9ZIZxzJTpDkAw3NJo5QjtUD+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/EheRqfRv/1URudhZBXzJRo1igQEFEg/nwqbGKtUxFv8xYsfwCVtiL/+oNk/QhCO
         vxhdjFff8eyT5h0n+jBkQTFcIaJY3fgEcCUOzz5hsz7ZUCFivXdX5gqFz17qS0lIwT
         iWV9tlacEAwbGA6uZS/SOVHiGIRHPNvDxaVIYE1SBBRlLk3hxOQANRWvmxKwEUL1vA
         dWN1hXDvBZmYCFip4g/RhFK8w86F7NTlyvRNc0G+/hYpN1beLQFGPpqSp0yQ38BwQp
         FhSijjnOJglVwe9yPFUU5Yrqko0BGtPXGZp2wLDmKD+LX+GPZ7WE/fmC5m6rPzjTem
         5ZcWk03WtNSyg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] tracing: Allow multiple hitcount values in histograms
Date:   Wed, 19 Oct 2022 00:48:42 +0900
Message-Id: <166610812248.56030.16754785928712505251.stgit@devnote2>
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

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 48465f7e97b4..13bb7ec45836 100644
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

