Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21E7265DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjFGQ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFGQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:27:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCB1702;
        Wed,  7 Jun 2023 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686155239; x=1717691239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vHtpI6Qsn7NGjTSAM0k4UxnDolyPgswNmZ79/69hRuo=;
  b=CQ4EJCcc3F5yRfC3+9LaByT6guFI2rdVz7p6Lt2FoUdNA8ZaNfYe21r/
   bQPczZHYhivuHAcAxA3TpqvzpGI4srTgAGJaBmObWFhDLXgXkGNs0cisO
   qaMJuQCu8Ns6kUGIV/myoLvkM2T7qKjvYDOj0wLXz3V+T6WfEL9zd2I6g
   Bs1czTNQ8dzScdY1ci53yNCyZfloHJOXRvyWAyIKPhxcim6RPwGyZ3/u4
   nHaWdFyeiWb5D8edG9wjJfrdf2ZrMfJIX/Qobw0nWiru9R2/0JEbnw8QA
   YGFJqLHmaU1+H0XbXY0IxM15k83q3+cGjXAcvUdoos0/kTjRAbDsShmGb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="355892602"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="355892602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774697649"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="774697649"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 09:27:18 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/8] New metricgroup output in perf stat default mode
Date:   Wed,  7 Jun 2023 09:26:52 -0700
Message-Id: <20230607162700.3234712-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In the default mode, the current output of the metricgroup include both
events and metrics, which is not necessary and makes the output hard to
read. Also, different ARCHs (even different generations of the ARCH) may
have a different output format because of the different events in a
metrics.

The patch proposes a new output format which only outputting the value
of each metric and the metricgroup name. It can brings a clean and
consistent output format among ARCHs and generations.

The first two patches are bug fixes for the current code.

The patches 3-6 introduce the new metricgroup output.

The patches 7-8 improve the tests to cover the default mode.

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

On Hybrid

perf stat -a sleep 1

 Performance counter stats for 'system wide':

         32,154.81 msec cpu-clock                        #   31.978 CPUs utilized
               165      context-switches                 #    5.131 /sec
                33      cpu-migrations                   #    1.026 /sec
                72      page-faults                      #    2.239 /sec
         5,653,347      cpu_core/cycles/                 #    0.000 GHz
         4,164,114      cpu_atom/cycles/                 #    0.000 GHz
         3,921,839      cpu_core/instructions/           #    0.69  insn per cycle
         2,142,800      cpu_atom/instructions/           #    0.38  insn per cycle
           713,629      cpu_core/branches/               #   22.194 K/sec
           452,838      cpu_atom/branches/               #   14.083 K/sec
            26,810      cpu_core/branch-misses/          #    3.76% of all branches
            26,029      cpu_atom/branch-misses/          #    3.65% of all branches
             TopdownL1 (cpu_core)                 #     32.0 %  tma_backend_bound
                                                  #      8.0 %  tma_bad_speculation
                                                  #     45.5 %  tma_frontend_bound
                                                  #     14.5 %  tma_retiring


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
{"counter-value" : "32150.838437", "unit" : "msec", "event" : "cpu-clock", "event-runtime" : 32150846654, "pcnt-running" : 100.00, "metric-value" : "31.981465", "metric-unit" : "CPUs utilized"}
{"counter-value" : "154.000000", "unit" : "", "event" : "context-switches", "event-runtime" : 32150849941, "pcnt-running" : 100.00, "metric-value" : "4.789922", "metric-unit" : "/sec"}
{"counter-value" : "32.000000", "unit" : "", "event" : "cpu-migrations", "event-runtime" : 32150851194, "pcnt-running" : 100.00, "metric-value" : "0.995308", "metric-unit" : "/sec"}
{"counter-value" : "73.000000", "unit" : "", "event" : "page-faults", "event-runtime" : 32150855128, "pcnt-running" : 100.00, "metric-value" : "2.270547", "metric-unit" : "/sec"}
{"counter-value" : "6404864.000000", "unit" : "", "event" : "cpu_core/cycles/", "event-runtime" : 16069765136, "pcnt-running" : 100.00, "metric-value" : "0.000199", "metric-unit" : "GHz"}
{"counter-value" : "3011411.000000", "unit" : "", "event" : "cpu_atom/cycles/", "event-runtime" : 16080917475, "pcnt-running" : 100.00, "metric-value" : "0.000094", "metric-unit" : "GHz"}
{"counter-value" : "4748155.000000", "unit" : "", "event" : "cpu_core/instructions/", "event-runtime" : 16069777198, "pcnt-running" : 100.00, "metric-value" : "0.741336", "metric-unit" : "insn per cycle"}
{"counter-value" : "1129678.000000", "unit" : "", "event" : "cpu_atom/instructions/", "event-runtime" : 16080933337, "pcnt-running" : 100.00, "metric-value" : "0.176378", "metric-unit" : "insn per cycle"}
{"counter-value" : "943319.000000", "unit" : "", "event" : "cpu_core/branches/", "event-runtime" : 16069771422, "pcnt-running" : 100.00, "metric-value" : "29.340417", "metric-unit" : "K/sec"}
{"counter-value" : "194500.000000", "unit" : "", "event" : "cpu_atom/branches/", "event-runtime" : 16080937169, "pcnt-running" : 100.00, "metric-value" : "6.049609", "metric-unit" : "K/sec"}
{"counter-value" : "31974.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 16069759637, "pcnt-running" : 100.00, "metric-value" : "3.389521", "metric-unit" : "of all branches"}
{"counter-value" : "18643.000000", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 16080929464, "pcnt-running" : 100.00, "metric-value" : "1.976320", "metric-unit" : "of all branches"}
{"event-runtime" : 16069747669, "pcnt-running" : 100.00, "metricgroup" : "TopdownL1 (cpu_core)"}
{"metric-value" : "30.939553", "metric-unit" : "%  tma_backend_bound"}
{"metric-value" : "8.303274", "metric-unit" : "%  tma_bad_speculation"}
{"metric-value" : "46.181223", "metric-unit" : "%  tma_frontend_bound"}
{"metric-value" : "14.575950", "metric-unit" : "%  tma_retiring"}


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
32148.69,msec,cpu-clock,32148689529,100.00,31.974,CPUs utilized
168,,context-switches,32148707526,100.00,5.226,/sec
33,,cpu-migrations,32148718292,100.00,1.026,/sec
73,,page-faults,32148729436,100.00,2.271,/sec
8632400,,cpu_core/cycles/,16067477534,100.00,0.000,GHz
3359282,,cpu_atom/cycles/,16081105672,100.00,0.000,GHz
9222630,,cpu_core/instructions/,16067506390,100.00,1.07,insn per cycle
1256594,,cpu_atom/instructions/,16081131302,100.00,0.15,insn per cycle
1842167,,cpu_core/branches/,16067509544,100.00,57.301,K/sec
215437,,cpu_atom/branches/,16081139517,100.00,6.701,K/sec
38133,,cpu_core/branch-misses/,16067511463,100.00,2.07,of all branches
20857,,cpu_atom/branch-misses/,16081135654,100.00,1.13,of all branches
,16067501860,100.00,,,,TopdownL1 (cpu_core)
,,,,,30.6,%  tma_backend_bound
,,,,,7.8,%  tma_bad_speculation
,,,,,42.0,%  tma_frontend_bound
,,,,,19.6,%  tma_retiring


Kan Liang (8):
  perf metric: Fix no group check
  perf evsel: Fix the annotation for hardware events on hybrid
  perf metric: JSON flag to default metric group
  perf vendor events arm64: Add default tags into topdown L1 metrics
  perf stat,jevents: Introduce Default tags for the default mode
  perf stat,metrics: New metrics output for the default mode
  pert tests: Support metricgroup perf stat JSON output
  perf test: Add test case for the standard perf stat output

 tools/perf/builtin-stat.c                     |   5 +-
 tools/perf/pmu-events/arch/arm64/sbsa.json    |  12 +-
 .../arch/x86/alderlake/adl-metrics.json       |  20 +-
 .../arch/x86/icelake/icl-metrics.json         |  20 +-
 .../arch/x86/icelakex/icx-metrics.json        |  20 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |  60 ++--
 .../arch/x86/tigerlake/tgl-metrics.json       |  20 +-
 tools/perf/pmu-events/jevents.py              |   5 +-
 tools/perf/pmu-events/pmu-events.h            |   1 +
 .../tests/shell/lib/perf_json_output_lint.py  |   3 +
 tools/perf/tests/shell/stat+std_output.sh     | 259 ++++++++++++++++++
 tools/perf/util/evsel.h                       |  13 +-
 tools/perf/util/metricgroup.c                 | 111 +++++++-
 tools/perf/util/metricgroup.h                 |   1 +
 tools/perf/util/stat-display.c                |  69 ++++-
 tools/perf/util/stat-shadow.c                 |  39 +--
 16 files changed, 564 insertions(+), 94 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+std_output.sh

-- 
2.35.1

