Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447C6EA093
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjDUAUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 20:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDUAUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 20:20:16 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012A44AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:20:14 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3e0965f70ecso968431cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 17:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682036413; x=1684628413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7tSO9JVWpUxREzmBE/AtfUmxjjKC3XzPrJTXq3xxjA=;
        b=ur5oZsdmGFfnFYXcGW41k6uZxUSmC3SirIKFSQm+Mhu1P/8PW/rP/vVmfeHp0RxoL9
         5fNk6gao5xe4n4XKgKFVJAhixOJVyoeRMiFYPzlKqzgZVMpGSJxmTqwM1pSrnJlfxzFe
         zW71yihiMO5KsK8VdH13BPd6OLHKGfwmO1kZgQPsFKVLD7XhzwiWSVbKoyB4Si4gB/jY
         fAzWdj2t+WkIe0V7zceYRAcQc8QGqjCBKS9wsU0HI07mWpA0sBSCCWsiQd3DEbWE2AYJ
         GecFqZdKHZ1qYCmUGjbgwl0a7Y4n6EDQ0d+/b34TKMOQ2vk20Mi8w4t1IqNAkrzypDo5
         XWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682036413; x=1684628413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7tSO9JVWpUxREzmBE/AtfUmxjjKC3XzPrJTXq3xxjA=;
        b=fUWhpCGTQIn/UVpWEKMkLVL+1HyWyaHXDNt6jCSDkGJEk6sVUhFeswV5yEFv3m5g9T
         2xVc8L9BaxPJGVd4EBUkzGBQX8bjUx/svM4unXs6tifD0T5x5IMoKbl5lMCKDsYsRv0C
         1I51PTyJao5AIuk9RpGIEsUZH7p8pYawa/osyRtz4YXNO8xYpX/3hmMS8hjD2ay3amJ9
         SNzFXuM5iIrbNW4lgFjOPM6FdnChNjMUgCxIHqHFKbovjR80LfseCDvr9YGxByLhCMT1
         yyQlG5cRdMjEoR8l+CS1e5+13BLabqHtqya3xsf9csjNpHk389Efaer9YNYT5EGYDO5X
         NXuQ==
X-Gm-Message-State: AAQBX9dh0oCp4/vqq6lx+ypuaFC20C5x5pqW57Y56WeO+zVhBwQ/lLfT
        RZyKIcWoVz6KMLB0MNHqhYM/Qa0UpF2pQAT58C8wxQ==
X-Google-Smtp-Source: AKy350ZykY7yU9RwLaaUi7HKwVR6hWcHJEPzLeilN1eFwGoUEZ4E6Q63DUB9MPr+eRNKiDikwodQ9yZPK++LpIsBmlw=
X-Received: by 2002:a05:622a:1813:b0:3ef:330c:8f9e with SMTP id
 t19-20020a05622a181300b003ef330c8f9emr169301qtc.10.1682036413124; Thu, 20 Apr
 2023 17:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
 <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com> <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com> <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com> <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com> <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
 <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com>
In-Reply-To: <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Apr 2023 17:19:58 -0700
Message-ID: <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 6:04=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-19 8:23 p.m., Ian Rogers wrote:
> > On Wed, Apr 19, 2023 at 11:57=E2=80=AFAM Liang, Kan <kan.liang@linux.in=
tel.com> wrote:
> >>
> >>
> >> On 2023-04-19 12:51 p.m., Ian Rogers wrote:
> >>>>>>> With that change I don't have a case that requires skippable evse=
ls,
> >>>>>>> and so we can take that series with patch 6 over the v1 of that s=
eries
> >>>>>>> with this change.
> >>>>>>>
> >>>>>>
> >>>>>> I'm afraid this is not the only problem the commit 94b1a603fca7 ("=
perf
> >>>>>> stat: Add TopdownL1 metric as a default if present") in the
> >>>>>> perf-tools-next branch introduced.
> >>>>>>
> >>>>>> The topdown L2 in the perf stat default on SPR and big core of the=
 ADL
