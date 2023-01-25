Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32867B942
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjAYSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjAYSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:25:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279D76A3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:25:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1958063wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s3qpODb1NvWye9Ia6ON+DIupPsUnzLWUZzhRnfX1OVU=;
        b=LUmgmC3FMDMwvcdyaFkDldZgZ0FyLD+FX4GRRnh1VhWYkWMFP2f9QjamRjmXD27iZF
         i1bDg3zIV+umg4REdz5UsBf2UVmbiI/oiUoCMnwiOHdbLxnjCCRQxG1wB3FUzJjl/w7k
         D+c4JpzjE9qeosItDhsGLpin4i2ITjcex6Wh2bMGJ5SO7QDWtYq/rghKDCZZmyloujJ0
         q8NTb1p5R29+0KBWF8CEFBlRrvcMEoI0pki4QUp7GBy74kUX5aHkFBO8wCEU1vH/eTrn
         vXK/KOMu/OFF3KB5vkn87CcjSR0NI+hS267+J2C/PsK2FL6mcd4vR4GDhTK7lH1miZ04
         /UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3qpODb1NvWye9Ia6ON+DIupPsUnzLWUZzhRnfX1OVU=;
        b=DaSCqrQR5UIDAltGkfMSPZc88pxzUPWqXzaIlJyqCDOWhFf64EdLzwGPmS0nvm+bVd
         FLplCmV7yfq5hak/3ugZGRPkLLuuwDmMLv0LGpyRzPQuvAfq3q2ZIXI3s6E9v0YsL0vY
         aKNk9HF/b+wSISGQHmcroq5KYbVVpPzRsq27D2YEKLWO/Qu5x2UJO1IcFJEWYsUnOblY
         TLf56mnXFYJIJ7WhMTeaEqJRgdduS5BHmmfsZw/4xbK3qLfBsS+r4G3/PsBgu3BsYlyP
         n3RQ4gOx/+JDy0Hz8r+LxO/+g+I3G+pk7H9oPNZZkgRrSwl9EjL9/NQKDV/KqLaGEFWy
         Gbfw==
X-Gm-Message-State: AFqh2krOt9T6w7KzyDlITOFLPVRItb2j1HrF6CpjlaMxPGlv9XdIQGXn
        S1QiprnvDIicHlipjdjYkJWZjtJcTGPsiwRtpe6NVQ==
X-Google-Smtp-Source: AMrXdXthuBlQs04R8BBsNvNlsC+0CtOyst/8zH1P63ifGn6vgJJFGYnRq0YwgtEW4SbeGfo5b8cX5WDXxO9VbSz6lyM=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr1544505wms.174.1674671135880; Wed, 25
 Jan 2023 10:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20230125081251.1244997-1-namhyung@kernel.org> <CAP-5=fVS8EGLk1mgo2fqg4pLn2MOSELJBQ9jfyaiS7bKq-D57w@mail.gmail.com>
 <CAM9d7ci44XtW19qzwmncWfUBJnBq4TaPkAgP8Nh6yAM90hiSXw@mail.gmail.com>
In-Reply-To: <CAM9d7ci44XtW19qzwmncWfUBJnBq4TaPkAgP8Nh6yAM90hiSXw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 Jan 2023 10:25:23 -0800
Message-ID: <CAP-5=fUM2_M7LQa8KArn+NoMU-Jkev8FyO67E4tZ+KmG5tk6vA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Hide invalid uncore event output for aggr mode
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Wed, Jan 25, 2023 at 9:33 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Jan 25, 2023 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The current display code for perf stat iterates given cpus and build the
> > > aggr map to collect the event data for the aggregation mode.
> > >
> > > But uncore events have their own cpu maps and it won't guarantee that
> > > it'd match to the aggr map.  For example, per-package uncore events
> > > would generate a single value for each socket.  When user asks per-core
> > > aggregation mode, the output would contain 0 values for other cores.
> > >
> > > Thus it needs to check the uncore PMU's cpumask and if it matches to the
> > > current aggregation id.
> > >
> > > Before:
> > >   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   S0-D0-C0              1               3.73 Joules power/energy-pkg/
> > >   S0-D0-C1              0      <not counted> Joules power/energy-pkg/
> > >   S0-D0-C2              0      <not counted> Joules power/energy-pkg/
> > >   S0-D0-C3              0      <not counted> Joules power/energy-pkg/
> > >
> > >          1.001404046 seconds time elapsed
> > >
> > >   Some events weren't counted. Try disabling the NMI watchdog:
> > >         echo 0 > /proc/sys/kernel/nmi_watchdog
> > >         perf stat ...
> > >         echo 1 > /proc/sys/kernel/nmi_watchdog
> > >
> > > The core 1, 2 and 3 should not be printed because the event is handled
> > > in a cpu in the core 0 only.  With this change, the output becomes like
> > > below.
> > >
> > > After:
> > >   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   S0-D0-C0              1               2.09 Joules power/energy-pkg/
> > >
> > > Fixes: b89761351089 ("perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events")
> >
> > Thanks! Tested further with mixed core and uncore events like:
> > $ perf stat -A -a -e power/energy-pkg/,cycles sleep 1
> > and the "<not counted>" are now nicely gone.
>
> Thanks for the test!
>
> >
> > > Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> > > Cc: Michael Petlan <mpetlan@redhat.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++++------
> > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index 8bd8b0142630..b9dcb13650d0 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -787,6 +787,22 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
> > >                 uniquify_event_name(counter);
> > >  }
> > >
> > > +static bool check_uncore_event_aggr(struct perf_stat_config *config,
> > > +                                   struct evsel *counter,
> > > +                                   struct aggr_cpu_id *id)
> >
> > nit: const *s
> > nit: check_uncore_event_aggr isn't particularly intention revealing,
> > perhaps something more like should_print_counter. Perhaps some
> > kernel-doc like:
>
> It sounds like a generic name.  My intention was to check the uncore events
> specifically.  But maybe we can add other conditions like global per-thread
> aggregation mode.
>
> How about this?
>
> /*
>  * When the event count is zero, check if the event should not be printed.
>  * For example, uncore events have dedicated CPUs to manage them,
>  * result for other CPUs should be zero and skipped.
>  */
> static bool should_skip_zero_counter(...)

