Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1A6011D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJQOzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJQOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:54:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578569193;
        Mon, 17 Oct 2022 07:54:00 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=37AqhZ1J99hqvkzmvycFPVAzkOg4xUbgrKK3c22m2ek=;
        b=b/A4vVp8svKLLKA3mPCdv2grjAG23G+l/pxVLeI1s9etnefs8mDSSxsbZVYrkU+968+87B
        Py9BnxKOVFkM5EiLAATvE2iXDrYOCg+gzwQC/CCIPXgFvP8xkFGp2bDl63jxU4t+BqwE5I
        uOnLSghEI0rbmuPrFx4CqIS5IxMQmDksLlV1xDS76kNT4M4bBCPFGBaEqpvtN4KJIQi/9J
        hLQvA4L7bhMtr4aVWe4gLqDz7xpOKOQwliJ2OIwxGyYJ+z5bVGuNvqwIQ3hJiGx0zR8Bs8
        yANXW5tFKdV0Xn8SDPzo6VjqiBIXWjGLukEfkkmwGpOgPdwHCM5f+9PndGWgpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=37AqhZ1J99hqvkzmvycFPVAzkOg4xUbgrKK3c22m2ek=;
        b=5EPyL8s/dXp+fZiEGIFaDIawtFd74sgRHOMTw2/qn6KB3eu4H80vccgcZm2GlAT5xfUJPF
        270XbDGedT+Tk3BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Rework instruction -> symbol mapping
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166601843578.401.7005725839416716951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     dbcdbdfdf137b49144204571f1a5e5dc01b8aaad
Gitweb:        https://git.kernel.org/tip/dbcdbdfdf137b49144204571f1a5e5dc01b8aaad
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 22 Sep 2022 22:03:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:08 +02:00

objtool: Rework instruction -> symbol mapping

Currently insn->func contains a instruction -> symbol link for
STT_FUNC symbols. A NULL value is assumed to mean STT_NOTYPE.
However, there are also instructions not covered by any symbol at all.
This can happen due to __weak symbols for example.

Since the current scheme cannot differentiate between no symbol and
STT_NOTYPE symbol, change things around. Make insn->sym point to any
symbol type such that !insn->sym means no symbol and add a helper
insn_func() that check the sym->type to retain the old functionality.

This then prepares the way to add code that depends on the distinction
between STT_NOTYPE and no symbol at all.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 | 105 +++++++++++++------------
 tools/objtool/include/objtool/check.h |  12 ++-
 2 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f46f46..e532efb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -62,12 +62,12 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 					       struct instruction *insn)
 {
 	struct instruction *next = list_next_entry(insn, list);
-	struct symbol *func = insn->func;
+	struct symbol *func = insn_func(insn);
 
 	if (!func)
 		return NULL;
 
-	if (&next->list != &file->insn_list && next->func == func)
+	if (&next->list != &file->insn_list && insn_func(next) == func)
 		return next;
 
 	/* Check if we're already in the subfunction: */
@@ -83,7 +83,7 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 {
 	struct instruction *prev = list_prev_entry(insn, list);
 
-	if (&prev->list != &file->insn_list && prev->func == insn->func)
+	if (&prev->list != &file->insn_list && insn_func(prev) == insn_func(insn))
 		return prev;
 
 	return NULL;
@@ -133,7 +133,7 @@ static bool is_sibling_call(struct instruction *insn)
 	 * sibling call detection consistency between vmlinux.o and individual
 	 * objects.
 	 */
-	if (!insn->func)
+	if (!insn_func(insn))
 		return false;
 
 	/* An indirect jump is either a sibling call or a jump to a table. */
@@ -207,7 +207,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		return false;
 
 	insn = find_insn(file, func->sec, func->offset);
-	if (!insn->func)
+	if (!insn_func(insn))
 		return false;
 
 	func_for_each_insn(file, func, insn) {
@@ -243,7 +243,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 				return false;
 			}
 
-			return __dead_end_function(file, dest->func, recursion+1);
+			return __dead_end_function(file, insn_func(dest), recursion+1);
 		}
 	}
 
