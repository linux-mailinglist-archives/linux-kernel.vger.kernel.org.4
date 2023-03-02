Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4956A87C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCBRUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCBRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:20:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ECC3B214
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:20:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az36so116971wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 09:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677777620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZeVTVdPwdyRd6x+xvldQA7mLz+VoWHh9S4MWGKf8kM=;
        b=l+VWzJcnfZrt6fvQHMas+YS35D87hEQkID+Ma1vEyRfIXeUFoA3pGylnUsXikikeUx
         Wgt2iN7dr8zKs258L1xUUo8W3HH/xlMdCwE80w5lVvelwOj43DSImOY35QYMwwBkj24k
         T6WKb/WpiG8F8HZZnKsiwKxeDa5+Olkqw8X0gxgE/SPusFsrVUSoiS8hoEYan1uw2mfJ
         rKQo3a2nQXiu9n7VG5u5u1ofi5S/eJFXniScJ3Y8yEHMv/gUH8/ftmIu7AA1rCyzDhF8
         4bzGOSsfHY6tMxUm2nrarkRk4tahB7/asxM+7XT+VXbsD+IY5YOvFlY+h/QdVrw/Zy6E
         TJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677777620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZeVTVdPwdyRd6x+xvldQA7mLz+VoWHh9S4MWGKf8kM=;
        b=n5cgi6dYW7+IfSJts2uyhi5mcEzKnCPYo+TgL1nsc3NFrtcxT0XfDXJuyE5qGDUkxk
         czJW2sQEqGMT/IgM1lhmJx25lZJTZsisJC0goV+S8F0aQvj+xIz94dzn19PlSwNGfyT8
         KmHBwtNsJ9rwx4xKGVDgUR0/zOqANbWJkw3ErvM2WBeRXGLkDoqUG1N8Fn8qGJjKTrSN
         6yDWloa1yl9rIWzDuhtjLEF+aDO010QhPEXNXNyH41iXvC2iRTiECk7salIxpIfneQsC
         Sk7WMKkOBE/wDTiAd1lsASAPpmOo3wMQJbDhRO7uhKy+QnyluYwaMMFhMcXAqHehEIf7
         pHCQ==
X-Gm-Message-State: AO0yUKVStdcWYtnGvo5SyqFSj5SNHAdtdaWm/Ohdi7KySo1yfPxMVTqL
        8Hw5aiww03uGn9zHflt76agNLjaxAKQJlomH/LCySA==
X-Google-Smtp-Source: AK7set94wt5iEh3QWjxGCMWNczh08nzhy56Q3CEf7V7bZK39ryNDJB9mFE/MeG5/MIHohqGLW5fnpGFKwY43YqoAOrE=
X-Received: by 2002:a05:600c:54e1:b0:3e0:f40:f720 with SMTP id
 jb1-20020a05600c54e100b003e00f40f720mr3041118wmb.8.1677777620088; Thu, 02 Mar
 2023 09:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20230302041211.852330-1-irogers@google.com> <20230302041211.852330-10-irogers@google.com>
 <ZAC33ftkLnW4X/P5@kernel.org>
In-Reply-To: <ZAC33ftkLnW4X/P5@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 09:20:07 -0800
Message-ID: <CAP-5=fXBgq8QqdSrHfh4x6N8NSaQUZgKoQQWADXG2rB+HWAwDw@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] perf parse-events: Sort and group parsed events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 6:51=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Em Wed, Mar 01, 2023 at 08:12:10PM -0800, Ian Rogers escreveu:
> > This change is intended to be a no-op for most current cases, the
> > default sort order is the order the events were parsed. Where it
> > varies is in how groups are handled. Previously an uncore and core
> > event that are grouped would most often cause the group to be removed:
>
> And shouldn't that continue to be the case? I.e. the user asks for
> events to be in a group, but that can't be performed, so the tool fails
> and states that those events can't be in a group, looks sensible, no?

I agree with you in principle but it is tricky. Consider:
$ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_write/}'
-a sleep 1

On my Tigerlake laptop there is no imc_free_running PMU, but there are
uncore_imc_free_running_0 and uncore_imc_free_running_1. So when you
parse the expression above we generate a list of the following events:

