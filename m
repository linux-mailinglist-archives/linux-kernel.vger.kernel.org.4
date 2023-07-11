Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8674F48C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjGKQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjGKQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:11:14 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED61FF6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:10:57 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m5V4hWyz9sFP;
        Tue, 11 Jul 2023 18:09:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s0xjpf3Cf8Xk; Tue, 11 Jul 2023 18:09:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m5C609Hz9sFR;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C9C828B763;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id giaowgQi7Vvt; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D7F0E8B77D;
        Tue, 11 Jul 2023 18:08:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8j0U3696832
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:45 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8jRf3696831;
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
Subject: [PATCH v4 08/15] objtool: Track general purpose register used for switch table base
Date:   Tue, 11 Jul 2023 18:08:34 +0200
Message-ID: <09a51f61dca0eb7d2a448b88d9b4ef2853df229f.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091705; l=5330; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=jSX08wGhmyYeQdnc4/mndFd0/Va8aTjRzvV2Pq5SbcY=; b=AWO4XAaGal72ZQpHsbX4CCq0Ln4LfTwpvD423uaUqC21QY3Q0pyAgpAFCGQuunhYiv/39Tezp oiyNon86hCtBtku6zFPKoW41QJ/kXT+nzFJUSedSC5tHgN6Q7ZW/h8l
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

A function can contain nested switch tables using different registers
as base address.

In order to avoid failure in tracking those switch tables, the register
containing the base address needs to be taken into account.

To do so, add a 5 bits field in struct instruction that will hold the
ID of the register containing the base address of the switch table and
take that register into account during the backward search in order to
not stop the walk when encountering a jump related to another switch
table.

On architectures not handling it, the ID stays nul and has no impact
on the search.

To enable that, also provide to arch_find_switch_table() the dynamic
instruction related to a table search.

Also allow prev_insn_same_sec() to be used outside check.c so that
architectures can backward walk through instruction to find out which
register is used as base address for a switch table.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/arch/powerpc/special.c    | 3 ++-
 tools/objtool/arch/x86/special.c        | 3 ++-
 tools/objtool/check.c                   | 9 +++++----
 tools/objtool/include/objtool/check.h   | 6 ++++--
 tools/objtool/include/objtool/special.h | 3 ++-
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
index d33868147196..a7dd2559b536 100644
--- a/tools/objtool/arch/powerpc/special.c
+++ b/tools/objtool/arch/powerpc/special.c
@@ -13,7 +13,8 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 }
 
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn)
+				     struct instruction *insn,
+				     struct instruction *orig_insn)
 {
 	exit(-1);
 }
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 8e8302fe909f..8cf17d94c69b 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -86,7 +86,8 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
  *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
  */
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn)
+				     struct instruction *insn,
+				     struct instruction *orig_insn)
 {
 	struct reloc  *text_reloc, *rodata_reloc;
 	struct section *table_sec;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d51f47c4a3bd..be413c578588 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -80,8 +80,8 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
 
-static struct instruction *prev_insn_same_sec(struct objtool_file *file,
-					      struct instruction *insn)
+struct instruction *prev_insn_same_sec(struct objtool_file *file,
+				       struct instruction *insn)
 {
 	if (insn->idx == 0) {
 		if (insn->prev_len)
@@ -2064,7 +2064,8 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 	     insn && insn_func(insn) && insn_func(insn)->pfunc == func;
 	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
 
-		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
+		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC &&
+		    insn->gpr == orig_insn->gpr)
 			break;
 
 		/* allow small jumps within the range */
@@ -2074,7 +2075,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		     insn->jump_dest->offset > orig_insn->offset))
 		    break;
 
-		table_reloc = arch_find_switch_table(file, insn);
+		table_reloc = arch_find_switch_table(file, insn, orig_insn);
 		if (!table_reloc)
 			continue;
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965..660ea9d0393e 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -63,8 +63,9 @@ struct instruction {
 	    noendbr		: 1,
 	    unret		: 1,
 	    visited		: 4,
-	    no_reloc		: 1;
-		/* 10 bit hole */
+	    no_reloc		: 1,
+	    gpr			: 5;
+		/* 5 bit hole */
 
 	struct alt_group *alt_group;
 	struct instruction *jump_dest;
@@ -115,6 +116,7 @@ struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
 struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruction *insn);
+struct instruction *prev_insn_same_sec(struct objtool_file *file, struct instruction *insn);
 
 #define sec_for_each_insn(file, _sec, insn)				\
 	for (insn = find_insn(file, _sec, 0);				\
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 86d4af9c5aa9..4128a479d76e 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -38,5 +38,6 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc);
 struct reloc *arch_find_switch_table(struct objtool_file *file,
-				    struct instruction *insn);
+				     struct instruction *insn,
+				     struct instruction *orig_insn);
 #endif /* _SPECIAL_H */
-- 
2.41.0

