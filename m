Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E868635F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjBAKGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjBAKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:06:19 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78B62274;
        Wed,  1 Feb 2023 02:05:55 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4P6HbP6vC1z9sgb;
        Wed,  1 Feb 2023 11:05:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HPiS1y57O1WX; Wed,  1 Feb 2023 11:05:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4P6HbJ66wBz9sgg;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B3ADB8B786;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wjPushX05z81; Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 42CB68B77A;
        Wed,  1 Feb 2023 11:05:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 311A4rZa3908594
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 11:04:53 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 311A4r3q3908593;
        Wed, 1 Feb 2023 11:04:53 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2 8/9] powerpc/bpf/32: introduce a second source register for ALU operations
Date:   Wed,  1 Feb 2023 11:04:30 +0100
Message-Id: <d5aaaba50d9d6b4a0e9f0cd4a5e34101aca1e247.1675245773.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
References: <4fd69ef7945518c3e27f96b95046a5c1468d35bf.1675245773.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675245869; l=24322; s=20211009; h=from:subject:message-id; bh=MvFm0CqF5sFZGDeZVbeizM0wDS/mNFuNg+HvpMVJCpw=; b=gP6D+LODByNR39T1Z2aufZpbA+HSccnxYjHcvN/jMLAiYjzSrMllebIbeqdUIw5l6a5PO9yQZm5S aYmahgphC/2v0MfJ1PmEPsZ9wKTiSWX6DXl9nOfMf7Og0QydtwXY
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time being, all ALU operation are performed with same L-source
and destination, requiring the L-source to be moved into destination via
a separate register move, like:

  70:	7f c6 f3 78 	mr      r6,r30
  74:	7f a5 eb 78 	mr      r5,r29
  78:	30 c6 ff f4 	addic   r6,r6,-12
  7c:	7c a5 01 d4 	addme   r5,r5

Introduce a second source register to all ALU operations. For the time
being that second source register is made equal to the destination
register.

That change will allow, via following patch, to optimise the generated
code as:

  70:	30 de ff f4 	addic   r6,r30,-12
  74:	7c bd 01 d4 	addme   r5,r29

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit_comp32.c | 350 ++++++++++++++++--------------
 1 file changed, 183 insertions(+), 167 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index b1d6ed4d8270..5d36ff7a0a8b 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -294,6 +294,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		u32 dst_reg_h = dst_reg - 1;
 		u32 src_reg = bpf_to_ppc(insn[i].src_reg);
 		u32 src_reg_h = src_reg - 1;
+		u32 src2_reg = dst_reg;
+		u32 src2_reg_h = dst_reg_h;
 		u32 ax_reg = bpf_to_ppc(BPF_REG_AX);
 		u32 tmp_reg = bpf_to_ppc(TMP_REG);
 		u32 size = BPF_SIZE(code);
@@ -338,108 +340,111 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		 * Arithmetic operations: ADD/SUB/MUL/DIV/MOD/NEG
 		 */
 		case BPF_ALU | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
