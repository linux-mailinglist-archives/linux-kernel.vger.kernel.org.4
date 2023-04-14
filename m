Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396386E2CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDNXEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:04:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF3B40E1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:04:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso152625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681513449; x=1684105449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUeJh9lLhBEEfUin458nCy3VawHkCJwr19MLa4Kox8U=;
        b=2CZMU2MBcl6sTqTVQQRcs4+U8Y5R0UGROoXY+zh5OSZnxBg+42zka7z3im40GZYFG9
         YBkc5tTiLX10zCZbNF5bp9ruiHCcCdVPTV3eMP4q4YzUP8Akxi4l3RZogu9NESehAXri
         HQBUA/dvWIsbgBBZp44Y73pcdxWtRG+Lvok6gZQFvzOl2qkvfLGBF+v0SVdfYrZHxJGC
         FJnBNaE1Meozx2kLEGWnQRx64L4P48gk4c9RNcv69r9Z4g7Qd8nupFMA7l8+jx0GA34m
         u4tdVfpY/xQg9Vfuro4voZej1a5V+FOGvc4NeBzsm2ev34PNrZgvCRL0pmWZRIVufqaH
         BGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681513449; x=1684105449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUeJh9lLhBEEfUin458nCy3VawHkCJwr19MLa4Kox8U=;
        b=e3BiatMYJhN6Hti52RF8Iz+mxOUqnAymyPjfmJUb4Re1n1dpd/+iknYldiDq0ad4sQ
         triAX5Sn26+W1KVD6qiHymA6YSHQ4R2Ahb1tNdVVpRTV/ZXVIwHMnYZflp+oHedSAkII
         KOWHJ1P0T+pzL2/Bwlp0bb9EBW4v62R6ZLyF623+ArLDw+LC1XILFwPPEbaQaEdxP545
         QErDfn0g7BGgaLRanw8+ajEYINnyTicgFT9BcVk84mPl1mhzknTb/6p3l5T98IlQJFN8
         lEAK0EXspbadgyXERCJ/sKpemlcQdqJaDv9LK+54ze0PXVp7ywGtsXlnR1xSVB8i5JSv
         PTZg==
X-Gm-Message-State: AAQBX9cZEY5VSN3K9ip5LbJc3p6p3iN1hbX3f8SqOujtCFh1mzrcqdDY
        39TXpxvUnjL1gS9pw7GGmOiyRQr3AEp35J6S9+m1MA==
X-Google-Smtp-Source: AKy350bD/FEGczb19vNtgoq3PFx3e80o5LlafycZ3Y0Qd7nJBFLpQHHrH6oP2m+DsmIAMgR7bdZyH9deMaNYMcCkG/8=
X-Received: by 2002:a05:600c:3b28:b0:3f1:663e:7aeb with SMTP id
 m40-20020a05600c3b2800b003f1663e7aebmr43168wms.2.1681513449250; Fri, 14 Apr
 2023 16:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
In-Reply-To: <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 14 Apr 2023 16:03:56 -0700
Message-ID: <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 11:07=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-04-14 1:19 a.m., Ian Rogers wrote:
> > Perf stat with no arguments will use default events and metrics. These
> > events may fail to open even with kernel and hypervisor disabled. When
> > these fail then the permissions error appears even though they were
> > implicitly selected. This is particularly a problem with the automatic
> > selection of the TopdownL1 metric group on certain architectures like
> > Skylake:
> >
> > ```
> > $ perf stat true
> > Error:
> > Access to performance monitoring and observability operations is limite=
d.
> > Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > access to performance monitoring and observability operations for proce=
sses
> > without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> > More information can be found at 'Perf events and tool security' docume=
nt:
> > https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> > perf_event_paranoid setting is 2:
> >   -1: Allow use of (almost) all events by all users
> >       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >> =3D 0: Disallow raw and ftrace function tracepoint access
> >> =3D 1: Disallow CPU event access
> >> =3D 2: Disallow kernel profiling
> > To make the adjusted perf_event_paranoid setting permanent preserve it
> > in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
> > ```
> >
> > This patch adds skippable evsels that when they fail to open won't
> > fail and won't appear in output. The TopdownL1 events, from the metric
> > group, are marked as skippable. This turns the failure above to:
> >
> > ```
> > $ perf stat true
> >
> >  Performance counter stats for 'true':
> >
> >               1.26 msec task-clock:u                     #    0.328 CPU=
s utilized
> >                  0      context-switches:u               #    0.000 /se=
c
> >                  0      cpu-migrations:u                 #    0.000 /se=
c
> >                 49      page-faults:u                    #   38.930 K/s=
ec
> >            176,449      cycles:u                         #    0.140 GHz=
                         (48.99%)
>
> Multiplexing?
>
> Thanks,
> Kan

I may have been running a test in the background otherwise I can't
explain it. Repeating the test yields no multiplexing:

```
$ perf stat true

