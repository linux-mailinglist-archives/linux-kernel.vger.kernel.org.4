Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE5630B34
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKSDak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiKSDah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:30:37 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23690A6589;
        Fri, 18 Nov 2022 19:30:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VV7ZO4r_1668828630;
Received: from 192.168.0.105(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VV7ZO4r_1668828630)
          by smtp.aliyun-inc.com;
          Sat, 19 Nov 2022 11:30:32 +0800
Message-ID: <ae446c02-d5d7-4631-72b7-243b6ef52708@linux.alibaba.com>
Date:   Sat, 19 Nov 2022 11:30:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH RFC 0/6] Add metrics for neoverse-n2
To:     James Clark <james.clark@arm.com>,
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
 <d6553087-9157-21e8-6980-31bc8e44f066@arm.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <d6553087-9157-21e8-6980-31bc8e44f066@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/16 下午7:19, James Clark 写道:
> 
> 
> On 31/10/2022 11:11, Jing Zhang wrote:
>> This series add six metricgroups for neoverse-n2, among which, the
>> formula of topdown L1 is from the document:
>> https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
>>
>> Since neoverse-n2 does not yet support topdown L2, metricgroups such
>> as Cache, TLB, Branch, InstructionsMix, and PEutilization are added to
>> help further analysis of performance bottlenecks.
>>
> 
> Hi Jing,
> 
> Thanks for working on this, these metrics look ok to me in general,
> although we're currently working on publishing standardised metrics
> across all new cores as part of a new project in Arm. This will include
> N2, and our ones are very similar (or almost identical) to yours,
> barring slightly different group names, metric names, and differences in
> things like outputting topdown metrics as percentages.
> 
> We plan to publish our standard metrics some time in the next 2 months.
> Would you consider holding off on merging this change so that we have
> consistant group names and units going forward? Otherwise N2 would be
> the odd one out. I will send you the metrics when they are ready, and we
> will have a script to generate perf jsons from them, so you can review.
> 
> We also have a slightly different forumula for one of the top down
> metrics which I think would be slightly more accurate. We don't have
> anything for your "PE utilization" metrics, which I can raise
> internally. It could always be added to perf on top of the standardised
> ones if we don't add it to our standard ones.
> 
> Thanks
> James
> 

Hi James,

Regarding the arm n2 standard metrics last time, is my understanding correct,
and does it meet your meaning? If so, may I ask when you will send me the
standards you formulate so that I can align with you in time over my patchset.
Please communicate this matter so that we can understand each other's schedule.

Thanks,
Jing


>> with this series on neoverse-n2:
>>
>> $./perf list metricgroup
>>
>> List of pre-defined events (to be used in -e):
>>
>>
>> Metric Groups:
>>
>> Branch
>> Cache
>> InstructionMix
>> PEutilization
>> TLB
>> TopDownL1
>>
>>
>> $./perf list
>>
>> ...
>> Metric Groups:
>>
>> Branch:
>>   branch_miss_pred_rate
>>        [The rate of branches mis-predited to the overall branches]
>>   branch_mpki
>>        [The rate of branches mis-predicted per kilo instructions]
>>   branch_pki
>>        [The rate of branches retired per kilo instructions]
>> Cache:
>>   l1d_cache_miss_rate
>>        [The rate of L1 D-Cache misses to the overall L1 D-Cache]
>>   l1d_cache_mpki
>>        [The rate of L1 D-Cache misses per kilo instructions]
>> ...
>>
>>
>> $sudo ./perf stat -a -M TLB sleep 1
>>
>>  Performance counter stats for 'system wide':
>>
>>         35,861,936      L1I_TLB                          #     0.00 itlb_walk_rate           (74.91%)
>>              5,661      ITLB_WALK                                                            (74.91%)
>>         97,279,240      INST_RETIRED                     #     0.07 itlb_mpki                (74.91%)
>>              6,851      ITLB_WALK                                                            (74.91%)
>>             26,391      DTLB_WALK                        #     0.00 dtlb_walk_rate           (75.07%)
>>         35,585,545      L1D_TLB                                                              (75.07%)
>>         85,923,244      INST_RETIRED                     #     0.35 dtlb_mpki                (75.11%)
>>             29,992      DTLB_WALK                                                            (75.11%)
>>
>>        1.003450755 seconds time elapsed
>>        
>>
>> Jing Zhang (6):
>>   perf vendor events arm64: Add topdown L1 metrics for neoverse-n2
>>   perf vendor events arm64: Add TLB metrics for neoverse-n2
>>   perf vendor events arm64: Add cache metrics for neoverse-n2
>>   perf vendor events arm64: Add branch metrics for neoverse-n2
>>   perf vendor events arm64: Add PE utilization metrics for neoverse-n2
>>   perf vendor events arm64: Add instruction mix metrics for neoverse-n2
>>
>>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 247 +++++++++++++++++++++
>>  1 file changed, 247 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>