-			EMIT(PPC_RAW_ADD(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_ADD(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_ADD | BPF_X: /* dst += src */
-			EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, src_reg));
-			EMIT(PPC_RAW_ADDE(dst_reg_h, dst_reg_h, src_reg_h));
+			EMIT(PPC_RAW_ADDC(dst_reg, src2_reg, src_reg));
+			EMIT(PPC_RAW_ADDE(dst_reg_h, src2_reg_h, src_reg_h));
 			break;
 		case BPF_ALU | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
-			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SUB(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
-			EMIT(PPC_RAW_SUBFC(dst_reg, src_reg, dst_reg));
-			EMIT(PPC_RAW_SUBFE(dst_reg_h, src_reg_h, dst_reg_h));
+			EMIT(PPC_RAW_SUBFC(dst_reg, src_reg, src2_reg));
+			EMIT(PPC_RAW_SUBFE(dst_reg_h, src_reg_h, src2_reg_h));
 			break;
 		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
 			imm = -imm;
 			fallthrough;
 		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
-			if (IMM_HA(imm) & 0xffff)
-				EMIT(PPC_RAW_ADDIS(dst_reg, dst_reg, IMM_HA(imm)));
+			if (!imm) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+			} else if (IMM_HA(imm) & 0xffff) {
+				EMIT(PPC_RAW_ADDIS(dst_reg, src2_reg, IMM_HA(imm)));
+				src2_reg = dst_reg;
+			}
 			if (IMM_L(imm))
-				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
+				EMIT(PPC_RAW_ADDI(dst_reg, src2_reg, IMM_L(imm)));
 			break;
 		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
 			imm = -imm;
 			fallthrough;
 		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
-			if (!imm)
+			if (!imm) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+				EMIT(PPC_RAW_MR(dst_reg_h, src2_reg_h));
 				break;
-
+			}
 			if (imm >= -32768 && imm < 32768) {
-				EMIT(PPC_RAW_ADDIC(dst_reg, dst_reg, imm));
+				EMIT(PPC_RAW_ADDIC(dst_reg, src2_reg, imm));
 			} else {
 				PPC_LI32(_R0, imm);
-				EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, _R0));
+				EMIT(PPC_RAW_ADDC(dst_reg, src2_reg, _R0));
 			}
 			if (imm >= 0 || (BPF_OP(code) == BPF_SUB && imm == 0x80000000))
-				EMIT(PPC_RAW_ADDZE(dst_reg_h, dst_reg_h));
+				EMIT(PPC_RAW_ADDZE(dst_reg_h, src2_reg_h));
 			else
-				EMIT(PPC_RAW_ADDME(dst_reg_h, dst_reg_h));
+				EMIT(PPC_RAW_ADDME(dst_reg_h, src2_reg_h));
 			break;
 		case BPF_ALU64 | BPF_MUL | BPF_X: /* dst *= src */
 			bpf_set_seen_register(ctx, tmp_reg);
-			EMIT(PPC_RAW_MULW(_R0, dst_reg, src_reg_h));
-			EMIT(PPC_RAW_MULW(dst_reg_h, dst_reg_h, src_reg));
-			EMIT(PPC_RAW_MULHWU(tmp_reg, dst_reg, src_reg));
-			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_MULW(_R0, src2_reg, src_reg_h));
+			EMIT(PPC_RAW_MULW(dst_reg_h, src2_reg_h, src_reg));
+			EMIT(PPC_RAW_MULHWU(tmp_reg, src2_reg, src_reg));
+			EMIT(PPC_RAW_MULW(dst_reg, src2_reg, src_reg));
 			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, _R0));
 			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, tmp_reg));
 			break;
 		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
-			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_MULW(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
-			if (imm == 1)
-				break;
-			if (imm == -1) {
-				EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
+			if (imm == 1) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+			} else if (imm == -1) {
+				EMIT(PPC_RAW_SUBFIC(dst_reg, src2_reg, 0));
 			} else if (is_power_of_2((u32)imm)) {
-				EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, ilog2(imm)));
+				EMIT(PPC_RAW_SLWI(dst_reg, src2_reg, ilog2(imm)));
 			} else if (imm >= -32768 && imm < 32768) {
-				EMIT(PPC_RAW_MULI(dst_reg, dst_reg, imm));
+				EMIT(PPC_RAW_MULI(dst_reg, src2_reg, imm));
 			} else {
 				PPC_LI32(_R0, imm);
-				EMIT(PPC_RAW_MULW(dst_reg, dst_reg, _R0));
+				EMIT(PPC_RAW_MULW(dst_reg, src2_reg, _R0));
 			}
 			break;
 		case BPF_ALU64 | BPF_MUL | BPF_K: /* dst *= imm */
 			if (!imm) {
 				PPC_LI32(dst_reg, 0);
 				PPC_LI32(dst_reg_h, 0);
-				break;
-			}
-			if (imm == 1)
-				break;
-			if (imm == -1) {
-				EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
-				EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
-				break;
-			}
-			if (imm > 0 && is_power_of_2(imm)) {
+			} else if (imm == 1) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+				EMIT(PPC_RAW_MR(dst_reg_h, src2_reg_h));
+			} else if (imm == -1) {
+				EMIT(PPC_RAW_SUBFIC(dst_reg, src2_reg, 0));
+				EMIT(PPC_RAW_SUBFZE(dst_reg_h, src2_reg_h));
+			} else if (imm > 0 && is_power_of_2(imm)) {
 				imm = ilog2(imm);
-				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg_h, imm, 0, 31 - imm));
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, src2_reg_h, imm, 0, 31 - imm));
 				EMIT(PPC_RAW_RLWIMI(dst_reg_h, dst_reg, imm, 32 - imm, 31));
