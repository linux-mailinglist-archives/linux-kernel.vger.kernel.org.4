Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7C6536B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLUS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:56:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED8B647C;
        Wed, 21 Dec 2022 10:56:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9B687CE186C;
        Wed, 21 Dec 2022 18:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8206C433D2;
        Wed, 21 Dec 2022 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671648973;
        bh=I1Wb/JVkjLx/D5Iu41GpT9ftH9FUtw4RpMRFSFdWNlw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fIb6DQ6RJ1UC2WtFiKNrTv9lAD0Rcc9MVYxpARnYwPdZgkqp4Jo5UQGQvg+AflMhq
         2E7xushjeWlgp95ABFMa9NcijYUi0MA0rGUHcFEAJQF4LNfHEZKKgFm4S0APVM67c+
         nmzgFENQuVEYLjpziZ5elMLRNEEgJ0eWwBpIVh5ZjN2YdZzJoQ+Mo7CiM/JVFN5IAX
         bUIiLBt1qb+PMbQip0YBLH0Fdyh9y5z81aSYWtqn8D8fP459cxS6lXIXQnWldCsLb0
         C5guTRv8LwAK59TTD5RYCNTj7ID7cKP4SkahD/KhFIiFIGbrZoE0V2E+T0d6cE8fHM
         Er4vY9I2UI6NA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 56D7D5C0989; Wed, 21 Dec 2022 10:56:13 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:56:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, linux-crypto@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rcu: genericize RCU stall suppression functions
Message-ID: <20221221185613.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221219202910.3063036-1-elliott@hpe.com>
 <20221219202910.3063036-2-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219202910.3063036-2-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:29:08PM -0600, Robert Elliott wrote:
> Convert the functions that temporarily suppress RCU CPU
> stall reporting:
> 	rcu_sysrq_start()
> 	rcu_sysrq_end()
> 
> to more generic functions that may be called by functions
> other than the SysRq handler:
> 	rcu_suppress_start()
> 	rcu_suppress_end()
> 
> Covert the underlying variable:
> 	rcu_cpu_stall_suppress
> 
> to an atomic variable so multiple threads can manipulate it at the
> same time, incrementing it in start() and decrementing in end().
> 
> Expose that in sysfs in a read-only
> 	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress_dyn
> 
> Keep
> 	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress
> as writeable by userspace, but OR that into the equations rather than
> directly manipulate the atomic value.
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>

I really like the idea of making the suppressing and unsuppressing of
RCU CPU stall warnings SMP-safe, thank you!  Yes, as far as I know,
there have been no problems due to this, but accidents waiting to happen
and all that.

Some comments and questions below.

> ---
>  .../RCU/Design/Requirements/Requirements.rst  |  6 +++---
>  Documentation/RCU/stallwarn.rst               | 19 +++++++++++++++----
>  arch/parisc/kernel/process.c                  |  2 +-
>  drivers/tty/sysrq.c                           |  4 ++--
>  include/linux/rcupdate.h                      |  8 ++++----
>  kernel/rcu/rcu.h                              | 11 ++++++-----
>  kernel/rcu/tree_stall.h                       | 18 ++++++++++--------
>  kernel/rcu/update.c                           | 11 ++++++++++-
>  8 files changed, 51 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 49387d823619..5083490bb6fc 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1639,9 +1639,9 @@ against mishaps and misuse:
>     ``rcupdate.rcu_cpu_stall_suppress`` to suppress the splats. This
>     kernel parameter may also be set via ``sysfs``. Furthermore, RCU CPU
>     stall warnings are counter-productive during sysrq dumps and during
> -   panics. RCU therefore supplies the rcu_sysrq_start() and
> -   rcu_sysrq_end() API members to be called before and after long
> -   sysrq dumps. RCU also supplies the rcu_panic() notifier that is
> +   panics. RCU therefore supplies the rcu_suppress_start() and
> +   rcu_suppress_end() API members to be called before and after long
> +   CPU usage. RCU also supplies the rcu_panic() notifier that is
>     automatically invoked at the beginning of a panic to suppress further
>     RCU CPU stall warnings.
>  
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index e38c587067fc..9e6fba72f56d 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -135,13 +135,24 @@ see include/trace/events/rcu.h.
>  Fine-Tuning the RCU CPU Stall Detector
>  ======================================
>  
> -The rcuupdate.rcu_cpu_stall_suppress module parameter disables RCU's
> -CPU stall detector, which detects conditions that unduly delay RCU grace
> -periods.  This module parameter enables CPU stall detection by default,
> -but may be overridden via boot-time parameter or at runtime via sysfs.
> +RCU's CPU stall detector detects conditions that unduly delay RCU grace
> +periods.  CPU stall detection is enabled by default, but may be overridden
> +via boot-time parameter or at runtime via sysfs (accessible via
> +/sys/module/rcupdate/parameters).
> +
> +The rcupdate.rcu_cpu_stall_suppress module parameter disables RCU's
> +CPU stall detector.
> +
> +/sys/module/rcu_cpu_stall_suppress_dyn reports an internal semaphore

