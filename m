Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509B67162E2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjE3OAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjE3OAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:00:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD6C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:00:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b025aaeddbso308445ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685455234; x=1688047234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2UZx8lRuVV95JLdyEdn9XhsUM2ReQsqKWGI4qb4yJI=;
        b=cT34SGrTUx7G2y+GF9IExmt66HEAk0TxXg7RkU1Cpyy9QR+fe8x9NxU4QASqdIzs28
         zINMXUEZi30EQwRE502SDS2rgtrzNjhUJgtkJDcihbMwAHp0bgG3qJI9KE2px04befqq
         K5i10y/gpHxJaTBixgSe25E7O4LCvEV0uAylxZBL+pQ1p9W5GlTCWiK7wRXnwo32oue5
         xx5dcdHboQlFY1ujpsPsniOasYntzWQeJK82N16nGdR6CtSPheMsHpXhB5p54otHS4/f
         VSGyowzxzHSGXaLlktUxF+na9w7jFDZ+tHOEkVThEvvRMiJjYN0+mfEZIVQP+EpK3L0n
         xjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685455234; x=1688047234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2UZx8lRuVV95JLdyEdn9XhsUM2ReQsqKWGI4qb4yJI=;
        b=TnC7qEGKjqZRNVHjR91gRg/JrOAO5HkGDTvpFfnVlYuzHUWe8X4xgISlEbl9Q6kZ3Z
         L12n7CCad0ej179dXAVOh2PWpp9Noqhzd6i69knt1TlOvtr4QPB7275r6ZlM6LhDCV61
         x4SNV1EA8rjjelFU3RDYyc43YAGSc5BafkKlSCLkzyo9EoI7wAgOktcbsi09cGiUnS4c
         YEJuuinZsxss3eo8EERVaOyH9b/fDsT7bUMd4+TNlUK8ArS8Rt2atQuMBJDNsbIn9wlB
         NX+jPlx1EOwhNjdIcd2HhCKnEJAMomiYX+kRvKmqrOCA3NQdaICO54PvrvYmytthpH/d
         UVuw==
X-Gm-Message-State: AC+VfDx8deS+OB9RJAb9kjWxe1pTuc34o/v1ZIv4+KpEhpXcbTT77/sh
        sgBpM+Vo0RwUK+oA+Ae85LiglRUvwd6Bh8MftcSLxA==
X-Google-Smtp-Source: ACHHUZ4Rp/ErIVyDCQ2IHBUOh47iZFHwPFvGVtazcxih8Jzal8pvp70DtHeeb89A+lZnrQ5GhQglC5p/FVhmpjaGtmM=
X-Received: by 2002:a17:902:d490:b0:1b0:cea:294e with SMTP id
 c16-20020a170902d49000b001b00cea294emr125798plg.21.1685455233533; Tue, 30 May
 2023 07:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230504110003.2548-1-ravi.bangoria@amd.com> <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X> <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
 <ZG8KLbZSECiYaKFc@linux.dev> <20230525142031.GU83892@hirez.programming.kicks-ass.net>
 <ZG+FLdP2kkfI1m2Z@linux.dev> <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
 <86jzwtdhmk.wl-maz@kernel.org> <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
 <86h6rxd3gh.wl-maz@kernel.org> <0075d8a9-2df4-86eb-8171-8995f59904e0@linux.ibm.com>
In-Reply-To: <0075d8a9-2df4-86eb-8171-8995f59904e0@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 May 2023 07:00:22 -0700
Message-ID: <CAP-5=fXo0t+buDrmf7SyTD97gmTWGoDAO2YXWyav+_79O3MZ0w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 12:45=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On 5/27/23 20:38, Marc Zyngier wrote:
> > On Sat, 27 May 2023 18:00:13 +0100,
> > Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Sat, May 27, 2023 at 6:32=E2=80=AFAM Marc Zyngier <maz@kernel.org> =
wrote:
> >>>
> >>> On Sat, 27 May 2023 00:00:47 +0100,
> >>> Ian Rogers <irogers@google.com> wrote:
> >>>>
> >>>> On Thu, May 25, 2023 at 8:56=E2=80=AFAM Oliver Upton <oliver.upton@l=
inux.dev> wrote:
> >>>>>
> >>>>> On Thu, May 25, 2023 at 04:20:31PM +0200, Peter Zijlstra wrote:
> >>>>>> On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:
> >>>>>>
> >>>>>>> The PMUv3 driver does pass a name, but it relies on getting back =
an
> >>>>>>> allocated pmu id as @type is -1 in the call to perf_pmu_register(=
).
> >>>>>>>
> >>>>>>> What actually broke is how KVM probes for a default core PMU to u=
se for
> >>>>>>> a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RA=
W and
> >>>>>>> reads the pmu from the returned perf_event. The linear search had=
 the
