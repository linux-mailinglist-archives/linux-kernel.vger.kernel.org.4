Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F770E158
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbjEWQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbjEWQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:02:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF0C5;
        Tue, 23 May 2023 09:02:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E976D1FDE4;
        Tue, 23 May 2023 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684857761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cqLxfbe6m1nrIclFjUzmkz44DpKUbRwlhs98Py3OTY8=;
        b=CFqzXOj3bL7rPcBsBdnQq+i5O/CDOiB4nyZNA73SNAgWKZudQnAShHS3hyPjZMeVbo3Zg8
        JKxZ6KhMqP5e4g1LT0ZE4QYnnNKcDTQP5B5H4Eu5ag6gT1SFuEVSJvWaaLv8xs0RsmZ5Yd
        hNDc6rCkMBwtEvwv3PlapHOL2Tv73vk=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 921102C141;
        Tue, 23 May 2023 16:02:38 +0000 (UTC)
Date:   Tue, 23 May 2023 18:02:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 10/18] watchdog/hardlockup: Add a "cpu" param to
 watchdog_hardlockup_check()
Message-ID: <ZGzjm9h85fpYZJMc@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.10.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.10.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-05-19 10:18:34, Douglas Anderson wrote:
> In preparation for the buddy hardlockup detector where the CPU
> checking for lockup might not be the currently running CPU, add a
> "cpu" parameter to watchdog_hardlockup_check().
> 
> As part of this change, make hrtimer_interrupts an atomic_t since now
> the CPU incrementing the value and the CPU reading the value might be
> different. Technially this could also be done with just READ_ONCE and
> WRITE_ONCE, but atomic_t feels a little cleaner in this case.
> 
> While hrtimer_interrupts is made atomic_t, we change
> hrtimer_interrupts_saved from "unsigned long" to "int". The "int" is
> needed to match the data type backing atomic_t for hrtimer_interrupts.
> Even if this changes us from 64-bits to 32-bits (which I don't think
> is true for most compilers), it doesn't really matter. All we ever do
> is increment it every few seconds and compare it to an old value so
> 32-bits is fine (even 16-bits would be). The "signed" vs "unsigned"
> also doesn't matter for simple equality comparisons.
> 
> hrtimer_interrupts_saved is _not_ switched to atomic_t nor even
> accessed with READ_ONCE / WRITE_ONCE. The hrtimer_interrupts_saved is
> always consistently accessed with the same CPU. NOTE: with the
> upcoming "buddy" detector there is one special case. When a CPU goes
> offline/online then we can change which CPU is the one to consistently
> access a given instance of hrtimer_interrupts_saved. We still can't
> end up with a partially updated hrtimer_interrupts_saved, however,
> because we end up petting all affected CPUs to make sure the new and
> old CPU can't end up somehow read/write hrtimer_interrupts_saved at
> the same time.
> 
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -87,29 +87,34 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
>  
>  #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
>  
> -static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
> -static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
> +static DEFINE_PER_CPU(atomic_t, hrtimer_interrupts);
> +static DEFINE_PER_CPU(int, hrtimer_interrupts_saved);
>  static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
>  static unsigned long watchdog_hardlockup_all_cpu_dumped;
>  
> -static bool is_hardlockup(void)
> +static bool is_hardlockup(unsigned int cpu)
>  {
> -	unsigned long hrint = __this_cpu_read(hrtimer_interrupts);
> +	int hrint = atomic_read(&per_cpu(hrtimer_interrupts, cpu));
>  
> -	if (__this_cpu_read(hrtimer_interrupts_saved) == hrint)
> +	if (per_cpu(hrtimer_interrupts_saved, cpu) == hrint)
>  		return true;
>  
> -	__this_cpu_write(hrtimer_interrupts_saved, hrint);
> +	/*
> +	 * NOTE: we don't need any fancy atomic_t or READ_ONCE/WRITE_ONCE
> +	 * for hrtimer_interrupts_saved. hrtimer_interrupts_saved is
> +	 * written/read by a single CPU.
> +	 */
> +	per_cpu(hrtimer_interrupts_saved, cpu) = hrint;
>  
>  	return false;
>  }
>  
>  static void watchdog_hardlockup_kick(void)
>  {
> -	__this_cpu_inc(hrtimer_interrupts);
> +	atomic_inc(raw_cpu_ptr(&hrtimer_interrupts));

Is there any particular reason why raw_*() is needed, please?

My expectation is that the raw_ API should be used only when
there is a good reason for it. Where a good reason might be
when the checks might fail but the consistency is guaranteed
another way.

IMHO, we should use:

	atomic_inc(this_cpu_ptr(&hrtimer_interrupts));

To be honest, I am a bit lost in the per_cpu API definitions.

But this_cpu_ptr() seems to be implemented the same way as
per_cpu_ptr() when CONFIG_DEBUG_PREEMPT is enabled.
And we use per_cpu_ptr() in is_hardlockup().

Also this_cpu_ptr() is used more commonly:

$> git grep this_cpu_ptr | wc -l
1385
$> git grep raw_cpu_ptr | wc -l
114

>  }
>  
> -void watchdog_hardlockup_check(struct pt_regs *regs)
> +void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
>  {
>  	/*
>  	 * Check for a hardlockup by making sure the CPU's timer
> @@ -117,35 +122,42 @@ void watchdog_hardlockup_check(struct pt_regs *regs)
>  	 * fired multiple times before we overflow'd. If it hasn't
>  	 * then this is a good indication the cpu is stuck
>  	 */
> -	if (is_hardlockup()) {
> +	if (is_hardlockup(cpu)) {
>  		unsigned int this_cpu = smp_processor_id();
> +		struct cpumask backtrace_mask = *cpu_online_mask;

Does this work, please?

IMHO, we should use cpumask_copy().

>  
>  		/* Only print hardlockups once. */
> -		if (__this_cpu_read(watchdog_hardlockup_warned))
> +		if (per_cpu(watchdog_hardlockup_warned, cpu))
>  			return;
>  

Otherwise, it looks good to me.

Best Regards,
Petr
