Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E8E6EAE47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjDUPts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDUPto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:49:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C795118E2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:49:42 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef36d814a5so1170501cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682092181; x=1684684181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Q0j2Er3y23Z2Kvz7DZ0W4QsTMAsEfLxUdWrtpuJ6s=;
        b=kmV4x6zuc4CeuxCsONzDFEmVhep4iyQNxv0LnJcm9GVozPZ+V+qUlCz2tJNcX2XEJ2
         z/dJvDZ7joNOEocwLYHLcA+3Ss5ME674mPfx38LvXQII2XqY1kKS44/4zfu3KtyDxw77
         DvDAZr/MCEL3cmciETkyYzjhWieKtC4ilJKVaAZS1PFpn9pWO7UJFlEgI7tG7zMZugAv
         TUGxFQj/FPtDCgXX3hix7f0eFkOpcwuxU03JEO8rJ3Xf/pzetr5F2bd9A4PXG4iZYRIQ
         WdNCfQ7strsH5BHZs42EDYJxkGmryCpY64Eb126eFamHXMFNrezVsAqtjuqNx9QQhJWY
         X+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682092181; x=1684684181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9Q0j2Er3y23Z2Kvz7DZ0W4QsTMAsEfLxUdWrtpuJ6s=;
        b=WO++8FUAp57Q98/8dRSHKr3j5A6ZNDh+hpnUrI14LRfF4LttHOg0DU6R7uzfuRE3ni
         KssM916xkxjFxfO5LkJYTSu6GlcnULPzz+3Z7HzlcjNYPqWidC/ia3vzFm153tEt1kyt
         o8kGfSKsnBmvkxCmMJd7sPVf/bVcvfCz1aCbCLinyKdZwRHoEXLHmYE/hFO2FUSLQ619
         Mcx+ZSMmJTdr8kHe7HztoBd1C+YF4DIxp2aiTsnf+ZGwd6OrN5RZRi5FNwQ45eCftWKv
         miMm3l4Htw1p6nM5kr3BrZs0+o+wJUID6Znpa+KsPMklV+cyLforRHmhPKanCXKCfrY/
         bmyg==
X-Gm-Message-State: AAQBX9dyS4onAU/qNT5EBL2MDsBCWARBZxOndUSx6BTcGMZqjGMUT/IF
        i5Ap+A2q0cRGIkAXfy5mXqcVARROkiniHrsAmNma6Q==
X-Google-Smtp-Source: AKy350bkJbqjKtUvUTw5VsChcNRbthgxusJFSxjabLJ75M6d/zYx/xvsM51G/XmRf+e4gxqdFOYHTYLPL1f3vFBSz/Y=
X-Received: by 2002:a05:622a:1716:b0:3de:1aaa:42f5 with SMTP id
 h22-20020a05622a171600b003de1aaa42f5mr303051qtk.15.1682092181131; Fri, 21 Apr
 2023 08:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
 <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com> <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com> <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com> <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
 <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com> <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
 <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com>
