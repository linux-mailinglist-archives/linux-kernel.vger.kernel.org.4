Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CB6A03DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjBWIcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjBWIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:32:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03084D62C;
        Thu, 23 Feb 2023 00:32:08 -0800 (PST)
Date:   Thu, 23 Feb 2023 08:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677141127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeY/xPjRHAfkeAHz60UcW1TUNewqJvCeulSRbfSx8xY=;
        b=kZMrZV+YM0rRG9Z7HbTTbiWHx135G8LfFW50QHAasLcSZiwgYBFEHuI7NiEd40G8YE5FYm
        nFiA5D7ttd1TSPHgo2S2xTVy9D360jG8IyqUq0N55yZspcxmrAUA80tI7TXCYmdwtg/lPN
        tZd+gW8GMsLcfVqcNyPoxhu3c/M0UdJ2m8XSS3nQw4bnRA4ho82Nuq35YyIeI2ttehd40E
        BpZGtWKZMrZH9BRUTywriZTJWoMLr0deb5ihwQ1MPIAlHv44/Vc2mwByyOjspmKUDZUhPS
        A74xcokr5KAe98+tk+cT3YsIpbmLQNJrDP1APKXpYgKehfP7jJVAKWd0ySa3qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677141127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jeY/xPjRHAfkeAHz60UcW1TUNewqJvCeulSRbfSx8xY=;
        b=odzQ2PQ4o1B2rbVeM9IM2+mKj8A85bQyk3BA3KUaU0DOLKa6mBcTXrxmdttKwIaNqAtcj7
        3htGLOrXE9rIyoBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Union instruction::{call_dest,jump_table}
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.640914454@infradead.org>
References: <20230208172245.640914454@infradead.org>
MIME-Version: 1.0
Message-ID: <167714112696.5837.4989746739788659101.tip-bot2@tip-bot2>
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

Commit-ID:     c6f5dc28fb3d736fa8d7f7d31e0664a9c772c299
Gitweb:        https://git.kernel.org/tip/c6f5dc28fb3d736fa8d7f7d31e0664a9c77=
2c299
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:18:02 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Feb 2023 09:21:27 +01:00

objtool: Union instruction::{call_dest,jump_table}

The instruction call_dest and jump_table members can never be used at
the same time, their usage depends on type.

 struct instruction {
 	struct list_head           list;                 /*     0    16 */
 	struct hlist_node          hash;                 /*    16    16 */
 	struct list_head           call_node;            /*    32    16 */
 	struct section *           sec;                  /*    48     8 */
 	long unsigned int          offset;               /*    56     8 */
 	/* --- cacheline 1 boundary (64 bytes) --- */
 	long unsigned int          immediate;            /*    64     8 */
 	unsigned int               len;                  /*    72     4 */
 	u8                         type;                 /*    76     1 */

 	/* Bitfield combined with previous fields */

 	u16                        dead_end:1;           /*    76: 8  2 */
 	u16                        ignore:1;             /*    76: 9  2 */
 	u16                        ignore_alts:1;        /*    76:10  2 */
 	u16                        hint:1;               /*    76:11  2 */
 	u16                        save:1;               /*    76:12  2 */
 	u16                        restore:1;            /*    76:13  2 */
 	u16                        retpoline_safe:1;     /*    76:14  2 */
 	u16                        noendbr:1;            /*    76:15  2 */
 	u16                        entry:1;              /*    78: 0  2 */
 	u16                        visited:4;            /*    78: 1  2 */
 	u16                        no_reloc:1;           /*    78: 5  2 */

 	/* XXX 2 bits hole, try to pack */
 	/* Bitfield combined with next fields */

 	s8                         instr;                /*    79     1 */
 	struct alt_group *         alt_group;            /*    80     8 */
-	struct symbol *            call_dest;            /*    88     8 */
-	struct instruction *       jump_dest;            /*    96     8 */
-	struct instruction *       first_jump_src;       /*   104     8 */
-	struct reloc *             jump_table;           /*   112     8 */
-	struct alternative *       alts;                 /*   120     8 */
+	struct instruction *       jump_dest;            /*    88     8 */
+	struct instruction *       first_jump_src;       /*    96     8 */
+	union {
+		struct symbol *    _call_dest;           /*   104     8 */
+		struct reloc *     _jump_table;          /*   104     8 */
+	};                                               /*   104     8 */
+	struct alternative *       alts;                 /*   112     8 */
+	struct symbol *            sym;                  /*   120     8 */
 	/* --- cacheline 2 boundary (128 bytes) --- */
-	struct symbol *            sym;                  /*   128     8 */
-	struct stack_op *          stack_ops;            /*   136     8 */
-	struct cfi_state *         cfi;                  /*   144     8 */
+	struct stack_op *          stack_ops;            /*   128     8 */
+	struct cfi_state *         cfi;                  /*   136     8 */

-	/* size: 152, cachelines: 3, members: 29 */
-	/* sum members: 150 */
+	/* size: 144, cachelines: 3, members: 28 */
+	/* sum members: 142 */
 	/* sum bitfield members: 14 bits, bit holes: 1, sum bit holes: 2 bits */
-	/* last cacheline: 24 bytes */
+	/* last cacheline: 16 bytes */
 };

