Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41D95EF7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiI2OlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiI2OlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:41:00 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693A1C4302
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:40:58 -0700 (PDT)
Received: from fdsafasdfasdf.mikrus.ds.pw.edu.pl (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id AE93540192;
        Thu, 29 Sep 2022 16:40:55 +0200 (CEST)
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
Subject: [PATCH v2 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Date:   Thu, 29 Sep 2022 16:40:39 +0200
Message-Id: <20220929144039.40011-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220929144039.40011-1-konrad.dybcio@somainline.org>
References: <20220929144039.40011-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for A7-A11 SoCs by if-ing out some features only present
on:

* A11 & newer (implementation-defined IPI & UNCORE registers)
* A11[1] & newer (fast IPI support).

Also, annotate IPI regs support in the aic struct so that the driver
can tell whether the SoC supports these, as they are written to,
even if fast IPI is disabled. This in turn causes a crash on older
platforms, as the implemention-defined registers either do
something else or are not supposed to be touched - definitely not a
NOP though.

[1] A11 is supposed to use this feature, but it currently doesn't work
for reasons unknown and hence remains disabled. It can easily be enabled
on A11 only, as there is a SoC-specific compatible in the DT with a
fallback to apple,aic, so that the interrupt controller gets to probe
regardless of whether IPI Sn_... registers are used or not.
That said, it is not yet necessary, especially with only one core up,
and it has worked a-ok so far.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v1:
- remove EL2 register check (dts change covered this)
- use static_branch instead of ifs
- rename "uncore2 registers" to "uncore registers" in added code and
update the commit message accordingly
- create a "legacy" config struct for pre-A11 targets
- rewrite the commit message a bit to match actual status

 drivers/irqchip/irq-apple-aic.c | 56 ++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..cdef99bfcfb3 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -229,6 +229,7 @@
 #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
 
 static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+static DEFINE_STATIC_KEY_TRUE(has_uncore_regs);
 
 struct aic_info {
 	int version;
@@ -246,6 +247,7 @@ struct aic_info {
 
 	/* Features */
 	bool fast_ipi;
+	bool uncore_regs;
 };
 
 static const struct aic_info aic1_info = {
@@ -253,6 +255,8 @@ static const struct aic_info aic1_info = {
 
 	.event		= AIC_EVENT,
 	.target_cpu	= AIC_TARGET_CPU,
+
+	.uncore_regs	= true,
 };
 
 static const struct aic_info aic1_fipi_info = {
@@ -264,6 +268,13 @@ static const struct aic_info aic1_fipi_info = {
 	.fast_ipi	= true,
 };
 
+static const struct aic_info aic1_legacy_info = {
+	.version	= 1,
+
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
+};
+
 static const struct aic_info aic2_info = {
 	.version	= 2,
 
@@ -273,6 +284,10 @@ static const struct aic_info aic2_info = {
 };
 
 static const struct of_device_id aic_info_match[] = {
+	{
+		.compatible = "apple,s5l8960x-aic",
+		.data = &aic1_legacy_info,
+	},
 	{
 		.compatible = "apple,t8103-aic",
 		.data = &aic1_fipi_info,
@@ -524,12 +539,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 * we check for everything here, even things we don't support yet.
 	 */
 
-	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		if (static_branch_likely(&use_fast_ipi)) {
-			aic_handle_ipi(regs);
-		} else {
-			pr_err_ratelimited("Fast IPI fired. Acking.\n");
-			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi)) {
+		if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
+			if (static_branch_likely(&use_fast_ipi)) {
+				aic_handle_ipi(regs);
+			} else {
+				pr_err_ratelimited("Fast IPI fired. Acking.\n");
+				write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+			}
 		}
 	}
 
@@ -566,12 +583,14 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 					  AIC_FIQ_HWIRQ(irq));
 	}
 
-	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == UPMCR0_IMODE_FIQ &&
-			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
-		/* Same story with uncore PMCs */
-		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
-		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&has_uncore_regs)) {
+		if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) ==
+			UPMCR0_IMODE_FIQ && (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
+			/* Same story with uncore PMCs */
+			pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
+			sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+					FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+		}
 	}
 }
 
@@ -944,7 +963,8 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
 
 	/* Pending Fast IPI FIQs */
-	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+	if (static_branch_likely(&use_fast_ipi))
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
 
 	/* Timer FIQs */
 	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
@@ -965,8 +985,9 @@ static int aic_init_cpu(unsigned int cpu)
 			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
 
 	/* Uncore PMC FIQ */
-	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
-			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
+	if (static_branch_likely(&has_uncore_regs))
+		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
+				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
 
 	/* Commit all of the above */
 	isb();
@@ -1125,6 +1146,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	else
 		static_branch_disable(&use_fast_ipi);
 
+	if (irqc->info.uncore_regs)
+		static_branch_enable(&has_uncore_regs);
+	else
+		static_branch_disable(&has_uncore_regs);
+
 	irqc->info.die_stride = off - start_off;
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
-- 
2.30.2

