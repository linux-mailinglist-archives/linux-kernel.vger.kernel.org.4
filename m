Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EE56B56D7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCKAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCKAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:40:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ECB1409C8;
        Fri, 10 Mar 2023 16:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA046B82461;
        Sat, 11 Mar 2023 00:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D3EC433EF;
        Sat, 11 Mar 2023 00:40:08 +0000 (UTC)
Date:   Fri, 10 Mar 2023 19:40:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] tracing: Make tracepoint lockdep check actually test
 something
Message-ID: <20230310194005.374c5367@gandalf.local.home>
In-Reply-To: <20230310235653.GC1605437@hirez.programming.kicks-ass.net>
References: <20230310172856.77406446@gandalf.local.home>
        <20230310235653.GC1605437@hirez.programming.kicks-ass.net>
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

On Sat, 11 Mar 2023 00:56:53 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Mar 10, 2023 at 05:28:56PM -0500, Steven Rostedt wrote:
> 
> > @@ -249,9 +248,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  				TP_ARGS(args),				\
> >  				TP_CONDITION(cond), 0);			\
> >  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > -			rcu_read_lock_sched_notrace();			\
> > -			rcu_dereference_sched(__tracepoint_##name.funcs);\
> > -			rcu_read_unlock_sched_notrace();		\
> > +			WARN_ON_ONCE(!rcu_is_watching());		\
> >  		}							\
> >  	}								\
> >  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\  
> 
> Yep, that makes heaps more sense. If you so care you can save one more
> line and make the {} go away too.

I thought about that, but I kinda prefer the brackets still.

> 
> In any case,
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

-- Steve

