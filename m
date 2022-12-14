Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4222364C942
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiLNMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLNMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:50:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B380EA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:49:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B7C8B818AE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371E5C433D2;
        Wed, 14 Dec 2022 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671022168;
        bh=MfURZ9LBGJIdU91BwgSvPBsaxxo8gfXFc4ZKjgaELJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUap6aiHDZvgbDfx3ZAuiCMW7MxWYq/v3Z7YS+Tpg6e0QdJsDwtQC0E4X+aBSUARX
         ZuckVeOGUZY1KbnSKt1riHxPHeUqGrvvdA7VWreYeCBPzgfiYIPHA9uDwtFHmakAfX
         pDN6ReDJycypdCrZgO9GlNCZ5MhJDAwMQDRW6r+3ef+yWwkQFh5HEem6Q7KE9onz1V
         dOjDre9So8BJTN+Op/fxGSIRrB4nbIDmMWaLS+hgcfqJuXviaayipf/jvy7nefNv0a
         0YdlWYPcUCnTZwj+fh80mvY/46CqwUPKMO+BJ+hsAU5FVomY0yEqb7hoe5k6Rr9tVb
         UKDHoVeLCdsyQ==
Date:   Wed, 14 Dec 2022 13:49:25 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 4/5] tick/nohz_full: Ensure quiet_vmstat() is called
 on exit to user-mode when the idle tick is stopped
Message-ID: <20221214124925.GB1925147@lothringen>
References: <20221206161826.698593151@redhat.com>
 <20221206162416.509808578@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206162416.509808578@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 01:18:30PM -0300, Marcelo Tosatti wrote:
> From: Aaron Tomlin <atomlin@redhat.com>
> 
> This patch ensures CPU-specific vmstat differentials do not remain
> when the scheduling-tick is stopped and before exiting to user-mode
> in the context of nohz_full only.
> 
> A trivial test program was used to determine the impact of the proposed
> changes and under vanilla. The mlock(2) and munlock(2) system calls was
> used solely to modify vmstat item 'NR_MLOCK'. The following is an average
> count of CPU-cycles across the aforementioned system calls:
> 
> 				  Vanilla                 Modified
> 
>   Cycles per syscall              8461                    8690    (+2.6%)
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>

This is missing your Signed-off-by:

Also can you make this (and also the conditional vmstat_shepherd ignore
nohz_full CPUs and also the in-place local arming) a Kconfig option perhaps?
Something like CONFIG_FLUSH_WORK_ON_RESUME_USER (depend on NO_HZ_FULL). I'm using
"WORK" instead of "VMSTAT" so that we can even add more stuff there later.

This way I'll stop worrying about the potential HPC users who may not care about
the occasional interrupt and prefer to have reasonably fast syscalls.

Then after some time if nobody complains, we can remove the Kconfig entry.

Thanks.

> ---
>  include/linux/tick.h     |    5 +++--
>  kernel/time/tick-sched.c |   15 +++++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/include/linux/tick.h
> ===================================================================
> --- linux-2.6.orig/include/linux/tick.h
> +++ linux-2.6/include/linux/tick.h
> @@ -11,7 +11,6 @@
>  #include <linux/context_tracking_state.h>
>  #include <linux/cpumask.h>
>  #include <linux/sched.h>
> -#include <linux/rcupdate.h>
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern void __init tick_init(void);
> @@ -272,6 +271,7 @@ static inline void tick_dep_clear_signal
>  
>  extern void tick_nohz_full_kick_cpu(int cpu);
>  extern void __tick_nohz_task_switch(void);
> +void __tick_nohz_user_enter_prepare(void);
>  extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
>  #else
>  static inline bool tick_nohz_full_enabled(void) { return false; }
> @@ -296,6 +296,7 @@ static inline void tick_dep_clear_signal
>  
>  static inline void tick_nohz_full_kick_cpu(int cpu) { }
>  static inline void __tick_nohz_task_switch(void) { }
> +static inline void __tick_nohz_user_enter_prepare(void) { }
>  static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
>  #endif
>  
> @@ -308,7 +309,7 @@ static inline void tick_nohz_task_switch
>  static inline void tick_nohz_user_enter_prepare(void)
>  {
>  	if (tick_nohz_full_cpu(smp_processor_id()))
> -		rcu_nocb_flush_deferred_wakeup();
> +		__tick_nohz_user_enter_prepare();
>  }
>  
>  #endif
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -26,6 +26,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/context_tracking.h>
>  #include <linux/mm.h>
> +#include <linux/rcupdate.h>
>  
>  #include <asm/irq_regs.h>
>  
> @@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
>  	}
>  }
>  
> +void __tick_nohz_user_enter_prepare(void)
> +{
> +	struct tick_sched *ts;
> +
> +	if (tick_nohz_full_cpu(smp_processor_id())) {
> +		ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +		if (ts->tick_stopped)
> +			quiet_vmstat(true);
> +		rcu_nocb_flush_deferred_wakeup();
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
> +
>  /* Get the boot-time nohz CPU list from the kernel parameters. */
>  void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>  {
> 
> 
