Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D525BDD81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiITGl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiITGlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:41:47 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C55755A5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:41:46 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MWsQc72myz9skc;
        Tue, 20 Sep 2022 08:41:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WNKj4NCcytQc; Tue, 20 Sep 2022 08:41:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MWsQb6Jzxz9skB;
        Tue, 20 Sep 2022 08:41:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8AFC8B76D;
        Tue, 20 Sep 2022 08:41:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8k7mSurLH5to; Tue, 20 Sep 2022 08:41:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.12])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FEE88B764;
        Tue, 20 Sep 2022 08:41:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28K6fYVN1607407
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:41:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28K6fY7T1607404;
        Tue, 20 Sep 2022 08:41:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/irq: Modernise inline assembly in irq_soft_mask_{set,return}
Date:   Tue, 20 Sep 2022 08:41:28 +0200
Message-Id: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663656086; l=1658; s=20211009; h=from:subject:message-id; bh=9GEx36HJ5/FfDi1dx6YvjaaoBbioX39W24JCLk5Suh0=; b=+0srDpNF4WhGQedCfhlunENf/K/k6Gr6nhlJ8mzBeINfIeztz2JrkXSV0SBg37WT6uD3skB8fNjR K9D8xoquDCpL7LOjHGDPMkiQ+BdQwXsCe3UXQCYTXCoca/PA5BLl
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

local_paca is declared as global register asm("r13"), it is therefore
garantied to always ever be r13.

It is therefore not required to opencode r13 in the assembly, use
a reference to local_paca->irq_soft_mask instead.

This also allows removing the 'memory' clobber in irq_soft_mask_set()
as GCC now knows what is being modified in memory.

Using %X modifier will give GCC a bit more flexibility on the code
generation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/hw_irq.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e8de249339d8..dbe037ff4474 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -115,10 +115,7 @@ static inline notrace unsigned long irq_soft_mask_return(void)
 {
 	unsigned long flags;
 
-	asm volatile(
-		"lbz %0,%1(13)"
-		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, irq_soft_mask)));
+	asm volatile("lbz%X1 %0,%1" : "=r" (flags) : "m" (local_paca->irq_soft_mask));
 
 	return flags;
 }
@@ -147,12 +144,7 @@ static inline notrace void irq_soft_mask_set(unsigned long mask)
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
 		WARN_ON(mask && !(mask & IRQS_DISABLED));
 
-	asm volatile(
-		"stb %0,%1(13)"
-		:
-		: "r" (mask),
-		  "i" (offsetof(struct paca_struct, irq_soft_mask))
-		: "memory");
+	asm volatile("stb%X0 %1,%0" : "=m" (local_paca->irq_soft_mask) : "r" (mask));
 }
 
 static inline notrace unsigned long irq_soft_mask_set_return(unsigned long mask)
-- 
2.37.1

