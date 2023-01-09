Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF54F66210F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjAIJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbjAIJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:10:20 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9ACA1BC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:06:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id h7so1407652pfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r+WRhyapDUj23mCaA3ejtr+rwDQ48nvv/NE42rhcUA=;
        b=YgsCb1OAGMG4ZMs50M4Et2DamButK/KtHPAhX6PmTrN7sgL7riDbh3PgY1a5h5KbOP
         WiqQAY65Ux2YcUmyli+t3ddUJYgg/bjeXGdDPIfF1IfRgFaNpbloFez5/14AbHz0hQ36
         BfYgYZgRoLhLD7NxYCOmh/+vw58l2HbC81RGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r+WRhyapDUj23mCaA3ejtr+rwDQ48nvv/NE42rhcUA=;
        b=s6DLnRUDM02cbpU2CcD4ecfZTn7okXd0r8cjk3EJeL6JmTX9k/JmWH0+cIIEsfA9jf
         PCLxrNDXnBWk6Q484eJ17pamvHlaS2/MSl4YR/d9ztWnCLnW2n/A0fkpAOYyuoMHW8lL
         Q6FKa+WmtZQyUJW9glj0z+8Ja4wm8JEQSPPjwgEa3N+mecYs9IASqzf3pY7HF0j+BBPe
         /cBC7jppcNKKF9NBxetnZO7gRPajBQeKb6IdNPvNaolYYKlyfEcNJKr4a4UTAtAi9Q46
         wKT5s0etajfbeQT+IhhYU0GHQxaIjL8qbsqf8l91IAotV+bgcXzjKFTbifNqVCmEwHW7
         ucvg==
X-Gm-Message-State: AFqh2kokwP/4po8firXS5Pin1iqSJE5hl95busbcw5tEGWSLbPIvlm7f
        ibC4l2rwiPFp0sx6lhTVSYKRlE2WU8E3KMD20m/j
X-Google-Smtp-Source: AMrXdXulPAqyOdz4UBE54Hr4oerdJvrGpRElmcRSPOcmJFO1mFZGU/P/kR8wxR5HdwO3AdkQKGIkziWYGvq4Y5hjfLE=
X-Received: by 2002:a05:6a00:13a8:b0:583:3d00:cb97 with SMTP id
 t40-20020a056a0013a800b005833d00cb97mr932019pfg.24.1673255217606; Mon, 09 Jan
 2023 01:06:57 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
 <Y7gN32eHJNyWBvVD@FVFF77S0Q05N>
In-Reply-To: <Y7gN32eHJNyWBvVD@FVFF77S0Q05N>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 9 Jan 2023 01:06:45 -0800
Message-ID: <CAOnJCULGM=JvOtoRQM8gY3w3oSDhto=VwfgqcL+cb=er6d=dgQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 4:02 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Jan 05, 2023 at 11:59:24AM -0800, Atish Patra wrote:
> > Hi All,
> > There was a recent uabi update[1] for RISC-V that allows the users to
> > read cycle and instruction count without any checks.
> > We tried to restrict that behavior to address security concerns
> > earlier but it resulted in breakage for some user space
> > applications[2].
> > Thus, previous behavior was restored where a user on RISC-V platforms
> > can directly read cycle or instruction count[3].
> >
> > Comparison with other ISAs w.r.t user space access of counters:
> > ARM64
> >   -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
> >   -- Only for task bound events configured via perf.
> >
> > X86
> >  --- rdpmc instruction
> >  --- Enable/Disable via =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
> > -- Before v4.0
> >  -- any process (even without active perf event) rdpmc
> > After v4.0
> > -- Default behavior changed to support only active events in a
> > process=E2=80=99s context.
> > -- Configured through perf similar to ARM64
> > -- Continue to maintain backward compatibility for unrestricted access
> > by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=80=9D
> >
> > IMO, RISC-V should only enable user space access through perf similar
> > to ARM64 and x86 (post v4.0).
> > However, we do have to support the legacy behavior to avoid
> > application breakage.
> > As per my understanding a direct user space access can lead to the
> > following problems:
> >
> > 1) There is no context switch support, so counts from other contexts ar=
e exposed
> > 2) If a perf user is allocated one of these counters, the counter
> > value will be written
> >
> > Looking at the x86 code as it continues to allow the above behavior,
> > rdpmc_always_available_key is enabled in the above case. However,
> > during the context switch (cr4_update_pce_mm)
> > only dirty counters are cleared. It only prevents leakage from perf
> > task to rdpmc task.
> >
> > How does the context switch of counters work for users who enable
> > unrestricted access by writing 2 to =E2=80=9C/sys/devices/cpu/rdpmc=E2=
=80=9D ?
> > Otherwise, rdpmc users likely get noise from other applications. Is
> > that expected ?
>
> Regardless of leakage, they're also going to get random jumps in the visi=
ble
> values of the cycle count and instruction count as the task is context-sw=
itched
> (and/or if those values get reset across idle, as can happen on arm64), s=
o
> those aren't going to be useful unless a number of other constraints appl=
y.
>

Agreed.

> AFAICT the affected package was actually a library of intrinsics; does th=
is
> affect a real application, or was this just in tests? If it's the latter =
there
> might still be scope to properly lock this down...
>

Unfortunately, there are real applications In RISC-V started using
cycle counters due to legacy reasons.

Here is the short list from debian repo pointed out in [1]
https://codesearch.debian.net/search?q=3D%22rdcycle+%250%22

Looking at aarch64 code in one of the application, it seems they rely
on reading "pmccntr_el0" to read time
https://sources.debian.org/src/chromium/108.0.5359.124-1/third_party/ffmpeg=
/libavutil/aarch64/timer.h/

AFAIK, any counter access from EL0 is disabled by default in
reset_pmuserenr_el0 and should be enabled via the
proc/sys/perf_user_access
in armv8pmu_enable_user_access. Is that correct ?

I couldn't find any application actually enabling the access using
perf_user_access. Maybe I am missing something?
Otherwise, the above application would trap on access to pmccntr_el0.

[1] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE?pli=
=3D1
> Thanks,
> Mark.
>
> > This can be a security concern also where a rogue rdpmc user
> > application can monitor other critical applications to initiate side
> > channel attack.
> >
> > Am I missing something? Please correct my understanding of the x86
> > implementation if it is wrong.
> >
> > [1] https://lore.kernel.org/lkml/20221201135110.3855965-1-conor.dooley@=
microchip.com/
> > [2] https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/REWcwYnzsKE=
?pli=3D1
> > [3] https://lore.kernel.org/all/YxIzgYP3MujXdqwj@aurel32.net/T/
> >
> > --
> > Regards,
> > Atish



--=20
Regards,
Atish