pre:	5:39.35 real,   215.58 user,    123.69 sys,     23448736 mem
post:	5:38.18 real,   213.25 user,    124.90 sys,     23449040 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.640914454@infradead.org
---
 tools/objtool/check.c                 | 73 ++++++++++++++++----------
 tools/objtool/include/objtool/check.h |  6 +-
 2 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6d0ce23..6f0adb2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -114,16 +114,34 @@ static struct instruction *prev_insn_same_sym(struct ob=
jtool_file *file,
 	for (insn =3D next_insn_same_sec(file, insn); insn;		\
 	     insn =3D next_insn_same_sec(file, insn))
=20
+static inline struct symbol *insn_call_dest(struct instruction *insn)
+{
+	if (insn->type =3D=3D INSN_JUMP_DYNAMIC ||
+	    insn->type =3D=3D INSN_CALL_DYNAMIC)
+		return NULL;
+
+	return insn->_call_dest;
+}
+
+static inline struct reloc *insn_jump_table(struct instruction *insn)
+{
+	if (insn->type =3D=3D INSN_JUMP_DYNAMIC ||
+	    insn->type =3D=3D INSN_CALL_DYNAMIC)
+		return insn->_jump_table;
+
+	return NULL;
+}
+
 static bool is_jump_table_jump(struct instruction *insn)
 {
 	struct alt_group *alt_group =3D insn->alt_group;
=20
-	if (insn->jump_table)
+	if (insn_jump_table(insn))
 		return true;
=20
 	/* Retpoline alternative for a jump table? */
 	return alt_group && alt_group->orig_group &&
-	       alt_group->orig_group->first_insn->jump_table;
+	       insn_jump_table(alt_group->orig_group->first_insn);
 }
=20
 static bool is_sibling_call(struct instruction *insn)
@@ -137,8 +155,8 @@ static bool is_sibling_call(struct instruction *insn)
 			return !is_jump_table_jump(insn);
 	}
=20
-	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
-	return (is_static_jump(insn) && insn->call_dest);
+	/* add_jump_destinations() sets insn_call_dest(insn) for sibling calls. */
+	return (is_static_jump(insn) && insn_call_dest(insn));
 }
=20
 /*
@@ -274,8 +292,8 @@ static void init_insn_state(struct objtool_file *file, st=
ruct insn_state *state,
=20
 	/*
 	 * We need the full vmlinux for noinstr validation, otherwise we can
-	 * not correctly determine insn->call_dest->sec (external symbols do
-	 * not have a section).
+	 * not correctly determine insn_call_dest(insn)->sec (external symbols
+	 * do not have a section).
 	 */
 	if (opts.link && opts.noinstr && sec)
 		state->noinstr =3D sec->noinstr;
@@ -678,7 +696,7 @@ static int create_static_call_sections(struct objtool_fil=
e *file)
 			return -1;
=20
 		/* find key symbol */
-		key_name =3D strdup(insn->call_dest->name);
+		key_name =3D strdup(insn_call_dest(insn)->name);
 		if (!key_name) {
 			perror("strdup");
 			return -1;
@@ -709,7 +727,7 @@ static int create_static_call_sections(struct objtool_fil=
e *file)
 			 * trampoline address.  This is fixed up in
 			 * static_call_add_module().
 			 */
-			key_sym =3D insn->call_dest;
+			key_sym =3D insn_call_dest(insn);
 		}
 		free(key_name);
