Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0F731A88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjFONym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344469AbjFONyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:54:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6A1BDB;
        Thu, 15 Jun 2023 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837278; x=1718373278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=chyFu3dvZY1S4ouv8eAOP3WF6rIvUT6kjXF1tagP5gk=;
  b=mfckRM4qD6hL0apvESazVGDI9pkwybqaUXcJbXNB6lPqFMqPt1457qGT
   UQcCff6pQ2yiZzMJ9GtX8Qi2WPEcSgHzJAYUK0zjCqw/bkCP9qAHg5uis
   JrmBM8VlvM9BmiSOvoIrWObhkGUsX+OdAtjQKzLmJrvFgUvt6v+pKoZeR
   UvC584BKJNn/ZJJiaBWa+a2vXTw6hC4eh67grqd5K9SAT4GhVWm3Dm4mu
   PuMZfC5urNAMyAMv+kVMKdczBJ7e64k9gb7naUD5hZK5E2skvFFGo/Mp5
   NHgvP1x9wtP52potoU63QcT8ZZaaXAggjz27ah+S7N+oMB7uOe0SM6mjN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356411378"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356411378"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782527040"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="782527040"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 06:54:36 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/8] New metricgroup output in perf stat default mode
Date:   Thu, 15 Jun 2023 06:53:07 -0700
Message-Id: <20230615135315.3662428-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Fixes memory leak (Ian)
  (Ian, I cannot reproduce the memory leak on all my machines. Please
   check whether the fix works on your side. Thanks.)
- Add Reviewed-by tags for several patches.

Changes since V1:
- Remove EVSEL_EVENT_MASK and use the __evsel__match which is suggested
  by Ian.
- Support TopdownL1 on both e-core and p-core of ADL in the default
  mode. (Ian)
- Have separate patches for the modifications of metricgroup and output.
  (Ian)
- Does 2nd sort for the Default metricgroup. Remove the logic of
  changing the associated metric event. (Ian)
- Move all the metric related code to stat-shadow (Ian)
- Move the commong functions between stat+csv_output and stat+std_output
  to the lib directory (Ian)

In the default mode, the current output of the metricgroup include both
events and metrics, which is not necessary and makes the output hard to
read. Also, different ARCHs (even different generations of the ARCH) may
have a different output format because of the different events in a
metrics.

The patch proposes a new output format which only outputting the value
of each metric and the metricgroup name. It can brings a clean and
consistent output format among ARCHs and generations.

The first patche is a bug fix for the current code.

The patches 2-5 introduce the new metricgroup output.

The patches 6-8 improve the tests to cover the default mode.

Here are some examples for the new output.

STD output:

On SPR

perf stat -a sleep 1

 Performance counter stats for 'system wide':

        226,054.13 msec cpu-clock                        #  224.588 CPUs utilized
               932      context-switches                 #    4.123 /sec
               224      cpu-migrations                   #    0.991 /sec
                76      page-faults                      #    0.336 /sec
        45,940,682      cycles                           #    0.000 GHz
        36,676,047      instructions                     #    0.80  insn per cycle
         7,044,516      branches                         #   31.163 K/sec
            62,169      branch-misses                    #    0.88% of all branches
                        TopdownL1                 #     68.7 %  tma_backend_bound
                                                  #      3.1 %  tma_bad_speculation
                                                  #     13.0 %  tma_frontend_bound
                                                  #     15.2 %  tma_retiring
                        TopdownL2                 #      2.7 %  tma_branch_mispredicts
                                                  #     19.6 %  tma_core_bound
                                                  #      4.8 %  tma_fetch_bandwidth
                                                  #      8.3 %  tma_fetch_latency
                                                  #      2.9 %  tma_heavy_operations
                                                  #     12.3 %  tma_light_operations
                                                  #      0.4 %  tma_machine_clears
                                                  #     49.1 %  tma_memory_bound

       1.006529767 seconds time elapsed

