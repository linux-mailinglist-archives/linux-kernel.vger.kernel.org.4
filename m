Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115960067E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiJQF56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJQF5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:57:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ADFE56006;
        Sun, 16 Oct 2022 22:57:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7941A1042;
        Sun, 16 Oct 2022 22:57:51 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4114B3F7D8;
        Sun, 16 Oct 2022 22:57:39 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V4 0/7] arm64/perf: Enable branch stack sampling
Date:   Mon, 17 Oct 2022 11:27:06 +0530
Message-Id: <20221017055713.451092-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables perf branch stack sampling support on arm64 platform
via a new arch feature called Branch Record Buffer Extension (BRBE). All
relevant register definitions could be accessed here.

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers

This series applies on v6.1-rc1.

Changes in V4:

- Changed ../tools/sysreg declarations as suggested
- Set PERF_SAMPLE_BRANCH_STACK in data.sample_flags
- Dropped perfmon_capable() check in armpmu_event_init()
- s/pr_warn_once/pr_info in armpmu_event_init()
- Added brbe_format element into struct pmu_hw_events
- Changed v1p1 as brbe_v1p1 in struct pmu_hw_events
- Dropped pr_info() from arm64_pmu_brbe_probe(), solved LOCKDEP warning

Changes in V3:

https://lore.kernel.org/all/20220929075857.158358-1-anshuman.khandual@arm.com/

- Moved brbe_stack from the stack and now dynamically allocated
- Return PERF_BR_PRIV_UNKNOWN instead of -1 in brbe_fetch_perf_priv()
- Moved BRBIDR0, BRBCR, BRBFCR registers and fields into tools/sysreg
- Created dummy BRBINF_EL1 field definitions in tools/sysreg
- Dropped ARMPMU_EVT_PRIV framework which cached perfmon_capable()
- Both exception and exception return branche records are now captured
  only if the event has PERF_SAMPLE_BRANCH_KERNEL which would already
  been checked in generic perf via perf_allow_kernel()

Changes in V2:

https://lore.kernel.org/all/20220908051046.465307-1-anshuman.khandual@arm.com/

- Dropped branch sample filter helpers consolidation patch from this series 
- Added new hw_perf_event.flags element ARMPMU_EVT_PRIV to cache perfmon_capable()
- Use cached perfmon_capable() while configuring BRBE branch record filters

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/20220613100119.684673-1-anshuman.khandual@arm.com/

- Added CONFIG_PERF_EVENTS wrapper for all branch sample filter helpers
- Process new perf branch types via PERF_BR_EXTEND_ABI

Changes in RFC V2:

https://lore.kernel.org/linux-arm-kernel/20220412115455.293119-1-anshuman.khandual@arm.com/

- Added branch_sample_priv() while consolidating other branch sample filter helpers
- Changed all SYS_BRBXXXN_EL1 register definition encodings per Marc
- Changed the BRBE driver as per proposed BRBE related perf ABI changes (V5)
- Added documentation for struct arm_pmu changes, updated commit message
- Updated commit message for BRBE detection infrastructure patch
- PERF_SAMPLE_BRANCH_KERNEL gets checked during arm event init (outside the driver)
- Branch privilege state capture mechanism has now moved inside the driver

Changes in RFC V1:

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: James Clark <james.clark@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (7):
  arm64/perf: Add BRBE registers and fields
  arm64/perf: Update struct arm_pmu for BRBE
  arm64/perf: Update struct pmu_hw_events for BRBE
  driver/perf/arm_pmu_platform: Add support for BRBE attributes detection
  arm64/perf: Drive BRBE from perf event states
  arm64/perf: Add BRBE driver
  arm64/perf: Enable branch stack sampling

 arch/arm64/include/asm/sysreg.h | 103 ++++++++
 arch/arm64/kernel/perf_event.c  |  49 ++++
 arch/arm64/tools/sysreg         | 161 ++++++++++++
 drivers/perf/Kconfig            |  11 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/arm_pmu.c          |  66 ++++-
 drivers/perf/arm_pmu_brbe.c     | 441 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu_brbe.h     | 259 +++++++++++++++++++
 drivers/perf/arm_pmu_platform.c |  34 +++
 include/linux/perf/arm_pmu.h    |  68 +++++
 10 files changed, 1190 insertions(+), 3 deletions(-)
 create mode 100644 drivers/perf/arm_pmu_brbe.c
 create mode 100644 drivers/perf/arm_pmu_brbe.h

-- 
2.25.1

