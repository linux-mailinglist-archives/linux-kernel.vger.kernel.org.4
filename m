Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA143613436
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJaLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJaLLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:11:45 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B03BE12;
        Mon, 31 Oct 2022 04:11:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VTVxoG-_1667214695;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VTVxoG-_1667214695)
          by smtp.aliyun-inc.com;
          Mon, 31 Oct 2022 19:11:41 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: [PATCH RFC 0/6] Add metrics for neoverse-n2
Date:   Mon, 31 Oct 2022 19:11:28 +0800
Message-Id: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add six metricgroups for neoverse-n2, among which, the
formula of topdown L1 is from the document:
https://documentation-service.arm.com/static/60250c7395978b529036da86?token=

Since neoverse-n2 does not yet support topdown L2, metricgroups such
as Cache, TLB, Branch, InstructionsMix, and PEutilization are added to
help further analysis of performance bottlenecks.

with this series on neoverse-n2:

$./perf list metricgroup

List of pre-defined events (to be used in -e):


Metric Groups:

Branch
Cache
InstructionMix
PEutilization
TLB
TopDownL1


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


$sudo ./perf stat -a -M TLB sleep 1

 Performance counter stats for 'system wide':

        35,861,936      L1I_TLB                          #     0.00 itlb_walk_rate           (74.91%)
             5,661      ITLB_WALK                                                            (74.91%)
        97,279,240      INST_RETIRED                     #     0.07 itlb_mpki                (74.91%)
             6,851      ITLB_WALK                                                            (74.91%)
            26,391      DTLB_WALK                        #     0.00 dtlb_walk_rate           (75.07%)
        35,585,545      L1D_TLB                                                              (75.07%)
        85,923,244      INST_RETIRED                     #     0.35 dtlb_mpki                (75.11%)
            29,992      DTLB_WALK                                                            (75.11%)

       1.003450755 seconds time elapsed
       

Jing Zhang (6):
  perf vendor events arm64: Add topdown L1 metrics for neoverse-n2
  perf vendor events arm64: Add TLB metrics for neoverse-n2
  perf vendor events arm64: Add cache metrics for neoverse-n2
  perf vendor events arm64: Add branch metrics for neoverse-n2
  perf vendor events arm64: Add PE utilization metrics for neoverse-n2
  perf vendor events arm64: Add instruction mix metrics for neoverse-n2

 .../arch/arm64/arm/neoverse-n2/metrics.json        | 247 +++++++++++++++++++++
 1 file changed, 247 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json

-- 
1.8.3.1

