Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0357D6A77BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCAXiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjCAXiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:02 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896E712048
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713880; x=1709249880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=elKTscyLR7FY5NmvjkmQhnEbe/r3S/2u7x+nfhQMrvU=;
  b=i2Gz5+Gk6raZEHI3nT/mpotyDkHDlrTfR9iMvhRCAAMYDPx24s+FifsW
   FuOaDGNzzk8lR2L8GKMFSaZywPoanaTWYZVZnvYs6PXayBli7NR7XksAy
   i5KHTp3jjbD0gGoXgN0Koy0cKjC4DdnHO5tqheKiDVoDtPw8/lr9OpxAE
   //yHY5xZs/4juYFxOlEqQ9kF0ww8k9rRGGeiFzwG0vrVrvmDuCCwHgpvK
   KZTA7CZb7gUm/u8G8qeV1Sol4dycamKaYJb1jcNiMCrw+t+nH3RUWTyF+
   XMjEZB17bHWtTwveov1zsdmz1zxibmjSj+YD2qaaUM8pmBi58y6pWcEa1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818693"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826798"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826798"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:56 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 04/24] x86/apic/vector: Implement a local APIC NMI controller
Date:   Wed,  1 Mar 2023 15:47:33 -0800
Message-Id: <20230301234753.28582-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a separate local APIC NMI controller to handle NMIs apart from the
regular APIC management.

This controller will be used to handle the NMI vector of the HPET NMI
watchdog.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * Reworked patch "x86/apic/vector: Implement support for NMI delivery
   mode" into a separate local APIC NMI controller. (Thomas)

Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/apic/vector.c | 57 +++++++++++++++++++++++++++++++++++
 include/linux/irq.h           |  5 +++
 2 files changed, 62 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 633b442c8f84..a4cf041427cb 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -42,6 +42,7 @@ EXPORT_SYMBOL_GPL(x86_vector_domain);
 static DEFINE_RAW_SPINLOCK(vector_lock);
 static cpumask_var_t vector_searchmask;
 static struct irq_chip lapic_controller;
+static struct irq_chip lapic_nmi_controller;
 static struct irq_matrix *vector_matrix;
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct hlist_head, cleanup_list);
@@ -451,6 +452,10 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
 	trace_vector_activate(irqd->irq, apicd->is_managed,
 			      apicd->can_reserve, reserve);
 
+	/* NMI has a fixed vector. No vector management required */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return 0;
+
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	if (!apicd->can_reserve && !apicd->is_managed)
 		assign_irq_vector_any_locked(irqd);
@@ -472,6 +477,10 @@ static void vector_free_reserved_and_managed(struct irq_data *irqd)
 	trace_vector_teardown(irqd->irq, apicd->is_managed,
 			      apicd->has_reserved);
 
+	/* NMI has a fixed vector. No vector management required */
+	if (apicd->hw_irq_cfg.delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	if (apicd->has_reserved)
 		irq_matrix_remove_reserved(vector_matrix);
 	if (apicd->is_managed)
@@ -539,6 +548,10 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 	if (disable_apic)
 		return -ENXIO;
 
+	/* Only one IRQ per NMI */
+	if ((info->flags & X86_IRQ_ALLOC_AS_NMI) && nr_irqs != 1)
+		return -EINVAL;
+
 	/*
 	 * Catch any attempt to touch the cascade interrupt on a PIC
 	 * equipped system.
@@ -573,6 +586,25 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		/* Don't invoke affinity setter on deactivated interrupts */
 		irqd_set_affinity_on_activate(irqd);
 
+		if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
+			/*
+			 * NMIs have a fixed vector and need their own
+			 * interrupt chip so nothing can end up in the
+			 * regular local APIC management code except the
+			 * MSI message composing callback.
+			 */
+			apicd->hw_irq_cfg.delivery_mode = APIC_DELIVERY_MODE_NMI;
+			irqd->chip = &lapic_nmi_controller;
+			/*
+			 * Exclude NMIs from balancing. This cannot work with
+			 * the regular affinity mechanisms. The local APIC NMI
+			 * controller provides a set_affinity() callback for the
+			 * intended HPET NMI watchdog use case.
+			 */
+			irqd_set_no_balance(irqd);
+			return 0;
+		}
+
 		/*
 		 * A delivery mode may be specified in the interrupt allocation
 		 * info. If not, use the delivery mode of the APIC.
@@ -872,8 +904,27 @@ static int apic_set_affinity(struct irq_data *irqd,
 	return err ? err : IRQ_SET_MASK_OK;
 }
 
+static int apic_nmi_set_affinity(struct irq_data *irqd,
+				 const struct cpumask *dest, bool force)
+{
+	struct apic_chip_data *apicd = apic_chip_data(irqd);
+	static struct cpumask tmp_mask;
+	int cpu;
+
+	cpumask_and(&tmp_mask, dest, cpu_online_mask);
+	if (cpumask_empty(&tmp_mask))
+		return -ENODEV;
+
+	cpu = cpumask_first(&tmp_mask);
+	apicd->hw_irq_cfg.dest_apicid = apic->calc_dest_apicid(cpu);
+	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+}
+
 #else
 # define apic_set_affinity	NULL
+# define apic_nmi_set_affinity	NULL
 #endif
 
 static int apic_retrigger_irq(struct irq_data *irqd)
@@ -914,6 +965,12 @@ static struct irq_chip lapic_controller = {
 	.irq_retrigger		= apic_retrigger_irq,
 };
 
+static struct irq_chip lapic_nmi_controller = {
+	.name			= "APIC-NMI",
+	.irq_set_affinity	= apic_nmi_set_affinity,
+	.irq_compose_msi_msg	= x86_vector_msi_compose_msg,
+};
+
 #ifdef CONFIG_SMP
 
 static void free_moved_vector(struct apic_chip_data *apicd)
diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1b28affb32a..c8738b36e316 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -263,6 +263,11 @@ static inline bool irqd_is_per_cpu(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_PER_CPU;
 }
 
+static inline void irqd_set_no_balance(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_NO_BALANCING;
+}
+
 static inline bool irqd_can_balance(struct irq_data *d)
 {
 	return !(__irqd_to_state(d) & (IRQD_PER_CPU | IRQD_NO_BALANCING));
-- 
2.25.1

