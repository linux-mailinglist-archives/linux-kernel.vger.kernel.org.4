Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD2A6E262B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjDNOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjDNOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:48:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E07171F;
        Fri, 14 Apr 2023 07:47:59 -0700 (PDT)
Date:   Fri, 14 Apr 2023 14:47:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mien3/uKZggur4cBhDZ729JspXhayLZwnXEaPFqzwQ=;
        b=vkCeVepBdVKL8qmYYPQ1g0Rrr1JD24qtCDFTXhJ9wtyfjLPFA43OBYick8iuBTq3dLw1ZM
        TRONcRoIr2P+2BLzo6sfWqXzhUZdGGoH5uT2ibV7kppOA1atcjUobzPizxGPphUkB7SFKy
        p73898kbVaIkoT3vFLd22IG3/vwX69I4jD++JQqO9UphCfCdjd2SOmtK50mFkVZImd8bY+
        ubi/wSj7pp9RYKRekgyeBTYXLtxiiCrMq8n9xkXdzKRfq6SQFk0tZGwriHlo0QY3Et54N3
        7MmM9eDxvKjPZaFrKIWASuPeRhrt5vqT87Ub1YTBbG2x42ZsUGrpwhZJlrrHjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681483676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mien3/uKZggur4cBhDZ729JspXhayLZwnXEaPFqzwQ=;
        b=38enjtSxaSTymXwDBiihOeT7MB1iui+gZ919wsrLXKhPpntP9ldk2s08d52123/pdAZOls
        PcqSUwG5L271W1Bg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add WARN_INSN()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2eaa3155c90fba683d8723599f279c46025b75f3.1681325924.git.jpoimboe@kernel.org>
References: <2eaa3155c90fba683d8723599f279c46025b75f3.1681325924.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168148367573.404.5085063087006490560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     246b2c85487a7bc5f6a09098e18a96506b1b55df
Gitweb:        https://git.kernel.org/tip/246b2c85487a7bc5f6a09098e18a96506b1b55df
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 12:03:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 16:08:28 +02:00

objtool: Add WARN_INSN()

It's easier to use and also gives easy access to the instruction's
containing function, which is useful for printing that function's
symbol.  It will also be useful in the future for rate-limiting and
disassembly of warned functions.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/2eaa3155c90fba683d8723599f279c46025b75f3.1681325924.git.jpoimboe@kernel.org
---
 tools/objtool/check.c                | 171 +++++++++-----------------
 tools/objtool/include/objtool/warn.h |   5 +-
 tools/objtool/orc_gen.c              |   9 +-
 3 files changed, 70 insertions(+), 115 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4c8ef81..7d1a42b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1446,7 +1446,7 @@ static void annotate_call_site(struct objtool_file *file,
 
 	if (opts.mcount && sym->fentry) {
 		if (sibling)
-			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
+			WARN_INSN(insn, "tail call to __fentry__ !?!?");
 		if (opts.mnop) {
 			if (reloc) {
 				reloc->type = R_NONE;
@@ -1648,9 +1648,8 @@ static int add_jump_destinations(struct objtool_file *file)
 				continue;
 			}
 
-			WARN_FUNC("can't find jump dest instruction at %s+0x%lx",
-				  insn->sec, insn->offset, dest_sec->name,
-				  dest_off);
+			WARN_INSN(insn, "can't find jump dest instruction at %s+0x%lx",
+				  dest_sec->name, dest_off);
 			return -1;
 		}
 
@@ -1733,13 +1732,12 @@ static int add_call_destinations(struct objtool_file *file)
 				continue;
 
 			if (!insn_call_dest(insn)) {
-				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
+				WARN_INSN(insn, "unannotated intra-function call");
 				return -1;
 			}
 
 			if (insn_func(insn) && insn_call_dest(insn)->type != STT_FUNC) {
-				WARN_FUNC("unsupported call to non-function",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "unsupported call to non-function");
 				return -1;
 			}
 
@@ -1747,10 +1745,8 @@ static int add_call_destinations(struct objtool_file *file)
 			dest_off = arch_dest_reloc_offset(reloc->addend);
 			dest = find_call_destination(reloc->sym->sec, dest_off);
 			if (!dest) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
-					  insn->sec, insn->offset,
-					  reloc->sym->sec->name,
-					  dest_off);
+				WARN_INSN(insn, "can't find call dest symbol at %s+0x%lx",
+					  reloc->sym->sec->name, dest_off);
 				return -1;
 			}
 
