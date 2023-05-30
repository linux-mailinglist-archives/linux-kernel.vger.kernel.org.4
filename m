Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4C715A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjE3J0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjE3J0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:26:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B00C210DE;
        Tue, 30 May 2023 02:25:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58D462F4;
        Tue, 30 May 2023 02:25:29 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AEC03F663;
        Tue, 30 May 2023 02:24:41 -0700 (PDT)
Message-ID: <830d2a40-655d-7f16-a969-cadbe5b2a1c5@arm.com>
Date:   Tue, 30 May 2023 10:24:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] perf cs-etm: Track exception level
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
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
 <20230524131958.2139331-4-james.clark@arm.com>
 <CAJ9a7Vj99VVDC6Xjyg1cYza-nOk62xPKg7rA4b5XBcU5B=oWVw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7Vj99VVDC6Xjyg1cYza-nOk62xPKg7rA4b5XBcU5B=oWVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/2023 12:16, Mike Leach wrote:
> Hi James,
> 
> On Wed, 24 May 2023 at 14:20, James Clark <james.clark@arm.com> wrote:
>>
>> Currently we assume all trace belongs to the host machine so when
>> the decoder should be looking at the guest kernel maps it can crash
>> because it looks at the host ones instead.
>>
>> Avoid one scenario (guest kernel running at EL1) by assigning the
>> default guest machine to this trace. For userspace trace it's still not
>> possible to determine guest vs host, but the PIDs should help in this
>> case.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  7 +-
>>  tools/perf/util/cs-etm.c                      | 64 ++++++++++++++-----
>>  tools/perf/util/cs-etm.h                      |  5 +-
>>  3 files changed, 56 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index 82a27ab90c8b..ac227cd03eb0 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -573,12 +573,13 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>>                 break;
>>         }
>>
>> +       if (cs_etm__etmq_set_tid_el(etmq, tid, trace_chan_id,
>> +                                elem->context.exception_level))
>> +               return OCSD_RESP_FATAL_SYS_ERR;
>> +
>>         if (tid == -1)
>>                 return OCSD_RESP_CONT;
>>
>> -       if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
>> -               return OCSD_RESP_FATAL_SYS_ERR;
>> -
>>         /*
>>          * A timestamp is generated after a PE_CONTEXT element so make sure
>>          * to rely on that coming one.
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index a997fe79d458..b9ba19327f26 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/types.h>
>>  #include <linux/zalloc.h>
>>
>> -#include <opencsd/ocsd_if_types.h>
>>  #include <stdlib.h>
>>
>>  #include "auxtrace.h"
>> @@ -87,6 +86,8 @@ struct cs_etm_traceid_queue {
>>         union perf_event *event_buf;
>>         struct thread *thread;
>>         struct thread *prev_thread;
>> +       ocsd_ex_level prev_el;
>> +       ocsd_ex_level el;
>>         struct branch_stack *last_branch;
>>         struct branch_stack *last_branch_rb;
>>         struct cs_etm_packet *prev_packet;
>> @@ -479,6 +480,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>>
>>         queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
>>         tidq->trace_chan_id = trace_chan_id;
>> +       tidq->el = tidq->prev_el = ocsd_EL_unknown;
>>         tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
>>                                                queue->tid);
>>         tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
>> @@ -618,6 +620,7 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>>                 tmp = tidq->packet;
>>                 tidq->packet = tidq->prev_packet;
>>                 tidq->prev_packet = tmp;
>> +               tidq->prev_el = tidq->el;
>>                 thread__put(tidq->prev_thread);
>>                 tidq->prev_thread = thread__get(tidq->thread);
>>         }
>> @@ -879,11 +882,34 @@ static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
>>         return evsel->core.attr.type == aux->pmu_type;
>>  }
>>
>> -static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
>> +static struct machine *cs_etm__get_machine(struct cs_etm_auxtrace *etm,
>> +                                          ocsd_ex_level el)
>>  {
>> -       struct machine *machine;
>> +       /*
>> +        * Not perfect, but assume anything in EL1 is the default guest, and
>> +        * everything else is the host. nHVE and pKVM may not work with this
>> +        * assumption. And distinguishing between guest and host userspaces
>> +        * isn't currently supported either. Neither is multiple guest support.
>> +        * All this does is reduce the likeliness of decode errors where we look
>> +        * into the host kernel maps when it should have been the guest maps.
>> +        */
> 
> What effect does this have if I am running with host only, kernel at
> EL1, e.g. any platform that is not running an EL2 kernel?

I suppose I didn't think about that case. It looks like you'd have to
start using --guest-vmlinux instead of --vmlinux to decode. But that's
probably not what we want.

Is that a standard configuration though? I'm wondering if we need to
support that out of the box, or needing the extra command line argument
is ok? It seems like it's hard to make anything just work without the
user providing extra info.

