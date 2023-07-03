Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954BF7457A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjGCItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGCItN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:49:13 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C7E60
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:49:01 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Qvfj01MBbz9sFf;
        Mon,  3 Jul 2023 10:48:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aC3WJAnODntz; Mon,  3 Jul 2023 10:48:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Qvfhs5Ckwz9sFk;
        Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF7628B768;
        Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zVcttKDZ8PhV; Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 629018B819;
        Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3638mQDu1103947
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 10:48:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3638mQhT1103945;
        Mon, 3 Jul 2023 10:48:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/9] powerpc/kuap: Fold kuep_is_disabled() into its only user
Date:   Mon,  3 Jul 2023 10:48:07 +0200
Message-ID: <ce9ffb23bdee2b0a43c70c8d4745897dc8905d1b.1688373335.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688373335.git.christophe.leroy@csgroup.eu>
References: <cover.1688373335.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688374084; l=1592; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=xPDEUS91RJ+Z0qj6uThAwAk6Rpfb4Lya66JNABcMboc=; b=3dCKsHmAk0EiIxDSfqHtwgi6HAXFQdGksywnocoMDVbBWZIPZ9MGP+qfKsdhVCTlTERiYTZVu S1PvEyi9NssB+mVkPWQgpGluqABtzhXSLXNvglYpUxYM2kWb52Q6W1P
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

kuep_is_disabled() was introduced by commit 91bb30822a2e ("powerpc/32s:
Refactor update of user segment registers") but then all users but one
were removed by commit 526d4a4c77ae ("powerpc/32s: Do kuep_lock() and
kuep_unlock() in assembly").

Fold kuep_is_disabled() into init_new_context() which is its only user.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 5 -----
 arch/powerpc/mm/book3s32/mmu_context.c   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 466a19cfb4df..0da0dea76c47 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -13,11 +13,6 @@
 
 extern struct static_key_false disable_kuap_key;
 
-static __always_inline bool kuep_is_disabled(void)
-{
-	return !IS_ENABLED(CONFIG_PPC_KUEP);
-}
-
 #ifdef CONFIG_PPC_KUAP
 
 #include <linux/sched.h>
diff --git a/arch/powerpc/mm/book3s32/mmu_context.c b/arch/powerpc/mm/book3s32/mmu_context.c
index 269a3eb25a73..1922f9a6b058 100644
--- a/arch/powerpc/mm/book3s32/mmu_context.c
+++ b/arch/powerpc/mm/book3s32/mmu_context.c
@@ -71,7 +71,7 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 	mm->context.id = __init_new_context();
 	mm->context.sr0 = CTX_TO_VSID(mm->context.id, 0);
 
-	if (!kuep_is_disabled())
+	if (IS_ENABLED(CONFIG_PPC_KUEP))
 		mm->context.sr0 |= SR_NX;
 	if (!kuap_is_disabled())
 		mm->context.sr0 |= SR_KS;
-- 
2.41.0