Actually an atomically updated variable as opposed to a semaphore,
correct?  Replacing "an internal semaphore" with something like "a
variable" would be fine from my viewpoint.

> +used by the RCU's CPU stall detector. Functions holding a CPU for a
> +long time (e.g., sysrq printouts) increment this value before use
> +and decrement it when done, so the value reports the number of
> +functions currently disabling stalls.
> +
>  The stall detector's idea of what constitutes "unduly delayed" is
>  controlled by a set of kernel configuration variables and cpp macros:
>  
> +
>  CONFIG_RCU_CPU_STALL_TIMEOUT
>  ----------------------------

And thank you for updating the documentation!

> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
> index c4f8374c7018..038378fe7bfa 100644
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -126,7 +126,7 @@ void machine_power_off(void)
>  	       "Please power this system off now.");
>  
>  	/* prevent soft lockup/stalled CPU messages for endless loop. */
> -	rcu_sysrq_start();
> +	rcu_suppress_start();
>  	lockup_detector_soft_poweroff();
>  	for (;;);
>  }
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index d2b2720db6ca..81ab63a473a7 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -579,7 +579,7 @@ void __handle_sysrq(int key, bool check_mask)
>  	orig_suppress_printk = suppress_printk;
>  	suppress_printk = 0;
>  
> -	rcu_sysrq_start();
> +	rcu_suppress_start();
>  	rcu_read_lock();
>  	/*
>  	 * Raise the apparent loglevel to maximum so that the sysrq header
> @@ -623,7 +623,7 @@ void __handle_sysrq(int key, bool check_mask)
>  		console_loglevel = orig_log_level;
>  	}
>  	rcu_read_unlock();
> -	rcu_sysrq_end();
> +	rcu_suppress_end();
>  
>  	suppress_printk = orig_suppress_printk;
>  }
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 03abf883a281..c0d8a4aae7ff 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -131,11 +131,11 @@ static inline void rcu_init_tasks_generic(void) { }
>  #endif
>  
>  #ifdef CONFIG_RCU_STALL_COMMON
> -void rcu_sysrq_start(void);
> -void rcu_sysrq_end(void);
> +void rcu_suppress_start(void);
> +void rcu_suppress_end(void);
>  #else /* #ifdef CONFIG_RCU_STALL_COMMON */
> -static inline void rcu_sysrq_start(void) { }
> -static inline void rcu_sysrq_end(void) { }
> +static inline void rcu_suppress_start(void) { }
> +static inline void rcu_suppress_end(void) { }
>  #endif /* #else #ifdef CONFIG_RCU_STALL_COMMON */
>  
>  #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index c5aa934de59b..a658955a1174 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -224,24 +224,25 @@ extern int rcu_cpu_stall_ftrace_dump;
>  extern int rcu_cpu_stall_suppress;
>  extern int rcu_cpu_stall_timeout;
>  extern int rcu_exp_cpu_stall_timeout;
> +extern atomic_t rcu_cpu_stall_suppress_dyn;
>  int rcu_jiffies_till_stall_check(void);
>  int rcu_exp_jiffies_till_stall_check(void);
>  
>  static inline bool rcu_stall_is_suppressed(void)
>  {
> -	return rcu_stall_is_suppressed_at_boot() || rcu_cpu_stall_suppress;
> +	return rcu_stall_is_suppressed_at_boot() ||
> +	       rcu_cpu_stall_suppress ||
> +	       atomic_read(&rcu_cpu_stall_suppress_dyn);
>  }
>  
>  #define rcu_ftrace_dump_stall_suppress() \
>  do { \
> -	if (!rcu_cpu_stall_suppress) \
> -		rcu_cpu_stall_suppress = 3; \

One thing we are losing here is the ability to see what is suppressing
the current stall, for example, from a crash dump.  Maybe that is OK,
as I haven't needed to debug that sort of thing.

Thoughts from those who have had this debugging experience?

> +	atomic_inc(&rcu_cpu_stall_suppress_dyn); \
>  } while (0)
>  
>  #define rcu_ftrace_dump_stall_unsuppress() \
>  do { \
> -	if (rcu_cpu_stall_suppress == 3) \
> -		rcu_cpu_stall_suppress = 0; \
> +	atomic_dec(&rcu_cpu_stall_suppress_dyn); \
>  } while (0)
>  
>  #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5653560573e2..260748bc5bc8 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -103,23 +103,25 @@ bool rcu_gp_might_be_stalled(void)
>  	return !time_before(j, READ_ONCE(rcu_state.gp_start) + d);
>  }
>  
> -/* Don't do RCU CPU stall warnings during long sysrq printouts. */
> -void rcu_sysrq_start(void)
> +/* Don't do RCU CPU stall warnings during functions holding the CPU
> + * for a long period of time such as long sysrq printouts.
> + */
> +void rcu_suppress_start(void)
>  {
> -	if (!rcu_cpu_stall_suppress)
> -		rcu_cpu_stall_suppress = 2;

And the same point here.

> +	atomic_inc(&rcu_cpu_stall_suppress_dyn);
>  }
> +EXPORT_SYMBOL_GPL(rcu_suppress_start);

