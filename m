Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CC641496
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiLCGsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiLCGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:47:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF95FA0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:47:37 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so6543493plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+y5lNDUnw4uQBrajobLH9mJrPY1sMzOJOF/tF/7n3g=;
        b=ATt6rq5dOTA8oWxpEJCQqPS1kcIRpCjbuC+ESsUaESQuQw5ldHrGr5re1LLhoQZsOm
         wvZMeYAC4vCciqOguGuMlVN/kIRqM7ivwi7QQ3CQ+R06EuxxnfznKals6Mj4kQ0D6ohx
         ijvgrIMP5Y1skdHnfanyVaE0fMLSfjLudifJtGSz/0Z94l8UngRaH9YVguYVclfDpWap
         Vn+B3ASFTLAadqoMz53aPRFfqsmvPDlL4Gbv10ZajdnaEDigqZ4cM5BGevwdSMZE+IPP
         ZSpCpTLp9+kSXZeetwWRon7zFPAMayKKZoDgGajwboWELYYRzedc2oqOc3qOtyPshcyz
         hXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+y5lNDUnw4uQBrajobLH9mJrPY1sMzOJOF/tF/7n3g=;
        b=N5E9rTKtPaK6GHxvliYWCtCMN5UX7QHiSyadqjIX1PETPaCUsn50SLLMPzvizi4pCV
         FVAOyZDppXTDvOVUf4AtzrTk12jSRSaQr5Xdbo192D+AsgWIcr7bKkfD4Y6sOKH/aa5u
         gcqIf5ZTKYiJFM+7NMNoXCPqMrzxipu0ukhk8rBTI8p/UnAAtgHTcbbPYa1enmGBypEl
         AILPL9VGU/3yfQS2GDLN9GqH1x8p1lwBLpfphxv11yW8xt7gIbDQDtg7/TCt0nmXZKd5
         uapfL/OX5OUvY2DeLjIDXKz2Oy7Rhv3w8/PUmf+Kody8BCIXStjL5BxVcHh6WoD2a1il
         WPuw==
X-Gm-Message-State: ANoB5plLwIQQWj/8hRH5zFkY9CNqV8Zkwzb/+r49cA8T555E4z2iIGeH
        /q1KkCiC6jQ7CdivVud75Mu1Yg==
X-Google-Smtp-Source: AA0mqf781B6PjmzZj9tFyg3PitYH5rgYx7rEfiA9nYItVnbShX8E1YMGaVw5XcMVFp/W8qePYyjN0A==
X-Received: by 2002:a17:902:cacb:b0:189:c19a:2ccf with SMTP id y11-20020a170902cacb00b00189c19a2ccfmr4412743pld.91.1670050057037;
        Fri, 02 Dec 2022 22:47:37 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b00575c8242849sm6102091pfq.69.2022.12.02.22.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:47:36 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH v15 9/9] irqchip/apple-aic: Move over to core ipi-mux
Date:   Sat,  3 Dec 2022 12:16:29 +0530
Message-Id: <20221203064629.1601299-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221203064629.1601299-1-apatel@ventanamicro.com>
References: <20221203064629.1601299-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

Now that the complexity of the AIC IPI mux has been copied into
the core code for the benefit of the riscv architecture,
shrink the AIC driver by the same amount by using that infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig         |   1 +
 drivers/irqchip/irq-apple-aic.c | 161 ++------------------------------
 2 files changed, 9 insertions(+), 153 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 131379aa8424..0fd452b49ed9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -675,6 +675,7 @@ config APPLE_AIC
 	bool "Apple Interrupt Controller (AIC)"
 	depends on ARM64
 	depends on ARCH_APPLE || COMPILE_TEST
