Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1C6E6D43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjDRUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjDRUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:09:19 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135772A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:09:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso75845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681848554; x=1684440554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1525zsWKnr1EkonUnoaIf64nmGsw4cC1+D1LMBheRA=;
        b=n+Idjg/y1pbkN7j2m2Lv99yYdcRAfyDeb3cYqV53JBjge/QBOHhzhciaG4ao1Z6khP
         ftL5jfisWDCft+4gzrjdQ0GLuBI9kke6wvh8gcaFdqs4906AcnxtHqoBrV66qVAjmYgw
         KrAWjxqYyu867vIhZbjBO+oXJwM/7FJVsldl7/CgCRoUA3/GOaVf032oDnw2Llh67evi
         f3PQEvGNd9cDTiec0aMBHa6GZ5yO1OS61DVhSPazQGv5Cu3WFfoN+4MAKIGV6whbGl1U
         6xEhNLOb9gPh9qNvNqNyqYrLjcsGZoJvJ3efixAbvakrRLjXZMjyJa/xWrzjxpH7+7p6
         8T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681848554; x=1684440554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1525zsWKnr1EkonUnoaIf64nmGsw4cC1+D1LMBheRA=;
        b=ZEDKSbRrXSHhphS2dfOllK8pCMkvvdfx5SordDT3OwwdO8t1WwnNifi9GEyrH1U4QL
         bdhz7W9znOq+fKUzKNcOSjF8HzDvNf4qXRbcTYJUe8XiQ3QgjI5VfNlGh4r3nNF/tXNB
         cBLyFaCY/PWehklR5SjAdO2w/CPIFeoGVyS9l4lqlCcOBotbH6WXmYp6NxRWPh4ufHlu
         9Pte6tAEVu4qLv2hKhhXLPLJQqlriEtDehkiM22GNPZMjRj6sp81wOeBfMl21WLee9Dk
         behGQJW4s2kGVKSq0LG35hnoNUrohFGPoRfH8FkOkB3Pn1nww61+FwmheG2+ktYN5ML/
         s50w==
X-Gm-Message-State: AAQBX9cQkk8gGPqsT9kYPE5k+y68UT1/uTw87jsNyhgCiyxl+8RCFQjc
        N5h2bVFKJhXFRcdLDFuLLlW5VwZcaPa7KTJJ7IY2Pg==
X-Google-Smtp-Source: AKy350ZVUytotLnLt0sUSZ7AO7sR44xZeAzCQSHqBqKY2oPIivb4Q8AkFXs+PyF987dTDqt1oslksnMe9NuM7tYJOxY=
X-Received: by 2002:a05:600c:4f03:b0:3f1:664a:9a52 with SMTP id
 l3-20020a05600c4f0300b003f1664a9a52mr32652wmq.7.1681848554192; Tue, 18 Apr
 2023 13:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com> <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com> <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com> <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
In-Reply-To: <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 Apr 2023 13:08:59 -0700
Message-ID: <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 11:19=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
> > On Tue, Apr 18, 2023 at 6:03=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
> >>> The json TopdownL1 is enabled if present unconditionally for perf sta=
t
> >>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
> >>> Skylake has multiplexing unrelated to this change - at least on the
> >>> machine I was testing on. We can remove the metric group TopdownL1 on
> >>> Skylake so that we don't enable it by default, there is still the
> >>> group TmaL1. To me, disabling TopdownL1 seems less desirable than
> >>> running with multiplexing - previously to get into topdown analysis
> >>> there has to be knowledge that "perf stat -M TopdownL1" is the way to
> >>> do this.
> >>
> >> To be honest, I don't think it's a good idea to remove the TopdownL1. =
We
> >> cannot remove it just because the new way cannot handle it. The perf
> >> stat default works well until 6.3-rc7. It's a regression issue of the
> >> current perf-tools-next.
> >
> > I'm not so clear it is a regression to consistently add TopdownL1 for
> > all architectures supporting it.
>
>
> Breaking the perf stat default is a regression.

Breaking is overstating the use of multiplexing. The impact is less
accuracy in the IPC and branch misses default metrics, if multiplexing
is necessary on your Intel architecture. I believe TopdownL1 is more
useful than either of these metrics and so having TopdownL1 be a
default is an improvement. We can add a patch, as I keep repeating
this is off-topic for this patch, to make it so that TopdownL1 isn't
enabled on Intel CPUs pre-Icelake, but I would discourage this.

> The reason we once added the TopdownL1 for ICL and later platform is
> that it doesn't break the original design (a *clean* output).

Right, and in 6.3-rc7 the aggregation of counts was broken because of
duplicated counts and hard coded metrics (I did a last minute partial
fix). In perf-tools-next aggregation was fixed and we switched to the
json metrics, that are accurate and up-to-date with the latest TMA
metrics, so that we wouldn't need to maintain a duplicate code path.
What keys enabling TopdownL1 in 6.3 is the presence of topdown events
whilst in perf-tools-next it is the presence of TopdownL1 metric
group, as this is a more consistent approach and had first been
proposed by ARM.

