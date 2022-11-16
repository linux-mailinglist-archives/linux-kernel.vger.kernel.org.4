Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B9F62BBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiKPLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiKPLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:30:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0900326D3;
        Wed, 16 Nov 2022 03:19:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 785E61477;
        Wed, 16 Nov 2022 03:19:40 -0800 (PST)
Received: from [10.1.39.20] (e121896.cambridge.arm.com [10.1.39.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597EF3F663;
        Wed, 16 Nov 2022 03:19:30 -0800 (PST)
Message-ID: <d6553087-9157-21e8-6980-31bc8e44f066@arm.com>
Date:   Wed, 16 Nov 2022 11:19:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC 0/6] Add metrics for neoverse-n2
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        nick Forrington <Nick.Forrington@arm.com>,
        Jumana MP <Jumana.MP@arm.com>,
        John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
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
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/2022 11:11, Jing Zhang wrote:
> This series add six metricgroups for neoverse-n2, among which, the
> formula of topdown L1 is from the document:
> https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
> 
> Since neoverse-n2 does not yet support topdown L2, metricgroups such
> as Cache, TLB, Branch, InstructionsMix, and PEutilization are added to
> help further analysis of performance bottlenecks.
> 

Hi Jing,

Thanks for working on this, these metrics look ok to me in general,
although we're currently working on publishing standardised metrics
across all new cores as part of a new project in Arm. This will include
N2, and our ones are very similar (or almost identical) to yours,
barring slightly different group names, metric names, and differences in
things like outputting topdown metrics as percentages.

We plan to publish our standard metrics some time in the next 2 months.
Would you consider holding off on merging this change so that we have
consistant group names and units going forward? Otherwise N2 would be
the odd one out. I will send you the metrics when they are ready, and we
will have a script to generate perf jsons from them, so you can review.

We also have a slightly different forumula for one of the top down
metrics which I think would be slightly more accurate. We don't have
anything for your "PE utilization" metrics, which I can raise
internally. It could always be added to perf on top of the standardised
ones if we don't add it to our standard ones.

Thanks
James

> with this series on neoverse-n2:
> 
> $./perf list metricgroup
> 
> List of pre-defined events (to be used in -e):
> 
> 
> Metric Groups:
> 
> Branch
> Cache
> InstructionMix
> PEutilization
> TLB
> TopDownL1
> 
> 
> $./perf list
> 
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
> $sudo ./perf stat -a -M TLB sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         35,861,936      L1I_TLB                          #     0.00 itlb_walk_rate           (74.91%)
>              5,661      ITLB_WALK                                                            (74.91%)
>         97,279,240      INST_RETIRED                     #     0.07 itlb_mpki                (74.91%)
>              6,851      ITLB_WALK                                                            (74.91%)
>             26,391      DTLB_WALK                        #     0.00 dtlb_walk_rate           (75.07%)
>         35,585,545      L1D_TLB                                                              (75.07%)
>         85,923,244      INST_RETIRED                     #     0.35 dtlb_mpki                (75.11%)
>             29,992      DTLB_WALK                                                            (75.11%)
> 
>        1.003450755 seconds time elapsed
>        
> 
> Jing Zhang (6):
>   perf vendor events arm64: Add topdown L1 metrics for neoverse-n2
>   perf vendor events arm64: Add TLB metrics for neoverse-n2
>   perf vendor events arm64: Add cache metrics for neoverse-n2
>   perf vendor events arm64: Add branch metrics for neoverse-n2
>   perf vendor events arm64: Add PE utilization metrics for neoverse-n2
>   perf vendor events arm64: Add instruction mix metrics for neoverse-n2
> 
>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 247 +++++++++++++++++++++
>  1 file changed, 247 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> 
