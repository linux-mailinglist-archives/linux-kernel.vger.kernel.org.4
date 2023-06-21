Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE947380FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjFUKog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjFUKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:44:10 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB721703
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:41:33 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QmKmD2KmZz9sDc;
        Wed, 21 Jun 2023 12:41:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kpcc0gyebTFj; Wed, 21 Jun 2023 12:41:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QmKmD1h8Jz9sCn;
        Wed, 21 Jun 2023 12:41:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 371D08B779;
        Wed, 21 Jun 2023 12:41:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EOZYyjJo5etZ; Wed, 21 Jun 2023 12:41:00 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21FA78B763;
        Wed, 21 Jun 2023 12:41:00 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35LAeuO92083234
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 12:40:56 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35LAeuQ42083232;
        Wed, 21 Jun 2023 12:40:56 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/reg: Remove #ifdef around mtspr macro
Date:   Wed, 21 Jun 2023 12:40:50 +0200
Message-Id: <cf652e47ea9e453e89813611b6f76d0939a12063.1687344017.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687344048; l=1049; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=sKHYPFEB7TP+JXjhLGDSqU3HLQ2duX1yFQEbt9lsW2A=; b=O2OSZdjAa2G8eBgXDBaanA/RIkSXrBvrRD9j1Ge7I/IcGru6gxCaXzZIiRxYwRW+5WgmIGB/Y UWnufyymAbzCbg0ZjANcB+PUeYGr6M7B3VBCFJi9c8DrGcgO99hb34X
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That ifdef was introduced by commit 1458dd951f7c ("powerpc/8xx:
Handle CPU6 ERRATA directly in mtspr() macro") and left over by
commit 2a45addd21de ("powerpc/8xx: Remove CPU6 ERRATA Workaround")

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/reg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index bb0121222ee3..4ae4ab9090a2 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1414,11 +1414,9 @@ static inline void mtmsr_isync(unsigned long val)
 #define mfspr(rn)	({unsigned long rval; \
 			asm volatile("mfspr %0," __stringify(rn) \
 				: "=r" (rval)); rval;})
-#ifndef mtspr
 #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : \
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
-#endif
 #define wrtspr(rn)	asm volatile("mtspr " __stringify(rn) ",2" : : : "memory")
 
 static inline void wrtee(unsigned long val)
-- 
2.40.1

