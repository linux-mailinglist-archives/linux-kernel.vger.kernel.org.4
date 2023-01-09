Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCA663090
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbjAITib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbjAITi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:38:29 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055F777C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:38:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i65so3517901pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJW757By3pyCr9WhEaqzFQ75DPB5RWkfBLPhZzSAskQ=;
        b=Uzz5Ku/PJw99Ny3hIDeY6FZm1/UfFL1eLjF+feC+LJbGzXwu7Ic3hBpQLmwcKmNHNc
         PV06/xC6Kba44i8gHfqWiQL8EwH5BcT64CTXA1inY9LeqGWx6PhjHZbCVPa/RAndDvNJ
         LNlegHSRZCYgM+v8GJdJfS4jWPYwj2fkm9KAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJW757By3pyCr9WhEaqzFQ75DPB5RWkfBLPhZzSAskQ=;
        b=yS1uZWLviykH1hqOojq9ZTxjlOMyW6RklfwXkLJSaKHBTGgyCYbkpZad7KGk0b/SS/
         Djrv+wQ1Ke/PtN7x0UO5f5NGVc80wlZn/YWhSJ/7HGyY8zh08NX7ziN5/7xvplM17QtX
         AIWe25ixu0SyyMGErSnZVqq/HsjLaZPCghGZrls8O/YuBBOVDjbxdVW/MgBN4KFWnmWZ
         FuuJB8O5Qvv+SNE9PEk+DH5RwRReAaEVRtZvRPYOYn10/s1lL5qTtPx/K7Ca02bbtysi
         5zZvY16rpTVewJsk+QxH2VCxoAFCv/IQ3vyPnpzeWZLMQOEss2mmXDqcv7RqmIg33+xC
         kJYg==
X-Gm-Message-State: AFqh2kpNJG8ZYPu1RItbrhr3rbK6uEAy5+i5OPWva3G9d1vfpxCBhdT4
        8K0CsXwQC6cGAwhQ2aZTrVksvQ0TWqzOTEbzL/3hLHm7Bfcocdg=
X-Google-Smtp-Source: AMrXdXv5xoh/ZOsyIbIHCfchh5eJtpYVuSbM+a3emfWlGWlYHnt3rM/q0BSzF6iR3XHFH6sBCN5tyo0i+Aur26bHC04=
X-Received: by 2002:aa7:9d1b:0:b0:580:a13b:366a with SMTP id
 k27-20020aa79d1b000000b00580a13b366amr3484931pfp.37.1673293107413; Mon, 09
 Jan 2023 11:38:27 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
 <Y7gN32eHJNyWBvVD@FVFF77S0Q05N> <CAOnJCULGM=JvOtoRQM8gY3w3oSDhto=VwfgqcL+cb=er6d=dgQ@mail.gmail.com>
 <Y7wyI5fBN6yOIzop@FVFF77S0Q05N>
