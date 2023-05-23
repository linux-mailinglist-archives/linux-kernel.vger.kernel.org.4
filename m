Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BABF70E23D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjEWQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbjEWQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:35:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908C21A6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:35:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae5dc9eac4so48964475ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684859713; x=1687451713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BQXLdFOI2CGu/rfEBqigmE78qgmnNYZiqsFoyv3xq0=;
        b=NApFrP14NOXxqan78wLxejm40kUZ/DL5PNlrNgf2kbD8fDbf178C0+whanhsPKYD7b
         kcmliTKRdhECeFDn6ufmCBWsagpEoeunlJf6oh1k9+afdKqYEdPjaJpqaQd1Aj9ysRnd
         mMbQJePOcVnDAla9r4MfM2ZEWUQoHKcho99xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859713; x=1687451713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BQXLdFOI2CGu/rfEBqigmE78qgmnNYZiqsFoyv3xq0=;
        b=DgN78j4qU7uWzziUAkbzoxD+Myk+SQILo1jJtybVfPz4onEzFygKQdHyQrfrK5yuV8
         JmsOunn7BSKSAFvaJPXxxoYCiCbg45eM3OaCaBWn63692oPCtK7imeDHlQjaKpinWzoG
         s/fHuTUkkB79OUyDLaxCJG41BmlSFqu/MjNiAHFnsqsP81+3hCsFDNSyITUelatCJa90
         WdB6A2EgO8CoxkwY1PabZM0Exf1TY8uDJ/hLmBU7uAoV+G5ka26At/BQNSCiCtSXKGrm
         BvIz0VeYcOgB39lIYpoJIwxjMUBAZEodV2v97RHJmpIOI7qDm4bNGY5XYBp1V4BQK6Xv
         4s8g==
X-Gm-Message-State: AC+VfDwBS5PcvS9c94JZ2Lc68af4BkyJdTo7hAtRA9YrubA1iIdw+fs2
        4Rq+A8zvfuZazd7Fv260UlSb22jZec6jG6pxnz4=
X-Google-Smtp-Source: ACHHUZ4Xj5hAoIs/rGWjJiwdPHJKoMX40I8die3KvDT+G+x52zMrd5A2wTpZ31R8qjxBexWafHxHiQ==
X-Received: by 2002:a17:902:d48f:b0:1af:daf7:7240 with SMTP id c15-20020a170902d48f00b001afdaf77240mr461967plg.58.1684859713303;
        Tue, 23 May 2023 09:35:13 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d70600b001a6a53c3b04sm6990933ply.306.2023.05.23.09.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:35:12 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ae3f74c98bso165075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:35:10 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a42:b0:32a:642d:2a13 with SMTP id
 u2-20020a056e021a4200b0032a642d2a13mr379303ilv.6.1684859689295; Tue, 23 May
 2023 09:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.10.I3a7d4dd8c23ac30ee0b607d77feb6646b64825c0@changeid> <ZGzjm9h85fpYZJMc@alley>
