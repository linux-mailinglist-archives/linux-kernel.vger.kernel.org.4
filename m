Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976E6B341A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCJCPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCJCOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:14:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2D1009ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:14:51 -0800 (PST)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PXqMG2kjBzKpx9;
        Fri, 10 Mar 2023 10:12:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 10 Mar
 2023 10:14:48 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <samuel@sholland.org>,
        <oleksandr_tyshchenko@epam.com>, <andy.shevchenko@gmail.com>,
        <apatel@ventanamicro.com>, <lvjianmin@loongson.cn>,
        <jason@lakedaemon.net>, <linux-kernel@vger.kernel.org>
CC:     <chris.zjh@huawei.com>, <liaochang1@huawei.com>
Subject: [RFC PATCH] genirq: introduce handle_fasteoi_edge_irq flow handler
Date:   Fri, 10 Mar 2023 10:14:17 +0000
Message-ID: <20230310101417.1081434-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, We have a LPI migration issue on the ARM SMP platform.

For example, NIC device generates MSI and sends LPI to CPU0 via ITS,
meanwhile irqbalance running on CPU1 set irq affinity of NIC to CPU1,
the next interrupt will be sent to CPU2, due to the state of irq is
still in progress, kernel does not end up performing irq handler on
CPU2, which results in some userland service timeouts, the sequence
of events is shown as follows:

NIC                     CPU0                    CPU1

Generate IRQ#1          READ_IAR
                        Lock irq_desc
                        Set IRQD_IN_PROGRESS
                        Unlock irq_desc
                                                Lock irq_desc
                                                Change LPI Affinity
                                                Unlock irq_desc
                        Call irq_handler
Generate IRQ#2
                                                READ_IAR
                                                Lock irq_desc
                                                Check IRQD_IN_PROGRESS
                                                Unlock irq_desc
                                                Return from interrupt#2
                        Lock irq_desc
                        Clear IRQD_IN_PROGRESS
                        Unlock irq_desc
                        return from interrupt#1

For this scenario, The IRQ#2 will be lost. This does cause some exceptions.

For further information, see [1].

This patch introduced a new flow handler which combines fasteoi and edge
type as a workaround.
An additional loop will be executed if the IRQS_PENDING has been setup.

[1]: https://lore.kernel.org/all/b0f2623b-ec70-d57e-b744-26c62b1ce523@huawei.com/

Fixes: cc2d3216f53c ("irqchip: GICv3: ITS command queue")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c |  2 +-
 include/linux/irq.h          |  1 +
 kernel/irq/chip.c            | 62 ++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd134e1f481a..625ec64f0218 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1456,7 +1456,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		if (!gic_dist_supports_lpis())
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
-				    handle_fasteoi_irq, NULL, NULL);
+				    handle_fasteoi_edge_irq, NULL, NULL);
 		break;
 
 	default:
diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1b28affb32a..adca5340edeb 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -656,6 +656,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
+extern void handle_fasteoi_edge_irq(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..bd3d346b468d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -677,6 +677,68 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 	}
 }
 
+/**
+ *	handle_fasteoi_edge_irq - irq handler for transparent controllers
+ *	edge type IRQ.
+ *	@desc:	the interrupt description structure for this irq
+ */
+void handle_fasteoi_edge_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip = desc->irq_data.chip;
+
+	raw_spin_lock(&desc->lock);
+
+	if (!irq_may_run(desc)) {
+		desc->istate |= IRQS_PENDING;
+		mask_irq(desc);
+		goto out;
+	}
+
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
+	/*
+	 * If its disabled or no action available
+	 * then mask it and get out of here:
+	 */
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
+		mask_irq(desc);
+		goto out;
+	}
+
+	kstat_incr_irqs_this_cpu(desc);
+
+	if (desc->istate & IRQS_ONESHOT)
+		mask_irq(desc);
+
+	do {
+		/*
+		 * When another irq arrived while we were handling
+		 * one, we could have masked the irq.
+		 * Reenable it, if it was not disabled in meantime.
+		 */
+		if (unlikely(desc->istate & IRQS_PENDING)) {
+			if (!irqd_irq_disabled(&desc->irq_data) &&
+			    irqd_irq_masked(&desc->irq_data))
+				unmask_irq(desc);
+		}
+
+		handle_irq_event(desc);
+
+	} while ((desc->istate & IRQS_PENDING) &&
+		 !irqd_irq_disabled(&desc->irq_data));
+
+	cond_unmask_eoi_irq(desc, chip);
+
+	raw_spin_unlock(&desc->lock);
+	return;
+out:
+	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
+		chip->irq_eoi(&desc->irq_data);
+	raw_spin_unlock(&desc->lock);
+}
+EXPORT_SYMBOL_GPL(handle_fasteoi_edge_irq);
+
 /**
  *	handle_fasteoi_irq - irq handler for transparent controllers
  *	@desc:	the interrupt description structure for this irq
-- 
2.34.1

