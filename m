Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40D6AEADC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjCGRiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCGRhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:37:24 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F37C3C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:33:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id a9so14887502plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678210402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7s+91AtfNZFr11BBB79AwltySbIUEsIHQ1Gjnv2r90=;
        b=YTWXHNmU3Hc0XfTZfvFMvruc2cQ9hnzedj7ZkwO5SHSf1i826p8VXu0CSgOmw3sEuz
         axKHZNIeR/th3QaA/yV6b5AZMnLsblZMRHG3T5HKXos+s/gBIBydn8ZA/U+vr18J9BWH
         NegD9ptHCwFrVFzxrJSLCT/zEl3GiSfks6/11ihSiHydYPZXH4hQ/YruwdwPI+X47x5V
         7Vu9/BY42gjkqKPWdezFXi5W9kNPnXNnNcxHhvruX9ZUpq5wxaT6HST/EWFQyl1asuBS
         qtsP8tOVDKwf6Oft1NhTeoUyzuFlLfFLejxnGCYq0a9IA8pRUIt2tTlIJ2L4JzDPPt88
         vTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7s+91AtfNZFr11BBB79AwltySbIUEsIHQ1Gjnv2r90=;
        b=XzptVeCrVemzDVoFFk3iSy/Ia7mn4h0vlLxNUy7LxCytUwfmwMXwtxWzAFZ/ZfNEF0
         2NJ3zIQyVNjXtun6pICsFnZlzwTauZ2b/PUYwVlcRJQaMLrW1raBc/TmROKE/LJv506k
         8OYrOV0qCfn0u5MSL1mBhVTIO3yfvwiaTYrW63s79591Xk517bO7VASqDCjrnuQwvd0U
         gtBQ7tO/MNXIGVO1WHSPaFwFMd+QFGMBfrTMAd7ziZ94WGzg6QSqeJENou713s1aNjue
         LDFGZ40Y8iBPaJ32QN5Qq6TZ9jVN09WGrTVfhAOAT9TqerIOmNRcQ1ygeLyIPq0ayq/7
         QMNg==
X-Gm-Message-State: AO0yUKXwVs/OdURRjwikq4KJQ4hB1l439fmGe5ea058lk7oYIJb/dhm6
        kO3BZuEVS5ewzrEGTY2UEaswvw==
X-Google-Smtp-Source: AK7set9P3Xbi72+G+xm28XWsz1BZjXh4gBXZE7BHzOVDDQ3CSdHSkQXa+8ZcFv1MLnww7/0wJpQ/Aw==
X-Received: by 2002:a05:6a20:1447:b0:cd:87ef:3f33 with SMTP id a7-20020a056a20144700b000cd87ef3f33mr19970346pzi.29.1678210401853;
        Tue, 07 Mar 2023 09:33:21 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 1-20020a630301000000b004fb11a7f2d4sm7996185pgd.57.2023.03.07.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 09:33:21 -0800 (PST)
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
        asahi@lists.linux.dev, Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v17 7/7] irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers
Date:   Tue,  7 Mar 2023 23:02:31 +0530
Message-Id: <20230307173231.2189275-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307173231.2189275-1-apatel@ventanamicro.com>
References: <20230307173231.2189275-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

