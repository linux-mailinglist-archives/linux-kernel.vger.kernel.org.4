Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFB61E8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKGClk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKGClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:41:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B87A3634D;
        Sun,  6 Nov 2022 18:41:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D0D1FB;
        Sun,  6 Nov 2022 18:41:41 -0800 (PST)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456083F703;
        Sun,  6 Nov 2022 18:41:30 -0800 (PST)
Message-ID: <a3e223bb-fdfa-4acc-a2f0-c12cd585e1a6@arm.com>
Date:   Mon, 7 Nov 2022 08:11:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 6/7] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20221017055713.451092-1-anshuman.khandual@arm.com>
 <20221017055713.451092-7-anshuman.khandual@arm.com>
 <c5585dd1-4491-c48d-311d-ddc27aaa01a3@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c5585dd1-4491-c48d-311d-ddc27aaa01a3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 21:06, James Clark wrote:
> 
> On 17/10/2022 06:57, Anshuman Khandual wrote:
>> This adds a BRBE driver which implements all the required helper functions
>> for struct arm_pmu. Following functions are defined by this driver which
>> will configure, enable, capture, reset and disable BRBE buffer HW as and
>> when requested via perf branch stack sampling framework.
>>
>> - arm64_pmu_brbe_filter()
>> - arm64_pmu_brbe_enable()
>> - arm64_pmu_brbe_disable()
>> - arm64_pmu_brbe_read()
>> - arm64_pmu_brbe_probe()
>> - arm64_pmu_brbe_reset()
>> - arm64_pmu_brbe_supported()
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c |   8 +-
>>  drivers/perf/Kconfig           |  11 +
>>  drivers/perf/Makefile          |   1 +
>>  drivers/perf/arm_pmu_brbe.c    | 441 +++++++++++++++++++++++++++++++++
>>  drivers/perf/arm_pmu_brbe.h    | 259 +++++++++++++++++++
>>  include/linux/perf/arm_pmu.h   |  20 ++
>>  6 files changed, 739 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/perf/arm_pmu_brbe.c
>>  create mode 100644 drivers/perf/arm_pmu_brbe.h
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index 97db333d1208..85a3aaefc0fb 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -1034,31 +1034,37 @@ static int armv8pmu_filter_match(struct perf_event *event)
>>  
>>  static void armv8pmu_brbe_filter(struct pmu_hw_events *hw_event, struct perf_event *event)
>>  {
>> +	arm64_pmu_brbe_filter(hw_event, event);
>>  }
>>  
>>  static void armv8pmu_brbe_enable(struct pmu_hw_events *hw_event)
>>  {
>> +	arm64_pmu_brbe_enable(hw_event);
>>  }
>>  
>>  static void armv8pmu_brbe_disable(struct pmu_hw_events *hw_event)
>>  {
>> +	arm64_pmu_brbe_disable(hw_event);
>>  }
>>  
>>  static void armv8pmu_brbe_read(struct pmu_hw_events *hw_event, struct perf_event *event)
>>  {
>> +	arm64_pmu_brbe_read(hw_event, event);
>>  }
>>  
>>  static void armv8pmu_brbe_probe(struct pmu_hw_events *hw_event)
>>  {
>> +	arm64_pmu_brbe_probe(hw_event);
>>  }
>>  
>>  static void armv8pmu_brbe_reset(struct pmu_hw_events *hw_event)
>>  {
>> +	arm64_pmu_brbe_reset(hw_event);
>>  }
>>  
>>  static bool armv8pmu_brbe_supported(struct perf_event *event)
>>  {
>> -	return false;
>> +	return arm64_pmu_brbe_supported(event);
>>  }
>>  
>>  static void armv8pmu_reset(void *info)
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 341010f20b77..4efd0a77c5ff 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -190,6 +190,17 @@ config ALIBABA_UNCORE_DRW_PMU
>>  	  Support for Driveway PMU events monitoring on Yitian 710 DDR
>>  	  Sub-system.
>>  
>> +config ARM_BRBE_PMU
>> +	tristate "Enable support for Branch Record Buffer Extension (BRBE)"
> Hi Anshuman,
> 
> I get a few build errors if this is enabled as a module, and it's
> missing the module boilerplate stuff. I'm wondering if tristate is a
> mistake and it's supposed to be static only? Otherwise it probably needs
> a few different things fixing up.
> 
> It would be nice to have it as a module so it's easy to work on in the
> future.
> 
>> +	depends on ARM64 && ARM_PMU
>> +	default y
> Should this be default m?
> 

Right, "Tristate" here does not really make sense as ARM_BRBE_PMU is dependent
on base ARM_PMU, where as ARM_SPE is abstracted as a separate PMU in itself.
