Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5F5F41F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJDL1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJDL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:27:40 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3211A2BE39
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:27:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a00:f41:188c:1c74:dc7c:ae37:b483:8263])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CC8291FC01;
        Tue,  4 Oct 2022 13:27:34 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     towinchenmi@gmail.com,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Date:   Tue,  4 Oct 2022 13:27:24 +0200
Message-Id: <20221004112724.31621-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221004112724.31621-1-konrad.dybcio@somainline.org>
References: <20221004112724.31621-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for A7-A11 SoCs by if-ing out some features only present
on:

* A11 & newer (implementation-defined IPI & UNCORE registers)
* A11[1] & newer (fast IPI support).

UNCORE/UNCORE2 and IPI registers conveniently both first appeared on
A11, so introduce just one check for that.

Knowing whether the SoC supports the latter is necessary, as they are
written to, even if fast IPI is disabled. This in turn causes a crash
on older platforms, as the implemention-defined registers either do
something else or are not supposed to be touched - definitely not a
NOP though.

[1] A11 is supposed to use this feature, but it currently doesn't work
for reasons unknown and hence remains disabled. It can easily be enabled
on A11 only, as there is a SoC-specific compatible in the DT with a
fallback to apple,aic. That said, it is not yet necessary, especially
with only one core up, and it has worked a-ok so far.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v2:
- has_uncore_regs now also reflects whether the soc has IPI regs (A11+)
- apple,aic is now the default, lowest-common-denominator fallback
compatible (Sven checked it still works on M1)
- fixed an error where "Fast IPI fired. Acking." would be unreachable..
oops..
- what used to be apple,aic (yes UNCORE/IPI regs no fast IPI) is now
used for the A11 compatible

 drivers/irqchip/irq-apple-aic.c | 60 ++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..239115c64340 100644
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
@@ -261,18 +265,33 @@ static const struct aic_info aic1_fipi_info = {
 	.event		= AIC_EVENT,
 	.target_cpu	= AIC_TARGET_CPU,
 
+	.uncore_ipi_regs	= true,
 	.fast_ipi	= true,
 };
 
+static const struct aic_info aic1_nofipi_info = {
+	.version	= 1,
+
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
+
+	.uncore_ipi_regs	= true,
+};
+
 static const struct aic_info aic2_info = {
 	.version	= 2,
 
 	.irq_cfg	= AIC2_IRQ_CFG,
 
+	.uncore_ipi_regs	= true,
 	.fast_ipi	= true,
 };
 
 static const struct of_device_id aic_info_match[] = {
+	{
+		.compatible = "apple,t8015-aic",
+		.data = &aic1_nofipi_info,
+	},
 	{
 		.compatible = "apple,t8103-aic",
 		.data = &aic1_fipi_info,
@@ -524,12 +543,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
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
 
@@ -566,12 +587,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
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
 
@@ -944,7 +967,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -965,8 +989,9 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
 
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&has_uncore_ipi_regs))
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
 
 	/* Commit all of the above */
 	isb();
@@ -1125,6 +1150,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
2.30.2

