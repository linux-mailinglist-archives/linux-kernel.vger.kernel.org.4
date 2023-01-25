Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3267B946
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjAYS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:28:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23392659E;
        Wed, 25 Jan 2023 10:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB31615B1;
        Wed, 25 Jan 2023 18:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B501EC433EF;
        Wed, 25 Jan 2023 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674671280;
        bh=JmhFCqmWydMTxh/c48YRkP4MJHYPmVstf/yF2eb9KAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUCc6Y0WRGqJzjnMLWWIED10gJVAsHBw+0QjObgG6RtycqnNqptBbdWIsEFUM0Uqp
         aS0UW2f8MNw7Pxs/AKJ9ZZN3KTMPybvhe72fgu10pvLTYZAGK9jdKw1oI3Cab96Skm
         AVJqnAaMr6AXU6O4PeovhKQAuqt1lUlSigCo28IA6fyTDsGfnJvSmjfodw3QzQuPG6
         eW8KDqgdYWFtQSr/xsw0vg51/tris3Y+lwrCZd/1yqnmLk6ik3FjxMzLF1av4w6HU5
         w6ZaJfQfYmksnO73DvhS5a4tdbdUcemj7wQ4jWHSu+LSDD5rY4MC8h4qWcAnnmWOjn
         uoxIX3bGSfSsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E5414405BE; Wed, 25 Jan 2023 15:27:50 -0300 (-03)
Date:   Wed, 25 Jan 2023 15:27:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf stat: Hide invalid uncore event output for aggr mode
Message-ID: <Y9F0piZlJqVSNkma@kernel.org>
References: <20230125081251.1244997-1-namhyung@kernel.org>
 <CAP-5=fVS8EGLk1mgo2fqg4pLn2MOSELJBQ9jfyaiS7bKq-D57w@mail.gmail.com>
 <CAM9d7ci44XtW19qzwmncWfUBJnBq4TaPkAgP8Nh6yAM90hiSXw@mail.gmail.com>
 <CAP-5=fUM2_M7LQa8KArn+NoMU-Jkev8FyO67E4tZ+KmG5tk6vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUM2_M7LQa8KArn+NoMU-Jkev8FyO67E4tZ+KmG5tk6vA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 25, 2023 at 10:25:23AM -0800, Ian Rogers escreveu:
> On Wed, Jan 25, 2023 at 10:18 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jan 25, 2023 at 9:33 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Wed, Jan 25, 2023 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > The current display code for perf stat iterates given cpus and build the
> > > > aggr map to collect the event data for the aggregation mode.
> > > >
> > > > But uncore events have their own cpu maps and it won't guarantee that
> > > > it'd match to the aggr map.  For example, per-package uncore events
> > > > would generate a single value for each socket.  When user asks per-core
> > > > aggregation mode, the output would contain 0 values for other cores.
> > > >
> > > > Thus it needs to check the uncore PMU's cpumask and if it matches to the
> > > > current aggregation id.
> > > >
> > > > Before:
> > > >   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
> > > >
> > > >    Performance counter stats for 'system wide':
> > > >
> > > >   S0-D0-C0              1               3.73 Joules power/energy-pkg/
> > > >   S0-D0-C1              0      <not counted> Joules power/energy-pkg/
> > > >   S0-D0-C2              0      <not counted> Joules power/energy-pkg/
> > > >   S0-D0-C3              0      <not counted> Joules power/energy-pkg/
> > > >
> > > >          1.001404046 seconds time elapsed
> > > >
> > > >   Some events weren't counted. Try disabling the NMI watchdog:
> > > >         echo 0 > /proc/sys/kernel/nmi_watchdog
> > > >         perf stat ...
> > > >         echo 1 > /proc/sys/kernel/nmi_watchdog
> > > >
> > > > The core 1, 2 and 3 should not be printed because the event is handled
> > > > in a cpu in the core 0 only.  With this change, the output becomes like
> > > > below.
> > > >
> > > > After:
> > > >   $ sudo ./perf stat -a --per-core -e power/energy-pkg/ sleep 1
> > > >
> > > >    Performance counter stats for 'system wide':
> > > >
> > > >   S0-D0-C0              1               2.09 Joules power/energy-pkg/
> > > >
> > > > Fixes: b89761351089 ("perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events")
> > >
> > > Thanks! Tested further with mixed core and uncore events like:
> > > $ perf stat -A -a -e power/energy-pkg/,cycles sleep 1
> > > and the "<not counted>" are now nicely gone.
> >
> > Thanks for the test!
> >
> > >
> > > > Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> > > > Cc: Michael Petlan <mpetlan@redhat.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++++------
> > > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > > index 8bd8b0142630..b9dcb13650d0 100644
> > > > --- a/tools/perf/util/stat-display.c
> > > > +++ b/tools/perf/util/stat-display.c
> > > > @@ -787,6 +787,22 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
> > > >                 uniquify_event_name(counter);
> > > >  }
> > > >
> > > > +static bool check_uncore_event_aggr(struct perf_stat_config *config,
> > > > +                                   struct evsel *counter,
> > > > +                                   struct aggr_cpu_id *id)
> > >
> > > nit: const *s
> > > nit: check_uncore_event_aggr isn't particularly intention revealing,
> > > perhaps something more like should_print_counter. Perhaps some
> > > kernel-doc like:
> >
> > It sounds like a generic name.  My intention was to check the uncore events
> > specifically.  But maybe we can add other conditions like global per-thread
> > aggregation mode.
> >
> > How about this?
> >
> > /*
> >  * When the event count is zero, check if the event should not be printed.
> >  * For example, uncore events have dedicated CPUs to manage them,
> >  * result for other CPUs should be zero and skipped.
> >  */
> > static bool should_skip_zero_counter(...)
> 
> lgtm, I like the idea one day there will be kernel-doc everywhere, but
> that may just be me :-)

