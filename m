Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E566E64CBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiLNOCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbiLNOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:02:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897320BC4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:02:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D189661A69
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0BDC4339E;
        Wed, 14 Dec 2022 14:02:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p5SKn-000gun-13;
        Wed, 14 Dec 2022 09:02:09 -0500
Message-ID: <20221214140209.194205837@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Dec 2022 09:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 5/8] tracing: Do not synchronize freeing of trigger filter on boot up
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a trigger filter on the kernel command line fails to apply (due to
syntax error), it will be freed. The freeing will call
tracepoint_synchronize_unregister(), but this is not needed during early
boot up, and will even trigger a lockdep splat.

Avoid calling the synchronization function when system_state is
SYSTEM_BOOTING.

Link: https://lore.kernel.org/linux-trace-kernel/20221213172429.7774f4ba@gandalf.local.home

Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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


