Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276864CBC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiLNOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiLNOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:02:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8DA11C21
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:02:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7AEFB818D3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8641EC433A7;
        Wed, 14 Dec 2022 14:02:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p5SKn-000gvm-24;
        Wed, 14 Dec 2022 09:02:09 -0500
Message-ID: <20221214140209.502652192@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Dec 2022 09:01:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [for-next][PATCH 7/8] tracing: Improve panic/die notifiers
References: <20221214140133.608431204@goodmis.org>
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

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

Currently the tracing dump_on_oops feature is implemented through
separate notifiers, one for die/oops and the other for panic;
given they have the same functionality, let's unify them.

Also improve the function comment and change the priority of the
notifier to make it execute earlier, avoiding showing useless trace
data (like the callback names for the other notifiers); finally,
we also removed an unnecessary header inclusion.

Link: https://lkml.kernel.org/r/20220819221731.480795-7-gpiccoli@igalia.com

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 55 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 548890c7c0f5..6d7ef130f57e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -19,7 +19,6 @@
 #include <linux/kallsyms.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
-#include <linux/notifier.h>
 #include <linux/irqflags.h>
 #include <linux/debugfs.h>
 #include <linux/tracefs.h>
@@ -9876,40 +9875,40 @@ static __init int tracer_init_tracefs(void)
 
 fs_initcall(tracer_init_tracefs);
 
-static int trace_panic_handler(struct notifier_block *this,
-			       unsigned long event, void *unused)
-{
-	if (ftrace_dump_on_oops)
-		ftrace_dump(ftrace_dump_on_oops);
-	return NOTIFY_OK;
-}
+static int trace_die_panic_handler(struct notifier_block *self,
+				unsigned long ev, void *unused);
 
 static struct notifier_block trace_panic_notifier = {
-	.notifier_call  = trace_panic_handler,
-	.next           = NULL,
-	.priority       = 150   /* priority: INT_MAX >= x >= 0 */
+	.notifier_call = trace_die_panic_handler,
+	.priority = INT_MAX - 1,
 };
 
-static int trace_die_handler(struct notifier_block *self,
-			     unsigned long val,
-			     void *data)
-{
-	switch (val) {
-	case DIE_OOPS:
-		if (ftrace_dump_on_oops)
-			ftrace_dump(ftrace_dump_on_oops);
-		break;
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
 static struct notifier_block trace_die_notifier = {
-	.notifier_call = trace_die_handler,
-	.priority = 200
+	.notifier_call = trace_die_panic_handler,
+	.priority = INT_MAX - 1,
 };
 
+/*
+ * The idea is to execute the following die/panic callback early, in order
+ * to avoid showing irrelevant information in the trace (like other panic
+ * notifier functions); we are the 2nd to run, after hung_task/rcu_stall
+ * warnings get disabled (to prevent potential log flooding).
+ */
+static int trace_die_panic_handler(struct notifier_block *self,
+				unsigned long ev, void *unused)
+{
+	if (!ftrace_dump_on_oops)
+		return NOTIFY_DONE;
+
+	/* The die notifier requires DIE_OOPS to trigger */
+	if (self == &trace_die_notifier && ev != DIE_OOPS)
+		return NOTIFY_DONE;
+
+	ftrace_dump(ftrace_dump_on_oops);
+
+	return NOTIFY_DONE;
+}
+
 /*
  * printk is set to max of 1024, we really don't need it that big.
  * Nothing should be printing 1000 characters anyway.
-- 
2.35.1


