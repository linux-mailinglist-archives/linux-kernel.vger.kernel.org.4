Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636A722C07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjFEP7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFEP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:59:41 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5099
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685980780; x=1717516780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uN+TvSK2cRTyeeOUI7T6vDwyC5LBuC2R/65rVF6ZRKo=;
  b=rvvB7tA6LuuLzToIisHXEyH/hTrBU3abA2KIYLM8bdnL5eaOKH+oki1s
   rr5kr0VXLbfZJXico9fv1YloZqcnXotgQrfgOwPHNzLHV1LqLDJX3D/UI
   8821ufj/dJNRphoeBYPvlriuctASkCsuRek1cqpcie8MozsURk9uqJHcG
   Y=;
X-IronPort-AV: E=Sophos;i="6.00,217,1681171200"; 
   d="scan'208";a="336859541"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 15:59:36 +0000
Received: from EX19D014EUC004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 2B74D40DA6;
        Mon,  5 Jun 2023 15:59:35 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.227) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Jun 2023 15:59:28 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>,
        Liao Chang <liaochang1@huawei.com>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
Subject: [PATCH v3 2/2] genirq: fasteoi supports resend on concurrent invoke
Date:   Mon, 5 Jun 2023 17:57:23 +0200
Message-ID: <20230605155723.2628097-2-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605155723.2628097-1-jgowans@amazon.com>
References: <20230605155723.2628097-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.227]
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... and enable that functionality for GIC-v3 only.

Update the generic handle_fasteoi_irq to cater for the case when the
next interrupt comes in while the previous handler is still running.
Currently when that happens the irq_may_run() early out causes the next
IRQ to be lost. Support marking the interrupt as pending when that
happens so that the interrupt can be resent just before
handle_fasteoi_irq returns.  This is largely inspired by
handle_edge_irq.

Generally it should not be possible for the next interrupt to arrive
while the previous handler is still running: the CPU will not preempt an
interrupt with another from the same source or same priority. However,
there is a race: if the interrupt affinity is changed while the previous
handler is running, then the next interrupt can arrive at a different
CPU while the previous handler is still running. In that case there will
be a concurrent invoke and the early out will be taken.

For example:

           CPU 0             |          CPU 1
-----------------------------|-----------------------------
interrupt start              |
  handle_fasteoi_irq         | set_affinity(CPU 1)
    handler                  |
    ...                      | interrupt start
    ...                      |   handle_fasteoi_irq -> early out
  handle_fasteoi_irq return  | interrupt end
interrupt end                |

This issue was observed specifically on an arm64 system with a GIC-v3
handling MSIs via LPI; GIC-v3 uses the handle_fasteoi_irq handler. The
issue is that the GIC-v3's physical LPIs do not have a global active
state. If LPIs had an active state, then it would not be able to be
retriggered until the first CPU had issued a deactivation. Without this
global active state, when the affinity is change the next interrupt can
be triggered on the new CPU while the old CPU is still running the
handler from the previous interrupt.

Implementation notes:

It is believed that it's NOT necessary to mask the interrupt in
handle_fasteoi_irq() the way that handle_edge_irq() does. This is
because handle_edge_irq() caters for controllers which are too simple to
gate interrupts from the same source, so the kernel explicitly masks the
interrupt if it re-occurs [0].

The resend on concurrent invoke logic is gated by a flag which the
interrupt controller can set if it's susceptible to this problem. It is
not desirable to resend unconditionally: a wake up source for example
has no need to be re-sent.

[0] https://lore.kernel.org/all/bf94a380-fadd-8c38-cc51-4b54711d84b3@huawei.com/

Suggested-by: Liao Chang <liaochang1@huawei.com>
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: KarimAllah Raslan <karahmed@amazon.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c |  2 ++
 include/linux/irq.h              | 13 +++++++++++++
 kernel/irq/chip.c                | 16 +++++++++++++++-
 kernel/irq/debugfs.c             |  2 ++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 586271b8aa39..d9becfe696f0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3574,6 +3574,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		irqd = irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
+		irqd_set_resend_when_in_progress(irqd);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
@@ -4512,6 +4513,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
 					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
+		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
 
 	if (err) {
diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1b28affb32a..b76cc90faebd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -223,6 +223,8 @@ struct irq_data {
  *				  irq_chip::irq_set_affinity() when deactivated.
  * IRQD_IRQ_ENABLED_ON_SUSPEND	- Interrupt is enabled on suspend by irq pm if
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
+ * RQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progress in which
+ *				  case it must be resent at the next available opportunity.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -249,6 +251,7 @@ enum {
 	IRQD_HANDLE_ENFORCE_IRQCTX	= (1 << 28),
 	IRQD_AFFINITY_ON_ACTIVATE	= (1 << 29),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= (1 << 30),
+	IRQD_RESEND_WHEN_IN_PROGRESS    = (1 << 31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -448,6 +451,16 @@ static inline bool irqd_affinity_on_activate(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_AFFINITY_ON_ACTIVATE;
 }
 
+static inline void irqd_set_resend_when_in_progress(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_RESEND_WHEN_IN_PROGRESS;
+}
+
+static inline bool irqd_needs_resend_when_in_progress(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..a531692ca62f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -692,8 +692,16 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	/*
+	 * When an affinity change races with IRQ delivery, the next interrupt
+	 * can arrive on the new CPU before the original CPU has completed
+	 * handling the previous one - it may need to be resent.
+	 */
+	if (!irq_may_run(desc)) {
+		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
+			desc->istate |= IRQS_PENDING;
 		goto out;
+	}
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
@@ -715,6 +723,12 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	cond_unmask_eoi_irq(desc, chip);
 
+	/*
+	 * When the race described above happens this will resend the interrupt.
+	 */
+	if (unlikely(desc->istate & IRQS_PENDING))
+		check_irq_resend(desc, false);
+
 	raw_spin_unlock(&desc->lock);
 	return;
 out:
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index bbcaac64038e..5971a66be034 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -133,6 +133,8 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_HANDLE_ENFORCE_IRQCTX),
 
 	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
+
+	BIT_MASK_DESCR(IRQD_RESEND_WHEN_IN_PROGRESS),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
-- 
2.25.1

