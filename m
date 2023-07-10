Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709D74D21A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjGJJt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjGJJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:48:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2449E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:43:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78360f61ba0so213589539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688982232; x=1691574232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXSsvlQ/R6yHM0Hz/nbqBTRJ+migXFNIKunDjIZh+EE=;
        b=W/of7M624lty1wnoYq2AEd8m6M/KJ2u+uFQsUmtTpS50lkX1mksFm1FF5vcO1pWyZj
         xyZSuo6XsQozWpsz8wvW2dGylYfwwi6Xxx/2iqxH+rhf3Na64EivLBq50b6jQmgOsEcW
         PpSKzmM3OKO+rcyZHvfD4RlVGPHN94F59v5oBbcRv381JFtmEyzQ5Xij4MBPhGIuMDjW
         tReZsODNXa3NudsL5yhXPFj9NjjOyJcql86MO0x13wu/D/Z//ItyNqxqhqPMlr2O7t/M
         XBnWb9YMUym97gSAJFEzaU8PVfVSRHbXzlDk9spe5Gk604RvBZUToV/TtMQrRSROw0M7
         FFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982232; x=1691574232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXSsvlQ/R6yHM0Hz/nbqBTRJ+migXFNIKunDjIZh+EE=;
        b=DMKGFJwtcQBaEk0olNcwAvO8wrmn2kx8kHlHIS2TpgZxROOBTC63h4uWYgVpLlCrKP
         DP2/GnquKIrPiXfFPW4ld+MZaMGG5cGIgT1xQSRT6ucwfDfZ5PiyvmvuW7qtLCnxbb1u
         Sp8QBwXu860jpl1PGww7gYBSSPdwzhDfw3GHxyPhA/ky+1+0lvoOgipxo5f0GK5bDqao
         kCSZq/xuNw4gznRjvldV1bLoOh966I/lfT7106F3gWLTT8FsovaJbFhvxSoQkA4eKtfn
         Sbl2+CZCnVPnN/rs4wc9DHVjmwc7pn3DoyR0ab+gy861NITF8WZ5nzuvrERQgjwbA7Td
         ctIQ==
X-Gm-Message-State: ABy/qLYAukUk67rFNkv+ssZJp8QqE2XQwqb6B0Q/Qn2qkYXRf81haWJ6
        reBjhE16e6tclScsOfmgFfTB3Q==
X-Google-Smtp-Source: APBJJlF+I80RYaN2WMHLcsN/9T5/HGm+CHwRryl4eQj0HMo93xFCdJg54YKQO8Y2dqiU0aMU4FHSkg==
X-Received: by 2002:a6b:7904:0:b0:786:cc36:360c with SMTP id i4-20020a6b7904000000b00786cc36360cmr10770193iop.8.1688982232246;
        Mon, 10 Jul 2023 02:43:52 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k1-20020a6b7a41000000b007870c56387dsm936938iop.49.2023.07.10.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:43:51 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v5 2/9] irqchip/riscv-intc: Add support for RISC-V AIA
Date:   Mon, 10 Jul 2023 15:13:14 +0530
Message-Id: <20230710094321.1378351-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710094321.1378351-1-apatel@ventanamicro.com>
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V advanced interrupt architecture (AIA) extends the per-HART
local interrupts in following ways:
1. Minimum 64 local interrupts for both RV32 and RV64
2. Ability to process multiple pending local interrupts in same
   interrupt handler
3. Priority configuration for each local interrupts
4. Special CSRs to configure/access the per-HART MSI controller

This patch adds support for RISC-V AIA in the RISC-V intc driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 36 ++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1bc391..e235bf1708a4 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <asm/hwcap.h>
 
 static struct irq_domain *intc_domain;
 
@@ -30,6 +31,15 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 	generic_handle_domain_irq(intc_domain, cause);
 }
 
+static asmlinkage void riscv_intc_aia_irq(struct pt_regs *regs)
+{
+	unsigned long topi;
+
+	while ((topi = csr_read(CSR_TOPI)))
+		generic_handle_domain_irq(intc_domain,
+					  topi >> TOPI_IID_SHIFT);
+}
+
 /*
  * On RISC-V systems local interrupts are masked or unmasked by writing
  * the SIE (Supervisor Interrupt Enable) CSR.  As CSRs can only be written
@@ -39,12 +49,18 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 
 static void riscv_intc_irq_mask(struct irq_data *d)
 {
-	csr_clear(CSR_IE, BIT(d->hwirq));
+	if (d->hwirq < BITS_PER_LONG)
+		csr_clear(CSR_IE, BIT(d->hwirq));
+	else
+		csr_clear(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
 }
 
 static void riscv_intc_irq_unmask(struct irq_data *d)
 {
-	csr_set(CSR_IE, BIT(d->hwirq));
+	if (d->hwirq < BITS_PER_LONG)
+		csr_set(CSR_IE, BIT(d->hwirq));
+	else
+		csr_set(CSR_IEH, BIT(d->hwirq - BITS_PER_LONG));
 }
 
 static void riscv_intc_irq_eoi(struct irq_data *d)
@@ -115,16 +131,22 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 
 static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 {
-	int rc;
+	int rc, nr_irqs = BITS_PER_LONG;
+
+	if (riscv_isa_extension_available(NULL, SxAIA) && BITS_PER_LONG == 32)
+		nr_irqs = nr_irqs * 2;
 
-	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
+	intc_domain = irq_domain_create_linear(fn, nr_irqs,
 					       &riscv_intc_domain_ops, NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
 	}
 
-	rc = set_handle_irq(&riscv_intc_irq);
+	if (riscv_isa_extension_available(NULL, SxAIA))
+		rc = set_handle_irq(&riscv_intc_aia_irq);
+	else
+		rc = set_handle_irq(&riscv_intc_irq);
 	if (rc) {
 		pr_err("failed to set irq handler\n");
 		return rc;
@@ -132,7 +154,9 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+	pr_info("%d local interrupts mapped%s\n",
+		nr_irqs, (riscv_isa_extension_available(NULL, SxAIA)) ?
+			 " using AIA" : "");
 
 	return 0;
 }
-- 
2.34.1

