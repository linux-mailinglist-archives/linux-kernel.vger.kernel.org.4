Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA2673DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjASPxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjASPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:53:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 846671BDC;
        Thu, 19 Jan 2023 07:53:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7631FB;
        Thu, 19 Jan 2023 07:54:18 -0800 (PST)
Received: from [10.57.47.54] (unknown [10.57.47.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501D43F445;
        Thu, 19 Jan 2023 07:53:34 -0800 (PST)
Message-ID: <5fc1e764-bafc-34e5-5ff9-8b62af99ac10@arm.com>
Date:   Thu, 19 Jan 2023 15:53:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/7] perf cs_etm: Basic support for virtual/kernel
 timestamps
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
References: <20230103162042.423694-1-james.clark@arm.com>
 <PH0PR18MB5017223066D8744D12C1F1BAD6FF9@PH0PR18MB5017.namprd18.prod.outlook.com>
 <5acce414-eabb-3d22-4907-da6b64b85a9c@arm.com>
 <b61039b1-1f64-ff1e-8e6a-7d8ada28656c@arm.com>
 <PH0PR18MB50178B52ED081276D2404493D6FD9@PH0PR18MB5017.namprd18.prod.outlook.com>
 <70a94ad3-fe5d-b013-7f6b-dd83d2332e0e@arm.com>
In-Reply-To: <70a94ad3-fe5d-b013-7f6b-dd83d2332e0e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2023 11:12, James Clark wrote:
> 
> 
> On 12/01/2023 15:33, Tanmay Jagdale wrote:
>> Hi James
>>
>>>>>> base-commit: 09e6f9f98370be9a9f8978139e0eb1be87d1125f
>>>>> I have tested this patch set on our platform and able to see updated
>>>>> timestamp values in perf script's output.
>>>>>
>>>>> $ perf record -e cs_etm/cycacc,@tmc_etr0/k -C 9 taskset -c 9 sleep 2
>>>>> $ perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent
>>>>>
>>>>> At certain points noticed that hardware emits same timestamp packets
>>>>> but with updated cycle count (CC) values. A small snippet of the log:
>>>>>
>>>>> Idx:100; ID:12; I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFF8000086A761C ~[0x761C]
>>>>> Idx:103; ID:12; I_TIMESTAMP : Timestamp.; Updated val = 0x2f373e37e02; CC=0x3d
>>>>> Idx:107; ID:12; I_ATOM_F2 : Atom format 2.; EN
>>>>> Idx:108; ID:12; I_TIMESTAMP : Timestamp.; Updated val = 0x2f373e37e02; CC=0x3f
>>>>> Idx:112; ID:12; I_ATOM_F1 : Atom format 1.; N
>>>>> Idx:113; ID:12; I_TIMESTAMP : Timestamp.; Updated val = 0x2f373e37e02; CC=0x45
>>>>> Idx:116; ID:12; I_ATOM_F1 : Atom format 1.; E
>>>>> Idx:117; ID:12; I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFF8000086B52D4 ~[0x152D4]
>>>>>
>>>>> Since the source of timestamp is the Generic Timer block and the CPUs
>>>>> run at higher frequencies, this behaviour could be possible on high
>>>>> performance ARM cores.
>>>>>
>>>>> Having consecutive timestamps with same value is resulting in a
>>>>> slightly jumbled order (in nanosecs) in perf script's time column.
>>>>> A snippet corresponding to the Coresight trace data mentioned above:
>>>>> ...
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   return                               0 ffff8000086a761c coresight_timeout+0xc8
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   return                               0 ffff8000086a7620 coresight_timeout+0xcc
>>>>> perf   965/965   [001]  3182.286629046:            instructions:k:   jmp                                  0 ffff8000086a75c8 coresight_timeout+0x74
>>>>> perf   965/965   [001]  3182.286629046:            instructions:k:   jmp                                  0 ffff8000086a75cc coresight_timeout+0x78
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75d0 coresight_timeout+0x7c
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75d4 coresight_timeout+0x80
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75d8 coresight_timeout+0x84
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75dc coresight_timeout+0x88
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75e0 coresight_timeout+0x8c
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75e4 coresight_timeout+0x90
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75e8 coresight_timeout+0x94
>>>>> perf   965/965   [001]  3182.286629044:            instructions:k:   jcc                                  0 ffff8000086a75ec coresight_timeout+0x98
>>>>>
>>>>> Perf's do_soft_timestamp() logic in cs_etm_decoder.c file is incrementing
>>>>> the HW timestamp based on instruction count. Since the next timestamp
>>>>> also has the same value, it could be leading to this jumbled order.
>>>>>
>>>>> We would like to know if this has been observed on other platforms ?
>>>>> And what could be a solution in SW for this ?
>>>>
>>>> Nice catch. If I'm understanding this correctly it looks like the issue
>>>> is a combination of the cycle count in the packet being ignored by Perf,
>>>> and the instruction count being reset to 0 when a new timestamp is received.
>>>>
>>>> It looks like it can be fixed by some combination of combining the cycle
>>>> count and instruction count and maybe not resetting instruction count if
>>>> the newly received timestamp is the same as the last one. I will look
>>>> into this.
>>>>
>>>> We haven't noticed it on any other platforms, but we haven't been
>>>> looking too closely at the timestamps until now. Perhaps I can add a
>>>> test that checks if the trace in a known function goes in the correct
>>>> time order.
>>>>
>>>
>>> I'm thinking of something like the following patch to fix the ordering.
>>> It doesn't use the cycle count, but I'm not sure if that would be
>>> worthwhile in the end, considering that it would have sub nanosecond
>>> resolution so wouldn't affect the Perf timestamps:
>> Thanks for coming up with a quick solution for this issue !
>>
>>>
>>>
>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> index 31fa3b45134a..08a028e3e87a 100644
>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>> @@ -112,6 +112,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
>>>  	return 1;
>>>  }
>>>
>>> +static u64 cs_etm_decoder__instr_count_to_ns(u64 instr_count)
>>> +{
>>> +	/*
>>> +	 * Assume a maximum of 0.1ns elapsed per instruction. This would be the
>>> +	 * case with a theoretical 10GHz core executing 1 instruction per cycle.
>>> +	 * Used to estimate the sample time for synthesized instructions because
>>> +	 * Coresight only emits a timestamp for a range of instructions rather
>>> +	 * than per instruction.
>>> +	 */
>>> +	const int INSTR_PER_NS = 10;
>>> +
>>> +	return instr_count / INSTR_PER_NS;
>>> +}
>>>  static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
>>>  					    ocsd_etmv3_cfg *config)
>>>  {
>>> @@ -267,7 +280,7 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>>>  	packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
>>>
>>>  	/* Estimate the timestamp for the next range packet */
>>> -	packet_queue->next_cs_timestamp += packet_queue->instr_count;
>>> +	packet_queue->next_cs_timestamp += cs_etm_decoder__instr_count_to_ns(packet_queue->instr_count);
>>>  	packet_queue->instr_count = 0;
>>>
>>>  	/* Tell the front end which traceid_queue needs attention */
>>> @@ -295,11 +308,17 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>>  	 * hence asking the decoder to keep decoding rather than stopping.
>>>  	 */
>>>  	if (packet_queue->cs_timestamp) {
>>> -		packet_queue->next_cs_timestamp = elem->timestamp;
>>> +		/*
>>> +		 * Don't allow next_cs_timestamp to be less than the last one estimated by
>>> +		 * cs_etm_decoder__do_soft_timestamp() otherwise new instructions would
>>> +		 * appear to go back in time. In theory this should never happen, but if
>>> +		 * it did, then next_cs_timestamp should eventually catch up to real time
>>> +		 * unless every single range was predicted to be too long for some reason.
>>> +		 */
>>> +		packet_queue->next_cs_timestamp = max(elem->timestamp, packet_queue->next_cs_timestamp);
>>>  		return OCSD_RESP_CONT;
>>>  	}
>>>
>>> -
>>>  	if (!elem->timestamp) {
>>>  		/*
>>>  		 * Zero timestamps can be seen due to misconfiguration or hardware bugs.
>>> @@ -312,7 +331,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>>  					". Decoding may be improved by prepending 'Z' to your current --itrace
>>> arguments.\n",
>>>  					indx);
>>>
>>> -	} else if (packet_queue->instr_count > elem->timestamp) {
>>> +	} else if (cs_etm_decoder__instr_count_to_ns(packet_queue->instr_count) > elem->timestamp) {
>>>  		/*
>>>  		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
>>>  		 * result in an underflow. Warn and clamp at 0 if it would.
>>> @@ -327,7 +346,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>>>  		 * which instructions started by subtracting the number of instructions
>>>  		 * executed to the timestamp.
>>>  		 */
>>> -		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
>>> +		packet_queue->cs_timestamp = elem->timestamp -
>>> +			cs_etm_decoder__instr_count_to_ns(packet_queue->instr_count);
>>>  	}
>>>  	packet_queue->next_cs_timestamp = elem->timestamp;
>>>  	packet_queue->instr_count = 0;
>> I have tested this diff along with the patchset and found that
>> timestamps are generated/estimated in an increasing order.
>>
>> However, found few corner cases where they weren't in order.
>> I'm currently gathering more information on these corner cases.
>>
>> Used the following steps to find inconsistencies:
>> $ perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
>> $ perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent > itrace
>> $ sed 's/://g' itrace | awk -F '.' ' { print $2 } ' | awk '{ if ($1 < prev) { print "line:" NR " " $0 } {prev=$1}}'
>>
>> Setting INSTR_PER_NS to higher values (14,16,20 etc) results in
>> lower inconsistencies but it would defeat the purpose of
>> estimating values in software since we could be returning 0
>> from __instr_count_to_ns() in many cases.
>>
>> Please share your thoughts.
> 
> I believe this could be because I was adding nanosecond values
> to the raw coresight counter before it was converted which was
> a mistake. I have made another change to move the conversion
> as early as possible to avoid mistakes like this.
> 
> Increasing the INSTR_PER_NS shouldn't be required because of
> the max() call, in fact INSTR_PER_NS isn't necessarily
> needed at all, I just thought it would make it more accurate.
> 
> I'll test the new version on the file that you sent before
> pasting it here. If you have another recording that has more
> of the edge cases then please also upload that one too.

Hi Tanmay,

I've sent v4 and I don't see any issues now with the files that you
sent. There were a couple of different edge cases that I listed in the
last commit message. Let me know if you find any more, otherwise if you
leave your review or tested-by tag that would be great.

Thanks
James
