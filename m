Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28DA5E7D43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiIWOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIWOgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:36:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF8C132FF9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g/7Bmnfde+ddRiCc6JuDwzfNvQR77gp+WakkcKIDIw0=; b=AWj0FhH2XvScMJT8xwBXLdEP0G
        rP6LHsylLNiWHSj8zyyGN5RZfv6m3ey924X1enS6XXiyI2VNAWTNz9+aZUpB9UMS/khWrQKGpbeSJ
        lMoKwp5577tdLu1keSjPE6NFxXgFYwMcxbcryuKFp3I2xqJvMyNn31TchjAO0hCCy+tOYIhnTu1Cb
        r2VAnkjIw5rSBPxqI5e2VbbfXRdZ/IM/ht8NnLfWyxFdDyCt3I11AtQh2wkqvyumGTkx8SVwTZLZX
        EwlHziuzuFf2qzZEQQXRhCBDU1pjAqbaf7LGEax9H6PEa7YPjpLgbmsmlOE+65HLw7rv7GCl2L4Kl
        h5hryprQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1objls-00FEa0-5x; Fri, 23 Sep 2022 14:35:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E784D3002F1;
        Fri, 23 Sep 2022 16:35:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEC4C2BC4508F; Fri, 23 Sep 2022 16:35:13 +0200 (CEST)
Date:   Fri, 23 Sep 2022 16:35:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 32/59] objtool: Allow STT_NOTYPE -> STT_FUNC+0
 tail-calls
Message-ID: <Yy3EIV9/qa6KsNu/@hirez.programming.kicks-ass.net>
References: <20220915111039.092790446@infradead.org>
 <20220915111146.224130589@infradead.org>
 <20220922052750.wux3iykp2pfzi75k@desk>
 <Yyw5JqLtiXcqid3K@hirez.programming.kicks-ass.net>
 <Yyw9Pvo7/7YWoKds@hirez.programming.kicks-ass.net>
 <Yyxf3eIF5hY7DHUh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyxf3eIF5hY7DHUh@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:15:10PM +0200, Peter Zijlstra wrote:

> Ho-Humm.. let me find a non hacky solution.

I've ended up here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=call-depth-tracking&id=c2a8b8187418956af92d2d954ee4574f87f5e188
  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=call-depth-tracking&id=c74976b9664fb6a1856d85ce246d84db3fd2c2cd

which is arguably quite a lot of work for something relatively minor,
but I do think it leaves us in a better place.

Combo patch below..

