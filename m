Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A570712F02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbjEZVlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbjEZVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:41:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC7BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:41:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso21355e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685137267; x=1687729267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCGba+6rmP3oFWlLxeG7HrMtI5cN+T+JVky+Yx/c6wM=;
        b=6pGLppNOwQz8D06a1Xq8N32BV2ybg2X/MHWeKdCBb0vDiM8BPnMcU1spg8QurVMJIa
         YQ4Ke3SATtI2Trp+eBqg85Ybt8ayx9Nehiwn4d+b532eixwGwZcHzFX+veGL2IL/rcgX
         Tc3ZnU6jDqYtiLyOlPeTxqaJNkUnRfc5TkhFgzBp9J1raB72QvEVJRZFUfaiK8oKMtqH
         xDg60A1yax9qCg2DR9PSnGd5Qpvm5CYnc932ediYC1UUJrtM1VDGzssfrXa11wwVoM22
         LvtPgbjPdYdb65IvN+pnAM/7D5ge+BPdMbbyKOTysHzjgq4wa7Kxxes2pUdH8XxuhEjr
         d4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685137267; x=1687729267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCGba+6rmP3oFWlLxeG7HrMtI5cN+T+JVky+Yx/c6wM=;
        b=ABMx/DgYenSf3BCRdwYqTTAdKavWbbZEkM5MifPN+Y2TIUwEu+hHvE/4RwWNcdJNDL
         AdN7F1uCtmhaUrZ9YjPDu8I0GDZeoP1/NBePT0VHmtGrLcO8EtncXekWGcja0Q7q/Zeh
         FI6npQ+1h32XJtus7zs354GlaAj2SRI87atI6efFghGjbM+FOMapToK4xwNLAcMkKmmX
         vcHGhxxovGp7Eo/r76dzuBwAIVlTRi9TuYZH7NpJvbOv8vUl21g8a1PytGvOZ3Vnwltj
         Px0ZDjd7nEgTfOlMznYSYjZMqx47nZVZwdLFbhuXtypWkSyLHzz1Ol6/p2LnyfOy8py7
         7jMw==
X-Gm-Message-State: AC+VfDz3t6M9qyaWAU6bIZOPwvfS6YEImPxu/2VZaCnFoHf8IVD+QEOM
        J/xuZ7Y9xj8dRddZH9QF6ZUIBZYVAQiSuuSguTgQ5Q==
X-Google-Smtp-Source: ACHHUZ4DoTymeb5+7502s5BwYQGVvVlqFioCiuVbgzAeZYam9rLSpWhBZZZL3rnD8qy0ydu7MYgCK09a9St+s1WKD+k=
X-Received: by 2002:a05:600c:1d24:b0:3f1:9a3d:4f7f with SMTP id
 l36-20020a05600c1d2400b003f19a3d4f7fmr12859wms.1.1685137266820; Fri, 26 May
 2023 14:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com> <20230524221831.1741381-10-irogers@google.com>
 <CAM9d7ci21E+BFHPtbx4iO=pcgs2Y7ZCCVsjD-b5OWMdPLb0-6A@mail.gmail.com>
In-Reply-To: <CAM9d7ci21E+BFHPtbx4iO=pcgs2Y7ZCCVsjD-b5OWMdPLb0-6A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 May 2023 14:40:54 -0700
Message-ID: <CAP-5=fVbn54AH3-YQ1OtUL=0f8o1V7iJh9LpZeZCk2x8SvX_Ag@mail.gmail.com>
Subject: Re: [PATCH v3 09/35] perf evlist: Propagate user CPU maps
 intersecting core PMU maps
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

