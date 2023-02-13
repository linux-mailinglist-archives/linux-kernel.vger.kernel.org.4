Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030A6943EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjBMLKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBMLKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC8D539;
        Mon, 13 Feb 2023 03:10:30 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:10:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676286628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCAK5aWAupP4I1r3332LS3DrK45cnunDMGIlTLQyUSo=;
        b=IRsCxRgiktT4HER4NFCEgoi7HRdbkmlCtHfK9undKbGEsh88j8cOGa//0ysxSEkNXMeZi6
        NtVbr73qmRfBKDDMNAJjUS6ZHRr4dBvCl9W6dwAAJ2NQGTRcF+9pi0xWkKI1EJgeDg+HgU
        OMB4HeAKDFO3GbGG/FUsaBJxt2+uHkV7Lb0l0RyKiMBHsI4KKYunKqaE878pZcFc/E8wEZ
        s0IT/f9ZsexcnEZFCmaG6qEFV5/Vc8aYgPWOdLD3TDwbdX1g0xGVR3zimzpeJRySvGd/Ml
        zz7U+slKmCDSjQ5K2yJlwWrRZ5/o/9Usu8bBk8UOZ+XKC/37+r3vtBFWbma9Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676286628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCAK5aWAupP4I1r3332LS3DrK45cnunDMGIlTLQyUSo=;
        b=CTK+IbdOWbw5UVv3S3Miip6AoN0ITgU61Za5+NBPLxrKUsV0uB9IUe1K5NyBM85jzHALs5
        gbZ+hMgH0qs2+mAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove instruction::list
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.851307606@infradead.org>
References: <20230208172245.851307606@infradead.org>
MIME-Version: 1.0
Message-ID: <167628662763.4906.11858025806195011386.tip-bot2@tip-bot2>
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

Commit-ID:     5a10ca6e6400d472553fda72e51e5ba598d24e1f
Gitweb:        https://git.kernel.org/tip/5a10ca6e6400d472553fda72e51e5ba598d=
24e1f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:18:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Feb 2023 11:26:09 +01:00

objtool: Remove instruction::list

