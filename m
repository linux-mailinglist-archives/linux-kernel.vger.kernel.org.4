Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF3B64BF52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiLMWYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiLMWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:24:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8313F89;
        Tue, 13 Dec 2022 14:24:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A716CB815FC;
        Tue, 13 Dec 2022 22:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92D1C433D2;
        Tue, 13 Dec 2022 22:24:30 +0000 (UTC)
Date:   Tue, 13 Dec 2022 17:24:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing: Do not synchronize freeing of trigger filter on
 boot up
Message-ID: <20221213172429.7774f4ba@gandalf.local.home>
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

If a trigger filter on the kernel command line fails to apply (due to
syntax error), it will be freed. The freeing will call
tracepoint_synchronize_unregister(), but this is not needed during early
boot up, and will even trigger a lockdep splat.

Avoid calling the synchronization function when system_state is
SYSTEM_BOOTING.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 19ce9d22bfd7..e535959939d3 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1085,8 +1085,14 @@ int set_trigger_filter(char *filter_str,
 	rcu_assign_pointer(data->filter, filter);
 
 	if (tmp) {
-		/* Make sure the call is done with the filter */
-		tracepoint_synchronize_unregister();
+		/*
+		 * Make sure the call is done with the filter.
+		 * It is possible that a filter could fail at boot up,
+		 * and then this path will be called. Avoid the synchronization
+		 * in that case.
+		 */
+		if (system_state != SYSTEM_BOOTING)
+			tracepoint_synchronize_unregister();
 		free_event_filter(tmp);
 	}
 
-- 
2.35.1

