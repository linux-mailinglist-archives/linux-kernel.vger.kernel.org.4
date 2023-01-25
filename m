Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9D67B928
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjAYSTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjAYSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:19:06 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EE959B6F;
        Wed, 25 Jan 2023 10:18:51 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id p189so8871582iod.0;
        Wed, 25 Jan 2023 10:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arVXHvoWv1i9v1WFXi+fm/Z8u6WiX0FXmePoEu19OGE=;
        b=CGYQO0Aq08iTilOIXbUGDVWeBLAYgVjONmGKoOZE+pc72+lE+Zn4O6YDri5ppi+F4N
         DsJVhjyXY1hxNDPZ5GTl4VC0/8LQSr4MApYNW0ldFcV+j+gdPqGht3C6lMr1NQzw0Pvv
         i6nS+uDIoOa8LHXFvupuATutQ9OU5hkUZl46m60qYrK82aMh9eZX9HII2Yo9v5ejJ0p7
         rSjxfii9+s5PjW1E6f7/rRN+myfnqtjnMwfqrtE+2Hu/WvbFmkLrycXpPYdh4Tf/KYvx
         oBvo/vAFrt9vzLGri1rkxXP7URv+P7671qc/4JzHIQYK41yuXzPbQOmoTjjy3hCw3ZPz
         0a4Q==
X-Gm-Message-State: AFqh2kqFZbNMD9A4bQZ8QfHikRSTB+92Xbs5lz99YsQ6BSRHAESCUBMv
        RyQserBjFSgCMtDmV91JceDB+jYjy3faLhTgmIg=
X-Google-Smtp-Source: AMrXdXt0oiisA9lSeFz7/opG1+rG8psAYI28gfG0k9sACpqdqGDOsKj+8c9CteBrsiiMIhHjANMAE2EB9iEeFxH3VV4=
X-Received: by 2002:a05:6638:37a6:b0:3a5:93d:f262 with SMTP id
 w38-20020a05663837a600b003a5093df262mr2552377jal.230.1674670730416; Wed, 25
 Jan 2023 10:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20230125081251.1244997-1-namhyung@kernel.org> <CAP-5=fVS8EGLk1mgo2fqg4pLn2MOSELJBQ9jfyaiS7bKq-D57w@mail.gmail.com>
In-Reply-To: <CAP-5=fVS8EGLk1mgo2fqg4pLn2MOSELJBQ9jfyaiS7bKq-D57w@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Jan 2023 10:18:38 -0800
Message-ID: <CAM9d7ci44XtW19qzwmncWfUBJnBq4TaPkAgP8Nh6yAM90hiSXw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Hide invalid uncore event output for aggr mode
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Jan 25, 2023 at 9:33 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jan 25, 2023 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The current display code for perf stat iterates given cpus and build the
> > aggr map to collect the event data for the aggregation mode.
> >
> > But uncore events have their own cpu maps and it won't guarantee that
> > it'd match to the aggr map.  For example, per-package uncore events
> > would generate a single value for each socket.  When user asks per-core
> > aggregation mode, the output would contain 0 values for other cores.
> >
> > Thus it needs to check the uncore PMU's cpumask and if it matches to the
> > current aggregation id.
> >
> > Before:
> >   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0-D0-C0              1               3.73 Joules power/energy-pkg/
> >   S0-D0-C1              0      <not counted> Joules power/energy-pkg/
> >   S0-D0-C2              0      <not counted> Joules power/energy-pkg/
> >   S0-D0-C3              0      <not counted> Joules power/energy-pkg/
> >
> >          1.001404046 seconds time elapsed
> >
> >   Some events weren't counted. Try disabling the NMI watchdog:
> >         echo 0 > /proc/sys/kernel/nmi_watchdog
> >         perf stat ...
> >         echo 1 > /proc/sys/kernel/nmi_watchdog
> >
> > The core 1, 2 and 3 should not be printed because the event is handled
> > in a cpu in the core 0 only.  With this change, the output becomes like
> > below.
> >
> > After:
> >   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0-D0-C0              1               2.09 Joules power/energy-pkg/
> >
> > Fixes: b89761351089 ("perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events")
>
> Thanks! Tested further with mixed core and uncore events like:
> $ perf stat -A -a -e power/energy-pkg/,cycles sleep 1
> and the "<not counted>" are now nicely gone.

