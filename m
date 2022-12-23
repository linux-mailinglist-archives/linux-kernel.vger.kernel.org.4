Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE39655079
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiLWMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiLWMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:39:37 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA6193DB;
        Fri, 23 Dec 2022 04:39:34 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VXwwMWV_1671799163;
Received: from srmbuffer011165236051.sqa.eu95(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VXwwMWV_1671799163)
          by smtp.aliyun-inc.com;
          Fri, 23 Dec 2022 20:39:30 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
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
Subject: [PATCH v4 0/6] Add metrics for neoverse-n2
Date:   Fri, 23 Dec 2022 20:37:19 +0800
Message-Id: <1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


This series add six metricgroups for neoverse-n2, among which, the formula of
topdown L1 is from ARM sbsa7.0 platform design document [0], D37-38.

However, due to the wrong count of stall_slot and stall_slot_frontend on
neoverse-n2, the real stall_slot and real stall_slot_frontend need to
subtract cpu_cycles,  so correct the expression of topdown metrics.
Reference from ARM neoverse-n2 errata notice [1], D117.

Since neoverse-n2 does not yet support topdown L2, metricgroups such as Cache,
TLB, Branch, InstructionsMix, and PEutilization are added to help further
analysis of performance bottlenecks. Reference from ARM PMU guide [2][3].

[0] https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
[1] https://documentation-service.arm.com/static/636a66a64e6cf12278ad89cb?token=
[2] https://documentation-service.arm.com/static/628f8fa3dfaf015c2b76eae8?token=
[3] https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393?token=


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

            31,561      L2D_TLB                          #     18.8 %  l2_tlb_miss_rate      (43.23%)
             5,944      L2D_TLB_REFILL                                                       (43.23%)
             2,248      L1I_TLB_REFILL                   #      0.1 %  l1i_tlb_miss_rate     (43.85%)
         2,203,195      L1I_TLB                                                              (43.85%)
       328,647,380      L1D_TLB                          #      0.0 %  l1d_tlb_miss_rate     (44.32%)
            26,347      L1D_TLB_REFILL                                                       (44.32%)
           747,319      L1I_TLB                          #      0.0 %  itlb_walk_rate        (43.74%)
               310      ITLB_WALK                                                            (43.74%)
       839,420,454      INST_RETIRED                     #     0.00 itlb_mpki                (42.77%)
               212      ITLB_WALK                                                            (42.77%)
               468      DTLB_WALK                        #      0.0 %  dtlb_walk_rate        (42.28%)
       265,405,802      L1D_TLB                                                              (42.28%)
       790,874,367      INST_RETIRED                     #     0.00 dtlb_mpki                (42.33%)
                23      DTLB_WALK                                                            (42.33%)

       0.515904553 seconds time elapsed

       1.410313000 seconds user
       0.000000000 seconds sys


$sudo ./perf stat -M TopDownL1 false_sharing 2

 Performance counter stats for 'false_sharing 2':

     4,310,905,590      cpu_cycles                       #      0.0 %  bad_speculation
                                                  #      4.0 %  retiring              (66.87%)
    25,009,763,735      stall_slot                                                           (66.87%)
       855,659,327      op_spec                                                              (66.87%)
       854,335,288      op_retired                                                           (66.87%)
     4,330,308,058      cpu_cycles                       #     27.1 %  frontend_bound        (66.99%)
    10,207,186,460      stall_slot_frontend                                                  (66.99%)
     4,316,583,673      cpu_cycles                       #     69.4 %  backend_bound         (66.65%)
    14,979,136,808      stall_slot_backend                                                   (66.65%)

       0.572056818 seconds time elapsed

       1.572143000 seconds user
       0.004010000 seconds sys


Jing Zhang (6):
  perf vendor events arm64: Add topdown L1 metrics for neoverse-n2
  perf vendor events arm64: Add TLB metrics for neoverse-n2
  perf vendor events arm64: Add cache metrics for neoverse-n2
  perf vendor events arm64: Add branch metrics for neoverse-n2
  perf vendor events arm64: Add PE utilization metrics for neoverse-n2
  perf vendor events arm64: Add instruction mix metrics for neoverse-n2

 .../arch/arm64/arm/neoverse-n2/metrics.json        | 277 +++++++++++++++++++++
 1 file changed, 277 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json

-- 
1.8.3.1

