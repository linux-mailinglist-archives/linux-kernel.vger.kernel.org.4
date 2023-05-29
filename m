Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF78714DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjE2QQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjE2QQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:16:21 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3156A0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:16:18 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33b187adfafso254175ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685376978; x=1687968978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKSJDqNfnH6DBBqgEYa1REE3Bo8m4BfdWDhphN34pVA=;
        b=ulDHXXw0kKIT2HmPomfjhiajht+EbSBfMfjlxp3X/8qMspHcbYlCrd7zzj2QA7zNDd
         h/kPdYsekpQLbUeoPsJXmdJEVBt6MczNJNBGbB0vuEZhUIQDygHs4CqEh/rWAFMut101
         sXUtWE7aWk+/RcfHGwhjMzA4xdR+ylPeQ6SqZkADkxXPiPSETGfle4aLJe2DIaICSq3P
         t+VP+dQxFNekBcL10uTtylrKO8rQdco++BONSopXtwz+HJTblt6T+nHFplBjfHF2j1gM
         qt9kG3WDGsMpsXpqFaOr6Z9+GLw8oB5IIX2MTbqnKnDD2cH9hWWYIKmpLtx9eRuTvz1q
         aOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376978; x=1687968978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKSJDqNfnH6DBBqgEYa1REE3Bo8m4BfdWDhphN34pVA=;
        b=V6Zpr8Qa9HEal8gcMkTpmaVlnhma3+RQtsJY4IlBVi4M7BhFoe05Sibm9htyB0U+5I
         AdwXlJtQXrVj9U7oE7RzvyfkX+sB3FuaxyRKei0aU+3ueNTuVauP52pVRsg/hga1p2yZ
         wgZG5jY70kDhF2B/ScpfxUwQb5WqIwlrzl6AAYOVM+B3D9aSAji2TRo4LrAmuPP1QAqK
         y2VU/Vg1Svi3aVpNrbAc5zMiHQLkhE82JXNWq4+vlnBf24fKiPxdNhh1B3dK/MylXYt5
         oYuIJHOTYt35B5T5w9HeVVmcFXqeKoNiyuhq2dGxwIbdleJfJHfoSfl7/Owl56r5XiQJ
         7isQ==
X-Gm-Message-State: AC+VfDxaDnlUahbttHJic6ZRSteuwNxVTgLJ1oOr3c8JgTgIy1B3E2TA
        f9uvC/5yWyGqzZtHJJLFAywvXyjuQCbfOW147qImrw==
X-Google-Smtp-Source: ACHHUZ7SvZreHKQCGdhY6XF2RYllUwkz7G99ln+uBBK/OmK/Lf1xZPxmBXN80I7GQgV1YAop3kVwy/9a7QQnICAKQTk=
X-Received: by 2002:a05:6e02:1e06:b0:335:e50d:9b11 with SMTP id
 g6-20020a056e021e0600b00335e50d9b11mr329745ila.7.1685376977876; Mon, 29 May
 2023 09:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230523044446.1020769-1-irogers@google.com> <0dc8fa26-248d-61eb-b224-4353443ddd6b@intel.com>
 <CAP-5=fXfJmBEuEa1ujYmoExWos-6PG4F=7XTaO6MouEQXLuE0Q@mail.gmail.com> <780caf46-683a-3702-5478-d203c38189cb@intel.com>
