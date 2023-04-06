Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA20B6D947D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbjDFKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDFKzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:55:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C365B6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=yURwplSdjGa62e3szWhgSzg84+YzkegGjB1Wwf/yvzQ=; b=ADvU4cjOEkuaJ9UQhCdQ3PGPKK
        4Yz+nnrh2V3n8CGMkb+c2FWLho3HWy0yBFgaVgkbzQ0LIHDCH/VIvEi4dcoOeq8wUuyy1v+m48eV5
        mFFColnEC0DyerdDDvsqhKWoLALv+1KsGrpb0MzX6xVLvTTOQ6m+/J/Ve3OSY0bnLeKFO9qQulMaN
        vqnVhDUQvQy3flxONsxX2Fb8p3YVOTZmy3dvYzZ72uecT6BHVq0fNBoe6MbFxKxyA8U5TldqLAPnM
        IAa+3CtXzU+eZJ/TOBNv56mZ4ECfhFVM3bdyZVdOHOJqN1C8QODGjwj9RWaTH4RE5JPV/k1i+OLO8
        aRsmEqOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkNH9-00AVMd-2T;
        Thu, 06 Apr 2023 10:55:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24557300194;
        Thu,  6 Apr 2023 12:55:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0782200A7ECE; Thu,  6 Apr 2023 12:55:29 +0200 (CEST)
Date:   Thu, 6 Apr 2023 12:55:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] tick_sched_timer() is not properly aligned, fixed by chance
Message-ID: <20230406105529.GB392176@hirez.programming.kicks-ass.net>
References: <20230406095735.0_14edn3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230406095735.0_14edn3@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 11:57:35AM +0200, Sebastian Andrzej Siewior wrote:
> With HIGHRES enabled tick_sched_timer() is programmed every jiffy to
> expire the timer_list timers. This timer is programmed accurate in
> respect to CLOCK_MONOTONIC so that 0 is the first tick and the next one
> is 1000/CONFIG_HZ ms later. For HZ=250 every 4 ms and so the us/ns part
> of the timer is always 0. This can be observed by enabling hrtimer_start
> events and looking for the tick_sched_timer timer:
> 
> | <idle>-0 [009] 137.085041: hrtimer_start: hrtimer=000000002df4f2bc function=tick_sched_timer expires=162784000000 softexpires=162784000000 mode=0xa
> | <idle>-0 [026] 137.085300: hrtimer_start: hrtimer=00000000b0911b5d function=tick_sched_timer expires=316384000000 softexpires=316384000000 mode=0xa
> 
> The lower part (us, ns) is zero. This is important for certain work
> loads where it is needed to either align with the timer or hide after
> it.
> 
> With commit
> 	857baa87b6422 ("sched/clock: Enable sched clock early")
> 
> merged into v4.19-rc1 this 0 offset is gone. The problematic part is the
> last hunk of the patch:
> 
> |@@ -356,7 +374,7 @@ u64 sched_clock_cpu(int cpu)
> |                return sched_clock() + __sched_clock_offset;
> |
> |        if (unlikely(!sched_clock_running))
> |-               return 0ull;
> |+               return sched_clock();
> |
> |        preempt_disable_notrace();
> |        scd = cpu_sdc(cpu);
> 
> which returns the sched_clock() without any offset. The gain of this is
> the high resolution output of the bootlog very early, so we see something
> like this:
> |[    0.000000] tsc: Detected 1995.083 MHz processor
> |[    0.000893] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> |[    0.008179] e820: remove [mem 0x000a0000-0x000fffff] usable
> |[    0.014395] last_pfn = 0xa40000 max_arch_pfn = 0x400000000
> |[    0.020667] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> |[    0.029822] last_pfn = 0xbe000 max_arch_pfn = 0x400000000
> |[    0.050770] found SMP MP-table at [mem 0x000fd2a0-0x000fd2af]
> |[    0.057015] Kernel/User page tables isolation: disabled on command line.
> |[    0.064452] Using GB pages for direct mapping
> |[    0.070337] RAMDISK: [mem 0x32d23000-0x35688fff]
> |[    0.075298] ACPI: Early table checksum verification disabled
> …
> |[    1.662577] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> |[    1.687317] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x398412f243e, max_idle_ns: 881590620736 ns
> |[    1.699071] Calibrating delay loop (skipped), value calculated using timer frequency.. 3990.16 BogoMIPS (lpj=7980332)
> |[    1.703070] pid_max: default: 32768 minimum: 301
> |[    1.707238] LSM: Security Framework initializing
> 
> but the tick_sched_timer() is no longer properly aligned:
> | <idle>-0 [002] 131.286274: hrtimer_start: hrtimer=000000000b8c5637 function=tick_sched_timer expires=130680348871 softexpires=130680348871 mode=0xa
> | <idle>-0 [006] 131.286275: hrtimer_start: hrtimer=00000000e08369e4 function=tick_sched_timer expires=317880348871 softexpires=317880348871 mode=0xa

But how ?!? Why does sched_clock() affect the tick_sched_timer() offset?

/me reads on

> instead of 0 we have "348871" here. I consider this as a bug given that
> this important.
> 
> Then PeterZ had other problems and committed
> 	776f22913b8e5 ("sched/clock: Make local_clock() noinstr")
> 
> which is part of v6.3-rc1. The important part here is (again) the last
> hunk, the local_clock() implementation:
> 
> |noinstr u64 local_clock(void)
> |{
> |       u64 clock;
> |
> |       if (static_branch_likely(&__sched_clock_stable))
> |               return sched_clock() + __sched_clock_offset;
> |
> |       preempt_disable_notrace();
> |       clock = sched_clock_local(this_scd());
> |       preempt_enable_notrace();
> |
> |       return clock;
> |}

And this morning I found:

https://lore.kernel.org/all/20230406040847.569970-1-dev@aaront.org/T/#u

that 'fixes' that :-)

> The tick_sched_timer story is that it uses ktime_get() to set the

But but but, ktime_get() does not use sched_clock(), it has it's own TSC
reader.

> initial expire time and then always incremented. If the returned value
> is jiffy-based then it will work as expected. If it has higher precision
> then the time has to be adjusted since it is not expected.
> 
> So, what do we do?
> - We would need to provide stable patches for v4.19…v6.1 to address the
>   timer issue.
> 
> - The high precision timestamps during boot are gone. Is it important to
>   bring that back? Or could that new local_clock() implementation be
>   backported?
> 
> - An alternative is to ensure that the time returned by ktime_get() in
>   tick_setup_device() is aligned with zeros.

The last one I think, let me try and figure out how sched_clock()
behaviour makes a different at all -- this is not making sense.
