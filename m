Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E56718DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjEaWDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjEaWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:03:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465CC138
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:02:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b025aaeddbso22005ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685570578; x=1688162578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM6H0mSVNqo8SpzwZ8nMwGApkrYbRcPDkJWQead2cJQ=;
        b=lXISOARaSujXM85KANC7V8goOWhVXRxR1UDKxTQJFYKRLYS+Yhwvx/LF8MbqWMS/uT
         TxVcUB4NP7QXfRXqbclJwMfFt3ujVtHPScjhDk3oaqJoewEeSIGOrSscscWBToj50MoC
         Ga14XgdVqAQR9LpJ9nwn5WlCxRud0ERyt2ZJkAJypoBpJLS6KCe4biYStjd/LRzmCFNz
         BlVZOWEBQy/UZ/44rebqV5Uoolnu8t/UHbiZwvD8Jvhly5bg11D0FcQzWHvHPs+1+yPR
         g7iunpd7vlnCybL6930EIXn4JtIixjA/nDfKay3/RGZe+YYhih1h9F11m/d4b2kL0k+m
         1qqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570578; x=1688162578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM6H0mSVNqo8SpzwZ8nMwGApkrYbRcPDkJWQead2cJQ=;
        b=YLUJ5qENfl4UYB35z8BQw/tVWomkGJZYRvs5D2aePr6QjQ56AcMy1Fhmr+Xxcjg5yq
         lSN03akmbHzfbmy3NG5wNAo2ET0J2yE9YzUUEy/qz6K4xtVMOXpt8pD9sFFlfDYSLj7U
         HlfXQ70WBA/GgyPPI/JH4DPVV5JPnQzNQZe2C2/e9lFBqRQ0eDjou4Pjcs+8a5TGGfXc
         +W8ZDKwBX8VlqHzGlAtEAEZtf5Jll7C6ipj5hxS05pEWG2ItQK6OJoDUZOc4Gksxzg+u
         chtyvn7pk9vxywOazRCAcFHKUjG40Q7BF6RLAXmPqr1prHT2EdjXkmLjxdLT98txQg0p
         kUiA==
X-Gm-Message-State: AC+VfDyaa72kKfX9F5bGtl4By9rRO7DrbHR0x03SUiNhzQKyI/9lj618
        qskVODuG0oxFOjktZhT0sPo9te+RYluhzQKHd5qGQw==
X-Google-Smtp-Source: ACHHUZ7mSC5S2tgNzxS8qsDxTU2WTAkHRb8bd8amnMZfp9IlLQwt2ks0SahohZw9AEz3B9qgrTe1CAAH3zY5aMvDFD0=
X-Received: by 2002:a17:902:a606:b0:1b0:4a37:9ca7 with SMTP id
 u6-20020a170902a60600b001b04a379ca7mr15629plq.5.1685570577357; Wed, 31 May
 2023 15:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230530232730.155084-1-irogers@google.com> <e9528b08-4d35-b01f-f3e7-861d92224f9c@linux.intel.com>
In-Reply-To: <e9528b08-4d35-b01f-f3e7-861d92224f9c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 31 May 2023 15:02:45 -0700
Message-ID: <CAP-5=fWy5=0C3v0kr3OLMfJEQyu=eSswjeANMVrfC8VnZcUKjQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Wildcard most "numeric" events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 7:04=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-05-30 7:27 p.m., Ian Rogers wrote:
> > Numeric events are either raw events or those with ABI defined numbers
> > matched by the lexer. All raw events that don't specify a PMU type
> > should wildcard match on hybrid systems. So "cycles" should match each
> > PMU type with an extended type, not just PERF_TYPE_HARDWARE.
> >
> > Change wildcard matching to add the event if wildcard PMU scanning
> > fails, there will be no extended type but this best matches previous
> > behavior.
> >
> > Only set the extended type when the event type supports it and when
> > perf_pmus__supports_extended_type is true. This new function returns
> > true if >1 core PMU and avoids potential errors on older kernels.
> >
> > Try to always pass a PMU for parse_events_add_numeric, update
> > evsel__compute_group_pmu_name as software events will have a PMU and
> > pmu_name rather than NULL. This makes homogeneous and heterogeneous
> > PMU events more similar.
> >
> > Set a parse events error if a hardware term's PMU lookup fails to
> > provide extra diagnostics.
>
> I think the patch tries to fix two issues on hybrid.
> - Perf fails to create hardware events for each core PMU when the PMU
> type is not specified.
> - When splitting a group with multiple PMUs, SW events should be created
> for each new sub-groups.

