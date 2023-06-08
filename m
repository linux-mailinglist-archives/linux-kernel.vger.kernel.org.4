Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D3727B87
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjFHJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbjFHJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:34:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 876CC2129;
        Thu,  8 Jun 2023 02:34:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1EE1AB6;
        Thu,  8 Jun 2023 02:35:31 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8F53F71E;
        Thu,  8 Jun 2023 02:34:43 -0700 (PDT)
Message-ID: <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
Date:   Thu, 8 Jun 2023 10:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230524131958.2139331-1-james.clark@arm.com>
 <20230524131958.2139331-3-james.clark@arm.com>
 <20230527090635.GB886420@leoy-yangtze.lan>
 <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
In-Reply-To: <630ab636-107d-4b12-5454-2ee91ad43543@arm.com>
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



On 30/05/2023 15:28, James Clark wrote:
> 
> 
> On 27/05/2023 10:06, Leo Yan wrote:
>> On Wed, May 24, 2023 at 02:19:56PM +0100, James Clark wrote:
>>> Branch samples currently use the IP of the previous packet as the from
>>> IP, and the IP of the current packet as the to IP. But it incorrectly
>>> uses the current thread. In some cases like a jump into a different
>>> exception level this will attribute to the incorrect process.
>>
>> It's about the timing that branch has taken or not taken :)
>>
>> If we think the branch sample as 'branch has taken', then current code
>> is doning right thing, otherwise, we need this fix.
>>
> 
> If you diff the outputs side by side you can see it mainly has an effect
> where there is a discontinuity. At this point we set either the from or
> the to IPs to 0.
> 
> For example here is a before and after perf script output. Without the
> change it looks like stress was running before it actually was. The
> schedule function that was attributed to ls on the first line hasn't
> finished running yet. But it's attributed to stress on the second line
> even though the destination IP is 0 meaning we don't even know where it
> went.
> 
> Before:
> 
>     ls  8350 [006] ... __schedule+0x394 => schedule+0x5c
> stress  8357 [006] ... schedule+0x84 => 0 [unknown]
> stress  8357 [006] ... 0 [unknown] => __unix_dgram_recvmsg+0x130
> 
> After:
> 
>     ls  8350 [006] ... __schedule+0x394 => schedule+0x5c
>     ls  8357 [006] ... schedule+0x84 => 0 [unknown]
> stress  8357 [006] ... 0 [unknown] => __unix_dgram_recvmsg+0x130
> 
> I didn't see any decode differences that weren't around these
> discontinuity points, so it seems like a low risk change.
> 
>>> Fix it by tracking the previous thread in the same way the previous
>>> packet is tracked.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>  tools/perf/util/cs-etm.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>> index ebffc9052561..a997fe79d458 100644
>>> --- a/tools/perf/util/cs-etm.c
>>> +++ b/tools/perf/util/cs-etm.c
>>> @@ -86,6 +86,7 @@ struct cs_etm_traceid_queue {
>>>  	size_t last_branch_pos;
>>>  	union perf_event *event_buf;
>>>  	struct thread *thread;
>>> +	struct thread *prev_thread;
>>>  	struct branch_stack *last_branch;
>>>  	struct branch_stack *last_branch_rb;
>>>  	struct cs_etm_packet *prev_packet;
>>> @@ -480,6 +481,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>>>  	tidq->trace_chan_id = trace_chan_id;
>>>  	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
>>>  					       queue->tid);
>>> +	tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
>>>  
>>>  	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
>>>  	if (!tidq->packet)
>>> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>>>  		tmp = tidq->packet;
>>>  		tidq->packet = tidq->prev_packet;
>>>  		tidq->prev_packet = tmp;
>>> +		thread__put(tidq->prev_thread);
>>> +		tidq->prev_thread = thread__get(tidq->thread);
>>
>> Maybe cs_etm__packet_swap() is not the best place to update
>> "tidq->prev_thread", since swapping packet doesn't mean it's necessarily
>> thread switching; can we move this change into the cs_etm__set_thread()?
>>
> 
> Yeah that might make more sense. I can move it there if we decide to
> keep this change.
> 

Unfortunately I don't think I can make this change. It seems like
putting the previous thread swap in  cs_etm__set_thread() has different
semantics to keeping all the swaps together in cs_etm__packet_swap().

This is because if you swap the thread in cs_etm__packet_swap() the
previous packet and next packet can have the _same_ thread if there
happened to be no change. However if you only swap previous thread in
cs_etm__set_thread(), that means that the previous thread is always
different to the next one. This has a huge difference on the decoding
because two adjacent packets on the same thread will say they branched
from the previous thread that ran, not the previous thread on the
previous packet.

>> Thanks,
>> Leo
>>
>>>  	}
>>>  }
>>>  
>>> @@ -791,6 +795,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>>>  		/* Free this traceid_queue from the array */
>>>  		tidq = etmq->traceid_queues[idx];
>>>  		thread__zput(tidq->thread);
>>> +		thread__zput(tidq->prev_thread);
>>>  		zfree(&tidq->event_buf);
>>>  		zfree(&tidq->last_branch);
>>>  		zfree(&tidq->last_branch_rb);
>>> @@ -1450,8 +1455,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>>>  	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
>>>  
>>>  	sample.ip = ip;
>>> -	sample.pid = tidq->thread->pid_;
>>> -	sample.tid = tidq->thread->tid;
>>> +	sample.pid = tidq->prev_thread->pid_;
>>> +	sample.tid = tidq->prev_thread->tid;
>>>  	sample.addr = cs_etm__first_executed_instr(tidq->packet);
>>>  	sample.id = etmq->etm->branches_id;
>>>  	sample.stream_id = etmq->etm->branches_id;
>>> -- 
>>> 2.34.1
>>>