+	select GENERIC_IRQ_IPI_MUX
 	help
 	  Support for the Apple Interrupt Controller found on Apple Silicon SoCs,
 	  such as the M1.
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813ad8bbe..1fa81fcff788 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -292,7 +292,6 @@ struct aic_irq_chip {
 	void __iomem *base;
 	void __iomem *event;
 	struct irq_domain *hw_domain;
-	struct irq_domain *ipi_domain;
 	struct {
 		cpumask_t aff;
 	} *fiq_aff[AIC_NR_FIQ];
@@ -307,9 +306,6 @@ struct aic_irq_chip {
 
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
 
-static DEFINE_PER_CPU(atomic_t, aic_vipi_flag);
-static DEFINE_PER_CPU(atomic_t, aic_vipi_enable);
-
 static struct aic_irq_chip *aic_irqc;
 
 static void aic_handle_ipi(struct pt_regs *regs);
@@ -751,98 +747,8 @@ static void aic_ipi_send_fast(int cpu)
 	isb();
 }
 
-static void aic_ipi_mask(struct irq_data *d)
-{
-	u32 irq_bit = BIT(irqd_to_hwirq(d));
-
-	/* No specific ordering requirements needed here. */
-	atomic_andnot(irq_bit, this_cpu_ptr(&aic_vipi_enable));
-}
-
-static void aic_ipi_unmask(struct irq_data *d)
-{
-	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
-	u32 irq_bit = BIT(irqd_to_hwirq(d));
-
-	atomic_or(irq_bit, this_cpu_ptr(&aic_vipi_enable));
-
-	/*
-	 * The atomic_or() above must complete before the atomic_read()
-	 * below to avoid racing aic_ipi_send_mask().
-	 */
-	smp_mb__after_atomic();
-
-	/*
-	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
-	 * No barriers needed here since this is a self-IPI.
-	 */
-	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
-		if (static_branch_likely(&use_fast_ipi))
-			aic_ipi_send_fast(smp_processor_id());
-		else
-			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
-	}
-}
-
-static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
-{
-	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
-	u32 irq_bit = BIT(irqd_to_hwirq(d));
-	u32 send = 0;
-	int cpu;
-	unsigned long pending;
-
-	for_each_cpu(cpu, mask) {
-		/*
-		 * This sequence is the mirror of the one in aic_ipi_unmask();
-		 * see the comment there. Additionally, release semantics
-		 * ensure that the vIPI flag set is ordered after any shared
-		 * memory accesses that precede it. This therefore also pairs
-		 * with the atomic_fetch_andnot in aic_handle_ipi().
-		 */
-		pending = atomic_fetch_or_release(irq_bit, per_cpu_ptr(&aic_vipi_flag, cpu));
-
-		/*
-		 * The atomic_fetch_or_release() above must complete before the
-		 * atomic_read() below to avoid racing aic_ipi_unmask().
-		 */
-		smp_mb__after_atomic();
-
-		if (!(pending & irq_bit) &&
-		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
-			if (static_branch_likely(&use_fast_ipi))
-				aic_ipi_send_fast(cpu);
-			else
-				send |= AIC_IPI_SEND_CPU(cpu);
-		}
-	}
-
-	/*
-	 * The flag writes must complete before the physical IPI is issued
-	 * to another CPU. This is implied by the control dependency on
-	 * the result of atomic_read_acquire() above, which is itself
-	 * already ordered after the vIPI flag write.
-	 */
-	if (send)
-		aic_ic_write(ic, AIC_IPI_SEND, send);
-}
-
-static struct irq_chip ipi_chip = {
-	.name = "AIC-IPI",
-	.irq_mask = aic_ipi_mask,
-	.irq_unmask = aic_ipi_unmask,
-	.ipi_send_mask = aic_ipi_send_mask,
-};
-
-/*
- * IPI IRQ domain
- */
-
 static void aic_handle_ipi(struct pt_regs *regs)
 {
-	int i;
-	unsigned long enabled, firing;
-
 	/*
 	 * Ack the IPI. We need to order this after the AIC event read, but
 	 * that is enforced by normal MMIO ordering guarantees.
@@ -857,27 +763,7 @@ static void aic_handle_ipi(struct pt_regs *regs)
 		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
 	}
 
-	/*
-	 * The mask read does not need to be ordered. Only we can change
-	 * our own mask anyway, so no races are possible here, as long as
-	 * we are properly in the interrupt handler (which is covered by
-	 * the barrier that is part of the top-level AIC handler's readl()).
-	 */
-	enabled = atomic_read(this_cpu_ptr(&aic_vipi_enable));
-
-	/*
-	 * Clear the IPIs we are about to handle. This pairs with the
-	 * atomic_fetch_or_release() in aic_ipi_send_mask(), and needs to be
-	 * ordered after the aic_ic_write() above (to avoid dropping vIPIs) and
-	 * before IPI handling code (to avoid races handling vIPIs before they
-	 * are signaled). The former is taken care of by the release semantics
-	 * of the write portion, while the latter is taken care of by the
-	 * acquire semantics of the read portion.
-	 */
-	firing = atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & enabled;
-
-	for_each_set_bit(i, &firing, AIC_NR_SWIPI)
-		generic_handle_domain_irq(aic_irqc->ipi_domain, i);
+	ipi_mux_process();
 
 	/*
 	 * No ordering needed here; at worst this just changes the timing of
@@ -887,55 +773,24 @@ static void aic_handle_ipi(struct pt_regs *regs)
 		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
 }
 
-static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
-			 unsigned int nr_irqs, void *args)
+static void aic_ipi_send_single(unsigned int cpu)
 {
-	int i;
-
-	for (i = 0; i < nr_irqs; i++) {
-		irq_set_percpu_devid(virq + i);
-		irq_domain_set_info(d, virq + i, i, &ipi_chip, d->host_data,
-				    handle_percpu_devid_irq, NULL, NULL);
-	}
-
-	return 0;
-}
-
-static void aic_ipi_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
-{
-	/* Not freeing IPIs */
+	if (static_branch_likely(&use_fast_ipi))
+		aic_ipi_send_fast(cpu);
+	else
+		aic_ic_write(aic_irqc, AIC_IPI_SEND, AIC_IPI_SEND_CPU(cpu));
 }
 
-static const struct irq_domain_ops aic_ipi_domain_ops = {
-	.alloc = aic_ipi_alloc,
-	.free = aic_ipi_free,
-};
-
 static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
 {
-	struct irq_domain *ipi_domain;
 	int base_ipi;
 
-	ipi_domain = irq_domain_create_linear(irqc->hw_domain->fwnode, AIC_NR_SWIPI,
-					      &aic_ipi_domain_ops, irqc);
-	if (WARN_ON(!ipi_domain))
-		return -ENODEV;
-
-	ipi_domain->flags |= IRQ_DOMAIN_FLAG_IPI_SINGLE;
-	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-
-	base_ipi = __irq_domain_alloc_irqs(ipi_domain, -1, AIC_NR_SWIPI,
-					   NUMA_NO_NODE, NULL, false, NULL);
-
-	if (WARN_ON(!base_ipi)) {
-		irq_domain_remove(ipi_domain);
+	base_ipi = ipi_mux_create(AIC_NR_SWIPI, aic_ipi_send_single);
+	if (WARN_ON(base_ipi <= 0))
 		return -ENODEV;
-	}
 
 	set_smp_ipi_range(base_ipi, AIC_NR_SWIPI);
 
-	irqc->ipi_domain = ipi_domain;
-
 	return 0;
 }
 
-- 
2.34.1

