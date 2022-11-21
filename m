Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF19632166
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKULzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKULzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:55:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A71E41147F;
        Mon, 21 Nov 2022 03:55:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67FB1FB;
        Mon, 21 Nov 2022 03:55:27 -0800 (PST)
Received: from [10.57.6.6] (unknown [10.57.6.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84E6A3F587;
        Mon, 21 Nov 2022 03:55:18 -0800 (PST)
Message-ID: <aece0734-844a-74c6-8019-6da6e4727a6f@arm.com>
Date:   Mon, 21 Nov 2022 11:55:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC 0/6] Add metrics for neoverse-n2
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     nick Forrington <Nick.Forrington@arm.com>,
        Jumana MP <Jumana.MP@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
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
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <d6553087-9157-21e8-6980-31bc8e44f066@arm.com>
 <ae446c02-d5d7-4631-72b7-243b6ef52708@linux.alibaba.com>
 <CAP-5=fW+Z_Tc3BfK1bRKUeKWfxtPfoZXL9D2BhcU1SzNOruSsg@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fW+Z_Tc3BfK1bRKUeKWfxtPfoZXL9D2BhcU1SzNOruSsg@mail.gmail.com>
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



On 19/11/2022 21:46, Ian Rogers wrote:
> On Fri, Nov 18, 2022 at 7:30 PM Jing Zhang <renyu.zj@linux.alibaba.com>
> wrote:
>>
>>
>> 在 2022/11/16 下午7:19, James Clark 写道:
>>>
>>>
>>> On 31/10/2022 11:11, Jing Zhang wrote:
>>>> This series add six metricgroups for neoverse-n2, among which, the
>>>> formula of topdown L1 is from the document:
>>>>
> https://documentation-service.arm.com/static/60250c7395978b529036da86?token=
>>>>
>>>> Since neoverse-n2 does not yet support topdown L2, metricgroups such
>>>> as Cache, TLB, Branch, InstructionsMix, and PEutilization are added to
>>>> help further analysis of performance bottlenecks.
>>>>
>>>
>>> Hi Jing,
>>>
>>> Thanks for working on this, these metrics look ok to me in general,
>>> although we're currently working on publishing standardised metrics
>>> across all new cores as part of a new project in Arm. This will include
>>> N2, and our ones are very similar (or almost identical) to yours,
>>> barring slightly different group names, metric names, and differences in
>>> things like outputting topdown metrics as percentages.
>>>
>>> We plan to publish our standard metrics some time in the next 2 months.
>>> Would you consider holding off on merging this change so that we have
>>> consistant group names and units going forward? Otherwise N2 would be
>>> the odd one out. I will send you the metrics when they are ready, and we
>>> will have a script to generate perf jsons from them, so you can review.
>>>
>>> We also have a slightly different forumula for one of the top down
>>> metrics which I think would be slightly more accurate. We don't have
>>> anything for your "PE utilization" metrics, which I can raise
>>> internally. It could always be added to perf on top of the standardised
>>> ones if we don't add it to our standard ones.
>>>
>>> Thanks
>>> James
>>>
>>
>> Hi James,
>>
>> Regarding the arm n2 standard metrics last time, is my understanding
> correct,
>> and does it meet your meaning? If so, may I ask when you will send me the
>> standards you formulate so that I can align with you in time over my
> patchset.
>> Please communicate this matter so that we can understand each other's
> schedule.
>>
>> Thanks,
>> Jing
> 
> Hi,
> 
> In past versions of the perf tool the metrics have been pretty broken. If
> we have something that is good we shouldn't be holding it to a bar of being
> perfect, we can merge what we have and improve over time. In this case what
> Jing has prepared may arrive in time for Linux 6.2 whilst the standard
> metrics may arrive in time for 6.3. I'd suggest merging Jing's work and
> then improving on it with the standard metrics.
>

I'm not completely opposed to this, I was just worried about the churn
because ours will be generated from a script, and that it would end up
looking like a mass replacement of these that would have only recently
been added.

But maybe that's fine like you say.

> In terms of the metrics themselves, could we add ScaleUnit? For example:
> 
> +    {
> +        "MetricExpr": "LD_SPEC / INST_SPEC",
> +        "PublicDescription": "The rate of load instructions speculatively
> executed to overall instructions speclatively executed",
> +        "BriefDescription": "The rate of load instructions speculatively
> executed to overall instructions speclatively executed",
> +        "MetricGroup": "InstructionMix",
> +        "MetricName": "load_spec_rate"
> +    },
> 
> A ScaleUnit of "100%" would likely make things more readable.
> 
> Thanks,
> Ian
> 
