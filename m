Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8297259DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbjFGJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239917AbjFGJOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:14:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E57711F;
        Wed,  7 Jun 2023 02:14:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EC72AB6;
        Wed,  7 Jun 2023 02:15:01 -0700 (PDT)
Received: from [10.57.25.143] (unknown [10.57.25.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732DE3F587;
        Wed,  7 Jun 2023 02:14:13 -0700 (PDT)
Message-ID: <9751fe01-a93a-176c-5280-67ae700468e0@arm.com>
Date:   Wed, 7 Jun 2023 10:14:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] perf cs-etm: Add exception level consistency check
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        denik@chromium.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
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
 <20230524131958.2139331-5-james.clark@arm.com>
 <CAJ9a7VioqoCTLOKmPPbS9ogs9n+2sV3szn-ZSDE3+mZTEgP0UQ@mail.gmail.com>
 <612885c1-b58f-5bce-59dc-bf84b057048d@arm.com>
 <CAJ9a7Vgi=309o+BxNW5YjukFoe+wuUp5oCmHfJHrASJfX2w6fw@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7Vgi=309o+BxNW5YjukFoe+wuUp5oCmHfJHrASJfX2w6fw@mail.gmail.com>
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



On 30/05/2023 11:40, Mike Leach wrote:
> Hi James,
> 
> Further thought here - this consistency check may be redundant.
> 
> You are setting the EL according to that in the traced context packet.
> This is correct and sufficient to match the EL that OpenCSD is
> expecting, if added to the security state from the same packet. The EL
> memory space values that OpenCSD provides in the memory callback are
> based on that same data from this context packet.
> Thus it is not necessary to use the EL in the memory callback. This is
> primarily used for matching when searching for a suitable memory
> source - especially when clients register files etc with the library,
> rather than provide a global callback as perf does.
> 
> Regards
> 

It was supposed to be defensive coding against some future refactor
where the Perf side tracking goes wrong. I think it makes sense to keep
it as it could be quite easy to make a mistake there and extra tests
can't be bad.

For ETMv3 I did have to make this change because OpenCSD was returning
the 'any' values so I made it skip the validation in that case:

	if (!(mem_space == OCSD_MEM_SPACE_ANY ||
	      mem_space == OCSD_MEM_SPACE_N ||
	      mem_space == OCSD_MEM_SPACE_S)) {
		if (mem_space & OCSD_MEM_SPACE_EL1N) {
			/* Includes both non secure EL1 and EL0 */
			assert(tidq->el == ocsd_EL1 || tidq->el == ocsd_EL0);
		} else if (mem_space & OCSD_MEM_SPACE_EL2)
			assert(tidq->el == ocsd_EL2);
		else if (mem_space & OCSD_MEM_SPACE_EL3)
			assert(tidq->el == ocsd_EL3);
	}


> Mike
> 
> 
> 
> On Tue, 30 May 2023 at 10:12, James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 25/05/2023 12:39, Mike Leach wrote:
>>> Hi James,
>>>
>>> My concern here is that for etmv3 trace, OpenCSD will only provide
>>> memory spaces as either secure or non-secure, The ETMv3 does not
>>> trace, and hence OpenCSD cannot provide the different ELs.
>>> The memory callback will be either OCSD_MEM_SPACE_S or OCSD_MEM_SPACE_N.
>>>
>>
>> As long as none of the bits are set for EL1-EL3 then no validation will
>> be done so it should be fine. But I will try to test ETMv3.
>>
>>> Can this patch - and the set handle this. (assuming perf supports our
>>> ETMv3 coresight kernel driver)
>>
>> For the whole set, the tracked EL will stay as ocsd_EL_unknown and
>> cs_etm__get_machine() will return host so the behavior will be unchanged
>> from before. This is assuming OpenCSD will set the EL to unknown in
>> elem->context.exception_level in this case.
>>
>>>
>>> Regards
>>>
>>> Mike
>>>
>>> On Wed, 24 May 2023 at 14:20, James Clark <james.clark@arm.com> wrote:
>>>>
>>>> Assert that our own tracking of the exception level matches what
>>>> OpenCSD provides. OpenCSD doesn't distinguish between EL0 and EL1 in the
>>>> memory access callback so the extra tracking was required. But a rough
>>>> assert can still be done.
>>>>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  6 +--
>>>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 +-
>>>>  tools/perf/util/cs-etm.c                      | 37 +++++++++++++------
>>>>  3 files changed, 32 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> index ac227cd03eb0..50b3c248d1e5 100644
>>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>>> @@ -52,15 +52,15 @@ struct cs_etm_decoder {
>>>>  static u32
>>>>  cs_etm_decoder__mem_access(const void *context,
>>>>                            const ocsd_vaddr_t address,
>>>> -                          const ocsd_mem_space_acc_t mem_space __maybe_unused,
>>>> +                          const ocsd_mem_space_acc_t mem_space,
>>>>                            const u8 trace_chan_id,
>>>>                            const u32 req_size,
>>>>                            u8 *buffer)
>>>>  {
>>>>         struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
>>>>
>>>> -       return decoder->mem_access(decoder->data, trace_chan_id,
>>>> -                                  address, req_size, buffer);
>>>> +       return decoder->mem_access(decoder->data, trace_chan_id, address,
>>>> +                                  req_size, buffer, mem_space);
>>>>  }
>>>>
>>>>  int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
>>>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> index 21d403f55d96..272c2efe78ee 100644
>>>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>>> @@ -11,6 +11,7 @@
>>>>  #define INCLUDE__CS_ETM_DECODER_H__
>>>>
>>>>  #include <linux/types.h>
>>>> +#include <opencsd/ocsd_if_types.h>
>>>>  #include <stdio.h>
>>>>
>>>>  struct cs_etm_decoder;
>>>> @@ -19,7 +20,8 @@ struct cs_etm_packet_queue;
>>>>
>>>>  struct cs_etm_queue;
>>>>
>>>> -typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *);
>>>> +typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *,
>>>> +                                 const ocsd_mem_space_acc_t);
>>>>
>>>>  struct cs_etmv3_trace_params {
>>>>         u32 reg_ctrl;
>>>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>>>> index b9ba19327f26..ccf34ed8ddf2 100644
>>>> --- a/tools/perf/util/cs-etm.c
>>>> +++ b/tools/perf/util/cs-etm.c
>>>> @@ -931,7 +931,8 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
>>>>  }
>>>>
>>>>  static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>>> -                             u64 address, size_t size, u8 *buffer)
>>>> +                             u64 address, size_t size, u8 *buffer,
>>>> +                             const ocsd_mem_space_acc_t mem_space)
>>>>  {
>>>>         u8  cpumode;
>>>>         u64 offset;
>>>> @@ -947,6 +948,20 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>>>         if (!tidq)
>>>>                 return 0;
>>>>
>>>> +       /*
>>>> +        * We've already tracked EL along side the PID in cs_etm__set_thread()
>>>> +        * so double check that it matches what OpenCSD thinks as well. It
>>>> +        * doesn't distinguish between EL0 and EL1 for this mem access callback
>>>> +        * so we had to do the extra tracking.
>>>> +        */
>>>> +       if (mem_space & OCSD_MEM_SPACE_EL1N) {
>>>> +               /* Includes both non secure EL1 and EL0 */
>>>> +               assert(tidq->el == ocsd_EL1 || tidq->el == ocsd_EL0);
>>>> +       } else if (mem_space & OCSD_MEM_SPACE_EL2)
>>>> +               assert(tidq->el == ocsd_EL2);
>>>> +       else if (mem_space & OCSD_MEM_SPACE_EL3)
>>>> +               assert(tidq->el == ocsd_EL3);
>>>> +
>>>>         cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
>>>>
>>>>         if (!thread__find_map(tidq->thread, cpumode, address, &al))
>>>> @@ -1195,8 +1210,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>>>>  {
>>>>         u8 instrBytes[2];
>>>>
>>>> -       cs_etm__mem_access(etmq, trace_chan_id, addr,
>>>> -                          ARRAY_SIZE(instrBytes), instrBytes);
>>>> +       cs_etm__mem_access(etmq, trace_chan_id, addr, ARRAY_SIZE(instrBytes),
>>>> +                          instrBytes, 0);
>>>>         /*
>>>>          * T32 instruction size is indicated by bits[15:11] of the first
>>>>          * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
>>>> @@ -1387,8 +1402,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>>>>         else
>>>>                 sample->insn_len = 4;
>>>>
>>>> -       cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
>>>> -                          sample->insn_len, (void *)sample->insn);
>>>> +       cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
>>>> +                          (void *)sample->insn, 0);
>>>>  }
>>>>
>>>>  u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
>>>> @@ -1940,8 +1955,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>>>                  * so below only read 2 bytes as instruction size for T32.
>>>>                  */
>>>>                 addr = end_addr - 2;
>>>> -               cs_etm__mem_access(etmq, trace_chan_id, addr,
>>>> -                                  sizeof(instr16), (u8 *)&instr16);
>>>> +               cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr16),
>>>> +                                  (u8 *)&instr16, 0);
>>>>                 if ((instr16 & 0xFF00) == 0xDF00)
>>>>                         return true;
>>>>
>>>> @@ -1956,8 +1971,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>>>                  * +---------+---------+-------------------------+
>>>>                  */
>>>>                 addr = end_addr - 4;
>>>> -               cs_etm__mem_access(etmq, trace_chan_id, addr,
>>>> -                                  sizeof(instr32), (u8 *)&instr32);
>>>> +               cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
>>>> +                                  (u8 *)&instr32, 0);
>>>>                 if ((instr32 & 0x0F000000) == 0x0F000000 &&
>>>>                     (instr32 & 0xF0000000) != 0xF0000000)
>>>>                         return true;
>>>> @@ -1973,8 +1988,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>>>                  * +-----------------------+---------+-----------+
>>>>                  */
>>>>                 addr = end_addr - 4;
>>>> -               cs_etm__mem_access(etmq, trace_chan_id, addr,
>>>> -                                  sizeof(instr32), (u8 *)&instr32);
>>>> +               cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
>>>> +                                  (u8 *)&instr32, 0);
>>>>                 if ((instr32 & 0xFFE0001F) == 0xd4000001)
>>>>                         return true;
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>>
> 
> 
> 
