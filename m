Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5F70C0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjEVOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjEVOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:06:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B715A0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:06:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33164ec77ccso273475ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684764381; x=1687356381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB85uiBgKhjknrygPq+ojSJSwNAZMp9Wa7JXyVxFU0A=;
        b=tpIdvSU6PzqxsEjJLU+aWfWX4bR/m3VqQOSQJk9yHVpfj6sm8O0x4qe0ssuDaW3bmm
         W4tkCg5MFoM1i6N+vbbS6J1Vi2LTwyXOxdsaf4bn0IM8FQnum5BRM2PiciNb3Ki9WelW
         i189EGPazxvor6UiqoVEjT2t1t0a5TUoEYZzxrdVCHioAp0dJ/niQvpRJ9hiPfFvSkir
         hfXfDnyZEUC05P5maVEn0r5/qaDWhx4sxBZe2XQ9RI3zUnsW/HB0MyXjh/7btJz5PplT
         b8okzAc4FMSooPu+oJpKCgEyPbjTMsaj8HP0tvoA+4nyRh9OQgYpUxwJ6IZ41DjCMCoj
         gN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684764381; x=1687356381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB85uiBgKhjknrygPq+ojSJSwNAZMp9Wa7JXyVxFU0A=;
        b=ibvSY1UwBaWEHFNpoJYycY3NyZQrGbt4pxgfBmAS8725hRKMgQlwd0avmBJZ28GliJ
         08ixS0I9MXc/Qjjo8iWgEPYA7i02DAxOL2N7ZeSuaWzQxQ0Rk3nb9g6YLxx8nT/jtV6+
         B7EnjHWnLPo+g8hqazGYfV2KQqT4IMvWUht7Ev+kF0ldKPmjYiw0368FXsH41jmRYpQa
         jUF15ctFEvoZnMFY52jZSnzJMgYSmSv+4RHpr3mfXlR4IE/k+BjRBwLAlmfz+SKxfHJu
         IM2rPZ4d86TS9P6sUOq3mXWC6HWe8EIDJcJNDP/MDaZICbQINXilYAZGraeOsxRHa1vb
         qmEA==
X-Gm-Message-State: AC+VfDyEuyBdvGjVSysika/OQxgtj3FX6/6j5CgMXEc+eG2DDK/l+j6j
        rbipDf8LgtYAeOjN7NPfsWYBqMxN5bNROo68S1v0fg==
X-Google-Smtp-Source: ACHHUZ4VDWLKaikEbEOkmCdE7xFHUZ4WM0HfRPiXx9xBaOU4eOsWBT29d8n1GxbvB5ZBNMehTnonT3uqgyTFWzFXxW8=
X-Received: by 2002:a05:6e02:180d:b0:338:9f6a:d546 with SMTP id
 a13-20020a056e02180d00b003389f6ad546mr445959ilv.20.1684764381435; Mon, 22 May
 2023 07:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com> <20230517145803.559429-6-irogers@google.com>
 <1ea342ab-d68f-26e5-0043-f05b1886009e@linux.intel.com> <CAP-5=fU3OYNsjaJhLq_8tJXZKFARCTqrg3CEr64-3rAm_kTx+A@mail.gmail.com>
 <642c0b26-fcd8-8063-72d2-c74466c29785@linux.intel.com>
In-Reply-To: <642c0b26-fcd8-8063-72d2-c74466c29785@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 22 May 2023 07:06:09 -0700
Message-ID: <CAP-5=fXEzRsmgGdKRbTNiWwNR-L65YVc4hrPjg9FE8V+daMbzg@mail.gmail.com>
Subject: Re: [PATCH v1 05/23] perf pmu: Remove perf_pmu__hybrid_mounted
To:     "Liang, Kan" <kan.liang@linux.intel.com>
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
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
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

On Mon, May 22, 2023 at 4:55=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-05-22 1:21 a.m., Ian Rogers wrote:
> > On Sun, May 21, 2023 at 12:23=E2=80=AFPM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >>
> >> On 2023-05-17 10:57 a.m., Ian Rogers wrote:
> >>> perf_pmu__hybrid_mounted is used to detect whether cpu_core or
> >>> cpu_atom
> >>
> >> Currently, there are only two CPU types for a hybrid machine, core and
> >> atom. But there may be more CPU types added later. Please see the CPUI=
D
> >> 1AH EAX enumeration in SDM VOL2. It has several reserved encodings for
> >> CPU types. It's better not using the hardcode cpu_core/cpu_atom to
> >> replace the perf_pmu__hybrid_mounted().
> >>
> >> Thanks,
> >> Kan
> >
> > This is covered by later patches. Specifically patches like:
> > patch 7: perf pmu: Add is_core to pmu
> > patch 20: Split pmus list into core and uncore
> >
> > Ultimately in pmus.h we have two scan routines, one for all PMUs and
> > one for core PMUs. For everything except hybrid (and the name varies a
> > bit on ARM) the core scan only scans "cpu", on hybrid it scans
> > "cpu_atom" and "cpu_core". The determination of core vs uncore is
> > done without using the name, so can support >2 hybrid PMUs. At this
> > point in the patch series I'm trying to simplify everything so that I
> > can then build the pmus interface.
>
> But if we add a new core type "cpu_whatever" later, we have to hardcode
> the new name to the perf tool, right? Users have to update the perf tool
> for the new platforms, otherwise I think the new type will be treated as
> an uncore PMU.
>
> Since the hybrid is Intel only, I think it may be better move the
> is_pmu_hybrid() to X86 specifc code. For the Intel only code, we already
> have a naming rule for the hybrid name, "cpu_$". So we don't need to
> update the tool for every new CPU type.
>
> Thanks,
> Kan

