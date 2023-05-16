Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1A70584F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEPUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEPUFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0F25FCA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C1063297
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C759C433D2;
        Tue, 16 May 2023 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267531;
        bh=C26ece4b4niNCvvb1qP08GjRXSjksKycT9Ijfpwgod4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rh94Is4ld9AwD+rwDThBnzTSVBiyElsidNrl9ySKDLQRqe1mIrE7X8/URRqlonQr4
         5hrSbqKtub2yY2dh7lkfTVeZ5NnqdKeIaWNOCjKlpCNkWfhEknljqJ/A2zKQLmvsjR
         X8/i4LjAa3zTuj5TJPBCnZwPcAudObRm1vDj7s11rPGNVA2dc4AsCjgMn4CWAisiCh
         JA57/jxmieVogCW5eSl0PuaV6csVYbtP5GWhhr3ENswHpKE56E4klt4tS93p1dmAC+
         kW274DrTm54///5TPhedAhX2upKFCOHpz9RQiQqvNUoGZogiP7e4V5SFH86K+rPb2V
         JNzon1xp6xu7w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] irqchip: mmp: remove non-DT codepath
Date:   Tue, 16 May 2023 22:05:05 +0200
Message-Id: <20230516200516.554663-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516200516.554663-1-arnd@kernel.org>
References: <20230516200516.554663-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with "W=1" warns about missing declarations for
two functions in the mmp irqchip driver:

drivers/irqchip/irq-mmp.c:248:13: error: no previous prototype for 'icu_init_irq'
drivers/irqchip/irq-mmp.c:271:13: error: no previous prototype for 'mmp2_init_icu'

The declarations are present in an unused header, but since there is no
caller, it's best to just remove the functions and the header completely,
making the driver DT-only to match the state of the platform.

Fixes: 77acc85ce797 ("ARM: mmp: remove device definitions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-mmp.c   | 127 ------------------------------------
 include/linux/irqchip/mmp.h |  10 ---
 2 files changed, 137 deletions(-)
 delete mode 100644 include/linux/irqchip/mmp.h

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 83455ca72439..25cf4f80e767 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -244,132 +244,6 @@ static void __exception_irq_entry mmp2_handle_irq(struct pt_regs *regs)
 	generic_handle_domain_irq(icu_data[0].domain, hwirq);
 }
 
