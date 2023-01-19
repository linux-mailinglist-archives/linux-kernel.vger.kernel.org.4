Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4956738E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjASMoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjASMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:43:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069344BF3;
        Thu, 19 Jan 2023 04:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2B360DE9;
        Thu, 19 Jan 2023 12:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080DAC433EF;
        Thu, 19 Jan 2023 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674132120;
        bh=292KzxUJN9VdU7M1zGSDQFahnk68KzKp/8zQpV+/Qwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOzOefUiKR8aX+FEeId4evHN7e/JgrqWImv4P5WaA5/ZM8s5CXfpJUVruBJnzMmBV
         9p01WozxvRhSlWnVUKWN7oIgihNxJ8GLQuD3krjykWvODiYdNrKkep5YAQtetr/kU0
         PfgSqCJKmE0vpZ3SxIrxEJ05z1PGPLUSfDMaNJbYZvOGfR8aB/DrAwq2aOn9u06HPG
         npDNwR01lVQALNdAw5phf/f+R/XJq9KRyPu4d84udalZjhHD7frq0n+qDqB25uprPc
         JU6jdK6rvEDFS25eGFyJ1T8gzdU+soOmh8JUFyqdfY1VJqlh10CAQVgVxpVA0twXjN
         F90PWoCfBMY8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BCA1405BE; Thu, 19 Jan 2023 09:41:57 -0300 (-03)
Date:   Thu, 19 Jan 2023 09:41:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v8 0/9] Add metrics for neoverse-n2-v2
Message-ID: <Y8k6la+oWXm+VSX0@kernel.org>
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 17, 2023 at 03:29:24PM +0800, Jing Zhang escreveu:
> Changes since v7:
> - Change pmu_core__find_same to pmu__find_core_pmu as suggested by Ian.
> - Returned NAN when can't find a pmu or the value from */caps/slots is
>   zero, in perf_pmu__cpu_slots_per_cycle, as suggested by John.
> - Link: https://lore.kernel.org/all/1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com/

Thanks, applied.

