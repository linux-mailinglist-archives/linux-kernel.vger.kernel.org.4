Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671D764023E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiLBIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiLBIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:34:00 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA61B8463
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:32:09 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4NNmQG1lDcz9sYc;
        Fri,  2 Dec 2022 09:32:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NXpXyakorzIP; Fri,  2 Dec 2022 09:32:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4NNmQF3JRjz9sYf;
        Fri,  2 Dec 2022 09:32:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 617918B763;
        Fri,  2 Dec 2022 09:32:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fir5lhI6-aKN; Fri,  2 Dec 2022 09:32:05 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.19])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 075E78B781;
        Fri,  2 Dec 2022 09:32:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2B28VqQG273735
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 09:31:52 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2B28VqNn273734;
        Fri, 2 Dec 2022 09:31:52 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, bgray@linux.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] powerpc/code-patching: Remove protection against patching init addresses after init
Date:   Fri,  2 Dec 2022 09:31:43 +0100
Message-Id: <504310828f473d424e2ed229eff57bf075f52796.1669969781.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <f67d2a109404d03e8fdf1ea15388c8778337a76b.1669969781.git.christophe.leroy@csgroup.eu>
References: <f67d2a109404d03e8fdf1ea15388c8778337a76b.1669969781.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669969790; l=2535; s=20211009; h=from:subject:message-id; bh=nOnMnzMbg/uGrb4Fx/wPKbQFpaiwBP9S4AOq00Fb1JI=; b=3ovNCqJz4ZfpWdiIHGgXE2+7LbK7EZ8oo6+EWngQ4Q9YW/dYOW93/T7VWBgs90bpm7nChPSrjO54 JEGZjDYkDtw+KpvHs4wxK/irKxkeJpQyMADahXv5zXmgEsinM1pl
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once init section is freed, attempting to patch init code
ends up in the weed.

Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
protected patch_instruction() against that, but it is the responsibility
of the caller to ensure that the patched memory is valid.

All callers have now been verified and fixed so the check
can be removed.

This improves ftrace activation by about 2% on 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h |  2 --
 arch/powerpc/lib/code-patching.c         | 13 +------------
 arch/powerpc/mm/mem.c                    |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 1c6316ec4b74..3f881548fb61 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -22,8 +22,6 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
-DECLARE_STATIC_KEY_FALSE(init_mem_is_free);
-
 /*
  * Powerpc branch instruction is :
  *
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 98a7bbfc8f67..eae355892396 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -349,7 +349,7 @@ static int __do_patch_instruction(u32 *addr, ppc_inst_t instr)
 	return err;
 }
 
-static int do_patch_instruction(u32 *addr, ppc_inst_t instr)
+int patch_instruction(u32 *addr, ppc_inst_t instr)
 {
 	int err;
 	unsigned long flags;
@@ -372,17 +372,6 @@ static int do_patch_instruction(u32 *addr, ppc_inst_t instr)
 
 	return err;
 }
-
-__ro_after_init DEFINE_STATIC_KEY_FALSE(init_mem_is_free);
-
-int patch_instruction(u32 *addr, ppc_inst_t instr)
-{
-	/* Make sure we aren't patching a freed init section */
-	if (static_branch_likely(&init_mem_is_free) && init_section_contains(addr, 4))
-		return 0;
-
-	return do_patch_instruction(addr, instr);
-}
 NOKPROBE_SYMBOL(patch_instruction);
 
 int patch_branch(u32 *addr, unsigned long target, int flags)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 84d171953ba4..8b121df7b08f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -344,7 +344,6 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	mark_initmem_nx();
-	static_branch_enable(&init_mem_is_free);
 	free_initmem_default(POISON_FREE_INITMEM);
 	ftrace_free_init_tramp();
 }
-- 
2.38.1