On Wed, May 24, 2023 at 10:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, May 24, 2023 at 3:19=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The CPU map for a non-core PMU gives a default CPU value for
> > perf_event_open. For core PMUs the CPU map lists all CPUs the evsel
> > may be opened on. If there are >1 core PMU, the CPU maps will list the
> > CPUs for that core PMU, but the user_requested_cpus may contain CPUs
> > that are invalid for the PMU and cause perf_event_open to fail. To
> > avoid this, when propagating the CPU map for core PMUs intersect it
> > with the CPU map of the PMU (the evsel's "own_cpus").
> >
> > Add comments to __perf_evlist__propagate_maps to explain its somewhat
> > complex behavior.
>
> Thanks for tackling this.  There are many assumptions on this code
> which make this code hard to understand.  I think we need to list
> all possible cases and make the logic as simple as possible.
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/evlist.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 81e8b5fcd8ba..b8b066d0dc5e 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -36,18 +36,33 @@ void perf_evlist__init(struct perf_evlist *evlist)
> >  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> >                                           struct perf_evsel *evsel)
> >  {
> > -       /*
> > -        * We already have cpus for evsel (via PMU sysfs) so
> > -        * keep it, if there's no target cpu list defined.
> > -        */
>
> So basically this code is only needed when the user specified a cpu list.
> Otherwise evsels can use their own cpus.  But it's a kind of sad that
> libperf does not have a notion of PMU (with a cpu map) yet.
>
> I think we have the following cases.  Please tell me if I miss some.
>
> 1. non-hybrid core PMU: It used to not have a cpu map, but you added it
>    in this patchset to cover all (online) CPUs.  So it'd be ok to treat t=
hem as
>    same as the hybrid PMUs.
>
> 2. hybrid core PMU: It has a cpu map to cover possible CPUs and the
>    user requested cpu map should be intersected with its map.

Right, and these two cases should be just considered as core PMU
cases, where there can be >1 core PMU.

> 3. uncore PMU: It has a cpu map to indicate CPUs to handle event
>    settings but it's allowed to read the event from other CPUs (at least
>    for Intel CPUs).  That means it can just use the user request cpu map.

Yep, but uncore can be a confusing name as it means things not in the
core and doesn't include, say the interconnect, that Intel calls
offcore. In pmus.c at the end of this series we have a list of core
pmus and other pmus.

> 4. dummy event: It can be marked as system-wide to get the sideband
>    events from all CPUs.  Then it should ignore the user requested cpu
>    map.  Otherwise it should be treated as other events.

Agreed. Typically dummy is regarded as a software event but the PMU
for software events has an empty CPU map.

> 5. tool event: It's used for perf stat and has a hardcoded cpu map for
>    CPU 0.  Not sure if it can accept other CPUs but it seems we can ignor=
e
>    the user requested cpu map.

Tool events have their PMU type set to software but then we special
case things prior to say displaying the name or reading a counter. The
CPU maps are never used to my knowledge and the enable/running times
look questionable for user and system time.

> 6. other event: No restrictions.  It can use the user requested cpu map.

Here there are software, tracepoint and breakpoint events and there is
no PMU provided CPU map. There are sysfs PMUs for these but they don't
provide a CPU map.

I think the thing that stems from this is the comment on evsel
system_wide is stale:

/*
* system_wide is for events that need to be on every CPU, irrespective
* of user requested CPUs or threads. Map propagation will set cpus to
* this event's own_cpus, whereby they will contribute to evlist
* all_cpus.
*/

If this were true then the empty software PMU's CPU map would be
copied to dummy events when instead every CPU is being requested. I'll
tweak the comment in v4.

Thanks,
Ian


> >         if (evsel->system_wide) {
> > +               /* System wide: set the cpu map of the evsel to all onl=
ine CPUs. */
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus =3D perf_cpu_map__new(NULL);
> > +       } else if (evlist->has_user_cpus && evsel->is_pmu_core) {
> > +               /*
> > +                * User requested CPUs on a core PMU, ensure the reques=
ted CPUs
> > +                * are valid by intersecting with those of the PMU.
> > +                */
> > +               perf_cpu_map__put(evsel->cpus);
> > +               evsel->cpus =3D perf_cpu_map__intersect(evlist->user_re=
quested_cpus, evsel->own_cpus);
> >         } else if (!evsel->own_cpus || evlist->has_user_cpus ||
> > -                  (!evsel->requires_cpu && perf_cpu_map__empty(evlist-=
>user_requested_cpus))) {
> > +               (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evli=
st->user_requested_cpus))) {
> > +               /*
> > +                * The PMU didn't specify a default cpu map, this isn't=
 a core
> > +                * event and the user requested CPUs or the evlist user
> > +                * requested CPUs have the "any CPU" (aka dummy) CPU va=
lue. In
> > +                * which case use the user requested CPUs rather than t=
he PMU
> > +                * ones.
> > +                */
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus =3D perf_cpu_map__get(evlist->user_requeste=
d_cpus);
> >         } else if (evsel->cpus !=3D evsel->own_cpus) {
> > +               /*
> > +                * No user requested cpu map but the PMU cpu map doesn'=
t match
> > +                * the evsel's. Reset it back to the PMU cpu map.
> > +                */
>
> Not sure if it actually happens.
>
> Thanks,
> Namhyung
>
>
> >                 perf_cpu_map__put(evsel->cpus);
> >                 evsel->cpus =3D perf_cpu_map__get(evsel->own_cpus);
> >         }
> > --
> > 2.40.1.698.g37aff9b760-goog
> >
