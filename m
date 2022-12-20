Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85ED652849
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiLTVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiLTVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:18:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A57F1E707;
        Tue, 20 Dec 2022 13:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yPlZS5KVMJAuPJditas+5KPPwoNrjpAa0vnLiSnP5PU=; b=G+2OF4CjguqQ644Yk3nQX0q8pX
        k9fXRaHBHAcRmZeY4dcWvZVN88pg9yeTbXicURJ00ZFtw+PZygirUNWfRegyWQIcpB+SuI6NzZVRC
        yWzJ3VhrSWoVr1rHGbZL7+uCug4Dedr99LkRc2qnt/tp1iLKRM/TEet6nMSddL5FP055hQa34cW4a
        dXVB/JBKJCzcO+L4/URclldj4tw916FUk4TWVpUODaQ8Ex0O+R8ipbir6a2UAIlnWJOf5nAV/+MVD
        7mtZNb0JrXgfd8R0U83+HVqiBlLCx+Ojp7a/K30t0EwT1PR41G9q6kzgHs8Hwv9t84+tqMjd5ujys
        g2M8a1EA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7k06-002BX3-AV; Tue, 20 Dec 2022 21:18:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F11CF3000DD;
        Tue, 20 Dec 2022 22:18:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A62A620D2DE0C; Tue, 20 Dec 2022 22:18:02 +0100 (CET)
Date:   Tue, 20 Dec 2022 22:18:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, len.brown@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <Y6ImigCet+RXzds/@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
 <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
 <20221216220748.GA1967978@lothringen>
 <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
 <5ae0d53990c29aa25648cbf32ef3b16e9bec911c.camel@linux.intel.com>
 <Y6IgPVacKInH9tgv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6IgPVacKInH9tgv@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:51:09PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 19, 2022 at 02:54:55PM -0800, srinivas pandruvada wrote:
> 
> > But after ksoftirqd_run_end(), which will renable local irq, this may
> > further cause more soft irq pending. Here RCU soft irq entry continues
> 
> Right you are.. what about if we spell the idle.c thing like so instead?
> 
> Then we repeat the softirq thing every time we drop out of the idle loop
> for a reschedule.

Uff, that obviously can't work because we already have preemption
disabled here, this needs a bit more work. I think it's possible to
re-arrange things a bit.

I'll try and have a look tomorrow, but the kids have their xmas play at
school so who knows what I'll get done.

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f26ab2675f7d..6dce49813bcc 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -381,8 +381,13 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
>  	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
>  		      HRTIMER_MODE_REL_PINNED_HARD);
>  
> -	while (!READ_ONCE(it.done))
> +	while (!READ_ONCE(it.done)) {
> +		rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
> +		__run_ksoftirqd(smp_processor_id());
> +		rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
> +
>  		do_idle();
> +	}
>  
>  	cpuidle_use_deepest_state(0);
>  	current->flags &= ~PF_IDLE;