Replace the instruction::list by allocating instructions in arrays of
256 entries and stringing them together by (amortized) find_insn().
This shrinks instruction by 16 bytes and brings it down to 128.

 struct instruction {
-	struct list_head           list;                 /*     0    16 */
-	struct hlist_node          hash;                 /*    16    16 */
-	struct list_head           call_node;            /*    32    16 */
-	struct section *           sec;                  /*    48     8 */
-	long unsigned int          offset;               /*    56     8 */
-	/* --- cacheline 1 boundary (64 bytes) --- */
-	long unsigned int          immediate;            /*    64     8 */
-	unsigned int               len;                  /*    72     4 */
-	u8                         type;                 /*    76     1 */
-
-	/* Bitfield combined with previous fields */
+	struct hlist_node          hash;                 /*     0    16 */
+	struct list_head           call_node;            /*    16    16 */
+	struct section *           sec;                  /*    32     8 */
+	long unsigned int          offset;               /*    40     8 */
+	long unsigned int          immediate;            /*    48     8 */
+	u8                         len;                  /*    56     1 */
+	u8                         prev_len;             /*    57     1 */
+	u8                         type;                 /*    58     1 */
+	s8                         instr;                /*    59     1 */
+	u32                        idx:8;                /*    60: 0  4 */
+	u32                        dead_end:1;           /*    60: 8  4 */
+	u32                        ignore:1;             /*    60: 9  4 */
+	u32                        ignore_alts:1;        /*    60:10  4 */
+	u32                        hint:1;               /*    60:11  4 */
+	u32                        save:1;               /*    60:12  4 */
+	u32                        restore:1;            /*    60:13  4 */
+	u32                        retpoline_safe:1;     /*    60:14  4 */
+	u32                        noendbr:1;            /*    60:15  4 */
+	u32                        entry:1;              /*    60:16  4 */
+	u32                        visited:4;            /*    60:17  4 */
+	u32                        no_reloc:1;           /*    60:21  4 */

-	u16                        dead_end:1;           /*    76: 8  2 */
-	u16                        ignore:1;             /*    76: 9  2 */
-	u16                        ignore_alts:1;        /*    76:10  2 */
-	u16                        hint:1;               /*    76:11  2 */
-	u16                        save:1;               /*    76:12  2 */
-	u16                        restore:1;            /*    76:13  2 */
-	u16                        retpoline_safe:1;     /*    76:14  2 */
-	u16                        noendbr:1;            /*    76:15  2 */
-	u16                        entry:1;              /*    78: 0  2 */
-	u16                        visited:4;            /*    78: 1  2 */
-	u16                        no_reloc:1;           /*    78: 5  2 */
+	/* XXX 10 bits hole, try to pack */

-	/* XXX 2 bits hole, try to pack */
-	/* Bitfield combined with next fields */
-
-	s8                         instr;                /*    79     1 */
-	struct alt_group *         alt_group;            /*    80     8 */
-	struct instruction *       jump_dest;            /*    88     8 */
-	struct instruction *       first_jump_src;       /*    96     8 */
+	/* --- cacheline 1 boundary (64 bytes) --- */
+	struct alt_group *         alt_group;            /*    64     8 */
+	struct instruction *       jump_dest;            /*    72     8 */
+	struct instruction *       first_jump_src;       /*    80     8 */
 	union {
-		struct symbol *    _call_dest;           /*   104     8 */
-		struct reloc *     _jump_table;          /*   104     8 */
-	};                                               /*   104     8 */
-	struct alternative *       alts;                 /*   112     8 */
-	struct symbol *            sym;                  /*   120     8 */
-	/* --- cacheline 2 boundary (128 bytes) --- */
-	struct stack_op *          stack_ops;            /*   128     8 */
-	struct cfi_state *         cfi;                  /*   136     8 */
+		struct symbol *    _call_dest;           /*    88     8 */
+		struct reloc *     _jump_table;          /*    88     8 */
+	};                                               /*    88     8 */
+	struct alternative *       alts;                 /*    96     8 */
+	struct symbol *            sym;                  /*   104     8 */
+	struct stack_op *          stack_ops;            /*   112     8 */
+	struct cfi_state *         cfi;                  /*   120     8 */

-	/* size: 144, cachelines: 3, members: 28 */
-	/* sum members: 142 */
-	/* sum bitfield members: 14 bits, bit holes: 1, sum bit holes: 2 bits */
-	/* last cacheline: 16 bytes */
+	/* size: 128, cachelines: 2, members: 29 */
+	/* sum members: 124 */
+	/* sum bitfield members: 22 bits, bit holes: 1, sum bit holes: 10 bits */
 };

pre:	5:38.18 real,   213.25 user,    124.90 sys,     23449040 mem
post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.851307606@infradead.org
---
 tools/objtool/check.c                   | 166 ++++++++++++++---------
 tools/objtool/include/objtool/check.h   |  51 +++----
 tools/objtool/include/objtool/objtool.h |   1 +-
 tools/objtool/objtool.c                 |   1 +-
 4 files changed, 133 insertions(+), 86 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7e9d3d3..b0b467d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -47,27 +47,29 @@ struct instruction *find_insn(struct objtool_file *file,
 	return NULL;
 }
=20
-static struct instruction *next_insn_same_sec(struct objtool_file *file,
-					      struct instruction *insn)
+struct instruction *next_insn_same_sec(struct objtool_file *file,
+				       struct instruction *insn)
 {
-	struct instruction *next =3D list_next_entry(insn, list);
+	if (insn->idx =3D=3D INSN_CHUNK_MAX)
+		return find_insn(file, insn->sec, insn->offset + insn->len);
=20
-	if (!next || &next->list =3D=3D &file->insn_list || next->sec !=3D insn->se=
c)
+	insn++;
+	if (!insn->len)
 		return NULL;
=20
-	return next;
+	return insn;
 }