-/* MMP (ARMv5) */
-void __init icu_init_irq(void)
-{
-	int irq;
-
-	max_icu_nr = 1;
-	mmp_icu_base = ioremap(0xd4282000, 0x1000);
-	icu_data[0].conf_enable = mmp_conf.conf_enable;
-	icu_data[0].conf_disable = mmp_conf.conf_disable;
-	icu_data[0].conf_mask = mmp_conf.conf_mask;
-	icu_data[0].nr_irqs = 64;
-	icu_data[0].virq_base = 0;
-	icu_data[0].domain = irq_domain_add_legacy(NULL, 64, 0, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[0]);
-	for (irq = 0; irq < 64; irq++) {
-		icu_mask_irq(irq_get_irq_data(irq));
-		irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
-	}
-	irq_set_default_host(icu_data[0].domain);
-	set_handle_irq(mmp_handle_irq);
-}
-
-/* MMP2 (ARMv7) */
-void __init mmp2_init_icu(void)
-{
-	int irq, end;
-
-	max_icu_nr = 8;
-	mmp_icu_base = ioremap(0xd4282000, 0x1000);
-	icu_data[0].conf_enable = mmp2_conf.conf_enable;
-	icu_data[0].conf_disable = mmp2_conf.conf_disable;
-	icu_data[0].conf_mask = mmp2_conf.conf_mask;
-	icu_data[0].nr_irqs = 64;
-	icu_data[0].virq_base = 0;
-	icu_data[0].domain = irq_domain_add_legacy(NULL, 64, 0, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[0]);
-	icu_data[1].reg_status = mmp_icu_base + 0x150;
-	icu_data[1].reg_mask = mmp_icu_base + 0x168;
-	icu_data[1].clr_mfp_irq_base = icu_data[0].virq_base +
-				icu_data[0].nr_irqs;
-	icu_data[1].clr_mfp_hwirq = 1;		/* offset to IRQ_MMP2_PMIC_BASE */
-	icu_data[1].nr_irqs = 2;
-	icu_data[1].cascade_irq = 4;
-	icu_data[1].virq_base = icu_data[0].virq_base + icu_data[0].nr_irqs;
-	icu_data[1].domain = irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
-						   icu_data[1].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[1]);
-	icu_data[2].reg_status = mmp_icu_base + 0x154;
-	icu_data[2].reg_mask = mmp_icu_base + 0x16c;
-	icu_data[2].nr_irqs = 2;
-	icu_data[2].cascade_irq = 5;
-	icu_data[2].virq_base = icu_data[1].virq_base + icu_data[1].nr_irqs;
-	icu_data[2].domain = irq_domain_add_legacy(NULL, icu_data[2].nr_irqs,
-						   icu_data[2].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[2]);
-	icu_data[3].reg_status = mmp_icu_base + 0x180;
-	icu_data[3].reg_mask = mmp_icu_base + 0x17c;
-	icu_data[3].nr_irqs = 3;
-	icu_data[3].cascade_irq = 9;
-	icu_data[3].virq_base = icu_data[2].virq_base + icu_data[2].nr_irqs;
-	icu_data[3].domain = irq_domain_add_legacy(NULL, icu_data[3].nr_irqs,
-						   icu_data[3].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[3]);
-	icu_data[4].reg_status = mmp_icu_base + 0x158;
-	icu_data[4].reg_mask = mmp_icu_base + 0x170;
-	icu_data[4].nr_irqs = 5;
-	icu_data[4].cascade_irq = 17;
-	icu_data[4].virq_base = icu_data[3].virq_base + icu_data[3].nr_irqs;
-	icu_data[4].domain = irq_domain_add_legacy(NULL, icu_data[4].nr_irqs,
-						   icu_data[4].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[4]);
-	icu_data[5].reg_status = mmp_icu_base + 0x15c;
-	icu_data[5].reg_mask = mmp_icu_base + 0x174;
-	icu_data[5].nr_irqs = 15;
-	icu_data[5].cascade_irq = 35;
-	icu_data[5].virq_base = icu_data[4].virq_base + icu_data[4].nr_irqs;
-	icu_data[5].domain = irq_domain_add_legacy(NULL, icu_data[5].nr_irqs,
-						   icu_data[5].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[5]);
-	icu_data[6].reg_status = mmp_icu_base + 0x160;
-	icu_data[6].reg_mask = mmp_icu_base + 0x178;
-	icu_data[6].nr_irqs = 2;
-	icu_data[6].cascade_irq = 51;
-	icu_data[6].virq_base = icu_data[5].virq_base + icu_data[5].nr_irqs;
-	icu_data[6].domain = irq_domain_add_legacy(NULL, icu_data[6].nr_irqs,
-						   icu_data[6].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[6]);
-	icu_data[7].reg_status = mmp_icu_base + 0x188;
-	icu_data[7].reg_mask = mmp_icu_base + 0x184;
-	icu_data[7].nr_irqs = 2;
-	icu_data[7].cascade_irq = 55;
-	icu_data[7].virq_base = icu_data[6].virq_base + icu_data[6].nr_irqs;
-	icu_data[7].domain = irq_domain_add_legacy(NULL, icu_data[7].nr_irqs,
-						   icu_data[7].virq_base, 0,
-						   &irq_domain_simple_ops,
-						   &icu_data[7]);
-	end = icu_data[7].virq_base + icu_data[7].nr_irqs;
-	for (irq = 0; irq < end; irq++) {
-		icu_mask_irq(irq_get_irq_data(irq));
-		if (irq == icu_data[1].cascade_irq ||
-		    irq == icu_data[2].cascade_irq ||
-		    irq == icu_data[3].cascade_irq ||
-		    irq == icu_data[4].cascade_irq ||
-		    irq == icu_data[5].cascade_irq ||
-		    irq == icu_data[6].cascade_irq ||
-		    irq == icu_data[7].cascade_irq) {
-			irq_set_chip(irq, &icu_irq_chip);
-			irq_set_chained_handler(irq, icu_mux_irq_demux);
-		} else {
-			irq_set_chip_and_handler(irq, &icu_irq_chip,
-						 handle_level_irq);
-		}
-	}
-	irq_set_default_host(icu_data[0].domain);
-	set_handle_irq(mmp2_handle_irq);
-}
-
-#ifdef CONFIG_OF
 static int __init mmp_init_bases(struct device_node *node)
 {
 	int ret, nr_irqs, irq, i = 0;
@@ -548,4 +422,3 @@ static int __init mmp2_mux_of_init(struct device_node *node,
 	return -EINVAL;
 }
 IRQCHIP_DECLARE(mmp2_mux_intc, "mrvl,mmp2-mux-intc", mmp2_mux_of_init);
-#endif
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
deleted file mode 100644
index aa1813749a4f..000000000000
--- a/include/linux/irqchip/mmp.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef	__IRQCHIP_MMP_H
-#define	__IRQCHIP_MMP_H
-
-extern struct irq_chip icu_irq_chip;
-
-extern void icu_init_irq(void);
-extern void mmp2_init_icu(void);
-
-#endif	/* __IRQCHIP_MMP_H */
-- 
2.39.2

