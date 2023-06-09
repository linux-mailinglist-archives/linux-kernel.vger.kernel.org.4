Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E227297AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbjFILA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbjFILAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:00:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BF6A210C;
        Fri,  9 Jun 2023 04:00:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F394AB6;
        Fri,  9 Jun 2023 04:01:16 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BE693F587;
        Fri,  9 Jun 2023 04:00:28 -0700 (PDT)
Message-ID: <2e075792-7af8-209b-082b-48d687387463@arm.com>
Date:   Fri, 9 Jun 2023 12:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
Content-Language: en-US
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
 <1e7aa657-6d1e-9e7c-95cb-b32d307abe93@arm.com>
 <20230608102555.GB123723@leoy-huanghe>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230608102555.GB123723@leoy-huanghe>
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



On 08/06/2023 11:25, Leo Yan wrote:
> On Thu, Jun 08, 2023 at 10:34:42AM +0100, James Clark wrote:
> 
> [...]
> 
>>>>> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>>>>>  		tmp = tidq->packet;
>>>>>  		tidq->packet = tidq->prev_packet;
>>>>>  		tidq->prev_packet = tmp;
>>>>> +		thread__put(tidq->prev_thread);
>>>>> +		tidq->prev_thread = thread__get(tidq->thread);
>>>>
>>>> Maybe cs_etm__packet_swap() is not the best place to update
>>>> "tidq->prev_thread", since swapping packet doesn't mean it's necessarily
>>>> thread switching; can we move this change into the cs_etm__set_thread()?
>>>>
>>>
>>> Yeah that might make more sense. I can move it there if we decide to
>>> keep this change.
>>>
>>
>> Unfortunately I don't think I can make this change. It seems like
>> putting the previous thread swap in  cs_etm__set_thread() has different
>> semantics to keeping all the swaps together in cs_etm__packet_swap().
> 
> Thanks for trying this.
> 
>> This is because if you swap the thread in cs_etm__packet_swap() the
>> previous packet and next packet can have the _same_ thread if there
>> happened to be no change. However if you only swap previous thread in
>> cs_etm__set_thread(), that means that the previous thread is always
>> different to the next one. This has a huge difference on the decoding
>> because two adjacent packets on the same thread will say they branched
>> from the previous thread that ran, not the previous thread on the
>> previous packet.
> 
> Seems to me, this is a synchronization issue between the field
> 'tidq->prev_thread' and 'tidq->prev_packet'.
> 
> It's still hard for me to understand "two adjacent packets on the same
> thread will say they branched from the previous thread that ran", IIUC,
> even we move thread swapping into cs_etm__set_thread(), if the two
> adjacent packets are in the same thread context, we can skip to update
> fields 'tidq->prev_thread' and 'tidq->prev_packet'.
> 
> So I am curious if below cs_etm__set_thread() works or not?
> 
> static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
> 			       struct cs_etm_traceid_queue *tidq, pid_t tid)
> {
> 	struct machine *machine = &etm->session->machines.host;
> 
> 	/* No context switching, bail out */
> 	if ((tidq->thread->tid != tid)
> 		return;
> 
> 	/* If tid is -1, we simply use idle thread context */
> 	if (tid == -1)
> 		goto find_idle_thread;
> 
> 	/*
> 	 * The new incoming tid is different from current thread,
> 	 * so it's to switch to the next thread context.
> 	 */
> 
> 	/* Swap thread contexts */
> 	thread__put(tidq->prev_thread);
> 	tidq->prev_thread = thread__get(tidq->thread);
> 
> 	/* Find thread context for new tid */
> 	thread__zput(tidq->thread);
> 	tidq->thread = machine__find_thread(machine, -1, tid);
> 
> find_idle_thread:
> 	/* Couldn't find a known thread */
> 	if (!tidq->thread)
> 		tidq->thread = machine__idle_thread(machine);
> }
> 

I tried this change but I still don't think it's giving the right
results. Tracking previous thread in cs_etm__set_thread() changes the
semantics of being "the thread for the previous packet" to being "the
previous different thread of an unknown old packet". If you imagine the
packets and thread changes are like this (where <d> is a discontinuity
packet):

    <--thread 1--> <--thread 2-------------------> <------thread 3-->
<d> <--packet 1--> <d> <--packet 2--> <packet 3--> <d> <--packet 4-->

Branches are generated using the last IP of the previous packet, and the
first IP of the next packet, ignoring everything in between as they are
just sequential instructions.

So assuming there are discontinuity packets between the thread switches
we should get:

  thread 1 branches from packet 1 to 0x0
  thread 2 branches from 0x0 to packet 2
  thread 2 branches from packet 2 to packet 3
  thread 2 branches from packet 3 to 0x0
  thread 3 branches from 0x0 to packet 4

By tracking the previous thread for each packet, packet 2 and 3 stay in
thread 2.

If we track the previous thread instead, then both packet 2 and 3 would
continue to look like they branch from thread 1 like this:

  thread ? branches from packet 1 to 0x0
  thread 1 branches from 0x0 to packet 2
  thread 1 branches from packet 2 to packet 3
  thread 1 branches from packet 3 to 0x0
  thread 2 branches from 0x0 to packet 4

Everything gets shifted back by 1 thread. I don't see the issue of
keeping all the swap stuff together in one place. Maybe there is an
issue with the naming of prev_thread? It's not really the previous
thread, it's the previous _packets_ thread. It might be the same thread
as the current one if there was no switch:

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ca01109c3fc4..f3c73c86010a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -86,8 +86,8 @@ struct cs_etm_traceid_queue {
        size_t last_branch_pos;
        union perf_event *event_buf;
        struct thread *thread;
-       struct thread *prev_thread;
-       ocsd_ex_level prev_el;
+       struct thread *prev_packet_thread;
+       ocsd_ex_level prev_packet_el;
        ocsd_ex_level el;
        struct branch_stack *last_branch;

> Thanks,
> Leo
