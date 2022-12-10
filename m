Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0FC648F11
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLJN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLJN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4833186EA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5684B60C2C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DA0C433AE;
        Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40N0-000ktr-0x;
        Sat, 10 Dec 2022 08:58:26 -0500
Message-ID: <20221210135826.163090876@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [for-next][PATCH 19/25] tracing: remove unnecessary trace_trigger ifdef
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

From: Ross Zwisler <zwisler@chromium.org>

The trace_trigger command line option introduced by
commit a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
doesn't need to depend on the CONFIG_HIST_TRIGGERS kernel config option.

This code doesn't depend on the histogram code, and the run-time
selection of triggers is usable without CONFIG_HIST_TRIGGERS.

Link: https://lore.kernel.org/linux-trace-kernel/20221209003310.1737039-1-zwisler@google.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Fixes: a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3bfaf560ecc4..33e0b4f8ebe6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2796,7 +2796,6 @@ trace_create_new_event(struct trace_event_call *call,
 	return file;
 }
 
-#ifdef CONFIG_HIST_TRIGGERS
 #define MAX_BOOT_TRIGGERS 32
 
 static struct boot_triggers {
@@ -2832,7 +2831,6 @@ static __init int setup_trace_triggers(char *str)
 	return 1;
 }
 __setup("trace_trigger=", setup_trace_triggers);
-#endif
 
 /* Add an event to a trace directory */
 static int
@@ -2850,7 +2848,6 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 		return event_define_fields(call);
 }
 
-#ifdef CONFIG_HIST_TRIGGERS
 static void trace_early_triggers(struct trace_event_file *file, const char *name)
 {
 	int ret;
@@ -2868,9 +2865,6 @@ static void trace_early_triggers(struct trace_event_file *file, const char *name
 			       bootup_triggers[i].event);
 	}
 }
-#else
-static inline void trace_early_triggers(struct trace_event_file *file, const char *name) { }
-#endif
 
 /*
  * Just create a descriptor for early init. A descriptor is required
-- 
2.35.1


