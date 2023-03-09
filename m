Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593816B3012
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCIV6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCIV5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:57:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508DCFB26B;
        Thu,  9 Mar 2023 13:56:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF71061D12;
        Thu,  9 Mar 2023 21:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C46C433D2;
        Thu,  9 Mar 2023 21:56:05 +0000 (UTC)
Date:   Thu, 9 Mar 2023 16:56:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] tracing: Make tracepoint lockdep check actually test
 something
Message-ID: <20230309165603.6967197d@gandalf.local.home>
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

A while ago where the trace events had the following:

   rcu_read_lock_sched_notrace();
   rcu_dereference_sched(...);
   rcu_read_unlock_sched_notrace();

If the tracepoint is enabled, it could trigger RCU issues if called in
the wrong place. And this warning was only triggered if lockdep was
enabled. If the tracepoint was never enabled with lockdep, the bug would
not be caught. To handle this, the above sequence was done when lockdep
was enabled regardless if the tracepoint was enabled or not (although the
always enabled code really didn't do anything, it would still trigger a
warning).

But a lot has changed since that lockdep code was added. One is, that
sequence no longer triggers any warning. Another is, the tracepoint when
enabled doesn't even do that sequence anymore.

The main check we care about today is whether RCU is "watching" or not.
So if lockdep is enabled, always check if rcu_is_watching() which will
trigger a warning if it is not (tracepoints require RCU to be watching).

Note, that old sequence did add a bit of overhead when lockdep was enabled,
and with the latest kernel updates, would cause the system to slow down
enough to trigger kernel "stalled" warnings.

Link: http://lore.kernel.org/lkml/20140806181801.GA4605@redhat.com
Link: http://lore.kernel.org/lkml/20140807175204.C257CAC5@viggo.jf.intel.com
Link: https://lore.kernel.org/lkml/20230307184645.521db5c9@gandalf.local.home/

Cc: stable@vger.kernel.org
Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index e299f29375bb..d3a221158ab1 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -260,9 +260,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			rcu_read_lock_sched_notrace();			\
-			rcu_dereference_sched(__tracepoint_##name.funcs);\
-			rcu_read_unlock_sched_notrace();		\
+			WARN_ON_ONCE(!rcu_is_watching());		\
 		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
-- 
2.39.1