Sorry for that. The 2nd item isn't intended. The behavior of software
events has changed as the code is now assigning all events it can a
PMU, so software events get the software PMU and a pmu_name of
"software".

> It works well for the first issue:
> Before
>
> # perf_old stat -e cycles ./hybrid.sh
>
>  Performance counter stats for './hybrid.sh':
>
>        420,833,619      cycles
>
>        1.219129587 seconds time elapsed
>
> With the patch
>
> # perf stat -e cycles ./hybrid.sh
>
>  Performance counter stats for './hybrid.sh':
>
>        420,691,729      cpu_core/cycles/
>        613,038,584      cpu_atom/cycles/
>                        (98.47%)
>
>        1.219057759 seconds time elapsed

Thanks for checking.

> For the second issue, the new behavior doesn't seem correct for me.
>
> Before
>
> ./perf_old stat -e '{data_read,faults}' --no-merge -a sleep 1
> WARNING: events were regrouped to match PMUs
> WARNING: grouped events cpus do not match.
> Events with CPUs not matching the leader will be removed from the group.
>   anon group { data_read, faults }
>
>  Performance counter stats for 'system wide':
>
>              70.05 MiB  data_read [uncore_imc_free_running_0]
>              55.82 MiB  data_read [uncore_imc_free_running_1]
>                 77      faults
>
>        1.004216885 seconds time elapsed
>
>
> With the patch
>
> # ./perf stat -e '{data_read,faults}' --no-merge -a sleep 1
> WARNING: events were regrouped to match PMUs
> WARNING: grouped events cpus do not match.
> Events with CPUs not matching the leader will be removed from the group.
>   anon group { data_read, faults, faults }
>
>  Performance counter stats for 'system wide':
>
>              53.51 MiB  data_read [uncore_imc_free_running_0]
>              39.04 MiB  data_read [uncore_imc_free_running_1]
>                 76      cpu_core/faults/
>                  2      cpu_atom/faults/

This is wrong, the patch needs to exclude software events from
wildcard PMU lookup. It probably makes sense to exclude anything that
isn't PERF_TYPE_HARDWARE or PERF_TYPE_HW_CACHE.

For PERF_TYPE_RAW, on heterogeneous Intel this matches 'cpu_core' but
at least for ARM the expectation appears to be that this is all core
PMUs. Given the confusion, and not extended type, it probably just
makes sense not to wildcard it.

> The faults is a SW event, but with a core PMU prefix. I think it's wrong.
>
> According to the -vvv information, the faults doesn't seem be regrouped
> with any uncore events.
>
> perf_event_attr:
>   type                             1
>   size                             136
>   config                           0x2
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 =3D 5
> ------------------------------------------------------------
>
> For the second issue, can we make the behavior unchanged for now?

Yep. I wasn't aiming to change it.

> BTW: It seems the current perf-tools-next branch has another regression
> for the JSON event. The inst_retired.any should be available for both
> atom and core. I believe I tried the below commands several days ago.
> But it does't work now. I will check when the regression was introduced.
>
> # ./perf stat -e inst_retired.any ./hybrid.sh
>
>  Performance counter stats for './hybrid.sh':
>
>      3,261,510,386      cpu_core/inst_retired.any/
>                        (99.07%)
>
>        1.218858763 seconds time elapsed

Thanks, this was supposed to be unchanged for this patch. The matching
logic is here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/util/parse-events.y?h=3Dperf-tools-next#n284

