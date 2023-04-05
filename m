Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431156D881E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDEUXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjDEUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:23:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF18349D6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jTyEKh3ikb2Y8N6HrOFo1BDcfkQEm1X8lIi0hGITVng=; b=XTupqCO+XwlbIgTKxvumTFGBhV
        MJqn1OAnoaBGTSgj/ecXpNI5rsgMiCpyDPjAoPmysJbiXlBnsAukc+1cGSPSO35ACyxM0llBie+tf
        857X8AQ0vi2K1KQ23uaBYE0DirbsswN1Mw45XqtatYg3YYZKeD/rV6bo+4a77rJfXel1FSCPy/g6S
        57TWlYt/cSXtczrwmR64DohndY9jStgKd/Ch9vi9wpExBgdvaQvJaHGdVzlQic2QxbEGW6j5PMm5U
        IvRGmYx7CX4NTaLXABnTs3l8WA5gaTrl6z/iDCan3/s9WpGwGXlUdxzio6fbEuzc7pdRN6/WVZ29E
        I0HZGqMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pk9eT-00A4qm-13;
        Wed, 05 Apr 2023 20:22:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3084B300202;
        Wed,  5 Apr 2023 22:22:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18EDB27985545; Wed,  5 Apr 2023 22:22:40 +0200 (CEST)
Date:   Wed, 5 Apr 2023 22:22:40 +0200
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
Message-ID: <20230405202240.GE365912@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-9-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403052233.1880567-9-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:22:32PM -0700, Ankur Arora wrote:
> Allow threads marked TIF_ALLOW_RESCHED to be rescheduled in irqexit.
> 
> This is only necessary under !preempt_model_preemptible() for which
> we reuse the same logic as irqentry_exit_code_resched().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/entry/common.c |  8 ++++++++
>  kernel/sched/core.c   | 36 +++++++++++++++++++++---------------
>  2 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index be61332c66b5..f1005595ebe7 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -390,6 +390,9 @@ void raw_irqentry_exit_cond_resched(void)
>  			preempt_schedule_irq();
>  	}
>  }
> +
> +void irqentry_exit_allow_resched(void) __alias(raw_irqentry_exit_cond_resched);

Because typing raw_irqentry_exit_cond_resched() was too much effort?

> +
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>  #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> @@ -431,6 +434,11 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
>  		instrumentation_begin();
>  		if (IS_ENABLED(CONFIG_PREEMPTION))
>  			irqentry_exit_cond_resched();
> +		/*
> +		 * We care about this clause only in the dynamic !preemptible case.
> +		 */
> +		if (unlikely(!preempt_model_preemptible() && resched_allowed()))
> +			irqentry_exit_allow_resched();

This is wrong, if we have dynamic preemption then we have
CONFIG_PREEMPTION and we'll have that irqentry_exit_cond_resched() call.

Basically what you've written above is something like:

	static_call(foo); // raw_foo() when A, NOP if !A
	if (!A)
		raw_foo();

And yeah, you've got the extra resched_allowed() thing in there, but
that doesn't make it any better -- this is all quite horrible.

What you really care about is the CONFIG_PREEMPTION=n case, but that you
don't actually handle.

>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0d18c3969f90..11845a91b691 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

> @@ -8597,28 +8599,32 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>   * SC:preempt_schedule
>   * SC:preempt_schedule_notrace
>   * SC:irqentry_exit_cond_resched
> + * SC:irqentry_exit_allow_resched
>   *
>   *
>   * NONE:
> - *   cond_resched               <- __cond_resched
> - *   might_resched              <- RET0
> - *   preempt_schedule           <- NOP
> - *   preempt_schedule_notrace   <- NOP
> - *   irqentry_exit_cond_resched <- NOP
> + *   cond_resched                <- __cond_resched
> + *   might_resched               <- RET0
> + *   preempt_schedule            <- NOP
> + *   preempt_schedule_notrace    <- NOP
> + *   irqentry_exit_cond_resched  <- NOP
> + *   irqentry_exit_allow_resched <- irqentry_exit_allow_resched
>   *
>   * VOLUNTARY:
> - *   cond_resched               <- __cond_resched
> - *   might_resched              <- __cond_resched
> - *   preempt_schedule           <- NOP
> - *   preempt_schedule_notrace   <- NOP
> - *   irqentry_exit_cond_resched <- NOP
> + *   cond_resched                <- __cond_resched
> + *   might_resched               <- __cond_resched
> + *   preempt_schedule            <- NOP
> + *   preempt_schedule_notrace    <- NOP
> + *   irqentry_exit_cond_resched  <- NOP
> + *   irqentry_exit_allow_resched <- irqentry_exit_allow_resched
>   *
>   * FULL:
> - *   cond_resched               <- RET0
> - *   might_resched              <- RET0
> - *   preempt_schedule           <- preempt_schedule
> - *   preempt_schedule_notrace   <- preempt_schedule_notrace
> - *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
> + *   cond_resched                <- RET0
> + *   might_resched               <- RET0
> + *   preempt_schedule            <- preempt_schedule
> + *   preempt_schedule_notrace    <- preempt_schedule_notrace
> + *   irqentry_exit_cond_resched  <- irqentry_exit_cond_resched
> + *   irqentry_exit_allow_resched <- NOP
>   */

This ^ is all complete nonsense.. irqentry_exit_allow_resched() is not
a static call. It's an alias of raw_irqentry_exit_cond_resched which
circumvents the static call entirely.