-				EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
-				break;
+				EMIT(PPC_RAW_SLWI(dst_reg, src2_reg, imm));
+			} else {
+				bpf_set_seen_register(ctx, tmp_reg);
+				PPC_LI32(tmp_reg, imm);
+				EMIT(PPC_RAW_MULW(dst_reg_h, src2_reg_h, tmp_reg));
+				if (imm < 0)
+					EMIT(PPC_RAW_SUB(dst_reg_h, dst_reg_h, src2_reg));
+				EMIT(PPC_RAW_MULHWU(_R0, src2_reg, tmp_reg));
+				EMIT(PPC_RAW_MULW(dst_reg, src2_reg, tmp_reg));
+				EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, _R0));
 			}
-			bpf_set_seen_register(ctx, tmp_reg);
-			PPC_LI32(tmp_reg, imm);
-			EMIT(PPC_RAW_MULW(dst_reg_h, dst_reg_h, tmp_reg));
-			if (imm < 0)
-				EMIT(PPC_RAW_SUB(dst_reg_h, dst_reg_h, dst_reg));
-			EMIT(PPC_RAW_MULHWU(_R0, dst_reg, tmp_reg));
-			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, tmp_reg));
-			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, _R0));
 			break;
 		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
-			EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_DIVWU(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
-			EMIT(PPC_RAW_DIVWU(_R0, dst_reg, src_reg));
+			EMIT(PPC_RAW_DIVWU(_R0, src2_reg, src_reg));
 			EMIT(PPC_RAW_MULW(_R0, src_reg, _R0));
-			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, _R0));
+			EMIT(PPC_RAW_SUB(dst_reg, src2_reg, _R0));
 			break;
 		case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
 			return -EOPNOTSUPP;
@@ -448,14 +453,13 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
 			if (!imm)
 				return -EINVAL;
-			if (imm == 1)
-				break;
-
-			if (is_power_of_2((u32)imm)) {
-				EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, ilog2(imm)));
+			if (imm == 1) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+			} else if (is_power_of_2((u32)imm)) {
+				EMIT(PPC_RAW_SRWI(dst_reg, src2_reg, ilog2(imm)));
 			} else {
 				PPC_LI32(_R0, imm);
-				EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, _R0));
+				EMIT(PPC_RAW_DIVWU(dst_reg, src2_reg, _R0));
 			}
 			break;
 		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
@@ -465,16 +469,15 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (!is_power_of_2((u32)imm)) {
 				bpf_set_seen_register(ctx, tmp_reg);
 				PPC_LI32(tmp_reg, imm);
-				EMIT(PPC_RAW_DIVWU(_R0, dst_reg, tmp_reg));
+				EMIT(PPC_RAW_DIVWU(_R0, src2_reg, tmp_reg));
 				EMIT(PPC_RAW_MULW(_R0, tmp_reg, _R0));
-				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, _R0));
-				break;
-			}
-			if (imm == 1)
+				EMIT(PPC_RAW_SUB(dst_reg, src2_reg, _R0));
+			} else if (imm == 1) {
 				EMIT(PPC_RAW_LI(dst_reg, 0));
-			else
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 32 - ilog2((u32)imm), 31));
-
+			} else {
+				imm = ilog2((u32)imm);
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 0, 32 - imm, 31));
+			}
 			break;
 		case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
 			if (!imm)
@@ -486,7 +489,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			if (imm == 1)
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 			else
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 32 - ilog2(imm), 31));
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 0, 32 - ilog2(imm), 31));
 			EMIT(PPC_RAW_LI(dst_reg_h, 0));
 			break;
 		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