After this change we also wanted to start setting exclude_guest=1 by
default, so technically this change is only needed when exclude_guest=0.
Otherwise we could assume it's always the host regardless of the EL. It
should be quite easy to check what that setting was in this switch
statement, but it would be temporarily broken in the mean time. And also
we can only make exclude_guest work with FEAT_TRF (v8.4 onwards)

> 
> Mike
> 
> 
>> +       switch (el) {
>> +       case ocsd_EL1:
>> +               return machines__find_guest(&etm->session->machines,
>> +                                           DEFAULT_GUEST_KERNEL_ID);
>> +       case ocsd_EL3:
>> +       case ocsd_EL2:
>> +       case ocsd_EL0:
>> +       case ocsd_EL_unknown:
>> +       default:
>> +               return &etm->session->machines.host;
>> +       }
>> +}
>>
>> -       machine = &etmq->etm->session->machines.host;
>> +static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
>> +                          ocsd_ex_level el)
>> +{
>> +       struct machine *machine = cs_etm__get_machine(etmq->etm, el);
>>
>>         if (address >= machine__kernel_start(machine)) {
>>                 if (machine__is_host(machine))
>> @@ -893,10 +919,14 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
>>         } else {
>>                 if (machine__is_host(machine))
>>                         return PERF_RECORD_MISC_USER;
>> -               else if (perf_guest)
>> +               else {
>> +                       /*
>> +                        * Can't really happen at the moment because
>> +                        * cs_etm__get_machine() will always return
>> +                        * machines.host for any non EL1 trace.
>> +                        */
>>                         return PERF_RECORD_MISC_GUEST_USER;
>> -               else
>> -                       return PERF_RECORD_MISC_HYPERVISOR;
>> +               }
>>         }
>>  }
>>
>> @@ -913,11 +943,12 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>>         if (!etmq)
>>                 return 0;
>>
>> -       cpumode = cs_etm__cpu_mode(etmq, address);
>>         tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
>>         if (!tidq)
>>                 return 0;
>>
>> +       cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
>> +
>>         if (!thread__find_map(tidq->thread, cpumode, address, &al))
>>                 return 0;
>>
>> @@ -1296,9 +1327,10 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
>>  }
>>
>>  static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
>> -                              struct cs_etm_traceid_queue *tidq, pid_t tid)
>> +                              struct cs_etm_traceid_queue *tidq, pid_t tid,
>> +                              ocsd_ex_level el)
>>  {
>> -       struct machine *machine = &etm->session->machines.host;
>> +       struct machine *machine = cs_etm__get_machine(etm, el);
>>
>>         if (tid != -1) {
>>                 thread__zput(tidq->thread);
>> @@ -1308,10 +1340,12 @@ static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
>>         /* Couldn't find a known thread */
>>         if (!tidq->thread)
>>                 tidq->thread = machine__idle_thread(machine);
>> +
>> +       tidq->el = el;
>>  }
>>
>> -int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>> -                        pid_t tid, u8 trace_chan_id)
>> +int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid, u8 trace_chan_id,
>> +                        ocsd_ex_level el)
>>  {
>>         struct cs_etm_traceid_queue *tidq;
>>
>> @@ -1319,7 +1353,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>>         if (!tidq)
>>                 return -EINVAL;
>>
>> -       cs_etm__set_thread(etmq->etm, tidq, tid);
>> +       cs_etm__set_thread(etmq->etm, tidq, tid, el);
>>         return 0;
>>  }
>>
>> @@ -1389,7 +1423,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>         struct perf_sample sample = {.ip = 0,};
>>
>>         event->sample.header.type = PERF_RECORD_SAMPLE;
>> -       event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
>> +       event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
>>         event->sample.header.size = sizeof(struct perf_event_header);
>>
>>         /* Set time field based on etm auxtrace config. */
>> @@ -1448,7 +1482,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>>         ip = cs_etm__last_executed_instr(tidq->prev_packet);
>>
>>         event->sample.header.type = PERF_RECORD_SAMPLE;
>> -       event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
>> +       event->sample.header.misc = cs_etm__cpu_mode(etmq, ip, tidq->prev_el);
>>         event->sample.header.size = sizeof(struct perf_event_header);
>>
>>         /* Set time field based on etm auxtrace config. */
>> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
>> index 70cac0375b34..88e9b25a8a9f 100644
>> --- a/tools/perf/util/cs-etm.h
>> +++ b/tools/perf/util/cs-etm.h
>> @@ -232,10 +232,11 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>>  struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
>>
>>  #ifdef HAVE_CSTRACE_SUPPORT
>> +#include <opencsd/ocsd_if_types.h>
>>  int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
>>  int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
>> -int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>> -                        pid_t tid, u8 trace_chan_id);
>> +int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid, u8 trace_chan_id,
>> +                        ocsd_ex_level el);
>>  bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
>>  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>>                                               u8 trace_chan_id);
>> --
>> 2.34.1
>>
> 
> 
