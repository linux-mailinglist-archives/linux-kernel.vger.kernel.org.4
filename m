Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB25FB2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJKNHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJKNHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:07:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736B92CE30;
        Tue, 11 Oct 2022 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0kl7dlvjnuqfiBoL2flcqsA/Ux8iLqViAUlVpL1x4Uo=; b=PMDKwr0KWdXbhAaPTSlYSSmTYv
        mIRgI5rrLsxLj0eUfhOvczUj0+VhBlzjcUYHbk6NdI7Al5eUjP/uSvg79Q5+Jsznybyc9383/SYUv
        ng18nHoA7ujD0h4YtYCNt1xVNzQ1YDUS9R63z6eWL0Bk8+5/7y6qF+74JHtZldJWX9DI1RX5g8r2K
        5102+Mwj1jyeFqD3UvqF0YSfOkiqTwR9tT49PIeLt9SBkkefqpoMKpbMUcKhC+ShVrGWwkIFtop/9
        ga/OE6Nm+E1fje6qeCFeFSdhNNt5HzglmD1H5lIx/4tCaAByHdCUrQBOew4zb2b3DVO6+jVUzS7WH
        mTLEO1kw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oiEyI-004yPP-BO; Tue, 11 Oct 2022 13:06:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2F7830004F;
        Tue, 11 Oct 2022 15:06:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A693029A09944; Tue, 11 Oct 2022 15:06:52 +0200 (CEST)
Date:   Tue, 11 Oct 2022 15:06:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] perf: Fix missing SIGTRAPs
Message-ID: <Y0VqbNDKIHUcC7Ha@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
 <Y0Ue2L5CsaQwDrEs@hirez.programming.kicks-ass.net>
 <Y0VofNVMBXPOJJr7@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0VofNVMBXPOJJr7@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:58:36PM +0200, Marco Elver wrote:
> On Tue, Oct 11, 2022 at 09:44AM +0200, Peter Zijlstra wrote:
> > Subject: perf: Fix missing SIGTRAPs
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Oct 6 15:00:39 CEST 2022
> > 
> > Marco reported:
> > 
> > Due to the implementation of how SIGTRAP are delivered if
> > perf_event_attr::sigtrap is set, we've noticed 3 issues:
> > 
> >   1. Missing SIGTRAP due to a race with event_sched_out() (more
> >      details below).
> > 
> >   2. Hardware PMU events being disabled due to returning 1 from
> >      perf_event_overflow(). The only way to re-enable the event is
> >      for user space to first "properly" disable the event and then
> >      re-enable it.
> > 
> >   3. The inability to automatically disable an event after a
> >      specified number of overflows via PERF_EVENT_IOC_REFRESH.
> > 
> > The worst of the 3 issues is problem (1), which occurs when a
> > pending_disable is "consumed" by a racing event_sched_out(), observed
> > as follows:
> > 
> > 		CPU0			|	CPU1
> > 	--------------------------------+---------------------------
> > 	__perf_event_overflow()		|
> > 	 perf_event_disable_inatomic()	|
> > 	  pending_disable = CPU0	| ...
> > 					| _perf_event_enable()
> > 					|  event_function_call()
> > 					|   task_function_call()
> > 					|    /* sends IPI to CPU0 */
> > 	<IPI>				| ...
> > 	 __perf_event_enable()		+---------------------------
> > 	  ctx_resched()
> > 	   task_ctx_sched_out()
> > 	    ctx_sched_out()
> > 	     group_sched_out()
> > 	      event_sched_out()
> > 	       pending_disable = -1
> > 	</IPI>
> > 	<IRQ-work>
> > 	 perf_pending_event()
> > 	  perf_pending_event_disable()
> > 	   /* Fails to send SIGTRAP because no pending_disable! */
> > 	</IRQ-work>
> > 
> > In the above case, not only is that particular SIGTRAP missed, but also
> > all future SIGTRAPs because 'event_limit' is not reset back to 1.
> > 
> > To fix, rework pending delivery of SIGTRAP via IRQ-work by introduction
> > of a separate 'pending_sigtrap', no longer using 'event_limit' and
> > 'pending_disable' for its delivery.
> > 
> > Additionally; and different to Marco's proposed patch:
> > 
> >  - recognise that pending_disable effectively duplicates oncpu for
> >    the case where it is set. As such, change the irq_work handler to
> >    use ->oncpu to target the event and use pending_* as boolean toggles.
> > 
> >  - observe that SIGTRAP targets the ctx->task, so the context switch
> >    optimization that carries contexts between tasks is invalid. If
> >    the irq_work were delayed enough to hit after a context switch the
> >    SIGTRAP would be delivered to the wrong task.
> > 
> >  - observe that if the event gets scheduled out
> >    (rotation/migration/context-switch/...) the irq-work would be
> >    insufficient to deliver the SIGTRAP when the event gets scheduled
> >    back in (the irq-work might still be pending on the old CPU).
> > 
> >    Therefore have event_sched_out() convert the pending sigtrap into a
> >    task_work which will deliver the signal at return_to_user.
> > 
> > Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> > Reported-by: Marco Elver <elver@google.com>
> > Debugged-by: Marco Elver <elver@google.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>
> Tested-by: Marco Elver <elver@google.com>
> 
> .. fuzzing, and lots of concurrent sigtrap_threads with this patch:
> 
> 	https://lore.kernel.org/all/20221011124534.84907-1-elver@google.com/
> 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> My original patch also attributed Dmitry:
> 
> 	Reported-by: Dmitry Vyukov <dvyukov@google.com>
> 	Debugged-by: Dmitry Vyukov <dvyukov@google.com>
> 
> ... we all melted our brains on this one. :-)
> 
> Would be good to get the fix into one of the upcoming 6.1-rc.

Updated and yes, I'm planning on queueing this in perf/urgent the moment
-rc1 happens.

Thanks!
