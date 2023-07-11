Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF874F11D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjGKOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjGKOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:05:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00C6510F6;
        Tue, 11 Jul 2023 07:05:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D381FB;
        Tue, 11 Jul 2023 07:05:45 -0700 (PDT)
Received: from [10.57.30.34] (unknown [10.57.30.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5C733F740;
        Tue, 11 Jul 2023 07:05:00 -0700 (PDT)
Message-ID: <95506174-546c-9bf7-82af-09058550be6d@arm.com>
Date:   Tue, 11 Jul 2023 15:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] arm_pmu: Remove unused
 PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
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
 <20230710122138.1450930-4-james.clark@arm.com>
 <86792ab2-864a-5c27-95c1-54c4057024db@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <86792ab2-864a-5c27-95c1-54c4057024db@arm.com>
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



On 11/07/2023 13:08, Anshuman Khandual wrote:
> 
> 
> On 7/10/23 17:51, James Clark wrote:
>> Since commit bd2756811766 ("perf: Rewrite core context handling") the
>> relationship between perf_event_context and PMUs has changed so that
>> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
>> silenced no longer exists.
>>
>> Remove the capability and associated comment to avoid confusion that it
>> actually influences any perf core behavior. This change should be a
>> no-op.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  drivers/perf/arm_pmu.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index d8844a9461a2..297906df6628 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -872,15 +872,12 @@ struct arm_pmu *armpmu_alloc(void)
>>  		.attr_groups	= pmu->attr_groups,
>>  		/*
>>  		 * This is a CPU PMU potentially in a heterogeneous
>> -		 * configuration (e.g. big.LITTLE). This is not an uncore PMU,
>> -		 * and we have taken ctx sharing into account (e.g. with our
>> -		 * pmu::filter callback and pmu::event_init group validation).
>> -		 *
>> +		 * configuration (e.g. big.LITTLE) so
>>  		 * PERF_PMU_CAP_EXTENDED_HW_TYPE is required to open the legacy
>>  		 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE events on a
>>  		 * specific PMU.
>>  		 */
>> -		.capabilities	= PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS |
>> +		.capabilities	= PERF_PMU_CAP_EXTENDED_REGS |
>>  				  PERF_PMU_CAP_EXTENDED_HW_TYPE,
> 
> Small nit, the second line could be folded back into the first one.

.clang-format has a column limit of 80 which is why it gets folded. The
kernel coding style guide also still says 80 is a strongly preferred
limit so I'll probably leave it.

> 
>>  	};
>>  
