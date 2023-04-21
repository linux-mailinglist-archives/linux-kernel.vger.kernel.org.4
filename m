Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB326EAE8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjDUP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjDUP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:59:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C71BE2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:58:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f182f35930so187645e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682092724; x=1684684724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N5YHEQ1RxQ6t0+aJXh2jcD1fRRCI0f96yxG6zaIICc=;
        b=2D1ccbmHLReNxMGth23vK1Cu9XNpFhLP1pydR7nBPZsWO1MmVrjObNh8dvJuklRfi5
         b9j3U1TaRpzJfAZTT45s/cUDHJzY025fpEoK5eo9hCVMi71EO2a06MOPtgTInqvBZqPu
         C0/X/8V8tynW7hokvCTnOC01y43rRTtG2KCXzvt7xTmEOwA3oQgUyVPCoBPhawV4bYcW
         lAv9rWPlPPWB7BdkRp7mxOJGgVgbc4cF541AEx5iKNbDE+nOS5Dh/6Pnpr27u3ASS5KM
         cdd4RalUS62sAp63jk568ySxtCrfSZDfbP2rD2aEyCrBTz6D3a28BEqN2yMFxc5WYhWS
         bb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682092724; x=1684684724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N5YHEQ1RxQ6t0+aJXh2jcD1fRRCI0f96yxG6zaIICc=;
        b=Mlu2T1iZFemhj0Za0DoTqIK1rM3MLXFURR9RyzsUzPvBobB3DNJJnlWruOrs3p1env
         HK8o+vE/BsEjtb9/B1AUHtnG7XN5TBuonMLlAokQn4gVt+9t42Ab7x1pWQPSFG3gHV9U
         rjgQTH86pUTpXxufet82f/5lYXZIl3TM0uN79XrrODuSL1LTJt0xtTfpfMON67l0IAH2
         LB+T7TqeQ0T8S2pZHWv26aax0tkeu03h2ojQujzvMyECi1UourWcbEaeDEv4nNKFeRSH
         /nER28BHViBHD0W1u1Uf9Ujw25xUqqTV5F4IVBo5bo16SmqERMNHtmFjGU/YBSfa/hGS
         AX2w==
X-Gm-Message-State: AAQBX9fEw6JygjRYTp741eTJ5V1NeM66KXirykdaoTizylv4EdJI6GSZ
        L3QDhNsl/G7DvzGljrOTctIIB7PRNlumXKA7KqZTMg==
X-Google-Smtp-Source: AKy350YoSddf8HzdPcpJuMrQNcocPvOdwaD1CcugAQN+grxkIY/8nSgZrsNV33k7ofzdcQ053CQD0KMo1B0QIaFAfiI=
X-Received: by 2002:a05:600c:5399:b0:3f1:70d1:21a6 with SMTP id
 hg25-20020a05600c539900b003f170d121a6mr227616wmb.0.1682092724495; Fri, 21 Apr
 2023 08:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230414051922.3625666-1-irogers@google.com> <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
 <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com> <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
 <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com> <CAP-5=fVVFjKgUGV8zVurd99BOhASQ9mMaZqOyw13PYLhZWpsOA@mail.gmail.com>
 <CAP-5=fW_JwabjEUqSLaJn+tuHXLoyRWqJVVCh_z1dhXJ6On=MQ@mail.gmail.com>
 <84b19053-2e9f-5251-6816-26d2475894c0@linux.intel.com> <CAP-5=fWJKmo4eLKe9+=3pKGe7g+xfA+YxOz7AOgqLfcRNzNaLw@mail.gmail.com>
 <201a2ad6-3fb4-4b2a-d8a4-34d924e680c3@linux.intel.com> <CAP-5=fVWN5=URg0Og7KW7f7L4LSw6D8ghOKjP7La=0c+MkXFCg@mail.gmail.com>
 <2b8768bf-de24-946f-62da-6ed171a5c324@linux.intel.com> <CAP-5=fU9WeBga_tQKi6QKX1-t=C1w5CoPc8Rn9myR=1CxeQuMg@mail.gmail.com>
 <46508ba1-6bd5-a28e-5ae8-bc69a679b2c5@linux.intel.com> <CAP-5=fWeBN0gzCzk3_gh=bd_H+q5B+1KqofG5q-JGTaFk7akog@mail.gmail.com>
 <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com>
In-Reply-To: <7836c3c0-75bb-7c66-d6b1-ee6ff1201117@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 21 Apr 2023 08:58:19 -0700
Message-ID: <CAP-5=fXMmj1mNuGNbocmjb1ytqvgAkdjUR2tYgH0Lzvwp+_L4A@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "Yasin, Ahmad" <ahmad.yasin@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Wang, Weilin" <weilin.wang@intel.com>,
        Edward <edward.baker@intel.com>,
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

