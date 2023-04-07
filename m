Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1B26DAB7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbjDGKZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbjDGKYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:24:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DB3BDCB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 03:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ugJQ22P2VM2xtxPkMIbImarOlCvwMytzlwoGMDfly34=; b=Dq04D9zzLKR5wp+izPIbSqfWCk
        JAAhGmLVvloKx2ozZj7RJhMd07cDz4txUxVYEkzAXEuhNf1AUqnO5dmLiYcXBnRMssPmqc4bwhmVt
        w77odgN7jSLHMOKgWUpkEqEiEHH5NiFtgYP/kmU5G+LUDZvvvUUzFYBDdWbQFJHcghWhQceDHzQZz
        5PglCFe0ALwx0AYdsU6/aE+WHomHgBfTRKQapZDSd5LunGJcJjO85XsjsgFK/LTPHeTAV+gBge++T
        fExC6DFfYRJbh9o8qZ85DRxdVszqecBdf7iJDFAA1z/VRZq9qVRVcdsjD1sZ0JHAM6iCXVYWQMtXI
        Xw+ru7qQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkjFi-00AzzU-1W;
        Fri, 07 Apr 2023 10:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42B36300070;
        Fri,  7 Apr 2023 12:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A1342625093E; Fri,  7 Apr 2023 12:23:23 +0200 (CEST)
Date:   Fri, 7 Apr 2023 12:23:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 8/9] irqentry: define irqentry_exit_allow_resched()
Message-ID: <20230407102323.GA430894@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com>
 <20230405202240.GE365912@hirez.programming.kicks-ass.net>
 <87o7o1lzko.fsf@oracle.com>
 <20230406201359.GC405948@hirez.programming.kicks-ass.net>
 <87lej4ifvc.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lej4ifvc.fsf@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:29:59PM -0700, Ankur Arora wrote:
> Peter Zijlstra <peterz@infradead.org> writes:

> > Something like the below perhaps?
> >
> > ---
> >  include/linux/entry-common.h |  6 ++++++
> >  kernel/entry/common.c        | 23 +++++++++++++++++++++--
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index d95ab85f96ba..0c365dc1f1c2 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -415,10 +415,16 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
> >   * Conditional reschedule with additional sanity checks.
> >   */
> >  void raw_irqentry_exit_cond_resched(void);
> > +void irqentry_exit_cond_resched_tif(void);
> > +
> >  #ifdef CONFIG_PREEMPT_DYNAMIC
> >  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> >  #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
> > +#ifdef TIF_RESCHED_ALLOW
> > +#define irqentry_exit_cond_resched_dynamic_disabled	irqentry_exit_cond_resched_tif
> > +#else
> >  #define irqentry_exit_cond_resched_dynamic_disabled	NULL
> > +#endif
> 
> So this is clever. Essentially this would toggle between the two kinds
> for the preempt_model_preemptible()/!preempt_model_preemptible() dynamic
> case. Do I have that right?

Exactly!

> >  DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> >  #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
> >  #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index be61332c66b5..211d118aa672 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -390,6 +390,21 @@ void raw_irqentry_exit_cond_resched(void)
> >  			preempt_schedule_irq();
> >  	}
> >  }
> > +
> > +void irqentry_exit_cond_resched_tif(void)
> > +{
> > +#ifdef TIF_RESCHED_ALLOW
> > +	if (resched_allowed()) {
> > +		/* Sanity check RCU and thread stack */
> > +		rcu_irq_exit_check_preempt();
> > +		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> > +			WARN_ON_ONCE(!on_thread_stack());
> > +		if (need_resched())
> > +			preempt_schedule_irq();
> > +	}
> > +#endif
> > +}
> > +
> >  #ifdef CONFIG_PREEMPT_DYNAMIC
> >  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
> >  DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> > @@ -397,8 +412,10 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> >  DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> >  void dynamic_irqentry_exit_cond_resched(void)
> >  {
> > -	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> > -		return;
> > +	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched)) {
> > +		irqentry_exit_cond_resched_tif();
> > +		return
> > +	}
> >  	raw_irqentry_exit_cond_resched();
> >  }
> >  #endif
> > @@ -431,6 +448,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
> >  		instrumentation_begin();
> >  		if (IS_ENABLED(CONFIG_PREEMPTION))
> >  			irqentry_exit_cond_resched();
> > +		else
> > +			irqentry_exit_cond_resched_tif();
> 
> And, if we choose between the two resched modes at compile time then this
> would work.

Just so.

> Might massage the names a little but this should work as is.

Yeah, I'm not liking the naming either, perhaps your
irqentry_exit_allow_resched() would've been better, dunno, see what
works.

> Okay if I use your Codeveloped-by/Suggested-by on this patch?

Yep.
