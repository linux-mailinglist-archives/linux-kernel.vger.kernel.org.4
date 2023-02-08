Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A468F45C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBHRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:24:06 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8AC2BEC5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ZM2H9NcBYzk3p+h+REZIrOr8Wdv2eWikVDS+/wEJ9YQ=; b=QPSoc0VOKEEOeRBS1h3oyzg4aF
        B0ACXT394ce1mbXzw6peCznewOKbFYH8iFtM0xyr1jgjnNFirxwwQjEfBFpYKP7dah5m2Aipp/gPU
        FX/yyS0uMQ2PJIQTdaNXI0zUa+/jNpbwk2z6sLH+OVwg+mlCzezFdejh5cGJd5B+LeL2RnyezLQ0J
        KLgZNifgVqc+0VDdyvOJNQQ0ZsJZKE0kMadt01JthBlz/YcR1jn5/69iVm0muATWTdaJ9GTojaJxl
        kCbDeF7jzLw0D0oMFkLuVcoUtxIbOeDyWVOUmyA9yFyDp1Vd33XAgC31FyePRCYe3v+SqPy8skxwx
        2ve9GtRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoA4-007Vve-0A;
        Wed, 08 Feb 2023 17:23:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 199C1300446;
        Wed,  8 Feb 2023 18:23:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 026E220A3C1B4; Wed,  8 Feb 2023 18:23:49 +0100 (CET)
Message-ID: <20230208172245.291087549@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Feb 2023 18:17:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 01/10] objtool: Change arch_decode_instruction() signature
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

In preparation to changing struct instruction around a bit, avoid
passing it's members by pointer and instead pass the whole thing.

A cleanup in it's own right too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/powerpc/decode.c  |   22 +++----
 tools/objtool/arch/x86/decode.c      |  105 +++++++++++++++++------------------
 tools/objtool/check.c                |    4 -
 tools/objtool/include/objtool/arch.h |    4 -
 4 files changed, 64 insertions(+), 71 deletions(-)

