Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C890763F11E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLANC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiLANCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:02:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744AB56EF7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:02:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5144873pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOsF09BSv6WEjfktoanH0vG9zVuY2VCJ6w8ZQR8SIzw=;
        b=fo7AY9pboIe0ZJcIHcZHssx/Fv6yMUxHk5pOTZgl/310+2AuM9F4JAgAGN6E98l73e
         jVxZYWn1D+mPWtaLmlhPAoddu20lmKlsahPX9z5FHHl2H9jGkT7nbJtpsFfSTL1b1oYi
         Qomi2vFrOFdq/qU0TSA+qe5klggIfjdYzvPi7LoN9GYdX2vp67+K6nOo0VTUTqNvp9PM
         +Kxnvszajn/b6hlTAoh+eT5vkN/W3/SFrnGs1v0aH4wGzsNHuMT7bm6BNRjLKb5VkXuz
         sIMvaQmC2Di4rGc4Xx3mRTaCx4pPLQ8eisvuheaX63Z542ybF7ptuHTFqu+i3T5nDDID
         0EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOsF09BSv6WEjfktoanH0vG9zVuY2VCJ6w8ZQR8SIzw=;
        b=4B6E2sCURX8LO08lD1QeXMYvCx0gDGMEF+JwOY4pk3hS517ytwG5mespGYyx695fJp
         Pz+GiahuCLNnBIkdAP5BiCMFmot7ngmLj2N42uNQqCNkoU+MymybXFhrpJpAVYh07TTl
         8FzLnMrNcQtmlwU0hy4Jb7koM3ycg1dXmmkGar1M+MMogI2WuXc0VYVfVdLMl8PuSP4r
         d4tZX28YEU6swbFvt88Ri3Bl/3m4GvV38lT5LQj1Reeh7Uz4rMB14K/oGv0aKPsYaWM5
         1JbVtc2CRiTGhdbgSW7JkuFyg8fx2ujBztd55IA0+OrHCcINokDvubi6R+Rvn7V2/FF0
         vT3w==
X-Gm-Message-State: ANoB5pnymvLFdTn3reTqxZAaDZUpmt9lB5KwcSsoPya8WPC9kPJi0pWB
        8j4CHEIYsvzSPSPBkHXONM8K2w==
X-Google-Smtp-Source: AA0mqf5PQ521+yihjzeyfsJKJ4JWk+Io5YpSnmTZL/MABGqC4OUWdtY2+uZKfeMq2gshRjq3UzIxzw==
X-Received: by 2002:a17:90a:440f:b0:218:9894:62c1 with SMTP id s15-20020a17090a440f00b00218989462c1mr61850866pjg.205.1669899740831;
        Thu, 01 Dec 2022 05:02:20 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.81.69])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm4855856pjf.17.2022.12.01.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:02:20 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v14 8/8] irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers
Date:   Thu,  1 Dec 2022 18:31:35 +0530
Message-Id: <20221201130135.1115380-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201130135.1115380-1-apatel@ventanamicro.com>
References: <20221201130135.1115380-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add empty irq_eoi() in RISC-V INTC driver for child irqchip
drivers (such as PLIC, SBI IPI, CLINT, APLIC, IMSIC, etc) which
implement chained handlers for parent per-HART local interrupts.
This hels us avoid unnecessary mask/unmask of per-HART local
interrupts at the time of handling interrupts.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-riscv-intc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 784d25645704..f229e3e66387 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -46,10 +46,27 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
+static void riscv_intc_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * The RISC-V INTC driver uses handle_percpu_devid_irq() flow
+	 * for the per-HART local interrupts and child irqchip drivers
+	 * (such as PLIC, SBI IPI, CLINT, APLIC, IMSIC, etc) implement
+	 * chained handlers for the per-HART local interrupts.
+	 *
+	 * In the absence of irq_eoi(), the chained_irq_enter() and
+	 * chained_irq_exit() functions (used by child irqchip drivers)
+	 * will do unnecessary mask/unmask of per-HART local interrupts
+	 * at the time of handling interrupts. To avoid this, we provide
+	 * an empty irq_eoi() callback for RISC-V INTC irqchip.
+	 */
+}
+
 static struct irq_chip riscv_intc_chip = {
 	.name = "RISC-V INTC",
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
+	.irq_eoi = riscv_intc_irq_eoi,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
-- 
2.34.1

