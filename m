Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEEB5B5DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiILPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiILPvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:51:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FE6111A3B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:51:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B655106F;
        Mon, 12 Sep 2022 08:51:38 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.78.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 006923F73D;
        Mon, 12 Sep 2022 08:51:29 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/1] arm_pmu: acpi: Pre-allocate pmu structures
Date:   Mon, 12 Sep 2022 17:51:03 +0200
Message-Id: <20220912155105.1443303-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleeping inside arm_pmu_acpi_cpu_starting() while running a preemp_rt
kernel was reported at [1], and a solution was suggested at [2].

It seems [2] doesn't work because of the following:
"""PREPARE: The callbacks are invoked on a control CPU before the
hotplugged CPU is started up or after the hotplugged CPU has died."""

Indeed the 'prepare' callbacks are executed on the control CPU and
this CPU cannot remotely read the cpuid (cf read_cpuid_id()) of the
other CPUs.

Another solution:
1. count the number of different PMU IRQs (#IRQs)
2. allocate #IRQs pmu structures. There is at most #IRQs PMUs
3. in arm_pmu_acpi_cpu_starting() subcalls, after checking the cpuid,
   decide to use or re-use a pre-allocated pmu structure.
   Thus the pre-allocated pmu struct can be seen as a pool and all
   the struct might not be used.
4. free the unused pmu structures when probing
is suggested in this patch.

Freeing the unused pmu structures (4.) could maybe be done in a
CPUHP_AP_ONLINE_DYN hotplug callback instead, but only one CPU is
needed to search/free unused pre-allocated pmu structures.


This bug is the last remaining among the ones reported at [1]:
- [SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
  Fixed with [3].
- [SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
  Fixed with [4].

[1] https://lore.kernel.org/all/20210810134127.1394269-2-valentin.schneider@arm.com
[2] https://lore.kernel.org/all/87y299oyyq.ffs@tglx
[3] https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/
[4 ]https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/

Pierre Gondois (1):
  arm_pmu: acpi: Pre-allocate pmu structures

 drivers/perf/arm_pmu.c       |  17 +-----
 drivers/perf/arm_pmu_acpi.c  | 114 ++++++++++++++++++++++++++++++-----
 include/linux/perf/arm_pmu.h |   1 -
 3 files changed, 103 insertions(+), 29 deletions(-)

-- 
2.25.1

