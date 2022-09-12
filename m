Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891DC5B5DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiILPvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiILPvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:51:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EF0713D02
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:51:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 477DA113E;
        Mon, 12 Sep 2022 08:51:41 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.78.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 076EA3F73D;
        Mon, 12 Sep 2022 08:51:32 -0700 (PDT)
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
Subject: [PATCH v1 1/1] arm_pmu: acpi: Pre-allocate pmu structures
Date:   Mon, 12 Sep 2022 17:51:04 +0200
Message-Id: <20220912155105.1443303-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912155105.1443303-1-pierre.gondois@arm.com>
References: <20220912155105.1443303-1-pierre.gondois@arm.com>
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

On an Ampere Altra,
Running a preemp_rt kernel based on v5.19-rc3-rt4 on an Ampere Altra
triggers:
[   12.642389] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[   12.642402] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 24, name: cpuhp/0
[   12.642406] preempt_count: 0, expected: 0
[   12.642409] RCU nest depth: 0, expected: 0
[   12.642411] 3 locks held by cpuhp/0/24:
[   12.642414] #0: ffffd8a22c8870d0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun (linux/kernel/cpu.c:754)
[   12.642429] #1: ffffd8a22c887120 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun (linux/kernel/cpu.c:754)
[   12.642436] #2: ffff083e7f0d97b8 ((&c->lock)){+.+.}-{3:3}, at: ___slab_alloc (linux/mm/slub.c:2954)
[   12.642458] irq event stamp: 42
[   12.642460] hardirqs last enabled at (41): finish_task_switch (linux/./arch/arm64/include/asm/irqflags.h:35)
[   12.642471] hardirqs last disabled at (42): cpuhp_thread_fun (linux/kernel/cpu.c:776 (discriminator 1))
[   12.642476] softirqs last enabled at (0): copy_process (linux/./include/linux/lockdep.h:191)
[   12.642484] softirqs last disabled at (0): 0x0
[   12.642495] CPU: 0 PID: 24 Comm: cpuhp/0 Tainted: G        W         5.19.0-rc3-rt4-custom-piegon01-rt_0 #142
[   12.642500] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
[   12.642506] Call trace:
[   12.642508] dump_backtrace (linux/arch/arm64/kernel/stacktrace.c:200)
[   12.642514] show_stack (linux/arch/arm64/kernel/stacktrace.c:207)
[   12.642517] dump_stack_lvl (linux/lib/dump_stack.c:107)
[   12.642523] dump_stack (linux/lib/dump_stack.c:114)
[   12.642527] __might_resched (linux/kernel/sched/core.c:9929)
[   12.642531] rt_spin_lock (linux/kernel/locking/rtmutex.c:1732 (discriminator 4))
[   12.642536] ___slab_alloc (linux/mm/slub.c:2954)
[   12.642539] __slab_alloc.isra.0 (linux/mm/slub.c:3116)
[   12.642543] kmem_cache_alloc_trace (linux/mm/slub.c:3207)
[   12.642549] __armpmu_alloc (linux/./include/linux/slab.h:600)
[   12.642558] armpmu_alloc_atomic (linux/drivers/perf/arm_pmu.c:927)
[   12.642562] arm_pmu_acpi_cpu_starting (linux/drivers/perf/arm_pmu_acpi.c:204)
[   12.642568] cpuhp_invoke_callback (linux/kernel/cpu.c:192)
[   12.642571] cpuhp_thread_fun (linux/kernel/cpu.c:777 (discriminator 3))
[   12.642573] smpboot_thread_fn (linux/kernel/smpboot.c:164 (discriminator 3))
[   12.642580] kthread (linux/kernel/kthread.c:376)
[   12.642584] ret_from_fork (linux/arch/arm64/kernel/entry.S:868)

arm_pmu_acpi_cpu_starting() is called in the STARTING hotplug section,
which runs with interrupts disabled. To avoid allocating memory and
sleeping in this function, the pmu structures must be pre-allocated.

