Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B173DC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjFZKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFZKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:20:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AFF719F;
        Mon, 26 Jun 2023 03:20:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27F392F4;
        Mon, 26 Jun 2023 03:21:37 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D511D3F64C;
        Mon, 26 Jun 2023 03:20:50 -0700 (PDT)
Message-ID: <e60de124-ae61-c8a0-c012-ce6d4dabad10@arm.com>
Date:   Mon, 26 Jun 2023 11:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] perf: cs-etm: Fixes in instruction sample synthesis
Content-Language: en-US
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        areddy3@marvell.com, john.g.garry@oracle.com, will@kernel.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, irogers@google.com, adrian.hunter@intel.com,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>
References: <20230623182204.25199-1-tanmay@marvell.com>
 <20230623182204.25199-2-tanmay@marvell.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230623182204.25199-2-tanmay@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2023 19:22, Tanmay Jagdale wrote:
> The existing method of synthesizing instruction samples has the
> following issues:
> 1. Non-branch instructions have mnemonics of branch instructions.
> 2. Branch target address is missing.
> 
> Set the sample flags only when we reach the last instruction in
> the tidq (which would be a branch instruction) to solve issue 1).
> 
> To fix issue 2), start synthesizing the instructions from the
> previous packet (tidq->prev_packet) instead of current packet
> (tidq->packet). This way, it is easy to figure out the target
> address of the branch instruction in tidq->prev_packet which
> is the current packet's (tidq->packet) first executed instruction.
> 
> After the switch to processing the previous packet first, we no
> longer need to swap the packets during cs_etm__flush().

Hi Tanmay,

I think the fix for setting the right flags and instruction type makes
sense, but is it possible to do it without the change to swapping in
cs_etm__flush() or some of the other changes to
cs_etm__synth_instruction_sample()?

I'm seeing some differences in the output related to the PID that's
assigned to a sample and some of the addresses that aren't explained by
the commit message. Also there is no corresponding change to
cs_etm__synth_branch_sample(), which is also using prev_packet etc so
I'm wondering if that's correct now without the swap? That function gets
used with the default itrace options or itrace=b

For example if I run 'perf script --itrace=i100ns' and diff the output
before and after your change I see a difference even though branch and
instruction info isn't printed, so I wouldn't expect to see any changes.
This is on a systemwide recording of a system under load.

Thanks
James

> 
> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> ---
>  tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 91299cc56bf7..446e00d98fd5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1418,10 +1418,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	sample.stream_id = etmq->etm->instructions_id;
>  	sample.period = period;
>  	sample.cpu = tidq->packet->cpu;
> -	sample.flags = tidq->prev_packet->flags;
>  	sample.cpumode = event->sample.header.misc;
>  
> -	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> +	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet, &sample);
> +
> +	/* Populate branch target information only when we encounter
> +	 * branch instruction, which is at the end of tidq->prev_packet.
> +	 */
> +	if (addr == (tidq->prev_packet->end_addr - 4)) {
> +		/* Update the perf_sample flags using the prev_packet
> +		 * since that is the queue we are synthesizing.
> +		 */
> +		sample.flags = tidq->prev_packet->flags;
> +
> +		/* The last instruction of the previous queue would be a
> +		 * branch operation. Get the target of that branch by looking
> +		 * into the first executed instruction of the current packet
> +		 * queue.
> +		 */
> +		sample.addr = cs_etm__first_executed_instr(tidq->packet);
> +	}
>  
>  	if (etm->synth_opts.last_branch)
>  		sample.branch_stack = tidq->last_branch;
> @@ -1641,7 +1657,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  	/* Get instructions remainder from previous packet */
>  	instrs_prev = tidq->period_instructions;
>  
> -	tidq->period_instructions += tidq->packet->instr_count;
> +	tidq->period_instructions += tidq->prev_packet->instr_count;
>  
>  	/*
>  	 * Record a branch when the last instruction in
> @@ -1721,8 +1737,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  			 * been executed, but PC has not advanced to next
>  			 * instruction)
>  			 */
> +			/* Get address from prev_packet since we are synthesizing
> +			 * that in cs_etm__synth_instruction_sample()
> +			 */
>  			addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -						  tidq->packet, offset - 1);
> +						  tidq->prev_packet, offset - 1);
>  			ret = cs_etm__synth_instruction_sample(
>  				etmq, tidq, addr,
>  				etm->instructions_sample_period);
> @@ -1786,7 +1805,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  
>  	/* Handle start tracing packet */
>  	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
> -		goto swap_packet;
> +		goto reset_last_br;
>  
>  	if (etmq->etm->synth_opts.last_branch &&
>  	    etmq->etm->synth_opts.instructions &&
> @@ -1822,8 +1841,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>  			return err;
>  	}
>  
> -swap_packet:
> -	cs_etm__packet_swap(etm, tidq);
> +reset_last_br:
>  
>  	/* Reset last branches after flush the trace */
>  	if (etm->synth_opts.last_branch)
