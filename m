Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7B7135D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 19:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjE0RGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjE0RGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 13:06:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8494BBB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:06:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4f6eb612aso160e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685207161; x=1687799161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vbK5h4do+bY1KchzX2H/fba6s8GMgbgsm0UAALIeh0=;
        b=U9Ucz14Al3ZvZHRfR+J2GU6wErvB+bhqi4ccOFl5asO7nf2RT10NHK8L3IsXk4YOos
         s6DK4GD0y9zup8GTproFGCq2snhINaWgkesaAtY1rG5tJixDfSHguQPAmN63Gl/vtffj
         clw4BriftlOVOexsDxxQSTmOpVbMVsTIRXi3Ls4lYauGZqy8AtsdTpZBlq49xZxYShp0
         UfrlEGJjyHyW8dlvPZ6/XZMfqa9RyVNTYBzv3Xaux6TiuhkoRf69uskBR+CnW3cGSvJw
         XAJisKKeN68bLDPg70onxBPsHSqamDx+TotnaVO8r57QSTituqsPlWo2l9OF2XsYoQEe
         Zx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685207161; x=1687799161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vbK5h4do+bY1KchzX2H/fba6s8GMgbgsm0UAALIeh0=;
        b=C2cLGjwRdpKH8Kc3QtikO45Se6DDrneO/9QQJO9ELXc+JYkMbrR7C/KisQHYcLf0r0
         85nfRK5zF5UpE5oyVKAkJBXyKHOt7lOFu6z35+2REvOwvPj2JZh4E//H5pVzG6IapYRx
         eSw5PvSeoElLMq/4hkJPZ7s3CLJW2P4Mek4WJIMVOO1lZ9v12QAKGCXpAAq2gsdQDosA
         x1esUvbWoM7IedjU00pIv2WSydwQc/sNSM+GhwFGk7QxKfDqIf11A55ljJdaDJT+RxgW
         eAXxMcOuVKVgxV6mVdquZWO6iH2OrURHqv6ebSqnkSj5bBcrqMtZ9Wm1/EkPydFq4Z9e
         4fjw==
X-Gm-Message-State: AC+VfDzD9Y7AHDsO0drODEwUQs4nnsJmp5XjFSr1RvWYcbRAW6yi51Bx
        /s6AZnQIrAHx72NI90vyq3oHpcZPJINQ3A+DT9v5ug==
X-Google-Smtp-Source: ACHHUZ61ptZywiWevvrY4UDRUU5KAV1PSJdJM2tiOHMVzu7icADg+YOF4Qz0AOh6HFcxVaAW+TM7GwJ72YmMLt8vQIo=
X-Received: by 2002:a05:6512:2158:b0:4f2:632d:4d61 with SMTP id
 s24-20020a056512215800b004f2632d4d61mr92573lfr.6.1685207160461; Sat, 27 May
 2023 10:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230504110003.2548-1-ravi.bangoria@amd.com> <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X> <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
 <ZG8KLbZSECiYaKFc@linux.dev> <20230525142031.GU83892@hirez.programming.kicks-ass.net>
 <ZG+FLdP2kkfI1m2Z@linux.dev> <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
 <86jzwtdhmk.wl-maz@kernel.org> <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
In-Reply-To: <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 27 May 2023 10:05:47 -0700
Message-ID: <CAP-5=fVHKE5+H1qu-kP2=Zz91mb70_ff=Q2o8r7wN0+-=r8FNA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
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

On Sat, May 27, 2023 at 10:00=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Sat, May 27, 2023 at 6:32=E2=80=AFAM Marc Zyngier <maz@kernel.org> wro=
te:
> >
> > On Sat, 27 May 2023 00:00:47 +0100,
> > Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, May 25, 2023 at 8:56=E2=80=AFAM Oliver Upton <oliver.upton@li=
nux.dev> wrote:
> > > >
> > > > On Thu, May 25, 2023 at 04:20:31PM +0200, Peter Zijlstra wrote:
> > > > > On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:
> > > > >
> > > > > > The PMUv3 driver does pass a name, but it relies on getting bac=
k an
> > > > > > allocated pmu id as @type is -1 in the call to perf_pmu_registe=
r().
> > > > > >
> > > > > > What actually broke is how KVM probes for a default core PMU to=
 use for
> > > > > > a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_=
RAW and
> > > > > > reads the pmu from the returned perf_event. The linear search h=
ad the
> > > > > > effect of eventually stumbling on the correct core PMU and succ=
eeding.
> > > > > >
> > > > > > Perf folks: is this WAI for heterogenous systems?
> > > > >
> > > > > TBH, I'm not sure. hetero and virt don't mix very well AFAIK and =
I'm not
> > > > > sure what ARM64 does here.
> > > > >
> > > > > IIRC the only way is to hard affine things; that is, force vCPU o=
f
> > > > > 'type' to the pCPU mask of 'type' CPUs.
> > > >
> > > > We provide absolutely no illusion of consistency across implementat=
ions.
> > > > Userspace can select the PMU type, and then it is a userspace probl=
em
> > > > affining vCPUs to the right pCPUs.
> > > >
> > > > And if they get that wrong, we just bail and refuse to run the vCPU=
.
> > > >
> > > > > If you don't do that; or let userspace 'override' that, things go
> > > > > sideways *real* fast.
> > > >
> > > > Oh yeah, and I wish PMUs were the only problem with these hetero
> > > > systems...
> > >
> > > Just to add some context from what I understand. There are inbuilt
> > > type numbers for PMUs:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/i=
nclude/uapi/linux/perf_event.h?h=3Dperf-tools-next#n34
> > > so the PMU generally called /sys/devices/cpu should have type 4 (ARM
> > > give it another name). For heterogeneous ARM there is a single PMU an=
d
> > > the same events are programmed regardless of whether it is a big or a
> > > little core - the cpumask lists all CPUs.
> >
> > I think you misunderstood the way heterogeneous arm64 systems are
> > described . Each CPU type gets its own PMU type, and its own event
> > list. Case in point:
> >
> > $ grep . /sys/devices/*pmu/{type,cpus}
> > /sys/devices/apple_avalanche_pmu/type:9
> > /sys/devices/apple_blizzard_pmu/type:8
> > /sys/devices/apple_avalanche_pmu/cpus:4-9
> > /sys/devices/apple_blizzard_pmu/cpus:0-3
> >
> > Type 4 (aka PERF_EVENT_RAW) is AFAICT just a way to encode the raw
> > event number, nothing else.
>
> Which PMU will a raw event open on? Note, the raw events don't support
> the extended type that is present in PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/include/=
uapi/linux/perf_event.h#n41
> as the bits are already in use for being just plain config values. I
> suspect not being type 4 is a bug on apple ARM here.
>
> Thanks,
> Ian

Btw, thanks for correcting me! :-D These assumptions are under
documented/tested and nobody wants to make interfaces/tools that are
broken. One source of information is:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/Documentat=
ion/admin-guide/perf
but it doesn't capture this.

Thanks,
Ian

> > Thanks,
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