uncore_imc_free_running_0/data_read/
uncore_imc_free_running_1/data_read/
uncore_imc_free_running_0/data_write/
uncore_imc_free_running_1/data_write/

which wouldn't work as a grouping as there are two PMUs. The groupings
we want are:
{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_0/data_write/=
}
{uncore_imc_free_running_1/data_read/,uncore_imc_free_running_1/data_write/=
}

Similarly for metrics we place all events in a weak group, attempt the
perf_event_open and break the group if that fails. We are running into
issues with this:
1) topdown events must always be in groups
2) the fake PMU in the kernel, used to see whether the scheduling for
the weak group can work, fails to consider errata like two counters
being used on Sandybridge if SMT is enabled due to "leaky" counters

So the vendor updates in:
https://lore.kernel.org/lkml/20230219092848.639226-1-irogers@google.com/
brought in additional flags, but now those flags break things like
topdown events being in a group. For example, the Tigerlake
tma_dram_bound metric doesn't group events, there are more events than
there are counters, but has topdown events which must be in a group.
If that metric leans on the weak group to fail then that's prone to
issues like we see with sandybridge where the group opening succeeds
but you get no counts. If we don't group the events we at least need
to group the topdown events, which is what is fixed here.

Metrics may also do things like counts of X per kilo-instruction. If
we imagine there is an uncore PMU with data_read and data_write, we
could have a metric like:
(uncore_imc@data_read@ + uncore_imc@data_write@) / instructions
It likely makes sense to group the uncore events but we can't group
instructions due to the different PMU. The current behavior is to just
remove all groups.

> Perhaps the tool should continue to fail but provide an alternative
> command line where multiple groups are specified, the user gets educated
> and uses that instead? Probably the logic would be similar to what you
> seem to be doing here?

I think we can pass a flag to say that the event parsing is parsing a
command line. I think we can warn when the groupings change, but as
can be seen in the wildcard uncore case, we expect the groupings to
change. This change will force topdown events into a group, we could
warn for this but the old behavior was just an error and it seems more
friendly just to correct it. In the case of software and aux events,
we expect the groups to be mixed. This means detecting the exact
conditions to warn about and what the corrected user command line
should be are tricky.

The approach taken here is to generalize what we do for uncore
wildcard matching and swap an array sort for a list sort. It seems
likely that this problem will get worse in the future as the layers of
interconnect produce more cases where you want to wildcard some but
not all PMUs. Listing out all PMUs and events is cumbersome, so
wildcards and regular expressions seem useful.

I think when we have examples of useful warnings we should add those
into the code, but we need to take care we don't flag wildcard and
metric groups as being erroneous. With the change as is, we correct
groups but still warn for things like mismatched CPU masks on events.

Thanks,
Ian