On ACPI systems, the count of PMUs is unknown until CPUs are
hotplugged, cf:
commit 0dc1a1851af1 ("arm_pmu: add armpmu_alloc_atomic()")

At most #PMU_IRQs pmu structures will be used and thus need to be
pre-allocated.
In arm_pmu_acpi_cpu_starting() subcalls, after checking the cpuid,
decide to use or re-use a pre-allocated pmu structure. Thus the
pre-allocated pmu struct can be seen as a pool.
When probing, search and free unused pmu structures.

Platforms used to test this patch:
- Juno-r2 (2 clusters: 2 big and 4 little CPUs) with 2 PMUs and
  one interrupt for each CPU
- Ampere Altra with 1 PMU and one interrupt for the 160 CPUs

Link: https://lore.kernel.org/all/20210810134127.1394269-2-valentin.schneider@arm.com
Reported-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/perf/arm_pmu.c       |  17 +-----
 drivers/perf/arm_pmu_acpi.c  | 114 ++++++++++++++++++++++++++++++-----
 include/linux/perf/arm_pmu.h |   1 -
 3 files changed, 103 insertions(+), 29 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 59d3980b8ca2..731e793dfef5 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -861,16 +861,16 @@ static void cpu_pmu_destroy(struct arm_pmu *cpu_pmu)
 					    &cpu_pmu->node);
 }
 