lgtm, I like the idea one day there will be kernel-doc everywhere, but
that may just be me :-)
Thanks!

> > /**
> >  * should_print_counter() - Based on id, should the current counter's
> > value be printed.
> >  * @config: The perf stat configuration with knowledge of the aggregation mode.
> >  * @counter: The counter with its associated cpumap.
> >  * @id: The aggregation type that is being queried for printing.
> >  *
> >  * An evlist can have evsels with different cpumaps, for example, by
> > mixing core and uncore events.
> >  * When displaying one counter the other counter shouldn't be printed.
> > Check the counter's cpumap
> >  * to see whether for any CPU it is associated with the counter should
> > be printed.
> >  *
> >  * Return: true for counters that should be printed.
> >  */
> >
> > > +{
> > > +       struct perf_cpu cpu;
> > > +       int idx;
> > > +
> > > +       perf_cpu_map__for_each_cpu(cpu, idx, counter->core.own_cpus) {
> >
> > I know this is pre-existing, sorry to whine. I think we need to
> > document cpus vs own_cpus in the perf_evsel. Normally own_cpus ==
> > cpus, but in a case like this the difference matters and I have a hard
> > time understanding what "own" is supposed to be conveying, and why
> > here we don't use cpus. I also lose what the connection is with
> > perf_evlist all_cpus, does that union own_cpus or cpus? At least there
> > is a comment there :-D Honestly, why do we need to even have 2 cpu
> > maps in an evsel?
>
> Right, maybe we can use pmu->cpus instead of evsel->core.own_cpus.
> IIUC ->cpus is from the user and ->own_cpus is from the hardware.
> I agree with you that having 2 cpu maps is confusing and it's been a
> source of subtle bugs.
>
> Let me see what I can do..
>
> Thanks,
> Namhyung
>
> >
> > > +               struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
> > > +
> > > +               if (aggr_cpu_id__equal(id, &own_id))
> > > +                       return true;
> > > +       }
> > > +       return false;
> > > +}
> > > +
> > >  static void print_counter_aggrdata(struct perf_stat_config *config,
> > >                                    struct evsel *counter, int s,
> > >                                    struct outstate *os)
> > > @@ -814,12 +830,21 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> > >         ena = aggr->counts.ena;
> > >         run = aggr->counts.run;
> > >
> > > -       /*
> > > -        * Skip value 0 when enabling --per-thread globally, otherwise it will
> > > -        * have too many 0 output.
> > > -        */
> > > -       if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> > > -               return;
> > > +       if (val == 0) {
> > > +               /*
> > > +                * Skip value 0 when enabling --per-thread globally,
> > > +                * otherwise it will have too many 0 output.
> > > +                */
> > > +               if (config->aggr_mode == AGGR_THREAD && config->system_wide)
> > > +                       return;
> > > +               /*
> > > +                * Skip value 0 when it's an uncore event and the given aggr id
> > > +                * does not belong to the PMU cpumask.
> > > +                */
> > > +               if (counter->core.requires_cpu &&
> > > +                   !check_uncore_event_aggr(config, counter, &id))
> > > +                       return;
> > > +       }
> > >
> > >         if (!metric_only) {
> > >                 if (config->json_output)
> > > --
> > > 2.39.1.405.gd4c25cc71f-goog
> > >
