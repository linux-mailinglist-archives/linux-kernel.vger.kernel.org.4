Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C885B6BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiIMKzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIMKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:55:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A509B1A38F;
        Tue, 13 Sep 2022 03:55:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1B11063;
        Tue, 13 Sep 2022 03:55:14 -0700 (PDT)
Received: from [10.57.77.29] (unknown [10.57.77.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4D373F71A;
        Tue, 13 Sep 2022 03:55:06 -0700 (PDT)
Message-ID: <e44d0bd6-7809-59db-0133-1c6c9ba8cd55@arm.com>
Date:   Tue, 13 Sep 2022 11:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 0/7] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220908051046.465307-1-anshuman.khandual@arm.com>
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



On 08/09/2022 06:10, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on v6.0-rc4 after the BRBE related perf ABI changes series
> (V7) that was posted earlier, and a branch sample filter helper patch.
> 
> https://lore.kernel.org/all/20220824044822.70230-1-anshuman.khandual@arm.com/
> 
> https://lore.kernel.org/all/20220906084414.396220-1-anshuman.khandual@arm.com/
> 
> Following issues have been resolved
> 
> - Jame's concerns regarding permission inadequacy related to perfmon_capable()
> - Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()

I don't see the resolution to this one. I'm not 100% sure of the code
path used for LBR, but I think you just need to take perf_allow_kernel()
into account somewhere to make this command have the same result with
BRBE. Is there any contention that the permissions shouldn't behave in
the same way across platforms? This is when perf_event_paranoid < 2:

Intel:

  $ perf record -j any -- ls

  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.014 MB perf.data (16 samples) ]

Arm:

  $ perf record -j any -- ls

  Error:
  No permission to enable cycles event.

> 
> Following issues remain inconclusive
> 
> - Rob's concerns regarding the series structure, arm_pmu callbacks based framework
> 
> Changes in V2:
> 
> - Dropped branch sample filter helpers consolidation patch from this series 
> - Added new hw_perf_event.flags element ARMPMU_EVT_PRIV to cache perfmon_capable()
> - Use cached perfmon_capable() while configuring BRBE branch record filters
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-arm-kernel/20220613100119.684673-1-anshuman.khandual@arm.com/
> 
> - Added CONFIG_PERF_EVENTS wrapper for all branch sample filter helpers
> - Process new perf branch types via PERF_BR_EXTEND_ABI
> 
> Changes in RFC V2:
> 
> https://lore.kernel.org/linux-arm-kernel/20220412115455.293119-1-anshuman.khandual@arm.com/
> 
> - Added branch_sample_priv() while consolidating other branch sample filter helpers
> - Changed all SYS_BRBXXXN_EL1 register definition encodings per Marc
> - Changed the BRBE driver as per proposed BRBE related perf ABI changes (V5)
> - Added documentation for struct arm_pmu changes, updated commit message
> - Updated commit message for BRBE detection infrastructure patch
> - PERF_SAMPLE_BRANCH_KERNEL gets checked during arm event init (outside the driver)
> - Branch privilege state capture mechanism has now moved inside the driver
> 
> Changes in RFC V1:
> 
> https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (7):
>   arm64/perf: Add register definitions for BRBE
>   arm64/perf: Update struct arm_pmu for BRBE
>   arm64/perf: Update struct pmu_hw_events for BRBE
>   driver/perf/arm_pmu_platform: Add support for BRBE attributes detection
>   arm64/perf: Drive BRBE from perf event states
>   arm64/perf: Add BRBE driver
>   arm64/perf: Enable branch stack sampling
> 
>  arch/arm64/include/asm/sysreg.h | 222 ++++++++++++++++
>  arch/arm64/kernel/perf_event.c  |  48 ++++
>  drivers/perf/Kconfig            |  11 +
>  drivers/perf/Makefile           |   1 +
>  drivers/perf/arm_pmu.c          |  82 +++++-
>  drivers/perf/arm_pmu_brbe.c     | 448 ++++++++++++++++++++++++++++++++
>  drivers/perf/arm_pmu_brbe.h     | 259 ++++++++++++++++++
>  drivers/perf/arm_pmu_platform.c |  34 +++
>  include/linux/perf/arm_pmu.h    |  67 +++++
>  9 files changed, 1169 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/perf/arm_pmu_brbe.c
>  create mode 100644 drivers/perf/arm_pmu_brbe.h
> 
