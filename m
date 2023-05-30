Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEFD715749
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjE3Hna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjE3HnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:43:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AE3127
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:42:48 -0700 (PDT)
Date:   Tue, 30 May 2023 07:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685432485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xhU/yZF2uXMwyHdo5kEEt8Hrqxfr36ESyDFCDZDhw10=;
        b=RHyTx6R49t832JM4lqaPlhImNNYIT5OC4Gz0AIrp/Op+QrMHoy89prJbQgi7CzxQJPDMLg
        Ly1PnMo3TkPoXWItkoiScDLs07aT5ZDWCseQS/qxdn/+Sl2wwsPFRufivvePBpMwFZlVC7
        yrylEvsHbEbCnQuINrgqTEt16f85gsUaOZwvIipVAZSnTFgvHRgLsnsdRTl+mMJp0NZENI
        eu4nR4DbWOr63Ttc8GarQT/e8IkVttDQGVgsIaPq/s9CNdbesaMIuZczx6IEqc/incalBn
        /dxZvucPS/HHDQv4PgGBIZPeSmEyRG/NvRLxlO89d9Mn4LRs8vlFHb+VBgrf7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685432485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xhU/yZF2uXMwyHdo5kEEt8Hrqxfr36ESyDFCDZDhw10=;
        b=a2+5ES55fMQgxKJJbP95hcoC18+l+dQQA3lSKgMpgpSeDJ/jAeQ2+cybncfA69eRr1cJwk
        6LPJPnxArLwLZADw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Improve affinity helper
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <168543248488.404.160985809296056807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3c65cbb7c5ebb4247968936899580c7f508ed223
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3c65cbb7c5ebb4247968936899580c7f508ed223
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 29 May 2023 16:21:42 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 29 May 2023 16:58:07 +01:00

irqchip/gic-v3: Improve affinity helper

The GICv3 driver uses multiple formats for the affinity, all
derived from a reading of MPDR_EL1 on one CPU or another.

Simplify the handling of these affinity by moving the access
to the CPU affinity via cpu_logical_map() inside the helper,
and rename it accordingly.

This will be helpful to support some more broken hardware.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a605aa7..50455bc 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -656,8 +656,9 @@ static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 	return 0;
 }
 
-static u64 gic_mpidr_to_affinity(unsigned long mpidr)
+static u64 gic_cpu_to_affinity(int cpu)
 {
+	u64 mpidr = cpu_logical_map(cpu);
 	u64 aff;
 
 	aff = ((u64)MPIDR_AFFINITY_LEVEL(mpidr, 3) << 32 |
@@ -914,7 +915,7 @@ static void __init gic_dist_init(void)
 	 * Set all global interrupts to the boot CPU only. ARE must be
 	 * enabled.
 	 */
-	affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
+	affinity = gic_cpu_to_affinity(smp_processor_id());
 	for (i = 32; i < GIC_LINE_NR; i++)
 		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
 
@@ -963,7 +964,7 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 
 static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 {
-	unsigned long mpidr = cpu_logical_map(smp_processor_id());
+	unsigned long mpidr;
 	u64 typer;
 	u32 aff;
 
@@ -971,6 +972,8 @@ static int __gic_populate_rdist(struct redist_region *region, void __iomem *ptr)
 	 * Convert affinity to a 32bit value that can be matched to
 	 * GICR_TYPER bits [63:32].
 	 */
+	mpidr = gic_cpu_to_affinity(smp_processor_id());
+
 	aff = (MPIDR_AFFINITY_LEVEL(mpidr, 3) << 24 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 2) << 16 |
 	       MPIDR_AFFINITY_LEVEL(mpidr, 1) << 8 |
@@ -1084,7 +1087,7 @@ static inline bool gic_dist_security_disabled(void)
 static void gic_cpu_sys_reg_init(void)
 {
 	int i, cpu = smp_processor_id();
-	u64 mpidr = cpu_logical_map(cpu);
+	u64 mpidr = gic_cpu_to_affinity(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
 	bool group0;
 	u32 pribits;
@@ -1183,11 +1186,11 @@ static void gic_cpu_sys_reg_init(void)
 	for_each_online_cpu(i) {
 		bool have_rss = per_cpu(has_rss, i) && per_cpu(has_rss, cpu);
 
-		need_rss |= MPIDR_RS(cpu_logical_map(i));
+		need_rss |= MPIDR_RS(gic_cpu_to_affinity(i));
 		if (need_rss && (!have_rss))
 			pr_crit("CPU%d (%lx) can't SGI CPU%d (%lx), no RSS\n",
 				cpu, (unsigned long)mpidr,
-				i, (unsigned long)cpu_logical_map(i));
+				i, (unsigned long)gic_cpu_to_affinity(i));
 	}
 
 	/**
@@ -1263,9 +1266,11 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 				   unsigned long cluster_id)
 {
 	int next_cpu, cpu = *base_cpu;
-	unsigned long mpidr = cpu_logical_map(cpu);
+	unsigned long mpidr;
 	u16 tlist = 0;
 
+	mpidr = gic_cpu_to_affinity(cpu);
+
 	while (cpu < nr_cpu_ids) {
 		tlist |= 1 << (mpidr & 0xf);
 
@@ -1274,7 +1279,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
 			goto out;
 		cpu = next_cpu;
 
-		mpidr = cpu_logical_map(cpu);
+		mpidr = gic_cpu_to_affinity(cpu);
 
 		if (cluster_id != MPIDR_TO_SGI_CLUSTER_ID(mpidr)) {
 			cpu--;
@@ -1319,7 +1324,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	dsb(ishst);
 
 	for_each_cpu(cpu, mask) {
-		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
+		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(gic_cpu_to_affinity(cpu));
 		u16 tlist;
 
 		tlist = gic_compute_target_list(&cpu, mask, cluster_id);
@@ -1377,7 +1382,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 
 	offset = convert_offset_index(d, GICD_IROUTER, &index);
 	reg = gic_dist_base(d) + offset + (index * 8);
-	val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
+	val = gic_cpu_to_affinity(cpu);
 
 	gic_write_irouter(val, reg);
 
