Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9AA6FDBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjEJKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJKdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49EA3582
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CCA632BA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CE7C433EF;
        Wed, 10 May 2023 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683714778;
        bh=pcHCLtOh0HdEkzYFuTfO5KZmLO01o2e11R0rl38Yxfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCzxlqyk3KGBvY1ct5gmyTLYNl6DQvaCNm0HLXYwsnaysDKggGej3KDZlhkDL1dyc
         PIeHtcF3J91XhCmrey76COmJ0MrOO/MjElF2g9yciZh9hnuAri/mKFkeOBaZZPo5NU
         EU9bPHjpHYAe8X844D9ApbMLioV5z2aQm8R7G7tmuxMbiqLoFsM0cSCZs/0idvPA3J
         FCp7bI/TEFm8zH7Rh0QO4wBF7q50cCr3eMsa58JBEQ5659SUkI/I22dgNGeTq1RrVQ
         pkkwOsfiGiPSxXth4+Ey5YQd+cZhmqA7Y5GgoyPkzXjfLs4ISwBtcrZMIrhTe5vHhq
         41KaB8D5Ce2hQ==
Date:   Wed, 10 May 2023 12:32:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 19/21] timer: Implement the hierarchical pull model
Message-ID: <ZFty1fNMlnuLk4qF@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-20-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510072817.116056-20-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 10, 2023 at 09:28:15AM +0200, Anna-Maria Behnsen a écrit :
> +static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
> +				   unsigned long jif)
> +{
> +	struct timer_events tevt;
> +	struct tmigr_walk data;
> +	struct tmigr_cpu *tmc;
> +	u64 next = KTIME_MAX;
> +
> +	tmc = per_cpu_ptr(&tmigr_cpu, cpu);
> +
> +	raw_spin_lock_irq(&tmc->lock);
> +	/*
> +	 * Remote CPU is offline or no longer idle or other cpu handles cpu
> +	 * timers already or next event was already expired - return!
> +	 */
> +	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
> +	    now < tmc->cpuevt.nextevt.expires) {
> +		raw_spin_unlock_irq(&tmc->lock);
> +		return next;
> +	}
> +
> +	tmc->remote = 1;
> +
> +	/* Drop the lock to allow the remote CPU to exit idle */
> +	raw_spin_unlock_irq(&tmc->lock);
> +
> +	if (cpu != smp_processor_id())
> +		timer_expire_remote(cpu);
> +
> +	/*
> +	 * Pretend that there is no timer pending if the cpu is offline.
> +	 * Possible pending timers will be migrated later to an active cpu.
> +	 */
> +	if (cpu_is_offline(smp_processor_id())) {
> +		raw_spin_lock_irq(&tmc->lock);
> +		tevt.local = tevt.global = KTIME_MAX;
> +	} else {
> +		/*
> +		 * Lock ordering needs to be preserved - timer_base locks
> +		 * before tmigr related locks. During fetching the next
> +		 * timer interrupt, also tmc->lock needs to be
> +		 * held. Otherwise there is a possible race window against
> +		 * the CPU itself when it comes out of idle, updates the
> +		 * first timer and goes back to idle.
> +		 */
> +		timer_lock_remote_bases(cpu);

So the return value is ignored here.

In the case of !PREEMPT_RT, I suppose it's impossible for the target
CPU to be offline. You checked above tmc->online and in-between the
call to timer_lock_remote_bases(), the path is BH-disabled, this prevents
stop_machine from running and from setting the CPU as offline.

However in PREEMPT_RT, ksoftirqd (or timersd) is preemptible, so it seems
that it could happen in theory. And that could create a locking imbalance.

My suggestion would be to unconditionally lock the bases, you already checked if
!tmc->online before. The remote CPU may have gone down since then because the
tmc lock has been relaxed but it should be rare enough that you don't care
about optimizing with a lockless check. So you can just lock the bases,
lock the tmc and check again if tmc->online. If not then you can just ignore
the tmigr_new_timer_up call and propagation.

Thanks.

> +		raw_spin_lock(&tmc->lock);
> +
> +		/* next	event of cpu */
> +		fetch_next_timer_interrupt_remote(jif, now, &tevt, cpu);
> +	}
> +
> +	/*
> +	 * Nothing more to do when CPU came out of idle in the meantime - needs
> +	 * to be checked when holding the tmc lock to prevent race.
> +	 */
> +	if (!tmc->idle)
> +		goto unlock;
> +
> +	data.evt = &tmc->cpuevt;
> +	data.nextexp = tevt.global;
> +	data.groupstate.state = atomic_read(&tmc->tmgroup->migr_state);
> +	data.remote = true;
> +	tmc->cpuevt.ignore = 0;
> +
> +	walk_groups(&tmigr_new_timer_up, &data, tmc);
> +
> +	next = data.nextexp;
> +
> +unlock:
> +	tmc->remote = 0;
> +	raw_spin_unlock_irq(&tmc->lock);
> +
> +	return next;
> +}
