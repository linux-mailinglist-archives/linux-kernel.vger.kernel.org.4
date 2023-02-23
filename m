Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA06A03E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjBWIco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjBWIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0B4D627;
        Thu, 23 Feb 2023 00:32:12 -0800 (PST)
Date:   Thu, 23 Feb 2023 08:32:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677141128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Kmj1/w+vickLd/6DB3c4kjCP73tN9o7hiQD9n5AzZo=;
        b=khwCOBQ/tX1B9s/qHTZeq/3OT4eNI014Grz8Wm4UVZqqVq2YRZA2mguOy0IgpqbKysrqiF
        F1qTnm5u4Siyf9/gRPI1xGou9FTyfX+nTkAIu8/yMsD0Q6VeHLnwBaw6t2s7kg6qgogZIa
        viAGp3ox5eQ2i+CceJv1jffC/fSOEr2I/qjBFTBBn41+MwXLhK7k85AybqdcYbLAUBJGau
        i5XP1o/Kb/c50fh1C8+DuBnyHEYmd7aARrg3gNHcCkUSQ7wZgHsNtxfQTd4LZu8Zm3lY2d
        UhFhf4iMs6MCjbgvZa9RtySDkvKhiKvgO7NfLNKoGUdXig/fmpU6ZLNJAQw3CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677141128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Kmj1/w+vickLd/6DB3c4kjCP73tN9o7hiQD9n5AzZo=;
        b=wKoEtkjOH3IL/lVB+PA5soK686Xpn61XQT1vCNVuH+juZZc3eRUYSsKTIAtRvQ8xKdvb2E
        19+xYBqGdmnB1MAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make instruction::stack_ops a single-linked list
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.362196959@infradead.org>
References: <20230208172245.362196959@infradead.org>
MIME-Version: 1.0
Message-ID: <167714112801.5837.11298340280066463263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3ee88df1b063962e39d7798ccc3b18fd10cea813
Gitweb:        https://git.kernel.org/tip/3ee88df1b063962e39d7798ccc3b18fd10c=
ea813
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:17:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Feb 2023 09:20:59 +01:00

objtool: Make instruction::stack_ops a single-linked list

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.362196959@infradead.org
---
 tools/objtool/arch/x86/decode.c       |  4 ++--
 tools/objtool/check.c                 | 11 +++++------
 tools/objtool/include/objtool/arch.h  |  2 +-
 tools/objtool/include/objtool/check.h |  2 +-
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c5c4927..9ef024f 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -105,7 +105,7 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 #define ADD_OP(op) \
 	if (!(op =3D calloc(1, sizeof(*op)))) \
 		return -1; \
-	else for (list_add_tail(&op->list, ops_list); op; op =3D NULL)
+	else for (*ops_list =3D op, ops_list =3D &op->next; op; op =3D NULL)
=20
 /*
  * Helpers to decode ModRM/SIB:
@@ -148,7 +148,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 			    unsigned long offset, unsigned int maxlen,
 			    struct instruction *insn)
 {
-	struct list_head *ops_list =3D &insn->stack_ops;
+	struct stack_op **ops_list =3D &insn->stack_ops;
 	const struct elf *elf =3D file->elf;
 	struct insn ins;
 	int x86_64, ret;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b3b423d..8109d74 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -398,7 +398,6 @@ static int decode_instructions(struct objtool_file *file)
 			}
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
-			INIT_LIST_HEAD(&insn->stack_ops);
 			INIT_LIST_HEAD(&insn->call_node);
=20
 			insn->sec =3D sec;
@@ -1331,12 +1330,13 @@ static struct reloc *insn_reloc(struct objtool_file *=
file, struct instruction *i
=20
 static void remove_insn_ops(struct instruction *insn)
 {
-	struct stack_op *op, *tmp;
+	struct stack_op *op, *next;
=20
-	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
-		list_del(&op->list);
+	for (op =3D insn->stack_ops; op; op =3D next) {
+		next =3D op->next;
 		free(op);
 	}
+	insn->stack_ops =3D NULL;
 }
=20
 static void annotate_call_site(struct objtool_file *file,
@@ -1781,7 +1781,6 @@ static int handle_group_alt(struct objtool_file *file,
 		}
 		memset(nop, 0, sizeof(*nop));
 		INIT_LIST_HEAD(&nop->alts);
-		INIT_LIST_HEAD(&nop->stack_ops);
=20
 		nop->sec =3D special_alt->new_sec;
 		nop->offset =3D special_alt->new_off + special_alt->new_len;
@@ -3226,7 +3225,7 @@ static int handle_insn_ops(struct instruction *insn,
 {
 	struct stack_op *op;
=20
-	list_for_each_entry(op, &insn->stack_ops, list) {
+	for (op =3D insn->stack_ops; op; op =3D op->next) {
=20
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index 73149f8..2b6d2ce 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -62,9 +62,9 @@ struct op_src {
 };
=20
 struct stack_op {
+	struct stack_op *next;
 	struct op_dest dest;
 	struct op_src src;
-	struct list_head list;
 };
=20
 struct instruction;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index acd7fae..23e9819 100644
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
=20
