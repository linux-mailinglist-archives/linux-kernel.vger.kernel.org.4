Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19472E754
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbjFMPfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbjFMPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:34:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D21BF0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:34:49 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39cc64e4a44so1448466b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686670488; x=1689262488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXSsvlQ/R6yHM0Hz/nbqBTRJ+migXFNIKunDjIZh+EE=;
        b=JojL+gfZIo4k2B2N1XNc6LNsjmo8WP6nwvdAY/onRH8Zqxu4pd+KVL1KxrrjkyXY96
         Joqz5ZSGZFWiIRkE5swbNsTyHOBbYKsDIU6WOyz/Yv/epbAMDBVdnd/pzm/r4Re01wM3
         0I1OFaRBqJfQNQnzC8UZgUXzPW9I3+cbm6Jb04CqNCsB53hq2jRIaasZYV4gaJRnvbKT
         xbPihBDPiQsUZgx6U1T4ju4hnEpu9xIef8Ilol0yCzhRe7Ls57cYEPkZbBrEWLs4wgXH
         JOoTqVjnLgqMN6ihBEOtMb44bu9HSKT2MAkkFeaKHVD+ekZSdQbP0HXTF0P0KVzbHdp8
         67Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686670488; x=1689262488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXSsvlQ/R6yHM0Hz/nbqBTRJ+migXFNIKunDjIZh+EE=;
        b=KJD14KY2nOOr5WnGxk9wXGtFzze+Mbu4VG3Gcez3UEe9Qz66KPSGyZzz2KsR7js8mk
         2GShjV/I1tqpD/IHznKTa1dyh0tmo3QTgImRK9vmkTwlzmDCj4um/WFNuQTLaxxsq7Sd
         BYF11VKoKcNx2fwpakJWdo3MYixvAt35gBwlzNgnGo+fQyQ0ikWKeP/iZm8IQn6zqSu5
         xLyWvH/tndVH3KNuUmN1r2QK1vrXmK8sgGwTs6CbOU+KzJLjuL94L19gYtBYZu5akgCT
         zy7aRCi5CrkWr3obkDvvDK2wcuZ+K+/ulBL85dLDrkllHg29NM9DppXz0SD8uq6lsfpD
         Ed+w==
X-Gm-Message-State: AC+VfDxoaXDiXXcf8F4BeRe9RkYX4rnMeVz9Jf4QpRHQSWpgQyjzKFuc
        4hGMbKRHLqCdSYD4nyxLPWm3jQ==
X-Google-Smtp-Source: ACHHUZ4zSdqrg0FoDckfeqsUwQBijAmHsngd8VD44TIt7ZxFz+NbF3OXoUg7rKPjPP/3duHDx3VYrw==
X-Received: by 2002:a05:6808:23d3:b0:39a:a19a:3207 with SMTP id bq19-20020a05680823d300b0039aa19a3207mr8116705oib.18.1686670488400;
        Tue, 13 Jun 2023 08:34:48 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n2-20020acabd02000000b0039ce305ea4fsm1630807oif.14.2023.06.13.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:34:48 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 02/10] irqchip/riscv-intc: Add support for RISC-V AIA
Date:   Tue, 13 Jun 2023 21:04:07 +0530
Message-Id: <20230613153415.350528-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613153415.350528-1-apatel@ventanamicro.com>
References: <20230613153415.350528-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

