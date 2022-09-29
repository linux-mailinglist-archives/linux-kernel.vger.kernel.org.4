Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD45EF3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiI2LGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiI2LGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:06:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F538125D85
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=isscZ9xZcb3X8C/grlpGX2flK1QyGsNT5yCD9AlT2y8=; b=YLRspUlrRsysRAL/e5xkVGkoon
        QH3QOGf+U8Ocbys0UIgsJ2fAu0UbTP/MFlQqOyj3qhMaf3z3gSijx5IMI3CqEeAiXHMtO1mIUCS53
        fwUKy4b5PA6S5BFvjuEIPEjmNWPRlBAwSbN69XeInhvB4hgS4UKp6iMjqIPwr0hH+GUIC/kxNYHrc
        WpiI1VhcsPSnELuKlICJIvv6PHRCWClx7ciC8sNLdXog8e4+vUFkA9a/KErRSObigqZB2UKy0fI4j
        lSh6quf68wJzZnd9eiei7fu1KRV8SnWgVxVi9K6lSE+9YUTv3bIgioDKHPREZDT5gftg3OTYF9l2j
        c8J/7kyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odrN6-00GsdK-U4; Thu, 29 Sep 2022 11:06:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05CCF30008D;
        Thu, 29 Sep 2022 13:06:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0F6C2019CD2C; Thu, 29 Sep 2022 13:06:27 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:06:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RCU vs NOHZ
Message-ID: <YzV8M4OU2wj7L9W+@hirez.programming.kicks-ass.net>
References: <YyLksEr05QTNo05Q@hirez.programming.kicks-ass.net>
 <20220915160600.GA246308@paulmck-ThinkPad-P17-Gen-1>
 <YyN0BKEoDbe4hcIl@hirez.programming.kicks-ass.net>
 <20220915191427.GC246308@paulmck-ThinkPad-P17-Gen-1>
 <YyOnilnwnLKA9ghN@hirez.programming.kicks-ass.net>
 <20220916075817.GE246308@paulmck-ThinkPad-P17-Gen-1>
 <YyQ/zn54D1uoaIc1@hirez.programming.kicks-ass.net>
 <20220917142508.GF246308@paulmck-ThinkPad-P17-Gen-1>
 <20220921213644.GA1609461@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921213644.GA1609461@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 02:36:44PM -0700, Paul E. McKenney wrote:

> commit 80fc02e80a2dfb6c7468217cff2d4494a1c4b58d
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Sep 21 13:30:24 2022 -0700
> 
>     rcu: Let non-offloaded idle CPUs with callbacks defer tick
>     
>     When a CPU goes idle, rcu_needs_cpu() is invoked to determine whether or
>     not RCU needs the scheduler-clock tick to keep interrupting.  Right now,
>     RCU keeps the tick on for a given idle CPU if there are any non-offloaded
>     callbacks queued on that CPU.
>     
>     But if all of these callbacks are waiting for a grace period to finish,
>     there is no point in scheduling a tick before that grace period has any
>     reasonable chance of completing.  This commit therefore delays the tick
>     in the case where all the callbacks are waiting for a specific grace
>     period to elapse.  In theory, this should result in a 50-70% reduction in
>     RCU-induced scheduling-clock ticks on mostly-idle CPUs.  In practice, TBD.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 5ec97e3f7468..47cd3b0d2a07 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -676,12 +676,33 @@ void __rcu_irq_enter_check_tick(void)
>   * scheduler-clock interrupt.
>   *
>   * Just check whether or not this CPU has non-offloaded RCU callbacks
> - * queued.
> + * queued that need immediate attention.
>   */
> -int rcu_needs_cpu(void)
> +int rcu_needs_cpu(u64 basemono, u64 *nextevt)
>  {
> -	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
> -		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +	struct rcu_segcblist *rsclp = &rdp->cblist;
> +
> +	// Disabled, empty, or offloaded means nothing to do.
> +	if (!rcu_segcblist_is_enabled(rsclp) ||
> +	    rcu_segcblist_empty(rsclp) || rcu_rdp_is_offloaded(rdp)) {
> +		*nextevt = KTIME_MAX;
> +		return 0;
> +	}

So far agreed; however, I was arguing to instead:

> +
> +	// Callbacks ready to invoke or that have not already been
> +	// assigned a grace period need immediate attention.
> +	if (!rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ||
> +	    !rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL))
> +		return 1;
> +
> +	// There are callbacks waiting for some later grace period.
> +	// Wait for about a grace period or two for the next tick, at which
> +	// point there is high probability that this CPU will need to do some
> +	// work for RCU.
> +	*nextevt = basemono + TICK_NSEC * (READ_ONCE(jiffies_till_first_fqs) +
> +					   READ_ONCE(jiffies_till_next_fqs) + 1);
> +	return 0;
>  }

force offload whatever you have in this case and always have it return
false.

Except I don't think this is quite the right place; there's too much
that can still get in the way of stopping the tick, I would delay the
force offload to the place where we actually know we're going to stop
the tick.

