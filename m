Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1E74F2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGKOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGKOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966E81BB;
        Tue, 11 Jul 2023 07:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B3E161515;
        Tue, 11 Jul 2023 14:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1590DC433C8;
        Tue, 11 Jul 2023 14:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689087090;
        bh=LDPCX11v0c+dpXVZwPUW42yYc1K3TuG9tgPfht12BYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYvB+2U2HPdqCadDwP3nP7YDwijECzeIGkL+aN6kAuknOwKCofyfz3p3NuMnl6tFd
         2DV6Ijp6r4WF9J5iWOpBY++sjj3Wcz7+RD6ZuCCaTeD133A2Q6LTUuIcC0bgqh1AkV
         euZTmpCYNZN2AKcGl+iLQe/UqOdcDFQmwjWJa17oab1qO4VDuV7Jhj3M2aBcVnAKnB
         MBE9lnU4TGBGa1i4ljWAkSBPU+xakc0ni9Rv0J5/EhZ2zviHu9qh9LLeSFV3ISs8nG
         FPq3CNPbR1Ci2wjS7bsxkHCvY9Ny/32HR7c4644KKT7CD9t9NLOBnbSCYZPQJ1xzVM
         KcHtuqK3uypwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78D5B40516; Tue, 11 Jul 2023 11:51:27 -0300 (-03)
Date:   Tue, 11 Jul 2023 11:51:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, ayush.jain3@amd.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf vendor events amd: Fix large metrics
Message-ID: <ZK1sb4tPizTzWq7q@kernel.org>
References: <20230706063440.54189-1-sandipan.das@amd.com>
 <CAP-5=fVdVSL4H1qWLZMiU3H2-bOJ0RkFOfq4Jxz1qw0-8EoYFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVdVSL4H1qWLZMiU3H2-bOJ0RkFOfq4Jxz1qw0-8EoYFw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 06, 2023 at 06:49:29AM -0700, Ian Rogers escreveu:
> On Wed, Jul 5, 2023 at 11:34 PM Sandipan Das <sandipan.das@amd.com> wrote:
> >
> > There are cases where a metric requires more events than the number of
> > available counters. E.g. AMD Zen, Zen 2 and Zen 3 processors have four
> > data fabric counters but the "nps1_die_to_dram" metric has eight events.
> > By default, the constituent events are placed in a group and since the
> > events cannot be scheduled at the same time, the metric is not computed.
> > The "all metrics" test also fails because of this.
> >
> > Use the NO_GROUP_EVENTS constraint for such metrics which anyway expect
> > the user to run perf with "--metric-no-group".
> >
> > E.g.
> >
> >   $ sudo perf test -v 101
> >
> > Before:
> >
> >   101: perf all metrics test                                           :
> >   --- start ---
> >   test child forked, pid 37131
> >   Testing branch_misprediction_ratio
> >   Testing all_remote_links_outbound
> >   Testing nps1_die_to_dram
> >   Metric 'nps1_die_to_dram' not printed in:
> >   Error:
> >   Invalid event (dram_channel_data_controller_4) in per-thread mode, enable system wide with '-a'.
> >   Testing macro_ops_dispatched
> >   Testing all_l2_cache_accesses
> >   Testing all_l2_cache_hits
> >   Testing all_l2_cache_misses
> >   Testing ic_fetch_miss_ratio
> >   Testing l2_cache_accesses_from_l2_hwpf
> >   Testing l2_cache_misses_from_l2_hwpf
> >   Testing op_cache_fetch_miss_ratio
> >   Testing l3_read_miss_latency
> >   Testing l1_itlb_misses
> >   test child finished with -1
> >   ---- end ----
> >   perf all metrics test: FAILED!
> >
> > After:
> >
> >   101: perf all metrics test                                           :
> >   --- start ---
> >   test child forked, pid 43766
> >   Testing branch_misprediction_ratio
> >   Testing all_remote_links_outbound
> >   Testing nps1_die_to_dram
> >   Testing macro_ops_dispatched
> >   Testing all_l2_cache_accesses
> >   Testing all_l2_cache_hits
> >   Testing all_l2_cache_misses
> >   Testing ic_fetch_miss_ratio
> >   Testing l2_cache_accesses_from_l2_hwpf
> >   Testing l2_cache_misses_from_l2_hwpf
> >   Testing op_cache_fetch_miss_ratio
> >   Testing l3_read_miss_latency
> >   Testing l1_itlb_misses
> >   test child finished with 0
> >   ---- end ----
> >   perf all metrics test: Ok
> >
> > Reported-by: Ayush Jain <ayush.jain3@amd.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Will there be a PMU driver fix so that the perf_event_open fails for
> the group? That way the weak group would work.
> 
> Thanks,
> Ian
> 
> > ---
> >
> > Previous versions can be found at:
> > v1: https://lore.kernel.org/all/20230614090710.680330-1-sandipan.das@amd.com/
> >
> > Changes in v2:
> > - As suggested by Ian, use the NO_GROUP_EVENTS constraint instead of
> >   retrying the test scenario with --metric-no-group.
> > - Change the commit message accordingly.
> >
> >  tools/perf/pmu-events/arch/x86/amdzen1/recommended.json | 3 ++-
> >  tools/perf/pmu-events/arch/x86/amdzen2/recommended.json | 3 ++-
> >  tools/perf/pmu-events/arch/x86/amdzen3/recommended.json | 3 ++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> > index bf5083c1c260..4d28177325a0 100644
> > --- a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> > +++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> > @@ -169,8 +169,9 @@
> >    },
> >    {
> >      "MetricName": "nps1_die_to_dram",
> > -    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
> > +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die)",
> >      "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
> > +    "MetricConstraint": "NO_GROUP_EVENTS",
> >      "MetricGroup": "data_fabric",
> >      "PerPkg": "1",
> >      "ScaleUnit": "6.1e-5MiB"
> > diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> > index a71694a043ba..60e19456d4c8 100644
> > --- a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> > +++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> > @@ -169,8 +169,9 @@
> >    },
> >    {
> >      "MetricName": "nps1_die_to_dram",
> > -    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
> > +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die)",
> >      "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
> > +    "MetricConstraint": "NO_GROUP_EVENTS",
> >      "MetricGroup": "data_fabric",
> >      "PerPkg": "1",
> >      "ScaleUnit": "6.1e-5MiB"
> > diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
> > index 988cf68ae825..3e9e1781812e 100644
> > --- a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
> > +++ b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
> > @@ -205,10 +205,11 @@
> >    },
> >    {
> >      "MetricName": "nps1_die_to_dram",
> > -    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
> > +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die)",
> >      "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
> >      "MetricGroup": "data_fabric",
> >      "PerPkg": "1",
> > +    "MetricConstraint": "NO_GROUP_EVENTS",
> >      "ScaleUnit": "6.1e-5MiB"
> >    }
> >  ]
> > --
> > 2.34.1
> >

-- 

- Arnaldo
