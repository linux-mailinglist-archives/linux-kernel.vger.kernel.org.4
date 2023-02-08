Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5703668F45F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBHRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjBHRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401C11174
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8TbebfEQGupoy/9v/z5uEIiMfU8D0SE8LTUS76/4dow=; b=jEjQtbcquVHU8Ggz47ZybOguHR
        1bxalUflyRQu0unb/sLmUz0tbYotSThHT0iuuYQN7Gv3yJQlNRkhJnIJwtAUQIocwuulqGRkc6aYe
        lkpvxSu6hD5qRKQb6is+Reml5E5j2QDsJNJSJoOb4cXa0H6FTdH1/72tIeuPw8ynD6OPIvrSE62F8
        1iAvWhSBH8gjam9wv/Ov3Gz7shF6DcNn480VHqyDUeQAZIJ3h8NB55udNf8MX9i6DjM37Sf0Uf7RS
        apj5TLukX/82BUZz5VbRyGKbpihRKVob316SF0YBxl+62BsvDuubNV8aE/1pmmTn4UxzGlhNTGpmD
        nBibaSoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPoAg-001PY4-Gg; Wed, 08 Feb 2023 17:23:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ECF73007FB;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0469123D88E92; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.362196959@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:17:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 02/10] objtool: Make instruction::stack_ops a single-linked list
References: <20230208171756.898991570@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 struct instruction {
 	struct list_head           list;                 /*     0    16 */
 	struct hlist_node          hash;                 /*    16    16 */
 	struct list_head           call_node;            /*    32    16 */
 	struct section *           sec;                  /*    48     8 */
 	long unsigned int          offset;               /*    56     8 */
 	/* --- cacheline 1 boundary (64 bytes) --- */
 	unsigned int               len;                  /*    64     4 */
 	enum insn_type             type;                 /*    68     4 */
 	long unsigned int          immediate;            /*    72     8 */
 	u16                        dead_end:1;           /*    80: 0  2 */
 	u16                        ignore:1;             /*    80: 1  2 */
 	u16                        ignore_alts:1;        /*    80: 2  2 */
 	u16                        hint:1;               /*    80: 3  2 */
 	u16                        save:1;               /*    80: 4  2 */
 	u16                        restore:1;            /*    80: 5  2 */
 	u16                        retpoline_safe:1;     /*    80: 6  2 */
 	u16                        noendbr:1;            /*    80: 7  2 */
 	u16                        entry:1;              /*    80: 8  2 */

 	/* XXX 7 bits hole, try to pack */

 	s8                         instr;                /*    82     1 */
 	u8                         visited;              /*    83     1 */

 	/* XXX 4 bytes hole, try to pack */

 	struct alt_group *         alt_group;            /*    88     8 */
 	struct symbol *            call_dest;            /*    96     8 */
 	struct instruction *       jump_dest;            /*   104     8 */
 	struct instruction *       first_jump_src;       /*   112     8 */
 	struct reloc *             jump_table;           /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
 	struct reloc *             reloc;                /*   128     8 */
 	struct list_head           alts;                 /*   136    16 */
 	struct symbol *            sym;                  /*   152     8 */
-	struct list_head           stack_ops;            /*   160    16 */
-	struct cfi_state *         cfi;                  /*   176     8 */
+	struct stack_op *          stack_ops;            /*   160     8 */
+	struct cfi_state *         cfi;                  /*   168     8 */

-	/* size: 184, cachelines: 3, members: 29 */
-	/* sum members: 178, holes: 1, sum holes: 4 */
+	/* size: 176, cachelines: 3, members: 29 */
+	/* sum members: 170, holes: 1, sum holes: 4 */
 	/* sum bitfield members: 9 bits, bit holes: 1, sum bit holes: 7 bits */
-	/* last cacheline: 56 bytes */
+	/* last cacheline: 48 bytes */
 };

pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
post:	5:58.50 real,   229.64 user,    128.65 sys,     26221520 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c       |    4 ++--
 tools/objtool/check.c                 |   11 +++++------
 tools/objtool/include/objtool/arch.h  |    2 +-
 tools/objtool/include/objtool/check.h |    2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -105,7 +105,7 @@ bool arch_pc_relative_reloc(struct reloc
 #define ADD_OP(op) \
 	if (!(op = calloc(1, sizeof(*op)))) \
 		return -1; \
-	else for (list_add_tail(&op->list, ops_list); op; op = NULL)
+	else for (*ops_list = op, ops_list = &op->next; op; op = NULL)
 
 /*
  * Helpers to decode ModRM/SIB:
@@ -148,7 +148,7 @@ int arch_decode_instruction(struct objto
 			    unsigned long offset, unsigned int maxlen,
 			    struct instruction *insn)
 {
-	struct list_head *ops_list = &insn->stack_ops;
+	struct stack_op **ops_list = &insn->stack_ops;
 	const struct elf *elf = file->elf;
 	struct insn ins;
 	int x86_64, ret;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -396,7 +396,6 @@ static int decode_instructions(struct ob
 			}
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
-			INIT_LIST_HEAD(&insn->stack_ops);
 			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
@@ -1319,12 +1318,13 @@ static struct reloc *insn_reloc(struct o
 
 static void remove_insn_ops(struct instruction *insn)
 {
-	struct stack_op *op, *tmp;
+	struct stack_op *op, *next;
 
-	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
-		list_del(&op->list);
+	for (op = insn->stack_ops; op; op = next) {
+		next = op->next;
 		free(op);
 	}
+	insn->stack_ops = NULL;
 }
 
 static void annotate_call_site(struct objtool_file *file,
@@ -1769,7 +1769,6 @@ static int handle_group_alt(struct objto
 		}
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
-		INIT_LIST_HEAD(&nop->stack_ops);
 
 		nop->sec = special_alt->new_sec;
 		nop->offset = special_alt->new_off + special_alt->new_len;
@@ -3214,7 +3213,7 @@ static int handle_insn_ops(struct instru
 {
 	struct stack_op *op;
 
-	list_for_each_entry(op, &insn->stack_ops, list) {
+	for (op = insn->stack_ops; op; op = op->next) {
 
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -62,9 +62,9 @@ struct op_src {
 };
 
 struct stack_op {
+	struct stack_op *next;
 	struct op_dest dest;
 	struct op_src src;
-	struct list_head list;
 };
 
 struct instruction;
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -68,7 +68,7 @@ struct instruction {
 	struct reloc *reloc;
 	struct list_head alts;
 	struct symbol *sym;
-	struct list_head stack_ops;
+	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
 };
 


