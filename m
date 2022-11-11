Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0B6252C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKKEny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiKKEnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:43:23 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392326CA30
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:01 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2243410otu.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0whY6CuX4CjDJzLdZou1ftrY3RLAFDBaqvIT3+qCC0=;
        b=ex4g+HVmPtKwUsgRtgBGZc6dEnU40ikO5oUN+/xbjTgKAsQ4AmcA8indPUodHr5bW+
         H/iwZxP/S29A8whf7W6sj+wo/kEJs5SUnXHo7x6EMz0jVaxnuuz+DS0hloWJ1J1FvCO1
         sfAKi08Zhl0viCznsZrsgns2XLwc46Yo92WHpoeAV2SvfqD/K6pEKLlTKGa2RFE/qW5Z
         PlrCBNqwzqyhq6XpEOHfHhpbMCjUFL18t4rKIFiXb9W3y3hrwl0tMhCrYdNBlr3wvmaJ
         ODZV7/7SbguEDMCD2rP9+jJ2/+moHsuMBhEqs3aaKAGc6e0PWSZzJAUC3FJ1R7ntoKZN
         iMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0whY6CuX4CjDJzLdZou1ftrY3RLAFDBaqvIT3+qCC0=;
        b=G6mig54SfHFNraczeoHmqs8semEauEh7dUtpTPFFjuPjmebKwo/IC9lTh7GZOnXau4
         yKWos1Q+MawzEtAwpaXeKImcOS8GgSlxnv75JmDqxGy/MudMfB9f5igZX91Sn5Rd0b+o
         OuW/fl3a9sxUT0Ao1yNmv6nFxdRvZ5LLY1krTPD56DL9Fd+u5QRqQN0Rr88HvAJDlnRa
         v93IUTWQpEomuLKuZX4AAFXbeDsLy2mNlmzK4VsaB7JlfpkQyCSj3m46ogHU7h5daheP
         wtjmnMpGVB3r4ZffLNK03FqRJky1r0okJImLaX63q0p/KocJA+hO58wOxKjWgpvNIKC2
         Anhg==
X-Gm-Message-State: ANoB5pmc9+ePmTwAabv7FXqcDFXnsyTPAmm9nruFt7IIKehkn54XrbBN
        W9XVp8lM6fqxNn7qd3AADrSwG7hWCJMqrQ==
X-Google-Smtp-Source: AA0mqf5MndJeJfOoAMW4mJ9r4EwnrWkrc/tZWwYMozRKaabuYjW3ZiXnwST3SGNkMyE30OTKRoJnew==
X-Received: by 2002:a05:6830:20ca:b0:66c:4f87:fd14 with SMTP id z10-20020a05683020ca00b0066c4f87fd14mr454372otq.159.1668141780427;
        Thu, 10 Nov 2022 20:43:00 -0800 (PST)
Received: from anup-ubuntu64-vm.. ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870350e00b0013d9bd4ad2esm787353oah.12.2022.11.10.20.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:43:00 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 3/9] irqchip/riscv-intc: Add support for RISC-V AIA
Date:   Fri, 11 Nov 2022 10:12:01 +0530
Message-Id: <20221111044207.1478350-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111044207.1478350-1-apatel@ventanamicro.com>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/irqchip/irq-riscv-intc.c | 37 ++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 784d25645704..e72969295241 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <asm/hwcap.h>
 
 static struct irq_domain *intc_domain;
 
@@ -29,6 +30,15 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
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
@@ -38,12 +48,18 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 
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
 
 static struct irq_chip riscv_intc_chip = {
@@ -98,7 +114,7 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	int rc;
+	int rc, nr_irqs;
 	unsigned long hartid;
 
 	rc = riscv_of_parent_hartid(node, &hartid);
@@ -116,14 +132,21 @@ static int __init riscv_intc_init(struct device_node *node,
 	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
 		return 0;
 
-	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
+	nr_irqs = BITS_PER_LONG;
+	if (riscv_isa_extension_available(NULL, SxAIA) && BITS_PER_LONG == 32)
+		nr_irqs = nr_irqs * 2;
+
+	intc_domain = irq_domain_add_linear(node, nr_irqs,
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
@@ -131,7 +154,9 @@ static int __init riscv_intc_init(struct device_node *node,
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+	pr_info("%d local interrupts mapped%s\n",
+		nr_irqs, (riscv_isa_extension_available(NULL, SxAIA)) ?
+			 " using AIA" : "");
 
 	return 0;
 }
-- 
2.34.1

