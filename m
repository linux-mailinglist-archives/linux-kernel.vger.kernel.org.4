Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8B68F467
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBHRYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjBHRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D74E52B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wzBN97ZQFhjUhX+K0c8kPMFOf7C/Gf9jJ86oNi8wN4M=; b=EsoEMmiZgEYdWvchlhellXRAEr
        i8BgamOpFzs3xx7hnUoRAGHB+jiwAJ2VmeNuDM27rtX4dzQ00PSc9o6w3dJtYhjXRDTNbPCSiwixU
        0dYDmmbW3k/07WB92v+pmR2gl1W6VtdM/1OGabG5fNeI3gC83t+Ewl831WuBwfVekbbVgke2mlO+6
        GHXWrUT2siE71T4BI+D3RrwjGWVzX0RGJd51cn0HYjuSyymVK58B467VkzgJuXseJtp1n7N2arb+4
        7ltViIikb/1lyQQsEHKYlvY8gGEYJTvyr/qIamRlXhXkIDPpF9XiSZJYZxthoB/XTFZH6+mrmJnOo
        Y3t6DNtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA4-007Vvh-1Q;
        Wed, 08 Feb 2023 17:23:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49770300CCD;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 236D423D8CFB5; Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Message-ID: <20230208172245.851307606@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:18:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 09/10] objtool: Remove instruction::list
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
---
 tools/objtool/check.c                   |  166 ++++++++++++++++++++------------
 tools/objtool/include/objtool/check.h   |   51 +++++----
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 4 files changed, 133 insertions(+), 86 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -47,27 +47,29 @@ struct instruction *find_insn(struct obj
 	return NULL;
 }
 