> - Arnaldo
>
> >
> > ```
> > $ perf stat -e '{instructions,uncore_imc_free_running_0/data_total/}' -=
a sleep 1
> > WARNING: grouped events cpus do not match, disabling group:
> >   anon group { instructions, uncore_imc_free_running_0/data_total/ }
> > ...
> > ```
> >
> > However, when wildcards are used the events should be re-sorted and
> > re-grouped in parse_events__set_leader, but this currently fails for
> > simple examples:
> >
> > ```
> > $ perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_run=
ning/data_write/}' -a sleep 1
>
> Next time can you state what is the system where this can be tested?
> Saves a bit of time looking for where to test this.
>
> >  Performance counter stats for 'system wide':
> >
> >      <not counted> MiB  uncore_imc_free_running/data_read/
> >      <not counted> MiB  uncore_imc_free_running/data_write/
> >
> >        1.000996992 seconds time elapsed
> > ```
> >
> > A futher failure mode, fixed in this patch, is to force topdown events
>
> further
>
> > into a group.
> >
> > This change moves sorting the evsels in the evlist after parsing. It
> > requires parsing to set up groups. First the evsels are sorted
> > respecting the existing groupings and parse order, but also reordering
> > to ensure evsels of the same PMU and group appear together. So that
> > software and aux events respect groups, their pmu_name is taken from
> > the group leader. The sorting is done with list_sort removing a memory
> > allocation.
> >
> > After sorting a pass is done to correct the group leaders and for
> > topdown events ensuring they have a group leader.
> >
> > This fixes the problems seen before:
> >
> > ```
> > $ perf stat -e '{uncore_imc_free_running/data_read/,uncore_imc_free_run=
ning/data_write/}' -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >             727.42 MiB  uncore_imc_free_running/data_read/
> >              81.84 MiB  uncore_imc_free_running/data_write/
> >
> >        1.000948615 seconds time elapsed
> > ```
> >
> > As well as making groups not fail for cases like:
> >
> > ```
> > $ perf stat -e '{imc_free_running_0/data_total/,imc_free_running_1/data=
_total/}' -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >             256.47 MiB  imc_free_running_0/data_total/
> >             256.48 MiB  imc_free_running_1/data_total/
> >
> >        1.001165442 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/evlist.c |  39 ++---
> >  tools/perf/util/evlist.h          |   2 +-
> >  tools/perf/util/parse-events.c    | 240 +++++++++++++++---------------
> >  tools/perf/util/parse-events.h    |   3 +-
> >  tools/perf/util/parse-events.y    |   4 +-
> >  5 files changed, 136 insertions(+), 152 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/ut=
il/evlist.c
> > index 8a7ae4162563..d4193479a364 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -65,29 +65,22 @@ int arch_evlist__add_default_attrs(struct evlist *e=
vlist,
> >       return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
> >  }
> >
> > -struct evsel *arch_evlist__leader(struct list_head *list)
> > +int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> >  {
> > -     struct evsel *evsel, *first, *slots =3D NULL;
> > -     bool has_topdown =3D false;
> > -
> > -     first =3D list_first_entry(list, struct evsel, core.node);
> > -
> > -     if (!topdown_sys_has_perf_metrics())
> > -             return first;
> > -
> > -     /* If there is a slots event and a topdown event then the slots e=
vent comes first. */
> > -     __evlist__for_each_entry(list, evsel) {
> > -             if (evsel->pmu_name && !strncmp(evsel->pmu_name, "cpu", 3=
) && evsel->name) {
> > -                     if (strcasestr(evsel->name, "slots")) {
> > -                             slots =3D evsel;
> > -                             if (slots =3D=3D first)
> > -                                     return first;
> > -                     }
> > -                     if (strcasestr(evsel->name, "topdown"))
> > -                             has_topdown =3D true;
> > -                     if (slots && has_topdown)
> > -                             return slots;
> > -             }
> > +     if (topdown_sys_has_perf_metrics() &&
> > +         (!lhs->pmu_name || !strncmp(lhs->pmu_name, "cpu", 3))) {
> > +             /* Ensure the topdown slots comes first. */
> > +             if (strcasestr(lhs->name, "slots"))
> > +                     return -1;
> > +             if (strcasestr(rhs->name, "slots"))
> > +                     return 1;
> > +             /* Followed by topdown events. */
> > +             if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->=
name, "topdown"))
> > +                     return -1;
> > +             if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->=
name, "topdown"))
> > +                     return 1;
> >       }
> > -     return first;
> > +
> > +     /* Default ordering by insertion index. */
> > +     return lhs->core.idx - rhs->core.idx;
> >  }
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 01fa9d592c5a..d89d8f92802b 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -119,7 +119,7 @@ int arch_evlist__add_default_attrs(struct evlist *e=
vlist,
> >  #define evlist__add_default_attrs(evlist, array) \
> >       arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
> >
> > -struct evsel *arch_evlist__leader(struct list_head *list);
> > +int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)=
;
> >
> >  int evlist__add_dummy(struct evlist *evlist);
> >  struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system=
_wide);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 1be454697d57..d6eb0a54dd2d 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/hw_breakpoint.h>
> >  #include <linux/err.h>
> > +#include <linux/list_sort.h>
> >  #include <linux/zalloc.h>
> >  #include <dirent.h>
> >  #include <errno.h>
> > @@ -1655,125 +1656,7 @@ int parse_events__modifier_group(struct list_he=
ad *list,
> >       return parse_events__modifier_event(list, event_mod, true);
> >  }
> >
> > -/*
> > - * Check if the two uncore PMUs are from the same uncore block
> > - * The format of the uncore PMU name is uncore_#blockname_#pmuidx
> > - */
> > -static bool is_same_uncore_block(const char *pmu_name_a, const char *p=
mu_name_b)
> > -{
> > -     char *end_a, *end_b;
> > -
> > -     end_a =3D strrchr(pmu_name_a, '_');
> > -     end_b =3D strrchr(pmu_name_b, '_');
> > -
> > -     if (!end_a || !end_b)
> > -             return false;
> > -
> > -     if ((end_a - pmu_name_a) !=3D (end_b - pmu_name_b))
> > -             return false;
> > -
> > -     return (strncmp(pmu_name_a, pmu_name_b, end_a - pmu_name_a) =3D=
=3D 0);
> > -}
> > -
> > -static int
> > -parse_events__set_leader_for_uncore_aliase(char *name, struct list_hea=
d *list,
> > -                                        struct parse_events_state *par=
se_state)
> > -{
> > -     struct evsel *evsel, *leader;
> > -     uintptr_t *leaders;
> > -     bool is_leader =3D true;
> > -     int i, nr_pmu =3D 0, total_members, ret =3D 0;
> > -
> > -     leader =3D list_first_entry(list, struct evsel, core.node);
> > -     evsel =3D list_last_entry(list, struct evsel, core.node);
> > -     total_members =3D evsel->core.idx - leader->core.idx + 1;
> > -
> > -     leaders =3D calloc(total_members, sizeof(uintptr_t));
> > -     if (WARN_ON(!leaders))
> > -             return 0;
> > -
> > -     /*
> > -      * Going through the whole group and doing sanity check.
> > -      * All members must use alias, and be from the same uncore block.
> > -      * Also, storing the leader events in an array.
> > -      */
> > -     __evlist__for_each_entry(list, evsel) {
> > -
> > -             /* Only split the uncore group which members use alias */
> > -             if (!evsel->use_uncore_alias)
> > -                     goto out;
> > -
> > -             /* The events must be from the same uncore block */
> > -             if (!is_same_uncore_block(leader->pmu_name, evsel->pmu_na=
me))
> > -                     goto out;
> > -
> > -             if (!is_leader)
> > -                     continue;
> > -             /*
> > -              * If the event's PMU name starts to repeat, it must be a=
 new
> > -              * event. That can be used to distinguish the leader from
> > -              * other members, even they have the same event name.
> > -              */
> > -             if ((leader !=3D evsel) &&
> > -                 !strcmp(leader->pmu_name, evsel->pmu_name)) {
> > -                     is_leader =3D false;
> > -                     continue;
> > -             }
> > -
> > -             /* Store the leader event for each PMU */
> > -             leaders[nr_pmu++] =3D (uintptr_t) evsel;
> > -     }
> > -
> > -     /* only one event alias */
> > -     if (nr_pmu =3D=3D total_members) {
> > -             parse_state->nr_groups--;
> > -             goto handled;
> > -     }
> > -
> > -     /*
> > -      * An uncore event alias is a joint name which means the same eve=
nt
> > -      * runs on all PMUs of a block.
> > -      * Perf doesn't support mixed events from different PMUs in the s=
ame
> > -      * group. The big group has to be split into multiple small group=
s
> > -      * which only include the events from the same PMU.
> > -      *
> > -      * Here the uncore event aliases must be from the same uncore blo=
ck.
> > -      * The number of PMUs must be same for each alias. The number of =
new
> > -      * small groups equals to the number of PMUs.
> > -      * Setting the leader event for corresponding members in each gro=
up.
> > -      */
> > -     i =3D 0;
> > -     __evlist__for_each_entry(list, evsel) {
> > -             if (i >=3D nr_pmu)
> > -                     i =3D 0;
> > -             evsel__set_leader(evsel, (struct evsel *) leaders[i++]);
> > -     }
> > -
> > -     /* The number of members and group name are same for each group *=
/
> > -     for (i =3D 0; i < nr_pmu; i++) {
> > -             evsel =3D (struct evsel *) leaders[i];
> > -             evsel->core.nr_members =3D total_members / nr_pmu;
> > -             evsel->group_name =3D name ? strdup(name) : NULL;
> > -     }
> > -
> > -     /* Take the new small groups into account */
> > -     parse_state->nr_groups +=3D nr_pmu - 1;
> > -
> > -handled:
> > -     ret =3D 1;
> > -     free(name);
> > -out:
> > -     free(leaders);
> > -     return ret;
> > -}
> > -
> > -__weak struct evsel *arch_evlist__leader(struct list_head *list)
> > -{
> > -     return list_first_entry(list, struct evsel, core.node);
> > -}
> > -
> > -void parse_events__set_leader(char *name, struct list_head *list,
> > -                           struct parse_events_state *parse_state)
> > +void parse_events__set_leader(char *name, struct list_head *list)
> >  {
> >       struct evsel *leader;
> >
> > @@ -1782,13 +1665,9 @@ void parse_events__set_leader(char *name, struct=
 list_head *list,
> >               return;
> >       }
> >
> > -     if (parse_events__set_leader_for_uncore_aliase(name, list, parse_=
state))
> > -             return;
> > -
> > -     leader =3D arch_evlist__leader(list);
> > +     leader =3D list_first_entry(list, struct evsel, core.node);
> >       __perf_evlist__set_leader(list, &leader->core);
> >       leader->group_name =3D name;
> > -     list_move(&leader->core.node, list);
> >  }
> >
> >  /* list_event is assumed to point to malloc'ed memory */
> > @@ -2245,6 +2124,117 @@ static int parse_events__with_hybrid_pmu(struct=
 parse_events_state *parse_state,
> >       return ret;
> >  }
> >
> > +__weak int arch_evlist__cmp(const struct evsel *lhs, const struct evse=
l *rhs)
> > +{
> > +     /* Order by insertion index. */
> > +     return lhs->core.idx - rhs->core.idx;
> > +}
> > +
> > +static int evlist__cmp(void *state, const struct list_head *l, const s=
truct list_head *r)
> > +{
> > +     const struct perf_evsel *lhs_core =3D container_of(l, struct perf=
_evsel, node);
> > +     const struct evsel *lhs =3D container_of(lhs_core, struct evsel, =
core);
> > +     const struct perf_evsel *rhs_core =3D container_of(r, struct perf=
_evsel, node);
> > +     const struct evsel *rhs =3D container_of(rhs_core, struct evsel, =
core);
> > +     int *leader_idx =3D state;
> > +     int lhs_leader_idx =3D *leader_idx, rhs_leader_idx =3D *leader_id=
x, ret;
> > +     const char *lhs_pmu_name, *rhs_pmu_name;
> > +
> > +     /*
> > +      * First sort by grouping/leader. Read the leader idx only if the=
 evsel
> > +      * is part of a group, as -1 indicates no group.
> > +      */
> > +     if (lhs_core->leader !=3D lhs_core || lhs_core->nr_members > 1)
> > +             lhs_leader_idx =3D lhs_core->leader->idx;
> > +     if (rhs_core->leader !=3D rhs_core || rhs_core->nr_members > 1)
> > +             rhs_leader_idx =3D rhs_core->leader->idx;
> > +
> > +     if (lhs_leader_idx !=3D rhs_leader_idx)
> > +             return lhs_leader_idx - rhs_leader_idx;
> > +
> > +     /* Group by PMU. Groups can't span PMUs. */
> > +     lhs_pmu_name =3D evsel__pmu_name(lhs);
> > +     rhs_pmu_name =3D evsel__pmu_name(rhs);
> > +     ret =3D strcmp(lhs_pmu_name, rhs_pmu_name);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Architecture specific sorting. */
> > +     return arch_evlist__cmp(lhs, rhs);
> > +}
> > +
> > +static void parse_events__sort_events_and_fix_groups(struct list_head =
*list)
> > +{
> > +     int idx =3D -1;
> > +     struct evsel *pos, *cur_leader =3D NULL;
> > +     struct perf_evsel *cur_leaders_grp =3D NULL;
> > +
> > +     /*
> > +      * Compute index to insert ungrouped events at. Place them where =
the
> > +      * first ungrouped event appears.
> > +      */
> > +     list_for_each_entry(pos, list, core.node) {
> > +             const struct evsel *pos_leader =3D evsel__leader(pos);
> > +
> > +             if (pos !=3D pos_leader || pos->core.nr_members > 1)
> > +                     continue;
> > +
> > +             idx =3D pos->core.idx;
> > +             break;
> > +     }
> > +
> > +     /* Sort events. */
> > +     list_sort(&idx, list, evlist__cmp);
> > +
> > +     /*
> > +      * Recompute groups, splitting for PMUs and adding groups for eve=
nts
> > +      * that require them.
> > +      */
> > +     idx =3D 0;
> > +     list_for_each_entry(pos, list, core.node) {
> > +             const struct evsel *pos_leader =3D evsel__leader(pos);
> > +             const char *pos_pmu_name =3D evsel__pmu_name(pos);
> > +             const char *cur_leader_pmu_name, *pos_leader_pmu_name;
> > +             bool force_grouped =3D arch_evsel__must_be_in_group(pos);
> > +
> > +             /* Reset index and nr_members. */
> > +             pos->core.idx =3D idx++;
> > +             pos->core.nr_members =3D 0;
> > +
> > +             /*
> > +              * Set the group leader respecting the given groupings an=
d that
> > +              * groups can't span PMUs.
> > +              */
> > +             if (!cur_leader)
> > +                     cur_leader =3D pos;
> > +
> > +             cur_leader_pmu_name =3D evsel__pmu_name(cur_leader);
> > +             if ((cur_leaders_grp !=3D pos->core.leader && !force_grou=
ped) ||
> > +                 strcmp(cur_leader_pmu_name, pos_pmu_name)) {
> > +                     /* Event is for a different group/PMU than last. =
*/
> > +                     cur_leader =3D pos;
> > +                     /*
> > +                      * Remember the leader's group before it is overw=
ritten,
> > +                      * so that later events match as being in the sam=
e
> > +                      * group.
> > +                      */
> > +                     cur_leaders_grp =3D pos->core.leader;
> > +             }
> > +             pos_leader_pmu_name =3D evsel__pmu_name(pos_leader);
> > +             if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_gr=
ouped) {
> > +                     /*
> > +                      * Event's PMU differs from its leader's. Groups =
can't
> > +                      * span PMUs, so update leader from the group/PMU
> > +                      * tracker.
> > +                      */
> > +                     evsel__set_leader(pos, cur_leader);
> > +             }
> > +     }
> > +     list_for_each_entry(pos, list, core.node) {
> > +             pos->core.leader->nr_members++;
> > +     }
> > +}
> > +
> >  int __parse_events(struct evlist *evlist, const char *str,
> >                  struct parse_events_error *err, struct perf_pmu *fake_=
pmu)
> >  {
> > @@ -2266,6 +2256,8 @@ int __parse_events(struct evlist *evlist, const c=
har *str,
> >               return -1;
> >       }
> >
> > +     parse_events__sort_events_and_fix_groups(&parse_state.list);
> > +
> >       /*
> >        * Add list to the evlist even with errors to allow callers to cl=
ean up.
> >        */
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 428e72eaafcc..22fc11b0bd59 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -200,8 +200,7 @@ int parse_events_copy_term_list(struct list_head *o=
ld,
> >
> >  enum perf_pmu_event_symbol_type
> >  perf_pmu__parse_check(const char *name);
> > -void parse_events__set_leader(char *name, struct list_head *list,
> > -                           struct parse_events_state *parse_state);
> > +void parse_events__set_leader(char *name, struct list_head *list);
> >  void parse_events_update_lists(struct list_head *list_event,
> >                              struct list_head *list_all);
> >  void parse_events_evlist_error(struct parse_events_state *parse_state,
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index 541b8dde2063..90d12f2bc8be 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -203,7 +203,7 @@ PE_NAME '{' events '}'
> >
> >       inc_group_count(list, _parse_state);
> >       /* Takes ownership of $1. */
> > -     parse_events__set_leader($1, list, _parse_state);
> > +     parse_events__set_leader($1, list);
> >       $$ =3D list;
> >  }
> >  |
> > @@ -212,7 +212,7 @@ PE_NAME '{' events '}'
> >       struct list_head *list =3D $2;
> >
> >       inc_group_count(list, _parse_state);
> > -     parse_events__set_leader(NULL, list, _parse_state);
> > +     parse_events__set_leader(NULL, list);
> >       $$ =3D list;
> >  }
> >
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
>
> --
>
> - Arnaldo