=20
 static struct instruction *next_insn_same_func(struct objtool_file *file,
 					       struct instruction *insn)
 {
-	struct instruction *next =3D list_next_entry(insn, list);
+	struct instruction *next =3D next_insn_same_sec(file, insn);
 	struct symbol *func =3D insn_func(insn);
=20
 	if (!func)
 		return NULL;
=20
-	if (&next->list !=3D &file->insn_list && insn_func(next) =3D=3D func)
+	if (next && insn_func(next) =3D=3D func)
 		return next;
=20
 	/* Check if we're already in the subfunction: */
@@ -78,17 +80,35 @@ static struct instruction *next_insn_same_func(struct obj=
tool_file *file,
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
=20
+static struct instruction *prev_insn_same_sec(struct objtool_file *file,
+					      struct instruction *insn)
+{
+	if (insn->idx =3D=3D 0) {
+		if (insn->prev_len)
+			return find_insn(file, insn->sec, insn->offset - insn->prev_len);
+		return NULL;
+	}
+
+	return insn - 1;
+}
+
 static struct instruction *prev_insn_same_sym(struct objtool_file *file,
-					       struct instruction *insn)
+					      struct instruction *insn)
 {
-	struct instruction *prev =3D list_prev_entry(insn, list);
+	struct instruction *prev =3D prev_insn_same_sec(file, insn);
=20
-	if (&prev->list !=3D &file->insn_list && insn_func(prev) =3D=3D insn_func(i=
nsn))
+	if (prev && insn_func(prev) =3D=3D insn_func(insn))
 		return prev;
=20
 	return NULL;
 }
=20
+#define for_each_insn(file, insn)					\
+	for (struct section *__sec, *__fake =3D (struct section *)1;	\
+	     __fake; __fake =3D NULL)					\
+		for_each_sec(file, __sec)				\
+			sec_for_each_insn(file, __sec, insn)
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn =3D find_insn(file, func->sec, func->offset);		\
 	     insn;							\
@@ -96,16 +116,13 @@ static struct instruction *prev_insn_same_sym(struct obj=
tool_file *file,
=20
 #define sym_for_each_insn(file, sym, insn)				\
 	for (insn =3D find_insn(file, sym->sec, sym->offset);		\
-	     insn && &insn->list !=3D &file->insn_list &&			\
-		insn->sec =3D=3D sym->sec &&				\
-		insn->offset < sym->offset + sym->len;			\
-	     insn =3D list_next_entry(insn, list))
+	     insn && insn->offset < sym->offset + sym->len;		\
+	     insn =3D next_insn_same_sec(file, insn))
=20
 #define sym_for_each_insn_continue_reverse(file, sym, insn)		\
-	for (insn =3D list_prev_entry(insn, list);			\
-	     &insn->list !=3D &file->insn_list &&				\
-		insn->sec =3D=3D sym->sec && insn->offset >=3D sym->offset;	\
-	     insn =3D list_prev_entry(insn, list))
+	for (insn =3D prev_insn_same_sec(file, insn);			\
+	     insn && insn->offset >=3D sym->offset;			\
+	     insn =3D prev_insn_same_sec(file, insn))
=20
 #define sec_for_each_insn_from(file, insn)				\
 	for (; insn; insn =3D next_insn_same_sec(file, insn))
@@ -384,6 +401,9 @@ static int decode_instructions(struct objtool_file *file)
 	int ret;
=20
 	for_each_sec(file, sec) {
+		struct instruction *insns =3D NULL;
+		u8 prev_len =3D 0;
+		u8 idx =3D 0;
=20
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
 			continue;
@@ -409,22 +429,31 @@ static int decode_instructions(struct objtool_file *fil=
e)
 			sec->init =3D true;
=20
 		for (offset =3D 0; offset < sec->sh.sh_size; offset +=3D insn->len) {
-			insn =3D malloc(sizeof(*insn));
-			if (!insn) {
-				WARN("malloc failed");
-				return -1;
+			if (!insns || idx =3D=3D INSN_CHUNK_MAX) {
+				insns =3D calloc(sizeof(*insn), INSN_CHUNK_SIZE);
+				if (!insns) {
+					WARN("malloc failed");
+					return -1;
+				}
+				idx =3D 0;
+			} else {
+				idx++;
 			}
-			memset(insn, 0, sizeof(*insn));
-			INIT_LIST_HEAD(&insn->call_node);
+			insn =3D &insns[idx];
+			insn->idx =3D idx;
=20
+			INIT_LIST_HEAD(&insn->call_node);
 			insn->sec =3D sec;
 			insn->offset =3D offset;
+			insn->prev_len =3D prev_len;
=20
 			ret =3D arch_decode_instruction(file, sec, offset,
 						      sec->sh.sh_size - offset,
 						      insn);
 			if (ret)
-				goto err;
+				return ret;
+
+			prev_len =3D insn->len;
=20
 			/*
 			 * By default, "ud2" is a dead end unless otherwise
@@ -435,10 +464,11 @@ static int decode_instructions(struct objtool_file *fil=
e)
 				insn->dead_end =3D true;
=20
 			hash_add(file->insn_hash, &insn->hash, sec_offset_hash(sec, insn->offset)=
);
-			list_add_tail(&insn->list, &file->insn_list);
 			nr_insns++;
 		}
=20
+//		printf("%s: last chunk used: %d\n", sec->name, (int)idx);
+
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type !=3D STT_NOTYPE && func->type !=3D STT_FUNC)
 				continue;
@@ -481,10 +511,6 @@ static int decode_instructions(struct objtool_file *file)
 		printf("nr_insns: %lu\n", nr_insns);
=20
 	return 0;
-
-err:
-	free(insn);
-	return ret;
 }
=20
 /*
@@ -599,7 +625,7 @@ static int add_dead_ends(struct objtool_file *file)
 		}
 		insn =3D find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
-			insn =3D list_prev_entry(insn, list);
+			insn =3D prev_insn_same_sec(file, insn);
 		else if (reloc->addend =3D=3D reloc->sym->sec->sh.sh_size) {
 			insn =3D find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
@@ -634,7 +660,7 @@ reachable:
 		}
 		insn =3D find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
-			insn =3D list_prev_entry(insn, list);
+			insn =3D prev_insn_same_sec(file, insn);
 		else if (reloc->addend =3D=3D reloc->sym->sec->sh.sh_size) {
 			insn =3D find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
@@ -1775,6 +1801,7 @@ static int handle_group_alt(struct objtool_file *file,
 		orig_alt_group->orig_group =3D NULL;
 		orig_alt_group->first_insn =3D orig_insn;
 		orig_alt_group->last_insn =3D last_orig_insn;
+		orig_alt_group->nop =3D NULL;
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset !=3D special_alt->orig_len) {
@@ -1876,12 +1903,11 @@ static int handle_group_alt(struct objtool_file *file,
 		return -1;
 	}
=20
-	if (nop)
-		list_add(&nop->list, &last_new_insn->list);
 end:
 	new_alt_group->orig_group =3D orig_alt_group;
 	new_alt_group->first_insn =3D *new_insn;
-	new_alt_group->last_insn =3D nop ? : last_new_insn;
+	new_alt_group->last_insn =3D last_new_insn;
+	new_alt_group->nop =3D nop;
 	new_alt_group->cfi =3D orig_alt_group->cfi;
 	return 0;
 }
@@ -1931,7 +1957,7 @@ static int handle_jump_alt(struct objtool_file *file,
 	else
 		file->jl_long++;
=20
-	*new_insn =3D list_next_entry(orig_insn, list);
+	*new_insn =3D next_insn_same_sec(file, orig_insn);
 	return 0;
 }
=20
@@ -3522,11 +3548,28 @@ static struct instruction *next_insn_to_validate(stru=
ct objtool_file *file,
 	 * Simulate the fact that alternatives are patched in-place.  When the
 	 * end of a replacement alt_group is reached, redirect objtool flow to
 	 * the end of the original alt_group.
+	 *
+	 * insn->alts->insn -> alt_group->first_insn
+	 *		       ...
+	 *		       alt_group->last_insn
+	 *		       [alt_group->nop]      -> next(orig_group->last_insn)
 	 */
-	if (alt_group && insn =3D=3D alt_group->last_insn && alt_group->orig_group)
-		return next_insn_same_sec(file, alt_group->orig_group->last_insn);
+	if (alt_group) {
+		if (alt_group->nop) {
+			/* ->nop implies ->orig_group */
+			if (insn =3D=3D alt_group->last_insn)
+				return alt_group->nop;
+			if (insn =3D=3D alt_group->nop)
+				goto next_orig;
+		}
+		if (insn =3D=3D alt_group->last_insn && alt_group->orig_group)
+			goto next_orig;
+	}
=20
 	return next_insn_same_sec(file, insn);
+
+next_orig:
+	return next_insn_same_sec(file, alt_group->orig_group->last_insn);
 }
=20
 /*
@@ -3777,11 +3820,25 @@ static int validate_branch(struct objtool_file *file,=
 struct symbol *func,
 	return 0;
 }
=20
+static int validate_unwind_hint(struct objtool_file *file,
+				  struct instruction *insn,
+				  struct insn_state *state)
+{
+	if (insn->hint && !insn->visited && !insn->ignore) {
+		int ret =3D validate_branch(file, insn_func(insn), insn, *state);
+		if (ret && opts.backtrace)
+			BT_FUNC("<=3D=3D=3D (hint)", insn);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int validate_unwind_hints(struct objtool_file *file, struct section *=
sec)
 {
 	struct instruction *insn;
 	struct insn_state state;
-	int ret, warnings =3D 0;
+	int warnings =3D 0;
=20
 	if (!file->hints)
 		return 0;
@@ -3789,22 +3846,11 @@ static int validate_unwind_hints(struct objtool_file =
*file, struct section *sec)
 	init_insn_state(file, &state, sec);
=20
 	if (sec) {
-		insn =3D find_insn(file, sec, 0);
-		if (!insn)
-			return 0;
+		sec_for_each_insn(file, sec, insn)
+			warnings +=3D validate_unwind_hint(file, insn, &state);
 	} else {
-		insn =3D list_first_entry(&file->insn_list, typeof(*insn), list);
-	}
-
-	while (&insn->list !=3D &file->insn_list && (!sec || insn->sec =3D=3D sec))=
 {
-		if (insn->hint && !insn->visited && !insn->ignore) {
-			ret =3D validate_branch(file, insn_func(insn), insn, state);
-			if (ret && opts.backtrace)
-				BT_FUNC("<=3D=3D=3D (hint)", insn);
-			warnings +=3D ret;
-		}
-
-		insn =3D list_next_entry(insn, list);
+		for_each_insn(file, insn)
+			warnings +=3D validate_unwind_hint(file, insn, &state);
 	}
=20
 	return warnings;
@@ -4070,7 +4116,7 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
 	 *
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
-	prev_insn =3D list_prev_entry(insn, list);
+	prev_insn =3D prev_insn_same_sec(file, insn);
 	if ((prev_insn->dead_end ||
 	     dead_end_function(file, insn_call_dest(prev_insn))) &&
 	    (insn->type =3D=3D INSN_BUG ||
@@ -4102,7 +4148,7 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
 		if (insn->offset + insn->len >=3D insn_func(insn)->offset + insn_func(insn=
)->len)
 			break;
=20
-		insn =3D list_next_entry(insn, list);
+		insn =3D next_insn_same_sec(file, insn);
 	}
=20
 	return false;
@@ -4115,10 +4161,10 @@ static int add_prefix_symbol(struct objtool_file *fil=
e, struct symbol *func,
 		return 0;
=20
 	for (;;) {
-		struct instruction *prev =3D list_prev_entry(insn, list);
+		struct instruction *prev =3D prev_insn_same_sec(file, insn);
 		u64 offset;
=20
-		if (&prev->list =3D=3D &file->insn_list)
+		if (!prev)
 			break;
=20
 		if (prev->type !=3D INSN_NOP)
@@ -4517,7 +4563,7 @@ int check(struct objtool_file *file)
=20
 	warnings +=3D ret;
=20
-	if (list_empty(&file->insn_list))
+	if (!nr_insns)
 		goto out;
=20
 	if (opts.retpoline) {
@@ -4626,7 +4672,7 @@ int check(struct objtool_file *file)
 		warnings +=3D ret;
 	}
=20
-	if (opts.orc && !list_empty(&file->insn_list)) {
+	if (opts.orc && nr_insns) {
 		ret =3D orc_create(file);
 		if (ret < 0)
 			goto out;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index ab6deae..3e7c700 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -27,7 +27,7 @@ struct alt_group {
 	struct alt_group *orig_group;
=20
 	/* First and last instructions in the group */
-	struct instruction *first_insn, *last_insn;
+	struct instruction *first_insn, *last_insn, *nop;
=20
 	/*
 	 * Byte-offset-addressed len-sized array of pointers to CFI structs.
@@ -36,31 +36,36 @@ struct alt_group {
 	struct cfi_state **cfi;
 };
=20
+#define INSN_CHUNK_BITS		8
+#define INSN_CHUNK_SIZE		(1 << INSN_CHUNK_BITS)
+#define INSN_CHUNK_MAX		(INSN_CHUNK_SIZE - 1)
+
 struct instruction {
-	struct list_head list;
 	struct hlist_node hash;
 	struct list_head call_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned long immediate;
-	unsigned int len;
-	u8 type;
-
-	u16 dead_end		: 1,
-	   ignore		: 1,
-	   ignore_alts		: 1,
-	   hint			: 1,
-	   save			: 1,
-	   restore		: 1,
-	   retpoline_safe	: 1,
-	   noendbr		: 1,
-	   entry		: 1,
-	   visited		: 4,
-	   no_reloc		: 1;
-		/* 2 bit hole */
=20
+	u8 len;
+	u8 prev_len;
+	u8 type;
 	s8 instr;
=20
+	u32 idx			: INSN_CHUNK_BITS,
+	    dead_end		: 1,
+	    ignore		: 1,
+	    ignore_alts		: 1,
+	    hint		: 1,
+	    save		: 1,
+	    restore		: 1,
+	    retpoline_safe	: 1,
+	    noendbr		: 1,
+	    entry		: 1,
+	    visited		: 4,
+	    no_reloc		: 1;
+		/* 10 bit hole */
+
 	struct alt_group *alt_group;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
@@ -109,13 +114,11 @@ static inline bool is_jump(struct instruction *insn)
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
=20
-#define for_each_insn(file, insn)					\
-	list_for_each_entry(insn, &file->insn_list, list)
+struct instruction *next_insn_same_sec(struct objtool_file *file, struct ins=
truction *insn);
=20
-#define sec_for_each_insn(file, sec, insn)				\
-	for (insn =3D find_insn(file, sec, 0);				\
-	     insn && &insn->list !=3D &file->insn_list &&			\
-			insn->sec =3D=3D sec;				\
-	     insn =3D list_next_entry(insn, list))
+#define sec_for_each_insn(file, _sec, insn)				\
+	for (insn =3D find_insn(file, _sec, 0);				\
+	     insn && insn->sec =3D=3D _sec;					\
+	     insn =3D next_insn_same_sec(file, insn))
=20
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/=
objtool/objtool.h
index 6b40977..94a33ee 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -21,7 +21,6 @@ struct pv_state {
=20
 struct objtool_file {
 	struct elf *elf;
-	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
 	struct list_head retpoline_call_list;
 	struct list_head return_thunk_list;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 6affd80..c54f723 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -99,7 +99,6 @@ struct objtool_file *objtool_open_read(const char *_objname)
 		return NULL;
 	}
=20
-	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.return_thunk_list);
