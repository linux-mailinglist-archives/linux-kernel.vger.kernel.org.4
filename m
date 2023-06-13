Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D933B72ECB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjFMUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:16:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D24173E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:16:55 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f98276f89cso3651cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687414; x=1689279414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VILDqn/KccRl/jLKR5THJyq32eAwj6moG+HYXYE+r+k=;
        b=oRp2tRsaZuk3H1Ad5fNyRoeYmlz9z3W+OswlFi+WPDCNauT/Jmf2ct9rMC9Vy4yw41
         whAgNq0ZxfDbhuTdvQZjA1sd4dOKnaiNS7I74wcj3/40bhTktLVLlSR5vtROaKh10h67
         s71ygJXozgVk/7vs7Xxebx3Nb/BMeInWN5d76qnBHI3UZ8FRW51VM6lykozIBPqySo9J
         vdoFaM4po1OxGNFASLEhX7B1vXnvE9t1WznzPCWRpiJzLlHphpFpsbIRU1Pp/5UwpDIc
         i83pZ5FuyV0nSBRuPNvtSbXmxBFRi4whq43+32YP1ANN7tvojqdF0HXkrkkqBMHtmd5R
         iHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687414; x=1689279414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VILDqn/KccRl/jLKR5THJyq32eAwj6moG+HYXYE+r+k=;
        b=aOeOu9soeYZkqTgHFXk3hEpJTnZ9M8JYbV9ZWvy04r14lqi0d3gBns+ugPM3XdtQ/r
         +Nk+ddB5IMwHq18i7w5JhXGTqC2rSzQTZuYywZ1I13sacx/Bk/VMXAqLRLWIAjNKizti
         koH2oRlcnSMPNzmzZJmPF9sA7CXC3P+Z9gT0ll5x2DOoyOiUUnVJEcC990s24KAWwqeI
         hNzjoy1S+AI8anePmrGRRev2m7sxfnAvXS5t+i8UOtFCZBjSPQqzO0Wu1IlAKQ8gdkll
         GM1S7l7hJHvYDtBFGi9CI4QaJO9gQ6fPc3vOycMbs+JUN21abI0ndRL3WS9uWNVCm+iP
         RJQw==
X-Gm-Message-State: AC+VfDyT9L8HWGYShbP2sqKOBiS2M5mkaOh6iAjFj7v0X1ga9gGQan/m
        PcTaKPPO4JupwaEwNdG1Wdc/KqwK+7U8iJfulMi0hg==
X-Google-Smtp-Source: ACHHUZ5YBu6HVLhk6SucyzzdzLGI4NZ4TR9jcE4eXTc+GMWrfB3g3LdEzWpc4eeqd2j99dZ96pD+AR8NcLZkqrDKrI4=
X-Received: by 2002:a05:622a:54b:b0:3fd:aaef:3807 with SMTP id
 m11-20020a05622a054b00b003fdaaef3807mr48408qtx.16.1686687414155; Tue, 13 Jun
 2023 13:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-7-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-7-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 13:16:42 -0700
