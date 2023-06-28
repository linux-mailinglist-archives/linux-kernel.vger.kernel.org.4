Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2859741264
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjF1N3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:29:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232060AbjF1N1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:27:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA1A0C14;
        Wed, 28 Jun 2023 06:28:33 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFAFE3F663;
        Wed, 28 Jun 2023 06:27:47 -0700 (PDT)
Message-ID: <a77130d2-b313-6eda-ad44-7b234ac16547@arm.com>
Date:   Wed, 28 Jun 2023 14:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] perf: cs-etm: Fixes in instruction sample synthesis
Content-Language: en-US
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Anil Kumar Reddy H <areddy3@marvell.com>,
        "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "will@kernel.org" <will@kernel.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "irogers@google.com" <irogers@google.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>
References: <20230623182204.25199-1-tanmay@marvell.com>
 <20230623182204.25199-2-tanmay@marvell.com>
 <e60de124-ae61-c8a0-c012-ce6d4dabad10@arm.com>
 <PH0PR18MB5017A3EA0B38EC0F1E795A2ED624A@PH0PR18MB5017.namprd18.prod.outlook.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <PH0PR18MB5017A3EA0B38EC0F1E795A2ED624A@PH0PR18MB5017.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/2023 09:01, Tanmay Jagdale wrote:
> Hi James,
> 
>> On 23/06/2023 19:22, Tanmay Jagdale wrote:
>>> The existing method of synthesizing instruction samples has the
>>> following issues:
>>> 1. Non-branch instructions have mnemonics of branch instructions.
>>> 2. Branch target address is missing.
>>>
>>> Set the sample flags only when we reach the last instruction in
>>> the tidq (which would be a branch instruction) to solve issue 1).
>>>
>>> To fix issue 2), start synthesizing the instructions from the
>>> previous packet (tidq->prev_packet) instead of current packet
>>> (tidq->packet). This way, it is easy to figure out the target
>>> address of the branch instruction in tidq->prev_packet which
>>> is the current packet's (tidq->packet) first executed instruction.
>>>
>>> After the switch to processing the previous packet first, we no
>>> longer need to swap the packets during cs_etm__flush().
>>
>> Hi Tanmay,
>>
>> I think the fix for setting the right flags and instruction type makes
>> sense, but is it possible to do it without the change to swapping in
>> cs_etm__flush() or some of the other changes to
>> cs_etm__synth_instruction_sample()?
> Thanks for the review. I took this approach of swapping because
> it would be easy to figure out the target address of the branch.
> If we don't swap the packet synthesis, then we must decode the
> actual instruction to get the branch target address.
> IMHO, this would be a complex change.
> 
> Since the swapping approach is meant to solve issue 2) I will
> split the patch while posting the next version.
> 
>>
>> I'm seeing some differences in the output related to the PID that's
>> assigned to a sample and some of the addresses that aren't explained by
>> the commit message. Also there is no corresponding change to
>> cs_etm__synth_branch_sample(), which is also using prev_packet etc so
>> I'm wondering if that's correct now without the swap? That function gets
>> used with the default itrace options or itrace=b
> IMHO the existing way to handle itrace=b or itrace is correct and
> does not need any change since we are interested in only the last and
> first instruction from tidq->prev_packet and tidq->packet respectively,
> to generate the branching information.
> 
>>
>> For example if I run 'perf script --itrace=i100ns' and diff the output
>> before and after your change I see a difference even though branch and
>> instruction info isn't printed, so I wouldn't expect to see any changes.
>> This is on a systemwide recording of a system under load.
> Yes, the "tr start" mnemonic isn't printed in the flags column, but
> rest of columns are the same. Will fix this in the next version.
> 
> If you have observed any other differences, can you please share them ?
> 
> Also, can you please share the test case commands so that I can run them
> before submitting the next version ?

It's just if you diff any existing recording it seems that there are
differences. In this case below I see a difference in the ordering of
the samples generated. In a more complicated case with a VM running I
also see a difference in which PID is assigned to some samples. It's
probably not related to the VM but just that there was more going on on
the machine.

