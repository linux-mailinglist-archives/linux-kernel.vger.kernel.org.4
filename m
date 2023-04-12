Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C26DFACA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDLQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjDLQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:04:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D119F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:04:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso66365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681315491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLTqTFa9Ip69IuEGNTE7JFScIC+sdKRnAZUcOxbImQ4=;
        b=F+VxMTARKxZvVNqdLNLAARelVIrVIxdTCNs2lRNhHCBzkV935ikgFTBDsK6S3OAiUI
         e2eiiTy0P1tMgMFam8jTR1rlJ8HuESnUc8KaMwKoCqdhqgsTlXrfhzOlF69ZGTMyadvo
         6xJ6nUjchantXLGUn7knjr7qkF1RzuXOQ988zvVrz2CneEU0dEl4Qn7eEFzp1QYqdYQq
         /TNYdPcu5MzcPG4VatPln9EgPyRF20oX4C9vaMVgbKY4D1EdXnVIAIg8EvxDZHCr/HN9
         F41CKXKvXaClMEzO0wQ96j3KCW8LkT/QUzMp66U6xK9nQldO3iy15tpxdeaH7YaxpthS
         aPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681315491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLTqTFa9Ip69IuEGNTE7JFScIC+sdKRnAZUcOxbImQ4=;
        b=KTM5bowL5587RvVL7NQxrKYEII8H7NBK/KwR3UJN3lyie1Lx2i5TXaTXejLuNXEzSn
         1HInYsEN4bXc6feCX5nStKb2+1cruz0TKeVvsaqhzz5Ctgay++Wm3CXKXfLxazU/LLYF
         mt2NkPRtJ6dPqB5m/1F5k0AsbJTyTtmgUr8qW96gpv3hIIe4V2HnTi1MZVkSpbu734zM
         O4XLo3oTE81C8VMNsNvlLALJEkJr+FBJ7J3sOLV0LejGLMU8O55Er0kMRlQ1U1xXx40J
         vBBFk0lLapGweoSawA8X8+3sOP659sXyUNdhMlMfQPqs/anvHku0EJkS9EEeL+y0iNC4
         O4kg==
X-Gm-Message-State: AAQBX9fPcvv8tG63lssRU7C9RpeEAZkSmrskZZhzJMEIu/FPk8cb1KDL
        MgEhkgVYYZDQkNRjCI4EN0Nj/i0/TFWN2RWwFWAuVQ==
X-Google-Smtp-Source: AKy350aCclzsnkyBri3WUkKXsHvKnsNoAd2ZJc1UxRcHVnMtU0NCb3Kwf5oXJCwIT2QP6LIZlB8HcY/BwhfVK3JGXBs=
X-Received: by 2002:a05:600c:1c08:b0:3f0:9ff0:3b1c with SMTP id
 j8-20020a05600c1c0800b003f09ff03b1cmr115853wms.2.1681315490641; Wed, 12 Apr
 2023 09:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230411205622.3266490-1-irogers@google.com> <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
In-Reply-To: <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Apr 2023 09:04:38 -0700
Message-ID: <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 6:44=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2023-04-11 4:56 p.m., Ian Rogers wrote:
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
> > This patch adds skippable evsels that when they fail to open will be
> > skipped. The TopdownL1 events are marked as skippable. This turns the
> > failure above to:
> >
> > ```
> > $ perf stat true
> >
> >  Performance counter stats for 'true':
> >
> >               1.28 msec task-clock:u                     #    0.323 CPU=
s utilized
> >                  0      context-switches:u               #    0.000 /se=
c
> >                  0      cpu-migrations:u                 #    0.000 /se=
c
> >                 48      page-faults:u                    #   37.550 K/s=
ec
> >            206,228      cycles:u                         #    0.161 GHz=
                         (44.07%)
> >            122,904      instructions:u                   #    0.60  ins=
n per cycle
> >             28,263      branches:u                       #   22.110 M/s=
ec
> >              2,461      branch-misses:u                  #    8.71% of =
all branches
> >      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
> >    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
> >      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
> >      <not counted>      CPU_CLK_UNHALTED.THREAD:u
> >      <not counted>      UOPS_RETIRED.RETIRE_SLOTS:u
> >      <not counted>      UOPS_ISSUED.ANY:u
> >      <not counted>      CPU_CLK_UNHALTED.REF_XCLK:u
> >      <not counted>      IDQ_UOPS_NOT_DELIVERED.CORE:u
> >    <not supported>      INT_MISC.RECOVERY_CYCLES_ANY:u
> >      <not counted>      CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE:u
> >      <not counted>      CPU_CLK_UNHALTED.THREAD:u
> >      <not counted>      UOPS_ISSUED.ANY:u
> >
> >        0.003958627 seconds time elapsed
> >
> >        0.000000000 seconds user
> >        0.004263000 seconds sys
> >
> > Some events weren't counted. Try disabling the NMI watchdog:
> >         echo 0 > /proc/sys/kernel/nmi_watchdog
> >         perf stat ...
> >         echo 1 > /proc/sys/kernel/nmi_watchdog
> > The events in group usually have to be from the same PMU. Try reorganiz=
ing the group.
> > ```
> >
>
> I don't think that's how the perf stat default was designed.
> There should be no multiplexing or <not counted> with perf stat true.
>
>
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
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 39 ++++++++++++++++++++++++++++++---------
> >  tools/perf/util/evsel.c   | 15 +++++++++++++--
> >  tools/perf/util/evsel.h   |  1 +
> >  3 files changed, 44 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 38133afda7fc..024fda0dd943 100644
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
>
>
> I think we should move these to X86 specific code. Maybe we should
> provide something like, arch_perf_stat_default(), for different ARCHs to
> append their specific events with perf stat default, such as
> TopdownL1/L2 on newer Intel machines.
>
> I still don't think we should only rely on the event list for the
> availability of the Topdown feature. For example, the topdown metrics
> hasn't been supported by the KVM yet. If perf stat is launched on a ICL
> VM, you should at least get "not supported" with perf stat true, which
> breaks the design. We need to check the events which are exposed in the
> sysfs, or add a new ABI to expose the capability in
> /sys/devices/cpu/caps/, before appending events to perf stat default.
>
> Thanks,
> Kan

