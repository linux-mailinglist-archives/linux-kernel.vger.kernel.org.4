Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5600265FE67
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAFJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFJy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:54:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A8645641;
        Fri,  6 Jan 2023 01:54:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AFEF11FB;
        Fri,  6 Jan 2023 01:55:09 -0800 (PST)
Received: from [10.57.45.115] (unknown [10.57.45.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4688B3F23F;
        Fri,  6 Jan 2023 01:54:25 -0800 (PST)
Message-ID: <44e87647-d64e-ee24-0046-06bb15f5a1f4@arm.com>
Date:   Fri, 6 Jan 2023 09:54:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v6 11/14] kernel: events: Export
 perf_report_aux_output_id()
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20221123195010.6859-1-mike.leach@linaro.org>
 <20221123195010.6859-12-mike.leach@linaro.org>
 <e3afc4ad-8a95-7d0b-832b-7f7a8be0b647@arm.com>
 <9ea2a0d8-b025-bb56-3a04-1a88e340da2d@arm.com>
In-Reply-To: <9ea2a0d8-b025-bb56-3a04-1a88e340da2d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Ingo, Arnaldo

On 13/12/2022 10:08, Suzuki K Poulose wrote:
> Peter,
> 
> On 24/11/2022 11:04, Suzuki Kuruppassery Poulose wrote:
>> Peter
>>
>>
>> On 23/11/2022 19:50, Mike Leach wrote:
>>> CoreSight trace being updated to use the perf_report_aux_output_id()
>>> in a similar way to intel-pt.
>>>
>>> This function in needs export visibility to allow it to be called from
>>> kernel loadable modules, which CoreSight may configured to be built as.
>>>
>>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   kernel/events/core.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 4ec3717003d5..ad388552f1d5 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -9231,6 +9231,7 @@ void perf_report_aux_output_id(struct 
>>> perf_event *event, u64 hw_id)
>>>       perf_output_end(&handle);
>>>   }
>>> +EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
>>
>> Are you happy with me picking up this change through the coresight  
>> tree ?
>>
>> Suzuki
>>
> 
> Please could you let me know your thoughts on this ? Coresight PMU would
> use this to inform the dynamically allocated trace id for a CPU to the
> perf via this HWID packet.
> 
> If you are happy with the above change, I could pick it up via the
> coresight tree with your Ack. Otherwise, please could you pick it
> up ?
>

Please could you let us know if this is acceptable and if so, how can
this be pushed ? CoreSight PMU (which can be built as a module) is using
these packets to advertise the traceID allocated for a given CPU bound
ETM (which is made dynamic due to the limited number of ids available).
The perf tool can use these packets to then decode and separate the
trace data from shared buffer.

As of now, the series to enable the dynamic trace id allocation is
blocked on this change.


Kind regards
Suzuki

> Suzuki
> 

