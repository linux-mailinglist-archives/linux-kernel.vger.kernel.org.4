Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F9738B39
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjFUQas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjFUQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D74B1733
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AA536162A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F12C433CD;
        Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iI-001yoz-2x;
        Wed, 21 Jun 2023 12:29:46 -0400
Message-ID: <20230621162946.729796944@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [for-next][PATCH 12/13] tracing/boot: Replace strlcpy with strscpy
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Azeem Shaikh <azeemshaikh38@gmail.com>

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -E2BIG
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Link: https://lore.kernel.org/linux-trace-kernel/20230613004125.3539934-1-azeemshaikh38@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 778200dd8ede..5fe525f1b8cc 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *tr, struct xbc_node *node)
 
 	/* Common ftrace options */
 	xbc_node_for_each_array_value(node, "options", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, struct xbc_node *node)
 	const char *p;
 
 	xbc_node_for_each_array_value(node, "events", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG) {
 			pr_err("String is too long: %s\n", p);
 			continue;
 		}
@@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	p = xbc_node_find_value(enode, "filter", NULL);
 	if (p && *p != '\0') {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+		if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
 			pr_err("filter string is too long: %s\n", p);
 		else if (apply_event_filter(file, buf) < 0)
 			pr_err("Failed to apply filter: %s\n", buf);
@@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 
 	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
 		xbc_node_for_each_array_value(enode, "actions", anode, p) {
-			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+			if (strscpy(buf, p, ARRAY_SIZE(buf)) == -E2BIG)
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply an action: %s\n", p);
-- 
2.39.2
