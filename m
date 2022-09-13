Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363E5B6DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiIMMxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIMMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:53:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522A052FE1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:53:18 -0700 (PDT)
Date:   Tue, 13 Sep 2022 12:53:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663073596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqfrfXkRsHRGYHXOUlBuFZR2vK07mCJqOIjJUh0k/zw=;
        b=YsKLvizRQ4VBK7pWti8ayVZMA/L2cpZe75wry2a6N4psJ3e1/aXO6qh7J/sgZpDO7a07l0
        Wp0Lo+MC0bZO0g/pTn9aefgseZF0l30oeBFWTkSNlAiFWV54+yRv/S/zFigMjEzrr/MZkp
        Fmf95CwJQs49WLj3NrYO/RLoxSs7xpikNrtarwU3U43Zt1aa01GlaiAvd7WwPlAjfbZMZi
        gol/pjlFKRaTr990Afe55t1GrUJYG6fIEtVz+zltPu1dbDfagUN7zohZn/jXAa6KoarLJW
        HrvrOdVYXE6swFHmjtTXygjhiJDg8tYa/cfxV1eeRzIY/VKawF+yGT5U4S4naA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663073596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqfrfXkRsHRGYHXOUlBuFZR2vK07mCJqOIjJUh0k/zw=;
        b=hhSE7OGTA/pxgzTM7L9YnlRnsbGA5zyXMaJlBDe7M1fPVXWYObY+LOXmqrpuRNW+WXRjIl
        bynqHAAlLCbo1gCQ==
From:   "irqchip-bot for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3-its: Remove cpumask_var_t
 allocation
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220912141857.1391343-1-pierre.gondois@arm.com>
References: <20220912141857.1391343-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Message-ID: <166307359572.401.12623325354964031028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     f55a9b59e8f06e034368aeb48625359194e41f0e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f55a9b59e8f06e034368aeb48625359194e41f0e
Author:        Pierre Gondois <pierre.gondois@arm.com>
AuthorDate:    Mon, 12 Sep 2022 16:18:57 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 12 Sep 2022 16:37:43 +01:00

irqchip/gic-v3-its: Remove cpumask_var_t allocation

Running a PREEMPT_RT kernel based on v5.19-rc3-rt4 on an Ampere Altra
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

Follow the pattern established in commit cba4235e6031e ("genirq: Remove
mask argument from setup_affinity()") and co to overcome this issue by
defining a static struct cpumask and protecting it by a raw spinlock.

Since its_select_cpu() can be executed with IRQs enabled or disabled,
enforce that the cpumask computation is done with interrupts disabled.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220912141857.1391343-1-pierre.gondois@arm.com
---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5ff09de..beead1a 100644
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