I have access to an Alderlake again now, so I'll test the patch and do
the type changes mentioned above for v2.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> > Reported-by: Kan Liang <kan.liang@linux.intel.com>
> > Fixes: 8bc75f699c14 ("perf parse-events: Support wildcards on raw event=
s")
> > Signed-off-by: Ian Rogers <irogers@google.com>> ---
> >  tools/perf/util/parse-events.c | 71 +++++++++++++++++++++-------------
> >  tools/perf/util/parse-events.y |  4 +-
> >  tools/perf/util/pmus.c         |  5 +++
> >  tools/perf/util/pmus.h         |  1 +
> >  4 files changed, 53 insertions(+), 28 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 7f047ac11168..58c9f34bcd95 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -372,7 +372,7 @@ static int config_attr(struct perf_event_attr *attr=
,
> >   *                                     contain hyphens and the longest=
 name
> >   *                                     should always be selected.
> >   */
> > -int parse_events__decode_legacy_cache(const char *name, int pmu_type, =
__u64 *config)
> > +int parse_events__decode_legacy_cache(const char *name, int extended_p=
mu_type, __u64 *config)
> >  {
> >       int len, cache_type =3D -1, cache_op =3D -1, cache_result =3D -1;
> >       const char *name_end =3D &name[strlen(name) + 1];
> > @@ -423,8 +423,9 @@ int parse_events__decode_legacy_cache(const char *n=
ame, int pmu_type, __u64 *con
> >       if (cache_result =3D=3D -1)
> >               cache_result =3D PERF_COUNT_HW_CACHE_RESULT_ACCESS;
> >
> > -     *config =3D ((__u64)pmu_type << PERF_PMU_TYPE_SHIFT) |
> > -             cache_type | (cache_op << 8) | (cache_result << 16);
> > +     *config =3D cache_type | (cache_op << 8) | (cache_result << 16);
> > +     if (perf_pmus__supports_extended_type())
> > +             *config |=3D (__u64)extended_pmu_type << PERF_PMU_TYPE_SH=
IFT;
> >       return 0;
> >  }
> >
> > @@ -1204,11 +1205,17 @@ static int config_term_pmu(struct perf_event_at=
tr *attr,
> >               const struct perf_pmu *pmu =3D perf_pmus__find_by_type(at=
tr->type);
> >
> >               if (!pmu) {
> > -                     pr_debug("Failed to find PMU for type %d", attr->=
type);
> > +                     char *err_str;
> > +
> > +                     if (asprintf(&err_str, "Failed to find PMU for ty=
pe %d", attr->type) >=3D 0)
> > +                             parse_events_error__handle(err, term->err=
_term,
> > +                                                        err_str, /*hel=
p=3D*/NULL);
> >                       return -EINVAL;
> >               }
> >               attr->type =3D PERF_TYPE_HARDWARE;
> > -             attr->config =3D ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT=
) | term->val.num;
> > +             attr->config =3D term->val.num;
> > +             if (perf_pmus__supports_extended_type())
> > +                     attr->config |=3D (__u64)pmu->type << PERF_PMU_TY=
PE_SHIFT;
> >               return 0;
> >       }
> >       if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
> > @@ -1435,8 +1442,8 @@ int parse_events_add_tracepoint(struct list_head =
*list, int *idx,
> >
> >  static int __parse_events_add_numeric(struct parse_events_state *parse=
_state,
> >                               struct list_head *list,
> > -                             struct perf_pmu *pmu, u32 type, u64 confi=
g,
> > -                             struct list_head *head_config)
> > +                             struct perf_pmu *pmu, u32 type, u32 exten=
ded_type,
> > +                             u64 config, struct list_head *head_config=
)
> >  {
> >       struct perf_event_attr attr;
> >       LIST_HEAD(config_terms);
> > @@ -1446,6 +1453,10 @@ static int __parse_events_add_numeric(struct par=
se_events_state *parse_state,
> >       memset(&attr, 0, sizeof(attr));
> >       attr.type =3D type;
> >       attr.config =3D config;
> > +     if (extended_type && (type =3D=3D PERF_TYPE_HARDWARE || type =3D=
=3D PERF_TYPE_HW_CACHE)) {
> > +             assert(perf_pmus__supports_extended_type());
> > +             attr.config |=3D (u64)extended_type << PERF_PMU_TYPE_SHIF=
T;
> > +     };
> >
> >       if (head_config) {
> >               if (config_attr(&attr, head_config, parse_state->error,
> > @@ -1474,24 +1485,26 @@ int parse_events_add_numeric(struct parse_event=
s_state *parse_state,
> >       struct perf_pmu *pmu =3D NULL;
> >       bool found_supported =3D false;
> >
> > -     if (!wildcard)
> > -             return __parse_events_add_numeric(parse_state, list, /*pm=
u=3D*/NULL,
> > -                                               type, config, head_conf=
ig);
> > -
> >       /* Wildcards on numeric values are only supported by core PMUs. *=
/
> > -     while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > -             int ret;
> > +     if (wildcard && perf_pmus__supports_extended_type()) {
> > +             while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > +                     int ret;
> >
> > -             if (parse_events__filter_pmu(parse_state, pmu))
> > -                     continue;
> > +                     found_supported =3D true;
> > +                     if (parse_events__filter_pmu(parse_state, pmu))
> > +                             continue;
> >
> > -             found_supported =3D true;
> > -             ret =3D __parse_events_add_numeric(parse_state, list, pmu=
, pmu->type,
> > -                                              config, head_config);
> > -             if (ret)
> > -                     return ret;
> > +                     ret =3D __parse_events_add_numeric(parse_state, l=
ist, pmu,
> > +                                                      type, pmu->type,
> > +                                                      config, head_con=
fig);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +             if (found_supported)
> > +                     return 0;
> >       }
> > -     return found_supported ? 0 : -EINVAL;
> > +     return __parse_events_add_numeric(parse_state, list, perf_pmus__f=
ind_by_type(type),
> > +                                     type, /*extended_type=3D*/0, conf=
ig, head_config);
> >  }
> >
> >  int parse_events_add_tool(struct parse_events_state *parse_state,
> > @@ -1989,7 +2002,10 @@ static int evsel__compute_group_pmu_name(struct =
evsel *evsel,
> >  {
> >       struct evsel *leader =3D evsel__leader(evsel);
> >       struct evsel *pos;
> > -     const char *group_pmu_name =3D evsel->pmu_name ?: "cpu";
> > +     const char *group_pmu_name =3D "cpu";
> > +
> > +     if (evsel->core.attr.type !=3D PERF_TYPE_SOFTWARE && evsel->pmu_n=
ame)
> > +             group_pmu_name =3D evsel->pmu_name;
> >
> >       /*
> >        * Software events may be in a group with other uncore PMU events=
. Use
> > @@ -2002,14 +2018,17 @@ static int evsel__compute_group_pmu_name(struct=
 evsel *evsel,
> >       if (evsel->core.attr.type =3D=3D PERF_TYPE_SOFTWARE || evsel__is_=
aux_event(leader)) {
> >               /*
> >                * Starting with the leader, find the first event with a =
named
> > -              * PMU. for_each_group_(member|evsel) isn't used as the l=
ist
> > -              * isn't yet sorted putting evsel's in the same group tog=
ether.
> > +              * non-software PMU. for_each_group_(member|evsel) isn't =
used as
> > +              * the list isn't yet sorted putting evsel's in the same =
group
> > +              * together.
> >                */
> > -             if (leader->pmu_name) {
> > +             if (leader->pmu_name && leader->core.attr.type !=3D PERF_=
TYPE_SOFTWARE) {
> >                       group_pmu_name =3D leader->pmu_name;
> >               } else if (leader->core.nr_members > 1) {
> >                       list_for_each_entry(pos, head, core.node) {
> > -                             if (evsel__leader(pos) =3D=3D leader && p=
os->pmu_name) {
> > +                             if (evsel__leader(pos) =3D=3D leader &&
> > +                                 pos->core.attr.type !=3D PERF_TYPE_SO=
FTWARE &&
> > +                                 pos->pmu_name) {
> >                                       group_pmu_name =3D pos->pmu_name;
> >                                       break;
> >                               }
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index abd6ab460e12..48c21314cf6b 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -449,7 +449,7 @@ value_sym '/' event_config '/'
> >       list =3D alloc_list();
> >       ABORT_ON(!list);
> >       err =3D parse_events_add_numeric(_parse_state, list, type, config=
, $3,
> > -                                    /*wildcard=3D*/false);
> > +                                    /*wildcard=3D*/true);
> >       parse_events_terms__delete($3);
> >       if (err) {
> >               free_list_evsel(list);
> > @@ -468,7 +468,7 @@ value_sym sep_slash_slash_dc
> >       ABORT_ON(!list);
> >       ABORT_ON(parse_events_add_numeric(_parse_state, list, type, confi=
g,
> >                                         /*head_config=3D*/NULL,
> > -                                       /*wildcard=3D*/false));
> > +                                       /*wildcard=3D*/true));
> >       $$ =3D list;
> >  }
> >  |
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 53f11f6ce878..e1d0a93147e5 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -477,6 +477,11 @@ int perf_pmus__num_core_pmus(void)
> >       return count;
> >  }
> >
> > +bool perf_pmus__supports_extended_type(void)
> > +{
> > +     return perf_pmus__num_core_pmus() > 1;
> > +}
> > +
> >  struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
> >  {
> >       struct perf_pmu *pmu =3D evsel->pmu;
> > diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> > index 1e710720aec7..d02ffea5d3a4 100644
> > --- a/tools/perf/util/pmus.h
> > +++ b/tools/perf/util/pmus.h
> > @@ -19,5 +19,6 @@ int perf_pmus__num_mem_pmus(void);
> >  void perf_pmus__print_pmu_events(const struct print_callbacks *print_c=
b, void *print_state);
> >  bool perf_pmus__have_event(const char *pname, const char *name);
> >  int perf_pmus__num_core_pmus(void);
> > +bool perf_pmus__supports_extended_type(void);
> >
> >  #endif /* __PMUS_H */
