Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E34632145
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiKULvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiKULvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:51:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC88B2A27D;
        Mon, 21 Nov 2022 03:51:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94BC91FB;
        Mon, 21 Nov 2022 03:51:53 -0800 (PST)
Received: from [10.57.6.6] (unknown [10.57.6.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 757033F587;
        Mon, 21 Nov 2022 03:51:44 -0800 (PST)
Message-ID: <107dda1a-6053-ea35-1e29-96ee6d049eb1@arm.com>
Date:   Mon, 21 Nov 2022 11:51:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   James Clark <james.clark@arm.com>
Subject: Re: [PATCH RFC 0/6] Add metrics for neoverse-n2
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
 <d6553087-9157-21e8-6980-31bc8e44f066@arm.com>
 <d334a33c-b171-8381-3f75-e47392b6cba5@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <d334a33c-b171-8381-3f75-e47392b6cba5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2022 15:26, Jing Zhang wrote:
> 
> 
> 在 2022/11/16 下午7:19, James Clark 写道:
>>
>>
>> On 31/10/2022 11:11, Jing Zhang wrote:
>>> This series add six metricgroups for neoverse-n2, among which, the
>>> formula of topdown L1 is from the document:
>>> https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
>>>
>>> Since neoverse-n2 does not yet support topdown L2, metricgroups such
>>> as Cache, TLB, Branch, InstructionsMix, and PEutilization are added to
>>> help further analysis of performance bottlenecks.
>>>
>>
>> Hi Jing,
>>
>> Thanks for working on this, these metrics look ok to me in general,
>> although we're currently working on publishing standardised metrics
>> across all new cores as part of a new project in Arm. This will include
>> N2, and our ones are very similar (or almost identical) to yours,
>> barring slightly different group names, metric names, and differences in
>> things like outputting topdown metrics as percentages.
>>
>> We plan to publish our standard metrics some time in the next 2 months.
>> Would you consider holding off on merging this change so that we have
>> consistant group names and units going forward? Otherwise N2 would be> the odd one out. I will send you the metrics when they are ready, and we
>> will have a script to generate perf jsons from them, so you can review.
>>
> 
> Do you mean that after you release the new standard metrics, I remake my
> patch referring to them, such as consistent group names and unit?

Hi Jing,

I was planning to submit the patch myself, but there will be a script to
generate perf json files, so no manual work would be needed. Although
this is complicated by the fact that we won't be publishing the fixed
TopdownL1 metrics that you have for the existing N2 silicon so there
would be a one time copy paste to fix that part.

> 
> 
>> We also have a slightly different forumula for one of the top down
>> metrics which I think would be slightly more accurate. We don't have
> 
> 
> The v2 version of the patchset updated the formula of topdown L1.
> Link: https://lore.kernel.org/all/1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com/
> 
> The formula of the v2 version is more accurate than v1, and it has been
> verified in our test environment. Can you share your formula first and we
> can discuss it together? :)

I was looking at v2 but replied to the root of the thread by mistake. I
also had it the wrong way round. So your version corrects for the errata
on the current version of N2 (as you mentioned in the commit message).
Our version would be if there is a future new silicon revision with that
fixed, but it does have an extra improvement by subtracting the branch
mispredicts.

Perf doesn't currently match the jsons based on silicon revision, so
we'd have to add something in for that if a fixed silicon version is
released. But this is another problem for another time.

This is the frontend bound metric we have for future revisions:

	"100 * ( (STALL_SLOT_FRONTEND/(CPU_CYCLES * 5)) - ((BR_MIS_PRED *
4)/CPU_CYCLES) )"

Other changes are, for example, your 'wasted' metric, we have
'bad_speculation', and without the
cycles subtraction:

	100 * ( ((1 - (OP_RETIRED/OP_SPEC)) * (1 - (STALL_SLOT/(CPU_CYCLES *
5)))) + ((BR_MIS_PRED * 4)/CPU_CYCLES) )

And some more details filled in around the units, for example:

    {
        "MetricName": "bad_speculation",
        "MetricExpr": "100 * ( ((1 - (OP_RETIRED/OP_SPEC)) * (1 -
(STALL_SLOT/(CPU_CYCLES * 5)))) + ((BR_MIS_PRED * 4)/CPU_CYCLES) )",
        "BriefDescription": "Bad Speculation",
        "PublicDescription": "This metric is the percentage of total
slots that executed operations and didn't retire due to a pipeline
flush.\nThis indicates cycles that were utilized but inefficiently.",
        "MetricGroup": "TopdownL1",
        "ScaleUnit": "1percent of slots"
    },

So ignoring the errata issue, the main reason to hold off is for
consistency and churn because these metrics in this format will be
released for all cores going forwards.

Thanks
James


