Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB5665332
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjAKFOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAKFNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:13:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11EA71A07B;
        Tue, 10 Jan 2023 21:06:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3A5DFEC;
        Tue, 10 Jan 2023 21:06:47 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5453F71A;
        Tue, 10 Jan 2023 21:06:01 -0800 (PST)
Message-ID: <97d1d6a1-13b2-e971-b0c4-1d71623ca1e3@arm.com>
Date:   Wed, 11 Jan 2023 10:35:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V7 0/6] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230105031039.207972-1-anshuman.khandual@arm.com>
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



On 1/5/23 08:40, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on v6.2-r2.
> 
> Changes in V7:
> 
> - Folded [PATCH 7/7] into [PATCH 3/7] which enables branch stack sampling event
> - Defined BRBFCR_EL1_BRANCH_FILTERS, BRBCR_EL1_DEFAULT_CONFIG in the header
> - Defined BRBFCR_EL1_DEFAULT_CONFIG in the header
> - Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_FZP
> - Defined BRBCR_EL1_DEFAULT_TS in the header
> - Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_DEFAULT_TS
> - Moved BRBCR_EL1_DEFAULT_CONFIG check inside branch_type_to_brbcr()
> - Moved down BRBCR_EL1_CC, BRBCR_EL1_MPRED later in branch_type_to_brbcr()
> - Also set BRBE in paused state in armv8pmu_branch_disable()
> - Dropped brbe_paused(), set_brbe_paused() helpers
> - Extracted error string via branch_filter_error_msg[] for armv8pmu_branch_valid()
> - Replaced brbe_v1p1 with brbe_version in struct brbe_hw_attr
> - Added valid_brbe_[cc, format, version]() helpers
> - Split a separate brbe_attributes_probe() from armv8pmu_branch_probe()
> - Capture event->attr.branch_sample_type earlier in armv8pmu_branch_valid()
> - Defined enum brbe_bank_idx with possible values for BRBE bank indices
> - Changed armpmu->hw_attr into armpmu->private
> - Added missing space in stub definition for armv8pmu_branch_valid()
> - Replaced both kmalloc() with kzalloc()
> - Added BRBE_BANK_MAX_ENTRIES
> - Updated comment for capture_brbe_flags()
> - Updated comment for struct brbe_hw_attr
> - Dropped space after type cast in couple of places
> - Replaced inverse with negation for testing BRBCR_EL1_FZP in armv8pmu_branch_read()
> - Captured cpuc->branches->branch_entries[idx] in a local variable
> - Dropped saved_priv from armv8pmu_branch_read()
> - Reorganize PERF_SAMPLE_BRANCH_NO_[CYCLES|NO_FLAGS] related configuration
> - Replaced with FIELD_GET() and FIELD_PREP() wherever applicable
> - Replaced BRBCR_EL1_TS_PHYSICAL with BRBCR_EL1_TS_VIRTUAL
> - Moved valid_brbe_nr(), valid_brbe_cc(), valid_brbe_format(), valid_brbe_version()
>   select_brbe_bank(), select_brbe_bank_index() helpers inside the C implementation
> - Reorganized brbe_valid_nr() and dropped the pr_warn() message
> - Changed probe sequence in brbe_attributes_probe()
> - Added 'brbcr' argument into capture_brbe_flags() to ascertain correct state
> - Disable BRBE before disabling the PMU event counter
> - Enable PERF_SAMPLE_BRANCH_HV filters when is_kernel_in_hyp_mode()
> - Guard armv8pmu_reset() & armv8pmu_sched_task() with arm_pmu_branch_stack_supported()

Gentle ping, any updates on this series ?