=20
@@ -1340,7 +1358,7 @@ static void annotate_call_site(struct objtool_file *fil=
e,
 			       struct instruction *insn, bool sibling)
 {
 	struct reloc *reloc =3D insn_reloc(file, insn);
-	struct symbol *sym =3D insn->call_dest;
+	struct symbol *sym =3D insn_call_dest(insn);
=20
 	if (!sym)
 		sym =3D reloc->sym;
@@ -1425,7 +1443,7 @@ static void annotate_call_site(struct objtool_file *fil=
e,
 static void add_call_dest(struct objtool_file *file, struct instruction *ins=
n,
 			  struct symbol *dest, bool sibling)
 {
-	insn->call_dest =3D dest;
+	insn->_call_dest =3D dest;
 	if (!dest)
 		return;
=20
@@ -1683,12 +1701,12 @@ static int add_call_destinations(struct objtool_file =
*file)
 			if (insn->ignore)
 				continue;
=20
-			if (!insn->call_dest) {
+			if (!insn_call_dest(insn)) {
 				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
 				return -1;
 			}
=20
-			if (insn_func(insn) && insn->call_dest->type !=3D STT_FUNC) {
+			if (insn_func(insn) && insn_call_dest(insn)->type !=3D STT_FUNC) {
 				WARN_FUNC("unsupported call to non-function",
 					  insn->sec, insn->offset);
 				return -1;
@@ -2125,7 +2143,7 @@ static void mark_func_jump_tables(struct objtool_file *=
file,
 		reloc =3D find_jump_table(file, func, insn);
 		if (reloc) {
 			reloc->jump_table_start =3D true;
-			insn->jump_table =3D reloc;
+			insn->_jump_table =3D reloc;
 		}
 	}
 }
@@ -2137,10 +2155,10 @@ static int add_func_jump_tables(struct objtool_file *=
file,
 	int ret;
=20
 	func_for_each_insn(file, func, insn) {
-		if (!insn->jump_table)
+		if (!insn_jump_table(insn))
 			continue;
=20
-		ret =3D add_jump_table(file, insn, insn->jump_table);
+		ret =3D add_jump_table(file, insn, insn_jump_table(insn));
 		if (ret)
 			return ret;
 	}
@@ -2612,8 +2630,8 @@ static int decode_sections(struct objtool_file *file)
 static bool is_fentry_call(struct instruction *insn)
 {
 	if (insn->type =3D=3D INSN_CALL &&
-	    insn->call_dest &&
-	    insn->call_dest->fentry)
+	    insn_call_dest(insn) &&
+	    insn_call_dest(insn)->fentry)
 		return true;
=20
 	return false;
@@ -3320,8 +3338,8 @@ static inline const char *call_dest_name(struct instruc=
tion *insn)
 	struct reloc *rel;
 	int idx;
=20
-	if (insn->call_dest)
-		return insn->call_dest->name;
+	if (insn_call_dest(insn))
+		return insn_call_dest(insn)->name;
=20
 	rel =3D insn_reloc(NULL, insn);
 	if (rel && !strcmp(rel->sym->name, "pv_ops")) {
@@ -3403,13 +3421,13 @@ static int validate_call(struct objtool_file *file,
 			 struct insn_state *state)
 {
 	if (state->noinstr && state->instr <=3D 0 &&
-	    !noinstr_call_dest(file, insn, insn->call_dest)) {
+	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
 	}
=20
-	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
+	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
 		WARN_FUNC("call to %s() with UACCESS enabled",
 				insn->sec, insn->offset, call_dest_name(insn));
 		return 1;
@@ -3847,11 +3865,11 @@ static int validate_entry(struct objtool_file *file, =
struct instruction *insn)
=20
 			/* fallthrough */
 		case INSN_CALL:
-			dest =3D find_insn(file, insn->call_dest->sec,
-					 insn->call_dest->offset);
+			dest =3D find_insn(file, insn_call_dest(insn)->sec,
+					 insn_call_dest(insn)->offset);
 			if (!dest) {
 				WARN("Unresolved function after linking!?: %s",
-				     insn->call_dest->name);
+				     insn_call_dest(insn)->name);
 				return -1;
 			}
=20
@@ -3952,13 +3970,13 @@ static int validate_retpoline(struct objtool_file *fi=
le)
 static bool is_kasan_insn(struct instruction *insn)
 {
 	return (insn->type =3D=3D INSN_CALL &&
-		!strcmp(insn->call_dest->name, "__asan_handle_no_return"));
+		!strcmp(insn_call_dest(insn)->name, "__asan_handle_no_return"));
 }
=20
 static bool is_ubsan_insn(struct instruction *insn)
 {
 	return (insn->type =3D=3D INSN_CALL &&
-		!strcmp(insn->call_dest->name,
+		!strcmp(insn_call_dest(insn)->name,
 			"__ubsan_handle_builtin_unreachable"));
 }
=20
@@ -4036,7 +4054,8 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
 	prev_insn =3D list_prev_entry(insn, list);
-	if ((prev_insn->dead_end || dead_end_function(file, prev_insn->call_dest)) =
&&
+	if ((prev_insn->dead_end ||
+	     dead_end_function(file, insn_call_dest(prev_insn))) &&
 	    (insn->type =3D=3D INSN_BUG ||
 	     (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type =3D=3D INSN_BUG)))
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index fffc8b8..ab6deae 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -62,10 +62,12 @@ struct instruction {
 	s8 instr;
=20
 	struct alt_group *alt_group;
-	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
-	struct reloc *jump_table;
+	union {
+		struct symbol *_call_dest;
+		struct reloc *_jump_table;
+	};
 	struct alternative *alts;
 	struct symbol *sym;
 	struct stack_op *stack_ops;
