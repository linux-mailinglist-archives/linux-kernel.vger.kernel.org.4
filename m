Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C2733F39
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbjFQHcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346145AbjFQHct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14D2688
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C91A660A73
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FADC433C8;
        Sat, 17 Jun 2023 07:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686987167;
        bh=y8w853I7CHZt5YvljPd+kSH9JBLhArAvK5O+cwAX4iI=;
        h=From:To:Cc:Subject:Date:From;
        b=fCo6FmwvxPn6DkviuEGtkhMBWuiWNTuVIQvQmKVtAYKAgAJwHze1b9mf6x6NnUJbz
         IXzx3nhd7NRthiOA/Bd7tk1DqwMq4D3/5n6/oq0vokVVDR3RzTdxIFSETKcBLSQ3d5
         tepWdeqQiV9IVfFyszjsZdCAZz2Fc7NWjuL65xgGY6slEfdnxBcX4ihrKxEAHbOg4+
         3ptZl/994ILV/z/eZpzxPOJLAh7BSrp/PS3kAlJufnvtYwwtsrtklR/gKNMhdSZIg2
         TcG9tmj+oextAp8Lp56ylGt6WDtBAM4YRekI9K+xtjr7dT10pGY87PW88WCSrvOsGk
         +95p1M+FDVMwA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qAQQO-0063vn-Qi;
        Sat, 17 Jun 2023 08:32:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>, wanghaibin.wang@huawei.com
Subject: [PATCH] irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation
Date:   Sat, 17 Jun 2023 08:32:42 +0100
Message-Id: <20230617073242.3199746-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jiangkunkun@huawei.com, yuzenghui@huawei.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-gic-v3-its.c | 75 ++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0ec2b1e1df75..c5cb2830e853 100644
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
@@ -3952,18 +3977,10 @@ static void its_vpe_send_inv(struct irq_data *d)
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
-- 
2.34.1