> >>>>>> is still missed. I don't see a possible fix for this on the curren=
t
> >>>>>> perf-tools-next branch.
> >>>>>
> >>>>> I thought in its current state the json metrics for TopdownL2 on SP=
R
> >>>>> have multiplexing. Given L1 is used to drill down to L2, it seems o=
dd
> >>>>> to start on L2, but given L1 is used to compute the thresholds for =
L2,
> >>>>> this should be to have both L1 and L2 on these platforms. However,
> >>>>> that doesn't work as you don't want multiplexing.
> >>>>>
> >>>>> This all seems backward to avoid potential multiplexing on branch m=
iss
> >>>>> rate and IPC, just always having TopdownL1 seems cleanest with the
> >>>>> skippable evsels working around the permissions issue - as put forw=
ard
> >>>>> in this patch. Possibly adding L2 metrics on ADL/SPR, but only once
> >>>>> the multiplexing issue is resolved.
> >>>>>
> >>>>
> >>>> No, not just that issue. Based to what I tested these days, perf sta=
t
> >>>> default has issues/regressions on most of the Intel platforms with t=
he
> >>>> current perf-tools-next and perf/core branch of acme's repo.
> >>>>
> >>>> For the pre-ICL platforms:
> >>>> - The permission issue. (This patch tried to address.)
> >>>> - Unclean perf stat default. (This patch failed to address.)
> >>>>   Unnecessary multiplexing for cycles.
> >>>>   Display partial of the TopdownL1
> >>>>
> >>>> https://lore.kernel.org/lkml/d1fe801a-22d0-1f9b-b127-227b21635bd5@li=
nux.intel.com/
> >>>>
> >>>> For SPR platforms
> >>>> - Topdown L2 metrics is missed, while it works with the current 6.3-=
rc7.
> >>>>
> >>>> For ADL/RPL platforms
> >>>> - Segmentation fault which I just found this morning.
> >>>> # ./perf stat true
> >>>> Segmentation fault (core dumped)
> >>>
> >>> This may also stem from the reference count checking work that Arnald=
o
> >>> is currently merging. It is hard to test hybrid because it uses
> >>> non-generic code paths.
> >>
> >> There are two places which causes the Segmentation fault.
> >> One place is the TopdownL1.
> >>
> >> After I disable the TopdownL1 and add !counter->name as below, there a=
re
> >> no errors for the ./perf stat true.
> >>
> >> (The below is just for test purpose.)
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 7a641a67486d..8e12ed1141e0 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -1892,7 +1892,7 @@ static int add_default_attributes(void)
> >>                  * Add TopdownL1 metrics if they exist. To minimize
> >>                  * multiplexing, don't request threshold computation.
> >>                  */
> >> -               if (metricgroup__has_metric("TopdownL1")) {
> >> +               if (0 && metricgroup__has_metric("TopdownL1")) {
> >
> > So hybrid has something different that causes this. Can you provide
> > the information to solve?
>
> Here is the backtrace.
>
> #0  get_group_fd (thread=3D0, cpu_map_idx=3D<optimized out>,
> evsel=3D0x555556015af0) at util/evsel.c:1722
> #1  evsel__open_cpu (evsel=3D<optimized out>, cpus=3D<optimized out>,
> threads=3D<optimized out>,
>     start_cpu_map_idx=3D<optimized out>, end_cpu_map_idx=3D<optimized out=
>)
> at util/evsel.c:2105
> #2  0x000055555561dd9e in __run_perf_stat (run_idx=3D<optimized out>,
> argv=3D0x7fffffffe1d0, argc=3D1)
>     at builtin-stat.c:734
> #3  run_perf_stat (run_idx=3D<optimized out>, argv=3D0x7fffffffe1d0, argc=
=3D1)
> at builtin-stat.c:949
> #4  cmd_stat (argc=3D1, argv=3D0x7fffffffe1d0) at builtin-stat.c:2537
> #5  0x00005555556b56a0 in run_builtin (p=3Dp@entry=3D0x555555f84450
> <commands+336>, argc=3Dargc@entry=3D2,
>     argv=3Dargv@entry=3D0x7fffffffe1d0) at perf.c:323
> #6  0x00005555555fe2d9 in handle_internal_command (argv=3D0x7fffffffe1d0,
> argc=3D2) at perf.c:377
> #7  run_argv (argv=3D<synthetic pointer>, argcp=3D<synthetic pointer>) at
> perf.c:421
> #8  main (argc=3D2, argv=3D0x7fffffffe1d0) at perf.c:537
>
> >
> >>                         struct evlist *metric_evlist =3D evlist__new()=
;
> >>                         struct evsel *metric_evsel;
> >>
> >> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-dis=
play.c
> >> index 6b46bbb3d322..072fa56744b4 100644
> >> --- a/tools/perf/util/stat-display.c
> >> +++ b/tools/perf/util/stat-display.c
> >> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *coun=
ter)
> >>         int ret =3D 0;
> >>
> >>         if (counter->uniquified_name || counter->use_config_name ||
> >> -           !counter->pmu_name || !strncmp(counter->name, counter->pmu=
_name,
> >> +           !counter->pmu_name || !counter->name ||
> >> !strncmp(counter->name, counter->pmu_name,
> >>                                            strlen(counter->pmu_name)))
> >>                 return;
> >
> > Is this a pre-existing hybrid bug? It is a real shame hybrid shows so
> > few common code paths. In general evsel__name should be preferred over
> > directly accessing name.
>
>
> I don't think so.
>
> I haven't dig into the bug yet. But from the source code I can tell that
> the check is the same as the current 6.3-rc7.
>
> For the current 6.3-rc7, perf stat true works.
> The perf stat -M TopdownL1 --metric-no-group can work as well.
>
> But with the current perf-tools-next branch, perf stat true gives a
> Segmentation fault.
>
> The TopdownL1 doesn't work either.
>
> # ./perf stat -M TopdownL1 --metric-no-group
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> for event (topdown-retiring).
> /bin/dmesg | grep -i perf may provide additional information.

I see hybrid failing basic sanity tests both for 6.3 and in
perf-tools-next. For metrics I see:

```
$ git status
...
Your branch is up to date with 'linus/master'
...
$ git describe
v6.3-rc7-139-gb7bc77e2f2c7
$ sudo perf stat -M TopdownL1 -a sleep 1
WARNING: events in group from different hybrid PMUs!
WARNING: grouped events cpus do not match, disabling group:
 anon group { topdown-retiring, topdown-retiring,
INT_MISC.UOP_DROPPING, topdown-fe-bound, topdown-fe-bound,
CPU_CLK_UNHALTED.CORE, topdown-be-bound, topdown-be-bound,
topdown-bad-spec, topdown-bad-spec }
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (topdown-retiring).
/bin/dmesg | grep -i perf may provide additional information.
```

It seems perf on hybrid is quite broken in 6.3, but I doubt we can fix
6.3 given the late stage of the release cycle. As perf-tools-next
enables TopdownL1 metrics when no events or metric are specified and
when the metric group is present, on hybrid this will cause the
pre-existing bug to appear for the no events/metrics case. I suspect
this is the cause of the crashes you see, but I'm seeing assertion
failures and similar as I'm using a debug build.

I'm looking into fixing perf-tools-next and not 6.3. Maybe there will
be something we can cherry-pick back to fix up 6.3. It hasn't been
easy to find hardware to test on, and if the machine I'm remotely
using falls over then I have no means to test, so fingers crossed.

Thanks,
Ian

> >
> >>>
> >>>> After the test on a hybrid machine, I incline to revert the commit
> >>>> 94b1a603fca7 ("perf stat: Add TopdownL1 metric as a default if prese=
nt")
> >>>> and related patches for now.
> >>>>
> >>>> To clarify, I do not object a generic solution for the Topdown on
> >>>> different ARCHs. But the current generic solution aka TopdownL1 has =
all
> >>>> kinds of problems on most of Intel platforms. We should fix them fir=
st
> >>>> before applying to the mainline.
> >>>
> >>> No, 6.3 has many issues as do the default events/metrics:
> >>
> >> To be honest, I don't think they are real critical issues. For the fir=
st
> >> one, I think there was already a temporary fix. For the others, they a=
re
> >> there for years.
> >
> > This isn't true. The aggregation bug was raised to me by Intel and
> > stems from aggregation refactoring in per-thread mode done by
> > Namhyung.
> >
> >> However, the solution you proposed in the huge patch set
> >> (https://lore.kernel.org/lkml/20230219092848.639226-37-irogers@google.=
com/)
> >> brings many critical issues on different Intel platforms, crashes,
> >> Missing features, etc.
> >> Also, I was just told that many of our existing tools which on top of
> >> the perf tool will also be broken, because all the annotations of the
> >> kernel top-down metrics event disappeared.
> >>
> >> So we really should revert the patches. I don't think patches 39 to 51
> >> are well-tested and reviewed.
> >
> > The only issue I'm aware of is that hard coded use of the inaccurate
> > hard coded metrics now needs to switch to json metrics. This seems a
> > worthwhile update anyway, and not one that would justify breaking perf
> > stat metrics.
> >
>
> I have pointed out many issues (crash, missing features, user-visible
> changes which breaking existing tools) many times in the previous reply,
> I will not repeat the details again here.
>
> The json metrics in the current perf-tools-next branch which you want to
> switch to also has many bugs based on my recent test.
> - The TopdownL2 triggers unnecessary multiplexing on SPR.
> - Doesn't work on hybrid platforms while the current 6.3-rc7 can.
>
> The difference between the hard coded kernel metrics and the json
> metrics is that the json metrics just collect two more events, e.g., on
> Tigerlake. The core metrics is exactly the same. It's good enough for a
> initial judgement with core metrics.
>
> I don't think the switching is a good choice and necessary based on all
> of the above issues.
>
> Thanks,
> Kan