Performance counter stats for 'true':

             0.78 msec task-clock:u                     #    0.383
CPUs utilized
                0      context-switches:u               #    0.000
/sec
                0      cpu-migrations:u                 #    0.000
/sec
               47      page-faults:u                    #   60.174
K/sec
          233,420      cycles:u                         #    0.299 GHz
          133,318      instructions:u                   #    0.57
insn per cycle
           31,396      branches:u                       #   40.196
M/sec
            2,334      branch-misses:u                  #    7.43% of
all branches
        1,167,100      TOPDOWN.SLOTS:u                  #     12.2 %
tma_retiring
                                                 #     28.9 %
tma_backend_bound
                                                 #     41.0 %
tma_frontend_bound
                                                 #     18.0 %
tma_bad_speculation
          141,882      topdown-retiring:u
          480,570      topdown-fe-bound:u
          320,380      topdown-be-bound:u
          224,266      topdown-bad-spec:u
            2,173      INT_MISC.UOP_DROPPING:u          #    2.782
M/sec
            3,323      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #
 4.254 M/sec


      0.002036744 seconds time elapsed

      0.002252000 seconds user
      0.000000000 seconds sys
```

Thanks,
Ian

> >            122,905      instructions:u                   #    0.70  ins=
n per cycle
> >             28,264      branches:u                       #   22.456 M/s=
ec
> >              2,405      branch-misses:u                  #    8.51% of =
all branches
> >
> >        0.003834565 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.004130000 seconds sys
> > ```
> >
> > When the events can have kernel/hypervisor disabled, like on
> > Tigerlake, then it continues to succeed as:
> >
> > ```
> > $ perf stat true
> >
> >  Performance counter stats for 'true':
> >
> >               0.57 msec task-clock:u                     #    0.385 CPU=
s utilized
> >                  0      context-switches:u               #    0.000 /se=
c
> >                  0      cpu-migrations:u                 #    0.000 /se=
c
> >                 47      page-faults:u                    #   82.329 K/s=
ec
> >            287,017      cycles:u                         #    0.503 GHz
> >            133,318      instructions:u                   #    0.46  ins=
n per cycle
> >             31,396      branches:u                       #   54.996 M/s=
ec
> >              2,442      branch-misses:u                  #    7.78% of =
all branches
> >            998,790      TOPDOWN.SLOTS:u                  #     14.5 %  =
tma_retiring
> >                                                   #     27.6 %  tma_bac=
kend_bound
> >                                                   #     40.9 %  tma_fro=
ntend_bound
> >                                                   #     17.0 %  tma_bad=
_speculation
> >            144,922      topdown-retiring:u
> >            411,266      topdown-fe-bound:u
> >            258,510      topdown-be-bound:u
> >            184,090      topdown-bad-spec:u
> >              2,585      INT_MISC.UOP_DROPPING:u          #    4.528 M/s=
ec
> >              3,434      cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/u #=
    6.015 M/sec
> >
> >        0.001480954 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.001686000 seconds sys
> > ```
> >
> > And this likewise works if paranoia allows or running as root.
> >
> > v2. Don't display the skipped events as <not counted> or <not supported=
>.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++--------
> >  tools/perf/util/evsel.c        | 15 +++++++++++--
> >  tools/perf/util/evsel.h        |  1 +
> >  tools/perf/util/stat-display.c |  4 ++++
> >  4 files changed, 48 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index d3cbee7460fc..7a641a67486d 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -667,6 +667,13 @@ static enum counter_recovery stat_handle_error(str=
uct evsel *counter)
> >                       evsel_list->core.threads->err_thread =3D -1;
> >                       return COUNTER_RETRY;
> >               }
> > +     } else if (counter->skippable) {
> > +             if (verbose > 0)
> > +                     ui__warning("skipping event %s that kernel failed=
 to open .\n",
> > +                                 evsel__name(counter));
> > +             counter->supported =3D false;
> > +             counter->errored =3D true;
> > +             return COUNTER_SKIP;
> >       }
> >
> >       evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
> > @@ -1885,15 +1892,29 @@ static int add_default_attributes(void)
> >                * Add TopdownL1 metrics if they exist. To minimize
> >                * multiplexing, don't request threshold computation.
> >                */
> > -             if (metricgroup__has_metric("TopdownL1") &&
> > -                 metricgroup__parse_groups(evsel_list, "TopdownL1",
> > -                                         /*metric_no_group=3D*/false,
> > -                                         /*metric_no_merge=3D*/false,
> > -                                         /*metric_no_threshold=3D*/tru=
e,
> > -                                         stat_config.user_requested_cp=
u_list,
> > -                                         stat_config.system_wide,
> > -                                         &stat_config.metric_events) <=
 0)
