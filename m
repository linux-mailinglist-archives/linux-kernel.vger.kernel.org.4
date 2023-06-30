Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC8744274
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjF3Sk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjF3SkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:40:11 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6423C35
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:40:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40345bf4875so44471cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688150400; x=1690742400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMhdF7XmZUrQzEGOBCLhK60sECD90kqP+92O6yGTFyM=;
        b=iWsTvzTBqM8kolIuXx0id5TEB937GwMk+2ZqoY456wWh7pG3N8BU0g4ywtsLS2la8a
         QKrbPNUgpaYexx+1l40HqupvHmxWR4Rb4P3veemDHb1lTBcaabyPlwtNj4IyxV7DezMm
         C2ypT3ynlBSl/pPD5Xb1/BG+VN8YaZFJbxDCMLw1vETcKWKGme08yjUnSMkHRQDPd6VG
         Swy/wx2sqQffLupwR9zwxy+vZfz2sYSS8w/c7YBOx4aqQls62F3s2WGNWw/ES9tuj5ad
         62H96Ci4ijA+9oSCF0sCB2wSZ0IvPDvn6E8Z8CnICLuOXbe9bMoU5307Mr8sMjjMp+VH
         0avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150400; x=1690742400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMhdF7XmZUrQzEGOBCLhK60sECD90kqP+92O6yGTFyM=;
        b=i3u4YXy62navSqn7JLAi3F+Q+nTrbtqysEnE2wGjwKFP6B2slht6CXHUX+Erm9TAlY
         8Q0fw1ZrMJxl3EYzZYl+xECr3MRNhlVBE54YWkMTkxnllGNFW+mgV/6e8fdaRiVIuySc
         KavkXVlAQFNvpjCrwRIHUIfu6kddlZcswG+k1CV1zlMCbgXnnPhcWjPFt2m3knOhFHjU
         6jJ0U4noGSAI+aEnMLhTXiEMGwFgnns/081OR+FndZpUrilJHgLQRDQ9oB0lHklPg8h6
         jycopIWJRAsVU4ddewESZbC7I1lswrrIGT6ctsdhtYxs05CPy0L8lKGkn+y9gqaLqwOw
         xP1w==
X-Gm-Message-State: ABy/qLbQE/Ea6FGEw9GvV9C1nCVwlllvUdEev04qCQgw+CRqwn0Z/g5o
        6XVfHcGkaYi7BECqbb5X2gdyqqfiOCnYidxavpPCgw==
X-Google-Smtp-Source: APBJJlHJrnMSqi8V5RX1eIMBqnmr7LPrFQQ1b8Y5Qaheazr200SwE8XUuCuy+9FRgOlkD/KAbPQb2asHgWUZSP4fs6o=
X-Received: by 2002:ac8:5841:0:b0:3f2:1441:3c11 with SMTP id
 h1-20020ac85841000000b003f214413c11mr14347qth.2.1688150400094; Fri, 30 Jun
 2023 11:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com> <20230628102949.2598096-4-john.g.garry@oracle.com>
In-Reply-To: <20230628102949.2598096-4-john.g.garry@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 11:39:48 -0700
Message-ID: <CAP-5=fVS5Y2VxSDNdcXjc0Y90J7XpCXtxXU_=_Fjn6MJkuz3nA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/9] perf metrics: Pass cpu and sys tables to metricgroup__add_metric()
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
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

On Wed, Jun 28, 2023 at 3:30=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> The current @table arg may be a CPU metric table or a sys metric table.
> There is no point in searching the CPU metric table for a sys metric, and
> vice versa, so pass separate pointers
>
> When sys metric table is passed, this would mean that we are in self-test
> mode. In this mode, the host system cannot match events in the metric
> expression as the associated PMUs may not be present. As such, just try
> add the metric, see metricgroup__add_metric_sys_event_iter().

Thanks John, I'm not opposed to this change. My understanding is it
will give greater testing coverage. As previously mentioned I'd like
longer term we have a sysfs like abstraction for the json events. For
CPUs this could be like:

<cpuid>/cpu/events/inst_retired.any
<cpuid>/cpu/events/inst_retired.any.scale
<cpuid>/cpu/events/inst_retired.any.unit
<cpuid>/cpu/events/inst_retired.any.desc
...
<cpuid>/cpu/metrics/ipc
<cpuid>/cpu/metrics/ipc.scale
<cpuid>/cpu/metrics/ipc.unit
...
<cpuid>/uncore_imc_free_running_0/events/unc_mc0_rdcas_count_freerun
...

Where <cpuid> comes from mapfile.csv. I'd like to union the in memory
json event generated sysfs, with the kernel sysfs. There needs to be
some kind of wildcard mechanism for all the uncore counters. Such a
union-ing could allow on an disk sysfs, and this could be a route for
testing.

For sys metrics I guess we'd so something like:

sys/hisi_sicl/events/cpa_cycles
sys/hisi_sicl/events/cpa_cycles.desc
...
sys/cpa/events/cpa_cycles
sys/cpa/cpa_cycles.desc
...

or perhaps have some kind of wildcard matching syntax:

sys/(hisi_sicl|cpa)/events/cpa_cycles
sys/(hisi_sicl|cpa)/events/cpa_cycles.desc
...

So ultimately I can imagine the distinction of sys and cpu are going
to become less, and we just test properties of PMUs. The ideas of
tables should be hidden, but we could have a boolean on a PMU to say
whether it is a sys or cpu type.

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/tests/expand-cgroup.c |  2 +-
>  tools/perf/tests/parse-metric.c  |  2 +-
>  tools/perf/tests/pmu-events.c    | 29 +++++++++++++++-----
>  tools/perf/util/metricgroup.c    | 45 +++++++++++++++++++++++---------
>  tools/perf/util/metricgroup.h    |  3 ++-
>  5 files changed, 59 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-c=
group.c
> index 9c1a1f18db75..50e128ddb474 100644
> --- a/tools/perf/tests/expand-cgroup.c
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -187,7 +187,7 @@ static int expand_metric_events(void)
>
>         rblist__init(&metric_events);
>         pme_test =3D find_core_metrics_table("testarch", "testcpu");
> -       ret =3D metricgroup__parse_groups_test(evlist, pme_test, metric_s=
tr, &metric_events);
> +       ret =3D metricgroup__parse_groups_test(evlist, pme_test, NULL, me=
tric_str, &metric_events);

nit: Here and below. Could we name the argument here, so:
ret =3D metricgroup__parse_groups_test(evlist, pme_test,
/*sys_table=3D*/NULL, metric_str, &metric_events);
for clarity it would be nice if pme_test were cpu_table.

Thanks,
Ian