perf stat -a sleep 1

 Performance counter stats for 'system wide':

         32,127.99 msec cpu-clock                        #   31.992 CPUs utilized
               240      context-switches                 #    7.470 /sec
                32      cpu-migrations                   #    0.996 /sec
                74      page-faults                      #    2.303 /sec
         6,313,960      cpu_core/cycles/                 #    0.000 GHz
       257,711,907      cpu_atom/cycles/                 #    0.008 GHz                         (54.18%)
         4,477,162      cpu_core/instructions/           #    0.71  insn per cycle
        37,721,481      cpu_atom/instructions/           #    5.97  insn per cycle              (63.33%)
           809,747      cpu_core/branches/               #   25.204 K/sec
         6,621,226      cpu_atom/branches/               #  206.089 K/sec                       (63.32%)
            39,667      cpu_core/branch-misses/          #    4.90% of all branches
         1,032,146      cpu_atom/branch-misses/          #  127.47% of all branches             (63.33%)
             TopdownL1 (cpu_core)                 #      nan %  tma_backend_bound
                                                  #      0.0 %  tma_bad_speculation
                                                  #      nan %  tma_frontend_bound
                                                  #      nan %  tma_retiring
             TopdownL1 (cpu_atom)                 #     13.6 %  tma_bad_speculation      (63.36%)
                                                  #     41.1 %  tma_frontend_bound       (63.54%)
                                                  #     39.2 %  tma_backend_bound
                                                  #     39.2 %  tma_backend_bound_aux    (63.93%)
                                                  #      5.4 %  tma_retiring             (64.15%)

       1.004244114 seconds time elapsed

JSON output

on SPR

perf stat --json -a sleep 1
{"counter-value" : "225904.823297", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 225904323425, "pcnt-running" : 100.00, "metric-value" : "224.456872", "metric-unit" : "CPUs utilized"}
{"counter-value" : "986.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 225904108985, "pcnt-running" : 100.00, "metric-value" : "4.364670", "metric-unit" : "/sec"}
{"counter-value" : "224.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 225904016141, "pcnt-running" : 100.00, "metric-value" : "0.991568", "metric-unit" : "/sec"}
{"counter-value" : "76.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 225903913270, "pcnt-running" : 100.00, "metric-value" : "0.336425", "metric-unit" : "/sec"}
{"counter-value" : "48433482.000000", "unit" : "", "event" : "cycles", "event-runtime" : 225903792732, "pcnt-running" : 100.00, "metric-value" : "0.000214", "metric-unit" : "GHz"}
{"counter-value" : "38620409.000000", "unit" : "", "event" : "instructions", "event-runtime" : 225903657830, "pcnt-running" : 100.00, "metric-value" : "0.797391", "metric-unit" : "insn per cycle"}
{"counter-value" : "7369473.000000", "unit" : "", "event" : "branches", "event-runtime" : 225903464328, "pcnt-running" : 100.00, "metric-value" : "32.622026", "metric-unit" : "K/sec"}
{"counter-value" : "54747.000000", "unit" : "", "event" : "branch-misses", "event-runtime" : 225903234523, "pcnt-running" : 100.00, "metric-value" : "0.742889", "metric-unit" : "of all branches"}
{"event-runtime" : 225902840555, "pcnt-running" : 100.00, "metricgroup" : "TopdownL1"}
{"metric-value" : "69.950631", "metric-unit" : "%  tma_backend_bound"}
{"metric-value" : "2.771783", "metric-unit" : "%  tma_bad_speculation"}
{"metric-value" : "12.026074", "metric-unit" : "%  tma_frontend_bound"}
{"metric-value" : "15.251513", "metric-unit" : "%  tma_retiring"}
{"event-runtime" : 225902840555, "pcnt-running" : 100.00, "metricgroup" : "TopdownL2"}
{"metric-value" : "2.351757", "metric-unit" : "%  tma_branch_mispredicts"}
{"metric-value" : "19.729771", "metric-unit" : "%  tma_core_bound"}
{"metric-value" : "4.555207", "metric-unit" : "%  tma_fetch_bandwidth"}
{"metric-value" : "7.470867", "metric-unit" : "%  tma_fetch_latency"}
{"metric-value" : "2.938808", "metric-unit" : "%  tma_heavy_operations"}
{"metric-value" : "12.312705", "metric-unit" : "%  tma_light_operations"}
{"metric-value" : "0.420026", "metric-unit" : "%  tma_machine_clears"}
{"metric-value" : "50.220860", "metric-unit" : "%  tma_memory_bound"}

On hybrid

perf stat --json -a sleep 1
{"counter-value" : "32131.530625", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 32131536951, "pcnt-running" : 100.00, "metric-value" : "31.992642", "metric-unit" : "CPUs utilized"}
{"counter-value" : "328.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 32131525778, "pcnt-running" : 100.00, "metric-value" : "10.208042", "metric-unit" : "/sec"}
{"counter-value" : "32.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 32131515104, "pcnt-running" : 100.00, "metric-value" : "0.995906", "metric-unit" : "/sec"}
{"counter-value" : "353.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 32131501396, "pcnt-running" : 100.00, "metric-value" : "10.986094", "metric-unit" : "/sec"}
{"counter-value" : "18685492.000000", "unit" : "", "event" : "cpu_core/cycles/", "event-runtime" : 16061585292, "pcnt-running" : 100.00, "metric-value" : "0.000582", "metric-unit" : "GHz"}
{"counter-value" : "255620352.000000", "unit" : "", "event" : "cpu_atom/cycles/", "event-runtime" : 8690268422, "pcnt-running" : 54.00, "metric-value" : "0.007955", "metric-unit" : "GHz"}
{"counter-value" : "15489913.000000", "unit" : "", "event" : "cpu_core/instructions/", "event-runtime" : 16061582200, "pcnt-running" : 100.00, "metric-value" : "0.828981", "metric-unit" : "insn per cycle"}
{"counter-value" : "38790161.000000", "unit" : "", "event" : "cpu_atom/instructions/", "event-runtime" : 10163133324, "pcnt-running" : 63.00, "metric-value" : "2.075951", "metric-unit" : "insn per cycle"}
{"counter-value" : "2908031.000000", "unit" : "", "event" : "cpu_core/branches/", "event-runtime" : 16061563416, "pcnt-running" : 100.00, "metric-value" : "90.503967", "metric-unit" : "K/sec"}
{"counter-value" : "6814948.000000", "unit" : "", "event" : "cpu_atom/branches/", "event-runtime" : 10161711336, "pcnt-running" : 63.00, "metric-value" : "212.095343", "metric-unit" : "K/sec"}
{"counter-value" : "97638.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 16061535261, "pcnt-running" : 100.00, "metric-value" : "3.357530", "metric-unit" : "of all branches"}
{"counter-value" : "1017066.000000", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 10159971797, "pcnt-running" : 63.00, "metric-value" : "34.974386", "metric-unit" : "of all branches"}
{"event-runtime" : 16061513607, "pcnt-running" : 100.00, "metricgroup" : "TopdownL1 (cpu_core)"}
{"metric-value" : "nan", "metric-unit" : "%  tma_backend_bound"}
{"metric-value" : "0.000000", "metric-unit" : "%  tma_bad_speculation"}
{"metric-value" : "nan", "metric-unit" : "%  tma_frontend_bound"}
{"metric-value" : "nan", "metric-unit" : "%  tma_retiring"}
{"event-runtime" : 10157398501, "pcnt-running" : 63.00, "metricgroup" : "TopdownL1 (cpu_atom)"}
{"metric-value" : "13.719821", "metric-unit" : "%  tma_bad_speculation"}
{"event-runtime" : 10178698656, "pcnt-running" : 63.00, "metric-value" : "41.016738", "metric-unit" : "%  tma_frontend_bound"}
{"event-runtime" : 10240582902, "pcnt-running" : 63.00, "metric-value" : "39.327764", "metric-unit" : "%  tma_backend_bound"}
{"metric-value" : "39.327764", "metric-unit" : "%  tma_backend_bound_aux"}
{"event-runtime" : 10284284920, "pcnt-running" : 64.00, "metric-value" : "5.374638", "metric-unit" : "%  tma_retiring"}

CSV output

On SPR

perf stat -x, -a sleep 1
225851.20,msec,cpu-clock,225850700108,100.00,224.431,CPUs utilized
976,,context-switches,225850504803,100.00,4.321,/sec
224,,cpu-migrations,225850410336,100.00,0.992,/sec
76,,page-faults,225850304155,100.00,0.337,/sec
52288305,,cycles,225850188531,100.00,0.000,GHz
37977214,,instructions,225850071251,100.00,0.73,insn per cycle
7299859,,branches,225849890722,100.00,32.322,K/sec
51102,,branch-misses,225849672536,100.00,0.70,of all branches
,225849327050,100.00,,,,TopdownL1
,,,,,70.1,%  tma_backend_bound
,,,,,2.7,%  tma_bad_speculation
,,,,,12.5,%  tma_frontend_bound
,,,,,14.6,%  tma_retiring
,225849327050,100.00,,,,TopdownL2
,,,,,2.3,%  tma_branch_mispredicts
,,,,,19.6,%  tma_core_bound
,,,,,4.6,%  tma_fetch_bandwidth
,,,,,7.9,%  tma_fetch_latency
,,,,,2.9,%  tma_heavy_operations
,,,,,11.7,%  tma_light_operations
,,,,,0.5,%  tma_machine_clears
,,,,,50.5,%  tma_memory_bound

On Hybrid

perf stat -x, -a sleep 1
32139.34,msec,cpu-clock,32139351409,100.00,32.001,CPUs utilized
225,,context-switches,32139342672,100.00,7.001,/sec
32,,cpu-migrations,32139337772,100.00,0.996,/sec
72,,page-faults,32139328384,100.00,2.240,/sec
6766433,,cpu_core/cycles/,16067551558,100.00,0.000,GHz
256500230,,cpu_atom/cycles/,8695757391,54.00,0.008,GHz
4688595,,cpu_core/instructions/,16067558976,100.00,0.69,insn per cycle
37487490,,cpu_atom/instructions/,10165193856,63.00,5.54,insn per cycle
845211,,cpu_core/branches/,16067540225,100.00,26.298,K/sec
6571193,,cpu_atom/branches/,10155940853,63.00,204.459,K/sec
41359,,cpu_core/branch-misses/,16067516493,100.00,4.89,of all branches
1020231,,cpu_atom/branch-misses/,10159363620,63.00,120.71,of all branches
,16067494476,100.00,,,,TopdownL1 (cpu_core)
,,,,,,%  tma_backend_bound
,,,,,0.0,%  tma_bad_speculation
,,,,,,%  tma_frontend_bound
,,,,,,%  tma_retiring
,10160989992,63.00,,,,TopdownL1 (cpu_atom)
,,,,,13.8,%  tma_bad_speculation
,10188319019,63.00,,,41.3,%  tma_frontend_bound
,10258326591,63.00,,,38.6,%  tma_backend_bound
,,,,,38.6,%  tma_backend_bound_aux
,10282689488,64.00,,,5.4,%  tma_retiring

Kan Liang (8):
  perf evsel: Fix the annotation for hardware events on hybrid
  perf metric: JSON flag to default metric group
  perf stat,jevents: Introduce Default tags for the default mode
  perf metrics: Sort the Default metricgroup
  perf stat: New metricgroup output for the default mode
  pert tests: Update metric-value for perf stat JSON output
  perf test: Move all the check functions of stat csv output to lib
  perf test: Add test case for the standard perf stat output

 tools/perf/builtin-stat.c                     |   5 +-
 .../arch/x86/alderlake/adl-metrics.json       |  45 +++--
 .../arch/x86/alderlaken/adln-metrics.json     |  25 ++-
 .../arch/x86/icelake/icl-metrics.json         |  20 +-
 .../arch/x86/icelakex/icx-metrics.json        |  20 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |  60 +++---
 .../arch/x86/tigerlake/tgl-metrics.json       |  20 +-
 tools/perf/pmu-events/jevents.py              |   5 +-
 tools/perf/pmu-events/pmu-events.h            |   1 +
 .../tests/shell/lib/perf_json_output_lint.py  |   6 +-
 tools/perf/tests/shell/lib/stat_output.sh     | 169 ++++++++++++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 188 ++----------------
 tools/perf/tests/shell/stat+std_output.sh     | 108 ++++++++++
 tools/perf/util/evsel.h                       |  18 +-
 tools/perf/util/metricgroup.c                 |  43 ++++
 tools/perf/util/metricgroup.h                 |   3 +
 tools/perf/util/stat-display.c                | 108 +++++++++-
 tools/perf/util/stat-shadow.c                 | 108 ++++++++--
 tools/perf/util/stat.h                        |  15 ++
 19 files changed, 686 insertions(+), 281 deletions(-)
 create mode 100755 tools/perf/tests/shell/lib/stat_output.sh
 create mode 100755 tools/perf/tests/shell/stat+std_output.sh

-- 
2.35.1