I don't disagree, but fixing all uses of is_pmu_hybrid and similarly
perf_pmus__has_hybrid is going to add yet more to a moderately long
patch series. I think in most cases is_pmu_hybrid can be replaced by a
core oriented alternative. For example, in pmu.c there is
perf_pmu__auto_merge_stats that normally returns true that we want to
merge counts for uncore or non-hybrid PMUs. For hybrid it returns
false so that cpu_atom and cpu_core counts aren't merged. A core
oriented alternative would be to return false if the PMU is core and
the number of core PMUs is >1 - this also avoids any hard coding of
PMU names and assuming >1 core PMU means they all begin with "cpu_".

The scope of fixing the remaining is_pmu_hybrid and perf_pmus__has_hybrid i=
s:
```
$ grep -rn perf_pmus__has_hybrid tools/perf
tools/perf/util/header.c:1592:  if (perf_pmus__has_hybrid()) {
tools/perf/util/mem-events.c:132:               if (!perf_pmus__has_hybrid(=
)) {
tools/perf/util/mem-events.c:199:               if (!perf_pmus__has_hybrid(=
)) {
tools/perf/util/evsel.c:3139:   if (!perf_pmus__has_hybrid())
tools/perf/util/pmus.h:21:bool perf_pmus__has_hybrid(void);
tools/perf/util/stat-display.c:684:     if (!perf_pmus__has_hybrid())
tools/perf/util/metricgroup.c:277:      bool all_pmus =3D !strcmp(pmu,
"all") || !perf_pmus__has_hybrid() || !is_pmu_hybrid(pmu);
tools/perf/util/pmus.c:474:bool perf_pmus__has_hybrid(void)
tools/perf/util/cputopo.c:477:  if (!perf_pmus__has_hybrid())
tools/perf/tests/attr.c:188:    if (perf_pmus__has_hybrid())
tools/perf/tests/topology.c:44: if (!perf_pmus__has_hybrid()) {
tools/perf/tests/parse-metric.c:306:    if (!perf_pmus__has_hybrid()) {
tools/perf/tests/switch-tracking.c:378: if (perf_pmus__has_hybrid()) {
tools/perf/builtin-record.c:1297:           perf_pmus__has_hybrid()) {
tools/perf/builtin-record.c:2196:       if (!perf_pmus__has_hybrid())
tools/perf/builtin-record.c:4196:       rec->opts.target.hybrid =3D
perf_pmus__has_hybrid();
tools/perf/builtin-stat.c:2463: target.hybrid =3D perf_pmus__has_hybrid();
tools/perf/arch/x86/util/perf_regs.c:295:       if (perf_pmus__has_hybrid()=
) {
tools/perf/arch/x86/util/evlist.c:21:   if (!perf_pmus__has_hybrid())
tools/perf/arch/x86/tests/hybrid.c:284: if (!perf_pmus__has_hybrid())

$ grep -rn is_pmu_hybrid tools/perf
tools/perf/util/pmu.c:1433:bool is_pmu_hybrid(const char *name)
tools/perf/util/pmu.c:1445:     return !is_pmu_hybrid(pmu->name);
tools/perf/util/pmu.h:224:bool is_pmu_hybrid(const char *name);
tools/perf/util/metricgroup.c:277:      bool all_pmus =3D !strcmp(pmu,
"all") || !perf_pmus__
has_hybrid() || !is_pmu_hybrid(pmu);
tools/perf/util/pmus.c:482:                     if (is_pmu_hybrid(pmu->name=
)) {
```

