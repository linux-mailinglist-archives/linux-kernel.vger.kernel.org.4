Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE55ED4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiI1G3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiI1G3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:29:41 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E14433E03
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:29:40 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Mcmmy3BMGz9smH;
        Wed, 28 Sep 2022 08:29:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DB3Kn1yo_E4X; Wed, 28 Sep 2022 08:29:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Mcmmy2V9Pz9sm8;
        Wed, 28 Sep 2022 08:29:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46B598B776;
        Wed, 28 Sep 2022 08:29:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id axZ4ohyAlod8; Wed, 28 Sep 2022 08:29:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.79])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 13CB18B763;
        Wed, 28 Sep 2022 08:29:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28S6TSBQ420597
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:29:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28S6TSjm420589;
        Wed, 28 Sep 2022 08:29:28 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Reverse order entries are written by __set_pte_at()
Date:   Wed, 28 Sep 2022 08:29:22 +0200
Message-Id: <67c3b5d44edfec054234ea9b4d05fc4b4f7f8a0e.1664346554.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664346561; l=1335; s=20211009; h=from:subject:message-id; bh=9jZTVJ2VbndZFa3uCBcaKraZQEZwRNNQzKTSqN0XjYs=; b=x3aiEwbdWETYXnoMgSUQ4vScKUXvO35e+NmF2BGUCWwaaLzYkERsDDpQPqYI7Tm7eMvgSzdg81aX Nx7w8fJEDYcLFfdoMM/2J+u0xx5e55g6Te9cFVsEH0NrEfGTYuOM
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, with 16k pages __set_pte_at() writes table entries
in reverse order:

 294:	91 49 00 0c 	stw     r10,12(r9)
 298:	91 49 00 08 	stw     r10,8(r9)
 29c:	91 49 00 04 	stw     r10,4(r9)
 2a0:	91 49 00 00 	stw     r10,0(r9)

Allthough there should be no impact at all as it stays in a single
cacheline, reverse the writing in a more natural order.

 288:	91 49 00 0c 	stw     r10,0(r9)
 28c:	91 49 00 08 	stw     r10,4(r9)
 290:	91 49 00 04 	stw     r10,8(r9)
 294:	91 49 00 00 	stw     r10,12(r9)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 4fd73c7412d0..d2e39823af09 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -183,7 +183,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
-	ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
+	ptep->pte3 = ptep->pte2 = ptep->pte1 = ptep->pte = pte_val(pte);
 #else
 	*ptep = pte;
 #endif
-- 
2.37.1

