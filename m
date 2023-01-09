Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88B66629D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAIP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjAIP0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:26:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6821F24F;
        Mon,  9 Jan 2023 07:26:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 240251042;
        Mon,  9 Jan 2023 07:27:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC3B03F587;
        Mon,  9 Jan 2023 07:26:37 -0800 (PST)
Date:   Mon, 9 Jan 2023 15:26:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: Expected rdpmc behavior during context swtich and a RISC-V
 conundrum
Message-ID: <Y7wyI5fBN6yOIzop@FVFF77S0Q05N>
References: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
 <Y7gN32eHJNyWBvVD@FVFF77S0Q05N>
 <CAOnJCULGM=JvOtoRQM8gY3w3oSDhto=VwfgqcL+cb=er6d=dgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCULGM=JvOtoRQM8gY3w3oSDhto=VwfgqcL+cb=er6d=dgQ@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 01:06:45AM -0800, Atish Patra wrote:
> On Fri, Jan 6, 2023 at 4:02 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Jan 05, 2023 at 11:59:24AM -0800, Atish Patra wrote:
> > > Hi All,
> > > There was a recent uabi update[1] for RISC-V that allows the users to
> > > read cycle and instruction count without any checks.
> > > We tried to restrict that behavior to address security concerns
> > > earlier but it resulted in breakage for some user space
> > > applications[2].
> > > Thus, previous behavior was restored where a user on RISC-V platforms
> > > can directly read cycle or instruction count[3].
> > >
> > > Comparison with other ISAs w.r.t user space access of counters:
> > > ARM64
> > >   -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
> > >   -- Only for task bound events configured via perf.
> > >
> > > X86
> > >  --- rdpmc instruction
> > >  --- Enable/Disable via “/sys/devices/cpu/rdpmc”
> > > -- Before v4.0
> > >  -- any process (even without active perf event) rdpmc
> > > After v4.0
> > > -- Default behavior changed to support only active events in a
> > > process’s context.
> > > -- Configured through perf similar to ARM64
> > > -- Continue to maintain backward compatibility for unrestricted access
> > > by writing 2 to “/sys/devices/cpu/rdpmc”
> > >
> > > IMO, RISC-V should only enable user space access through perf similar
> > > to ARM64 and x86 (post v4.0).
> > > However, we do have to support the legacy behavior to avoid
> > > application breakage.
> > > As per my understanding a direct user space access can lead to the
> > > following problems:
> > >
> > > 1) There is no context switch support, so counts from other contexts are exposed
> > > 2) If a perf user is allocated one of these counters, the counter
> > > value will be written
> > >
> > > Looking at the x86 code as it continues to allow the above behavior,
> > > rdpmc_always_available_key is enabled in the above case. However,
> > > during the context switch (cr4_update_pce_mm)
> > > only dirty counters are cleared. It only prevents leakage from perf
> > > task to rdpmc task.
> > >
> > > How does the context switch of counters work for users who enable
> > > unrestricted access by writing 2 to “/sys/devices/cpu/rdpmc” ?
> > > Otherwise, rdpmc users likely get noise from other applications. Is
> > > that expected ?
> >
> > Regardless of leakage, they're also going to get random jumps in the visible
> > values of the cycle count and instruction count as the task is context-switched
> > (and/or if those values get reset across idle, as can happen on arm64), so
> > those aren't going to be useful unless a number of other constraints apply.
> >
> 
> Agreed.
> 
> > AFAICT the affected package was actually a library of intrinsics; does this
> > affect a real application, or was this just in tests? If it's the latter there
> > might still be scope to properly lock this down...
> >
> 
> Unfortunately, there are real applications In RISC-V started using
> cycle counters due to legacy reasons.
> 
> Here is the short list from debian repo pointed out in [1]
> https://codesearch.debian.net/search?q=%22rdcycle+%250%22

The first of those is GRUB, when running bare metal.

The second is this library again, which is not a whole application.

I see that it's used in some benchmarks in real applications, e.g. firefox,
chrome. However, as above we know that's *broken* today.

Is that code actually run?

> Looking at aarch64 code in one of the application, it seems they rely
> on reading "pmccntr_el0" to read time
> https://sources.debian.org/src/chromium/108.0.5359.124-1/third_party/ffmpeg/libavutil/aarch64/timer.h/

That part is under ifdefs for mac os:

| #if defined(__APPLE__)

... and it's nonsensical anyway, pmccntr_el0 is *not* a timer, and I don't know
if Mac OS would bother to context-switch the value, so it's very likely broken
anyhow.

> AFAIK, any counter access from EL0 is disabled by default in
> reset_pmuserenr_el0 and should be enabled via the
> proc/sys/perf_user_access
> in armv8pmu_enable_user_access. Is that correct ?

Yes, we *only* enable access for tasks doing self-monitoring via perf.

No other useage makes sense, since the value is arbitrarily reset, and it's not
consistent across CPUs. It *cannot* be used as a timer.

> I couldn't find any application actually enabling the access using
> perf_user_access. Maybe I am missing something?
> Otherwise, the above application would trap on access to pmccntr_el0.

As above, that's on Mac OS, not Linux.

Thanks,
Mark.

> 
> [1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=1
> > Thanks,
> > Mark.
> >
> > > This can be a security concern also where a rogue rdpmc user
> > > application can monitor other critical applications to initiate side
> > > channel attack.
> > >
> > > Am I missing something? Please correct my understanding of the x86
> > > implementation if it is wrong.
> > >
> > > [1] https://lore.kernel.org/lkml/20221201135110.3855965-1-conor.dooley@microchip.com/
> > > [2] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=1
> > > [3] https://lore.kernel.org/all/YxIzgYP3MujXdqwj@aurel32.net/T/
> > >
> > > --
> > > Regards,
> > > Atish
> 
> 
> 
> -- 
> Regards,
> Atish
