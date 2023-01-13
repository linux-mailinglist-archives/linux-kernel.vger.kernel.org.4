Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1F6692E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjAMJ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbjAMJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:27:17 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EAD42E17;
        Fri, 13 Jan 2023 01:22:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VZUDRQt_1673601743;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZUDRQt_1673601743)
          by smtp.aliyun-inc.com;
          Fri, 13 Jan 2023 17:22:33 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v7 0/9] Add metrics for neoverse-n2-v2
Date:   Fri, 13 Jan 2023 17:22:11 +0800
Message-Id: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
- Split patch #1 into 3 smaller patches as suggested by Ian.
- Change perf_pmu__get_slots into perf_pmu__cpu_slots_per_cycle,
  per John's suggestion;
- Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
  function, per John's suggestion;
- Factor out pmu_core__find_same function, per John's suggestion.
- Link: https://lore.kernel.org/all/1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/

Changes since v5:
- Add common topdownL1 metrics in sbsa.json as suggested by John;
- Correct PKI/MPKI ScaleUnit to 1PKI/1MPKI;
- Link: https://lore.kernel.org/all/1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com/

Changes since v4:
- Add MPKI/PKI “ScaleUnit”;
- Add acked-by from Ian Rogers;
- Link: https://lore.kernel.org/all/1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com/

Changes since v3:
- Add ipc_rate metric;
- Drop the PublicDescription;
- Describe PEutilization metrics in more detail;
- Link: https://lore.kernel.org/all/1669310088-13482-1-git-send-email-renyu.zj@linux.alibaba.com/

Changes since v2:
- Correct the furmula of Branch metrics;
- Add more PE utilization metrics;
- Add more TLB metrics;
- Add “ScaleUnit” for some metrics;
- Add a newline at the end of the file;
- Link: https://lore.kernel.org/all/1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com/

Changes since v1:
- Corrected formula for topdown L1 due to wrong counts for stall_slot and
  stall_slot_frontend; 
- Link: https://lore.kernel.org/all/1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com/

This series does the following things:

The slots in each architecture may be different, so add #slots literal
to obtain the slots of different architectures, and the #slots can be
applied in the topdown metric. Currently, The #slots just support for
arm64, and other architectures will return NAN.

The metrics of topdown L1 are from ARM sbsa7.0 platform design doc[0],
D37-38, which are standard. So put them in the common file sbsa.json of
arm64 and add general metric support, so that other cores besides n2/v2
can also be reused.

Then add topdownL1 metric for neoverse-n2-v2, and due to the wrong count
of stall_slot and stall_slot_frontend on neoverse-n2, the real stall_slot
and real stall_slot_frontend need to subtract cpu_cycles, so overwrite
the "MetricExpr" for neoverse-n2.
Reference from ARM neoverse-n2 errata notice [1], D117.

Since neoverse-n2/neoverse-v2 does not yet support topdown L2, metricgroups
such as Cache, TLB, Branch, InstructionsMix, and PEutilization will be added
to further analysis of performance bottlenecks in the following patches.
Reference from ARM PMU guide [2][3].

[0] https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
[1] https://documentation-service.arm.com/static/636a66a64e6cf12278ad89cb?token=
[2] https://documentation-service.arm.com/static/628f8fa3dfaf015c2b76eae8?token=
[3] https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393?token=

Tested in neoverse-n2:

$./perf list
...
Metric Groups:

Branch:
  branch_miss_pred_rate
       [The rate of branches mis-predited to the overall branches]
  branch_mpki
       [The rate of branches mis-predicted per kilo instructions]
  branch_pki
       [The rate of branches retired per kilo instructions]
Cache:
  l1d_cache_miss_rate
       [The rate of L1 D-Cache misses to the overall L1 D-Cache]
  l1d_cache_mpki
       [The rate of L1 D-Cache misses per kilo instructions]
...


