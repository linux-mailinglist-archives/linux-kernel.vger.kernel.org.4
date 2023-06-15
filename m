Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDF731107
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbjFOHli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbjFOHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:40:27 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1652953;
        Thu, 15 Jun 2023 00:39:59 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A1B84000F;
        Thu, 15 Jun 2023 07:38:27 +0000 (UTC)
Message-ID: <4c511218-eb54-0ec4-6820-265f06d91730@ghiti.fr>
Date:   Thu, 15 Jun 2023 09:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/10] drivers: perf: Implement perf event mmap support
 in the legacy backend
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-7-alexghiti@rivosinc.com>
 <20230531-705f2911e8d66938ece04905@orel>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230531-705f2911e8d66938ece04905@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/2023 16:27, Andrew Jones wrote:
> On Fri, May 12, 2023 at 10:53:17AM +0200, Alexandre Ghiti wrote:
>> Implement the needed callbacks in the legacy driver so that we can
>> directly access the counters through perf in userspace.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu_legacy.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
>> index ffe09d857366..f0f5bd856f66 100644
>> --- a/drivers/perf/riscv_pmu_legacy.c
>> +++ b/drivers/perf/riscv_pmu_legacy.c
>> @@ -74,6 +74,31 @@ static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
>>   	local64_set(&hwc->prev_count, initial_val);
>>   }
>>   
>> +static uint8_t pmu_legacy_csr_index(struct perf_event *event)
>> +{
>> +	return event->hw.idx;
>> +}
>> +
>> +static void pmu_legacy_event_mapped(struct perf_event *event, struct mm_struct *mm)
>> +{
>> +	/* In legacy mode, the first 3 CSRs are available. */
> Shouldn't this be
>
>   /* In legacy mode, the first and third CSR are available. */
>
> ?


Yes, I guess this comment is not right in this context, so I'll remove 
the comment entirely as it does bring much.


>> +	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
>> +	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
>> +		return;
>> +
>> +	event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
>> +}
>> +
>> +static void pmu_legacy_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>> +{
>> +	/* In legacy mode, the first 3 CSRs are available. */
> same comment
>
>> +	if (event->attr.config != PERF_COUNT_HW_CPU_CYCLES &&
>> +	    event->attr.config != PERF_COUNT_HW_INSTRUCTIONS)
>> +		return;
>> +
>> +	event->hw.flags &= ~PERF_EVENT_FLAG_USER_READ_CNT;
>> +}
>> +
>>   /*
>>    * This is just a simple implementation to allow legacy implementations
>>    * compatible with new RISC-V PMU driver framework.
>> @@ -94,6 +119,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>>   	pmu->ctr_get_width = NULL;
>>   	pmu->ctr_clear_idx = NULL;
>>   	pmu->ctr_read = pmu_legacy_read_ctr;
>> +	pmu->event_mapped = pmu_legacy_event_mapped;
>> +	pmu->event_unmapped = pmu_legacy_event_unmapped;
>> +	pmu->csr_index = pmu_legacy_csr_index;
>>   
>>   	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
>>   }
>> -- 
>> 2.37.2
>>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


Thanks!

