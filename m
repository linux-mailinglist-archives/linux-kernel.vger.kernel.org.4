Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC16B0F75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCHQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCHQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:57:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8F4D239C;
        Wed,  8 Mar 2023 08:56:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7745561852;
        Wed,  8 Mar 2023 16:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1748CC433EF;
        Wed,  8 Mar 2023 16:56:07 +0000 (UTC)
Date:   Wed, 8 Mar 2023 11:56:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] tracing, hardirq: Do not test lockdep on irq trace
 points when disabled
Message-ID: <20230308115606.0b6a193c@gandalf.local.home>
In-Reply-To: <20230308143925.GJ2017917@hirez.programming.kicks-ass.net>
References: <20230307184645.521db5c9@gandalf.local.home>
        <20230308143925.GJ2017917@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 15:39:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > 		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > 			rcu_read_lock_sched_notrace();			\
> > 			rcu_dereference_sched(__tracepoint_##name.funcs);\
> > 			rcu_read_unlock_sched_notrace();		\
> > 		}							\
> > 	}								\  
> 
> > Where it will test lockdep for trace points even when they are not
> > enabled, to make sure they do not cause RCU issues, and lockdep will
> > trigger even when the trace points are not enabled.  
> 
> I'm confused what that's actually trying to do..
> 
> You're not tickling the rcu_is_watching() check, because
> rcu_read_lock_sched_notrace() doesn't have that. You're not tickling
> RCU_LOCKDEP_WARN() because you did rcu_read_lock_sched_notrace().
> 
> So what?!?

Actually, I think the proper changes is to just add "rcu_is_watching()"
warning here?

That code is from 2014 where it simulated what was done in DO_TRACE() and I
think back then, those calls did trigger warnings. But this code has not
kept up with the changes in DO_TRACE.

So something like this instead?

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


-- Steve

