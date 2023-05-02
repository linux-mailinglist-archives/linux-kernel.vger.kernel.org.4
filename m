Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB356F4715
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjEBP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjEBP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:26:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1026BC;
        Tue,  2 May 2023 08:26:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A531421B0D;
        Tue,  2 May 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683041179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXWn7FssbrSs8MRrutlOtshdeBbrP/crYQCwv1Iexd0=;
        b=XxDdHFZlQui1F2WlF8bhbf41oWW6Fr9rAfk13WKktw/+Jtw97yL5A1Sttz4uqgqOcjRNii
        pj4J+Cp+HRg6BC0SrBdlXBmUXIj6XkAHYUWf0RbaKYkK6ZbWB8Cclv6Li0bhCJwINGjccy
        EBYuacjqAOW4uoLsHujhtJf/7MKOnXE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA2872C141;
        Tue,  2 May 2023 15:26:18 +0000 (UTC)
Date:   Tue, 2 May 2023 17:26:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ian Rogers <irogers@google.com>, ravi.v.shankar@intel.com,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        ricardo.neri@intel.com, Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Chen-Yu Tsai <wens@csie.org>, Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: shared code: was: Re: [PATCH v3] hardlockup: detect hard lockups
 using secondary (buddy) CPUs
Message-ID: <ZFErmshcrcikrSU1@alley>
References: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501082341.v3.1.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-05-01 08:24:46, Douglas Anderson wrote:
> From: Colin Cross <ccross@android.com>
> 
> Implement a hardlockup detector that doesn't doesn't need any extra
> arch-specific support code to detect lockups. Instead of using
> something arch-specific we will use the buddy system, where each CPU
> watches out for another one. Specifically, each CPU will use its
> softlockup hrtimer to check that the next CPU is processing hrtimer
> interrupts by verifying that a counter is increasing.
> 
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -134,6 +144,7 @@ void lockup_detector_reconfigure(void);
>  static inline void touch_nmi_watchdog(void)
>  {
>  	arch_touch_nmi_watchdog();
> +	buddy_cpu_touch_watchdog();

	touch_buddy_watchdog();    ??? to follow the naming scheme?

>  	touch_softlockup_watchdog();
>  }
>  
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -106,6 +108,13 @@ void __weak watchdog_nmi_disable(unsigned int cpu)
>  	hardlockup_detector_perf_disable();
>  }
>  
> +#else
> +
> +int __weak watchdog_nmi_enable(unsigned int cpu) { return 0; }
> +void __weak watchdog_nmi_disable(unsigned int cpu) { return; }

Honestly, the mix of softlockup and hardlockup code was a hard to
follow even before this patch. And it is going to be worse.

Anyway, the buddy watchdog is not using NMI at all. It should not
get enable using a function called *_nmi_enabled().

Also some comments are not longer valid, for example:

