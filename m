Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCBF63F119
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiLANC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiLANB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:01:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A9AC6E5C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:01:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k5so1774518pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBh16wlKK1pVBXMjv15TuW7j92X6+xaNPp74Ke5cwzg=;
        b=LK0BmkanOqFOZq1Co8XQye3afavPw4jKL+JQozoXHh/ziPTUOdRmLru+J5d5ffrcuT
         wltWSYEDVdM0loHvjrXqktcUYCoGB566FANnIiHhdbX1kjVJ/bHCUUl9HuyKWzxFOOY6
         Us/FvUSWsP/LBCrziBYyz/BBMha05zyadpOzWbzILKIDcop66dGJNvxdraxo1dYXBLfd
         tjcd6F7FYD4j+hDsdTXBtmXAdtJ28FHIftOqmZuC/Fwd7sS3mMPsGtPkK4ykFhlc2IeB
         b9HYDxtWX4eixqBZex6NvVhUM7XOVHbTuk5E4jwVmetUGHYcUupBXjoMtqvMNu1PXyb4
         gN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBh16wlKK1pVBXMjv15TuW7j92X6+xaNPp74Ke5cwzg=;
        b=EfZJCwTHO2SIpaHZ1I/O6dJscmC8MRN0tboEn+0I7vXW5e4n5UoaDgYvSmjGZyYvLL
         VnfVF6ZqQJ1JMlcyRlvKCWE5rFEQkZltHBTXSEQf0LSpesse3C3bYWklgoVBUnFuq35g
         laxIQqt6VzZQKbBk909EnJEJim3zmxKqevk9zGmO8L85hpCI2abBSC/TqGpzW0isSVix
         BvKwOEH02BkTfOZazOnQQZg073OoI46pG6xIGn6S5wbNstJZIi+CWOpodD+8iRkR4JIn
         AknE1/hEiKOoDb5+5VqdMVfQbadzgURzUiDXFJrRlXGCicuw2uhlBdqaoFyp2G9EkbPS
         C/WQ==
X-Gm-Message-State: ANoB5pmveXYQaIqNTuG7Zj65a//pJeUYe0kCoIuqrUN3O1qf6ZN/kZVL
        8NnrOOe1IbUzBpeXUchhmyAmjQ==
X-Google-Smtp-Source: AA0mqf7wBks9PFeUDq8NnVKjelVTwSI3GQ4kEdyKi0/xJpNbcfm+5Le3/nUL+eAyppM87Rct1i5FWw==
X-Received: by 2002:a17:902:d58d:b0:187:2502:888f with SMTP id k13-20020a170902d58d00b001872502888fmr52757656plh.136.1669899714535;
        Thu, 01 Dec 2022 05:01:54 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.81.69])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm4855856pjf.17.2022.12.01.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:01:54 -0800 (PST)
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
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v14 2/8] irqchip/riscv-intc: Allow drivers to directly discover INTC hwnode
Date:   Thu,  1 Dec 2022 18:31:29 +0530
Message-Id: <20221201130135.1115380-3-apatel@ventanamicro.com>
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

Various RISC-V drivers (such as SBI IPI, SBI Timer, SBI PMU, and
KVM RISC-V) don't have associated DT node but these drivers need
standard per-CPU (local) interrupts defined by the RISC-V privileged
specification.

We add riscv_get_intc_hwnode() in arch/riscv which allows RISC-V
drivers not having DT node to discover INTC hwnode which in-turn
helps these drivers to map per-CPU (local) interrupts provided
by the INTC driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/irq.h     |  4 ++++
 arch/riscv/kernel/irq.c          | 18 ++++++++++++++++++
 drivers/irqchip/irq-riscv-intc.c |  7 +++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index e4c435509983..43b9ebfbd943 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -12,6 +12,10 @@
 
 #include <asm-generic/irq.h>
 
+void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
+
+struct fwnode_handle *riscv_get_intc_hwnode(void);
+
 extern void __init init_IRQ(void);
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..96d3171f0ca1 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -7,9 +7,27 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/seq_file.h>
 #include <asm/smp.h>
 
+static struct fwnode_handle *(*__get_intc_node)(void);
+
+void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void))
+{
+	__get_intc_node = fn;
+}
+
+struct fwnode_handle *riscv_get_intc_hwnode(void)
+{
+	if (__get_intc_node)
+		return __get_intc_node();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(riscv_get_intc_hwnode);
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	show_ipi_stats(p, prec);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 499e5f81b3fe..9066467e99e4 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -92,6 +92,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
 	.xlate	= irq_domain_xlate_onecell,
 };
 
+static struct fwnode_handle *riscv_intc_hwnode(void)
+{
+	return intc_domain->fwnode;
+}
+
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
@@ -126,6 +131,8 @@ static int __init riscv_intc_init(struct device_node *node,
 		return rc;
 	}
 
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
 			  "irqchip/riscv/intc:starting",
 			  riscv_intc_cpu_starting,
-- 
2.34.1