It's not necessarily wrong, but we don't currently have any tests that
verify the complete correctness of the decoding, so unless the commit
message explains why there should be a difference we shouldn't make any
changes.

  stress -c 4 &
  sudo perf record -e cs_etm// -a -m,16M -- sleep 3

  sudo perf-before-change script --itrace=i1000i > before
  sudo perf-after-change script --itrace=i1000i > after

  diff before after

  29d28
  <           stress    8198 [000]  1096.381602:       1000
instructions:      aaaaceb70f2c rand@plt+0xc (/usr/bin/stress)
  30a30
  >           stress    8198 [000]  1096.381602:       1000
instructions:      aaaaceb70f2c rand@plt+0xc (/usr/bin/stress)
  193d192
  <           stress    8200 [001]  1096.381602:       1000
instructions:      aaaaceb70f28 rand@plt+0x8 (/usr/bin/stress)
  194a194
  >           stress    8200 [001]  1096.381602:       1000
instructions:      aaaaceb70f28 rand@plt+0x8 (/usr/bin/stress)



> 
> Thanks and regards,
> Tanmay
>>
>> Thanks
>> James
>>
>>>
>>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>>> ---
>>>  tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
>>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index 91299cc56bf7..446e00d98fd5 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -1418,10 +1418,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>>  	sample.stream_id = etmq->etm->instructions_id;
>>>  	sample.period = period;
>>>  	sample.cpu = tidq->packet->cpu;
>>> -	sample.flags = tidq->prev_packet->flags;
>>>  	sample.cpumode = event->sample.header.misc;
>>>
>>> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>>> +	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet, &sample);
>>> +
>>> +	/* Populate branch target information only when we encounter
>>> +	 * branch instruction, which is at the end of tidq->prev_packet.
>>> +	 */
>>> +	if (addr == (tidq->prev_packet->end_addr - 4)) {
>>> +		/* Update the perf_sample flags using the prev_packet
>>> +		 * since that is the queue we are synthesizing.
>>> +		 */
>>> +		sample.flags = tidq->prev_packet->flags;
>>> +
>>> +		/* The last instruction of the previous queue would be a
>>> +		 * branch operation. Get the target of that branch by looking
>>> +		 * into the first executed instruction of the current packet
>>> +		 * queue.
>>> +		 */
>>> +		sample.addr = cs_etm__first_executed_instr(tidq->packet);
>>> +	}
>>>
>>>  	if (etm->synth_opts.last_branch)
>>>  		sample.branch_stack = tidq->last_branch;
>>> @@ -1641,7 +1657,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>>>  	/* Get instructions remainder from previous packet */
>>>  	instrs_prev = tidq->period_instructions;
>>>
>>> -	tidq->period_instructions += tidq->packet->instr_count;
>>> +	tidq->period_instructions += tidq->prev_packet->instr_count;
>>>
>>>  	/*
>>>  	 * Record a branch when the last instruction in
>>> @@ -1721,8 +1737,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>>>  			 * been executed, but PC has not advanced to next
>>>  			 * instruction)
>>>  			 */
>>> +			/* Get address from prev_packet since we are synthesizing
>>> +			 * that in cs_etm__synth_instruction_sample()
>>> +			 */
>>>  			addr = cs_etm__instr_addr(etmq, trace_chan_id,
>>> -						  tidq->packet, offset - 1);
>>> +						  tidq->prev_packet, offset - 1);
>>>  			ret = cs_etm__synth_instruction_sample(
>>>  				etmq, tidq, addr,
>>>  				etm->instructions_sample_period);
>>> @@ -1786,7 +1805,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>>>
>>>  	/* Handle start tracing packet */
>>>  	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
>>> -		goto swap_packet;
>>> +		goto reset_last_br;
>>>
>>>  	if (etmq->etm->synth_opts.last_branch &&
>>>  	    etmq->etm->synth_opts.instructions &&
>>> @@ -1822,8 +1841,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>>>  			return err;
>>>  	}
>>>
>>> -swap_packet:
>>> -	cs_etm__packet_swap(etm, tidq);
>>> +reset_last_br:
>>>
>>>  	/* Reset last branches after flush the trace */
>>>  	if (etm->synth_opts.last_branch)
