Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82025BDD80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiITGlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:41:29 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC327DD8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:41:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWsQC5ydxz9skT;
        Tue, 20 Sep 2022 08:41:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y7y0dhBDeTkw; Tue, 20 Sep 2022 08:41:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWsQC53cNz9skB;
        Tue, 20 Sep 2022 08:41:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AA838B76D;
        Tue, 20 Sep 2022 08:41:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GDGpb6lyvrn6; Tue, 20 Sep 2022 08:41:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.12])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 730008B764;
        Tue, 20 Sep 2022 08:41:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28K6fGkK1607373
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:41:16 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28K6fErf1607369;
        Tue, 20 Sep 2022 08:41:14 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/irq: Refactor irq_soft_mask_{set,or}_return()
Date:   Tue, 20 Sep 2022 08:41:08 +0200
Message-Id: <18473da42362ee8f07bce36b9caef8ba77d7633f.1663656054.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663656068; l=1880; s=20211009; h=from:subject:message-id; bh=xfaNeT6yuYfKEL0UY6ZAyg1nr6Q9IyFxFzM006OhTos=; b=T0CHkHta4cs88ufxFa7Hqa2zatSAGWDdHMFWq3YtJvVzRp99MgCHXbcOIPF1gflMUyAKu/3ANxP3 RFpHJBrECLNl7PMHmh/D5MBoxOsfTRASe/t6kSShDi1DhPasbs2D
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partialy reapply commit ef5b570d3700 ("powerpc/irq: Don't
open code irq_soft_mask helpers") which was reverted by
commit 684c68d92e2e ("Revert "powerpc/irq: Don't open code
irq_soft_mask helpers"")

irq_soft_mask_set_return() and irq_soft_mask_or_return()
are overset of irq_soft_mask_set().

Have them use irq_soft_mask_set() instead of duplicating it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/hw_irq.h | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 983551859891..e8de249339d8 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -157,36 +157,18 @@ static inline notrace void irq_soft_mask_set(unsigned long mask)
 
 static inline notrace unsigned long irq_soft_mask_set_return(unsigned long mask)
 {
-	unsigned long flags;
-
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	WARN_ON(mask && !(mask & IRQS_DISABLED));
-#endif
+	unsigned long flags = irq_soft_mask_return();
 
-	asm volatile(
-		"lbz %0,%1(13); stb %2,%1(13)"
-		: "=&r" (flags)
-		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
-		  "r" (mask)
-		: "memory");
+	irq_soft_mask_set(mask);
 
 	return flags;
 }
 
 static inline notrace unsigned long irq_soft_mask_or_return(unsigned long mask)
 {
-	unsigned long flags, tmp;
+	unsigned long flags = irq_soft_mask_return();
 
-	asm volatile(
-		"lbz %0,%2(13); or %1,%0,%3; stb %1,%2(13)"
-		: "=&r" (flags), "=r" (tmp)
-		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
-		  "r" (mask)
-		: "memory");
-
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	WARN_ON((mask | flags) && !((mask | flags) & IRQS_DISABLED));
-#endif
+	irq_soft_mask_set(flags | mask);
 
 	return flags;
 }
-- 
2.37.1

