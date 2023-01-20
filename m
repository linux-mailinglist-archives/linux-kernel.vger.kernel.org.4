Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0067F675446
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjATMTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATMTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:19:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30C238B303
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:19:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8363C14BF;
        Fri, 20 Jan 2023 04:20:16 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D379E3F71A;
        Fri, 20 Jan 2023 04:19:33 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: [GIT PULL]  cacheinfo/arch_topology: Updates for v6.3
Date:   Fri, 20 Jan 2023 12:18:56 +0000
Message-Id: <20230120121856.1407369-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull !

It has been tested on RISC-V which is the main users outside of arm64.
The ACPI the RISC-V parts are acked-by the respective maintainers. All
the changes are in the -next for sometime and no issues reported at this
time.

Regards,
Sudeep

-->8

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/archtopo-cacheinfo-updates-6.3

for you to fetch changes up to 198102c9103fc78d8478495971947af77edb05c1:

  cacheinfo: Fix shared_cpu_map to handle shared caches at different levels (2023-01-18 09:58:40 +0000)

----------------------------------------------------------------
cacheinfo and arch_topology updates for v6.3

The main change is to build the cache topology information for all
the CPUs from the primary CPU. Currently the cacheinfo for secondary CPUs
is created during the early boot on the respective CPU itself. Preemption
and interrupts are disabled at this stage. On PREEMPT_RT kernels, allocating
memory and even parsing the PPTT table for ACPI based systems triggers a:
  'BUG: sleeping function called from invalid context'

To prevent this bug, the cacheinfo is now allocated from the primary CPU
when preemption and interrupts are enabled and before booting secondary
CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
only, without relying on any architecture specific mechanism if done so
early.

The other minor change included here is to handle shared caches at
different levels when not all the CPUs on the system have the same
cache hierarchy.

----------------------------------------------------------------
Pierre Gondois (6):
      cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
      cacheinfo: Return error code in init_of_cache_level()
      cacheinfo: Check 'cache-unified' property to count cache leaves
      ACPI: PPTT: Remove acpi_find_cache_levels()
      ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
      arch_topology: Build cacheinfo from primary CPU

Yong-Xuan Wang (1):
      cacheinfo: Fix shared_cpu_map to handle shared caches at different levels

 arch/arm64/kernel/cacheinfo.c |  11 +--
 arch/riscv/kernel/cacheinfo.c |  42 -----------
 drivers/acpi/pptt.c           |  93 ++++++++++++++----------
 drivers/base/arch_topology.c  |  12 +++-
 drivers/base/cacheinfo.c      | 161 +++++++++++++++++++++++++++++++++++-------
 include/linux/cacheinfo.h     |  11 ++-
 6 files changed, 213 insertions(+), 117 deletions(-)