> > -                     return -1;
> > +             if (metricgroup__has_metric("TopdownL1")) {
> > +                     struct evlist *metric_evlist =3D evlist__new();
> > +                     struct evsel *metric_evsel;
> > +
> > +                     if (!metric_evlist)
> > +                             return -1;
> > +
> > +                     if (metricgroup__parse_groups(metric_evlist, "Top=
downL1",
> > +                                                     /*metric_no_group=
=3D*/false,
> > +                                                     /*metric_no_merge=
=3D*/false,
> > +                                                     /*metric_no_thres=
hold=3D*/true,
> > +                                                     stat_config.user_=
requested_cpu_list,
> > +                                                     stat_config.syste=
m_wide,
> > +                                                     &stat_config.metr=
ic_events) < 0)
> > +                             return -1;
> > +
> > +                     evlist__for_each_entry(metric_evlist, metric_evse=
l) {
> > +                             metric_evsel->skippable =3D true;
> > +                     }
> > +                     evlist__splice_list_tail(evsel_list, &metric_evli=
st->core.entries);
> > +                     evlist__delete(metric_evlist);
> > +             }
> > +
> >               /* Platform specific attrs */
> >               if (evlist__add_default_attrs(evsel_list, default_null_at=
trs) < 0)
> >                       return -1;
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a85a987128aa..83a65f771666 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -290,6 +290,7 @@ void evsel__init(struct evsel *evsel,
> >       evsel->per_pkg_mask  =3D NULL;
> >       evsel->collect_stat  =3D false;
> >       evsel->pmu_name      =3D NULL;
> > +     evsel->skippable     =3D false;
> >  }
> >
> >  struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
> > @@ -1720,9 +1721,13 @@ static int get_group_fd(struct evsel *evsel, int=
 cpu_map_idx, int thread)
> >               return -1;
> >
> >       fd =3D FD(leader, cpu_map_idx, thread);
> > -     BUG_ON(fd =3D=3D -1);
> > +     BUG_ON(fd =3D=3D -1 && !leader->skippable);
> >
> > -     return fd;
> > +     /*
> > +      * When the leader has been skipped, return -2 to distinguish fro=
m no
> > +      * group leader case.
> > +      */
> > +     return fd =3D=3D -1 ? -2 : fd;
> >  }
> >
> >  static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_th=
reads, int thread_idx)
> > @@ -2104,6 +2109,12 @@ static int evsel__open_cpu(struct evsel *evsel, =
struct perf_cpu_map *cpus,
> >
> >                       group_fd =3D get_group_fd(evsel, idx, thread);
> >
> > +                     if (group_fd =3D=3D -2) {
> > +                             pr_debug("broken group leader for %s\n", =
evsel->name);
> > +                             err =3D -EINVAL;
> > +                             goto out_close;
> > +                     }
> > +
> >                       test_attr__ready();
> >
> >                       /* Debug message used by test scripts */
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 68072ec655ce..98afe3351176 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -95,6 +95,7 @@ struct evsel {
> >               bool                    weak_group;
> >               bool                    bpf_counter;
> >               bool                    use_config_name;
> > +             bool                    skippable;
> >               int                     bpf_fd;
> >               struct bpf_object       *bpf_obj;
> >               struct list_head        config_terms;
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index e6035ecbeee8..6b46bbb3d322 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -810,6 +810,10 @@ static bool should_skip_zero_counter(struct perf_s=
tat_config *config,
> >       struct perf_cpu cpu;
> >       int idx;
> >
> > +     /* Skip counters that were speculatively/default enabled rather t=
han requested. */
> > +     if (counter->skippable)
> > +             return true;
> > +
> >       /*
> >        * Skip value 0 when enabling --per-thread globally,
> >        * otherwise it will have too many 0 output.
