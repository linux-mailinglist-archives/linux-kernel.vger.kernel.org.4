Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF674F477
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjGKQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjGKQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:09:11 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A736170E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:09:06 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m5J1mWXz9sFG;
        Tue, 11 Jul 2023 18:08:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bjUmF-090Jdn; Tue, 11 Jul 2023 18:08:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m5C4fMtz9sFH;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 995388B763;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aGPtJYGvoTuZ; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E99558B786;
        Tue, 11 Jul 2023 18:08:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8j7L3696840
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:45 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8jfA3696839;
        Tue, 11 Jul 2023 18:08:45 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 10/15] objtool: When looking for switch tables also follow conditional and dynamic jumps
Date:   Tue, 11 Jul 2023 18:08:36 +0200
Message-ID: <a3482907d27f322f5964f84839e353dae3f776c8.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091706; l=1625; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=7B3IwCMH2qMhNo/Facke61evDmjUB4eFAtkLyw+hLRo=; b=1BcJQ85Afh6/r5Nw55zkzMYE4OQTPNmvxxnghSaaTTs7hooC3g9/S2b1Yhh/LtE1j1+tu6uGz hoe9MWxOkncCBOEiHMIxHbkSQPcpBh6i9S0ZEjNVmGPBUBwx8qQulPu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When walking backward to find the base address of a switch table,
also take into account conditionnal branches and dynamic jumps from
a previous switch table.

To avoid mis-routing, break when stumbling on a function return.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/check.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 361c832aefc8..ea0945f2195f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2034,6 +2034,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->next = insn->alts;
 		insn->alts = alt;
 		prev_offset = reloc_offset(reloc);
+		if (!dest_insn->first_jump_src)
+			dest_insn->first_jump_src = insn;
 	}
 
 	if (!prev_offset) {
@@ -2068,6 +2070,9 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		    insn->gpr == orig_insn->gpr)
 			break;
 
+		if (insn->type == INSN_RETURN)
+			break;
+
 		/* allow small jumps within the range */
 		if (insn->type == INSN_JUMP_UNCONDITIONAL &&
 		    insn->jump_dest &&
@@ -2130,8 +2135,7 @@ static int mark_add_func_jump_tables(struct objtool_file *file,
 		 * that find_jump_table() can back-track using those and
 		 * avoid some potentially confusing code.
 		 */
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
-		    insn->offset > last->offset &&
+		if (is_static_jump(insn) && insn->jump_dest &&
 		    insn->jump_dest->offset > insn->offset &&
 		    !insn->jump_dest->first_jump_src) {
 
-- 
2.41.0

