Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322465F7E65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJGUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJGUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:00:51 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B9D73F3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:00:49 -0700 (PDT)
Received: from localhost.localdomain (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 0FB6F3F36F;
        Fri,  7 Oct 2022 22:00:47 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Date:   Fri,  7 Oct 2022 22:00:22 +0200
Message-Id: <20221007200022.22844-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007200022.22844-1-konrad.dybcio@somainline.org>
References: <20221007200022.22844-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for A7-A11 SoCs by if-ing out some features only present
on A11 & newer (implementation-defined IPI & UNCORE registers).

Also, annotate IPI regs support in the aic struct so that the driver
can tell whether the SoC supports these, as they are written to,
even if fast IPI is disabled. This in turn causes a crash on older
platforms, as the implemention-defined registers either do
something else or are not supposed to be touched - definitely not a
NOP though.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v3:
- Replace use_fast_ipi with has_uncore_ipi_regs in aic_init_cpu
(logic error, this was written to regardless of FIPI usage before,
but touching Sn_... regs on SoCs that don't explicitly use them for
IPIs makes them sepuku..)
- Drop A11 compatible

 drivers/irqchip/irq-apple-aic.c | 47 ++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..2609d6b60487 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -230,6 +230,9 @@
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 
+/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present (A11+) */
+static DEFINE_STATIC_KEY_TRUE(has_uncore_ipi_regs);
+
 struct aic_info {
 	int version;
 
@@ -246,6 +249,7 @@ struct aic_info {
 
 	/* Features */
 	bool fast_ipi;
+	bool uncore_ipi_regs;
 };
 
 static const struct aic_info aic1_info = {
@@ -261,6 +265,7 @@ static const struct aic_info aic1_fipi_info = {
 	.event		= AIC_EVENT,
 	.target_cpu	= AIC_TARGET_CPU,
 
+	.uncore_ipi_regs	= true,
 	.fast_ipi	= true,
 };
 
@@ -269,6 +274,7 @@ static const struct aic_info aic2_info = {
 
 	.irq_cfg	= AIC2_IRQ_CFG,
 
+	.uncore_ipi_regs	= true,
 	.fast_ipi	= true,
 };
 
@@ -524,12 +530,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
 
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&has_uncore_ipi_regs)) {
+		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
+			if (static_branch_likely(&use_fast_ipi)) {
+				aic_handle_ipi(regs);
+			} else {
+				pr_err_ratelimited("Fast IPI fired. Acking.\n");
+				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+			}
 		}
 	}
 
@@ -566,12 +574,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 					  AIC_FIQ_HWIRQ(irq));
 	}
 
-	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
-			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
-		/* Same story with uncore PMCs */
-		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
-		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&has_uncore_ipi_regs)) {
+		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) ==
+			UPMCR0_IMODE_FIQ && (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
+			/* Same story with uncore PMCs */
+			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
+			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+		}
 	}
 }
 
@@ -944,7 +954,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&has_uncore_ipi_regs))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -965,8 +976,9 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
 
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&has_uncore_ipi_regs))
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
 
 	/* Commit all of the above */
 	isb();
@@ -1125,6 +1137,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	else
 		static_branch_disable(&use_fast_ipi);
 
+	if (irqc->info.uncore_ipi_regs)
+		static_branch_enable(&has_uncore_ipi_regs);
+	else
+		static_branch_disable(&has_uncore_ipi_regs);
+
 	irqc->info.die_stride = off - start_off;
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
-- 
2.37.3

