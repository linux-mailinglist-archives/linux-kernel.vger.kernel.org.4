Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854376CB52A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjC1DyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjC1Dxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:53:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817642723
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:53:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso796392pjf.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679975592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7s+91AtfNZFr11BBB79AwltySbIUEsIHQ1Gjnv2r90=;
        b=GEjjNtl9m0uaQ14T5Cp1Xzcub+kVAmI1XQP1g3dY3m8lo5LAKKLNNVYVlxv7+bKlMA
         aRe3MlgyoNB6TZOAM3CmHphWZB7MwQpq0xEz1SPLpc9j43+L+WzMCZhR2jJHCsZrxxBg
         oauGLWdq3+weB5U+6utGq3PfFDXlHAfL36MmLcIh4IxAF9oCkYpIUhILDb6O1c2kMBCC
         GkI1ZvIh6E/Zh4Qbn3Jz8fcQj3inLGLdNzP3RyHR3tiTE9dzWt6EdvPV+wzYExHZX7ZE
         ZMoysS6lt4jlK4loF2zpDXRDDPEoWJaT5LhD8kuYoUoxU0iK7elxFMScvp0V6EnJi2lE
         yPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7s+91AtfNZFr11BBB79AwltySbIUEsIHQ1Gjnv2r90=;
        b=cKNTfxl8G1XBiiFve1D3GSZlT2x15TmZQlDwWpHQ4tRUafqczsQVVx56RH235NNrCa
         3M7PzGvBWZk1YyumDYFQX+lKXbjimlVel4GcXHZxqdOdztk0cmOqS4mrwzx8rau+ZA2m
         V+YkUztS6UpiJqnkbARzdownHIRePhduJt9TAdaBgIIEcacCkzO3h89KM2KP1x40uxc6
         vxxpyFAXLTzzWHHrsddOllxCAxnN1UiF6xpTl+yu6e/7yiXf1duPEq0PWiR/fHf6A5n4
         wVfZ3lfhsEMMh+ZGkHLudhh1gpihWNZfyt+BgEW7ow1AmFlHd6tXhpX9ejKLpz9PLxNS
         uHEQ==
X-Gm-Message-State: AAQBX9cNa7dDifpFC6zIFsRL1PJIL1fmOkT73TBkWAWvt3eiHT4Gy2Jm
        DxgwXtaF9WiSdwC3ZnPWar2pfw==
X-Google-Smtp-Source: AKy350blb+cJVDOCRTgjKfm7KJqOhQzjeIhTlA8ZV+SWnKT1CdLB9KsiVTmjKDZxHKrOPWQ3G5xUKw==
X-Received: by 2002:a17:90b:3b90:b0:23f:a674:dc0b with SMTP id pc16-20020a17090b3b9000b0023fa674dc0bmr16062620pjb.15.1679975591902;
        Mon, 27 Mar 2023 20:53:11 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.82.104])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b0019cb534a824sm19880278pll.172.2023.03.27.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:53:11 -0700 (PDT)
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
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v18 7/7] irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers
Date:   Tue, 28 Mar 2023 09:22:23 +0530
Message-Id: <20230328035223.1480939-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328035223.1480939-1-apatel@ventanamicro.com>
References: <20230328035223.1480939-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
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