@@ -496,34 +499,38 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				return -EOPNOTSUPP;
 
 			if (imm < 0) {
-				EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
-				EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
+				EMIT(PPC_RAW_SUBFIC(dst_reg, src2_reg, 0));
+				EMIT(PPC_RAW_SUBFZE(dst_reg_h, src2_reg_h));
 				imm = -imm;
+				src2_reg = dst_reg;
+			}
+			if (imm == 1) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+				EMIT(PPC_RAW_MR(dst_reg_h, src2_reg_h));
+			} else {
+				imm = ilog2(imm);
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 32 - imm, imm, 31));
+				EMIT(PPC_RAW_RLWIMI(dst_reg, src2_reg_h, 32 - imm, 0, imm - 1));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src2_reg_h, imm));
 			}
-			if (imm == 1)
-				break;
-			imm = ilog2(imm);
-			EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 32 - imm, imm, 31));
-			EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
-			EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, imm));
 			break;
 		case BPF_ALU | BPF_NEG: /* (u32) dst = -dst */
-			EMIT(PPC_RAW_NEG(dst_reg, dst_reg));
+			EMIT(PPC_RAW_NEG(dst_reg, src2_reg));
 			break;
 		case BPF_ALU64 | BPF_NEG: /* dst = -dst */
-			EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
-			EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
+			EMIT(PPC_RAW_SUBFIC(dst_reg, src2_reg, 0));
+			EMIT(PPC_RAW_SUBFZE(dst_reg_h, src2_reg_h));
 			break;
 
 		/*
 		 * Logical operations: AND/OR/XOR/[A]LSH/[A]RSH
 		 */
 		case BPF_ALU64 | BPF_AND | BPF_X: /* dst = dst & src */
-			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
-			EMIT(PPC_RAW_AND(dst_reg_h, dst_reg_h, src_reg_h));
+			EMIT(PPC_RAW_AND(dst_reg, src2_reg, src_reg));
+			EMIT(PPC_RAW_AND(dst_reg_h, src2_reg_h, src_reg_h));
 			break;
 		case BPF_ALU | BPF_AND | BPF_X: /* (u32) dst = dst & src */
-			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_AND(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
 			if (imm >= 0)
@@ -531,23 +538,23 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			fallthrough;
 		case BPF_ALU | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
 			if (!IMM_H(imm)) {
-				EMIT(PPC_RAW_ANDI(dst_reg, dst_reg, IMM_L(imm)));
+				EMIT(PPC_RAW_ANDI(dst_reg, src2_reg, IMM_L(imm)));
 			} else if (!IMM_L(imm)) {
-				EMIT(PPC_RAW_ANDIS(dst_reg, dst_reg, IMM_H(imm)));
+				EMIT(PPC_RAW_ANDIS(dst_reg, src2_reg, IMM_H(imm)));
 			} else if (imm == (((1 << fls(imm)) - 1) ^ ((1 << (ffs(i) - 1)) - 1))) {
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0,
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 0,
 						    32 - fls(imm), 32 - ffs(imm)));
 			} else {
 				PPC_LI32(_R0, imm);
-				EMIT(PPC_RAW_AND(dst_reg, dst_reg, _R0));
+				EMIT(PPC_RAW_AND(dst_reg, src2_reg, _R0));
 			}
 			break;
 		case BPF_ALU64 | BPF_OR | BPF_X: /* dst = dst | src */
-			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
-			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, src_reg_h));
+			EMIT(PPC_RAW_OR(dst_reg, src2_reg, src_reg));
+			EMIT(PPC_RAW_OR(dst_reg_h, src2_reg_h, src_reg_h));
 			break;
 		case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
