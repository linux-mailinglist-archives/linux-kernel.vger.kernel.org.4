Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509365B5C17
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiILOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiILOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:19:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A78CC32070
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:19:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F09113E;
        Mon, 12 Sep 2022 07:19:24 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.78.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1F1BF3F73B;
        Mon, 12 Sep 2022 07:19:16 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2] irqchip/gic-v3-its: Remove cpumask_var_t allocation
Date:   Mon, 12 Sep 2022 16:18:57 +0200
Message-Id: <20220912141857.1391343-1-pierre.gondois@arm.com>
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

Running a preemp_rt kernel based on v5.19-rc3-rt4 on an Ampere Altra
triggers:
[   22.616229] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[   22.616239] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1884, name: kworker/80:1
[   22.616243] preempt_count: 3, expected: 0
[   22.616244] RCU nest depth: 0, expected: 0
[...]
[   22.616250] hardirqs last enabled at (33): _raw_spin_unlock_irq (/home/piegon01/linux/./arch/arm64/include/asm/irqflags.h:35)
[   22.616273] hardirqs last disabled at (34): __schedule (/home/piegon01/linux/kernel/sched/core.c:6432 (discriminator 1))
[   22.616283] softirqs last enabled at (0): copy_process (/home/piegon01/linux/./include/linux/lockdep.h:191)
[   22.616297] softirqs last disabled at (0): 0x0
[   22.616305] Preemption disabled at:
[   22.616307] __setup_irq (/home/piegon01/linux/kernel/irq/manage.c:1612)
[   22.616322] CPU: 80 PID: 1884 Comm: kworker/80:1 Tainted: G        W        [...]
[   22.616328] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
[   22.616333] Workqueue: events work_for_cpu_fn
[   22.616344] Call trace:
[...]
[   22.616403] alloc_cpumask_var_node (/home/piegon01/linux/lib/cpumask.c:115)
[   22.616414] alloc_cpumask_var (/home/piegon01/linux/lib/cpumask.c:147)
[   22.616417] its_select_cpu (/home/piegon01/linux/drivers/irqchip/irq-gic-v3-its.c:1580)
[   22.616428] its_set_affinity (/home/piegon01/linux/drivers/irqchip/irq-gic-v3-its.c:1659)
[   22.616431] msi_domain_set_affinity (/home/piegon01/linux/kernel/irq/msi.c:501)
[   22.616440] irq_do_set_affinity (/home/piegon01/linux/kernel/irq/manage.c:276)
[   22.616443] irq_setup_affinity (/home/piegon01/linux/kernel/irq/manage.c:633)
[   22.616447] irq_startup (/home/piegon01/linux/kernel/irq/chip.c:280)
[   22.616453] __setup_irq (/home/piegon01/linux/kernel/irq/manage.c:1777)

commit cba4235e6031e ("genirq: Remove mask argument from
setup_affinity()")
and
commit 11ea68f553e24 ("genirq, sched/isolation: Isolate from handling
managed interrupts")
overcome this issue by defining a static struct cpumask and protecting
it by a raw spinlock. The code in these commits is executed with IRQs
disabled.

its_select_cpu() can be executed with IRQs enabled or disabled.
Disabling IRQs with raw_spin_lock_irqsave() is necessary to avoid a:
'WARNING: possible irq lock inversion dependency detected'
[    2.935126]        CPU0                    CPU1
[    2.935126]        ----                    ----
[    2.935127]   lock(tmpmask_lock);
[    2.935129]                                local_irq_disable();
[    2.935129]                                lock(&irq_desc_lock_class);
[    2.935131]                                lock(tmp_mask_lock);
[    2.935133]   <Interrupt>
[    2.935133]     lock(&irq_desc_lock_class);
[...]
[    2.935446] ... key at: tmpmask_lock.56732+0x18/0x40
[    2.935451]    ... acquired at:
[    2.935452] _raw_spin_lock (linux/./include/linux/spinlock_api_smp.h:134)
[    2.935454] its_select_cpu (linux/drivers/irqchip/irq-gic-v3-its.c:1584)
[    2.935457] its_set_affinity (linux/drivers/irqchip/irq-gic-v3-its.c:1661)
[    2.935460] msi_domain_set_affinity (linux/kernel/irq/msi.c:501)
[    2.935463] irq_do_set_affinity (linux/kernel/irq/manage.c:276)
[    2.935468] irq_setup_affinity (linux/kernel/irq/manage.c:633)
[    2.935471] irq_startup (linux/kernel/irq/chip.c:280)
[    2.935473] __setup_irq (linux/kernel/irq/manage.c:1777)
[    2.935476] request_threaded_irq (linux/kernel/irq/manage.c:2206)
[...]
[    2.935592] ... key at: tmp_mask_lock.40873+0x18/0x40
[    2.935598]   ... acquired at:
[    2.935598] _raw_spin_lock (linux/./include/linux/spinlock_api_smp.h:134)
[    2.935600] irq_do_set_affinity (linux/./include/linux/irq.h:381)
[    2.935603] irq_startup (linux/kernel/irq/chip.c:273)
[    2.935605] __setup_irq (linux/kernel/irq/manage.c:1777)
[    2.935608] request_threaded_irq (linux/kernel/irq/manage.c:2206)
[...]
[    2.935812] ... key at: irq_desc_lock_class+0x0/0x10
[    2.935819]  ... acquired at:
[    2.935820] __lock_acquire (linux/kernel/locking/lockdep.c:4524)
[    2.935822] lock_acquire (linux/kernel/locking/lockdep.c:466)
[    2.935823] _raw_spin_lock (linux/./include/linux/spinlock_api_smp.h:134)
[    2.935825] handle_fasteoi_irq (linux/kernel/irq/chip.c:693)
[    2.935827] generic_handle_domain_irq (linux/kernel/irq/irqdesc.c:649)
[    2.935830] gic_handle_irq (linux/drivers/irqchip/irq-gic-v3.c:736)
[    2.935832] call_on_irq_stack (linux/arch/arm64/kernel/entry.S:902)
[    2.935834] do_interrupt_handler (linux/arch/arm64/kernel/entry-common.c:274)

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de6c48f..beead1a0191c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1574,13 +1574,15 @@ static int its_select_cpu(struct irq_data *d,
 			  const struct cpumask *aff_mask)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	cpumask_var_t tmpmask;
+	static DEFINE_RAW_SPINLOCK(tmpmask_lock);
+	static struct cpumask __tmpmask;
+	struct cpumask *tmpmask;
+	unsigned long flags;
 	int cpu, node;
-
-	if (!alloc_cpumask_var(&tmpmask, GFP_ATOMIC))
-		return -ENOMEM;
-
 	node = its_dev->its->numa_node;
+	tmpmask = &__tmpmask;
+
+	raw_spin_lock_irqsave(&tmpmask_lock, flags);
 
 	if (!irqd_affinity_is_managed(d)) {
 		/* First try the NUMA node */
@@ -1634,7 +1636,7 @@ static int its_select_cpu(struct irq_data *d,
 		cpu = cpumask_pick_least_loaded(d, tmpmask);
 	}
 out:
-	free_cpumask_var(tmpmask);
+	raw_spin_unlock_irqrestore(&tmpmask_lock, flags);
 
 	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
 	return cpu;
-- 
2.25.1

