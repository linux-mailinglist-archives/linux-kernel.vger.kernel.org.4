Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAD5B7F91
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiINDjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiINDjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:39:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA84B6DFB7;
        Tue, 13 Sep 2022 20:39:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30F2F1BB2;
        Tue, 13 Sep 2022 20:39:24 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AE753F73D;
        Tue, 13 Sep 2022 20:39:13 -0700 (PDT)
Message-ID: <c4800957-825c-a5c7-d8d4-946d9c6cdf6c@arm.com>
Date:   Wed, 14 Sep 2022 09:09:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 3/7] arm64/perf: Update struct pmu_hw_events for BRBE
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-4-anshuman.khandual@arm.com>
 <Yx8GBq1FJN49iJs9@sirena.org.uk>
 <84683aa7-58ad-85f8-327b-daed2f704834@arm.com>
 <YyBs1PJwNoNYv4NJ@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <YyBs1PJwNoNYv4NJ@sirena.org.uk>
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



On 9/13/22 17:13, Mark Brown wrote:
> On Tue, Sep 13, 2022 at 11:03:45AM +0530, Anshuman Khandual wrote:
>> On 9/12/22 15:42, Mark Brown wrote:
> 
>>> like it would be clearer and safer to allocate these dynamically
>>> when BRBE is used if that's possible, I'd expect that should also
>>> deal with the stack frame size issues as well.
> 
>> That might not be possible because the generic 'struct perf_branch_stack'
>> expects 'perf_branch_stack.entries' to be a variable array which is also
>> contiguous in memory, with other elements in 'perf_branch_stack'. Besides
>> that will be a deviation from similar implementations on x86 and powerpc
>> platforms.
> 
>> The stack frame size came up because BRBE_MAX_ENTRIES is 64 compared to
>> just 32 on other platforms, which follow the exact same method.
> 
> If this is a pattern used by other architectures and relied on by
> the core that doesn't mean it's impossible to do anything, it
> means that the existing code needs to be updated to allow the
> larger number of entries for BRBE if we want to change things.
> That is a lot of effort of course so something that moves the
> allocation off the stack would be more expedient in the short
> term.

Something like the following change moves the buffer allocation off the stack,
although it requires updating the driver, and buffer assignment during a PMU
interrupt. But it does seem to work (will require some more testing).

diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 3e7757d05146..a3401122d855 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -52,6 +52,12 @@ static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_PRIV) == ARMPMU_EVT_PRIV);
  */
 #define BRBE_MAX_ENTRIES 64
 
+/* Captured BRBE buffer - copied as is into perf_sample_data */
+struct brbe_records {
+       struct perf_branch_stack        brbe_stack;
+       struct perf_branch_entry        brbe_entries[BRBE_MAX_ENTRIES];
+};
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
        /*
@@ -92,9 +98,7 @@ struct pmu_hw_events {
        unsigned int                    brbe_users;
        void                            *brbe_context;
 
-       /* Captured BRBE buffer - copied as is into perf_sample_data */
-       struct perf_branch_stack        brbe_stack;
-       struct perf_branch_entry        brbe_entries[BRBE_MAX_ENTRIES];
+       struct brbe_records             *branch_records;
 };
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 05848c6d955c..2f0957519307 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -951,6 +951,13 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
                goto out_free_pmu;
        }
 
+       for_each_possible_cpu(cpu) {
+               struct pmu_hw_events *events = per_cpu_ptr(pmu->hw_events, cpu);
+
+               events->branch_records = kmalloc(sizeof(struct brbe_records), flags);
+               WARN_ON(!events->branch_records);
+       }