Message-ID: <CAP-5=fW0_S-6in=MpgZy0F0ShTfGi0f5FP8-9xA9Rd7pi8j0UQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf stat,metrics: New metricgroup output for the
 default mode
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
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

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> In the default mode, the current output of the metricgroup include both
> events and metrics, which is not necessary and just makes the output
> hard to read. Since different ARCHs (even different generations in the
> same ARCH) may use different events. The output also vary on different
> platforms.
>
> For a metricgroup, only outputting the value of each metric is good
> enough.
>
> Current perf may append different metric groups to the same leader
> event, or append the metrics from the same metricgroup to different
> events. That could bring confusion when perf only prints the
> metricgroup output mode. For example, print the same metricgroup name
> several times.
> Reorganize metricgroup for the default mode and make sure that
> a metricgroup can only be appended to one event.
> Sort the metricgroup for the default mode by the name of the
> metricgroup.
>
> Add a new field default_metricgroup in evsel to indicate an event of
> the default metricgroup. For those events, printout() should print
> the metricgroup name rather than events.
>
> Add print_metricgroup_header() to print out the metricgroup name in
> different output formats.
>
> On SPR
> Before:
>
>  ./perf_old stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.54 msec task-clock:u                     #    0.001 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 68      page-faults:u                    #  125.445 K/sec
>            540,970      cycles:u                         #    0.998 GHz
>            556,325      instructions:u                   #    1.03  insn =
per cycle
>            123,602      branches:u                       #  228.018 M/sec
>              6,889      branch-misses:u                  #    5.57% of al=
l branches
>          3,245,820      TOPDOWN.SLOTS:u                  #     18.4 %  tm=
a_backend_bound
>                                                   #     17.2 %  tma_retir=
ing
>                                                   #     23.1 %  tma_bad_s=
peculation
>                                                   #     41.4 %  tma_front=
end_bound
>            564,859      topdown-retiring:u
>          1,370,999      topdown-fe-bound:u
>            603,271      topdown-be-bound:u
>            744,874      topdown-bad-spec:u
>             12,661      INT_MISC.UOP_DROPPING:u          #   23.357 M/sec
>
>        1.001798215 seconds time elapsed
>
>        0.000193000 seconds user
>        0.001700000 seconds sys
>
> After:
>
> $ ./perf stat sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>               0.51 msec task-clock:u                     #    0.001 CPUs =
utilized
>                  0      context-switches:u               #    0.000 /sec
>                  0      cpu-migrations:u                 #    0.000 /sec
>                 68      page-faults:u                    #  132.683 K/sec
>            545,228      cycles:u                         #    1.064 GHz
>            555,509      instructions:u                   #    1.02  insn =
per cycle
>            123,574      branches:u                       #  241.120 M/sec
>              6,957      branch-misses:u                  #    5.63% of al=
l branches
>                         TopdownL1                 #     17.5 %  tma_backe=
nd_bound
>                                                   #     22.6 %  tma_bad_s=
peculation
>                                                   #     42.7 %  tma_front=
end_bound
>                                                   #     17.1 %  tma_retir=
ing
>                         TopdownL2                 #     21.8 %  tma_branc=
h_mispredicts
>                                                   #     11.5 %  tma_core_=
bound
>                                                   #     13.4 %  tma_fetch=
_bandwidth
>                                                   #     29.3 %  tma_fetch=
_latency
>                                                   #      2.7 %  tma_heavy=
_operations
>                                                   #     14.5 %  tma_light=
_operations
>                                                   #      0.8 %  tma_machi=
ne_clears
>                                                   #      6.1 %  tma_memor=
y_bound
>
>        1.001712086 seconds time elapsed
>
>        0.000151000 seconds user
>        0.001618000 seconds sys
>
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c      |   1 +
>  tools/perf/util/evsel.h        |   1 +
>  tools/perf/util/metricgroup.c  | 106 ++++++++++++++++++++++++++++++++-
>  tools/perf/util/metricgroup.h  |   1 +
>  tools/perf/util/stat-display.c |  69 ++++++++++++++++++++-
>  5 files changed, 172 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 2269b3e90e9b..b274cc264d56 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2172,6 +2172,7 @@ static int add_default_attributes(void)
>
>                         evlist__for_each_entry(metric_evlist, metric_evse=
l) {
>                                 metric_evsel->skippable =3D true;
> +                               metric_evsel->default_metricgroup =3D tru=
e;
>                         }
>                         evlist__splice_list_tail(evsel_list, &metric_evli=
st->core.entries);
>                         evlist__delete(metric_evlist);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 36a32e4ca168..61b1385108f4 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -130,6 +130,7 @@ struct evsel {
>         bool                    reset_group;
>         bool                    errored;
>         bool                    needs_auxtrace_mmap;
> +       bool                    default_metricgroup;

A comment would be useful here, something like:

If running perf stat, is this evsel a member of a Default metric group metr=
ic.

>         struct hashmap          *per_pkg_mask;
>         int                     err;
>         struct {
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index efafa02db5e5..22181ce4f27f 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *=
rblist __maybe_unused,
>                 return NULL;
>         memcpy(me, entry, sizeof(struct metric_event));
>         me->evsel =3D ((struct metric_event *)entry)->evsel;
> +       me->default_metricgroup_name =3D NULL;
>         INIT_LIST_HEAD(&me->head);
>         return &me->nd;
>  }
> @@ -1133,14 +1134,19 @@ static int metricgroup__add_metric_sys_event_iter=
(const struct pmu_metric *pm,
>  /**
>   * metric_list_cmp - list_sort comparator that sorts metrics with more e=
vents to
>   *                   the front. tool events are excluded from the count.
> + *                   For the default metrics, sort them by metricgroup n=
ame.
>   */
> -static int metric_list_cmp(void *priv __maybe_unused, const struct list_=
head *l,
> +static int metric_list_cmp(void *priv, const struct list_head *l,
>                            const struct list_head *r)
>  {
>         const struct metric *left =3D container_of(l, struct metric, nd);
>         const struct metric *right =3D container_of(r, struct metric, nd)=
;
>         struct expr_id_data *data;
>         int i, left_count, right_count;
> +       bool is_default =3D *(bool *)priv;
> +
> +       if (is_default && left->default_metricgroup_name && right->defaul=
t_metricgroup_name)
> +               return strcmp(left->default_metricgroup_name, right->defa=
ult_metricgroup_name);

This breaks the comment above. The events are now sorted prioritizing
default metric group names. This potentially will have an effect of
reducing sharing of events between groups, it will also break
assumptions within that code that there are always the same number of
fewer events in a metric as you process the list. To remedy this I
think you need to re-sort the metrics after the event sharing has had
a chance to share events between groups.


>
>         left_count =3D hashmap__size(left->pctx->ids);
>         perf_tool_event__for_each_event(i) {
> @@ -1497,6 +1503,91 @@ static int parse_ids(bool metric_no_merge, struct =
perf_pmu *fake_pmu,
>         return ret;
>  }
>
> +static struct metric_event *
> +metricgroup__lookup_default_metricgroup(struct rblist *metric_events,
> +                                       struct evsel *evsel,
> +                                       struct metric *m)
> +{
> +       struct metric_event *me;
> +       char *name;
> +       int err;
> +
> +       me =3D metricgroup__lookup(metric_events, evsel, true);
> +       if (!me->default_metricgroup_name) {
> +               if (m->pmu && strcmp(m->pmu, "cpu"))
> +                       err =3D asprintf(&name, "%s (%s)", m->default_met=
ricgroup_name, m->pmu);
> +               else
> +                       err =3D asprintf(&name, "%s", m->default_metricgr=
oup_name);
> +               if (err < 0)
> +                       return NULL;
> +               me->default_metricgroup_name =3D name;
> +       }
> +       if (!strncmp(m->default_metricgroup_name,
> +                    me->default_metricgroup_name,
> +                    strlen(m->default_metricgroup_name)))
> +               return me;
> +
> +       return NULL;
> +}

A function comment would be useful as the name is confusing, why
lookup? Doesn't it create the value? Leak sanitizer isn't happy here:

```
=3D=3D1545918=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 10 byte(s) in 1 object(s) allocated from:
    #0 0x7f2755a7077b in __interceptor_strdup
../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x564986a8df31 in asprintf util/util.c:566
    #2 0x5649869b5901 in metricgroup__lookup_default_metricgroup
util/metricgroup.c:1520
    #3 0x5649869b5e57 in metricgroup__lookup_create util/metricgroup.c:1579
    #4 0x5649869b6ddc in parse_groups util/metricgroup.c:1698
    #5 0x5649869b7714 in metricgroup__parse_groups util/metricgroup.c:1771
    #6 0x5649867da9d5 in add_default_attributes tools/perf/builtin-stat.c:2=
164
    #7 0x5649867ddbfb in cmd_stat tools/perf/builtin-stat.c:2707
    #8 0x5649868fa5a2 in run_builtin tools/perf/perf.c:323
    #9 0x5649868fab13 in handle_internal_command tools/perf/perf.c:377
    #10 0x5649868faedb in run_argv tools/perf/perf.c:421
    #11 0x5649868fb443 in main tools/perf/perf.c:537
    #12 0x7f2754846189 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
```

> +static struct metric_event *
> +metricgroup__lookup_create(struct rblist *metric_events,
> +                          struct evsel **evsel,
> +                          struct list_head *metric_list,
> +                          struct metric *m,
> +                          bool is_default)
> +{
> +       struct metric_event *me;
> +       struct metric *cur;
> +       struct evsel *ev;
> +       size_t i;
> +
> +       if (!is_default)
> +               return metricgroup__lookup(metric_events, evsel[0], true)=
;
> +
> +       /*
> +        * If the metric group has been attached to a previous
> +        * event/metric, use that metric event.
> +        */
> +       list_for_each_entry(cur, metric_list, nd) {
> +               if (cur =3D=3D m)
> +                       break;
> +               if (cur->pmu && strcmp(m->pmu, cur->pmu))
> +                       continue;
> +               if (strncmp(m->default_metricgroup_name,
> +                           cur->default_metricgroup_name,
> +                           strlen(m->default_metricgroup_name)))
> +                       continue;
> +               if (!cur->evlist)
> +                       continue;
> +               evlist__for_each_entry(cur->evlist, ev) {
> +                       me =3D metricgroup__lookup(metric_events, ev, fal=
se);
> +                       if (!strncmp(m->default_metricgroup_name,
> +                                    me->default_metricgroup_name,
> +                                    strlen(m->default_metricgroup_name))=
)
> +                               return me;
> +               }
> +       }
> +
> +       /*
> +        * Different metric groups may append to the same leader event.
> +        * For example, TopdownL1 and TopdownL2 are appended to the
> +        * TOPDOWN.SLOTS event.
> +        * Split it and append the new metric group to the next available
> +        * event.
> +        */
> +       me =3D metricgroup__lookup_default_metricgroup(metric_events, evs=
el[0], m);
> +       if (me)
> +               return me;
> +
> +       for (i =3D 1; i < hashmap__size(m->pctx->ids); i++) {
> +               me =3D metricgroup__lookup_default_metricgroup(metric_eve=
nts, evsel[i], m);
> +               if (me)
> +                       return me;
> +       }
> +       return NULL;
> +}
> +

I have a hard time understanding this function, does it just go away
if you do the two sorts that I proposed above? Should this be
metric_event__lookup_create? A function comment saying what the code
is trying to achieve would be useful.

This appears to be trying to correct output issues by changing how
metrics are associated with events, shouldn't output issues be
resolved by fixing the output code? If not, why don't we apply this
logic to TopdownL1, why just Default?

>  static int parse_groups(struct evlist *perf_evlist,
>                         const char *pmu, const char *str,
>                         bool metric_no_group,
> @@ -1512,6 +1603,7 @@ static int parse_groups(struct evlist *perf_evlist,
>         LIST_HEAD(metric_list);
>         struct metric *m;
>         bool tool_events[PERF_TOOL_MAX] =3D {false};
> +       bool is_default =3D !strcmp(str, "Default");
>         int ret;
>
>         if (metric_events_list->nr_entries =3D=3D 0)
> @@ -1523,7 +1615,7 @@ static int parse_groups(struct evlist *perf_evlist,
>                 goto out;
>
>         /* Sort metrics from largest to smallest. */
> -       list_sort(NULL, &metric_list, metric_list_cmp);
> +       list_sort((void *)&is_default, &metric_list, metric_list_cmp);
>
>         if (!metric_no_merge) {
>                 struct expr_parse_ctx *combined =3D NULL;
> @@ -1603,7 +1695,15 @@ static int parse_groups(struct evlist *perf_evlist=
,
>                         goto out;
>                 }
>
> -               me =3D metricgroup__lookup(metric_events_list, metric_eve=
nts[0], true);
> +               me =3D metricgroup__lookup_create(metric_events_list,
> +                                               metric_events,
> +                                               &metric_list, m,
> +                                               is_default);
> +               if (!me) {
> +                       pr_err("Cannot create metric group for default!\n=
");
> +                       ret =3D -EINVAL;
> +                       goto out;
> +               }
>
>                 expr =3D malloc(sizeof(struct metric_expr));
>                 if (!expr) {
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index bf18274c15df..e3609b853213 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -22,6 +22,7 @@ struct cgroup;
>  struct metric_event {
>         struct rb_node nd;
>         struct evsel *evsel;
> +       char *default_metricgroup_name;
>         struct list_head head; /* list of metric_expr */
>  };
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index a2bbdc25d979..efe5fd04c033 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -21,10 +21,12 @@
>  #include "iostat.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "metricgroup.h"

This is bringing metric code from stat-shadow, which is kind of the
whole reason there is a separation and stat-shadow exists. Should the
logic exist in stat-shadow instead?

>
>  #define CNTR_NOT_SUPPORTED     "<not supported>"
>  #define CNTR_NOT_COUNTED       "<not counted>"
>
> +#define MGROUP_LEN   50
>  #define METRIC_LEN   38
>  #define EVNAME_LEN   32
>  #define COUNTS_LEN   18
> @@ -707,6 +709,55 @@ static bool evlist__has_hybrid(struct evlist *evlist=
)
>         return false;
>  }
>
> +static void print_metricgroup_header_json(struct perf_stat_config *confi=
g,
> +                                         struct outstate *os __maybe_unu=
sed,
> +                                         const char *metricgroup_name)
> +{
> +       fprintf(config->output, "\"metricgroup\" : \"%s\"}", metricgroup_=
name);
> +       new_line_json(config, (void *)os);
> +}
> +

Should the output part of this patch be separate from the
evsel/evlist/meitric modifications?

Thanks,
Ian

> +static void print_metricgroup_header_csv(struct perf_stat_config *config=
,
> +                                        struct outstate *os,
> +                                        const char *metricgroup_name)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < os->nfields; i++)
> +               fputs(config->csv_sep, os->fh);
> +       fprintf(config->output, "%s", metricgroup_name);
> +       new_line_csv(config, (void *)os);
> +}
> +
> +static void print_metricgroup_header_std(struct perf_stat_config *config=
,
> +                                        struct outstate *os __maybe_unus=
ed,
> +                                        const char *metricgroup_name)
> +{
> +       int n =3D fprintf(config->output, " %*s", EVNAME_LEN, metricgroup=
_name);
> +
> +       fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
> +}
> +
> +static void print_metricgroup_header(struct perf_stat_config *config,
> +                                    struct outstate *os,
> +                                    struct evsel *counter,
> +                                    double noise, u64 run, u64 ena,
> +                                    const char *metricgroup_name)
> +{
> +       aggr_printout(config, os->evsel, os->id, os->aggr_nr);
> +
> +       print_noise(config, counter, noise, /*before_metric=3D*/true);
> +       print_running(config, run, ena, /*before_metric=3D*/true);
> +
> +       if (config->json_output) {
> +               print_metricgroup_header_json(config, os, metricgroup_nam=
e);
> +       } else if (config->csv_output) {
> +               print_metricgroup_header_csv(config, os, metricgroup_name=
);
> +       } else
> +               print_metricgroup_header_std(config, os, metricgroup_name=
);
> +
> +}
> +
>  static void printout(struct perf_stat_config *config, struct outstate *o=
s,
>                      double uval, u64 run, u64 ena, double noise, int agg=
r_idx)
>  {
> @@ -751,10 +802,17 @@ static void printout(struct perf_stat_config *confi=
g, struct outstate *os,
>         out.force_header =3D false;
>
>         if (!config->metric_only) {
> -               abs_printout(config, os->id, os->aggr_nr, counter, uval, =
ok);
> +               if (counter->default_metricgroup) {
> +                       struct metric_event *me;
>
> -               print_noise(config, counter, noise, /*before_metric=3D*/t=
rue);
> -               print_running(config, run, ena, /*before_metric=3D*/true)=
;
> +                       me =3D metricgroup__lookup(&config->metric_events=
, counter, false);
> +                       print_metricgroup_header(config, os, counter, noi=
se, run, ena,
> +                                                me->default_metricgroup_=
name);
> +               } else {
> +                       abs_printout(config, os->id, os->aggr_nr, counter=
, uval, ok);
> +                       print_noise(config, counter, noise, /*before_metr=
ic=3D*/true);
> +                       print_running(config, run, ena, /*before_metric=
=3D*/true);
> +               }
>         }
>
>         if (ok) {
> @@ -883,6 +941,11 @@ static void print_counter_aggrdata(struct perf_stat_=
config *config,
>         if (counter->merged_stat)
>                 return;
>
> +       /* Only print the metric group for the default mode */
> +       if (counter->default_metricgroup &&
> +           !metricgroup__lookup(&config->metric_events, counter, false))
> +               return;
> +
>         uniquify_counter(config, counter);
>
>         val =3D aggr->counts.val;
> --
> 2.35.1
>
