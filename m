Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137CA607D80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJUR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJUR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:27:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEE3256423;
        Fri, 21 Oct 2022 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666373243; x=1697909243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yppm1glbNgAHRD2YCTGWJOZ7YZvAQtdedMjfPqB8im4=;
  b=mlp9b52OBi/DV+22GWsaWVUYKKaL1t7Hkg5zcknoKT/sXakOLr9uBVBm
   9tsQCeo5wXuoM35e5Jg7+ARN1CMtrEucR0qKmQDw3tOsIVXdTvuXEmXFn
   JY6OIp2NG87cq41CsZOonaw7z4nVSf0xWQDJ8xwjLKFD8aAYO73cPKz1F
   wMbfGFq0X81wY5+59MTneJ29rPMFnheWJrnEzWw+S7XwHJPpngGu/W7Rn
   3upuHzaObNc63LN2A8HdQdHf7/TXQRnW7vV9JTLRW/n12BjChn4+ktXBP
   mBcdlNTcUXXszJN+cdkALX+fW9qMjRfARFcn2GCcq/rEL8Y/W9V03ed88
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307050358"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="307050358"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:27:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581685486"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="581685486"
Received: from thnguy1-mobl2.amr.corp.intel.com (HELO [10.209.91.210]) ([10.209.91.210])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 10:27:21 -0700
Message-ID: <44b41091-d474-9f80-fcf1-93c8d1316272@intel.com>
Date:   Fri, 21 Oct 2022 10:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221014180506.211592-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 11:05, Guilherme G. Piccoli wrote:
> Commit b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
> changed the way the split lock detector works when in "warn" mode;
> basically, not only it shows the warn message, but also intentionally
> introduces a slowdown (through sleeping plus serialization mechanism)
> on such task. Based on discussions in [0], seems the warning alone
> wasn't enough motivation for userspace developers to fix their
> applications.
> 
> Happens that originally the proposal in [0] was to add a new mode
> which would warns + slowdown the "split locking" task, keeping the
> old warn mode untouched. In the end, that idea was discarded and
> the regular/default "warn" mode now slowdowns the applications. This
> is quite aggressive with regards proprietary/legacy programs that
> basically are unable to properly run in kernel with this change.
> While is understandable that a malicious application could try a DoS
> by split locking, it seems unacceptable to regress old/proprietary
> userspace programs through a default configuration that previously
> worked. An example of such breakage was reported in [1].
> 
> So let's add a sysctl to allow controlling the "misery mode" behavior,
> as per Thomas suggestion on [2]. This way, users running legacy and/or
> proprietary software are allowed to still execute them with a decent
> performance while still observe the warning messages on kernel log.
> 
> [0] https://lore.kernel.org/lkml/20220217012721.9694-1-tony.luck@intel.com/
> 
> [1] https://github.com/doitsujin/dxvk/issues/2938
> 
> [2] https://lore.kernel.org/lkml/87pmf4bter.ffs@tglx/
> 
> Fixes: b041b525dab9 ("x86/split_lock: Make life miserable for split lockers")
> Cc: Andre Almeida <andrealmeid@igalia.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Joshua Ashton <joshua@froggi.es>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Paul Gofman <pgofman@codeweavers.com>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Pierre-Loup Griffais <pgriffais@valvesoftware.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Zebediah Figura <zfigura@codeweavers.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> V2:
> - Switched to sysctl approach following Thomas' suggestion (thanks!).
> 
> Andre tested the patch and will comment in this thread - seems everything is
> working as expected and we can enable/disable that, affecting the misery mode
> as one expects.
> 
> I've tried to keep the semaphore's up()/down() calls in-sync/paired, hence
> my approach of two delayed tasks, with and without misery.
> 
> Reviews / comments are greatly appreciated.
> Thanks,
> 
> 
> Guilherme
> 
> 
>  Documentation/admin-guide/sysctl/kernel.rst | 18 ++++++
>  arch/x86/kernel/cpu/intel.c                 | 61 +++++++++++++++++----
>  2 files changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ee6572b1edad..508952e42914 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1298,6 +1298,24 @@ watchdog work to be queued by the watchdog timer function, otherwise the NMI
>  watchdog — if enabled — can detect a hard lockup condition.
>  
>  
> +split_lock_mitigate (x86 only)
> +=============
> +
> +For x86 CPUs supporting the split lock detection mechanism, this parameter
> +allows the users to turn off what is called "the misery mode", which
> +introduces intentional delay in userspace applications that split locks.
> +The goal of the misery mode is to prevent using such unaligned access to
> +DoS the system dropping the performance overall, but some of these split
> +locking programs are legacy and/or proprietary software that cannot be fixed,
> +so using this sysctl is a way to allow them to run with a decent performance.

I think this is missing a lot of context.  End users looking here won't
even know what a split lock *is*.  Please either refer over to the real
documentation on this issue or write a brief description about what's
going on.

How about this?

	On x86, each "split lock" imposes a system-wide performance
	penalty.  On larger systems, large numbers of split locks from
	unprivileged users can result in denials of service to well-
	behaved and potentially more important users.

	The kernel mitigates these bad users by detecting split locks
	and imposing penalties: forcing them to wait and only allowing
	one core to execute split locks at a time.

	These mitigations can make those bad applications unbearably
	slow.  Setting split_lock_mitigate=0 may restore some
	application performance, but will also increase system exposure
	to denial of service attacks from split lock users.

