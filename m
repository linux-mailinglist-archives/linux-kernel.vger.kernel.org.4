Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF966E559
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjAQRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjAQRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:51:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9ED29E0C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:41:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7844B81928
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D910C433D2;
        Tue, 17 Jan 2023 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673977285;
        bh=7sRYg3qUp1zqUtwwm1zqghInj+DpINupYaUM6cJPwO8=;
        h=From:To:Cc:Subject:Date:From;
        b=jLFCnswtz4VyxrS6RmPl+G0KohWAEBrP/xQVe0QM4oFIAeV178SCKf2YcB5/Gy+1R
         82q7Twb1dVKGrcayBFFq7Ov1TCqPb3GgffeGl0tgV/p9O5YzNJMu66yT3Fi6HOUGLN
         He949qf8kqPfHYFSW4kivpWFjVtDQWDxViyjz3RHVYye61fIqRlMG5lPgUQONrfybC
         GkUx5mJyC6pNbtuTbdV8fS8VR2pIs80x8qb3m6VrcQiihU1i34Dwm2VzIcwpZ7B2kC
         6Tg8k3qpP+1hKeNh2LFP+l5K0U2AjW+rBPS7v55+Lobi8xC41eECeBwQz9R8RJSTF4
         dokrtgual6pGw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: irq: remove handle_IRQ() for good
Date:   Tue, 17 Jan 2023 18:40:47 +0100
Message-Id: <20230117174117.3314951-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only difference between generic_handle_irq() and the ARM
handle_IRQ() version is now the range check, and in the remaining
drivers this does not appear to be needed any more.

Remove this old interface and use the generic version in its place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/irq.h  |  4 ----
 arch/arm/kernel/irq.c       | 25 -------------------------
 arch/arm/mach-dove/irq.c    |  6 ++----
 arch/arm/mach-mv78xx0/irq.c |  9 +++------
 arch/arm/mach-orion5x/irq.c |  3 +--
 arch/arm/mach-pxa/irq.c     |  4 ++--
 6 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index a7c2337b0c7d..f62fa9f36192 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -23,10 +23,6 @@
 #endif
 
 #ifndef __ASSEMBLY__
-struct irqaction;
-struct pt_regs;
-
-void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
 #ifdef CONFIG_SMP
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index fe28fc1f759d..e0983269729f 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -96,31 +96,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
-/*
- * handle_IRQ handles all hardware IRQ's.  Decoded IRQs should
- * not come via this function.  Instead, they should provide their
- * own 'handler'.  Used by platform code implementing C-based 1st
- * level decoding.
- */
-void handle_IRQ(unsigned int irq, struct pt_regs *regs)
-{
-	struct irq_desc *desc;
-
-	/*
-	 * Some hardware gives randomly wrong interrupts.  Rather
-	 * than crashing, do something sensible.
-	 */
-	if (unlikely(!irq || irq >= nr_irqs))
-		desc = NULL;
-	else
-		desc = irq_to_desc(irq);
-
-	if (likely(desc))
-		handle_irq_desc(desc);
-	else
-		ack_bad_irq(irq);
-}
-
 void __init init_IRQ(void)
 {
 	int ret;
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 027a8f87bc2e..500f097e09b3 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -47,15 +47,13 @@ __exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
 	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_LOW_OFF);
 	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_LOW_OFF);
 	if (stat) {
-		unsigned int hwirq = 1 + __fls(stat);
-		handle_IRQ(hwirq, regs);
+		generic_handle_irq(1 + __fls(stat));
 		return;
 	}
 	stat = readl_relaxed(dove_irq_base + IRQ_CAUSE_HIGH_OFF);
 	stat &= readl_relaxed(dove_irq_base + IRQ_MASK_HIGH_OFF);
 	if (stat) {
-		unsigned int hwirq = 33 + __fls(stat);
-		handle_IRQ(hwirq, regs);
+		generic_handle_irq(33 + __fls(stat));
 		return;
 	}
 }
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index a34b6855fb19..6114ccbcdab2 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -31,22 +31,19 @@ __exception_irq_entry mv78xx0_legacy_handle_irq(struct pt_regs *regs)
 	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_LOW_OFF);
 	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_LOW_OFF);
 	if (stat) {
-		unsigned int hwirq = __fls(stat);
-		handle_IRQ(hwirq, regs);
+		generic_handle_irq(__fls(stat));
 		return;
 	}
 	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_HIGH_OFF);
 	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_HIGH_OFF);
 	if (stat) {
-		unsigned int hwirq = 32 + __fls(stat);
-		handle_IRQ(hwirq, regs);
+		generic_handle_irq(32 + __fls(stat));
 		return;
 	}
 	stat = readl_relaxed(mv78xx0_irq_base + IRQ_CAUSE_ERR_OFF);
 	stat &= readl_relaxed(mv78xx0_irq_base + IRQ_MASK_ERR_OFF);
 	if (stat) {
-		unsigned int hwirq = 64 + __fls(stat);
-		handle_IRQ(hwirq, regs);
+		generic_handle_irq(64 + __fls(stat));
 		return;
 	}
 }
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index e17727e53cb4..41d08934a918 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -31,8 +31,7 @@ __exception_irq_entry orion5x_legacy_handle_irq(struct pt_regs *regs)
 	stat = readl_relaxed(MAIN_IRQ_CAUSE);
 	stat &= readl_relaxed(MAIN_IRQ_MASK);
 	if (stat) {
-		unsigned int hwirq = 1 + __fls(stat);
-		handle_IRQ(hwirq, regs);
+		generic_handle_irq(1 + __fls(stat));
 		return;
 	}
 }
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 96f33ef1d9ea..1fe551b60eed 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -101,7 +101,7 @@ asmlinkage void __exception_irq_entry icip_handle_irq(struct pt_regs *regs)
 		if (mask == 0)
 			break;
 
-		handle_IRQ(PXA_IRQ(fls(mask) - 1), regs);
+		generic_handle_irq(PXA_IRQ(fls(mask) - 1));
 	} while (1);
 }
 
@@ -115,7 +115,7 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 		if ((ichp & ICHP_VAL_IRQ) == 0)
 			break;
 
-		handle_IRQ(PXA_IRQ(ICHP_IRQ(ichp)), regs);
+		generic_handle_irq(PXA_IRQ(ICHP_IRQ(ichp)));
 	} while (1);
 }
 
-- 
2.39.0

