Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66996A03E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjBWIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjBWIcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:32:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6624D621;
        Thu, 23 Feb 2023 00:32:12 -0800 (PST)
Date:   Thu, 23 Feb 2023 08:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677141128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3nzDb9QEcHYe7mq8a7GFpQl7B2oF3ScZnDCdv2yMnk=;
        b=Ze1aNFLWewR4YnFI62PIanLKbWcWkIqv3stFPN6q5xOoJTXRoXAoUHfWNnWGPzVgl7SHmb
        NTMSnhrn+bmtImtQ0e30C0MppwxuL+i+GpAktfGhovtsF1mZZO1d0rAWIrzIK7mu8GXp6v
        pKIHoa5xIqpRg4ci5gi381VYtZivl20eTefHcc3O2DjcoRqwShf0yifpPyA1dW5FurIYSF
        r30Z/KvDlo4m3nOeuENOHEDZpnf8Py7a8Orq83Q0LOp/JqKykDsPc176+SmyZMeOp/9iQ8
        LJ1PZoyTjyDMhmVANIvtMbh3AdbEYvAW2xfiIPindhn221wQ07kAC5Fxbab4qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677141128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3nzDb9QEcHYe7mq8a7GFpQl7B2oF3ScZnDCdv2yMnk=;
        b=qb0B8Jr++8HLW2exMkGrP9VjiqVg7mKnf2U18klDTtBrbau08RJAecrYS1oMRi9wUZAOzH
        dP/bgJRtp/h6yUCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make instruction::alts a single-linked list
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.430556498@infradead.org>
References: <20230208172245.430556498@infradead.org>
MIME-Version: 1.0
Message-ID: <167714112770.5837.10453236541325422066.tip-bot2@tip-bot2>
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

Commit-ID:     d54066546121426ecd7ad01a53ae429c4e37a9d5
Gitweb:        https://git.kernel.org/tip/d54066546121426ecd7ad01a53ae429c4e3=
7a9d5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:17:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Feb 2023 09:21:06 +01:00

objtool: Make instruction::alts a single-linked list

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
-	struct list_head           alts;                 /*   136    16 */
-	struct symbol *            sym;                  /*   152     8 */
-	struct stack_op *          stack_ops;            /*   160     8 */
-	struct cfi_state *         cfi;                  /*   168     8 */
+	struct alternative *       alts;                 /*   136     8 */
+	struct symbol *            sym;                  /*   144     8 */
+	struct stack_op *          stack_ops;            /*   152     8 */
+	struct cfi_state *         cfi;                  /*   160     8 */

-	/* size: 176, cachelines: 3, members: 29 */
-	/* sum members: 170, holes: 1, sum holes: 4 */
+	/* size: 168, cachelines: 3, members: 29 */
+	/* sum members: 162, holes: 1, sum holes: 4 */
 	/* sum bitfield members: 9 bits, bit holes: 1, sum bit holes: 7 bits */
-	/* last cacheline: 48 bytes */
+	/* last cacheline: 40 bytes */
 };

pre:	5:58.50 real,   229.64 user,    128.65 sys,     26221520 mem
post:	5:48.86 real,   220.30 user,    128.34 sys,     24834672 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.430556498@infradead.org
---
 tools/objtool/check.c                 | 18 +++++++++---------
 tools/objtool/include/objtool/check.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8109d74..9f83e85 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -23,7 +23,7 @@
 #include <linux/static_call_types.h>
=20
 struct alternative {
-	struct list_head list;
+	struct alternative *next;
 	struct instruction *insn;
 	bool skip_orig;
 };
@@ -397,7 +397,6 @@ static int decode_instructions(struct objtool_file *file)
 				return -1;
 			}
 			memset(insn, 0, sizeof(*insn));
-			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->call_node);
=20
 			insn->sec =3D sec;
@@ -1780,7 +1779,6 @@ static int handle_group_alt(struct objtool_file *file,
 			return -1;
 		}
 		memset(nop, 0, sizeof(*nop));
-		INIT_LIST_HEAD(&nop->alts);
=20
 		nop->sec =3D special_alt->new_sec;
 		nop->offset =3D special_alt->new_off + special_alt->new_len;
@@ -1978,7 +1976,8 @@ static int add_special_section_alts(struct objtool_file=
 *file)
 		alt->insn =3D new_insn;
 		alt->skip_orig =3D special_alt->skip_orig;
 		orig_insn->ignore_alts |=3D special_alt->skip_alt;
-		list_add_tail(&alt->list, &orig_insn->alts);
+		alt->next =3D orig_insn->alts;
+		orig_insn->alts =3D alt;
=20
 		list_del(&special_alt->list);
 		free(special_alt);
@@ -2037,7 +2036,8 @@ static int add_jump_table(struct objtool_file *file, st=
ruct instruction *insn,
 		}
=20
 		alt->insn =3D dest_insn;
-		list_add_tail(&alt->list, &insn->alts);
+		alt->next =3D insn->alts;
+		insn->alts =3D alt;
 		prev_offset =3D reloc->offset;
 	}
=20
@@ -3594,10 +3594,10 @@ static int validate_branch(struct objtool_file *file,=
 struct symbol *func,
 		if (propagate_alt_cfi(file, insn))
 			return 1;
=20
-		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
+		if (!insn->ignore_alts && insn->alts) {
 			bool skip_orig =3D false;
=20
-			list_for_each_entry(alt, &insn->alts, list) {
+			for (alt =3D insn->alts; alt; alt =3D alt->next) {
 				if (alt->skip_orig)
 					skip_orig =3D true;
=20
@@ -3796,11 +3796,11 @@ static int validate_entry(struct objtool_file *file, =
struct instruction *insn)
=20
 		insn->visited |=3D VISITED_ENTRY;
=20
-		if (!insn->ignore_alts && !list_empty(&insn->alts)) {
+		if (!insn->ignore_alts && insn->alts) {
 			struct alternative *alt;
 			bool skip_orig =3D false;
=20
-			list_for_each_entry(alt, &insn->alts, list) {
+			for (alt =3D insn->alts; alt; alt =3D alt->next) {
 				if (alt->skip_orig)
 					skip_orig =3D true;
=20
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 23e9819..7966f60 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -66,7 +66,7 @@ struct instruction {
 	struct instruction *first_jump_src;
 	struct reloc *jump_table;
 	struct reloc *reloc;
-	struct list_head alts;
+	struct alternative *alts;
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