In-Reply-To: <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 21 Apr 2023 08:49:27 -0700
Message-ID: <CAP-5=fVnuQ08zUg8XxFhT-oddRd9PC8GPu6q-FU-_H0QLqO91w@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Fri, Apr 21, 2023 at 6:32=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-20 8:19 p.m., Ian Rogers wrote:
> >>>>                         struct evlist *metric_evlist =3D evlist__new=
();
> >>>>                         struct evsel *metric_evsel;
> >>>>
> >>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-d=
isplay.c
> >>>> index 6b46bbb3d322..072fa56744b4 100644
> >>>> --- a/tools/perf/util/stat-display.c
> >>>> +++ b/tools/perf/util/stat-display.c
> >>>> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *co=
unter)
> >>>>         int ret =3D 0;
> >>>>
> >>>>         if (counter->uniquified_name || counter->use_config_name ||
> >>>> -           !counter->pmu_name || !strncmp(counter->name, counter->p=
mu_name,
> >>>> +           !counter->pmu_name || !counter->name ||
> >>>> !strncmp(counter->name, counter->pmu_name,
> >>>>                                            strlen(counter->pmu_name)=
))
> >>>>                 return;
> >>>
> >>> Is this a pre-existing hybrid bug? It is a real shame hybrid shows so
> >>> few common code paths. In general evsel__name should be preferred ove=
r
> >>> directly accessing name.
> >>
> >>
> >> I don't think so.
> >>
> >> I haven't dig into the bug yet. But from the source code I can tell th=
at
> >> the check is the same as the current 6.3-rc7.
> >>
> >> For the current 6.3-rc7, perf stat true works.
> >> The perf stat -M TopdownL1 --metric-no-group can work as well.
> >>
> >> But with the current perf-tools-next branch, perf stat true gives a
> >> Segmentation fault.
> >>
> >> The TopdownL1 doesn't work either.
> >>
> >> # ./perf stat -M TopdownL1 --metric-no-group
> >> Error:
> >> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> >> for event (topdown-retiring).
> >> /bin/dmesg | grep -i perf may provide additional information.
> >
> > I see hybrid failing basic sanity tests both for 6.3 and in
> > perf-tools-next. For metrics I see:
> >
> > ```
> > $ git status
> > ...
> > Your branch is up to date with 'linus/master'
> > ...
> > $ git describe
> > v6.3-rc7-139-gb7bc77e2f2c7
> > $ sudo perf stat -M TopdownL1 -a sleep 1
>
> Try the --metric-no-group.
>
>
> > WARNING: events in group from different hybrid PMUs!
> > WARNING: grouped events cpus do not match, disabling group:
> >  anon group { topdown-retiring, topdown-retiring,
> > INT_MISC.UOP_DROPPING, topdown-fe-bound, topdown-fe-bound,
> > CPU_CLK_UNHALTED.CORE, topdown-be-bound, topdown-be-bound,
> > topdown-bad-spec, topdown-bad-spec }
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > for event (topdown-retiring).
> > /bin/dmesg | grep -i perf may provide additional information.
> > ```
> >
> > It seems perf on hybrid is quite broken in 6.3, but I doubt we can fix
> > 6.3 given the late stage of the release cycle. As perf-tools-next
> > enables TopdownL1 metrics when no events or metric are specified and
> > when the metric group is present, on hybrid this will cause the
> > pre-existing bug to appear for the no events/metrics case. I suspect
> > this is the cause of the crashes you see, but I'm seeing assertion
> > failures and similar as I'm using a debug build.
> >
> > I'm looking into fixing perf-tools-next and not 6.3. Maybe there will
> > be something we can cherry-pick back to fix up 6.3. It hasn't been
> > easy to find hardware to test on, and if the machine I'm remotely
> > using falls over then I have no means to test, so fingers crossed.
> >
>
> OK. So the json metric thing is buggy on both 6.3 and perf-tools-next. I
> think it is even worse in the perf-tools-next.
> Besides the bugs, the json metric also changes the output layout of perf
> stat default. The tools, which are on top of perf, are all impacted.
>
> The question is why we are in such a rush to move the default of perf
> stat from reliable kernel metric to json metric?

So there is a long answer involving description of the multi-year
effort between Intel and Google to transition to json metrics that are
fully tested, etc. but the short answer here is that:
1) the code has always called for json to be the approach:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/builtin-stat.c#n1841
".. Once platform specific metrics support has been added to the json
files, all architectures will use this approach..."
2) aggregation in the saved values used by hard coded metrics, and
json metrics, is broken in 6.3 The bug reporting this came from Intel
around the time 6.2 was wrapping up (ie not a new issue), and Intel
requested a fix. This has been in use for metric testing by Intel. The
fix removed saved values, used by the hard coded metrics, and even if
the hard coded metrics were ported to perf-tools-next which version
should be ported? The version that disagrees with the TMA metric
spreadsheet that is in 6.3, or a version matching the json metric? If
you're just going to match the json metric then why not just use the
json metric? It is less code and cleaner all round. Fixing the hard
coded metric also alters the output formatting and so is unlikely to
resolve what has been an issue here.
3) hard coded metrics have a non-zero cost, in particular in output
formatting. Take for example:
https://lore.kernel.org/all/20221205042852.83382-1-atrajeev@linux.vnet.ibm.=
com/
"tools/perf: Fix printing field separator in CSV metrics output"
But the perf tool also has had patches in this area from RedHat.
Having the hard coded metrics is error prone, while the json metrics
are something that is far more uniform and tested. We have in the
region of 30 hard coded metrics in Linux 6.3, much fewer in
perf-tools-next, whereas we have more than 4,100 json metrics.

> Can we take a step back? Create a perf/json_metric or whatever branch,
> fix all the issues thoroughly, and then merge to the mainline.
>
> I think the default of perf stat is frequently used by not only the
> newbees but also the veterans. That could have a big user-visible impact.
>
> The 6.4 merge window is approaching. Can we at least revert the patches
> for 6.4?
>
> Arnaldo, what do you think?

Revert is a complete no go, we'd be reintroducing the bugs that are
fixed and who will then fix those? How will they be fixed in any way
other than how they've already been fixed? I've yet to see a
description of a bug that isn't either:
1) an issue because the output formatting changed - the fix here is to
use CSV or json output, using the hard coded metrics was a bug here
anyway, not least as the metrics are wrong,
2) a pre-existing issue, such as hybrid is broken,
3) a non-issue, such as multiplexing on Skylake.
That's not to say everything couldn't run better, which was the issue
this patch was looking to address.

My team have called for this to be discussed with Intel as we're firm
on what we see as being the correct approach. I think the meeting can
conclude what will happen wrt reverts, but I haven't heard a sensible
argument why reverts are necessary. I think the energy from this
conversation would be much better directed into fixing the issues we
know we have, which is why I'm currently looking at fixing some
aspects of what is broken in hybrid.

Thanks,
Ian

> Thanks,
> Kan