---
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -62,12 +62,12 @@ static struct instruction *next_insn_sam
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
@@ -83,7 +83,7 @@ static struct instruction *prev_insn_sam
 {
 	struct instruction *prev = list_prev_entry(insn, list);
 
-	if (&prev->list != &file->insn_list && prev->func == insn->func)
+	if (&prev->list != &file->insn_list && insn_func(prev) == insn_func(insn))
 		return prev;
 
 	return NULL;
@@ -129,16 +129,13 @@ static bool is_jump_table_jump(struct in
 static bool is_sibling_call(struct instruction *insn)
 {
 	/*
-	 * Assume only ELF functions can make sibling calls.  This ensures
-	 * sibling call detection consistency between vmlinux.o and individual
-	 * objects.
+	 * Assume only STT_FUNC calls have jump-tables.
 	 */
-	if (!insn->func)
-		return false;
-
-	/* An indirect jump is either a sibling call or a jump to a table. */
-	if (insn->type == INSN_JUMP_DYNAMIC)
-		return !is_jump_table_jump(insn);
+	if (insn_func(insn)) {
+		/* An indirect jump is either a sibling call or a jump to a table. */
+		if (insn->type == INSN_JUMP_DYNAMIC)
+			return !is_jump_table_jump(insn);
+	}
 
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
 	return (is_static_jump(insn) && insn->call_dest);
@@ -207,7 +204,7 @@ static bool __dead_end_function(struct o
 		return false;
 
 	insn = find_insn(file, func->sec, func->offset);
-	if (!insn->func)
+	if (!insn_func(insn))
 		return false;
 
 	func_for_each_insn(file, func, insn) {
@@ -243,7 +240,7 @@ static bool __dead_end_function(struct o
 				return false;
 			}
 
-			return __dead_end_function(file, dest->func, recursion+1);
+			return __dead_end_function(file, insn_func(dest), recursion+1);
 		}
 	}
 
@@ -427,7 +424,7 @@ static int decode_instructions(struct ob
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC || func->alias != func)
+			if (func->return_thunk || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {
@@ -437,9 +434,11 @@ static int decode_instructions(struct ob
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
@@ -1372,21 +1371,18 @@ static void add_return_call(struct objto
 		list_add_tail(&insn->call_node, &file->return_thunk_list);
 }
 
-static bool same_function(struct instruction *insn1, struct instruction *insn2)
-{
-	return insn1->func->pfunc == insn2->func->pfunc;
-}
-
-static bool is_first_func_insn(struct objtool_file *file, struct instruction *insn)
+static bool is_first_func_insn(struct objtool_file *file,
+			       struct instruction *insn, struct symbol *sym)
 {
-	if (insn->offset == insn->func->offset)
+	if (insn->offset == sym->offset)
 		return true;
 
+	/* Allow direct CALL/JMP past ENDBR */
 	if (opts.ibt) {
 		struct instruction *prev = prev_insn_same_sym(file, insn);
 
 		if (prev && prev->type == INSN_ENDBR &&
-		    insn->offset == insn->func->offset + prev->len)
+		    insn->offset == sym->offset + prev->len)
 			return true;
 	}
 
@@ -1394,6 +1390,32 @@ static bool is_first_func_insn(struct ob
 }
 
 /*
+ * A sibling call is a tail-call to another symbol -- to differentiate from a
+ * recursive tail-call which is to the same symbol.
+ */
+static bool jump_is_sibling_call(struct objtool_file *file,
+				 struct instruction *from, struct instruction *to)
+{
+	struct symbol *fs = from->sym;
+	struct symbol *ts = to->sym;
+
+	/* Not a sibling call if from/to a symbol hole */
+	if (!fs || !ts)
+		return false;
+
+	/* Not a sibling call if not targeting the start of a symbol. */
+	if (!is_first_func_insn(file, to, ts))
+		return false;
+
+	/* Disallow sibling calls into STT_NOTYPE */
+	if (ts->type == STT_NOTYPE)
+		return false;
+
+	/* Must not be self to be a sibling */
+	return fs->pfunc != ts->pfunc;
+}
+
+/*
  * Find the destination instructions for all jumps.
  */
 static int add_jump_destinations(struct objtool_file *file)
@@ -1427,7 +1449,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->return_thunk) {
 			add_return_call(file, insn, true);
 			continue;
-		} else if (insn->func) {
+		} else if (insn_func(insn)) {
 			/*
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
@@ -1469,8 +1491,8 @@ static int add_jump_destinations(struct
 		/*
 		 * Cross-function jump.
 		 */
-		if (insn->func && jump_dest->func &&
-		    insn->func != jump_dest->func) {
+		if (insn_func(insn) && insn_func(jump_dest) &&
+		    insn_func(insn) != insn_func(jump_dest)) {
 
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1487,22 +1509,22 @@ static int add_jump_destinations(struct
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(insn->func->name, ".cold") &&
-			    strstr(jump_dest->func->name, ".cold")) {
-				insn->func->cfunc = jump_dest->func;
-				jump_dest->func->pfunc = insn->func;
-
-			} else if (!same_function(insn, jump_dest) &&
-				   is_first_func_insn(file, jump_dest)) {
-				/*
-				 * Internal sibling call without reloc or with
-				 * STT_SECTION reloc.
-				 */
-				add_call_dest(file, insn, jump_dest->func, true);
-				continue;
+			if (!strstr(insn_func(insn)->name, ".cold") &&
+			    strstr(insn_func(jump_dest)->name, ".cold")) {
+				insn_func(insn)->cfunc = insn_func(jump_dest);
+				insn_func(jump_dest)->pfunc = insn_func(insn);
 			}
 		}
 
+		if (jump_is_sibling_call(file, insn, jump_dest)) {
+			/*
+			 * Internal sibling call without reloc or with
+			 * STT_SECTION reloc.
+			 */
+			add_call_dest(file, insn, insn_func(jump_dest), true);
+			continue;
+		}
+
 		insn->jump_dest = jump_dest;
 	}
 
@@ -1549,7 +1571,7 @@ static int add_call_destinations(struct
 				return -1;
 			}
 
-			if (insn->func && insn->call_dest->type != STT_FUNC) {
+			if (insn_func(insn) && insn->call_dest->type != STT_FUNC) {
 				WARN_FUNC("unsupported call to non-function",
 					  insn->sec, insn->offset);
 				return -1;
@@ -1645,7 +1667,7 @@ static int handle_group_alt(struct objto
 		nop->offset = special_alt->new_off + special_alt->new_len;
 		nop->len = special_alt->orig_len - special_alt->new_len;
 		nop->type = INSN_NOP;
-		nop->func = orig_insn->func;
+		nop->sym = orig_insn->sym;
 		nop->alt_group = new_alt_group;
 		nop->ignore = orig_insn->ignore_alts;
 	}
@@ -1665,7 +1687,7 @@ static int handle_group_alt(struct objto
 		last_new_insn = insn;
 
 		insn->ignore = orig_insn->ignore_alts;
-		insn->func = orig_insn->func;
+		insn->sym = orig_insn->sym;
 		insn->alt_group = new_alt_group;
 
 		/*
@@ -1859,7 +1881,7 @@ static int add_jump_table(struct objtool
 	struct reloc *reloc = table;
 	struct instruction *dest_insn;
 	struct alternative *alt;
-	struct symbol *pfunc = insn->func->pfunc;
+	struct symbol *pfunc = insn_func(insn)->pfunc;
 	unsigned int prev_offset = 0;
 
 	/*
@@ -1886,7 +1908,7 @@ static int add_jump_table(struct objtool
 			break;
 
 		/* Make sure the destination is in the same function: */
-		if (!dest_insn->func || dest_insn->func->pfunc != pfunc)
+		if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
@@ -1926,7 +1948,7 @@ static struct reloc *find_jump_table(str
 	 * it.
 	 */
 	for (;
-	     insn && insn->func && insn->func->pfunc == func;
+	     insn && insn_func(insn) && insn_func(insn)->pfunc == func;
 	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
 
 		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
@@ -1943,7 +1965,7 @@ static struct reloc *find_jump_table(str
 		if (!table_reloc)
 			continue;
 		dest_insn = find_insn(file, table_reloc->sym->sec, table_reloc->addend);
-		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc != func)
+		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
 			continue;
 
 		return table_reloc;
@@ -2395,6 +2417,13 @@ static int decode_sections(struct objtoo
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
@@ -2414,13 +2443,6 @@ static int decode_sections(struct objtoo
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
@@ -2628,7 +2650,7 @@ static int update_cfi_state(struct instr
 
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
-		if (insn->func) {
+		if (insn_func(insn)) {
 			WARN_FUNC("undefined stack state", insn->sec, insn->offset);
 			return -1;
 		}
@@ -2974,7 +2996,7 @@ static int update_cfi_state(struct instr
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
-		if (opts.stackval && insn->func && op->src.reg == CFI_BP &&
+		if (opts.stackval && insn_func(insn) && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
 			cfi->bp_scratch = true;
 		break;
@@ -3284,7 +3306,7 @@ static int validate_sibling_call(struct
 				 struct instruction *insn,
 				 struct insn_state *state)
 {
-	if (has_modified_stack_frame(insn, state)) {
+	if (insn_func(insn) && has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -3370,9 +3392,9 @@ static int validate_branch(struct objtoo
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
-		if (func && insn->func && func != insn->func->pfunc) {
+		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
 			WARN("%s() falls through to next function %s()",
-			     func->name, insn->func->name);
+			     func->name, insn_func(insn)->name);
 			return 1;
 		}
 
@@ -3614,7 +3636,7 @@ static int validate_unwind_hints(struct
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited && !insn->ignore) {
-			ret = validate_branch(file, insn->func, insn, state);
+			ret = validate_branch(file, insn_func(insn), insn, state);
 			if (ret && opts.backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
@@ -3837,7 +3859,7 @@ static bool ignore_unreachable_insn(stru
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (opts.link && !insn->func) {
+	if (opts.link && !insn_func(insn)) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3861,10 +3883,10 @@ static bool ignore_unreachable_insn(stru
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
@@ -3872,10 +3894,10 @@ static bool ignore_unreachable_insn(stru
 		return false;
 	}
 
-	if (!insn->func)
+	if (!insn_func(insn))
 		return false;
 
-	if (insn->func->static_call_tramp)
+	if (insn_func(insn)->static_call_tramp)
 		return true;
 
 	/*
@@ -3906,7 +3928,7 @@ static bool ignore_unreachable_insn(stru
 
 		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
 			if (insn->jump_dest &&
-			    insn->jump_dest->func == insn->func) {
+			    insn_func(insn->jump_dest) == insn_func(insn)) {
 				insn = insn->jump_dest;
 				continue;
 			}
@@ -3914,7 +3936,7 @@ static bool ignore_unreachable_insn(stru
 			break;
 		}
 
-		if (insn->offset + insn->len >= insn->func->offset + insn->func->len)
+		if (insn->offset + insn->len >= insn_func(insn)->offset + insn_func(insn)->len)
 			break;
 
 		insn = list_next_entry(insn, list);
@@ -3943,7 +3965,7 @@ static int validate_symbol(struct objtoo
 
 	state->uaccess = sym->uaccess_safe;
 
-	ret = validate_branch(file, insn->func, insn, *state);
+	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret && opts.backtrace)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
@@ -4080,7 +4102,7 @@ static int validate_ibt_insn(struct objt
 			continue;
 		}
 
-		if (dest->func && dest->func == insn->func) {
+		if (insn_func(dest) && insn_func(dest) == insn_func(insn)) {
 			/*
 			 * Anything from->to self is either _THIS_IP_ or
 			 * IRET-to-self.
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
