Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C8641495
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiLCGsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiLCGrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:47:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D16F0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:47:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so6833757pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOsF09BSv6WEjfktoanH0vG9zVuY2VCJ6w8ZQR8SIzw=;
        b=euh/WJv+d/Y/UR2nFG7ACLKlAQLWvS+pspdNbRB2N4/ywmUMocGyzv6imRDqz3xhKH
         hVIldCdSsx3gSImK07Yklld58ZLWhRJphAr12DxQQMawFYKM8pywLrV/uTbV9LLAmDDS
         hkO3PZ89RKY81mdSQ5tkYkGv/19QpikDSfjaQ9c9l6WF4jNeQaqrXyrB1x88IiFy/stj
         oeKNb5wLl3m5IwqB8Igm+5/ongIkEWLlVV71WL0HdF0ei1kY0RX9XFwtmoOPgrlc8MEL
         Um+06X63qygkIXhJ93rF3/Ong8S3f02KGlhQvPM2nJo2TLUyBkBpQuETTzyMtWnUE0jL
         3udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOsF09BSv6WEjfktoanH0vG9zVuY2VCJ6w8ZQR8SIzw=;
        b=ZHY5DZjVjJ9Khbi1CmW+bOosfAI9Y0Ioe1wTs5lhdn0fRWQeWsObaja2zSq7bqT34g
         NTk9oBOyfS0THQlcSLepH5SA83O6nU1c+k+bXn6BIbS23hFUBvGhzrzkTIgDygfGHuRC
         Y3Hi7X4gadL8pdwbkEPjM5Oze2E2jDshX3npE/mWKEvQauzb8A/52fctzswxREUv/uoe
         ooCutk3l6tDSk/Etpfk+Hed07mP9Z31myYEwP8C2Iuf0O6jn5yEbpFLF+CGm74U4uYTX
         2mbysnJ7F2zKFzZNar7fd3F9h2xBb6EMKU23HAt1L32GJs6RT3nMwcNmpsWPEkdfNlC3
         gpZw==
X-Gm-Message-State: ANoB5pnkvhS3EwhCo2XUEDHlx0qoH2fdKsv+5/8JSebafQJMdIbuxJtf
        /yRK/t+h1VxXtuDDzqdqYa1LpQ==
X-Google-Smtp-Source: AA0mqf4cYcNP3uDXkKA9ArYUQffs8SfM8J5dvZeNdcfvt1eItOoV77aq5HziR3bIe/MvkyKpsO/qbA==
X-Received: by 2002:aa7:92d7:0:b0:576:5cc7:8106 with SMTP id k23-20020aa792d7000000b005765cc78106mr6633237pfa.82.1670050051811;
        Fri, 02 Dec 2022 22:47:31 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79471000000b00575c8242849sm6102091pfq.69.2022.12.02.22.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 22:47:31 -0800 (PST)
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
Subject: [PATCH v15 8/9] irqchip/riscv-intc: Add empty irq_eoi() for chained irq handlers
Date:   Sat,  3 Dec 2022 12:16:28 +0530
Message-Id: <20221203064629.1601299-9-apatel@ventanamicro.com>
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

