Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9FE64810C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLIKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiLIKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:33:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C93F2DAB0;
        Fri,  9 Dec 2022 02:33:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC25923A;
        Fri,  9 Dec 2022 02:33:12 -0800 (PST)
Received: from pierre123.arm.com (unknown [10.57.42.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 139DD3F73B;
        Fri,  9 Dec 2022 02:33:01 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     palmer@rivosinc.com, Ionela.Voinescu@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 5/5] arch_topology: Build cacheinfo from primary CPU
Date:   Fri,  9 Dec 2022 11:31:27 +0100
Message-Id: <20221209103130.572196-6-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209103130.572196-1-pierre.gondois@arm.com>
References: <20221209103130.572196-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
in the CPU hotplug path")
adds a call to detect_cache_attributes() to populate the cacheinfo
before updating the siblings mask. detect_cache_attributes() allocates
memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
kernels, on secondary CPUs, this triggers a:
  'BUG: sleeping function called from invalid context' [1]
as the code is executed with preemption and interrupts disabled.

The primary CPU was previously storing the cache information using
the now removed (struct cpu_topology).llc_id:
commit 5b8dc787ce4a ("arch_topology: Drop LLC identifier stash from
the CPU topology")

allocate_cache_info() tries to build the cacheinfo from the primary
CPU prior secondary CPUs boot, if the DT/ACPI description
contains cache information.
If allocate_cache_info() fails, then fallback to the current state
for the cacheinfo allocation. [1] will be triggered in such case.

When unplugging a CPU, the cacheinfo memory cannot be freed. If it
was, then the memory would be allocated early by the re-plugged
CPU and would trigger [1].

Note that populate_cache_leaves() might be called multiple times
due to populate_leaves being moved up. This is required since
detect_cache_attributes() might be called with per_cpu_cacheinfo(cpu)
being allocated but not populated.

[1]:
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
[    7.560838] CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
[    7.560841] Call trace:
[...]
[    7.560870]  __kmalloc+0xbc/0x1e8
[    7.560873]  detect_cache_attributes+0x2d4/0x5f0
[    7.560876]  update_siblings_masks+0x30/0x368
[    7.560880]  store_cpu_topology+0x78/0xb8
[    7.560883]  secondary_start_kernel+0xd0/0x198
[    7.560885]  __secondary_switched+0xb0/0xb4

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/base/arch_topology.c | 12 +++++-
 drivers/base/cacheinfo.c     | 71 +++++++++++++++++++++++++++---------
 include/linux/cacheinfo.h    |  1 +
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7d6e6657ffa..b1c1dd38ab01 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -736,7 +736,7 @@ void update_siblings_masks(unsigned int cpuid)
 
 	ret = detect_cache_attributes(cpuid);
 	if (ret && ret != -ENOENT)
-		pr_info("Early cacheinfo failed, ret = %d\n", ret);
+		pr_info("Early cacheinfo allocation failed, ret = %d\n", ret);
 
 	/* update core and thread sibling masks */
 	for_each_online_cpu(cpu) {
@@ -825,7 +825,7 @@ __weak int __init parse_acpi_topology(void)
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
-	int ret;
+	int cpu, ret;
 
 	reset_cpu_topology();
 	ret = parse_acpi_topology();
@@ -840,6 +840,14 @@ void __init init_cpu_topology(void)
 		reset_cpu_topology();
 		return;
 	}
+
+	for_each_possible_cpu(cpu) {
+		ret = fetch_cache_info(cpu);
+		if (ret) {
+			pr_err("Early cacheinfo failed, ret = %d\n", ret);
+			break;
+		}
+	}
 }
 
 void store_cpu_topology(unsigned int cpuid)
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 6f6cd120c4f1..d8f71ee859d2 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -371,10 +371,6 @@ static void free_cache_attributes(unsigned int cpu)
 		return;
 
 	cache_shared_cpu_map_remove(cpu);
-
-	kfree(per_cpu_cacheinfo(cpu));
-	per_cpu_cacheinfo(cpu) = NULL;
-	cache_leaves(cpu) = 0;
 }
 
 int __weak init_cache_level(unsigned int cpu)
@@ -387,29 +383,71 @@ int __weak populate_cache_leaves(unsigned int cpu)
 	return -ENOENT;
 }
 
+static inline
+int allocate_cache_info(int cpu)
+{
+	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
+					 sizeof(struct cacheinfo), GFP_ATOMIC);
+	if (!per_cpu_cacheinfo(cpu)) {
+		cache_leaves(cpu) = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int fetch_cache_info(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci;
+	unsigned int levels, split_levels;
+	int ret;
+
+	if (acpi_disabled) {
+		ret = init_of_cache_level(cpu);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = acpi_get_cache_info(cpu, &levels, &split_levels);
+		if (ret < 0)
+			return ret;
+
+		this_cpu_ci = get_cpu_cacheinfo(cpu);
+		this_cpu_ci->num_levels = levels;
+		/*
+		 * This assumes that:
+		 * - there cannot be any split caches (data/instruction)
+		 *   above a unified cache
+		 * - data/instruction caches come by pair
+		 */
+		this_cpu_ci->num_leaves = levels + split_levels;
+	}
+	if (!cache_leaves(cpu))
+		return -ENOENT;
+
+	return allocate_cache_info(cpu);
+}
+
 int detect_cache_attributes(unsigned int cpu)
 {
 	int ret;
 
-	/* Since early detection of the cacheinfo is allowed via this
-	 * function and this also gets called as CPU hotplug callbacks via
-	 * cacheinfo_cpu_online, the initialisation can be skipped and only
-	 * CPU maps can be updated as the CPU online status would be update
-	 * if called via cacheinfo_cpu_online path.
+	/* Since early initialization/allocation of the cacheinfo is allowed
+	 * via fetch_cache_info() and this also gets called as CPU hotplug
+	 * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
+	 * as it will happen only once (the cacheinfo memory is never freed).
+	 * Just populate the cacheinfo.
 	 */
 	if (per_cpu_cacheinfo(cpu))
-		goto update_cpu_map;
+		goto populate_leaves;
 
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
-	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
-					 sizeof(struct cacheinfo), GFP_ATOMIC);
-	if (per_cpu_cacheinfo(cpu) == NULL) {
-		cache_leaves(cpu) = 0;
-		return -ENOMEM;
-	}
+	ret = allocate_cache_info(cpu);
+	if (ret)
+		return ret;
 
+populate_leaves:
 	/*
 	 * populate_cache_leaves() may completely setup the cache leaves and
 	 * shared_cpu_map or it may leave it partially setup.
@@ -418,7 +456,6 @@ int detect_cache_attributes(unsigned int cpu)
 	if (ret)
 		goto free_ci;
 
-update_cpu_map:
 	/*
 	 * For systems using DT for cache hierarchy, fw_token
 	 * and shared_cpu_map will be set up here only if they are
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 00d8e7f9d1c6..dfef57077cd0 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -85,6 +85,7 @@ int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
 bool last_level_cache_is_valid(unsigned int cpu);
 bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
+int fetch_cache_info(unsigned int cpu);
 int detect_cache_attributes(unsigned int cpu);
 #ifndef CONFIG_ACPI_PPTT
 /*
-- 
2.25.1

