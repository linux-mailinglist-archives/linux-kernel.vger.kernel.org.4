Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76BD74F478
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjGKQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjGKQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:09:04 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA810F9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:09:02 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m5H4xHSz9sFC;
        Tue, 11 Jul 2023 18:08:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sJunrGwSK_vC; Tue, 11 Jul 2023 18:08:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m5C3qNTz9sFG;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F2228B763;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9d1NI2BXQpaT; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D14788B77B;
        Tue, 11 Jul 2023 18:08:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8iwe3696820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:44 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8iCY3696819;
        Tue, 11 Jul 2023 18:08:44 +0200
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
Subject: [PATCH v4 05/15] objtool: Add INSN_RETURN_CONDITIONAL
Date:   Tue, 11 Jul 2023 18:08:31 +0200
Message-ID: <0b907f1cb4b85cba39b6c2b727c80d29e096e977.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091705; l=3391; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=RQvNZ3u/NPHor4suqgxX3vAfJ2dn/X79t365w/+p2nc=; b=B9G86bIXes9pIEokdlznNuX5AWjjZ0vaHIsr9dwCR0WD/GmjAkq4cSlQILjBFCpwqKqfNi2Vp F0BbI3cK4UZCuaFCjC7L8IJQ8BTZke0RpQbRghX+b2JMqDYRuFXOm7J
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

Most functions have an unconditional return at the end, like
this one:

	00000000 <is_exec_fault>:
	   0:	81 22 04 d0 	lwz     r9,1232(r2)
	   4:	38 60 00 00 	li      r3,0
	   8:	2c 09 00 00 	cmpwi   r9,0
	   c:	4d 82 00 20 	beqlr		<== Conditional return
	  10:	80 69 00 a0 	lwz     r3,160(r9)
	  14:	54 63 00 36 	clrrwi  r3,r3,4
	  18:	68 63 04 00 	xori    r3,r3,1024
	  1c:	7c 63 00 34 	cntlzw  r3,r3
	  20:	54 63 d9 7e 	srwi    r3,r3,5
	  24:	4e 80 00 20 	blr		<== Unconditional return

But other functions like this other one below only have
conditional returns:

	00000028 <pte_update.isra.0>:
	  28:	81 25 00 00 	lwz     r9,0(r5)
	  2c:	2c 08 00 00 	cmpwi   r8,0
	  30:	7d 29 30 78 	andc    r9,r9,r6
	  34:	7d 27 3b 78 	or      r7,r9,r7
	  38:	54 84 65 3a 	rlwinm  r4,r4,12,20,29
	  3c:	81 23 00 18 	lwz     r9,24(r3)
	  40:	41 82 00 58 	beq     98 <pte_update.isra.0+0x70>
	  44:	7d 29 20 2e 	lwzx    r9,r9,r4
	  48:	55 29 07 3a 	rlwinm  r9,r9,0,28,29
	  4c:	2c 09 00 0c 	cmpwi   r9,12
	  50:	41 82 00 08 	beq     58 <pte_update.isra.0+0x30>
	  54:	39 00 00 80 	li      r8,128
	  58:	2c 08 00 01 	cmpwi   r8,1
	  5c:	90 e5 00 00 	stw     r7,0(r5)
	  60:	4d a2 00 20 	beqlr+		<== Conditional return
	  64:	7c e9 3b 78 	mr      r9,r7
	  68:	39 40 00 00 	li      r10,0
	  6c:	39 4a 00 04 	addi    r10,r10,4
	  70:	7c 0a 40 00 	cmpw    r10,r8
	  74:	91 25 00 04 	stw     r9,4(r5)
	  78:	91 25 00 08 	stw     r9,8(r5)
	  7c:	38 a5 00 10 	addi    r5,r5,16
	  80:	91 25 ff fc 	stw     r9,-4(r5)
	  84:	4c 80 00 20 	bgelr		<== Conditional return
	  88:	55 49 60 26 	slwi    r9,r10,12
	  8c:	7d 29 3a 14 	add     r9,r9,r7
	  90:	91 25 00 00 	stw     r9,0(r5)
	  94:	4b ff ff d8 	b       6c <pte_update.isra.0+0x44>
	  98:	39 00 00 04 	li      r8,4
	  9c:	4b ff ff bc 	b       58 <pte_update.isra.0+0x30>

If conditional returns are decoded as INSN_OTHER, objtool considers
that the second function never returns.

If conditional returns are decoded as INSN_RETURN, objtool considers
that code after that conditional return is dead.

To overcome this situation, introduce INSN_RETURN_CONDITIONAL which
is taken as a confirmation that a function is not noreturn but still
sees following code as reachable.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                | 2 +-
 tools/objtool/include/objtool/arch.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 25f6df4713ed..ae0019412123 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -219,7 +219,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	func_for_each_insn(file, func, insn) {
 		empty = false;
 
-		if (insn->type == INSN_RETURN)
+		if (insn->type == INSN_RETURN || insn->type == INSN_RETURN_CONDITIONAL)
 			return false;
 	}
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 2b6d2ce4f9a5..84ba75112934 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -19,6 +19,7 @@ enum insn_type {
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
+	INSN_RETURN_CONDITIONAL,
 	INSN_CONTEXT_SWITCH,
 	INSN_BUG,
 	INSN_NOP,
-- 
2.41.0