Thanks Kan,

you are talking about a few different things here so let's break it apart.

1) default metrics and TopdownL2. Firstly, this isn't something this
change is seeking to alter. I'm not opposed to defaulting to TopdownL2
when the events are available, so sapphirerapids. The problem is that
when the events are present we may be on a hybrid system and then we
need to mix TopdownL2 and TopdownL1. It seems cleanest to just show
TopdownL1, at least on hybrid. On non-hybrid sapphirerapids it also
seems logical to always show TopdownL1 as, to derive thresholds for
TopdownL2 you need TopdownL1. So what we're really talking about is
that on sapphirerapids it'd be nice to add TopdownL2 to the default
metrics, and as we add default events for particular architectures we
can likewise do it for metrics. To avoid multiplexing in that
scenario, if it is possible with the metrics, the metrics just need
parsing with metric_no_group set to match the previous behavior -
although, something better may be desired to keep groups. We may just
be able to add this logic to evlist__add_default_attrs and it doesn't
strike me as a big deal. When running perf stat with no arguments, I
think defaulting to including the TopdownL1 metrics, when available,
is both useful and good marketing of the feature.

2) perf in kvm support for default metrics. Firstly, perf in kvm
failing to display default metrics is a pre-existing condition and not
one that has changed in the perf-tools-next branch. The particular
events/metrics have changed. In general perf stat hasn't tried to be
proactive in seeing if a perf_event_open will fail before doing it,
the fact that the perf_event_open fails is the signal to switch off
kernel/hypervisor profiling. There's the sandybridge and later problem
that we have with using perf_event_open, for these PMUs the
perf_event_open will succeed but potentially nothing will be counted
to workaround a hardware bug. Detecting all the failure modes for
perf_event_open to me sounds tricky, it will also inherently replicate
what the kernel is already doing, for these reasons I'm comfortable
just using perf_event_open as the way to detect features are present
imperfect as it is - and this will yield not supported/counted as
currently happens.

3) getting not supported/counted in stat output "breaking the design".
So, as mentioned in 2 we already have this breakage in the current
design. Something that is different here is that we know that the
events that fail are ones marked skippable. We could (1) remove
skippable events from the evlist that couldn't be opened or we could
(2) not display skippable events without counts. Doing 2 is the less
invasive change as (1) would need to resolve state with things like
metrics. Perhaps if we do (2) then we can also warn that events
weren't displayed because of permissions. As this sounds like the most
acceptable thing to do, I'll put together a v2 patch set with it.

There are other failures with perf, for example system wide fails with:

```
$ perf stat -a sleep 1
Error:
Access to performance monitoring and observability operations is limited.
Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
access to performance monitoring and observability operations for processes
without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
More information can be found at 'Perf events and tool security' document:
https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
perf_event_paranoid setting is 2:
 -1: Allow use of (almost) all events by all users
     Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
>=3D 0: Disallow raw and ftrace function tracepoint access
>=3D 1: Disallow CPU event access
>=3D 2: Disallow kernel profiling
To make the adjusted perf_event_paranoid setting permanent preserve it
in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
```

I'm not sure this is the most useful error message. We could be more
specific and say the failure relates to system wide events, and
removing those would hopefully yield success. There is also a lack of
testing on these error paths, which if nothing else would document
what the expected behavior should be.

Thanks,
Ian

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
> > index dc3faf005c3b..a09654ea18ec 100644
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
> > @@ -1717,9 +1718,13 @@ static int get_group_fd(struct evsel *evsel, int=
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
> > @@ -2101,6 +2106,12 @@ static int evsel__open_cpu(struct evsel *evsel, =
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
