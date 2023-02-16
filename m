Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACABF699D21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBPTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBPTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:45:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA550349;
        Thu, 16 Feb 2023 11:45:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9F260ACA;
        Thu, 16 Feb 2023 19:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D52C433EF;
        Thu, 16 Feb 2023 19:45:22 +0000 (UTC)
Date:   Thu, 16 Feb 2023 14:45:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: PATCH] tracing: Add BUILD_BUG() to make sure stacktrace fits in 
 strings
Message-ID: <20230216144520.07f4aebf@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The max string length for a histogram variable is 256 bytes. The max depth
of a stacktrace is 16. With 8byte words, that's 16 * 8 = 128. Which can
easily fit in the string variable. The histogram stacktrace is being
stored in the string value (with the given max length), with the
assumption it will fit. To make sure that this is always the case (in the
case that the stack trace depth increases), add a BUILD_BUG_ON() to test
this.

Link: https://lore.kernel.org/linux-trace-kernel/20230214002418.0103b9e765d3e5c374d2aa7d@kernel.org/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
[ Note this is on top of:
  https://patchwork.kernel.org/project/linux-trace-kernel/patch/1ed6906cd9d6477ef2bd8e63c61de20a9ffe64d7.1676063532.git.zanussi@kernel.org/
 ]
 kernel/trace/trace_events_hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f21e42ddba69..6cef1def1da5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3119,6 +3119,9 @@ static inline void __update_field_vars(struct tracing_map_elt *elt,
 	unsigned int i, j, var_idx;
 	u64 var_val;
 
+	/* Make sure stacktrace can fit in the string variable length */
+	BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) >= STR_VAR_LEN_MAX);
+
 	for (i = 0, j = field_var_str_start; i < n_field_vars; i++) {
 		struct field_var *field_var = field_vars[i];
 		struct hist_field *var = field_var->var;
-- 
2.39.1