-static struct instruction *next_insn_same_sec(struct objtool_file *file,
-					      struct instruction *insn)
+struct instruction *next_insn_same_sec(struct objtool_file *file,
+				       struct instruction *insn)
 {
-	struct instruction *next = list_next_entry(insn, list);
+	if (insn->idx == INSN_CHUNK_MAX)
+		return find_insn(file, insn->sec, insn->offset + insn->len);
 
-	if (!next || &next->list == &file->insn_list || next->sec != insn->sec)
+	insn++;
+	if (!insn->len)
 		return NULL;
 
-	return next;
+	return insn;
 }
 
 static struct instruction *next_insn_same_func(struct objtool_file *file,
 					       struct instruction *insn)
 {
-	struct instruction *next = list_next_entry(insn, list);
+	struct instruction *next = next_insn_same_sec(file, insn);
 	struct symbol *func = insn_func(insn);
 
 	if (!func)
 		return NULL;
 
-	if (&next->list != &file->insn_list && insn_func(next) == func)
+	if (next && insn_func(next) == func)
 		return next;
 
 	/* Check if we're already in the subfunction: */
@@ -78,17 +80,35 @@ static struct instruction *next_insn_sam
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
 
+static struct instruction *prev_insn_same_sec(struct objtool_file *file,
+					      struct instruction *insn)
+{
+	if (insn->idx == 0) {
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
-	struct instruction *prev = list_prev_entry(insn, list);
+	struct instruction *prev = prev_insn_same_sec(file, insn);
 
-	if (&prev->list != &file->insn_list && insn_func(prev) == insn_func(insn))
+	if (prev && insn_func(prev) == insn_func(insn))
 		return prev;
 
 	return NULL;
 }
 
+#define for_each_insn(file, insn)					\
+	for (struct section *__sec, *__fake = (struct section *)1;	\
+	     __fake; __fake = NULL)					\
+		for_each_sec(file, __sec)				\
+			sec_for_each_insn(file, __sec, insn)
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn = find_insn(file, func->sec, func->offset);		\
 	     insn;							\
@@ -96,16 +116,13 @@ static struct instruction *prev_insn_sam
 
 #define sym_for_each_insn(file, sym, insn)				\
 	for (insn = find_insn(file, sym->sec, sym->offset);		\
-	     insn && &insn->list != &file->insn_list &&			\
-		insn->sec == sym->sec &&				\
-		insn->offset < sym->offset + sym->len;			\
-	     insn = list_next_entry(insn, list))
+	     insn && insn->offset < sym->offset + sym->len;		\
+	     insn = next_insn_same_sec(file, insn))
 
 #define sym_for_each_insn_continue_reverse(file, sym, insn)		\
-	for (insn = list_prev_entry(insn, list);			\
-	     &insn->list != &file->insn_list &&				\
-		insn->sec == sym->sec && insn->offset >= sym->offset;	\
-	     insn = list_prev_entry(insn, list))
+	for (insn = prev_insn_same_sec(file, insn);			\
+	     insn && insn->offset >= sym->offset;			\
+	     insn = prev_insn_same_sec(file, insn))
 
 #define sec_for_each_insn_from(file, insn)				\
 	for (; insn; insn = next_insn_same_sec(file, insn))
@@ -383,6 +400,9 @@ static int decode_instructions(struct ob
 	int ret;
 
 	for_each_sec(file, sec) {
+		struct instruction *insns = NULL;
+		u8 prev_len = 0;
+		u8 idx = 0;
 
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
 			continue;
@@ -407,22 +427,31 @@ static int decode_instructions(struct ob
 			sec->init = true;
 
 		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
-			insn = malloc(sizeof(*insn));
-			if (!insn) {
-				WARN("malloc failed");
-				return -1;
+			if (!insns || idx == INSN_CHUNK_MAX) {
+				insns = calloc(sizeof(*insn), INSN_CHUNK_SIZE);
+				if (!insns) {
+					WARN("malloc failed");
+					return -1;
+				}
+				idx = 0;
+			} else {
+				idx++;
 			}
-			memset(insn, 0, sizeof(*insn));
-			INIT_LIST_HEAD(&insn->call_node);
+			insn = &insns[idx];
+			insn->idx = idx;
 
+			INIT_LIST_HEAD(&insn->call_node);
 			insn->sec = sec;
 			insn->offset = offset;
+			insn->prev_len = prev_len;
 
 			ret = arch_decode_instruction(file, sec, offset,
 						      sec->sh.sh_size - offset,
 						      insn);
 			if (ret)
-				goto err;
+				return ret;
+
+			prev_len = insn->len;
 
 			/*
 			 * By default, "ud2" is a dead end unless otherwise
@@ -433,10 +462,11 @@ static int decode_instructions(struct ob
 				insn->dead_end = true;
 
 			hash_add(file->insn_hash, &insn->hash, sec_offset_hash(sec, insn->offset));
-			list_add_tail(&insn->list, &file->insn_list);
 			nr_insns++;
 		}
 
+//		printf("%s: last chunk used: %d\n", sec->name, (int)idx);
+
 		list_for_each_entry(func, &sec->symbol_list, list) {
 			if (func->type != STT_NOTYPE && func->type != STT_FUNC)
 				continue;
@@ -479,10 +509,6 @@ static int decode_instructions(struct ob
 		printf("nr_insns: %lu\n", nr_insns);
 
 	return 0;
-
-err:
-	free(insn);
-	return ret;
 }
 
 /*
@@ -597,7 +623,7 @@ static int add_dead_ends(struct objtool_
 		}
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
-			insn = list_prev_entry(insn, list);
+			insn = prev_insn_same_sec(file, insn);
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
@@ -632,7 +658,7 @@ static int add_dead_ends(struct objtool_
 		}
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
-			insn = list_prev_entry(insn, list);
+			insn = prev_insn_same_sec(file, insn);
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
@@ -1763,6 +1789,7 @@ static int handle_group_alt(struct objto
 		orig_alt_group->orig_group = NULL;
 		orig_alt_group->first_insn = orig_insn;
 		orig_alt_group->last_insn = last_orig_insn;
+		orig_alt_group->nop = NULL;
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset != special_alt->orig_len) {
@@ -1864,12 +1891,11 @@ static int handle_group_alt(struct objto
 		return -1;
 	}
 
-	if (nop)
-		list_add(&nop->list, &last_new_insn->list);
 end:
 	new_alt_group->orig_group = orig_alt_group;
 	new_alt_group->first_insn = *new_insn;
-	new_alt_group->last_insn = nop ? : last_new_insn;
+	new_alt_group->last_insn = last_new_insn;
+	new_alt_group->nop = nop;
 	new_alt_group->cfi = orig_alt_group->cfi;
 	return 0;
 }
@@ -1919,7 +1945,7 @@ static int handle_jump_alt(struct objtoo
 	else
 		file->jl_long++;
 
-	*new_insn = list_next_entry(orig_insn, list);
+	*new_insn = next_insn_same_sec(file, orig_insn);
 	return 0;
 }
 
@@ -3504,11 +3530,28 @@ static struct instruction *next_insn_to_
 	 * Simulate the fact that alternatives are patched in-place.  When the
 	 * end of a replacement alt_group is reached, redirect objtool flow to
 	 * the end of the original alt_group.
+	 *
+	 * insn->alts->insn -> alt_group->first_insn
+	 *		       ...
+	 *		       alt_group->last_insn
+	 *		       [alt_group->nop]      -> next(orig_group->last_insn)
 	 */
-	if (alt_group && insn == alt_group->last_insn && alt_group->orig_group)
-		return next_insn_same_sec(file, alt_group->orig_group->last_insn);
+	if (alt_group) {
+		if (alt_group->nop) {
+			/* ->nop implies ->orig_group */
+			if (insn == alt_group->last_insn)
+				return alt_group->nop;
+			if (insn == alt_group->nop)
+				goto next_orig;
+		}
+		if (insn == alt_group->last_insn && alt_group->orig_group)
+			goto next_orig;
+	}
 
 	return next_insn_same_sec(file, insn);
+
+next_orig:
+	return next_insn_same_sec(file, alt_group->orig_group->last_insn);
 }
 
 /*
@@ -3759,11 +3802,25 @@ static int validate_branch(struct objtoo
 	return 0;
 }
 
+static int validate_unwind_hint(struct objtool_file *file,
+				  struct instruction *insn,
+				  struct insn_state *state)
+{
+	if (insn->hint && !insn->visited && !insn->ignore) {
+		int ret = validate_branch(file, insn_func(insn), insn, *state);
+		if (ret && opts.backtrace)
+			BT_FUNC("<=== (hint)", insn);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 {
 	struct instruction *insn;
 	struct insn_state state;
-	int ret, warnings = 0;
+	int warnings = 0;
 
 	if (!file->hints)
 		return 0;
@@ -3771,22 +3828,11 @@ static int validate_unwind_hints(struct
 	init_insn_state(file, &state, sec);
 
 	if (sec) {
-		insn = find_insn(file, sec, 0);
-		if (!insn)
-			return 0;
+		sec_for_each_insn(file, sec, insn)
+			warnings += validate_unwind_hint(file, insn, &state);
 	} else {
-		insn = list_first_entry(&file->insn_list, typeof(*insn), list);
-	}
-
-	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
-		if (insn->hint && !insn->visited && !insn->ignore) {
-			ret = validate_branch(file, insn_func(insn), insn, state);
-			if (ret && opts.backtrace)
-				BT_FUNC("<=== (hint)", insn);
-			warnings += ret;
-		}
-
-		insn = list_next_entry(insn, list);
+		for_each_insn(file, insn)
+			warnings += validate_unwind_hint(file, insn, &state);
 	}
 
 	return warnings;
@@ -4052,7 +4098,7 @@ static bool ignore_unreachable_insn(stru
 	 *
 	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
-	prev_insn = list_prev_entry(insn, list);
+	prev_insn = prev_insn_same_sec(file, insn);
 	if ((prev_insn->dead_end ||
 	     dead_end_function(file, insn_call_dest(prev_insn))) &&
 	    (insn->type == INSN_BUG ||
@@ -4084,7 +4130,7 @@ static bool ignore_unreachable_insn(stru
 		if (insn->offset + insn->len >= insn_func(insn)->offset + insn_func(insn)->len)
 			break;
 
-		insn = list_next_entry(insn, list);
+		insn = next_insn_same_sec(file, insn);
 	}
 
 	return false;
@@ -4097,10 +4143,10 @@ static int add_prefix_symbol(struct objt
 		return 0;
 
 	for (;;) {
-		struct instruction *prev = list_prev_entry(insn, list);
+		struct instruction *prev = prev_insn_same_sec(file, insn);
 		u64 offset;
 
-		if (&prev->list == &file->insn_list)
+		if (!prev)
 			break;
 
 		if (prev->type != INSN_NOP)
@@ -4493,7 +4539,7 @@ int check(struct objtool_file *file)
 
 	warnings += ret;
 
-	if (list_empty(&file->insn_list))
+	if (!nr_insns)
 		goto out;
 
 	if (opts.retpoline) {
@@ -4602,7 +4648,7 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	if (opts.orc && !list_empty(&file->insn_list)) {
+	if (opts.orc && nr_insns) {
 		ret = orc_create(file);
 		if (ret < 0)
 			goto out;
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -27,7 +27,7 @@ struct alt_group {
 	struct alt_group *orig_group;
 
 	/* First and last instructions in the group */
-	struct instruction *first_insn, *last_insn;
+	struct instruction *first_insn, *last_insn, *nop;
 
 	/*
 	 * Byte-offset-addressed len-sized array of pointers to CFI structs.
@@ -36,31 +36,36 @@ struct alt_group {
 	struct cfi_state **cfi;
 };
 
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
 
+	u8 len;
+	u8 prev_len;
+	u8 type;
 	s8 instr;
 
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
@@ -109,13 +114,11 @@ static inline bool is_jump(struct instru
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
 
-#define for_each_insn(file, insn)					\
-	list_for_each_entry(insn, &file->insn_list, list)
+struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruction *insn);
 
-#define sec_for_each_insn(file, sec, insn)				\
-	for (insn = find_insn(file, sec, 0);				\
-	     insn && &insn->list != &file->insn_list &&			\
-			insn->sec == sec;				\
-	     insn = list_next_entry(insn, list))
+#define sec_for_each_insn(file, _sec, insn)				\
+	for (insn = find_insn(file, _sec, 0);				\
+	     insn && insn->sec == _sec;					\
+	     insn = next_insn_same_sec(file, insn))
 
 #endif /* _CHECK_H */
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -21,7 +21,6 @@ struct pv_state {
 
 struct objtool_file {
 	struct elf *elf;
-	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
 	struct list_head retpoline_call_list;
 	struct list_head return_thunk_list;
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -99,7 +99,6 @@ struct objtool_file *objtool_open_read(c
 		return NULL;
 	}
 
-	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.return_thunk_list);