-static struct arm_pmu *__armpmu_alloc(gfp_t flags)
+struct arm_pmu *armpmu_alloc(void)
 {
 	struct arm_pmu *pmu;
 	int cpu;
 
-	pmu = kzalloc(sizeof(*pmu), flags);
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
 	if (!pmu)
 		goto out;
 
-	pmu->hw_events = alloc_percpu_gfp(struct pmu_hw_events, flags);
+	pmu->hw_events = alloc_percpu_gfp(struct pmu_hw_events, GFP_KERNEL);
 	if (!pmu->hw_events) {
 		pr_info("failed to allocate per-cpu PMU data.\n");
 		goto out_free_pmu;
@@ -916,17 +916,6 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 	return NULL;
 }
 
-struct arm_pmu *armpmu_alloc(void)
-{
-	return __armpmu_alloc(GFP_KERNEL);
-}
-
-struct arm_pmu *armpmu_alloc_atomic(void)
-{
-	return __armpmu_alloc(GFP_ATOMIC);
-}
-
-
 void armpmu_free(struct arm_pmu *pmu)
 {
 	free_percpu(pmu->hw_events);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 96ffadd654ff..599d8be78950 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -17,6 +17,8 @@
 
 static DEFINE_PER_CPU(struct arm_pmu *, probed_pmus);
 static DEFINE_PER_CPU(int, pmu_irqs);
+static unsigned int preallocated_pmus_count;
+static struct arm_pmu **preallocated_pmus;
 
 static int arm_pmu_acpi_register_irq(int cpu)
 {
@@ -187,30 +189,108 @@ static int arm_pmu_acpi_parse_irqs(void)
 	return err;
 }
 
+/* Count the number of different PMU IRQs for the input PMU. */
+static int count_pmu_irqs(struct arm_pmu *pmu)
+{
+	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
+	unsigned int num_irqs = 0;
+	int cpu, probed_cpu, irq;
+
+	for_each_cpu(cpu, &pmu->supported_cpus) {
+		irq = per_cpu(hw_events->irq, cpu);
+		for_each_cpu(probed_cpu, &pmu->supported_cpus) {
+			if (irq == per_cpu(hw_events->irq, probed_cpu)) {
+				if (probed_cpu == cpu)
+					num_irqs++;
+				break;
+			}
+		}
+	}
+
+	return num_irqs;
+}
+
+/*
+ * Count the number of different PMU IRQs across all the PMUs of the system
+ * to get an upper bound of the number of struct arm_pmu to pre-allocate.
+ */
+static int count_all_pmu_irqs(void)
+{
+	unsigned int num_irqs = 0;
+	int cpu, probed_cpu, irq;
+
+	for_each_possible_cpu(cpu) {
+		irq = per_cpu(pmu_irqs, cpu);
+		for_each_possible_cpu(probed_cpu) {
+			if (irq == per_cpu(pmu_irqs, probed_cpu)) {
+				if (probed_cpu == cpu)
+					num_irqs++;
+				break;
+			}
+		}
+	}
+
+	return num_irqs;
+}
+
+static unsigned int pmu_preallocate(void)
+{
+	unsigned int i, num_irqs = count_all_pmu_irqs();
+
+	preallocated_pmus = kcalloc(num_irqs, sizeof(*preallocated_pmus),
+					GFP_KERNEL);
+	if (!preallocated_pmus) {
+		pr_err("Failed to pre-allocate %d pmu struct\n", num_irqs);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
+		preallocated_pmus[i] = armpmu_alloc();
+		if (!preallocated_pmus[i])
+			return -ENOMEM;
+	}
+
+	preallocated_pmus_count = num_irqs;
+	return 0;
+}
+
 static struct arm_pmu *arm_pmu_acpi_find_alloc_pmu(void)
 {
 	unsigned long cpuid = read_cpuid_id();
 	struct arm_pmu *pmu;
-	int cpu;
+	unsigned int i;
 
-	for_each_possible_cpu(cpu) {
-		pmu = per_cpu(probed_pmus, cpu);
-		if (!pmu || pmu->acpi_cpuid != cpuid)
-			continue;
+	for (i = 0; i < preallocated_pmus_count; i++) {
+		pmu = preallocated_pmus[i];
 
-		return pmu;
+		if (!pmu->acpi_cpuid) {
+			pmu->acpi_cpuid = cpuid;
+			return pmu;
+		} else if (pmu->acpi_cpuid == cpuid)
+			return pmu;
 	}
 
-	pmu = armpmu_alloc_atomic();
-	if (!pmu) {
-		pr_warn("Unable to allocate PMU for CPU%d\n",
-			smp_processor_id());
-		return NULL;
-	}
+	pr_err("Unable to find pre-allocated PMU for CPU%d\n",
+		smp_processor_id());
+	return NULL;
+}
 
-	pmu->acpi_cpuid = cpuid;
+static void pmu_free_unused_preallocated(struct arm_pmu *pmu)
+{
+	int i, unused_num_irqs = count_pmu_irqs(pmu);
 
-	return pmu;
+	if (unused_num_irqs <= 1)
+		return;
+	else if (unused_num_irqs >= preallocated_pmus_count) {
+		pr_err("Trying to free %d pmu struct when %d are allocated\n",
+				unused_num_irqs, preallocated_pmus_count);
+		return;
+	}
+
+	unused_num_irqs--;
+	for (i = 0; i < unused_num_irqs; i++)
+		armpmu_free(preallocated_pmus[preallocated_pmus_count - i - 1]);
+	preallocated_pmus_count -= unused_num_irqs;
 }
 
 /*
@@ -311,6 +391,8 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 		if (!pmu || pmu->name)
 			continue;
 
+		pmu_free_unused_preallocated(pmu);
+
 		ret = init_fn(pmu);
 		if (ret == -ENODEV) {
 			/* PMU not handled by this driver, or not present */
@@ -351,6 +433,10 @@ static int arm_pmu_acpi_init(void)
 	if (ret)
 		return ret;
 
+	ret = pmu_preallocate();
+	if (ret)
+		return ret;
+
 	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_ACPI_STARTING,
 				"perf/arm/pmu_acpi:starting",
 				arm_pmu_acpi_cpu_starting, NULL);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 0407a38b470a..049908af3595 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -173,7 +173,6 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
-struct arm_pmu *armpmu_alloc_atomic(void);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
 int armpmu_request_irq(int irq, int cpu);
-- 
2.25.1