On Fri, Apr 21, 2023 at 6:32=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-04-20 8:19 p.m., Ian Rogers wrote:
> >>>>                         struct evlist *metric_evlist =3D evlist__new=
();
> >>>>                         struct evsel *metric_evsel;
> >>>>
> >>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-d=
isplay.c
> >>>> index 6b46bbb3d322..072fa56744b4 100644
> >>>> --- a/tools/perf/util/stat-display.c
> >>>> +++ b/tools/perf/util/stat-display.c
> >>>> @@ -747,7 +747,7 @@ static void uniquify_event_name(struct evsel *co=
unter)
> >>>>         int ret =3D 0;
> >>>>
> >>>>         if (counter->uniquified_name || counter->use_config_name ||
> >>>> -           !counter->pmu_name || !strncmp(counter->name, counter->p=
mu_name,
> >>>> +           !counter->pmu_name || !counter->name ||
> >>>> !strncmp(counter->name, counter->pmu_name,
> >>>>                                            strlen(counter->pmu_name)=
))
> >>>>                 return;
> >>>
> >>> Is this a pre-existing hybrid bug? It is a real shame hybrid shows so
> >>> few common code paths. In general evsel__name should be preferred ove=
r
> >>> directly accessing name.
> >>
> >>
> >> I don't think so.
> >>
> >> I haven't dig into the bug yet. But from the source code I can tell th=
at
> >> the check is the same as the current 6.3-rc7.
> >>
> >> For the current 6.3-rc7, perf stat true works.
> >> The perf stat -M TopdownL1 --metric-no-group can work as well.
> >>
> >> But with the current perf-tools-next branch, perf stat true gives a
> >> Segmentation fault.
> >>
> >> The TopdownL1 doesn't work either.
> >>
> >> # ./perf stat -M TopdownL1 --metric-no-group
> >> Error:
> >> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> >> for event (topdown-retiring).
> >> /bin/dmesg | grep -i perf may provide additional information.
> >
> > I see hybrid failing basic sanity tests both for 6.3 and in
> > perf-tools-next. For metrics I see:
> >
> > ```
> > $ git status
> > ...
> > Your branch is up to date with 'linus/master'
> > ...
> > $ git describe
> > v6.3-rc7-139-gb7bc77e2f2c7
> > $ sudo perf stat -M TopdownL1 -a sleep 1
>
> Try the --metric-no-group.

You can't not group topdown events, needed for the performance core,
on Linux 6.3. The logic to make that not necessary was added to
perf-tools-next and you are currently looking to revert the changes in
perf-tools-next.
https://lore.kernel.org/all/20230312021543.3060328-1-irogers@google.com/

Thanks,
Ian

>
>
> > WARNING: events in group from different hybrid PMUs!
> > WARNING: grouped events cpus do not match, disabling group:
> >  anon group { topdown-retiring, topdown-retiring,
> > INT_MISC.UOP_DROPPING, topdown-fe-bound, topdown-fe-bound,
> > CPU_CLK_UNHALTED.CORE, topdown-be-bound, topdown-be-bound,
> > topdown-bad-spec, topdown-bad-spec }
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> > for event (topdown-retiring).
> > /bin/dmesg | grep -i perf may provide additional information.
> > ```
> >
> > It seems perf on hybrid is quite broken in 6.3, but I doubt we can fix
> > 6.3 given the late stage of the release cycle. As perf-tools-next
> > enables TopdownL1 metrics when no events or metric are specified and
> > when the metric group is present, on hybrid this will cause the
> > pre-existing bug to appear for the no events/metrics case. I suspect
> > this is the cause of the crashes you see, but I'm seeing assertion
> > failures and similar as I'm using a debug build.
> >
> > I'm looking into fixing perf-tools-next and not 6.3. Maybe there will
> > be something we can cherry-pick back to fix up 6.3. It hasn't been
> > easy to find hardware to test on, and if the machine I'm remotely
> > using falls over then I have no means to test, so fingers crossed.
> >
>
> OK. So the json metric thing is buggy on both 6.3 and perf-tools-next. I
> think it is even worse in the perf-tools-next.
> Besides the bugs, the json metric also changes the output layout of perf
> stat default. The tools, which are on top of perf, are all impacted.
>
> The question is why we are in such a rush to move the default of perf
> stat from reliable kernel metric to json metric?
>
> Can we take a step back? Create a perf/json_metric or whatever branch,
> fix all the issues thoroughly, and then merge to the mainline.
>
> I think the default of perf stat is frequently used by not only the
> newbees but also the veterans. That could have a big user-visible impact.
>
> The 6.4 merge window is approaching. Can we at least revert the patches
> for 6.4?
>
> Arnaldo, what do you think?
>
> Thanks,
> Kan
