Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33B74F157
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjGKOMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjGKOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:12:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D02512A;
        Tue, 11 Jul 2023 07:12:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33DC91FB;
        Tue, 11 Jul 2023 07:13:31 -0700 (PDT)
Received: from [10.57.30.34] (unknown [10.57.30.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559C13F740;
        Tue, 11 Jul 2023 07:12:46 -0700 (PDT)
Message-ID: <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
Date:   Tue, 11 Jul 2023 15:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, irogers@google.com
References: <20230710122138.1450930-1-james.clark@arm.com>
 <20230710122138.1450930-2-james.clark@arm.com>
 <e111d9ac-c4f6-c541-313b-7a3a6acfb5d2@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <e111d9ac-c4f6-c541-313b-7a3a6acfb5d2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2023 13:01, Anshuman Khandual wrote:
> 
> 
> On 7/10/23 17:51, James Clark wrote:
>> This capability gives us the ability to open PERF_TYPE_HARDWARE and
>> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
>> implementation is contained in the Perf core and tool code so no change
>> to the Arm PMU driver is needed.
>>
>> The following basic use case now results in Perf opening the event on
>> all PMUs rather than picking only one in an unpredictable way:
>>
>>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
>>
>>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
>>
>>          963279620      armv8_cortex_a57/cycles/                (99.19%)
>>          752745657      armv8_cortex_a53/cycles/                (94.80%)
>>
>> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")
>> Suggested-by: Ian Rogers <irogers@google.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 277e29fbd504..d8844a9461a2 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -875,8 +875,13 @@ struct arm_pmu *armpmu_alloc(void)
>>  		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
>>  		 * and we have taken ctx sharing into account (e.g. with our
>>  		 * pmu::filter callback and pmu::event_init group validation).
>> +		 *
>> +		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the legacy
> 
> s/legacy/generic ? These hardware events are still around.

True, I thought I saw it mentioned that way somewhere, but I can
probably just remove it altogether. PERF_TYPE_HARDWARE and
PERF_TYPE_HW_CACHE is enough.


> 
>> +		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
>> +		 * specific PMU.
>>  		 */
>> -		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
>> +		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
>> +				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
>>  	};
>>  
>>  	pmu->attr_groups[ARMPMU_ATTR_GROUP_COMMON] =