>         if (ret < 0) {
>                 pr_debug("failed to parse '%s' metric\n", metric_str);
>                 goto out;
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-met=
ric.c
> index 2c28fb50dc24..e146f1193294 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -95,7 +95,7 @@ static int __compute_metric(const char *name, struct va=
lue *vals,
>
>         /* Parse the metric into metric_events list. */
>         pme_test =3D find_core_metrics_table("testarch", "testcpu");
> -       err =3D metricgroup__parse_groups_test(evlist, pme_test, name,
> +       err =3D metricgroup__parse_groups_test(evlist, pme_test, NULL, na=
me,
>                                              &metric_events);
>         if (err)
>                 goto out;
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.=
c
> index 64383fc34ef1..de571fd11cd7 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -798,9 +798,9 @@ struct metric {
>         struct metric_ref metric_ref;
>  };
>
> -static int test__parsing_callback(const struct pmu_metric *pm,
> +static int _test__parsing_callback(const struct pmu_metric *pm,
>                                   const struct pmu_metrics_table *table,
> -                                 void *data)
> +                                 void *data, bool is_cpu_table)
>  {
>         int *failures =3D data;
>         int k;
> @@ -811,6 +811,8 @@ static int test__parsing_callback(const struct pmu_me=
tric *pm,
>                 .nr_entries =3D 0,
>         };
>         int err =3D 0;
> +       const struct pmu_metrics_table *cpu_table =3D is_cpu_table ? tabl=
e : NULL;
> +       const struct pmu_metrics_table *sys_table =3D is_cpu_table ? NULL=
 : table;
>
>         if (!pm->metric_expr)
>                 return 0;
> @@ -834,7 +836,8 @@ static int test__parsing_callback(const struct pmu_me=
tric *pm,
>
>         perf_evlist__set_maps(&evlist->core, cpus, NULL);
>
> -       err =3D metricgroup__parse_groups_test(evlist, table, pm->metric_=
name, &metric_events);
> +       err =3D metricgroup__parse_groups_test(evlist, cpu_table, sys_tab=
le,
> +                                            pm->metric_name, &metric_eve=
nts);
>         if (err) {
>                 if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_=
name, "M2") ||
>                     !strcmp(pm->metric_name, "M3")) {
> @@ -890,13 +893,27 @@ static int test__parsing_callback(const struct pmu_=
metric *pm,
>         return err;
>  }
>
> -static int test__parsing(struct test_suite *test __maybe_unused,
> +static int test__parsing_callback_cpu(const struct pmu_metric *pm,
> +                                 const struct pmu_metrics_table *table,
> +                                 void *data)
> +{
> +       return _test__parsing_callback(pm, table, data, true);
> +}
> +
> +static int test__parsing_callback_sys(const struct pmu_metric *pm,
> +                                 const struct pmu_metrics_table *table,
> +                                 void *data)
> +{
> +       return _test__parsing_callback(pm, table, data, false);
> +}
> +
> +static __maybe_unused int test__parsing(struct test_suite *test __maybe_=
unused,
>                          int subtest __maybe_unused)
>  {
>         int failures =3D 0;
>
> -       pmu_for_each_core_metric(test__parsing_callback, &failures);
> -       pmu_for_each_sys_metric(test__parsing_callback, &failures);
> +       pmu_for_each_core_metric(test__parsing_callback_cpu, &failures);
> +       pmu_for_each_sys_metric(test__parsing_callback_sys, &failures);
>
>         return failures =3D=3D 0 ? TEST_OK : TEST_FAIL;
>  }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 8d2ac2513530..520436fbe99d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1232,13 +1232,14 @@ static int metricgroup__add_metric(const char *pm=
u, const char *metric_name, con
>                                    const char *user_requested_cpu_list,
>                                    bool system_wide,
>                                    struct list_head *metric_list,
> -                                  const struct pmu_metrics_table *table)
> +                                  const struct pmu_metrics_table *cpu_ta=
ble,
> +                                  const struct pmu_metrics_table *sys_ta=
ble)
>  {
>         LIST_HEAD(list);
>         int ret;
>         bool has_match =3D false;
>
> -       {
> +       if (cpu_table) {
>                 struct metricgroup__add_metric_data data =3D {
>                         .list =3D &list,
>                         .pmu =3D pmu,
> @@ -1254,7 +1255,7 @@ static int metricgroup__add_metric(const char *pmu,=
 const char *metric_name, con
>                  * Iterate over all metrics seeing if metric matches eith=
er the
>                  * name or group. When it does add the metric to the list=
.
>                  */
> -               ret =3D pmu_metrics_table_for_each_metric(table, metricgr=
oup__add_metric_callback,
> +               ret =3D pmu_metrics_table_for_each_metric(cpu_table, metr=
icgroup__add_metric_callback,
>                                                        &data);
>                 if (ret)
>                         goto out;
> @@ -1267,7 +1268,21 @@ static int metricgroup__add_metric(const char *pmu=
, const char *metric_name, con
>                 goto out;
>         }
>
> -       {
> +       if (sys_table) {
> +               struct metricgroup_add_iter_data data =3D {
> +                       .metric_list =3D &list,
> +                       .pmu =3D pmu,
> +                       .metric_name =3D metric_name,
> +                       .modifier =3D modifier,
> +                       .metric_no_group =3D metric_no_group,
> +                       .user_requested_cpu_list =3D user_requested_cpu_l=
ist,
> +                       .system_wide =3D system_wide,
> +                       .has_match =3D &has_match,
> +                       .ret =3D &ret,
> +               };
> +               pmu_metrics_table_for_each_metric(sys_table,
> +                       metricgroup__add_metric_sys_event_iter, &data);
> +       } else {
>                 struct metricgroup_iter_data data =3D {
>                         .fn =3D metricgroup__add_metric_sys_event_iter,
>                         .data =3D (void *) &(struct metricgroup_add_iter_=
data) {
> @@ -1320,7 +1335,8 @@ static int metricgroup__add_metric_list(const char =
*pmu, const char *list,
>                                         bool metric_no_threshold,
>                                         const char *user_requested_cpu_li=
st,
>                                         bool system_wide, struct list_hea=
d *metric_list,
> -                                       const struct pmu_metrics_table *t=
able)
> +                                       const struct pmu_metrics_table *c=
pu_table,
> +                                       const struct pmu_metrics_table *s=
ys_table)
>  {
>         char *list_itr, *list_copy, *metric_name, *modifier;
>         int ret, count =3D 0;
> @@ -1338,7 +1354,8 @@ static int metricgroup__add_metric_list(const char =
*pmu, const char *list,
>                 ret =3D metricgroup__add_metric(pmu, metric_name, modifie=
r,
>                                               metric_no_group, metric_no_=
threshold,
>                                               user_requested_cpu_list,
> -                                             system_wide, metric_list, t=
able);
> +                                             system_wide, metric_list, c=
pu_table,
> +                                             sys_table);
>                 if (ret =3D=3D -EINVAL)
>                         pr_err("Cannot find metric or group `%s'\n", metr=
ic_name);
>
> @@ -1534,7 +1551,8 @@ static int parse_groups(struct evlist *perf_evlist,
>                         bool system_wide,
>                         struct perf_pmu *fake_pmu,
>                         struct rblist *metric_events_list,
> -                       const struct pmu_metrics_table *table)
> +                       const struct pmu_metrics_table *cpu_table,
> +                       const struct pmu_metrics_table *sys_table)
>  {
>         struct evlist *combined_evlist =3D NULL;
>         LIST_HEAD(metric_list);
> @@ -1547,7 +1565,7 @@ static int parse_groups(struct evlist *perf_evlist,
>                 metricgroup__rblist_init(metric_events_list);
>         ret =3D metricgroup__add_metric_list(pmu, str, metric_no_group, m=
etric_no_threshold,
>                                            user_requested_cpu_list,
> -                                          system_wide, &metric_list, tab=
le);
> +                                          system_wide, &metric_list, cpu=
_table, sys_table);
>         if (ret)
>                 goto out;
>
> @@ -1697,18 +1715,19 @@ int metricgroup__parse_groups(struct evlist *perf=
_evlist,
>                               bool system_wide,
>                               struct rblist *metric_events)
>  {
> -       const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
> +       const struct pmu_metrics_table *cpu_table =3D pmu_metrics_table__=
find();
>
> -       if (!table)
> +       if (!cpu_table)
>                 return -EINVAL;
>
>         return parse_groups(perf_evlist, pmu, str, metric_no_group, metri=
c_no_merge,
>                             metric_no_threshold, user_requested_cpu_list,=
 system_wide,
> -                           /*fake_pmu=3D*/NULL, metric_events, table);
> +                           /*fake_pmu=3D*/NULL, metric_events, cpu_table=
, NULL);
>  }
>
>  int metricgroup__parse_groups_test(struct evlist *evlist,
> -                                  const struct pmu_metrics_table *table,
> +                                  const struct pmu_metrics_table *cpu_ta=
ble,
> +                                  const struct pmu_metrics_table *sys_ta=
ble,
>                                    const char *str,
>                                    struct rblist *metric_events)
>  {
> @@ -1718,7 +1737,7 @@ int metricgroup__parse_groups_test(struct evlist *e=
vlist,
>                             /*metric_no_threshold=3D*/false,
>                             /*user_requested_cpu_list=3D*/NULL,
>                             /*system_wide=3D*/false,
> -                           &perf_pmu__fake, metric_events, table);
> +                           &perf_pmu__fake, metric_events, cpu_table, sy=
s_table);
>  }
>
>  struct metricgroup__has_metric_data {
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index d5325c6ec8e1..b5f0d598eaec 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -79,7 +79,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlis=
t,
>                               bool system_wide,
>                               struct rblist *metric_events);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
> -                                  const struct pmu_metrics_table *table,
> +                                  const struct pmu_metrics_table *cpu_ta=
ble,
> +                                  const struct pmu_metrics_table *sys_ta=
ble,
>                                    const char *str,
>                                    struct rblist *metric_events);
>
> --
> 2.35.3
>
