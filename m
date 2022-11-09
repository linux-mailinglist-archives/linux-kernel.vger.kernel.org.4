Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7005662226A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiKIDIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKIDIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:08:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56291704B;
        Tue,  8 Nov 2022 19:08:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 719F11FB;
        Tue,  8 Nov 2022 19:08:45 -0800 (PST)
Received: from [10.162.42.10] (unknown [10.162.42.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D633B3F73D;
        Tue,  8 Nov 2022 19:08:34 -0800 (PST)
Message-ID: <c0401131-e0b4-7a25-8590-58402acb1e5b@arm.com>
Date:   Wed, 9 Nov 2022 08:38:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 6/7] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221107062514.2851047-1-anshuman.khandual@arm.com>
 <20221107062514.2851047-7-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221107062514.2851047-7-anshuman.khandual@arm.com>
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

On 11/7/22 11:55, Anshuman Khandual wrote:
> +void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event)
> +{
> +	u64 brbinf;
> +	int idx;
> +
> +	if (brbe_disabled(cpuc))
> +		return;
> +
> +	set_brbe_paused();
> +	for (idx = 0; idx < cpuc->brbe_nr; idx++) {
> +		select_brbe_bank_index(idx);
> +		brbinf = get_brbinf_reg(idx);
> +		/*
> +		 * There are no valid entries anymore on the buffer.
> +		 * Abort the branch record processing to save some
> +		 * cycles and also reduce the capture/process load
> +		 * for the user space as well.
> +		 */
> +		if (brbe_invalid(brbinf))
> +			break;
> +
> +		if (brbe_valid(brbinf)) {
> +			cpuc->branches->brbe_entries[idx].from =  get_brbsrc_reg(idx);
> +			cpuc->branches->brbe_entries[idx].to =  get_brbtgt_reg(idx);
> +		} else if (brbe_source(brbinf)) {
> +			cpuc->branches->brbe_entries[idx].from =  get_brbsrc_reg(idx);
> +			cpuc->branches->brbe_entries[idx].to = 0;
> +		} else if (brbe_target(brbinf)) {
> +			cpuc->branches->brbe_entries[idx].from = 0;
> +			cpuc->branches->brbe_entries[idx].to =  get_brbtgt_reg(idx);
> +		}
> +		capture_brbe_flags(cpuc, event, brbinf, idx);
> +	}
> +	cpuc->branches->brbe_stack.nr = idx;
> +	cpuc->branches->brbe_stack.hw_idx = -1ULL;
> +	process_branch_aborts(cpuc);
> +}

The following additional changes are required to ensure that BRBE remains "un-paused" after
processing the branch records inside PMU interrupt handler. Without this change, there will
PMU interrupts without valid branch records, reducing branch stack sample collection during
given workload execution. I will fold this into the BRBE driver.

diff --git a/drivers/perf/arm_pmu_brbe.c b/drivers/perf/arm_pmu_brbe.c
index ce1aa4171481..c8154ddd341d 100644
--- a/drivers/perf/arm_pmu_brbe.c
+++ b/drivers/perf/arm_pmu_brbe.c
@@ -429,6 +429,7 @@ void arm64_pmu_brbe_read(struct pmu_hw_events *cpuc, struct perf_event *event)
        cpuc->branches->brbe_stack.nr = idx;
        cpuc->branches->brbe_stack.hw_idx = -1ULL;
        process_branch_aborts(cpuc);
+       clr_brbe_paused();
 }
 
 void arm64_pmu_brbe_reset(struct pmu_hw_events *cpuc)
diff --git a/drivers/perf/arm_pmu_brbe.h b/drivers/perf/arm_pmu_brbe.h
index 22c4b25b1777..33da6fc9aefa 100644
--- a/drivers/perf/arm_pmu_brbe.h
+++ b/drivers/perf/arm_pmu_brbe.h
@@ -257,3 +257,11 @@ static inline void set_brbe_paused(void)
        write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
        isb();
 }
+
+static inline void clr_brbe_paused(void)
+{
+       u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+
+       write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+       isb();
+}

For example:

./perf record -j any,u,k,save_type ls
./perf report -D | grep branch

Before this change -

# cat out | grep "branch stack: nr:64" | wc -l
4
# cat out | grep "branch stack: nr:0" | wc -l
57
# perf report -D | grep branch

... branch stack: nr:64
... branch stack: nr:0
... branch stack: nr:64
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:64
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:64
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0
... branch stack: nr:0

But after this change -

$ cat out | grep "branch stack: nr:64" | wc -l
107
# cat out | grep "branch stack: nr:0" | wc -l
0
$ perf report -D | grep branch

.......................

... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64
... branch stack: nr:64

.......................

- Anshuman
