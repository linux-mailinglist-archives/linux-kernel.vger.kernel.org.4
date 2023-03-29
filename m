Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533306CF38B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjC2Tqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjC2Tp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F8193
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24E4E61E28
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0087EC433A1;
        Wed, 29 Mar 2023 19:45:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk2-002Rrf-0N;
        Wed, 29 Mar 2023 15:45:54 -0400
Message-ID: <20230329194553.932013715@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 24/25] tracing/user_events: Use print_format_fields() for trace output
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Currently, user events are shown using the "hex" output for "safety"
reasons as one cannot trust user events behaving nicely. But the hex
output is not the only utility for safe outputting of trace events. The
print_event_fields() is just as safe and gives user readable output.

Before:
         example-839     [001] .....    43.222244:
00000000: b1 06 00 00 47 03 00 00 00 00 00 00              ....G.......
         example-839     [001] .....    43.564433:
00000000: b1 06 00 00 47 03 00 00 01 00 00 00              ....G.......
         example-839     [001] .....    43.763917:
00000000: b1 06 00 00 47 03 00 00 02 00 00 00              ....G.......
         example-839     [001] .....    43.967929:
00000000: b1 06 00 00 47 03 00 00 03 00 00 00              ....G.......

After:

         example-837     [006] .....    55.739249: test: count=0x0 (0)
         example-837     [006] .....   111.104784: test: count=0x1 (1)
         example-837     [006] .....   111.268444: test: count=0x2 (2)
         example-837     [006] .....   111.416533: test: count=0x3 (3)
         example-837     [006] .....   111.542859: test: count=0x4 (4)

Link: https://lore.kernel.org/linux-trace-kernel/20230328151413.4770b8d7@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 67cb7b53caf6..cc8c6d8b69b5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -22,8 +22,9 @@
 #include <linux/highmem.h>
 #include <linux/init.h>
 #include <linux/user_events.h>
-#include "trace.h"
 #include "trace_dynevent.h"
+#include "trace_output.h"
+#include "trace.h"
 
 #define USER_EVENTS_PREFIX_LEN (sizeof(USER_EVENTS_PREFIX)-1)
 
@@ -1198,11 +1199,7 @@ static enum print_line_t user_event_print_trace(struct trace_iterator *iter,
 						int flags,
 						struct trace_event *event)
 {
-	/* Unsafe to try to decode user provided print_fmt, use hex */
-	trace_print_hex_dump_seq(&iter->seq, "", DUMP_PREFIX_OFFSET, 16,
-				 1, iter->ent, iter->ent_size, true);
-
-	return trace_handle_return(&iter->seq);
+	return print_event_fields(iter, event);
 }
 
 static struct trace_event_functions user_event_funcs = {
-- 
2.39.1
