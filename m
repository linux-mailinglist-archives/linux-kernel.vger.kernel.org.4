Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D86E6879
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjDRPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:43:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5799025
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:43:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso56295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681832623; x=1684424623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SomTtqeiIbTcMS5+NxXIxRdA8/4RoWbjrsah9okDzFc=;
        b=fnfHd/26tvhLm4K7nQfhU/fIZ6oKBdafTuXWW5UeF76VCr+ha76Fhs/V3fsOApJtkQ
         euk7mG2F9RqWa8dHbyNtXgRlrJZD1z3g87KdtH1A0IH+ROQJy2dtM7Cx9bIKMabOaxDY
         34qi4O4RGFnNFlFPjWcOVnWtPe3oSPawf0KZL1mH/P9rfwJBFmQl707fQs7hOh22p54U
         YMHZUvDAT1ey/2DFZtDNwdPqLAvSqTE42ptafzIYRJZFByDO942rZJwD1d80vaCa1IkA
         uMjvdAtciAI1cd31a8B4Tkkb1DTXgyurFdvuUNh4mY22QTY9HculzEATHWuASKWgpeD/
         mQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832623; x=1684424623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SomTtqeiIbTcMS5+NxXIxRdA8/4RoWbjrsah9okDzFc=;
        b=XaX8PDIu1KHgQwXRJVsGIIfzY4bDKHYFlo8hZB0Wg5N57tlR4Uk7EhznZv4mkjvwSf
         o2nbjD1Yg2fQWzuzIeMXtP8Z6YDErNSOdvTSMa+ki4h1efGwnbTiPINJkr4qOH4xMQcA
         RVdsD5G5J8Dmv/GPzmTUX/26As6qo2/Frzag1VnjGwz3t9JHfHO4J1TFBuzWD6M7NW6C
         E/dAoE/plkaFGDN2M+y+PtQ8mTUZgFeLpFYCZssxe6XnkJJtsO+S++JtNQi8DKl5iO5h
         fwt4GYeYCRDHeoROD446gB7fMQrhOHoFVJ0/JjXRdHTg4yVvFUuzbhQmsbgRo/4GTF/C
         cmLA==
X-Gm-Message-State: AAQBX9dlc4x7H41aL0yLYFWDr+ojJAZn6rz2LysLg2VSdnbyK5j1oHZ1
        iuyarsmkXmjbM3slfFYttK+qmQnNi7nfPe88//tzQQ==
X-Google-Smtp-Source: AKy350aH2uIv5rB5bwRkKqjdtAXoUNJ3RIfftfhxbO2P1EwXYalERS4s8XRe9gPERMIV+KcyoM/S/0RbD//AKfdNkpM=
X-Received: by 2002:a05:600c:4446:b0:3f1:6f35:f677 with SMTP id
 v6-20020a05600c444600b003f16f35f677mr174227wmn.1.1681832622724; Tue, 18 Apr
 2023 08:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com> <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com> <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
In-Reply-To: <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 08:43:28 -0700
Message-ID: <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 6:03=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
> > The json TopdownL1 is enabled if present unconditionally for perf stat
> > default. Enabling it on Skylake has multiplexing as TopdownL1 on
> > Skylake has multiplexing unrelated to this change - at least on the
> > machine I was testing on. We can remove the metric group TopdownL1 on
> > Skylake so that we don't enable it by default, there is still the
> > group TmaL1. To me, disabling TopdownL1 seems less desirable than
> > running with multiplexing - previously to get into topdown analysis
> > there has to be knowledge that "perf stat -M TopdownL1" is the way to
> > do this.
>
> To be honest, I don't think it's a good idea to remove the TopdownL1. We
> cannot remove it just because the new way cannot handle it. The perf
> stat default works well until 6.3-rc7. It's a regression issue of the
> current perf-tools-next.

I'm not so clear it is a regression to consistently add TopdownL1 for
all architectures supporting it. The assertion is that because
TopdownL1 has multiplexing and multiplexing is global then we've
lowered the accuracy of other metrics, but the only other hardware
metrics in the default output pre-Icelake are IPC and branch miss
rate. Having TopdownL1 is a way of drilling into performance issues,
while IPC and branch miss rate are putting your finger in the air to
see which way the wind is blowing. Perhaps we should drop these if
TopdownL1 is present.

> But I'm OK to add some flags with the metrics to assist the perf tool to
> specially handle the case if you prefer to modify the event list.

We've already removed thresholds from the default output, we could
remove groups.

> >
> > This doesn't relate to this change which is about making it so that
> > failing to set up TopdownL1 doesn't cause an early exit. The reason I
> > showed TigerLake output was that on TigerLake the skip/fallback
> > approach works while Skylake just needs the events disabled/skipped
> > unless it has sufficient permissions. Note the :u on the events in:
>
> The perf_event_open() should be good to detect the insufficient
> permission, but it doesn't work to detect an existing of an event.
> That's because the kernel only checks the features not specific events.
> It's not a reliable way to rely on the output of the perf_event_open() he=
re.

I'm unclear why not as not having perf_event_open fail seems like a
kernel bug. I can see there is little motivation to fix this on older
architectures like Skylake. We do attempt to workaround it with the
errata flags on the metrics introduced here:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L129=
6

> >> From your test result in the v2 description, we can see that there is =
no
> >> TopdownL1, which is good and expected. However, there is a (48.99%) wi=
th
> >> cycles:u event, which implies multiplexing. Could you please check
> >> what's the problem here?
> >> Also, if it's because of the backgroud, all the events should be
> >> multiplexing. But it looks like only cycle:u has multiplexing. Other
> >> events, instructions:u, branches:u and branch-misses:u work without
> >> multiplexing. That's very strange.
> > I wasn't able to reproduce it and suspect it was a transient thing. I
> > think there are multiplexing things to look into, 2 events on a fixed
> > counter on Icelake+ will trigger multiplexing on all counters, and
> > Skylake's 3 fixed and 4 generic should fit TopdownL1.
>
> Just found a cascade lake. With this patch + the current
> perf-tools-next, partial of the TopdownL1 and multiplexing can still be
> observed.
>
> $ sudo ./perf stat true
>
>  Performance counter stats for 'true':
>
>               2.91 msec task-clock                       #    0.316 CPUs
> utilized
>                  0      context-switches                 #    0.000 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 45      page-faults                      #   15.474 K/sec
>          2,819,972      cycles                           #    0.970 GHz
>                        (60.14%)
>          5,391,406      instructions                     #    1.91  insn
> per cycle
>          1,068,575      branches                         #  367.442 M/sec
>              8,455      branch-misses                    #    0.79% of
> all branches
>             70,283      CPU_CLK_UNHALTED.REF_XCLK        #   24.168
> M/sec
>             48,806      INT_MISC.RECOVERY_CYCLES_ANY     #   16.783
> M/sec                       (39.86%)
>
>        0.009204517 seconds time elapsed
>
>        0.000000000 seconds user
>        0.009614000 seconds sys

The issue here is that 'true' ran very quickly and so we skipped the
output of the events with 0 counts, no metrics were computed due to
the zero counts. Cascade lake has the same TopdownL1 multiplexing
issues as Skylake.

Thanks,
Ian

>
> Thanks,
> Kan