> > The assertion is that because
> > TopdownL1 has multiplexing and multiplexing is global then we've
> > lowered the accuracy of other metrics, but the only other hardware
> > metrics in the default output pre-Icelake are IPC and branch miss
> > rate. Having TopdownL1 is a way of drilling into performance issues,
> > while IPC and branch miss rate are putting your finger in the air to
> > see which way the wind is blowing. Perhaps we should drop these if
> > TopdownL1 is present.
> >
> >> But I'm OK to add some flags with the metrics to assist the perf tool =
to
> >> specially handle the case if you prefer to modify the event list.
> >
> > We've already removed thresholds from the default output, we could
> > remove groups.
> >
> >>>
> >>> This doesn't relate to this change which is about making it so that
> >>> failing to set up TopdownL1 doesn't cause an early exit. The reason I
> >>> showed TigerLake output was that on TigerLake the skip/fallback
> >>> approach works while Skylake just needs the events disabled/skipped
> >>> unless it has sufficient permissions. Note the :u on the events in:
> >>
> >> The perf_event_open() should be good to detect the insufficient
> >> permission, but it doesn't work to detect an existing of an event.
> >> That's because the kernel only checks the features not specific events=
.
> >> It's not a reliable way to rely on the output of the perf_event_open()=
 here.
> >
> > I'm unclear why not as not having perf_event_open fail seems like a
> > kernel bug. I can see there is little motivation to fix this on older
> > architectures like Skylake.
>
> Updating kernel may not be an option here. Because
> - There is no issue with the existing perf tool until 6.3-rc7. It
> doesn't sound like a defect of the kernel.
> - The kernel for the SKL has been there for many years. It's impossible
> to change all the kernels to support a new requirement from the perf tool=
.

This isn't a new behavior in the perf tool, the expectation that
perf_event_open fails is one that is present in the implementation of
weak event groups.

> > We do attempt to workaround it with the
> > errata flags on the metrics introduced here:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#=
L1296
> >
> If so, I would still suggest to check the slots and topdown events in
> sysfs and decide whether to append the TopdownL1 to perf stat default.
>
> So we probably need a ARCH specific is_event_available(), before
> appending the events.

This can be done, but is a feature request. I think we should enable
TopdownL1 by default as the way to avoid multiplexing, if you care or
are affected, is to choose the specific event or metric of interest
and profile with just that. I suspect for branch miss-rate and IPC,
the numbers wanting to do that will be small. Educating that TopdownL1
exists is a harder problem and shouldn't just be something present for
Intel Icelake+ users or those who've read through the wiki.

Thanks,
Ian

> >>>> From your test result in the v2 description, we can see that there i=
s no
> >>>> TopdownL1, which is good and expected. However, there is a (48.99%) =
with
> >>>> cycles:u event, which implies multiplexing. Could you please check
> >>>> what's the problem here?
> >>>> Also, if it's because of the backgroud, all the events should be
> >>>> multiplexing. But it looks like only cycle:u has multiplexing. Other
> >>>> events, instructions:u, branches:u and branch-misses:u work without
> >>>> multiplexing. That's very strange.
> >>> I wasn't able to reproduce it and suspect it was a transient thing. I
> >>> think there are multiplexing things to look into, 2 events on a fixed
> >>> counter on Icelake+ will trigger multiplexing on all counters, and
> >>> Skylake's 3 fixed and 4 generic should fit TopdownL1.
> >>
> >> Just found a cascade lake. With this patch + the current
> >> perf-tools-next, partial of the TopdownL1 and multiplexing can still b=
e
> >> observed.
> >>
> >> $ sudo ./perf stat true
> >>
> >>  Performance counter stats for 'true':
> >>
> >>               2.91 msec task-clock                       #    0.316 CP=
Us
> >> utilized
> >>                  0      context-switches                 #    0.000 /s=
ec
> >>                  0      cpu-migrations                   #    0.000 /s=
ec
> >>                 45      page-faults                      #   15.474 K/=
sec
> >>          2,819,972      cycles                           #    0.970 GH=
z
> >>                        (60.14%)
> >>          5,391,406      instructions                     #    1.91  in=
sn
> >> per cycle
> >>          1,068,575      branches                         #  367.442 M/=
sec
> >>              8,455      branch-misses                    #    0.79% of
> >> all branches
> >>             70,283      CPU_CLK_UNHALTED.REF_XCLK        #   24.168
> >> M/sec
> >>             48,806      INT_MISC.RECOVERY_CYCLES_ANY     #   16.783
> >> M/sec                       (39.86%)
> >>
> >>        0.009204517 seconds time elapsed
> >>
> >>        0.000000000 seconds user
> >>        0.009614000 seconds sys
> >
> > The issue here is that 'true' ran very quickly and so we skipped the
> > output of the events with 0 counts, no metrics were computed due to
> > the zero counts. Cascade lake has the same TopdownL1 multiplexing
> > issues as Skylake.
> >
>
> I tried other benchmark. I can still observe the multiplexing. But my
> remote machine just crashed. I'm asking the tech support. So I cannot do
> more tests.
>
> Thanks,
> Kan