Thanks for the test!

>
> > Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 8bd8b0142630..b9dcb13650d0 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -787,6 +787,22 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
> >                 uniquify_event_name(counter);
> >  }
> >
> > +static bool check_uncore_event_aggr(struct perf_stat_config *config,
> > +                                   struct evsel *counter,
> > +                                   struct aggr_cpu_id *id)
>
> nit: const *s
> nit: check_uncore_event_aggr isn't particularly intention revealing,
> perhaps something more like should_print_counter. Perhaps some
> kernel-doc like:

It sounds like a generic name.  My intention was to check the uncore events
specifically.  But maybe we can add other conditions like global per-thread
aggregation mode.

How about this?

/*
 * When the event count is zero, check if the event should not be printed.
 * For example, uncore events have dedicated CPUs to manage them,
 * result for other CPUs should be zero and skipped.
 */
static bool should_skip_zero_counter(...)


> /**
>  * should_print_counter() - Based on id, should the current counter's
> value be printed.
>  * @config: The perf stat configuration with knowledge of the aggregation mode.
>  * @counter: The counter with its associated cpumap.
>  * @id: The aggregation type that is being queried for printing.
>  *
>  * An evlist can have evsels with different cpumaps, for example, by
> mixing core and uncore events.
>  * When displaying one counter the other counter shouldn't be printed.
> Check the counter's cpumap
>  * to see whether for any CPU it is associated with the counter should
> be printed.
>  *
>  * Return: true for counters that should be printed.
>  */
>
> > +{
> > +       struct perf_cpu cpu;
> > +       int idx;
> > +
> > +       perf_cpu_map__for_each_cpu(cpu, idx, counter->core.own_cpus) {
>
> I know this is pre-existing, sorry to whine. I think we need to
> document cpus vs own_cpus in the perf_evsel. Normally own_cpus ==
> cpus, but in a case like this the difference matters and I have a hard
> time understanding what "own" is supposed to be conveying, and why
> here we don't use cpus. I also lose what the connection is with
> perf_evlist all_cpus, does that union own_cpus or cpus? At least there
> is a comment there :-D Honestly, why do we need to even have 2 cpu
> maps in an evsel?

Right, maybe we can use pmu->cpus instead of evsel->core.own_cpus.
IIUC ->cpus is from the user and ->own_cpus is from the hardware.
I agree with you that having 2 cpu maps is confusing and it's been a
source of subtle bugs.

Let me see what I can do..

Thanks,
Namhyung

>
> > +               struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
> > +
> > +               if (aggr_cpu_id__equal(id, &own_id))
> > +                       return true;
> > +       }
> > +       return false;
> > +}
> > +
> >  static void print_counter_aggrdata(struct perf_stat_config *config,
> >                                    struct evsel *counter, int s,
> >                                    struct outstate *os)
> > @@ -814,12 +830,21 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> >         ena = aggr->counts.ena;
> >         run = aggr->counts.run;
> >
> > -       /*
> > -        * Skip value 0 when enabling --per-thread globally, otherwise it will
> > -        * have too many 0 output.
> > -        */
> > -       if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> > -               return;
> > +       if (val == 0) {
> > +               /*
> > +                * Skip value 0 when enabling --per-thread globally,
> > +                * otherwise it will have too many 0 output.
> > +                */
> > +               if (config->aggr_mode == AGGR_THREAD && config->system_wide)
> > +                       return;
> > +               /*
> > +                * Skip value 0 when it's an uncore event and the given aggr id
> > +                * does not belong to the PMU cpumask.
> > +                */
> > +               if (counter->core.requires_cpu &&
> > +                   !check_uncore_event_aggr(config, counter, &id))
> > +                       return;
> > +       }
> >
> >         if (!metric_only) {
> >                 if (config->json_output)
> > --
> > 2.39.1.405.gd4c25cc71f-goog
> >