static void watchdog_enable(unsigned int cpu)
{
[...]
	/* Enable the perf event */
	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
		watchdog_nmi_enable(cpu);


I do not know. Maybe, fixing the mess is beyond any hope.
But we shold not make it worse.

I suggest to rename/shuffle at least functions touched
by this patchset to improve the meaning.

Sigh, it is hard to find a reasonable names. The code
already uses:

    + watchdog_*
    + watchdog_nmi_

    + softlockup_*

    + lockup_detector_*
    + hardlockup_detector_perf_*

and sysctl:

		.procname       = "watchdog",
		.procname	= "watchdog_thresh",
		.procname       = "nmi_watchdog",
		.procname	= "watchdog_cpumask",
		.procname       = "soft_watchdog",
		.procname	= "softlockup_panic",
		.procname	= "softlockup_all_cpu_backtrace",
		.procname	= "hardlockup_panic",
		.procname	= "hardlockup_all_cpu_backtrace",


So, I suggest, to use the names:


    + watchdog_*

	+ for the common infrastructure
	+ keep it in watchdog.c

    + hardlockup_detector_* or
      hardlockup_watchdog_* or
      watchdog_hld_*

	+ for the common hardlockup stuff.
	+ it t can stay in watchdog.c to keep shuffling bearable


    + hardlockup_detector_nmi_* or
      hardlockup_watchdog_nmi_* or
      watchdog_hld_nmi_* or
      watchdog_nmi_*

	+ for the arch specific hardlockup stuff that is
	  using NMI interrupts.

	+ it might either stay in watchdog_hld.c
	  or be moved to watchdog_nmi.c or
	  watchdog_hld_nmi.c

    + hardlockup_detector_buddy_* or
      hardlockup_watchdog_buddy_* or
      watchdog_hld_buddy_*
      watchdog_buddy_*

	+ for the arch specific hardlockup stuff that is
	  using buddy monitoring

	+ it might either be added to watchdog_hld.c
	  or be moved to watchdog_buddy.c or
	  watchdog_hld_buddy.c


Opinion:

     The buddy watchdog might actually be used also for
     softlockup detector. So, watchdog_buddy_* API
     and watchdog_buddy.c might make sense.


> +
> +#endif /* CONFIG_HARDLOCKUP_DETECTOR */
> +
>  /* Return 0, if a NMI watchdog is available. Error code otherwise */
>  int __weak __init watchdog_nmi_probe(void)
>  {
> @@ -364,6 +373,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  	/* kick the hardlockup detector */
>  	watchdog_interrupt_count();
>  
> +	/* test for hardlockups */
> +	watchdog_check_hardlockup();

  rename watchdog_buddy_check_hardlockup(); ???

> +
>  	/* kick the softlockup detector */
>  	if (completion_done(this_cpu_ptr(&softlockup_completion))) {
>  		reinit_completion(this_cpu_ptr(&softlockup_completion));
> --- /dev/null
> +++ b/kernel/watchdog_buddy_cpu.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/kernel.h>
> +#include <linux/nmi.h>
> +#include <linux/percpu-defs.h>
> +
> +static DEFINE_PER_CPU(bool, watchdog_touch);
> +static DEFINE_PER_CPU(bool, hard_watchdog_warn);
> +static cpumask_t __read_mostly watchdog_cpus;
> +
> +static unsigned long hardlockup_allcpu_dumped;
> +
> +int __init watchdog_nmi_probe(void)
> +{
> +	return 0;
> +}

This is pretty strange. It shows that it was added a hacky way.

> +
> +notrace void buddy_cpu_touch_watchdog(void)
> +{
> +	/*
> +	 * Using __raw here because some code paths have
> +	 * preemption enabled.  If preemption is enabled
> +	 * then interrupts should be enabled too, in which
> +	 * case we shouldn't have to worry about the watchdog
> +	 * going off.
> +	 */
> +	raw_cpu_write(watchdog_touch, true);
> +}
> +EXPORT_SYMBOL_GPL(buddy_cpu_touch_watchdog);

Cut&pasted arch_touch_nmi_watchdog().

> +
> +static unsigned int watchdog_next_cpu(unsigned int cpu)
> +{
> +	cpumask_t cpus = watchdog_cpus;
> +	unsigned int next_cpu;
> +
> +	next_cpu = cpumask_next(cpu, &cpus);
> +	if (next_cpu >= nr_cpu_ids)
> +		next_cpu = cpumask_first(&cpus);
> +
> +	if (next_cpu == cpu)
> +		return nr_cpu_ids;
> +
> +	return next_cpu;
> +}
> +
[...]
> +static int is_hardlockup_buddy_cpu(unsigned int cpu)
> +{
> +	unsigned long hrint = per_cpu(hrtimer_interrupts, cpu);
> +
> +	if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
> +		return 1;
> +
> +	per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
> +	return 0;

This is cut&pasted is_hardlockup(). And the __this_cpu_* API
is replaced by per_cpu_* API.

> +}
> +
> +void watchdog_check_hardlockup(void)
> +{
> +	unsigned int next_cpu;
> +
> +	/*
> +	 * Test for hardlockups every 3 samples. The sample period is
> +	 *  watchdog_thresh * 2 / 5, so 3 samples gets us back to slightly over
> +	 *  watchdog_thresh (over by 20%).
> +	 */
> +	if (__this_cpu_read(hrtimer_interrupts) % 3 != 0)
> +		return;
> +
> +	/* check for a hardlockup on the next CPU */
> +	next_cpu = watchdog_next_cpu(smp_processor_id());
> +	if (next_cpu >= nr_cpu_ids)
> +		return;
> +
> +	/* Match with smp_wmb() in watchdog_nmi_enable() / watchdog_nmi_disable() */
> +	smp_rmb();
> +
> +	if (per_cpu(watchdog_touch, next_cpu) == true) {
> +		per_cpu(watchdog_touch, next_cpu) = false;
> +		return;
> +	}
> +
> +	if (is_hardlockup_buddy_cpu(next_cpu)) {
> +		/* only warn once */
> +		if (per_cpu(hard_watchdog_warn, next_cpu) == true)
> +			return;
> +
> +		/*
> +		 * Perform all-CPU dump only once to avoid multiple hardlockups
> +		 * generating interleaving traces
> +		 */
> +		if (sysctl_hardlockup_all_cpu_backtrace &&
> +				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
> +			trigger_allbutself_cpu_backtrace();
> +
> +		if (hardlockup_panic)
> +			panic("Watchdog detected hard LOCKUP on cpu %u", next_cpu);
> +		else
> +			WARN(1, "Watchdog detected hard LOCKUP on cpu %u", next_cpu);
> +
> +		per_cpu(hard_watchdog_warn, next_cpu) = true;
> +	} else {
> +		per_cpu(hard_watchdog_warn, next_cpu) = false;

Also this cut&pastes a lots of code from watchdog_overflow_callback().

I wonder if we could somehow share the code between the two hardlockup
detectors. It would be win-win. It might help a lot with maintenance.

Best Regards,
Petr
