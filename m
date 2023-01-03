Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F865C1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjACONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbjACONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:13:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3251181A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:13:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so31209704pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOsF09BSv6WEjfktoanH0vG9zVuY2VCJ6w8ZQR8SIzw=;
        b=E8TWf5DkaPepHOkkXVQ+z8+CLsbLMAAvnxqIbnjKBZsOqm5DJLf4puRyphTaXyU7A3
         O20QSTl/gD6BfMbEjrMBswkQ2h+vdKWGGbkpnphb7jN+WHlAF8wJ9JJYAhz3yGD5s/f2
         M4qufJ2rkuyfvuEUfC8iBM8MGVWgvY+NJotvQZHFI7YhFe/5Jv6/ZqFn8lwng1OwLSfA
         8S0bJb64BFUYOOnDUHcZ/6iT6d54Q54fwUs5SN3W4qp3X3nnTy+i7Z3IkQucMwzklVhr
         ahzWYcQ9DvTEWEHqAFDrsnEwT9HyIodujAoltPh0wMNEwmdDz4oe7eQQ2rKO3pAP1FuI
         4YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOsF09BSv6WEjfktoanH0vG9zVuY2VCJ6w8ZQR8SIzw=;
        b=OTD4Ooez5om3P897jdZhLGYTdZ8exCdtx0keWSY6CTtTe2ml7utBrJecD8hLY4MRLW
         4W/UUcjzKmYyfp5UEzj8vCm6Tj2kRpmlXyv4HAVk3iHq9UDj0YSXhUpymsQGesxbdOXP
         TfNFXnVBWchYJKdx70Ad5p30Pq9e8+wLpFOPGTBV/tjucFApQnB4KAfP58+TZJFZvbwa
         FscZ7QKVWmWTrmT2sNiWEpOPVIPgeRWllSYJogI5sKUwMXNJLabTp6pxeJ+gsGhSluoe
         O0JrHjkyuiKsraJ2kE5qYj1nTCZuzVX63wmre+jmCq1WDryfRkzGPScoLJnpZEMNxYz2
         VqgQ==
X-Gm-Message-State: AFqh2kpRoovGoCV/FGAwF6ubSDi3azGd9Ud17G6Ma7TfZfNuLtee2VtK
        j5TIEDLIinGCq3CDD7/aqMHLLw==
X-Google-Smtp-Source: AMrXdXsuVkKXoZiM/PJQ6X7CsAqviLdEWi7Y0fZ02BkzwCJ5cCR4nkdmJMMRGmSCm2P4swYEtm6ULA==
X-Received: by 2002:a17:902:c386:b0:192:709b:9a6a with SMTP id g6-20020a170902c38600b00192709b9a6amr32164806plg.65.1672755196106;
        Tue, 03 Jan 2023 06:13:16 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b00192b0a07891sm8598286pll.101.2023.01.03.06.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:13:15 -0800 (PST)
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
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v16 8/9] irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers
Date:   Tue,  3 Jan 2023 19:42:20 +0530
Message-Id: <20230103141221.772261-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141221.772261-1-apatel@ventanamicro.com>
References: <20230103141221.772261-1-apatel@ventanamicro.com>
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

