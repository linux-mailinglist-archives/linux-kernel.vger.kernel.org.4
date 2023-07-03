Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F55746325
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGCTAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGCTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:00:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79CAF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:00:29 -0700 (PDT)
Date:   Mon, 03 Jul 2023 19:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688410828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ktIvteAh2Lu3P6dnQy0b8CeOancpHay9/2ZaeGc3ms=;
        b=AAYiyDQhKlYNkahxuAK9qC4mIqLN7KSH+784hH6CDKpgV+mpyLg0CYP58J7T1aqoVpftt5
        fMMG6B5J4I68zUKpFueaUF7qvN0EyuCYOBZVqdLU5W5emQHvTO8/gurEFQjuNirzuIVkJw
        EcGVc3SDDcCGcg1+oXOMNPLfLXaqnfFu/0s9a4KmyF7wOqPh43KLht9IYooErGn2Zdv83h
        nWOr4f/g89ctTMQZnB6ZpTHuZ7+kKifwYvtQ174jbRCaf2P3nH+uqRfOMy2+sQDNxv1vdj
        c3E0UOaM44XvrO2/+Rh1zwkdQh+3/9uQe/6Youk+YOwqFyaH02o7uNsXYGdchw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688410828;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ktIvteAh2Lu3P6dnQy0b8CeOancpHay9/2ZaeGc3ms=;
        b=DUKSK8EWcUGbY83C46f4k23d1dQVh0RxiH6VwIaMBY3BRnWyb1h/GjfQACLJv6sXfCmB9d
        YlnGBlZeWM8RMUDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v4.1: Properly lock VPEs
 when doing a directLPI invalidation
Cc:     Kunkun Jiang <jiangkunkun@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, wanghaibin.wang@huawei.com,
        tglx@linutronix.de
In-Reply-To: <20230617073242.3199746-1-maz@kernel.org>
References: <20230617073242.3199746-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168841082738.404.13387349184603678805.tip-bot2@tip-bot2>
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

Commit-ID:     926846a703cbf5d0635cc06e67d34b228746554b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/926846a703cbf5d0635cc06e67d34b228746554b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 17 Jun 2023 08:32:42 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 03 Jul 2023 19:48:04 +01:00

irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

We normally rely on the irq_to_cpuid_[un]lock() primitives to make
sure nothing will change col->idx while performing a LPI invalidation.

However, these primitives do not cover VPE doorbells, and we have
some open-coded locking for that. Unfortunately, this locking is
pretty bogus.

Instead, extend the above primitives to cover VPE doorbells and
convert the whole thing to it.

Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion between vPE affinity change and RD access")
Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: wanghaibin.wang@huawei.com
Tested-by: Kunkun Jiang <jiangkunkun@huawei.com>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20230617073242.3199746-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 75 +++++++++++++++++++------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1994541..5365bc3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -273,13 +273,23 @@ static void vpe_to_cpuid_unlock(struct its_vpe *vpe, unsigned long flags)
 	raw_spin_unlock_irqrestore(&vpe->vpe_lock, flags);
 }
 
+static struct irq_chip its_vpe_irq_chip;
+
 static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
 	int cpu;
 
-	if (map) {
-		cpu = vpe_to_cpuid_lock(map->vpe, flags);
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
+
+	if (vpe) {
+		cpu = vpe_to_cpuid_lock(vpe, flags);
 	} else {
 		/* Physical LPIs are already locked via the irq_desc lock */
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -293,10 +303,18 @@ static int irq_to_cpuid_lock(struct irq_data *d, unsigned long *flags)
 
 static void irq_to_cpuid_unlock(struct irq_data *d, unsigned long flags)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vpe *vpe = NULL;
+
+	if (d->chip == &its_vpe_irq_chip) {
+		vpe = irq_data_get_irq_chip_data(d);
+	} else {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+		if (map)
+			vpe = map->vpe;
+	}
 
-	if (map)
-		vpe_to_cpuid_unlock(map->vpe, flags);
+	if (vpe)
+		vpe_to_cpuid_unlock(vpe, flags);
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -1433,14 +1451,29 @@ static void wait_for_syncr(void __iomem *rdbase)
 		cpu_relax();
 }
 
-static void direct_lpi_inv(struct irq_data *d)
+static void __direct_lpi_inv(struct irq_data *d, u64 val)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
 	unsigned long flags;
-	u64 val;
 	int cpu;
 
+	/* Target the redistributor this LPI is currently routed to */
+	cpu = irq_to_cpuid_lock(d, &flags);
+	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
+
+	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
+	wait_for_syncr(rdbase);
+
+	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
+	irq_to_cpuid_unlock(d, flags);
+}
+
+static void direct_lpi_inv(struct irq_data *d)
+{
+	struct its_vlpi_map *map = get_vlpi_map(d);
+	u64 val;
+
 	if (map) {
 		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
@@ -1453,15 +1486,7 @@ static void direct_lpi_inv(struct irq_data *d)
 		val = d->hwirq;
 	}
 
-	/* Target the redistributor this LPI is currently routed to */
-	cpu = irq_to_cpuid_lock(d, &flags);
-	raw_spin_lock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, cpu)->rd_base;
-	gic_write_lpir(val, rdbase + GICR_INVLPIR);
-
-	wait_for_syncr(rdbase);
-	raw_spin_unlock(&gic_data_rdist_cpu(cpu)->rd_lock);
-	irq_to_cpuid_unlock(d, flags);
+	__direct_lpi_inv(d, val);
 }
 
 static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
@@ -3953,18 +3978,10 @@ static void its_vpe_send_inv(struct irq_data *d)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 
-	if (gic_rdists->has_direct_lpi) {
-		void __iomem *rdbase;
-
-		/* Target the redistributor this VPE is currently known on */
-		raw_spin_lock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
-		gic_write_lpir(d->parent_data->hwirq, rdbase + GICR_INVLPIR);
-		wait_for_syncr(rdbase);
-		raw_spin_unlock(&gic_data_rdist_cpu(vpe->col_idx)->rd_lock);
-	} else {
+	if (gic_rdists->has_direct_lpi)
+		__direct_lpi_inv(d, d->parent_data->hwirq);
+	else
 		its_vpe_send_cmd(vpe, its_send_inv);
-	}
 }
 
 static void its_vpe_mask_irq(struct irq_data *d)
