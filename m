Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9972219C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFEI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFEI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:58:54 -0400
X-Greylist: delayed 162 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 01:58:52 PDT
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0875083
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:58:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QZSFk66W0z9sBr;
        Mon,  5 Jun 2023 10:58:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rWPWtAMjftiO; Mon,  5 Jun 2023 10:58:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QZSFk5WDJz9s1X;
        Mon,  5 Jun 2023 10:58:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA2138B776;
        Mon,  5 Jun 2023 10:58:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SzEmAE8Jgjaw; Mon,  5 Jun 2023 10:58:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 901FC8B763;
        Mon,  5 Jun 2023 10:58:50 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3558wg3s050781
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 10:58:42 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3558wgm7050776;
        Mon, 5 Jun 2023 10:58:42 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
Date:   Mon,  5 Jun 2023 10:58:35 +0200
Message-Id: <7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685955512; l=2749; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=RMTGueSHDzqKafetVlF3QOmbe9ITMrXbgHIuvAD0zik=; b=CPrsdxrYnE08wgVnz2TmMhMmNqWHsg4+ey0N40QDgfuLJuiLub26/bPK9h7TWPJGy/nnes3m5 f1zJo3eIxD5AZuaag0RL8FN62weX4gAxuu81po9fB++7yLe8+1p5dPR
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

Looking at generated code for handle_signal32() shows calls to a
function called __unsafe_save_user_regs.constprop.0 while user access
is open.

And that __unsafe_save_user_regs.constprop.0 function has two nops at
the begining, allowing it to be traced, which is unexpected during
user access open window.

The solution could be to mark __unsafe_save_user_regs() no trace, but
to be on the safe side the most efficient is to flag it __always_inline
as already done for function __unsafe_restore_general_regs(). The
function is relatively small and only called twice, so the size
increase will remain in the noise.

Do the same with save_tm_user_regs_unsafe() as it may suffer the
same issue.

Fixes: ef75e7318294 ("powerpc/signal32: Transform save_user_regs() and save_tm_user_regs() in 'unsafe' version")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index c114c7f25645..7a718ed32b27 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -264,8 +264,9 @@ static void prepare_save_user_regs(int ctx_has_vsx_region)
 #endif
 }
 
-static int __unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
-				   struct mcontext __user *tm_frame, int ctx_has_vsx_region)
+static __always_inline int
+__unsafe_save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
+			struct mcontext __user *tm_frame, int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -364,8 +365,9 @@ static void prepare_save_tm_user_regs(void)
 		current->thread.ckvrsave = mfspr(SPRN_VRSAVE);
 }
 
-static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				    struct mcontext __user *tm_frame, unsigned long msr)
+static __always_inline int
+save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
+			 struct mcontext __user *tm_frame, unsigned long msr)
 {
 	/* Save both sets of general registers */
 	unsafe_save_general_regs(&current->thread.ckpt_regs, frame, failed);
@@ -444,8 +446,9 @@ static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user
 #else
 static void prepare_save_tm_user_regs(void) { }
 
-static int save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
-				    struct mcontext __user *tm_frame, unsigned long msr)
+static __always_inline int
+save_tm_user_regs_unsafe(struct pt_regs *regs, struct mcontext __user *frame,
+			 struct mcontext __user *tm_frame, unsigned long msr)
 {
 	return 0;
 }
-- 
2.40.1