@@ -1810,8 +1806,7 @@ static int handle_group_alt(struct objtool_file *file,
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset != special_alt->orig_len) {
-			WARN_FUNC("weirdly overlapping alternative! %ld != %d",
-				  orig_insn->sec, orig_insn->offset,
+			WARN_INSN(orig_insn, "weirdly overlapping alternative! %ld != %d",
 				  orig_alt_group->last_insn->offset +
 				  orig_alt_group->last_insn->len -
 				  orig_alt_group->first_insn->offset,
@@ -1880,8 +1875,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (alt_reloc && arch_pc_relative_reloc(alt_reloc) &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
-			WARN_FUNC("unsupported relocation in alternatives section",
-				  insn->sec, insn->offset);
+			WARN_INSN(insn, "unsupported relocation in alternatives section");
 			return -1;
 		}
 
@@ -1895,8 +1889,7 @@ static int handle_group_alt(struct objtool_file *file,
 		if (dest_off == special_alt->new_off + special_alt->new_len) {
 			insn->jump_dest = next_insn_same_sec(file, orig_alt_group->last_insn);
 			if (!insn->jump_dest) {
-				WARN_FUNC("can't find alternative jump destination",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "can't find alternative jump destination");
 				return -1;
 			}
 		}
@@ -1930,8 +1923,7 @@ static int handle_jump_alt(struct objtool_file *file,
 	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL &&
 	    orig_insn->type != INSN_NOP) {
 
-		WARN_FUNC("unsupported instruction at jump label",
-			  orig_insn->sec, orig_insn->offset);
+		WARN_INSN(orig_insn, "unsupported instruction at jump label");
 		return -1;
 	}
 
@@ -2010,8 +2002,7 @@ static int add_special_section_alts(struct objtool_file *file)
 
 		if (special_alt->group) {
 			if (!special_alt->orig_len) {
-				WARN_FUNC("empty alternative entry",
-					  orig_insn->sec, orig_insn->offset);
+				WARN_INSN(orig_insn, "empty alternative entry");
 				continue;
 			}
 
@@ -2102,8 +2093,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	}
 
 	if (!prev_offset) {
-		WARN_FUNC("can't find switch jump table",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "can't find switch jump table");
 		return -1;
 	}
 
@@ -2307,8 +2297,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 			if (sym && sym->bind == STB_GLOBAL) {
 				if (opts.ibt && insn->type != INSN_ENDBR && !insn->noendbr) {
-					WARN_FUNC("UNWIND_HINT_IRET_REGS without ENDBR",
-						  insn->sec, insn->offset);
+					WARN_INSN(insn, "UNWIND_HINT_IRET_REGS without ENDBR");
 				}
 			}
 		}
@@ -2322,8 +2311,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			cfi = *(insn->cfi);
 
 		if (arch_decode_hint_reg(hint->sp_reg, &cfi.cfa.base)) {
-			WARN_FUNC("unsupported unwind_hint sp base reg %d",
-				  insn->sec, insn->offset, hint->sp_reg);
+			WARN_INSN(insn, "unsupported unwind_hint sp base reg %d", hint->sp_reg);
 			return -1;
 		}
 
@@ -2386,8 +2374,7 @@ static int read_retpoline_hints(struct objtool_file *file)
 		    insn->type != INSN_CALL_DYNAMIC &&
 		    insn->type != INSN_RETURN &&
 		    insn->type != INSN_NOP) {
-			WARN_FUNC("retpoline_safe hint not an indirect jump/call/ret/nop",
-				  insn->sec, insn->offset);
+			WARN_INSN(insn, "retpoline_safe hint not an indirect jump/call/ret/nop");
 			return -1;
 		}
 
@@ -2498,8 +2485,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 		}
 
 		if (insn->type != INSN_CALL) {
-			WARN_FUNC("intra_function_call not a direct call",
-				  insn->sec, insn->offset);
+			WARN_INSN(insn, "intra_function_call not a direct call");
 			return -1;
 		}
 
@@ -2513,8 +2499,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 		dest_off = arch_jump_destination(insn);
 		insn->jump_dest = find_insn(file, insn->sec, dest_off);
 		if (!insn->jump_dest) {
-			WARN_FUNC("can't find call dest at %s+0x%lx",
-				  insn->sec, insn->offset,
+			WARN_INSN(insn, "can't find call dest at %s+0x%lx",
 				  insn->sec->name, dest_off);
 			return -1;
 		}
@@ -2855,7 +2840,7 @@ static int update_cfi_state(struct instruction *insn,
 	/* stack operations don't make sense with an undefined CFA */
 	if (cfa->base == CFI_UNDEFINED) {
 		if (insn_func(insn)) {
-			WARN_FUNC("undefined stack state", insn->sec, insn->offset);
+			WARN_INSN(insn, "undefined stack state");
 			return -1;
 		}
 		return 0;
@@ -3038,8 +3023,7 @@ static int update_cfi_state(struct instruction *insn,
 			}
 
 			if (op->dest.reg == cfi->cfa.base && !(next_insn && next_insn->hint)) {
-				WARN_FUNC("unsupported stack register modification",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "unsupported stack register modification");
 				return -1;
 			}
 
@@ -3049,8 +3033,7 @@ static int update_cfi_state(struct instruction *insn,
 			if (op->dest.reg != CFI_SP ||
 			    (cfi->drap_reg != CFI_UNDEFINED && cfa->base != CFI_SP) ||
 			    (cfi->drap_reg == CFI_UNDEFINED && cfa->base != CFI_BP)) {
-				WARN_FUNC("unsupported stack pointer realignment",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "unsupported stack pointer realignment");
 				return -1;
 			}
 
@@ -3145,8 +3128,7 @@ static int update_cfi_state(struct instruction *insn,
 			break;
 
 		default:
-			WARN_FUNC("unknown stack-related instruction",
-				  insn->sec, insn->offset);
+			WARN_INSN(insn, "unknown stack-related instruction");
 			return -1;
 		}
 
@@ -3235,8 +3217,7 @@ static int update_cfi_state(struct instruction *insn,
 
 	case OP_DEST_MEM:
 		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
-			WARN_FUNC("unknown stack-related memory operation",
-				  insn->sec, insn->offset);
+			WARN_INSN(insn, "unknown stack-related memory operation");
 			return -1;
 		}
 
@@ -3248,8 +3229,7 @@ static int update_cfi_state(struct instruction *insn,
 		break;
 
 	default:
-		WARN_FUNC("unknown stack-related instruction",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "unknown stack-related instruction");
 		return -1;
 	}
 
@@ -3288,8 +3268,7 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
 			struct alt_group *orig_group = insn->alt_group->orig_group ?: insn->alt_group;
 			struct instruction *orig = orig_group->first_insn;
 			char *where = offstr(insn->sec, insn->offset);
-			WARN_FUNC("stack layout conflict in alternatives: %s",
-				  orig->sec, orig->offset, where);
+			WARN_INSN(orig, "stack layout conflict in alternatives: %s", where);
 			free(where);
 			return -1;
 		}
@@ -3316,8 +3295,7 @@ static int handle_insn_ops(struct instruction *insn,
 			if (!state->uaccess_stack) {
 				state->uaccess_stack = 1;
 			} else if (state->uaccess_stack >> 31) {
-				WARN_FUNC("PUSHF stack exhausted",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "PUSHF stack exhausted");
 				return 1;
 			}
 			state->uaccess_stack <<= 1;
@@ -3349,8 +3327,7 @@ static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 
 	if (memcmp(&cfi1->cfa, &cfi2->cfa, sizeof(cfi1->cfa))) {
 
-		WARN_FUNC("stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
-			  insn->sec, insn->offset,
+		WARN_INSN(insn, "stack state mismatch: cfa1=%d%+d cfa2=%d%+d",
 			  cfi1->cfa.base, cfi1->cfa.offset,
 			  cfi2->cfa.base, cfi2->cfa.offset);
 
@@ -3360,8 +3337,7 @@ static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 				    sizeof(struct cfi_reg)))
 				continue;
 
-			WARN_FUNC("stack state mismatch: reg1[%d]=%d%+d reg2[%d]=%d%+d",
-				  insn->sec, insn->offset,
+			WARN_INSN(insn, "stack state mismatch: reg1[%d]=%d%+d reg2[%d]=%d%+d",
 				  i, cfi1->regs[i].base, cfi1->regs[i].offset,
 				  i, cfi2->regs[i].base, cfi2->regs[i].offset);
 			break;
@@ -3369,15 +3345,14 @@ static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 
 	} else if (cfi1->type != cfi2->type) {
 
-		WARN_FUNC("stack state mismatch: type1=%d type2=%d",
-			  insn->sec, insn->offset, cfi1->type, cfi2->type);
+		WARN_INSN(insn, "stack state mismatch: type1=%d type2=%d",
+			  cfi1->type, cfi2->type);
 
 	} else if (cfi1->drap != cfi2->drap ||
 		   (cfi1->drap && cfi1->drap_reg != cfi2->drap_reg) ||
 		   (cfi1->drap && cfi1->drap_offset != cfi2->drap_offset)) {
 
-		WARN_FUNC("stack state mismatch: drap1=%d(%d,%d) drap2=%d(%d,%d)",
-			  insn->sec, insn->offset,
+		WARN_INSN(insn, "stack state mismatch: drap1=%d(%d,%d) drap2=%d(%d,%d)",
 			  cfi1->drap, cfi1->drap_reg, cfi1->drap_offset,
 			  cfi2->drap, cfi2->drap_reg, cfi2->drap_offset);
 
@@ -3485,20 +3460,17 @@ static int validate_call(struct objtool_file *file,
 {
 	if (state->noinstr && state->instr <= 0 &&
 	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
-		WARN_FUNC("call to %s() leaves .noinstr.text section",
-				insn->sec, insn->offset, call_dest_name(insn));
+		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
 		return 1;
 	}
 
 	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
-		WARN_FUNC("call to %s() with UACCESS enabled",
-				insn->sec, insn->offset, call_dest_name(insn));
+		WARN_INSN(insn, "call to %s() with UACCESS enabled", call_dest_name(insn));
 		return 1;
 	}
 
 	if (state->df) {
-		WARN_FUNC("call to %s() with DF set",
-				insn->sec, insn->offset, call_dest_name(insn));
+		WARN_INSN(insn, "call to %s() with DF set", call_dest_name(insn));
 		return 1;
 	}
 
@@ -3510,8 +3482,7 @@ static int validate_sibling_call(struct objtool_file *file,
 				 struct insn_state *state)
 {
 	if (insn_func(insn) && has_modified_stack_frame(insn, state)) {
-		WARN_FUNC("sibling call from callable instruction with modified stack frame",
-				insn->sec, insn->offset);
+		WARN_INSN(insn, "sibling call from callable instruction with modified stack frame");
 		return 1;
 	}
 
@@ -3521,38 +3492,32 @@ static int validate_sibling_call(struct objtool_file *file,
 static int validate_return(struct symbol *func, struct instruction *insn, struct insn_state *state)
 {
 	if (state->noinstr && state->instr > 0) {
-		WARN_FUNC("return with instrumentation enabled",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "return with instrumentation enabled");
 		return 1;
 	}
 
 	if (state->uaccess && !func_uaccess_safe(func)) {
-		WARN_FUNC("return with UACCESS enabled",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "return with UACCESS enabled");
 		return 1;
 	}
 
 	if (!state->uaccess && func_uaccess_safe(func)) {
-		WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "return with UACCESS disabled from a UACCESS-safe function");
 		return 1;
 	}
 
 	if (state->df) {
-		WARN_FUNC("return with DF set",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "return with DF set");
 		return 1;
 	}
 
 	if (func && has_modified_stack_frame(insn, state)) {
-		WARN_FUNC("return with modified stack frame",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "return with modified stack frame");
 		return 1;
 	}
 
 	if (state->cfi.bp_scratch) {
-		WARN_FUNC("BP used as a scratch register",
-			  insn->sec, insn->offset);
+		WARN_INSN(insn, "BP used as a scratch register");
 		return 1;
 	}
 
@@ -3624,8 +3589,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		}
 
 		if (func && insn->ignore) {
-			WARN_FUNC("BUG: why am I validating an ignored function?",
-				  sec, insn->offset);
+			WARN_INSN(insn, "BUG: why am I validating an ignored function?");
 			return 1;
 		}
 
@@ -3658,14 +3622,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				}
 
 				if (!save_insn) {
-					WARN_FUNC("no corresponding CFI save for CFI restore",
-						  sec, insn->offset);
+					WARN_INSN(insn, "no corresponding CFI save for CFI restore");
 					return 1;
 				}
 
 				if (!save_insn->visited) {
-					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
-						  sec, insn->offset);
+					WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/restore combo");
 					return 1;
 				}
 
@@ -3725,8 +3687,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			if (opts.stackval && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
-				WARN_FUNC("call without frame pointer save/setup",
-					  sec, insn->offset);
+				WARN_INSN(insn, "call without frame pointer save/setup");
 				return 1;
 			}
 
@@ -3772,15 +3733,14 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_CONTEXT_SWITCH:
 			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_FUNC("unsupported instruction in callable function",
-					  sec, insn->offset);
+				WARN_INSN(insn, "unsupported instruction in callable function");
 				return 1;
 			}
 			return 0;
 
 		case INSN_STAC:
 			if (state.uaccess) {
-				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
+				WARN_INSN(insn, "recursive UACCESS enable");
 				return 1;
 			}
 
@@ -3789,12 +3749,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_CLAC:
 			if (!state.uaccess && func) {
-				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
+				WARN_INSN(insn, "redundant UACCESS disable");
 				return 1;
 			}
 
 			if (func_uaccess_safe(func) && !state.uaccess_stack) {
-				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
+				WARN_INSN(insn, "UACCESS-safe disables UACCESS");
 				return 1;
 			}
 
@@ -3803,7 +3763,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_STD:
 			if (state.df) {
-				WARN_FUNC("recursive STD", sec, insn->offset);
+				WARN_INSN(insn, "recursive STD");
 				return 1;
 			}
 
@@ -3812,7 +3772,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_CLD:
 			if (!state.df && func) {
-				WARN_FUNC("redundant CLD", sec, insn->offset);
+				WARN_INSN(insn, "redundant CLD");
 				return 1;
 			}
 
@@ -3920,15 +3880,14 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 		case INSN_CALL_DYNAMIC:
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
-			WARN_FUNC("early indirect call", insn->sec, insn->offset);
+			WARN_INSN(insn, "early indirect call");
 			return 1;
 
 		case INSN_JUMP_UNCONDITIONAL:
 		case INSN_JUMP_CONDITIONAL:
 			if (!is_sibling_call(insn)) {
 				if (!insn->jump_dest) {
-					WARN_FUNC("unresolved jump target after linking?!?",
-						  insn->sec, insn->offset);
+					WARN_INSN(insn, "unresolved jump target after linking?!?");
 					return -1;
 				}
 				ret = validate_unret(file, insn->jump_dest);
@@ -3969,7 +3928,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			return 0;
 
 		case INSN_RETURN:
-			WARN_FUNC("RET before UNTRAIN", insn->sec, insn->offset);
+			WARN_INSN(insn, "RET before UNTRAIN");
 			return 1;
 
 		case INSN_NOP:
@@ -3982,7 +3941,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 		}
 
 		if (!next) {
-			WARN_FUNC("teh end!", insn->sec, insn->offset);
+			WARN_INSN(insn, "teh end!");
 			return -1;
 		}
 		insn = next;
@@ -4006,7 +3965,7 @@ static int validate_unrets(struct objtool_file *file)
 
 		ret = validate_unret(file, insn);
 		if (ret < 0) {
-			WARN_FUNC("Failed UNRET validation", insn->sec, insn->offset);
+			WARN_INSN(insn, "Failed UNRET validation");
 			return ret;
 		}
 		warnings += ret;
@@ -4034,13 +3993,11 @@ static int validate_retpoline(struct objtool_file *file)
 
 		if (insn->type == INSN_RETURN) {
 			if (opts.rethunk) {
-				WARN_FUNC("'naked' return found in RETHUNK build",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "'naked' return found in RETHUNK build");
 			} else
 				continue;
 		} else {
-			WARN_FUNC("indirect %s found in RETPOLINE build",
-				  insn->sec, insn->offset,
+			WARN_INSN(insn, "indirect %s found in RETPOLINE build",
 				  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
 		}
 
@@ -4419,9 +4376,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 		if (noendbr_range(file, dest))
 			continue;
 
-		WARN_FUNC("relocation to !ENDBR: %s",
-			  insn->sec, insn->offset,
-			  offstr(dest->sec, dest->offset));
+		WARN_INSN(insn, "relocation to !ENDBR: %s", offstr(dest->sec, dest->offset));
 
 		warnings++;
 	}
@@ -4523,16 +4478,14 @@ static int validate_sls(struct objtool_file *file)
 		switch (insn->type) {
 		case INSN_RETURN:
 			if (!next_insn || next_insn->type != INSN_TRAP) {
-				WARN_FUNC("missing int3 after ret",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "missing int3 after ret");
 				warnings++;
 			}
 
 			break;
 		case INSN_JUMP_DYNAMIC:
 			if (!next_insn || next_insn->type != INSN_TRAP) {
-				WARN_FUNC("missing int3 after indirect jump",
-					  insn->sec, insn->offset);
+				WARN_INSN(insn, "missing int3 after indirect jump");
 				warnings++;
 			}
 			break;
@@ -4555,7 +4508,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		if (insn->visited || ignore_unreachable_insn(file, insn))
 			continue;
 
-		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
+		WARN_INSN(insn, "unreachable instruction");
 		return 1;
 	}
 
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index a3e79ae..b1c920d 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -53,6 +53,11 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	free(_str);					\
 })
 
+#define WARN_INSN(insn, format, ...)					\
+({									\
+	WARN_FUNC(format, insn->sec, insn->offset,  ##__VA_ARGS__);	\
+})
+
 #define BT_FUNC(format, insn, ...)			\
 ({							\
 	struct instruction *_insn = (insn);		\
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index b327f9c..48efd1e 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -47,8 +47,7 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 		orc->type = ORC_TYPE_REGS_PARTIAL;
 		break;
 	default:
-		WARN_FUNC("unknown unwind hint type %d",
-			  insn->sec, insn->offset, cfi->type);
+		WARN_INSN(insn, "unknown unwind hint type %d", cfi->type);
 		return -1;
 	}
 
@@ -80,8 +79,7 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 		orc->sp_reg = ORC_REG_DX;
 		break;
 	default:
-		WARN_FUNC("unknown CFA base reg %d",
-			  insn->sec, insn->offset, cfi->cfa.base);
+		WARN_INSN(insn, "unknown CFA base reg %d", cfi->cfa.base);
 		return -1;
 	}
 
@@ -96,8 +94,7 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 		orc->bp_reg = ORC_REG_BP;
 		break;
 	default:
-		WARN_FUNC("unknown BP base reg %d",
-			  insn->sec, insn->offset, bp->base);
+		WARN_INSN(insn, "unknown BP base reg %d", bp->base);
 		return -1;
 	}
 