@@ -427,7 +427,10 @@ static int decode_instructions(struct objtool_file *file)
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC || func->alias != func)
+			if (func->type != STT_NOTYPE && func->type != STT_FUNC)
+				continue;
+
+			if (func->return_thunk || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -437,9 +440,11 @@ static int decode_instructions(struct objtool_file *file)
 			}
 
 			sym_for_each_insn(file, func, insn) {
-				insn->func = func;
-				if (insn->type == INSN_ENDBR && list_empty(&insn->call_node)) {
-					if (insn->offset == insn->func->offset) {
+				insn->sym = func;
+				if (func->type == STT_FUNC &&
+				    insn->type == INSN_ENDBR &&
+				    list_empty(&insn->call_node)) {
+					if (insn->offset == func->offset) {
 						list_add_tail(&insn->call_node, &file->endbr_list);
 						file->nr_endbr++;
 					} else {
@@ -1397,19 +1402,19 @@ static void add_return_call(struct objtool_file *file, struct instruction *insn,
 
 static bool same_function(struct instruction *insn1, struct instruction *insn2)
 {
-	return insn1->func->pfunc == insn2->func->pfunc;
+	return insn_func(insn1)->pfunc == insn_func(insn2)->pfunc;
 }
 
 static bool is_first_func_insn(struct objtool_file *file, struct instruction *insn)
 {
-	if (insn->offset == insn->func->offset)
+	if (insn->offset == insn_func(insn)->offset)
 		return true;
 
 	if (opts.ibt) {
 		struct instruction *prev = prev_insn_same_sym(file, insn);
 
 		if (prev && prev->type == INSN_ENDBR &&
-		    insn->offset == insn->func->offset + prev->len)
+		    insn->offset == insn_func(insn)->offset + prev->len)
 			return true;
 	}
 
@@ -1450,7 +1455,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->return_thunk) {
 			add_return_call(file, insn, true);
 			continue;
-		} else if (insn->func) {
+		} else if (insn_func(insn)) {
 			/*
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
@@ -1492,8 +1497,8 @@ static int add_jump_destinations(struct objtool_file *file)
 		/*
 		 * Cross-function jump.
 		 */
-		if (insn->func && jump_dest->func &&
-		    insn->func != jump_dest->func) {
+		if (insn_func(insn) && insn_func(jump_dest) &&
+		    insn_func(insn) != insn_func(jump_dest)) {
 
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1510,10 +1515,10 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(insn->func->name, ".cold") &&
-			    strstr(jump_dest->func->name, ".cold")) {
-				insn->func->cfunc = jump_dest->func;
-				jump_dest->func->pfunc = insn->func;
+			if (!strstr(insn_func(insn)->name, ".cold") &&
+			    strstr(insn_func(jump_dest)->name, ".cold")) {
+				insn_func(insn)->cfunc = insn_func(jump_dest);
+				insn_func(jump_dest)->pfunc = insn_func(insn);
 
 			} else if (!same_function(insn, jump_dest) &&
 				   is_first_func_insn(file, jump_dest)) {
@@ -1521,7 +1526,7 @@ static int add_jump_destinations(struct objtool_file *file)
 				 * Internal sibling call without reloc or with
 				 * STT_SECTION reloc.
 				 */
-				add_call_dest(file, insn, jump_dest->func, true);
+				add_call_dest(file, insn, insn_func(jump_dest), true);
 				continue;
 			}
 		}
@@ -1572,7 +1577,7 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-			if (insn->func && insn->call_dest->type != STT_FUNC) {
+			if (insn_func(insn) && insn->call_dest->type != STT_FUNC) {
 				WARN_FUNC("unsupported call to non-function",
 					  insn->sec, insn->offset);
 				return -1;
@@ -1668,7 +1673,7 @@ static int handle_group_alt(struct objtool_file *file,
 		nop->offset = special_alt->new_off + special_alt->new_len;
 		nop->len = special_alt->orig_len - special_alt->new_len;
 		nop->type = INSN_NOP;
-		nop->func = orig_insn->func;
+		nop->sym = orig_insn->sym;
 		nop->alt_group = new_alt_group;
 		nop->ignore = orig_insn->ignore_alts;
 	}
@@ -1688,7 +1693,7 @@ static int handle_group_alt(struct objtool_file *file,
 		last_new_insn = insn;
 
 		insn->ignore = orig_insn->ignore_alts;
-		insn->func = orig_insn->func;
+		insn->sym = orig_insn->sym;
 		insn->alt_group = new_alt_group;
 
 		/*
@@ -1882,7 +1887,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	struct reloc *reloc = table;
 	struct instruction *dest_insn;
 	struct alternative *alt;
-	struct symbol *pfunc = insn->func->pfunc;
+	struct symbol *pfunc = insn_func(insn)->pfunc;
 	unsigned int prev_offset = 0;
 
 	/*
@@ -1909,7 +1914,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the destination is in the same function: */
-		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
+		if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
@@ -1949,7 +1954,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 	 * it.
 	 */
 	for (;
-	     insn && insn->func && insn->func->pfunc == func;
+	     insn && insn_func(insn) && insn_func(insn)->pfunc == func;
 	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
@@ -1966,7 +1971,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
 		if (!table_reloc)
 			continue;
 		dest_insn = find_insn(file, table_reloc->sym->sec, table_reloc->addend);
-		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc != func)
+		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
 		return table_reloc;
@@ -2415,6 +2420,13 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_{jump_call}_destination.
+	 */
+	ret = classify_symbols(file);
+	if (ret)
+		return ret;
+
 	ret = decode_instructions(file);
 	if (ret)
 		return ret;
@@ -2434,13 +2446,6 @@ static int decode_sections(struct objtool_file *file)
 		return ret;
 
 	/*
-	 * Must be before add_{jump_call}_destination.
-	 */
-	ret = classify_symbols(file);
-	if (ret)
-		return ret;
-
-	/*
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
@@ -2648,7 +2653,7 @@ static int update_cfi_state(struct instruction *insn,
 
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
-		if (insn->func) {
+		if (insn_func(insn)) {
 			WARN_FUNC("undefined stack state", insn->sec, insn->offset);
 			return -1;
 		}
@@ -2994,7 +2999,7 @@ static int update_cfi_state(struct instruction *insn,
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
-		if (opts.stackval && insn->func && op->src.reg == CFI_BP &&
+		if (opts.stackval && insn_func(insn) && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
 			cfi->bp_scratch = true;
 		break;
@@ -3390,13 +3395,13 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
-		if (func && insn->func && func != insn->func->pfunc) {
+		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6))
 				return 0;
 
 			WARN("%s() falls through to next function %s()",
-			     func->name, insn->func->name);
+			     func->name, insn_func(insn)->name);
 			return 1;
 		}
 
@@ -3638,7 +3643,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited && !insn->ignore) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn_func(insn), insn, state);
 			if (ret && opts.backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -3861,7 +3866,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (opts.link && !insn->func) {
+	if (opts.link && !insn_func(insn)) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3885,10 +3890,10 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 			/*
 			 * If this hole jumps to a .cold function, mark it ignore too.
 			 */
-			if (insn->jump_dest && insn->jump_dest->func &&
-			    strstr(insn->jump_dest->func->name, ".cold")) {
+			if (insn->jump_dest && insn_func(insn->jump_dest) &&
+			    strstr(insn_func(insn->jump_dest)->name, ".cold")) {
 				struct instruction *dest = insn->jump_dest;
-				func_for_each_insn(file, dest->func, dest)
+				func_for_each_insn(file, insn_func(dest), dest)
 					dest->ignore = true;
 			}
 		}
@@ -3896,10 +3901,10 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 		return false;
 	}
 
-	if (!insn->func)
+	if (!insn_func(insn))
 		return false;
 
-	if (insn->func->static_call_tramp)
+	if (insn_func(insn)->static_call_tramp)
 		return true;
 
 	/*
@@ -3930,7 +3935,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 
 		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
 			if (insn->jump_dest &&
-			    insn->jump_dest->func == insn->func) {
+			    insn_func(insn->jump_dest) == insn_func(insn)) {
 				insn = insn->jump_dest;
 				continue;
 			}
@@ -3938,7 +3943,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 			break;
 		}
 
-		if (insn->offset + insn->len >= insn->func->offset + insn->func->len)
+		if (insn->offset + insn->len >= insn_func(insn)->offset + insn_func(insn)->len)
 			break;
 
 		insn = list_next_entry(insn, list);
@@ -3967,7 +3972,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 
 	state->uaccess = sym->uaccess_safe;
 
-	ret = validate_branch(file, insn->func, insn, *state);
+	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret && opts.backtrace)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
@@ -4104,7 +4109,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 		}
 
-		if (dest->func && dest->func == insn->func) {
+		if (insn_func(dest) && insn_func(dest) == insn_func(insn)) {
 			/*
 			 * Anything from->to self is either _THIS_IP_ or
 			 * IRET-to-self.
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 036129c..acd7fae 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -67,11 +67,21 @@ struct instruction {
 	struct reloc *jump_table;
 	struct reloc *reloc;
 	struct list_head alts;
-	struct symbol *func;
+	struct symbol *sym;
 	struct list_head stack_ops;
 	struct cfi_state *cfi;
 };
 
+static inline struct symbol *insn_func(struct instruction *insn)
+{
+	struct symbol *sym = insn->sym;
+
+	if (sym && sym->type != STT_FUNC)
+		sym = NULL;
+
+	return sym;
+}
+
 #define VISITED_BRANCH		0x01
 #define VISITED_BRANCH_UACCESS	0x02
 #define VISITED_BRANCH_MASK	0x03