-			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_OR(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_OR | BPF_K:/* dst = dst | imm */
 			/* Sign-extended */
@@ -555,145 +562,154 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				EMIT(PPC_RAW_LI(dst_reg_h, -1));
 			fallthrough;
 		case BPF_ALU | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
-			if (IMM_L(imm))
-				EMIT(PPC_RAW_ORI(dst_reg, dst_reg, IMM_L(imm)));
+			if (IMM_L(imm)) {
+				EMIT(PPC_RAW_ORI(dst_reg, src2_reg, IMM_L(imm)));
+				src2_reg = dst_reg;
+			}
 			if (IMM_H(imm))
-				EMIT(PPC_RAW_ORIS(dst_reg, dst_reg, IMM_H(imm)));
+				EMIT(PPC_RAW_ORIS(dst_reg, src2_reg, IMM_H(imm)));
 			break;
 		case BPF_ALU64 | BPF_XOR | BPF_X: /* dst ^= src */
 			if (dst_reg == src_reg) {
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
 			} else {
-				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
-				EMIT(PPC_RAW_XOR(dst_reg_h, dst_reg_h, src_reg_h));
+				EMIT(PPC_RAW_XOR(dst_reg, src2_reg, src_reg));
+				EMIT(PPC_RAW_XOR(dst_reg_h, src2_reg_h, src_reg_h));
 			}
 			break;
 		case BPF_ALU | BPF_XOR | BPF_X: /* (u32) dst ^= src */
 			if (dst_reg == src_reg)
 				EMIT(PPC_RAW_LI(dst_reg, 0));
 			else
-				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
+				EMIT(PPC_RAW_XOR(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_XOR | BPF_K: /* dst ^= imm */
 			if (imm < 0)
-				EMIT(PPC_RAW_NOR(dst_reg_h, dst_reg_h, dst_reg_h));
+				EMIT(PPC_RAW_NOR(dst_reg_h, src2_reg_h, src2_reg_h));
 			fallthrough;
 		case BPF_ALU | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
-			if (IMM_L(imm))
-				EMIT(PPC_RAW_XORI(dst_reg, dst_reg, IMM_L(imm)));
+			if (IMM_L(imm)) {
+				EMIT(PPC_RAW_XORI(dst_reg, src2_reg, IMM_L(imm)));
+				src2_reg = dst_reg;
+			}
 			if (IMM_H(imm))
-				EMIT(PPC_RAW_XORIS(dst_reg, dst_reg, IMM_H(imm)));
+				EMIT(PPC_RAW_XORIS(dst_reg, src2_reg, IMM_H(imm)));
 			break;
 		case BPF_ALU | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
-			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SLW(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_LSH | BPF_X: /* dst <<= src; */
 			bpf_set_seen_register(ctx, tmp_reg);
 			EMIT(PPC_RAW_SUBFIC(_R0, src_reg, 32));
-			EMIT(PPC_RAW_SLW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_SLW(dst_reg_h, src2_reg_h, src_reg));
 			EMIT(PPC_RAW_ADDI(tmp_reg, src_reg, 32));
-			EMIT(PPC_RAW_SRW(_R0, dst_reg, _R0));
-			EMIT(PPC_RAW_SLW(tmp_reg, dst_reg, tmp_reg));
+			EMIT(PPC_RAW_SRW(_R0, src2_reg, _R0));
+			EMIT(PPC_RAW_SLW(tmp_reg, src2_reg, tmp_reg));
 			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, _R0));
-			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SLW(dst_reg, src2_reg, src_reg));
 			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, tmp_reg));
 			break;
 		case BPF_ALU | BPF_LSH | BPF_K: /* (u32) dst <<= (u32) imm */
-			if (!imm)
-				break;
-			EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
+			if (imm)
+				EMIT(PPC_RAW_SLWI(dst_reg, src2_reg, imm));
+			else
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
 			break;
 		case BPF_ALU64 | BPF_LSH | BPF_K: /* dst <<= imm */
 			if (imm < 0)
 				return -EINVAL;
-			if (!imm)
-				break;
-			if (imm < 32) {
-				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg_h, imm, 0, 31 - imm));
-				EMIT(PPC_RAW_RLWIMI(dst_reg_h, dst_reg, imm, 32 - imm, 31));
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, imm, 0, 31 - imm));
-				break;
-			}
-			if (imm < 64)
-				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg, imm, 0, 31 - imm));
-			else
+			if (!imm) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+			} else if (imm < 32) {
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, src2_reg_h, imm, 0, 31 - imm));
+				EMIT(PPC_RAW_RLWIMI(dst_reg_h, src2_reg, imm, 32 - imm, 31));
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, imm, 0, 31 - imm));
+			} else if (imm < 64) {
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, src2_reg, imm, 0, 31 - imm));
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+			} else {
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
-			EMIT(PPC_RAW_LI(dst_reg, 0));
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+			}
 			break;
 		case BPF_ALU | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