--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -41,38 +41,36 @@ const char *arch_ret_insn(int len)
 
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list)
+			    struct instruction *insn)
 {
 	unsigned int opcode;
 	enum insn_type typ;
 	unsigned long imm;
-	u32 insn;
+	u32 ins;
 
-	insn = bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
-	opcode = insn >> 26;
+	ins = bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
+	opcode = ins >> 26;
 	typ = INSN_OTHER;
 	imm = 0;
 
 	switch (opcode) {
 	case 18: /* b[l][a] */
-		if ((insn & 3) == 1) /* bl */
+		if ((ins & 3) == 1) /* bl */
 			typ = INSN_CALL;
 
-		imm = insn & 0x3fffffc;
+		imm = ins & 0x3fffffc;
 		if (imm & 0x2000000)
 			imm -= 0x4000000;
 		break;
 	}
 
 	if (opcode == 1)
-		*len = 8;
+		insn->len = 8;
 	else
-		*len = 4;
+		insn->len = 4;
 
-	*type = typ;
-	*immediate = imm;
+	insn->type = typ;
+	insn->immediate = imm;
 
 	return 0;
 }
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -146,12 +146,11 @@ static bool has_notrack_prefix(struct in
 
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list)
+			    struct instruction *insn)
 {
+	struct list_head *ops_list = &insn->stack_ops;
 	const struct elf *elf = file->elf;
-	struct insn insn;
+	struct insn ins;
 	int x86_64, ret;
 	unsigned char op1, op2, op3, prefix,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
@@ -165,42 +164,42 @@ int arch_decode_instruction(struct objto
 	if (x86_64 == -1)
 		return -1;
 
-	ret = insn_decode(&insn, sec->data->d_buf + offset, maxlen,
+	ret = insn_decode(&ins, sec->data->d_buf + offset, maxlen,
 			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 	if (ret < 0) {
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
 
-	*len = insn.length;
-	*type = INSN_OTHER;
+	insn->len = ins.length;
+	insn->type = INSN_OTHER;
 
-	if (insn.vex_prefix.nbytes)
+	if (ins.vex_prefix.nbytes)
 		return 0;
 
-	prefix = insn.prefixes.bytes[0];
+	prefix = ins.prefixes.bytes[0];
 
-	op1 = insn.opcode.bytes[0];
-	op2 = insn.opcode.bytes[1];
-	op3 = insn.opcode.bytes[2];
+	op1 = ins.opcode.bytes[0];
+	op2 = ins.opcode.bytes[1];
+	op3 = ins.opcode.bytes[2];
 
-	if (insn.rex_prefix.nbytes) {
-		rex = insn.rex_prefix.bytes[0];
+	if (ins.rex_prefix.nbytes) {
+		rex = ins.rex_prefix.bytes[0];
 		rex_w = X86_REX_W(rex) >> 3;
 		rex_r = X86_REX_R(rex) >> 2;
 		rex_x = X86_REX_X(rex) >> 1;
 		rex_b = X86_REX_B(rex);
 	}
 
-	if (insn.modrm.nbytes) {
-		modrm = insn.modrm.bytes[0];
+	if (ins.modrm.nbytes) {
+		modrm = ins.modrm.bytes[0];
 		modrm_mod = X86_MODRM_MOD(modrm);
 		modrm_reg = X86_MODRM_REG(modrm) + 8*rex_r;
 		modrm_rm  = X86_MODRM_RM(modrm)  + 8*rex_b;
 	}
 
-	if (insn.sib.nbytes) {
-		sib = insn.sib.bytes[0];
+	if (ins.sib.nbytes) {
+		sib = ins.sib.bytes[0];
 		/* sib_scale = X86_SIB_SCALE(sib); */
 		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
 		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
@@ -254,7 +253,7 @@ int arch_decode_instruction(struct objto
 		break;
 
 	case 0x70 ... 0x7f:
-		*type = INSN_JUMP_CONDITIONAL;
+		insn->type = INSN_JUMP_CONDITIONAL;
 		break;
 
 	case 0x80 ... 0x83:
@@ -278,7 +277,7 @@ int arch_decode_instruction(struct objto
 		if (!rm_is_reg(CFI_SP))
 			break;
 
-		imm = insn.immediate.value;
+		imm = ins.immediate.value;
 		if (op1 & 2) { /* sign extend */
 			if (op1 & 1) { /* imm32 */
 				imm <<= 32;
@@ -309,7 +308,7 @@ int arch_decode_instruction(struct objto
 			ADD_OP(op) {
 				op->src.type = OP_SRC_AND;
 				op->src.reg = CFI_SP;
-				op->src.offset = insn.immediate.value;
+				op->src.offset = ins.immediate.value;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
@@ -356,7 +355,7 @@ int arch_decode_instruction(struct objto
 					op->src.reg = CFI_SP;
 					op->dest.type = OP_DEST_REG_INDIRECT;
 					op->dest.reg = modrm_rm;
-					op->dest.offset = insn.displacement.value;
+					op->dest.offset = ins.displacement.value;
 				}
 				break;
 			}
@@ -389,7 +388,7 @@ int arch_decode_instruction(struct objto
 				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG_INDIRECT;
 				op->dest.reg = CFI_BP;
-				op->dest.offset = insn.displacement.value;
+				op->dest.offset = ins.displacement.value;
 			}
 			break;
 		}
@@ -402,7 +401,7 @@ int arch_decode_instruction(struct objto
 				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG_INDIRECT;
 				op->dest.reg = CFI_SP;
-				op->dest.offset = insn.displacement.value;
+				op->dest.offset = ins.displacement.value;
 			}
 			break;
 		}
@@ -419,7 +418,7 @@ int arch_decode_instruction(struct objto
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG_INDIRECT;
 				op->src.reg = CFI_BP;
-				op->src.offset = insn.displacement.value;
+				op->src.offset = ins.displacement.value;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = modrm_reg;
 			}
@@ -432,7 +431,7 @@ int arch_decode_instruction(struct objto
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG_INDIRECT;
 				op->src.reg = CFI_SP;
-				op->src.offset = insn.displacement.value;
+				op->src.offset = ins.displacement.value;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = modrm_reg;
 			}
@@ -464,7 +463,7 @@ int arch_decode_instruction(struct objto
 
 		/* lea disp(%src), %dst */
 		ADD_OP(op) {
-			op->src.offset = insn.displacement.value;
+			op->src.offset = ins.displacement.value;
 			if (!op->src.offset) {
 				/* lea (%src), %dst */
 				op->src.type = OP_SRC_REG;
@@ -487,7 +486,7 @@ int arch_decode_instruction(struct objto
 		break;
 
 	case 0x90:
-		*type = INSN_NOP;
+		insn->type = INSN_NOP;
 		break;
 
 	case 0x9c:
@@ -511,39 +510,39 @@ int arch_decode_instruction(struct objto
 		if (op2 == 0x01) {
 
 			if (modrm == 0xca)
-				*type = INSN_CLAC;
+				insn->type = INSN_CLAC;
 			else if (modrm == 0xcb)
-				*type = INSN_STAC;
+				insn->type = INSN_STAC;
 
 		} else if (op2 >= 0x80 && op2 <= 0x8f) {
 
-			*type = INSN_JUMP_CONDITIONAL;
+			insn->type = INSN_JUMP_CONDITIONAL;
 
 		} else if (op2 == 0x05 || op2 == 0x07 || op2 == 0x34 ||
 			   op2 == 0x35) {
 
 			/* sysenter, sysret */
-			*type = INSN_CONTEXT_SWITCH;
+			insn->type = INSN_CONTEXT_SWITCH;
 
 		} else if (op2 == 0x0b || op2 == 0xb9) {
 
 			/* ud2 */
-			*type = INSN_BUG;
+			insn->type = INSN_BUG;
 
 		} else if (op2 == 0x0d || op2 == 0x1f) {
 
 			/* nopl/nopw */
-			*type = INSN_NOP;
+			insn->type = INSN_NOP;
 
 		} else if (op2 == 0x1e) {
 
 			if (prefix == 0xf3 && (modrm == 0xfa || modrm == 0xfb))
-				*type = INSN_ENDBR;
+				insn->type = INSN_ENDBR;
 
 
 		} else if (op2 == 0x38 && op3 == 0xf8) {
-			if (insn.prefixes.nbytes == 1 &&
-			    insn.prefixes.bytes[0] == 0xf2) {
+			if (ins.prefixes.nbytes == 1 &&
+			    ins.prefixes.bytes[0] == 0xf2) {
 				/* ENQCMD cannot be used in the kernel. */
 				WARN("ENQCMD instruction at %s:%lx", sec->name,
 				     offset);
@@ -591,29 +590,29 @@ int arch_decode_instruction(struct objto
 
 	case 0xcc:
 		/* int3 */
-		*type = INSN_TRAP;
+		insn->type = INSN_TRAP;
 		break;
 
 	case 0xe3:
 		/* jecxz/jrcxz */
-		*type = INSN_JUMP_CONDITIONAL;
+		insn->type = INSN_JUMP_CONDITIONAL;
 		break;
 
 	case 0xe9:
 	case 0xeb:
-		*type = INSN_JUMP_UNCONDITIONAL;
+		insn->type = INSN_JUMP_UNCONDITIONAL;
 		break;
 
 	case 0xc2:
 	case 0xc3:
-		*type = INSN_RETURN;
+		insn->type = INSN_RETURN;
 		break;
 
 	case 0xc7: /* mov imm, r/m */
 		if (!opts.noinstr)
 			break;
 
-		if (insn.length == 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
+		if (ins.length == 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
 			struct reloc *immr, *disp;
 			struct symbol *func;
 			int idx;
@@ -661,17 +660,17 @@ int arch_decode_instruction(struct objto
 
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
-		*type = INSN_CONTEXT_SWITCH;
+		insn->type = INSN_CONTEXT_SWITCH;
 		break;
 
 	case 0xe0: /* loopne */
 	case 0xe1: /* loope */
 	case 0xe2: /* loop */
-		*type = INSN_JUMP_CONDITIONAL;
+		insn->type = INSN_JUMP_CONDITIONAL;
 		break;
 
 	case 0xe8:
-		*type = INSN_CALL;
+		insn->type = INSN_CALL;
 		/*
 		 * For the impact on the stack, a CALL behaves like
 		 * a PUSH of an immediate value (the return address).
@@ -683,30 +682,30 @@ int arch_decode_instruction(struct objto
 		break;
 
 	case 0xfc:
-		*type = INSN_CLD;
+		insn->type = INSN_CLD;
 		break;
 
 	case 0xfd:
-		*type = INSN_STD;
+		insn->type = INSN_STD;
 		break;
 
 	case 0xff:
 		if (modrm_reg == 2 || modrm_reg == 3) {
 
-			*type = INSN_CALL_DYNAMIC;
-			if (has_notrack_prefix(&insn))
+			insn->type = INSN_CALL_DYNAMIC;
+			if (has_notrack_prefix(&ins))
 				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
 
 		} else if (modrm_reg == 4) {
 
-			*type = INSN_JUMP_DYNAMIC;
-			if (has_notrack_prefix(&insn))
+			insn->type = INSN_JUMP_DYNAMIC;
+			if (has_notrack_prefix(&ins))
 				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
 
 		} else if (modrm_reg == 5) {
 
 			/* jmpf */
-			*type = INSN_CONTEXT_SWITCH;
+			insn->type = INSN_CONTEXT_SWITCH;
 
 		} else if (modrm_reg == 6) {
 
@@ -723,7 +722,7 @@ int arch_decode_instruction(struct objto
 		break;
 	}
 
-	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
+	insn->immediate = ins.immediate.nbytes ? ins.immediate.value : 0;
 
 	return 0;
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -404,9 +404,7 @@ static int decode_instructions(struct ob
 
 			ret = arch_decode_instruction(file, sec, offset,
 						      sec->sh.sh_size - offset,
-						      &insn->len, &insn->type,
-						      &insn->immediate,
-						      &insn->stack_ops);
+						      insn);
 			if (ret)
 				goto err;
 
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -75,9 +75,7 @@ void arch_initial_func_cfi_state(struct
 
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list);
+			    struct instruction *insn);
 
 bool arch_callee_saved_reg(unsigned char reg);
 


