Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2968E5B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBHB6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBHB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:57:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2A33F28C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:57:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24BCEB81B9B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF49CC433A0;
        Wed,  8 Feb 2023 01:57:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pPZiF-006dPq-2l;
        Tue, 07 Feb 2023 20:57:31 -0500
Message-ID: <20230208015731.669243610@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 07 Feb 2023 20:56:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 07/11] tracing: Fix trace_event_raw_event_synth() if else statement
References: <20230208015633.791198913@goodmis.org>
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

The test to check if the field is a stack is to be done if it is not a
string. But the code had:

    } if (event->fields[i]->is_stack) {

and not

   } else if (event->fields[i]->is_stack) {

which would cause it to always be tested. Worse yet, this also included an
"else" statement that was only to be called if the field was not a string
and a stack, but this code allows it to be called if it was a string (and
not a stack).

Also fixed some whitespace issues.

Link: https://lore.kernel.org/all/202301302110.mEtNwkBD-lkp@intel.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230131095237.63e3ca8d@gandalf.local.home

Cc: Tom Zanussi <zanussi@kernel.org>
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index adb630633f31..306c89e0ce55 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -564,8 +564,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
-		} if (event->fields[i]->is_stack) {
-		        long *stack = (long *)(long)var_ref_vals[val_idx];
+		} else if (event->fields[i]->is_stack) {
+			long *stack = (long *)(long)var_ref_vals[val_idx];
 
 			len = trace_stack(entry, event, stack,
 					   data_size, &n_u64);
-- 
2.39.1