Nope, trying to add kernel doc style is preferred, albeit difficult to
enforce and keep consistent :-\

- Arnaldo

> Thanks!
> 
> > > /**
> > >  * should_print_counter() - Based on id, should the current counter's
> > > value be printed.
> > >  * @config: The perf stat configuration with knowledge of the aggregation mode.
> > >  * @counter: The counter with its associated cpumap.
> > >  * @id: The aggregation type that is being queried for printing.
> > >  *
> > >  * An evlist can have evsels with different cpumaps, for example, by
> > > mixing core and uncore events.
> > >  * When displaying one counter the other counter shouldn't be printed.
> > > Check the counter's cpumap
> > >  * to see whether for any CPU it is associated with the counter should
> > > be printed.
> > >  *
> > >  * Return: true for counters that should be printed.
> > >  */
> > >
> > > > +{
> > > > +       struct perf_cpu cpu;
> > > > +       int idx;
> > > > +
> > > > +       perf_cpu_map__for_each_cpu(cpu, idx, counter->core.own_cpus) {
> > >
> > > I know this is pre-existing, sorry to whine. I think we need to
> > > document cpus vs own_cpus in the perf_evsel. Normally own_cpus ==
> > > cpus, but in a case like this the difference matters and I have a hard
> > > time understanding what "own" is supposed to be conveying, and why
> > > here we don't use cpus. I also lose what the connection is with
> > > perf_evlist all_cpus, does that union own_cpus or cpus? At least there
> > > is a comment there :-D Honestly, why do we need to even have 2 cpu
> > > maps in an evsel?
> >
> > Right, maybe we can use pmu->cpus instead of evsel->core.own_cpus.
> > IIUC ->cpus is from the user and ->own_cpus is from the hardware.
> > I agree with you that having 2 cpu maps is confusing and it's been a
> > source of subtle bugs.
> >
> > Let me see what I can do..
> >
> > Thanks,
> > Namhyung
> >
> > >
> > > > +               struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
> > > > +
> > > > +               if (aggr_cpu_id__equal(id, &own_id))
> > > > +                       return true;
> > > > +       }
> > > > +       return false;
> > > > +}
> > > > +
> > > >  static void print_counter_aggrdata(struct perf_stat_config *config,
> > > >                                    struct evsel *counter, int s,
> > > >                                    struct outstate *os)
> > > > @@ -814,12 +830,21 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> > > >         ena = aggr->counts.ena;
> > > >         run = aggr->counts.run;
> > > >
> > > > -       /*
> > > > -        * Skip value 0 when enabling --per-thread globally, otherwise it will
> > > > -        * have too many 0 output.
> > > > -        */
> > > > -       if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> > > > -               return;
> > > > +       if (val == 0) {
> > > > +               /*
> > > > +                * Skip value 0 when enabling --per-thread globally,
> > > > +                * otherwise it will have too many 0 output.
> > > > +                */
> > > > +               if (config->aggr_mode == AGGR_THREAD && config->system_wide)
> > > > +                       return;
> > > > +               /*
> > > > +                * Skip value 0 when it's an uncore event and the given aggr id
> > > > +                * does not belong to the PMU cpumask.
> > > > +                */
> > > > +               if (counter->core.requires_cpu &&
> > > > +                   !check_uncore_event_aggr(config, counter, &id))
> > > > +                       return;
> > > > +       }
> > > >
> > > >         if (!metric_only) {
> > > >                 if (config->json_output)
> > > > --
> > > > 2.39.1.405.gd4c25cc71f-goog
> > > >

-- 

- Arnaldo