In-Reply-To: <780caf46-683a-3702-5478-d203c38189cb@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 May 2023 09:16:06 -0700
Message-ID: <CAP-5=fWJZT66Sk+8-qX=z254683yuOeiOczWstnJL91nCzVVXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf evsel: evsel__group_pmu_name fixes
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, May 29, 2023 at 9:03=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 23/05/23 19:58, Ian Rogers wrote:
> > On Tue, May 23, 2023 at 6:01=E2=80=AFAM Adrian Hunter <adrian.hunter@in=
tel.com> wrote:
> >>
> >> On 23/05/23 07:44, Ian Rogers wrote:
> >>> Previously the evsel__group_pmu_name would iterate the evsel's group,
> >>> however, the list of evsels aren't yet sorted and so the loop may
> >>> terminate prematurely. It is also not desirable to iterate the list o=
f
> >>> evsels during list_sort as the list may be broken. Precompute the
> >>> group_pmu_name for the evsel before sorting, as part of the
> >>> computation and only if necessary, iterate the whole list looking for
> >>> group members so that being sorted isn't necessary.
> >>>
> >>> Move the group pmu name computation to parse-events.c given the close=
r
> >>> dependency on the behavior of
> >>> parse_events__sort_events_and_fix_groups.
> >>>
> >>> Fixes: 7abf0bccaaec ("perf evsel: Add function to compute group PMU n=
ame")
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/evsel.c        | 31 +++++-----------------
> >>>  tools/perf/util/evsel.h        |  2 +-
> >>>  tools/perf/util/parse-events.c | 47 ++++++++++++++++++++++++++++++--=
--
> >>>  3 files changed, 50 insertions(+), 30 deletions(-)
> >>>
> >>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >>> index 2f5910b31fa9..3247773f9e24 100644
> >>> --- a/tools/perf/util/evsel.c
> >>> +++ b/tools/perf/util/evsel.c
> >>> @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
> >>>       evsel->per_pkg_mask  =3D NULL;
> >>>       evsel->collect_stat  =3D false;
> >>>       evsel->pmu_name      =3D NULL;
> >>> +     evsel->group_pmu_name =3D NULL;
> >>>       evsel->skippable     =3D false;
> >>>  }
> >>>
> >>> @@ -431,6 +432,11 @@ struct evsel *evsel__clone(struct evsel *orig)
> >>>               if (evsel->pmu_name =3D=3D NULL)
> >>>                       goto out_err;
> >>>       }
> >>> +     if (orig->group_pmu_name) {
> >>> +             evsel->group_pmu_name =3D strdup(orig->group_pmu_name);
> >>> +             if (evsel->group_pmu_name =3D=3D NULL)
> >>> +                     goto out_err;
> >>> +     }
> >>>       if (orig->filter) {
> >>>               evsel->filter =3D strdup(orig->filter);
> >>>               if (evsel->filter =3D=3D NULL)
> >>> @@ -827,30 +833,6 @@ bool evsel__name_is(struct evsel *evsel, const c=
har *name)
> >>>       return !strcmp(evsel__name(evsel), name);
> >>>  }
> >>>
> >>> -const char *evsel__group_pmu_name(const struct evsel *evsel)
> >>> -{
> >>> -     struct evsel *leader =3D evsel__leader(evsel);
> >>> -     struct evsel *pos;
> >>> -
> >>> -     /*
> >>> -      * Software events may be in a group with other uncore PMU even=
ts. Use
> >>> -      * the pmu_name of the first non-software event to avoid breaki=
ng the
> >>> -      * software event out of the group.
> >>> -      *
> >>> -      * Aux event leaders, like intel_pt, expect a group with events=
 from
> >>> -      * other PMUs, so substitute the AUX event's PMU in this case.
> >>> -      */
> >>> -     if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__i=
s_aux_event(leader)) {
> >>> -             /* Starting with the leader, find the first event with =
a named PMU. */
> >>> -             for_each_group_evsel(pos, leader) {
> >>> -                     if (pos->pmu_name)
> >>> -                             return pos->pmu_name;
> >>> -             }
> >>> -     }
> >>> -
> >>> -     return evsel->pmu_name ?: "cpu";
> >>> -}
> >>> -
> >>>  const char *evsel__metric_id(const struct evsel *evsel)
> >>>  {
> >>>       if (evsel->metric_id)
> >>> @@ -1536,6 +1518,7 @@ void evsel__exit(struct evsel *evsel)
> >>>       zfree(&evsel->group_name);
> >>>       zfree(&evsel->name);
> >>>       zfree(&evsel->pmu_name);
> >>> +     zfree(&evsel->group_pmu_name);
> >>>       zfree(&evsel->unit);
> >>>       zfree(&evsel->metric_id);
> >>>       evsel__zero_per_pkg(evsel);
> >>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >>> index df8928745fc6..820771a649b2 100644
> >>> --- a/tools/perf/util/evsel.h
> >>> +++ b/tools/perf/util/evsel.h
> >>> @@ -72,6 +72,7 @@ struct evsel {
> >>>               char                    *name;
> >>>               char                    *group_name;
> >>>               const char              *pmu_name;
> >>> +             const char              *group_pmu_name;
> >>
> >> Since it seems to be only used when sorting, do we really
> >> need this on struct evsel?
> >
> > Agreed. There is also redundancy between evsel->pmu_name and
> > evsel->pmu->name. For now having it here makes the coding easier and
> > it could be a useful were we to do more with sorting, like sorting the
> > final evlist rather than each evlist post parsing, or for debug
> > output.
> >
> >>>  #ifdef HAVE_LIBTRACEEVENT
> >>>               struct tep_event        *tp_format;
> >>>  #endif
> >>> @@ -289,7 +290,6 @@ int arch_evsel__hw_name(struct evsel *evsel, char=
 *bf, size_t size);
> >>>  int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, ch=
ar *bf, size_t size);
> >>>  const char *evsel__name(struct evsel *evsel);
> >>>  bool evsel__name_is(struct evsel *evsel, const char *name);
> >>> -const char *evsel__group_pmu_name(const struct evsel *evsel);
> >>>  const char *evsel__metric_id(const struct evsel *evsel);
> >>>
> >>>  static inline bool evsel__is_tool(const struct evsel *evsel)
> >>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-e=
vents.c
> >>> index 34ba840ae19a..210e6f713c6f 100644
> >>> --- a/tools/perf/util/parse-events.c
> >>> +++ b/tools/perf/util/parse-events.c
> >>> @@ -2125,6 +2125,41 @@ static int parse_events__with_hybrid_pmu(struc=
t parse_events_state *parse_state,
> >>>       return ret;
> >>>  }
> >>>
> >>> +static void evsel__compute_group_pmu_name(struct evsel *evsel,
> >>> +                                       const struct list_head *head)
> >>> +{
> >>> +     struct evsel *leader =3D evsel__leader(evsel);
> >>> +     struct evsel *pos;
> >>> +
> >>> +     /*
> >>> +      * Software events may be in a group with other uncore PMU even=
ts. Use
> >>> +      * the pmu_name of the first non-software event to avoid breaki=
ng the
> >>> +      * software event out of the group.
> >>> +      *
> >>> +      * Aux event leaders, like intel_pt, expect a group with events=
 from
> >>> +      * other PMUs, so substitute the AUX event's PMU in this case.
> >>> +      */
> >>> +     if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__i=
s_aux_event(leader)) {
> >>> +             /*
> >>> +              * Starting with the leader, find the first event with =
a named
> >>> +              * PMU. for_each_group_(member|evsel) isn't used as the=
 list
> >>> +              * isn't yet sorted putting evsel's in the same group t=
ogether.
> >>> +              */
> >>> +             if (leader->pmu_name) {
> >>> +                     evsel->group_pmu_name =3D strdup(leader->pmu_na=
me);
> >>> +                     return;
> >>> +             }
> >>> +             list_for_each_entry(pos, head, core.node) {
> >>> +                     if (evsel__leader(pos) =3D=3D leader && pos->pm=
u_name) {
> >>> +                             evsel->group_pmu_name =3D strdup(pos->p=
mu_name);
> >>> +                             return;
> >>> +                     }
> >>> +             }
> >>> +     }
> >>> +
> >>> +     evsel->group_pmu_name =3D strdup(evsel->pmu_name ?: "cpu");
> >>> +}
> >>> +
> >>>  __weak int arch_evlist__cmp(const struct evsel *lhs, const struct ev=
sel *rhs)
> >>>  {
> >>>       /* Order by insertion index. */
> >>> @@ -2160,8 +2195,8 @@ static int evlist__cmp(void *state, const struc=
t list_head *l, const struct list
> >>>
> >>>       /* Group by PMU if there is a group. Groups can't span PMUs. */
> >>>       if (lhs_has_group && rhs_has_group) {
> >>> -             lhs_pmu_name =3D evsel__group_pmu_name(lhs);
> >>> -             rhs_pmu_name =3D evsel__group_pmu_name(rhs);
> >>> +             lhs_pmu_name =3D lhs->group_pmu_name;
> >>> +             rhs_pmu_name =3D rhs->group_pmu_name;
> >>>               ret =3D strcmp(lhs_pmu_name, rhs_pmu_name);
> >>>               if (ret)
> >>>                       return ret;
> >>> @@ -2186,6 +2221,8 @@ static bool parse_events__sort_events_and_fix_g=
roups(struct list_head *list)
> >>>       list_for_each_entry(pos, list, core.node) {
> >>>               const struct evsel *pos_leader =3D evsel__leader(pos);
> >>>
> >>> +             evsel__compute_group_pmu_name(pos, list);
> >>
> >> Perhaps check for failing to allocate the string?
> >
> > Will fix in v2.
> >
> >> But alternatively, allocate an array for pointers to the
> >> group pmu names.  Then they don't needed to be strdup'ed,
> >> or stored on evsel.  Would have to count the number of evsel
> >> first though.
> >>
> >>         group_pmu_names =3D calloc(nr_evsel, sizeof(const char *));
> >>
> >>         group_pmu_names[pos->core.idx] =3D evsel__group_pmu_name(pos);
> >
> > Possibly, I'd prefer to keep it as simple as possible until we think
> > we should optimize.
> >
> >>> +
> >>>               if (pos =3D=3D pos_leader)
> >>>                       orig_num_leaders++;
> >>>
> >>> @@ -2210,7 +2247,7 @@ static bool parse_events__sort_events_and_fix_g=
roups(struct list_head *list)
> >>>       idx =3D 0;
> >>>       list_for_each_entry(pos, list, core.node) {
> >>>               const struct evsel *pos_leader =3D evsel__leader(pos);
> >>> -             const char *pos_pmu_name =3D evsel__group_pmu_name(pos)=
;
> >>> +             const char *pos_pmu_name =3D pos->group_pmu_name;
> >>>               const char *cur_leader_pmu_name, *pos_leader_pmu_name;
> >>>               bool force_grouped =3D arch_evsel__must_be_in_group(pos=
);
> >>>
> >>> @@ -2227,7 +2264,7 @@ static bool parse_events__sort_events_and_fix_g=
roups(struct list_head *list)
> >>>               if (!cur_leader)
> >>>                       cur_leader =3D pos;
> >>>
> >>> -             cur_leader_pmu_name =3D evsel__group_pmu_name(cur_leade=
r);
> >>> +             cur_leader_pmu_name =3D cur_leader->group_pmu_name;
> >>>               if ((cur_leaders_grp !=3D pos->core.leader && !force_gr=
ouped) ||
> >>>                   strcmp(cur_leader_pmu_name, pos_pmu_name)) {
> >>>                       /* Event is for a different group/PMU than last=
. */
> >>> @@ -2239,7 +2276,7 @@ static bool parse_events__sort_events_and_fix_g=
roups(struct list_head *list)
> >>>                        */
> >>>                       cur_leaders_grp =3D pos->core.leader;
> >>>               }
> >>> -             pos_leader_pmu_name =3D evsel__group_pmu_name(pos_leade=
r);
> >>> +             pos_leader_pmu_name =3D pos_leader->group_pmu_name;
> >>>               if (strcmp(pos_leader_pmu_name, pos_pmu_name) || force_=
grouped) {
> >>>                       /*
> >>>                        * Event's PMU differs from its leader's. Group=
s can't
> >>
> >> By the way, do we really need unsorted_idx?
> >
> > Right, I've played around with this a bit. I'll have a go at
> > explaining the motivation below.
> >
> >> For example what about this for evlist__cmp():
> >>
> >> static int evlist__cmp(void *state __maybe_unused, const struct list_h=
ead *l, const struct list_head *r)
> >> {
> >>         const struct evsel *lhs =3D container_of(l, struct evsel, core=
.node);
> >>         const struct evsel *rhs =3D container_of(r, struct evsel, core=
.node);
> >>         int lhs_leader_idx =3D lhs->core.leader->idx;
> >>         int rhs_leader_idx =3D rhs->core.leader->idx;
> >>         int ret;
> >>
> >>         if (lhs_leader_idx !=3D rhs_leader_idx)
> >>                 return lhs_leader_idx - rhs_leader_idx;
> >
> > So here any ungrouped evsels, or evsels in different groups will cause
> > evlist__cmp to terminate.
> >
> >>         ret =3D strcmp(evsel__group_pmu_name(lhs), evsel__group_pmu_na=
me(rhs));
> >>         if (ret)
> >>                 return ret;
> >
> > This is redundant as the leader matches on both lhs and rhs given the
> > test above.
> >
> >>         /* Architecture specific sorting. */
> >>         return arch_evlist__cmp(lhs, rhs);
> >
> > We'll never reach here for cases like ungrouped topdown (perf metric)
> > events where we want to sort the topdown events to allow grouping. I
> > think the comment:
> >
> > /*
> > * First sort by grouping/leader. Read the leader idx only if the evsel
> > * is part of a group, as -1 indicates no group.
> > */
> >
> > isn't clear. I'll tweak it in v2, I think it would be better as somethi=
ng like:
> >
> > /*
> > * First sort by grouping/leader. Read the leader idx only if the evsel
> > * is part of a group, by default ungrouped events will be sorted relati=
ve
> > * to grouped events based
> > * on where the first ungrouped event occurs. If both events don't have
> > * a group we want to fall-through to the arch specific sorting, that ca=
n
> > * reorder and fix things like Intel's topdown events.
> > */
> >
> > To go back to why the code became this way. By default we'll place
> > metric's events into a weak group and if the perf_event_open fails
> > we'll break the group. We're smart enough to know when breaking a
> > group of events that the topdown event's group must not be broken.
> > However, there are cases where the perf_event_open succeeds but then
> > the counters yield "<not counted>" as they are part of a group. I've
> > asked for kernel fixes to fail the perf_event_open, maybe they'll
> > happen, for now I need to be able to work on old kernels anyway.
> > Metrics with "<not counted>" events are now tagged as saying the
> > events shouldn't be grouped but this has a problem of breaking the
> > grouping for topdown events. We already had to sort events for cases
> > like "{imc/cas_count_read/,imc/cas_count_write/}" where we have
> > multiple imc PMUs and we need to group cas_count_read and
> > cas_count_write events for each PMU - the eventual grouping looks like
> > "{uncore_imc_0/cas_count_read/,uncore_imc_0/cas_count_write/},{uncore_i=
mc_1/cas_count_read/,uncore_imc_1/cas_count_write/}...".
> > The aim with the code was to have a single sorting mechanism for the
> > existing uncore case and the new ungrouped topdown events case.
>
> Are there any tests for that?

Not specifically. The parse-events tests don't test it as we don't yet
have a way to force the sysfs layout for a test. The attribute test
has some coverage of topdown events in the default case, because the
TopdownL1 metrics are parsed. The metric test checks the metrics work,
which involves topdown and uncore event regrouping, but they consider
any output valid. Weilin is working to improve this.

Fwiw, the original issue that sparked this fix was the parse-events
tests but only with clang and compilation level O1.

Thanks,
Ian