In-Reply-To: <ZGzjm9h85fpYZJMc@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 23 May 2023 09:34:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VeGKTvw2=qhSqkSEtYwVrXGLNzNbgBAwrmn2CWWfJckQ@mail.gmail.com>
Message-ID: <CAD=FV=VeGKTvw2=qhSqkSEtYwVrXGLNzNbgBAwrmn2CWWfJckQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/18] watchdog/hardlockup: Add a "cpu" param to watchdog_hardlockup_check()
To:     Petr Mladek <pmladek@suse.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 23, 2023 at 9:02=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-05-19 10:18:34, Douglas Anderson wrote:
> > In preparation for the buddy hardlockup detector where the CPU
> > checking for lockup might not be the currently running CPU, add a
> > "cpu" parameter to watchdog_hardlockup_check().
> >
> > As part of this change, make hrtimer_interrupts an atomic_t since now
> > the CPU incrementing the value and the CPU reading the value might be
> > different. Technially this could also be done with just READ_ONCE and
> > WRITE_ONCE, but atomic_t feels a little cleaner in this case.
> >
> > While hrtimer_interrupts is made atomic_t, we change
> > hrtimer_interrupts_saved from "unsigned long" to "int". The "int" is
> > needed to match the data type backing atomic_t for hrtimer_interrupts.
> > Even if this changes us from 64-bits to 32-bits (which I don't think
> > is true for most compilers), it doesn't really matter. All we ever do
> > is increment it every few seconds and compare it to an old value so
> > 32-bits is fine (even 16-bits would be). The "signed" vs "unsigned"
> > also doesn't matter for simple equality comparisons.
> >
> > hrtimer_interrupts_saved is _not_ switched to atomic_t nor even
> > accessed with READ_ONCE / WRITE_ONCE. The hrtimer_interrupts_saved is
> > always consistently accessed with the same CPU. NOTE: with the
> > upcoming "buddy" detector there is one special case. When a CPU goes
> > offline/online then we can change which CPU is the one to consistently
> > access a given instance of hrtimer_interrupts_saved. We still can't
> > end up with a partially updated hrtimer_interrupts_saved, however,
> > because we end up petting all affected CPUs to make sure the new and
> > old CPU can't end up somehow read/write hrtimer_interrupts_saved at
> > the same time.
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -87,29 +87,34 @@ __setup("nmi_watchdog=3D", hardlockup_panic_setup);
> >
> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> >
> > -static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
> > -static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
> > +static DEFINE_PER_CPU(atomic_t, hrtimer_interrupts);
> > +static DEFINE_PER_CPU(int, hrtimer_interrupts_saved);
> >  static DEFINE_PER_CPU(bool, watchdog_hardlockup_warned);
> >  static unsigned long watchdog_hardlockup_all_cpu_dumped;
> >
> > -static bool is_hardlockup(void)
> > +static bool is_hardlockup(unsigned int cpu)
> >  {
> > -     unsigned long hrint =3D __this_cpu_read(hrtimer_interrupts);
> > +     int hrint =3D atomic_read(&per_cpu(hrtimer_interrupts, cpu));
> >
> > -     if (__this_cpu_read(hrtimer_interrupts_saved) =3D=3D hrint)
> > +     if (per_cpu(hrtimer_interrupts_saved, cpu) =3D=3D hrint)
> >               return true;
> >
> > -     __this_cpu_write(hrtimer_interrupts_saved, hrint);
> > +     /*
> > +      * NOTE: we don't need any fancy atomic_t or READ_ONCE/WRITE_ONCE
> > +      * for hrtimer_interrupts_saved. hrtimer_interrupts_saved is
> > +      * written/read by a single CPU.
> > +      */
> > +     per_cpu(hrtimer_interrupts_saved, cpu) =3D hrint;
> >
> >       return false;
> >  }
> >
> >  static void watchdog_hardlockup_kick(void)
> >  {
> > -     __this_cpu_inc(hrtimer_interrupts);
> > +     atomic_inc(raw_cpu_ptr(&hrtimer_interrupts));
>
> Is there any particular reason why raw_*() is needed, please?
>
> My expectation is that the raw_ API should be used only when
> there is a good reason for it. Where a good reason might be
> when the checks might fail but the consistency is guaranteed
> another way.
>
> IMHO, we should use:
>
>         atomic_inc(this_cpu_ptr(&hrtimer_interrupts));
>
> To be honest, I am a bit lost in the per_cpu API definitions.
>
> But this_cpu_ptr() seems to be implemented the same way as
> per_cpu_ptr() when CONFIG_DEBUG_PREEMPT is enabled.
> And we use per_cpu_ptr() in is_hardlockup().
>
> Also this_cpu_ptr() is used more commonly:
>
> $> git grep this_cpu_ptr | wc -l
> 1385
> $> git grep raw_cpu_ptr | wc -l
> 114

Hmmm, I think maybe I confused myself. The old code purposely used the
double-underscore prefixed version of this_cpu_inc(). I couldn't find
a double-underscore version of this_cpu_ptr() and I somehow convinced
myself that the raw() version was the right equivalent version.

You're right that this_cpu_ptr() is a better choice here and I don't
see any reason why we'd need the raw version.

> >  }
> >
> > -void watchdog_hardlockup_check(struct pt_regs *regs)
> > +void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> >  {
> >       /*
> >        * Check for a hardlockup by making sure the CPU's timer
> > @@ -117,35 +122,42 @@ void watchdog_hardlockup_check(struct pt_regs *re=
gs)
> >        * fired multiple times before we overflow'd. If it hasn't
> >        * then this is a good indication the cpu is stuck
> >        */
> > -     if (is_hardlockup()) {
> > +     if (is_hardlockup(cpu)) {
> >               unsigned int this_cpu =3D smp_processor_id();
> > +             struct cpumask backtrace_mask =3D *cpu_online_mask;
>
> Does this work, please?
>
> IMHO, we should use cpumask_copy().

Ah, good call, thanks!


> >               /* Only print hardlockups once. */
> > -             if (__this_cpu_read(watchdog_hardlockup_warned))
> > +             if (per_cpu(watchdog_hardlockup_warned, cpu))
> >                       return;
> >
>
> Otherwise, it looks good to me.

Neither change seems urgent though both are important to fix, I'll
wait a day or two to see if you have feedback on any of the other
patches and I'll send a fixup series.

-Doug