If this is being exported to modules, the question of who suppressed
the CPU stalls might at some point become more urgent.

If the problem was reproducible, I would simply attach a BPF program to
rcu_suppress_start() and rcu_suppress_end() counting the stack traces of
all callers to these functions.  This might or might not make everyone
happy, though.

> -void rcu_sysrq_end(void)
> +void rcu_suppress_end(void)
>  {
> -	if (rcu_cpu_stall_suppress == 2)
> -		rcu_cpu_stall_suppress = 0;
> +	atomic_dec(&rcu_cpu_stall_suppress_dyn);
>  }
> +EXPORT_SYMBOL_GPL(rcu_suppress_end);
>  
>  /* Don't print RCU CPU stall warnings during a kernel panic. */
>  static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
>  {
> -	rcu_cpu_stall_suppress = 1;
> +	atomic_inc(&rcu_cpu_stall_suppress_dyn);
>  	return NOTIFY_DONE;
>  }
>  
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index f5e6a2f95a2a..ceee9d777384 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -501,11 +501,18 @@ EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
>  #ifdef CONFIG_RCU_STALL_COMMON
>  int rcu_cpu_stall_ftrace_dump __read_mostly;
>  module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
> -int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings.
> +
> +int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings from sysfs
>  EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
>  module_param(rcu_cpu_stall_suppress, int, 0644);
> +
> +atomic_t rcu_cpu_stall_suppress_dyn __read_mostly; // !0 = suppress stall warnings from functions
> +EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_dyn);
> +module_param_named(rcu_cpu_stall_suppress_dyn, rcu_cpu_stall_suppress_dyn.counter, int, 0444);

I am not seeing a valid use case for specifying an initial
value on the kernel command line.  Or does this somehow prevent
rcupdate.rcu_cpu_stall_suppress_dyn from being specified on the kernel
command line?

If something like rcupdate.rcu_cpu_stall_suppress_dyn=3 can be specified
(incorrectly, in my current view) on the kernel command line, maybe
something as shown below would help?

> +
>  int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
>  module_param(rcu_cpu_stall_timeout, int, 0644);
> +
>  int rcu_exp_cpu_stall_timeout __read_mostly = CONFIG_RCU_EXP_CPU_STALL_TIMEOUT;
>  module_param(rcu_exp_cpu_stall_timeout, int, 0644);
>  #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
> @@ -616,6 +623,8 @@ void __init rcupdate_announce_bootup_oddness(void)
>  		pr_info("\tAll grace periods are expedited (rcu_expedited).\n");
>  	if (rcu_cpu_stall_suppress)
>  		pr_info("\tRCU CPU stall warnings suppressed (rcu_cpu_stall_suppress).\n");
> +	if (atomic_read(&rcu_cpu_stall_suppress_dyn))
> +		pr_info("\tDynamic RCU CPU stall warnings suppressed (rcu_cpu_stall_suppress_dyn).\n");

Should this instead be a WARN_ON() placed somewhere so that it won't
mess up the printing of the other parameters?

Or maybe have this code set it to back to zero, with the message
indicating that this is being done?

>  	if (rcu_cpu_stall_timeout != CONFIG_RCU_CPU_STALL_TIMEOUT)
>  		pr_info("\tRCU CPU stall warnings timeout set to %d (rcu_cpu_stall_timeout).\n", rcu_cpu_stall_timeout);
>  	rcu_tasks_bootup_oddness();
> -- 
> 2.38.1
> 
