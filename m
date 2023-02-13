Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106606943F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBMLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBMLKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E19F748;
        Mon, 13 Feb 2023 03:10:35 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676286631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tj50wqNW3HUZaZTq1Qy3Kknn9botdivUdHcWlfs+qi4=;
        b=ubryeHvhSo67Cuo1W9VfQOPiGq37d1TMrFcYFYDXy2J6CmNYMvknD+0R9setfKvXsVDGGV
        3bFAmqZ1mUiGj0GWL+ZrZY48F6wPPfRhiX8I+a4ygTxx6TxQXcSLOLEPE7N6s4mnXc/5ik
        feC4QTS9Q6d80gDPSQjyD7LjyMkAcUnkyiiurAjlnXadt5rv5evs6ehpcTSLx/YdXLw1Qb
        rb1oZu02ljkLIFIl7AS6xq3qIeoS7R/oD7fF10oqz1yZUK+bLdR+s3vIrTM/PWBNHHM1fN
        YyfmcsfOwXVzzMjZINTa4QumCRwJctbAJXx2ru3IcMo1PX8ts1Ex/n1dSQVWFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676286631;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tj50wqNW3HUZaZTq1Qy3Kknn9botdivUdHcWlfs+qi4=;
        b=7+DbTrC91vsJuk4UHzDmdBZt38olIBTAvt1raU9D85P+6XC/WlobQHerCdeVvnjOclP5HG
        GeyHyg3cqAiWH3Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Change arch_decode_instruction() signature
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.291087549@infradead.org>
References: <20230208172245.291087549@infradead.org>
MIME-Version: 1.0
Message-ID: <167628663110.4906.7441176564979695148.tip-bot2@tip-bot2>
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

Commit-ID:     a6267fd5dda7e93abeb96277c63cae595eeab6ee
Gitweb:        https://git.kernel.org/tip/a6267fd5dda7e93abeb96277c63cae595ee=
ab6ee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:17:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Feb 2023 11:26:06 +01:00

objtool: Change arch_decode_instruction() signature

In preparation to changing struct instruction around a bit, avoid
passing it's members by pointer and instead pass the whole thing.

A cleanup in it's own right too.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.291087549@infradead.org
---
 tools/objtool/arch/powerpc/decode.c  |  22 ++---
 tools/objtool/arch/x86/decode.c      | 105 ++++++++++++--------------
 tools/objtool/check.c                |   4 +-
 tools/objtool/include/objtool/arch.h |   4 +-
 4 files changed, 64 insertions(+), 71 deletions(-)

diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc=
/decode.c
index 9c65380..53b5569 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -41,38 +41,36 @@ const char *arch_ret_insn(int len)
=20
 int arch_decode_instruction(struct objtool_file *file, const struct section =
*sec,
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
=20
-	insn =3D bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
-	opcode =3D insn >> 26;
+	ins =3D bswap_if_needed(file->elf, *(u32 *)(sec->data->d_buf + offset));
+	opcode =3D ins >> 26;
 	typ =3D INSN_OTHER;
 	imm =3D 0;
=20
 	switch (opcode) {
 	case 18: /* b[l][a] */
-		if ((insn & 3) =3D=3D 1) /* bl */
+		if ((ins & 3) =3D=3D 1) /* bl */
 			typ =3D INSN_CALL;
=20
-		imm =3D insn & 0x3fffffc;
+		imm =3D ins & 0x3fffffc;
 		if (imm & 0x2000000)
 			imm -=3D 0x4000000;
 		break;
 	}
=20
 	if (opcode =3D=3D 1)
-		*len =3D 8;
+		insn->len =3D 8;
 	else
-		*len =3D 4;
+		insn->len =3D 4;
=20
-	*type =3D typ;
-	*immediate =3D imm;
+	insn->type =3D typ;
+	insn->immediate =3D imm;
=20
 	return 0;
 }
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index e7b030f..c5c4927 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -146,12 +146,11 @@ static bool has_notrack_prefix(struct insn *insn)
=20
 int arch_decode_instruction(struct objtool_file *file, const struct section =
*sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list)
+			    struct instruction *insn)
 {
+	struct list_head *ops_list =3D &insn->stack_ops;
 	const struct elf *elf =3D file->elf;
-	struct insn insn;
+	struct insn ins;
 	int x86_64, ret;
 	unsigned char op1, op2, op3, prefix,
 		      rex =3D 0, rex_b =3D 0, rex_r =3D 0, rex_w =3D 0, rex_x =3D 0,
@@ -165,42 +164,42 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
 	if (x86_64 =3D=3D -1)
 		return -1;
=20
-	ret =3D insn_decode(&insn, sec->data->d_buf + offset, maxlen,
+	ret =3D insn_decode(&ins, sec->data->d_buf + offset, maxlen,
 			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 	if (ret < 0) {
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
=20
-	*len =3D insn.length;
-	*type =3D INSN_OTHER;
+	insn->len =3D ins.length;
+	insn->type =3D INSN_OTHER;
=20
-	if (insn.vex_prefix.nbytes)
+	if (ins.vex_prefix.nbytes)
 		return 0;
=20
-	prefix =3D insn.prefixes.bytes[0];
+	prefix =3D ins.prefixes.bytes[0];
=20
-	op1 =3D insn.opcode.bytes[0];
-	op2 =3D insn.opcode.bytes[1];
-	op3 =3D insn.opcode.bytes[2];
+	op1 =3D ins.opcode.bytes[0];
+	op2 =3D ins.opcode.bytes[1];
+	op3 =3D ins.opcode.bytes[2];
=20
-	if (insn.rex_prefix.nbytes) {
-		rex =3D insn.rex_prefix.bytes[0];
+	if (ins.rex_prefix.nbytes) {
+		rex =3D ins.rex_prefix.bytes[0];
 		rex_w =3D X86_REX_W(rex) >> 3;
 		rex_r =3D X86_REX_R(rex) >> 2;
 		rex_x =3D X86_REX_X(rex) >> 1;
 		rex_b =3D X86_REX_B(rex);
 	}
=20
-	if (insn.modrm.nbytes) {
-		modrm =3D insn.modrm.bytes[0];
+	if (ins.modrm.nbytes) {
+		modrm =3D ins.modrm.bytes[0];
 		modrm_mod =3D X86_MODRM_MOD(modrm);
 		modrm_reg =3D X86_MODRM_REG(modrm) + 8*rex_r;
 		modrm_rm  =3D X86_MODRM_RM(modrm)  + 8*rex_b;
 	}
=20
-	if (insn.sib.nbytes) {
-		sib =3D insn.sib.bytes[0];
+	if (ins.sib.nbytes) {
+		sib =3D ins.sib.bytes[0];
 		/* sib_scale =3D X86_SIB_SCALE(sib); */
 		sib_index =3D X86_SIB_INDEX(sib) + 8*rex_x;
 		sib_base  =3D X86_SIB_BASE(sib)  + 8*rex_b;
@@ -254,7 +253,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 		break;
=20
 	case 0x70 ... 0x7f:
-		*type =3D INSN_JUMP_CONDITIONAL;
+		insn->type =3D INSN_JUMP_CONDITIONAL;
 		break;
=20
 	case 0x80 ... 0x83:
@@ -278,7 +277,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 		if (!rm_is_reg(CFI_SP))
 			break;
=20
-		imm =3D insn.immediate.value;
+		imm =3D ins.immediate.value;
 		if (op1 & 2) { /* sign extend */
 			if (op1 & 1) { /* imm32 */
 				imm <<=3D 32;
@@ -309,7 +308,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 			ADD_OP(op) {
 				op->src.type =3D OP_SRC_AND;
 				op->src.reg =3D CFI_SP;
-				op->src.offset =3D insn.immediate.value;
+				op->src.offset =3D ins.immediate.value;
 				op->dest.type =3D OP_DEST_REG;
 				op->dest.reg =3D CFI_SP;
 			}
@@ -356,7 +355,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 					op->src.reg =3D CFI_SP;
 					op->dest.type =3D OP_DEST_REG_INDIRECT;
 					op->dest.reg =3D modrm_rm;
-					op->dest.offset =3D insn.displacement.value;
+					op->dest.offset =3D ins.displacement.value;
 				}
 				break;
 			}
@@ -389,7 +388,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 				op->src.reg =3D modrm_reg;
 				op->dest.type =3D OP_DEST_REG_INDIRECT;
 				op->dest.reg =3D CFI_BP;
-				op->dest.offset =3D insn.displacement.value;
+				op->dest.offset =3D ins.displacement.value;
 			}
 			break;
 		}
@@ -402,7 +401,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 				op->src.reg =3D modrm_reg;
 				op->dest.type =3D OP_DEST_REG_INDIRECT;
 				op->dest.reg =3D CFI_SP;
-				op->dest.offset =3D insn.displacement.value;
+				op->dest.offset =3D ins.displacement.value;
 			}
 			break;
 		}
@@ -419,7 +418,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 			ADD_OP(op) {
 				op->src.type =3D OP_SRC_REG_INDIRECT;
 				op->src.reg =3D CFI_BP;
-				op->src.offset =3D insn.displacement.value;
+				op->src.offset =3D ins.displacement.value;
 				op->dest.type =3D OP_DEST_REG;
 				op->dest.reg =3D modrm_reg;
 			}
@@ -432,7 +431,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 			ADD_OP(op) {
 				op->src.type =3D OP_SRC_REG_INDIRECT;
 				op->src.reg =3D CFI_SP;
-				op->src.offset =3D insn.displacement.value;
+				op->src.offset =3D ins.displacement.value;
 				op->dest.type =3D OP_DEST_REG;
 				op->dest.reg =3D modrm_reg;
 			}
@@ -464,7 +463,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
=20
 		/* lea disp(%src), %dst */
 		ADD_OP(op) {
-			op->src.offset =3D insn.displacement.value;
+			op->src.offset =3D ins.displacement.value;
 			if (!op->src.offset) {
 				/* lea (%src), %dst */
 				op->src.type =3D OP_SRC_REG;
@@ -487,7 +486,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 		break;
=20
 	case 0x90:
-		*type =3D INSN_NOP;
+		insn->type =3D INSN_NOP;
 		break;
=20
 	case 0x9c:
@@ -511,39 +510,39 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
 		if (op2 =3D=3D 0x01) {
=20
 			if (modrm =3D=3D 0xca)
-				*type =3D INSN_CLAC;
+				insn->type =3D INSN_CLAC;
 			else if (modrm =3D=3D 0xcb)
-				*type =3D INSN_STAC;
+				insn->type =3D INSN_STAC;
=20
 		} else if (op2 >=3D 0x80 && op2 <=3D 0x8f) {
=20
-			*type =3D INSN_JUMP_CONDITIONAL;
+			insn->type =3D INSN_JUMP_CONDITIONAL;
=20
 		} else if (op2 =3D=3D 0x05 || op2 =3D=3D 0x07 || op2 =3D=3D 0x34 ||
 			   op2 =3D=3D 0x35) {
=20
 			/* sysenter, sysret */
-			*type =3D INSN_CONTEXT_SWITCH;
+			insn->type =3D INSN_CONTEXT_SWITCH;
=20
 		} else if (op2 =3D=3D 0x0b || op2 =3D=3D 0xb9) {
=20
 			/* ud2 */
-			*type =3D INSN_BUG;
+			insn->type =3D INSN_BUG;
=20
 		} else if (op2 =3D=3D 0x0d || op2 =3D=3D 0x1f) {
=20
 			/* nopl/nopw */
-			*type =3D INSN_NOP;
+			insn->type =3D INSN_NOP;
=20
 		} else if (op2 =3D=3D 0x1e) {
=20
 			if (prefix =3D=3D 0xf3 && (modrm =3D=3D 0xfa || modrm =3D=3D 0xfb))
-				*type =3D INSN_ENDBR;
+				insn->type =3D INSN_ENDBR;
=20
=20
 		} else if (op2 =3D=3D 0x38 && op3 =3D=3D 0xf8) {
-			if (insn.prefixes.nbytes =3D=3D 1 &&
-			    insn.prefixes.bytes[0] =3D=3D 0xf2) {
+			if (ins.prefixes.nbytes =3D=3D 1 &&
+			    ins.prefixes.bytes[0] =3D=3D 0xf2) {
 				/* ENQCMD cannot be used in the kernel. */
 				WARN("ENQCMD instruction at %s:%lx", sec->name,
 				     offset);
@@ -591,29 +590,29 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
=20
 	case 0xcc:
 		/* int3 */
-		*type =3D INSN_TRAP;
+		insn->type =3D INSN_TRAP;
 		break;
=20
 	case 0xe3:
 		/* jecxz/jrcxz */
-		*type =3D INSN_JUMP_CONDITIONAL;
+		insn->type =3D INSN_JUMP_CONDITIONAL;
 		break;
=20
 	case 0xe9:
 	case 0xeb:
-		*type =3D INSN_JUMP_UNCONDITIONAL;
+		insn->type =3D INSN_JUMP_UNCONDITIONAL;
 		break;
=20
 	case 0xc2:
 	case 0xc3:
-		*type =3D INSN_RETURN;
+		insn->type =3D INSN_RETURN;
 		break;
=20
 	case 0xc7: /* mov imm, r/m */
 		if (!opts.noinstr)
 			break;
=20
-		if (insn.length =3D=3D 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
+		if (ins.length =3D=3D 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
 			struct reloc *immr, *disp;
 			struct symbol *func;
 			int idx;
@@ -661,17 +660,17 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
=20
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
-		*type =3D INSN_CONTEXT_SWITCH;
+		insn->type =3D INSN_CONTEXT_SWITCH;
 		break;
=20
 	case 0xe0: /* loopne */
 	case 0xe1: /* loope */
 	case 0xe2: /* loop */
-		*type =3D INSN_JUMP_CONDITIONAL;
+		insn->type =3D INSN_JUMP_CONDITIONAL;
 		break;
=20
 	case 0xe8:
-		*type =3D INSN_CALL;
+		insn->type =3D INSN_CALL;
 		/*
 		 * For the impact on the stack, a CALL behaves like
 		 * a PUSH of an immediate value (the return address).
@@ -683,30 +682,30 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
 		break;
=20
 	case 0xfc:
-		*type =3D INSN_CLD;
+		insn->type =3D INSN_CLD;
 		break;
=20
 	case 0xfd:
-		*type =3D INSN_STD;
+		insn->type =3D INSN_STD;
 		break;
=20
 	case 0xff:
 		if (modrm_reg =3D=3D 2 || modrm_reg =3D=3D 3) {
=20
-			*type =3D INSN_CALL_DYNAMIC;
-			if (has_notrack_prefix(&insn))
+			insn->type =3D INSN_CALL_DYNAMIC;
+			if (has_notrack_prefix(&ins))
 				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
=20
 		} else if (modrm_reg =3D=3D 4) {
=20
-			*type =3D INSN_JUMP_DYNAMIC;
-			if (has_notrack_prefix(&insn))
+			insn->type =3D INSN_JUMP_DYNAMIC;
+			if (has_notrack_prefix(&ins))
 				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
=20
 		} else if (modrm_reg =3D=3D 5) {
=20
 			/* jmpf */
-			*type =3D INSN_CONTEXT_SWITCH;
+			insn->type =3D INSN_CONTEXT_SWITCH;
=20
 		} else if (modrm_reg =3D=3D 6) {
=20
@@ -723,7 +722,7 @@ int arch_decode_instruction(struct objtool_file *file, co=
nst struct section *sec
 		break;
 	}
=20
-	*immediate =3D insn.immediate.nbytes ? insn.immediate.value : 0;
+	insn->immediate =3D ins.immediate.nbytes ? ins.immediate.value : 0;
=20
 	return 0;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ba07a8e..b3b423d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -406,9 +406,7 @@ static int decode_instructions(struct objtool_file *file)
=20
 			ret =3D arch_decode_instruction(file, sec, offset,
 						      sec->sh.sh_size - offset,
-						      &insn->len, &insn->type,
-						      &insn->immediate,
-						      &insn->stack_ops);
+						      insn);
 			if (ret)
 				goto err;
=20
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index 4ecb480..73149f8 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -75,9 +75,7 @@ void arch_initial_func_cfi_state(struct cfi_init_state *sta=
te);
=20
 int arch_decode_instruction(struct objtool_file *file, const struct section =
*sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list);
+			    struct instruction *insn);
=20
 bool arch_callee_saved_reg(unsigned char reg);
=20
