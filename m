Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995CB648102
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLIKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLIKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:32:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CCBF6ACFC;
        Fri,  9 Dec 2022 02:32:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA1223A;
        Fri,  9 Dec 2022 02:32:34 -0800 (PST)
Received: from pierre123.arm.com (unknown [10.57.42.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF3663F73B;
        Fri,  9 Dec 2022 02:32:23 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     palmer@rivosinc.com, Ionela.Voinescu@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/5] arch_topology: Build cacheinfo from primary CPU
Date:   Fri,  9 Dec 2022 11:31:22 +0100
Message-Id: <20221209103130.572196-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 - Applied renaming/formatting comments from v1.
 - Check CACHE_TYPE_VALID flag in pppt.c.
v3:
 - Applied Sudeep's suggestions (for patch 5/5):
   - Renaming allocate_cache_info() -> fecth_cache_info()
   - Updated error message
   - Extract an inline allocate_cache_info() function
 - Re-run checkpatch with --strict option

Note:
This patchset requires the following patch to be applied first in
order to avoid the same bug described in the commit message:
https://lore.kernel.org/all/20221116094958.2141072-1-pierre.gondois@arm.com/

[1] and [2] build the CPU topology from the cacheinfo information for
both DT/ACPI based systems and remove (struct cpu_topology).llc_id
which was used by ACPI only.

Creating the cacheinfo for secondary CPUs is done during early boot.
Preemption and interrupts are disabled at this stage. On PREEMPT_RT
kernels, allocating memory (and parsing the PPTT table for ACPI based
systems) triggers a:
  'BUG: sleeping function called from invalid context' [4]

To prevent this bug, allocate the cacheinfo from the primary CPU when
preemption and interrupts are enabled and before booting secondary
CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
only, without relying on the arm64 CLIDR_EL1 register.
If no cache information is found in the DT/ACPI PPTT, then fallback
to the current state, triggering [4] on PREEMPT_RT kernels.

Patches to update the arm64 device trees that have incomplete cacheinfo
(mostly for missing the 'cache-level' or 'cache-unified' property)
have been sent at [3].

Tested platforms:
- ACPI + PPTT: Ampere Altra, Ampere eMAG, Cavium ThunderX2,
  Kunpeng 920, Juno-r2
- DT: rb5, db845c, Juno-r2

[1] https://lore.kernel.org/all/20220704101605.1318280-1-sudeep.holla@arm.com/
[2] https://lore.kernel.org/all/20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com/
[3] https://lore.kernel.org/all/20221107155825.1644604-1-pierre.gondois@arm.com/
[4] On an Ampere Altra, with PREEMPT_RT kernel based on v6.0.0-rc4:


[    7.560791] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[    7.560794] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
[    7.560796] preempt_count: 1, expected: 0
[    7.560797] RCU nest depth: 1, expected: 1
[    7.560799] 3 locks held by swapper/111/0:
[    7.560800]  #0: ffff403e406cae98 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
[    7.560811]  #1: ffffc5f8ed09f8e8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
[    7.560820]  #2: ffff403f400b4fd8 (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
[    7.560824] irq event stamp: 0
[    7.560825] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    7.560827] hardirqs last disabled at (0): [<ffffc5f8e9f7d594>] copy_process+0x5dc/0x1ab8
[    7.560830] softirqs last  enabled at (0): [<ffffc5f8e9f7d594>] copy_process+0x5dc/0x1ab8
[    7.560833] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    7.560834] Preemption disabled at:
[    7.560835] [<ffffc5f8e9fd3c28>] migrate_enable+0x30/0x130
[    7.560838] CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-[...]
[    7.560841] Call trace:
[...]
[    7.560870]  __kmalloc+0xbc/0x1e8
[    7.560873]  detect_cache_attributes+0x2d4/0x5f0
[    7.560876]  update_siblings_masks+0x30/0x368
[    7.560880]  store_cpu_topology+0x78/0xb8
[    7.560883]  secondary_start_kernel+0xd0/0x198
[    7.560885]  __secondary_switched+0xb0/0xb4

Pierre Gondois (5):
  cacheinfo: Use RISC-V's init_cache_level() as generic OF
    implementation
  cacheinfo: Return error code in init_of_cache_level()
  ACPI: PPTT: Remove acpi_find_cache_levels()
  ACPI: PPTT: Update acpi_find_last_cache_level() to
    acpi_get_cache_info()
  arch_topology: Build cacheinfo from primary CPU

 arch/arm64/kernel/cacheinfo.c |  11 ++--
 arch/riscv/kernel/cacheinfo.c |  39 +----------
 drivers/acpi/pptt.c           |  93 +++++++++++++++-----------
 drivers/base/arch_topology.c  |  12 +++-
 drivers/base/cacheinfo.c      | 119 +++++++++++++++++++++++++++++-----
 include/linux/cacheinfo.h     |  11 +++-
 6 files changed, 182 insertions(+), 103 deletions(-)

-- 
2.25.1