-			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SRW(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_RSH | BPF_X: /* dst >>= src */
 			bpf_set_seen_register(ctx, tmp_reg);
 			EMIT(PPC_RAW_SUBFIC(_R0, src_reg, 32));
-			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SRW(dst_reg, src2_reg, src_reg));
 			EMIT(PPC_RAW_ADDI(tmp_reg, src_reg, 32));
-			EMIT(PPC_RAW_SLW(_R0, dst_reg_h, _R0));
+			EMIT(PPC_RAW_SLW(_R0, src2_reg_h, _R0));
 			EMIT(PPC_RAW_SRW(tmp_reg, dst_reg_h, tmp_reg));
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, _R0));
-			EMIT(PPC_RAW_SRW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_SRW(dst_reg_h, src2_reg_h, src_reg));
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, tmp_reg));
 			break;
 		case BPF_ALU | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
-			if (!imm)
-				break;
-			EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, imm));
+			if (imm)
+				EMIT(PPC_RAW_SRWI(dst_reg, src2_reg, imm));
+			else
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
 			break;
 		case BPF_ALU64 | BPF_RSH | BPF_K: /* dst >>= imm */
 			if (imm < 0)
 				return -EINVAL;
-			if (!imm)
-				break;
-			if (imm < 32) {
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 32 - imm, imm, 31));
-				EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
-				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg_h, 32 - imm, imm, 31));
-				break;
-			}
-			if (imm < 64)
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg_h, 64 - imm, imm - 32, 31));
-			else
+			if (!imm) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+				EMIT(PPC_RAW_MR(dst_reg_h, src2_reg_h));
+			} else if (imm < 32) {
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 32 - imm, imm, 31));
+				EMIT(PPC_RAW_RLWIMI(dst_reg, src2_reg_h, 32 - imm, 0, imm - 1));
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, src2_reg_h, 32 - imm, imm, 31));
+			} else if (imm < 64) {
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg_h, 64 - imm, imm - 32, 31));
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			} else {
 				EMIT(PPC_RAW_LI(dst_reg, 0));
-			EMIT(PPC_RAW_LI(dst_reg_h, 0));
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			}
 			break;
 		case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
-			EMIT(PPC_RAW_SRAW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SRAW(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
 			bpf_set_seen_register(ctx, tmp_reg);
 			EMIT(PPC_RAW_SUBFIC(_R0, src_reg, 32));
-			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
-			EMIT(PPC_RAW_SLW(_R0, dst_reg_h, _R0));
+			EMIT(PPC_RAW_SRW(dst_reg, src2_reg, src_reg));
+			EMIT(PPC_RAW_SLW(_R0, src2_reg_h, _R0));
 			EMIT(PPC_RAW_ADDI(tmp_reg, src_reg, 32));
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, _R0));
 			EMIT(PPC_RAW_RLWINM(_R0, tmp_reg, 0, 26, 26));
-			EMIT(PPC_RAW_SRAW(tmp_reg, dst_reg_h, tmp_reg));
-			EMIT(PPC_RAW_SRAW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_SRAW(tmp_reg, src2_reg_h, tmp_reg));
+			EMIT(PPC_RAW_SRAW(dst_reg_h, src2_reg_h, src_reg));
 			EMIT(PPC_RAW_SLW(tmp_reg, tmp_reg, _R0));
 			EMIT(PPC_RAW_OR(dst_reg, dst_reg, tmp_reg));
 			break;
 		case BPF_ALU | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
-			if (!imm)
-				break;
-			EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg, imm));
+			if (imm)
+				EMIT(PPC_RAW_SRAWI(dst_reg, src2_reg, imm));
+			else
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
 			break;
 		case BPF_ALU64 | BPF_ARSH | BPF_K: /* (s64) dst >>= imm */
 			if (imm < 0)
 				return -EINVAL;
