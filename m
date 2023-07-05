Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427527486C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjGEOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjGEOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEDF10D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB66F615C9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D96BC433C8;
        Wed,  5 Jul 2023 14:46:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qH3m4-003PiJ-1Y;
        Wed, 05 Jul 2023 10:46:32 -0400
Message-ID: <20230705144632.294731621@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 05 Jul 2023 10:40:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [for-linus][PATCH 3/3] tracing/boot: Test strscpy() against less than zero for error
References: <20230705144031.702796304@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of checking for -E2BIG, it is better to just check for less than
zero of strscpy() for error. Testing for -E2BIG is not very robust, and
the calling code does not really care about the error code, just that
there was an error.

One of the updates to convert strlcpy() to strscpy() had a v2 version
that changed the test from testing against -E2BIG to less than zero, but I
took the v1 version that still tested for -E2BIG.

Link: https://lore.kernel.org/linux-trace-kernel/20230615180420.400769-1-azeemshaikh38@gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230704100807.707d1605@rorschach.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 5fe525f1b8cc..7ccc7a8e155b 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 
 	/* Common ftrace options */
 	xbc_node_for_each_array_value(node, "options", anode, p) {
-		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	const char *p;
 
 	xbc_node_for_each_array_value(node, "events", anode, p) {
-		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	p = xbc_node_find_value(enode, "filter", NULL);
 	if (p && *p != '\0') {
-		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
 			pr_err("filter string is too long: %s\n", p);
 		else if (apply_event_filter(file, buf) < 0)
 			pr_err("Failed to apply filter: %s\n", buf);
@@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
 		xbc_node_for_each_array_value(enode, "actions", anode, p) {
-			if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
+			if (strscpy(buf, p, ARRAY_SIZE(buf)) < 0)
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
-- 
2.39.2
