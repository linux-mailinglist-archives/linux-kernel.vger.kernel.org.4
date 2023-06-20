Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4212C737380
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjFTSID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTSIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:08:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C39DB198;
        Tue, 20 Jun 2023 11:07:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 540291063;
        Tue, 20 Jun 2023 11:08:43 -0700 (PDT)
Received: from [10.57.24.104] (unknown [10.57.24.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983373F64C;
        Tue, 20 Jun 2023 11:07:55 -0700 (PDT)
Message-ID: <a464e8ee-a1b9-10dd-5be0-d9dee994d7b8@arm.com>
Date:   Tue, 20 Jun 2023 19:08:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND][PATCH v2 3/3] schedutil: trace: Add tracing to capture
 filter out requests
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com,
        qyousef@layalina.io, kernel test robot <lkp@intel.com>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-4-lukasz.luba@arm.com>
 <CAJZ5v0g45=0+uLqPD5jib8aQrw8syjMxzd9uPqnTUzxgVCDVkQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g45=0+uLqPD5jib8aQrw8syjMxzd9uPqnTUzxgVCDVkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 6/20/23 18:40, Rafael J. Wysocki wrote:
> On Mon, May 22, 2023 at 4:57 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Some of the frequency update requests coming form the task scheduler
>> might be filter out. It can happen when the previous request was served
>> not that long ago (in a period smaller than provided by the cpufreq driver
>> as minimum for frequency update). In such case, we want to know if some of
>> the frequency updates cannot make through.
>> Export the new tracepoint as well. That would allow to handle it by a
>> toolkit for trace analyzes.
>>
>> Reported-by: kernel test robot <lkp@intel.com> # solved tricky build
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/trace/events/sched.h     |  4 ++++
>>   kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
>> index dbfb30809f15..e34b7cd5de73 100644
>> --- a/include/trace/events/sched.h
>> +++ b/include/trace/events/sched.h
>> @@ -739,6 +739,10 @@ DECLARE_TRACE(uclamp_update_tsk_tp,
>>          TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
>>          TP_ARGS(tsk, uclamp_id, value));
>>
>> +DECLARE_TRACE(schedutil_update_filtered_tp,
>> +       TP_PROTO(int cpu),
>> +       TP_ARGS(cpu));
>> +
>>   #endif /* _TRACE_SCHED_H */
>>
>>   /* This part must be outside protection */
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index f462496e5c07..4f9daf258a65 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -6,6 +6,8 @@
>>    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>    */
>>
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
>> +
>>   #define IOWAIT_BOOST_MIN       (SCHED_CAPACITY_SCALE / 8)
>>
>>   struct sugov_tunables {
>> @@ -318,8 +320,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>>
>>          ignore_dl_rate_limit(sg_cpu);
>>
>> -       if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>> +       if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
>> +               trace_schedutil_update_filtered_tp(sg_cpu->cpu);
> 
> It looks like the tracepoint can be added to
> sugov_should_update_freq() for less code duplication.
> 

Make sense. I will move that trace there.

In such case, of movement that trace call...
Based on your comment for patch 2/3 I got impression
that you still want it. For me it looks more 'aligned' w/ that
patch 2/3. The two functions code flows:
sugov_update_shared() and sugov_update_single_common() - how
they call and interpret result from
sugov_should_update_freq() - is more clear IMO.

So I will keep that patch 2/3 in the next version. Although,
if you don't like it - please tell me and I will drop it.

Thanks for the review!

Lukasz