> += ===================================================================
> +0 Disables the misery mode - just warns the split lock on kernel log.

... and exposes the system to Denial-of-Service attacks.  That's an
awfully big side-effect to not mention.

> +1 Enables the misery mode (this is the default) - penalizes the split
> +  lockers with intentional performance degradation.
> += ===================================================================

As much as I love the misery terminology, let's try to use one term.
Let's either call it "misery" *or* "mitigations", not both.

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 2d7ea5480ec3..2aacf9d6c723 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1034,8 +1034,32 @@ static const struct {
>  
>  static struct ratelimit_state bld_ratelimit;
>  
> +static unsigned int sysctl_sld_mitigate = 1;
>  static DEFINE_SEMAPHORE(buslock_sem);
>  
> +#ifdef CONFIG_PROC_SYSCTL
> +static struct ctl_table sld_sysctls[] = {
> +	{
> +		.procname       = "split_lock_mitigate",
> +		.data           = &sysctl_sld_mitigate,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler	= proc_douintvec_minmax,
> +		.extra1         = SYSCTL_ZERO,
> +		.extra2         = SYSCTL_ONE,
> +	},
> +	{}
> +};
> +
> +static int __init sld_mitigate_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", sld_sysctls);
> +	return 0;
> +}
> +
> +late_initcall(sld_mitigate_sysctl_init);
> +#endif
> +
>  static inline bool match_option(const char *arg, int arglen, const char *opt)
>  {
>  	int len = strlen(opt), ratelimit;
> @@ -1146,11 +1170,18 @@ static void split_lock_init(void)
>  		split_lock_verify_msr(sld_state != sld_off);
>  }
>  
> -static void __split_lock_reenable(struct work_struct *work)
> +static void __split_lock_reenable_sem(struct work_struct *work)
>  {

"sem" is a pretty crummy name.  Wouldn't

	__split_lock_reenable_unlock()

be much more clear?

>  	sld_update_msr(true);
>  	up(&buslock_sem);
>  }
> +static DECLARE_DELAYED_WORK(split_lock_reenable_sem, __split_lock_reenable_sem);
> +
> +static void __split_lock_reenable(struct work_struct *work)
> +{
> +	sld_update_msr(true);
> +}
> +static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);

Better yet, do you *really* need two functions and two
DECLARE_DELAYED_WORK()'s?

You could have a single delayed_work, and then just do:

static void split_lock_warn(unsigned long ip)
{
	bool need_release_sem = false;
	...

	if (down_interruptible(&buslock_sem) == -EINTR)
		return;
	need_release_sem = true;


Then, farther down, you do:

	split_lock_reenable->data = need_release_sem;
	schedule_delayed_work_on(cpu, &split_lock_reenable);

Then, in the work func:
	
	bool need_release_sem = work->data;

	if (need_release_sem)
		up(...);

That's nice and compact.  It's also logically easy to follow because you
can see how the need_release_sem gets set only after the
down_interruptible().  It's also nice to have both sites share the
'need_release_sem' naming for grepping.

>  /*
>   * If a CPU goes offline with pending delayed work to re-enable split lock
> @@ -1169,10 +1200,9 @@ static int splitlock_cpu_offline(unsigned int cpu)
>  	return 0;
>  }
>  
> -static DECLARE_DELAYED_WORK(split_lock_reenable, __split_lock_reenable);
> -
>  static void split_lock_warn(unsigned long ip)
>  {
> +	struct delayed_work *wk;

I think we can spare two bytes to make this "work".

>  	int cpu;
>  
>  	if (!current->reported_split_lock)
> @@ -1180,14 +1210,25 @@ static void split_lock_warn(unsigned long ip)
>  				    current->comm, current->pid, ip);
>  	current->reported_split_lock = 1;
>  
> -	/* misery factor #1, sleep 10ms before trying to execute split lock */
> -	if (msleep_interruptible(10) > 0)
> -		return;
> -	/* Misery factor #2, only allow one buslocked disabled core at a time */
> -	if (down_interruptible(&buslock_sem) == -EINTR)
> -		return;
> +	if (sysctl_sld_mitigate) {
> +		/*
> +		 * misery factor #1:
> +		 * sleep 10ms before trying to execute split lock.
> +		 */
> +		if (msleep_interruptible(10) > 0)
> +			return;
> +		/*
> +		 * Misery factor #2:
> +		 * only allow one buslocked disabled core at a time.
> +		 */
> +		wk = &split_lock_reenable_sem;
> +		if (down_interruptible(&buslock_sem) == -EINTR)
> +			return;

It's a little confusing to set:

	wk = &split_lock_reenable_sem;

and then not use it.

I'd probably set it below the lock check and return.

> +	} else
> +		wk = &split_lock_reenable;

Brackets, please:

	} else {
		wk = &split_lock_reenable;
	}

(if you keep this hunk).

>  	cpu = get_cpu();
> -	schedule_delayed_work_on(cpu, &split_lock_reenable, 2);
> +	schedule_delayed_work_on(cpu, wk, 2);
>  
>  	/* Disable split lock detection on this CPU to make progress */
>  	sld_update_msr(false);