-			if (!imm)
-				break;
-			if (imm < 32) {
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 32 - imm, imm, 31));
-				EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
-				EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, imm));
-				break;
+			if (!imm) {
+				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
+				EMIT(PPC_RAW_MR(dst_reg_h, src2_reg_h));
+			} else if (imm < 32) {
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 32 - imm, imm, 31));
+				EMIT(PPC_RAW_RLWIMI(dst_reg, src2_reg_h, 32 - imm, 0, imm - 1));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src2_reg_h, imm));
+			} else if (imm < 64) {
+				EMIT(PPC_RAW_SRAWI(dst_reg, src2_reg_h, imm - 32));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src2_reg_h, 31));
+			} else {
+				EMIT(PPC_RAW_SRAWI(dst_reg, src2_reg_h, 31));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src2_reg_h, 31));
 			}
-			if (imm < 64)
-				EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg_h, imm - 32));
-			else
-				EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg_h, 31));
-			EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, 31));
 			break;
 
 		/*
@@ -727,7 +743,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			switch (imm) {
 			case 16:
 				/* Copy 16 bits to upper part */
-				EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg, 16, 0, 15));
+				EMIT(PPC_RAW_RLWIMI(dst_reg, src2_reg, 16, 0, 15));
 				/* Rotate 8 bits right & mask */
 				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 24, 16, 31));
 				break;
@@ -737,23 +753,23 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 				 * 2 bytes are already in their final position
 				 * -- byte 2 and 4 (of bytes 1, 2, 3 and 4)
 				 */
-				EMIT(PPC_RAW_RLWINM(_R0, dst_reg, 8, 0, 31));
+				EMIT(PPC_RAW_RLWINM(_R0, src2_reg, 8, 0, 31));
 				/* Rotate 24 bits and insert byte 1 */
-				EMIT(PPC_RAW_RLWIMI(_R0, dst_reg, 24, 0, 7));
+				EMIT(PPC_RAW_RLWIMI(_R0, src2_reg, 24, 0, 7));
 				/* Rotate 24 bits and insert byte 3 */
-				EMIT(PPC_RAW_RLWIMI(_R0, dst_reg, 24, 16, 23));
+				EMIT(PPC_RAW_RLWIMI(_R0, src2_reg, 24, 16, 23));
 				EMIT(PPC_RAW_MR(dst_reg, _R0));
 				break;
 			case 64:
 				bpf_set_seen_register(ctx, tmp_reg);
-				EMIT(PPC_RAW_RLWINM(tmp_reg, dst_reg, 8, 0, 31));
-				EMIT(PPC_RAW_RLWINM(_R0, dst_reg_h, 8, 0, 31));
+				EMIT(PPC_RAW_RLWINM(tmp_reg, src2_reg, 8, 0, 31));
+				EMIT(PPC_RAW_RLWINM(_R0, src2_reg_h, 8, 0, 31));
 				/* Rotate 24 bits and insert byte 1 */
-				EMIT(PPC_RAW_RLWIMI(tmp_reg, dst_reg, 24, 0, 7));
-				EMIT(PPC_RAW_RLWIMI(_R0, dst_reg_h, 24, 0, 7));
+				EMIT(PPC_RAW_RLWIMI(tmp_reg, src2_reg, 24, 0, 7));
+				EMIT(PPC_RAW_RLWIMI(_R0, src2_reg_h, 24, 0, 7));
 				/* Rotate 24 bits and insert byte 3 */
-				EMIT(PPC_RAW_RLWIMI(tmp_reg, dst_reg, 24, 16, 23));
-				EMIT(PPC_RAW_RLWIMI(_R0, dst_reg_h, 24, 16, 23));
+				EMIT(PPC_RAW_RLWIMI(tmp_reg, src2_reg, 24, 16, 23));
+				EMIT(PPC_RAW_RLWIMI(_R0, src2_reg_h, 24, 16, 23));
 				EMIT(PPC_RAW_MR(dst_reg, _R0));
 				EMIT(PPC_RAW_MR(dst_reg_h, tmp_reg));
 				break;
@@ -763,7 +779,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *
 			switch (imm) {
 			case 16:
 				/* zero-extend 16 bits into 32 bits */
-				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 16, 31));
+				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 0, 16, 31));
 				break;
 			case 32:
 			case 64:
-- 
2.39.1