In-Reply-To: <Y7wyI5fBN6yOIzop@FVFF77S0Q05N>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 9 Jan 2023 11:38:15 -0800
Message-ID: <CAOnJCUKHe2yTUET4D6k9pFH-g6mYwjdbKUAo9Kxm3_UoT-LwRQ@mail.gmail.com>
Subject: Re: Expected rdpmc behavior during context swtich and a RISC-V conundrum
To:     Mark Rutland <mark.rutland@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:26 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Jan 09, 2023 at 01:06:45AM -0800, Atish Patra wrote:
> > On Fri, Jan 6, 2023 at 4:02 AM Mark Rutland <mark.rutland@arm.com> wrot=
e:
> > >
> > > On Thu, Jan 05, 2023 at 11:59:24AM -0800, Atish Patra wrote:
> > > > Hi All,
> > > > There was a recent uabi update[1] for RISC-V that allows the users =
to
> > > > read cycle and instruction count without any checks.
> > > > We tried to restrict that behavior to address security concerns
> > > > earlier but it resulted in breakage for some user space
> > > > applications[2].
> > > > Thus, previous behavior was restored where a user on RISC-V platfor=
ms
> > > > can directly read cycle or instruction count[3].
> > > >
> > > > Comparison with other ISAs w.r.t user space access of counters:
> > > > ARM64
> > > >   -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
> > > >   -- Only for task bound events configured via perf.
> > > >
> > > > X86
> > > >  --- rdpmc instruction
> > > >  --- Enable/Disable via =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
> > > > -- Before v4.0
> > > >  -- any process (even without active perf event) rdpmc
> > > > After v4.0
> > > > -- Default behavior changed to support only active events in a
> > > > process=E2=80=99s context.
> > > > -- Configured through perf similar to ARM64
> > > > -- Continue to maintain backward compatibility for unrestricted acc=
ess
> > > > by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
> > > >
> > > > IMO, RISC-V should only enable user space access through perf simil=
ar
> > > > to ARM64 and x86 (post v4.0).
> > > > However, we do have to support the legacy behavior to avoid
> > > > application breakage.
> > > > As per my understanding a direct user space access can lead to the
> > > > following problems:
> > > >
> > > > 1) There is no context switch support, so counts from other context=
s are exposed
> > > > 2) If a perf user is allocated one of these counters, the counter
> > > > value will be written
> > > >
> > > > Looking at the x86 code as it continues to allow the above behavior=
,
> > > > rdpmc_always_available_key is enabled in the above case. However,
> > > > during the context switch (cr4_update_pce_mm)
> > > > only dirty counters are cleared. It only prevents leakage from perf
> > > > task to rdpmc task.
> > > >
> > > > How does the context switch of counters work for users who enable
> > > > unrestricted access by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=
=E2=80=9D ?
> > > > Otherwise, rdpmc users likely get noise from other applications. Is
> > > > that expected ?
> > >
> > > Regardless of leakage, they're also going to get random jumps in the =
visible
> > > values of the cycle count and instruction count as the task is contex=
t-switched
> > > (and/or if those values get reset across idle, as can happen on arm64=
), so
> > > those aren't going to be useful unless a number of other constraints =
apply.
> > >
> >
> > Agreed.
> >
> > > AFAICT the affected package was actually a library of intrinsics; doe=
s this
> > > affect a real application, or was this just in tests? If it's the lat=
ter there
> > > might still be scope to properly lock this down...
> > >
> >
> > Unfortunately, there are real applications In RISC-V started using
> > cycle counters due to legacy reasons.
> >
> > Here is the short list from debian repo pointed out in [1]
> > https://codesearch.debian.net/search?q=3D%22rdcycle+%250%22
>
> The first of those is GRUB, when running bare metal.
>
> The second is this library again, which is not a whole application.
>
> I see that it's used in some benchmarks in real applications, e.g. firefo=
x,
> chrome. However, as above we know that's *broken* today.
>
> Is that code actually run?
>
> > Looking at aarch64 code in one of the application, it seems they rely
> > on reading "pmccntr_el0" to read time
> > https://sources.debian.org/src/chromium/108.0.5359.124-1/third_party/ff=
mpeg/libavutil/aarch64/timer.h/
>
> That part is under ifdefs for mac os:
>
> | #if defined(__APPLE__)
>

Yes. Sorry I missed that earlier. I checked few other application code
which correctly
use cntvct_el0 as you pointed out.

> ... and it's nonsensical anyway, pmccntr_el0 is *not* a timer, and I don'=
t know
> if Mac OS would bother to context-switch the value, so it's very likely b=
roken
> anyhow.
>
> > AFAIK, any counter access from EL0 is disabled by default in
> > reset_pmuserenr_el0 and should be enabled via the
> > proc/sys/perf_user_access
> > in armv8pmu_enable_user_access. Is that correct ?
>
> Yes, we *only* enable access for tasks doing self-monitoring via perf.
>
> No other useage makes sense, since the value is arbitrarily reset, and it=
's not
> consistent across CPUs. It *cannot* be used as a timer.
>

Yes. That's what we were trying to convince the user space application
maintainers too.

> > I couldn't find any application actually enabling the access using
> > perf_user_access. Maybe I am missing something?
> > Otherwise, the above application would trap on access to pmccntr_el0.
>
> As above, that's on Mac OS, not Linux.
>

Yeah. My bad. Sorry for the noise :)

> Thanks,
> Mark.
>
> >
> > [1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE=
?pli=3D1
> > > Thanks,
> > > Mark.
> > >
> > > > This can be a security concern also where a rogue rdpmc user
> > > > application can monitor other critical applications to initiate sid=
e
> > > > channel attack.
> > > >
> > > > Am I missing something? Please correct my understanding of the x86
> > > > implementation if it is wrong.
> > > >
> > > > [1] https://lore.kernel.org/lkml/20221201135110.3855965-1-conor.doo=
ley@microchip.com/
> > > > [2] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYn=
zsKE?pli=3D1
> > > > [3] https://lore.kernel.org/all/YxIzgYP3MujXdqwj@aurel32.net/T/
> > > >
> > > > --
> > > > Regards,
> > > > Atish
> >
> >
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish
