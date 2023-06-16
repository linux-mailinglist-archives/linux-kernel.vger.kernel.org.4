Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD667325BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbjFPDPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241838AbjFPDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:14:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2AB2132;
        Thu, 15 Jun 2023 20:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885288; x=1718421288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j6V55rCFU2w6lIcgKhvWcpNfOzmEBuL+14YH+IvcGk4=;
  b=R9mPMSBlwTxzeKvzIcRLv5SvBXH69W/MwstUVU/Xbfp+JMnQcBGw506o
   OBpzm9aip2f8nb9BRz9mOnyJOC0hQNS96zXy8UPOsyeW5C9enTWqImAVA
   GOWfzcR9TM+ozLKdMUJTmBPaaIFyAowfCiXzNFfKGKGe3TGOjeZ9q7eEl
   RD0uJ/dysJujyjwejfJQlyZ54nKyK2nYosnXy6YM+jkWGhNv/8f2Yc8QL
   +vCxZ+WW+DZolRg2Wq9fuXKcvNespziAbm3dwHH8iKxkcFjSDguCGvi4i
   aUm+PfAx2/83/gGiQ9ToUs7x3+nACPBl2XCZPOzMMrpGAvn96T0uDZqBH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338718185"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="338718185"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825555582"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="825555582"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 20:14:47 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        irogers@google.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 0/5] New metricgroup output in perf stat default mode
Date:   Thu, 15 Jun 2023 20:14:15 -0700
Message-Id: <20230616031420.3751973-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- Move the full name (PMU + metricgroup name) generation from the metric
  code to the output code. (Ian)
- Add default tags for Hisi hip08 L1 metrics (John)
- Some patches have been merged. Drop them from the V4.

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

The patches 1-2 introduce the new metricgroup output.

The patches 3-4 improve the tests to cover the default mode.

The patch 5 update the event list for Hisi hip08.

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

Kan Liang (5):
  perf metrics: Sort the Default metricgroup
  perf stat: New metricgroup output for the default mode
  perf test: Move all the check functions of stat csv output to lib
  perf test: Add test case for the standard perf stat output
  perf vendor events arm64: Add default tags for Hisi hip08 L1 metrics

 tools/perf/builtin-stat.c                     |   1 +
 .../arch/arm64/hisilicon/hip08/metrics.json   |  12 +-
 tools/perf/tests/shell/lib/stat_output.sh     | 169 ++++++++++++++++
 tools/perf/tests/shell/stat+csv_output.sh     | 188 ++----------------
 tools/perf/tests/shell/stat+std_output.sh     | 108 ++++++++++
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/metricgroup.c                 |  26 +++
 tools/perf/util/metricgroup.h                 |   3 +
 tools/perf/util/stat-display.c                | 108 +++++++++-
 tools/perf/util/stat-shadow.c                 | 131 ++++++++++--
 tools/perf/util/stat.h                        |  15 ++
 11 files changed, 563 insertions(+), 199 deletions(-)
 create mode 100755 tools/perf/tests/shell/lib/stat_output.sh
 create mode 100755 tools/perf/tests/shell/stat+std_output.sh

-- 
2.35.1