$sudo ./perf stat -M TLB false_sharing 2

 Performance counter stats for 'false_sharing 2':

            29,940      L2D_TLB                          #     20.0 %  l2_tlb_miss_rate         (42.36%)
             5,998      L2D_TLB_REFILL                                                          (42.36%)
             1,753      L1I_TLB_REFILL                   #      0.1 %  l1i_tlb_miss_rate        (43.17%)
         2,173,957      L1I_TLB                                                                 (43.17%)
       327,944,763      L1D_TLB                          #      0.0 %  l1d_tlb_miss_rate        (43.98%)
            22,485      L1D_TLB_REFILL                                                          (43.98%)
           497,210      L1I_TLB                          #      0.0 %  itlb_walk_rate           (44.83%)
                28      ITLB_WALK                                                               (44.83%)
       821,488,762      INST_RETIRED                     #      0.0 MPKI  itlb_mpki             (43.97%)
               122      ITLB_WALK                                                               (43.97%)
               744      DTLB_WALK                        #      0.0 %  dtlb_walk_rate           (43.01%)
       263,913,146      L1D_TLB                                                                 (43.01%)
       779,073,875      INST_RETIRED                     #      0.0 MPKI  dtlb_mpki             (42.07%)
             1,050      DTLB_WALK                                                               (42.07%)

       0.435864901 seconds time elapsed

       1.201384000 seconds user
       0.000000000 seconds sys


$sudo ./perf stat -M TopDownL1 false_sharing 2

 Performance counter stats for 'false_sharing 2':

     3,408,960,257      cpu_cycles                       #      0.0 %  bad_speculation
                                                  #      5.1 %  retiring                 (66.79%)
    19,576,079,610      stall_slot                                                              (66.79%)
       877,673,452      op_spec                                                                 (66.79%)
       876,324,270      op_retired                                                              (66.79%)
     3,406,548,064      cpu_cycles                       #     26.7 %  frontend_bound           (67.08%)
     7,961,814,801      stall_slot_frontend                                                     (67.08%)
     3,415,528,440      cpu_cycles                       #     68.8 %  backend_bound            (66.43%)
    11,746,647,747      stall_slot_backend                                                      (66.43%)

       0.455229807 seconds time elapsed

       1.243216000 seconds user
       0.000000000 seconds sys

$sudo ./perf stat -M branch sleep 1

 Performance counter stats for 'sleep 1':

           901,495      INST_RETIRED                     #    223.6 PKI  branch_pki
           201,603      BR_RETIRED
           901,495      INST_RETIRED                     #     10.0 MPKI  branch_mpki
             9,004      BR_MIS_PRED_RETIRED
             9,004      BR_MIS_PRED_RETIRED              #      4.5 %  branch_miss_pred_rate
           201,603      BR_RETIRED

       1.000794467 seconds time elapsed

       0.000905000 seconds user
       0.000000000 seconds sys

Jing Zhang (9):
  perf pmu: Add #slots literal support for arm64
  perf jevent: Add general metrics support
  perf vendor events arm64: Add common topdown L1 metrics
  perf vendor events arm64: Add topdown L1 metrics for neoverse-n2-v2
  perf vendor events arm64: Add TLB metrics for neoverse-n2-v2
  perf vendor events arm64: Add cache metrics for neoverse-n2-v2
  perf vendor events arm64: Add branch metrics for neoverse-n2-v2
  perf vendor events arm64: Add PE utilization metrics for
    neoverse-n2-v2
  perf vendor events arm64: Add instruction mix metrics for
    neoverse-n2-v2

 tools/perf/arch/arm64/util/pmu.c                   |  34 ++-
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 273 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/sbsa.json         |  30 +++
 tools/perf/pmu-events/jevents.py                   |   2 +
 tools/perf/util/expr.c                             |   5 +
 tools/perf/util/pmu.c                              |   6 +
 tools/perf/util/pmu.h                              |   1 +
 7 files changed, 349 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/sbsa.json

-- 
1.8.3.1