- Arnaldo

 
> Changes since v6:
> - Split patch 1 into 3 smaller patches as suggested by Ian.
> - Change perf_pmu__get_slots to perf_pmu__cpu_slots_per_cycle,
>   per John's suggestion;
> - Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
>   function, per John's suggestion;
> - Factor out pmu_core__find_same function, per John's suggestion.
> - Link: https://lore.kernel.org/all/1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Changes since v5:
> - Add common topdownL1 metrics in sbsa.json as suggested by John;
> - Correct PKI/MPKI ScaleUnit to 1PKI/1MPKI;
> - Link: https://lore.kernel.org/all/1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Changes since v4:
> - Add MPKI/PKI “ScaleUnit”;
> - Add acked-by from Ian Rogers;
> - Link: https://lore.kernel.org/all/1671799045-1108027-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Changes since v3:
> - Add ipc_rate metric;
> - Drop the PublicDescription;
> - Describe PEutilization metrics in more detail;
> - Link: https://lore.kernel.org/all/1669310088-13482-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Changes since v2:
> - Correct the furmula of Branch metrics;
> - Add more PE utilization metrics;
> - Add more TLB metrics;
> - Add “ScaleUnit” for some metrics;
> - Add a newline at the end of the file;
> - Link: https://lore.kernel.org/all/1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> Changes since v1:
> - Corrected formula for topdown L1 due to wrong counts for stall_slot
>   and stall_slot_frontend; 
> - Link: https://lore.kernel.org/all/1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> This series does the following things:
> 
> The slots in each architecture may be different, so add #slots literal
> to obtain the slots of different architectures, and the #slots can be
> applied in the topdown metric. Currently, The #slots just support for
> arm64, and other architectures will return NAN.
> 
> The metrics of topdown L1 are from ARM sbsa7.0 platform design doc[0],
> D37-38, which are standard. So put them in the common file sbsa.json of
> arm64 and add general metric support, so that other cores besides n2/v2
> can also be reused.
> 
> Then add topdownL1 metric for neoverse-n2-v2, and due to the wrong count
> of stall_slot and stall_slot_frontend on neoverse-n2, the real stall_slot
> and real stall_slot_frontend need to subtract cpu_cycles, so overwrite
> the "MetricExpr" for neoverse-n2.
> Reference from ARM neoverse-n2 errata notice [1], D117.
> 
> Since neoverse-n2/neoverse-v2 does not yet support topdown L2, metricgroups
> such as Cache, TLB, Branch, InstructionsMix, and PEutilization will be added
> to further analysis of performance bottlenecks in the following patches.
> Reference from ARM PMU guide [2][3].
> 
> [0] https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
> [1] https://documentation-service.arm.com/static/636a66a64e6cf12278ad89cb?token=
> [2] https://documentation-service.arm.com/static/628f8fa3dfaf015c2b76eae8?token=
> [3] https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393?token=
> 
> Tested in neoverse-n2:
> 
> $./perf list
> ...
> Metric Groups:
> 
> Branch:
>   branch_miss_pred_rate
>        [The rate of branches mis-predited to the overall branches]
>   branch_mpki
>        [The rate of branches mis-predicted per kilo instructions]
>   branch_pki
>        [The rate of branches retired per kilo instructions]
> Cache:
>   l1d_cache_miss_rate
>        [The rate of L1 D-Cache misses to the overall L1 D-Cache]
>   l1d_cache_mpki
>        [The rate of L1 D-Cache misses per kilo instructions]
> ...
> 
> 
> $sudo ./perf stat -M TLB false_sharing 2
> 
>  Performance counter stats for 'false_sharing 2':
> 
>             29,940      L2D_TLB                          #     20.0 %  l2_tlb_miss_rate         (42.36%)
>              5,998      L2D_TLB_REFILL                                                          (42.36%)
>              1,753      L1I_TLB_REFILL                   #      0.1 %  l1i_tlb_miss_rate        (43.17%)
>          2,173,957      L1I_TLB                                                                 (43.17%)
>        327,944,763      L1D_TLB                          #      0.0 %  l1d_tlb_miss_rate        (43.98%)
>             22,485      L1D_TLB_REFILL                                                          (43.98%)
>            497,210      L1I_TLB                          #      0.0 %  itlb_walk_rate           (44.83%)
>                 28      ITLB_WALK                                                               (44.83%)
>        821,488,762      INST_RETIRED                     #      0.0 MPKI  itlb_mpki             (43.97%)
>                122      ITLB_WALK                                                               (43.97%)
>                744      DTLB_WALK                        #      0.0 %  dtlb_walk_rate           (43.01%)
>        263,913,146      L1D_TLB                                                                 (43.01%)
>        779,073,875      INST_RETIRED                     #      0.0 MPKI  dtlb_mpki             (42.07%)
>              1,050      DTLB_WALK                                                               (42.07%)
> 
>        0.435864901 seconds time elapsed
> 
>        1.201384000 seconds user
>        0.000000000 seconds sys
> 
> 
> $sudo ./perf stat -M TopDownL1 false_sharing 2
> 
>  Performance counter stats for 'false_sharing 2':
> 
>      3,408,960,257      cpu_cycles                       #      0.0 %  bad_speculation
>                                                   #      5.1 %  retiring                 (66.79%)
>     19,576,079,610      stall_slot                                                              (66.79%)
>        877,673,452      op_spec                                                                 (66.79%)
>        876,324,270      op_retired                                                              (66.79%)
>      3,406,548,064      cpu_cycles                       #     26.7 %  frontend_bound           (67.08%)
>      7,961,814,801      stall_slot_frontend                                                     (67.08%)
>      3,415,528,440      cpu_cycles                       #     68.8 %  backend_bound            (66.43%)
>     11,746,647,747      stall_slot_backend                                                      (66.43%)
> 
>        0.455229807 seconds time elapsed
> 
>        1.243216000 seconds user
>        0.000000000 seconds sys
> 
> $sudo ./perf stat -M branch sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            901,495      INST_RETIRED                     #    223.6 PKI  branch_pki
>            201,603      BR_RETIRED
>            901,495      INST_RETIRED                     #     10.0 MPKI  branch_mpki
>              9,004      BR_MIS_PRED_RETIRED
>              9,004      BR_MIS_PRED_RETIRED              #      4.5 %  branch_miss_pred_rate
>            201,603      BR_RETIRED
> 
>        1.000794467 seconds time elapsed
> 
>        0.000905000 seconds user
>        0.000000000 seconds sys
> 
> 
> Jing Zhang (9):
>   perf pmu: Add #slots literal support for arm64
>   perf jevent: Add general metrics support
>   perf vendor events arm64: Add common topdown L1 metrics
>   perf vendor events arm64: Add topdown L1 metrics for neoverse-n2-v2
>   perf vendor events arm64: Add TLB metrics for neoverse-n2-v2
>   perf vendor events arm64: Add cache metrics for neoverse-n2-v2
>   perf vendor events arm64: Add branch metrics for neoverse-n2-v2
>   perf vendor events arm64: Add PE utilization metrics for
>     neoverse-n2-v2
>   perf vendor events arm64: Add instruction mix metrics for
>     neoverse-n2-v2
> 
>  tools/perf/arch/arm64/util/pmu.c                   |  35 ++-
>  .../arch/arm64/arm/neoverse-n2-v2/metrics.json     | 273 +++++++++++++++++++++
>  tools/perf/pmu-events/arch/arm64/sbsa.json         |  30 +++
>  tools/perf/pmu-events/jevents.py                   |   2 +
>  tools/perf/util/expr.c                             |   5 +
>  tools/perf/util/pmu.c                              |   6 +
>  tools/perf/util/pmu.h                              |   1 +
>  7 files changed, 350 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/sbsa.json
> 
> -- 
> 1.8.3.1

-- 

- Arnaldo