> >>>>>>> effect of eventually stumbling on the correct core PMU and succee=
ding.
> >>>>>>>
> >>>>>>> Perf folks: is this WAI for heterogenous systems?
> >>>>>>
> >>>>>> TBH, I'm not sure. hetero and virt don't mix very well AFAIK and I=
'm not
> >>>>>> sure what ARM64 does here.
> >>>>>>
> >>>>>> IIRC the only way is to hard affine things; that is, force vCPU of
> >>>>>> 'type' to the pCPU mask of 'type' CPUs.
> >>>>>
> >>>>> We provide absolutely no illusion of consistency across implementat=
ions.
> >>>>> Userspace can select the PMU type, and then it is a userspace probl=
em
> >>>>> affining vCPUs to the right pCPUs.
> >>>>>
> >>>>> And if they get that wrong, we just bail and refuse to run the vCPU=
.
> >>>>>
> >>>>>> If you don't do that; or let userspace 'override' that, things go
> >>>>>> sideways *real* fast.
> >>>>>
> >>>>> Oh yeah, and I wish PMUs were the only problem with these hetero
> >>>>> systems...
> >>>>
> >>>> Just to add some context from what I understand. There are inbuilt
> >>>> type numbers for PMUs:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/=
include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n34
> >>>> so the PMU generally called /sys/devices/cpu should have type 4 (ARM
> >>>> give it another name). For heterogeneous ARM there is a single PMU a=
nd
> >>>> the same events are programmed regardless of whether it is a big or =
a
> >>>> little core - the cpumask lists all CPUs.
> >>>
> >>> I think you misunderstood the way heterogeneous arm64 systems are
> >>> described . Each CPU type gets its own PMU type, and its own event
> >>> list. Case in point:
> >>>
> >>> $ grep . /sys/devices/*pmu/{type,cpus}
> >>> /sys/devices/apple_avalanche_pmu/type:9
> >>> /sys/devices/apple_blizzard_pmu/type:8
> >>> /sys/devices/apple_avalanche_pmu/cpus:4-9
> >>> /sys/devices/apple_blizzard_pmu/cpus:0-3
> >>>
> >>> Type 4 (aka PERF_EVENT_RAW) is AFAICT just a way to encode the raw
> >>> event number, nothing else.
> >>
> >> Which PMU will a raw event open on?
> >
> > On the PMU that matches the current CPU.
> >
> >> Note, the raw events don't support
> >> the extended type that is present in PERF_TYPE_HARDWARE and
> >> PERF_TYPE_HW_CACHE:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/inclu=
de/uapi/linux/perf_event.h#n41
> >> as the bits are already in use for being just plain config values.
> >
> > I'm not sure how relevant this is to the numbering of PMUs on arm64.
> >
> >> I suspect not being type 4 is a bug on apple ARM here.
> >
> > If that's a bug on this machine, it's a bug on all machines, at which
> > point it is the de-facto API:
> >
> > $ grep . /sys/devices/armv8*/{type,cpus}
> > /sys/devices/armv8_cortex_a53/type:8
> > /sys/devices/armv8_cortex_a72/type:9
> > /sys/devices/armv8_cortex_a53/cpus:0-3
> > /sys/devices/armv8_cortex_a72/cpus:4-5
> >
> > See, non-Apple HW. And now for a system with homogeneous CPUs:
> >
> > $ grep . /sys/devices/armv8*/{type,cpus}
> > /sys/devices/armv8_pmuv3_0/type:8
> > /sys/devices/armv8_pmuv3_0/cpus:0-159
> >
> > Still no type 4. I could go on for hours, I have plenty of HW around
> > me!
> >
> > So whatever your source of information is, it doesn't match reality.
> > Our PMUs are numbered arbitrarily, and have been so for... a very long
> > time. At least since perf_pmu_register has supported dynamic
> > registration (see 2e80a82a49c4c).
> >
> > Thanks,
> >
> >       M.
> >
>
>
> I agree with Marc,
> on s390 we have 5 different PMUs and all have arbitrary numbers
> and have totally different features:
>
> # ll /sys/devices/{cpum,pai}*/type
> -r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/cpum_cf_diag/type
> -r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/cpum_cf/type
> -r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/cpum_sf/type
> -r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/pai_crypto/type
> -r--r--r-- 1 root root 4096 May 30 09:33 /sys/devices/pai_ext/type
> # grep . /sys/devices/{cpum,pai}*/type
> /sys/devices/cpum_cf_diag/type:9
> /sys/devices/cpum_cf/type:8
> /sys/devices/cpum_sf/type:4
> /sys/devices/pai_crypto/type:10
> /sys/devices/pai_ext/type:11
> #

Thanks Thomas, could you:
$ ls /sys/devices/*/cpu*
The assumption is that if a file called "cpus" exists then this a
"core" PMU, while "cpumask" would indicate an uncore PMU. The
exception is /sys/devices/cpu where there is no cpus but all online
CPUs are assumed to be in "cpus" cpu map. On Intel one of the core
PMUs has type 4 which aligns with the perf_event.h "ABI" constant
PERF_TYPE_RAW, so opening a type 4 event will open it on that PMU. The
question is I have is what should be the behavior be on non-Intel for
type 4, for the big.little/hybrid case it seems opening it on core
PMUs would make most sense and is what is done for PERF_TYPE_HARDWARE
and PERF_TYPE_HW_CACHE.

Thanks,
Ian

> Thanks Thomas
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
