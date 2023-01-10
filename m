Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F795663D35
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbjAJJqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjAJJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:46:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A94E75;
        Tue, 10 Jan 2023 01:46:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 52636207BC;
        Tue, 10 Jan 2023 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673343966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OyS1qe+VqYApjk1lqv3E1gNDUdYRJwjdaxOzlVXlyX0=;
        b=RZW5MZXNI+Pty6W7CDi+pmRNPgMKptPSzltayhHHAcZJis+fEhRJktgnjmUMKNCFbiwlje
        ZOEGVbNrnJ46KbpMi2H0H7lfcinA1iOGYMIA5Zp2MOXx65nu6YS5X6T+wrOoEPQLPN5Sys
        XjnOSDBg2wkWHhlS1DxK1SBKPWsyS18=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 36AF02C141;
        Tue, 10 Jan 2023 09:46:06 +0000 (UTC)
Date:   Tue, 10 Jan 2023 10:46:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y70z2/0w05jnUiK7@alley>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
 <Y7wZSxw+Ys5MNf8g@alley>
 <b06140e6-e945-997a-54cb-9c7526d9e419@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06140e6-e945-997a-54cb-9c7526d9e419@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-10 12:05:20, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/1/9 21:40, Petr Mladek wrote:
> > On Wed 2022-12-28 09:45:11, Zhen Lei wrote:
> >> [T58] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
> >> The execution time of function kallsyms_on_each_match_symbol() is very
> >> short, about ten microseconds, the probability of this process being
> >> interrupted is very small. And even if it happens, we just have to try
> >> again.
> >>
> >> The execution time of function kallsyms_on_each_symbol() is very long,
> >> it takes tens of milliseconds, context switches is likely occur during
> >> this period. If the time obtained by task_cputime() is accurate, it is
> >> preferred. Otherwise, use local_clock() directly, and the time taken by
> >> irqs and high-priority tasks is not deducted because they are always
> >> running for a short time.
> >>
> >> --- a/kernel/kallsyms_selftest.c
> >> +++ b/kernel/kallsyms_selftest.c
> >> +	/*
> >> +	 * The test thread has been bound to a fixed CPU in advance. If the
> >> +	 * number of irqs does not change, no new scheduling request will be
> >> +	 * generated. That is, the performance test process is atomic.
> >> +	 */
> >> +	do {
> >> +		nr_irqs = kstat_cpu_irqs_sum(cpu);
> >> +		cond_resched();
> >> +		t0 = local_clock();
> >> +		kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
> >> +		t1 = local_clock();
> >> +	} while (nr_irqs != kstat_cpu_irqs_sum(cpu));
> > 
> > Huh, is this guaranteed to ever finish?
> > 
> > What if there is a regression and kallsyms_on_each_match_symbol()
> > never finishes without rescheduling?
> 
> The execution time of kallsyms_on_each_match_symbol() does not exceed 10 us.
> Assume that an interrupt is generated every 100 us(10000 interrupts are generated
> per second, it is very high). In this case, interrupts and high-priority tasks need
> to run for more than 90 us each time to cause the loop cannot exit normally.
> However, the CPU usage is 90+%, which is unreasonable.
> 
> Function kallsyms_on_each_symbol() takes a long time, about 20 milliseconds, and
> I'm already using task_cputime().

IMHO, this is a wrong mind set.

After all, this tests a function that was optimized because it took to
long. The function even contains cond_resched() because it caused
problems. I know that kallsyms_on_each_match_symbol() is
faster because it searches only one module but still.

The cond_resched() called before taking t0 is just a horrible
non-reliable hack.

I have seen many problematic non-reliable tests that relayed
on timing. They just hooped for the best. I am sure that we could
do better.

> > This is yet another unreliable hack.
> > 
> > 
> > Use standard solution:
> > 
> > I did the homework for you and checked how the "time" command
> > measures the time spend in the system. It actually uses more methods.
> > 
> > One is times() syscall. It uses thread_group_cputime_adjusted(), see
> > do_sys_times() in kernel/sys.c
> > 
> > Or it uses wait4() syscall to get struct rusage that provides this
> > information.
> > 
> > Please, stop inventing crazy hacks, and use these standard methods.
> > If the "time" tool is enough for userspace performance tests
> > then it must be enough in this case as well.
> 
> Okay, I'll study in depth, just worried about the different precision
> requirements.

If the problem is a timer precision then the solution would be
to repeat the operation more times or use better clock source.
It is actually a good practice to repeat the action more times
in performance tests because it helps to reduce noise.

Well, thread_group_cputime_adjusted() works with
struct task_cputime. It seems to store the time in nano-seconds,
see include/linux/sched/types.h. I might be wrong but I would expect
that it is accurate and precise enough.

> By the way, we still have to actively embrace new things.
> 
> In fact, I've thought of another way, which is to measure nine times,
> sort in ascending order, and take the middle one. Based on probabilistic
> statistics, the intermediate results are reliable.
> > 
> > Or remove this test:
> > 
> > Seriously, what is the value of this test?
> > Is anyone going to use it at all in the future?
> 
> There's really someone interested in performance data.
> https://lkml.org/lkml/2022/12/15/134

I know. But this code had very bad performance for years
and nobody cared. I am not sure if anyone would care
about the info printed by this selftest.

I am not sure if it is worth the effort. We have already
spent quite some time with attempts to make it usable
and are still not there.

Best Regards,
Petr