So, I think it makes sense to do it as a follow up.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >>> is mounted with a non-empty cpus file by
> >>> pmu_lookup. pmu_lookup will attempt to read the cpus file too and so
> >>> the check can be folded into this.
> >>>
> >>> Checking hybrid_mounted in pmu_is_uncore is redundant as the next
> >>> cpumask read will fail returning false.
> >>>
> >>> Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/pmu-hybrid.c | 15 +--------------
> >>>  tools/perf/util/pmu-hybrid.h |  3 ---
> >>>  tools/perf/util/pmu.c        | 26 ++++++++++++++------------
> >>>  3 files changed, 15 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybri=
d.c
> >>> index bc4cb0738c35..7fe943dd3217 100644
> >>> --- a/tools/perf/util/pmu-hybrid.c
> >>> +++ b/tools/perf/util/pmu-hybrid.c
> >>> @@ -18,20 +18,7 @@
> >>>
> >>>  LIST_HEAD(perf_pmu__hybrid_pmus);
> >>>
> >>> -bool perf_pmu__hybrid_mounted(const char *name)
> >>> -{
> >>> -     int cpu;
> >>> -     char pmu_name[PATH_MAX];
> >>> -     struct perf_pmu pmu =3D {.name =3D pmu_name};
> >>> -
> >>> -     if (strncmp(name, "cpu_", 4))
> >>> -             return false;
> >>> -
> >>> -     strlcpy(pmu_name, name, sizeof(pmu_name));
> >>> -     return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
> >>> -}
> >>> -
> >>> -struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
> >>> +static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
> >>>  {
> >>>       struct perf_pmu *pmu;
> >>>
> >>> diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybri=
d.h
> >>> index 206b94931531..8dbcae935020 100644
> >>> --- a/tools/perf/util/pmu-hybrid.h
> >>> +++ b/tools/perf/util/pmu-hybrid.h
> >>> @@ -13,9 +13,6 @@ extern struct list_head perf_pmu__hybrid_pmus;
> >>>  #define perf_pmu__for_each_hybrid_pmu(pmu)   \
> >>>       list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
> >>>
> >>> -bool perf_pmu__hybrid_mounted(const char *name);
> >>> -
> >>> -struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
> >>>  bool perf_pmu__is_hybrid(const char *name);
> >>>
> >>>  static inline int perf_pmu__hybrid_pmu_num(void)
> >>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >>> index 1e0be23d4dd7..729b1f166f80 100644
> >>> --- a/tools/perf/util/pmu.c
> >>> +++ b/tools/perf/util/pmu.c
> >>> @@ -617,9 +617,6 @@ static bool pmu_is_uncore(int dirfd, const char *=
name)
> >>>  {
> >>>       int fd;
> >>>
> >>> -     if (perf_pmu__hybrid_mounted(name))
> >>> -             return false;
> >>> -
> >>>       fd =3D perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
> >>>       if (fd < 0)
> >>>               return false;
> >>> @@ -898,6 +895,16 @@ static int pmu_max_precise(int dirfd, struct per=
f_pmu *pmu)
> >>>       return max_precise;
> >>>  }
> >>>
> >>> +/**
> >>> + * perf_pmu__skip_empty_cpus() - should pmu_lookup skip the named PM=
U if the
> >>> + *      cpus or cpumask file isn't present?
> >>> + * @name: Name of PMU.
> >>> + */
> >>> +static bool perf_pmu__skip_empty_cpus(const char *name)
> >>> +{
> >>> +     return !strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom");
> >>> +}
> >>> +
> >>>  static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_nam=
e)
> >>>  {
> >>>       struct perf_pmu *pmu;
> >>> @@ -905,15 +912,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, co=
nst char *lookup_name)
> >>>       LIST_HEAD(aliases);
> >>>       __u32 type;
> >>>       char *name =3D pmu_find_real_name(lookup_name);
> >>> -     bool is_hybrid =3D perf_pmu__hybrid_mounted(name);
> >>>       char *alias_name;
> >>>
> >>> -     /*
> >>> -      * Check pmu name for hybrid and the pmu may be invalid in sysf=
s
> >>> -      */
> >>> -     if (!strncmp(name, "cpu_", 4) && !is_hybrid)
> >>> -             return NULL;
> >>> -
> >>>       /*
> >>>        * The pmu data we store & need consists of the pmu
> >>>        * type value and format definitions. Load both right
> >>> @@ -933,8 +933,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, co=
nst char *lookup_name)
> >>>               return NULL;
> >>>
> >>>       pmu->cpus =3D pmu_cpumask(dirfd, name);
> >>> -     pmu->name =3D strdup(name);
> >>> +     if (!pmu->cpus && perf_pmu__skip_empty_cpus(name))
> >>> +             goto err;
> >>>
> >>> +     pmu->name =3D strdup(name);
> >>>       if (!pmu->name)
> >>>               goto err;
> >>>
> >>> @@ -964,7 +966,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, con=
st char *lookup_name)
> >>>       list_splice(&aliases, &pmu->aliases);
> >>>       list_add_tail(&pmu->list, &pmus);
> >>>
> >>> -     if (is_hybrid)
> >>> +     if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
> >>>               list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus=
);
> >>>       else
> >>>               INIT_LIST_HEAD(&pmu->hybrid_list);
