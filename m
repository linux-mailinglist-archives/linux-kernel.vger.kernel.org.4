Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CE687309
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjBBBb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBBBbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:31:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829857642C;
        Wed,  1 Feb 2023 17:31:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 207EF619C6;
        Thu,  2 Feb 2023 01:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26975C433D2;
        Thu,  2 Feb 2023 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675301463;
        bh=oniJMuB4yn490Q9EidMEJVoZxaBryjDo6MkhyhExUOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IynEMLoFAInKXkRhJsTclye0kiyVyqSziqRn7QugRzCLhDLJx4q8Bm9AJjIcchJNs
         yPE5xX+fqmP7awqossoCNmIDUcZ1gYcUzS+FKgnyBAlyAKiRS7SJRmKkmMagZOUA25
         b15DqzN0cSYf8EjvCcYSFMg1gUGVuv67SskS6VqIsoCRWadaVjZm94L4ZiZ2tfzi0O
         IGrXleOjV1XPcHO1EoCfYPCT8tyH6Lxaplh9LCIAdk9MyyBp7nnNUsOk7jn9vRbsRv
         CR+yfqA1zhJ4xf3ctklpdNnvzoqOZpQRWn9ykseLus45YkZGvy1iuQPLgP6kcQp1sa
         XWhrFiZs0dEHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B77C4405BE; Wed,  1 Feb 2023 22:31:00 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:31:00 -0300
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
Subject: Re: [PATCH v2] perf stat: Hide invalid uncore event output for aggr
 mode
Message-ID: <Y9sSVPLuK1OO+wR/@kernel.org>
References: <20230125192431.2929677-1-namhyung@kernel.org>
 <CAP-5=fXOhOCq3TS6RFUTsEZBXnzG74T=NiLvQCf+t0QHctSrZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXOhOCq3TS6RFUTsEZBXnzG74T=NiLvQCf+t0QHctSrZQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 25, 2023 at 04:10:39PM -0800, Ian Rogers escreveu:
> On Wed, Jan 25, 2023 at 11:24 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The current display code for perf stat iterates given cpus and build the
> > aggr map to collect the event data for the aggregation mode.
> >
> > But uncore events have their own cpu maps and it won't guarantee that
> > it'd match to the aggr map.  For example, per-package uncore events
> > would generate a single value for each socket.  When user asks per-core
> > aggregation mode, the output would contain 0 values for other cores.

Thanks, applied.

- Arnaldo

 >
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
> > Cc: Athira Jajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Tested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> > ---
> > * rename to 'should_skip_zero_counter'
> > * check pmu->cpus instead
> > * add kernel-doc style comments
> > * add Ian's Tested-by tag
> >
> >  tools/perf/util/stat-display.c | 51 ++++++++++++++++++++++++++++++----
> >  1 file changed, 46 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 8bd8b0142630..1b5cb20efd23 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -787,6 +787,51 @@ static void uniquify_counter(struct perf_stat_config *config, struct evsel *coun
> >                 uniquify_event_name(counter);
> >  }
> >
> > +/**
> > + * should_skip_zero_count() - Check if the event should print 0 values.
> > + * @config: The perf stat configuration (including aggregation mode).
> > + * @counter: The evsel with its associated cpumap.
> > + * @id: The aggregation id that is being queried.
> > + *
> > + * Due to mismatch between the event cpumap or thread-map and the
> > + * aggregation mode, sometimes it'd iterate the counter with the map
> > + * which does not contain any values.
> > + *
> > + * For example, uncore events have dedicated CPUs to manage them,
> > + * result for other CPUs should be zero and skipped.
> > + *
> > + * Return: %true if the value should NOT be printed, %false if the value
> > + * needs to be printed like "<not counted>" or "<not supported>".
> > + */
> > +static bool should_skip_zero_counter(struct perf_stat_config *config,
> > +                                    struct evsel *counter,
> > +                                    const struct aggr_cpu_id *id)
> > +{
> > +       struct perf_cpu cpu;
> > +       int idx;
> > +
> > +       /*
> > +        * Skip value 0 when enabling --per-thread globally,
> > +        * otherwise it will have too many 0 output.
> > +        */
> > +       if (config->aggr_mode == AGGR_THREAD && config->system_wide)
> > +               return true;
> > +       /*
> > +        * Skip value 0 when it's an uncore event and the given aggr id
> > +        * does not belong to the PMU cpumask.
> > +        */
> > +       if (!counter->pmu || !counter->pmu->is_uncore)
> > +               return false;
> > +
> > +       perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
> > +               struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
> > +
> > +               if (aggr_cpu_id__equal(id, &own_id))
> > +                       return false;
> > +       }
> > +       return true;
> > +}
> > +
> >  static void print_counter_aggrdata(struct perf_stat_config *config,
> >                                    struct evsel *counter, int s,
> >                                    struct outstate *os)
> > @@ -814,11 +859,7 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
> >         ena = aggr->counts.ena;
> >         run = aggr->counts.run;
> >
> > -       /*
> > -        * Skip value 0 when enabling --per-thread globally, otherwise it will
> > -        * have too many 0 output.
> > -        */
> > -       if (val == 0 && config->aggr_mode == AGGR_THREAD && config->system_wide)
> > +       if (val == 0 && should_skip_zero_counter(config, counter, &id))
> >                 return;
> >
> >         if (!metric_only) {
> > --
> > 2.39.1.456.gfc5497dd1b-goog
> >

-- 

- Arnaldo
