Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458435B6C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiIMLik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIMLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:38:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4E082EF24;
        Tue, 13 Sep 2022 04:38:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAAE81063;
        Tue, 13 Sep 2022 04:38:43 -0700 (PDT)
Received: from [10.163.58.193] (unknown [10.163.58.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731DB3F71A;
        Tue, 13 Sep 2022 04:38:33 -0700 (PDT)
Message-ID: <ea242aea-0470-4eb8-fe44-03551dbbaaba@arm.com>
Date:   Tue, 13 Sep 2022 17:08:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 6/7] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, German Gomez <german.gomez@arm.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-7-anshuman.khandual@arm.com>
 <740298c9-0cae-251d-97b4-d2724399ba40@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <740298c9-0cae-251d-97b4-d2724399ba40@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/22 16:09, James Clark wrote:
> 
> 
> On 08/09/2022 06:10, Anshuman Khandual wrote:
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
>>  drivers/perf/arm_pmu_brbe.c    | 448 +++++++++++++++++++++++++++++++++
>>  drivers/perf/arm_pmu_brbe.h    | 259 +++++++++++++++++++
>>  include/linux/perf/arm_pmu.h   |  20 ++
>>  6 files changed, 746 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/perf/arm_pmu_brbe.c
>>  create mode 100644 drivers/perf/arm_pmu_brbe.h
>>
> [...]
>> +
>> +static int brbe_fetch_perf_priv(u64 brbinf)
>> +{
>> +       int brbe_el = brbe_fetch_el(brbinf);
>> +
>> +       switch (brbe_el) {
>> +       case BRBINF_EL_EL0:
>> +               return PERF_BR_PRIV_USER;
>> +       case BRBINF_EL_EL1:
>> +               return PERF_BR_PRIV_KERNEL;
>> +       case BRBINF_EL_EL2:
>> +               if (is_kernel_in_hyp_mode())
>> +                       return PERF_BR_PRIV_KERNEL;
>> +               return PERF_BR_PRIV_HV;
>> +       default:
>> +               pr_warn("unknown branch privilege captured\n");
>> +               return -1;
> 
> On V1 you said that you would change this to PERF_BR_PRIV_UNKNOWN, looks
> like that was dropped. Unless it didn't work out?

Seems like it just got dropped unintentionally. Yes, PERF_BR_PRIV_UNKNOWN
can be returned here instead of "-1", similar to brbe_fetch_perf_type()
which returns PERF_BR_UNKNOWN.
