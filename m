Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4363EAAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLAH6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiLAH6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:58:00 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5763D58;
        Wed, 30 Nov 2022 23:57:27 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4NN7hL1C1Dz9sZv;
        Thu,  1 Dec 2022 08:57:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H_JiJorG2A5g; Thu,  1 Dec 2022 08:57:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4NN7hD4Wrbz9sb2;
        Thu,  1 Dec 2022 08:57:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 852588B78C;
        Thu,  1 Dec 2022 08:57:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DOt8h5AQMIwH; Thu,  1 Dec 2022 08:57:00 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C41078B780;
        Thu,  1 Dec 2022 08:56:59 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2B17uvxf130828
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 08:56:57 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2B17uvtN130827;
        Thu, 1 Dec 2022 08:56:57 +0100
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
Subject: [PATCH v1 06/10] powerpc/bpf: Perform complete extra passes to update addresses
Date:   Thu,  1 Dec 2022 08:56:31 +0100
Message-Id: <c13ebeb4d5d169bda6d1d60ccaa6cc956308308d.1669881248.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
References: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669881390; l=4449; s=20211009; h=from:subject:message-id; bh=RDj3enfMo0/pzPD7ndomZPp8lJevoeThXIDqFamXyKI=; b=r6vVGgdZKqeK1TBzPS1+mrL0tybQsq8zP5DrpFoROP2tPpRDYpuWPlhCPGDECNd2111a7npO6iCa /v3g7ZWIC0Vx5jT8W4hY7x0spxUcoHhdhtkHduQqHoFr9ST4qwXp
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF core calls the jit compiler again for an extra pass in order
to properly set subprog addresses.

Unlike other architectures, powerpc only updates the addresses
during that extra pass. It means that holes must have been left
in the code in order to enable the maximum possible instruction
size.

In order avoid waste of space, and waste of CPU time on powerpc
processors on which the NOP instruction is not 0-cycle, perform
two real additional passes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/net/bpf_jit_comp.c | 85 ---------------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 43e634126514..8833bf23f5aa 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -23,74 +23,6 @@ static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
 }
 
-/* Fix updated addresses (for subprog calls, ldimm64, et al) during extra pass */
-static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
-				   struct codegen_context *ctx, u32 *addrs)
-{
-	const struct bpf_insn *insn = fp->insnsi;
-	bool func_addr_fixed;
-	u64 func_addr;
-	u32 tmp_idx;
-	int i, j, ret;
-
-	for (i = 0; i < fp->len; i++) {
-		/*
-		 * During the extra pass, only the branch target addresses for
-		 * the subprog calls need to be fixed. All other instructions
-		 * can left untouched.
-		 *
-		 * The JITed image length does not change because we already
-		 * ensure that the JITed instruction sequence for these calls
-		 * are of fixed length by padding them with NOPs.
-		 */
-		if (insn[i].code == (BPF_JMP | BPF_CALL) &&
-		    insn[i].src_reg == BPF_PSEUDO_CALL) {
-			ret = bpf_jit_get_func_addr(fp, &insn[i], true,
-						    &func_addr,
-						    &func_addr_fixed);
-			if (ret < 0)
-				return ret;
-
-			/*
-			 * Save ctx->idx as this would currently point to the
-			 * end of the JITed image and set it to the offset of
-			 * the instruction sequence corresponding to the
-			 * subprog call temporarily.
-			 */
-			tmp_idx = ctx->idx;
-			ctx->idx = addrs[i] / 4;
-			ret = bpf_jit_emit_func_call_rel(image, ctx, func_addr);
-			if (ret)
-				return ret;
-
-			/*
-			 * Restore ctx->idx here. This is safe as the length
-			 * of the JITed sequence remains unchanged.
-			 */
-			ctx->idx = tmp_idx;
-		} else if (insn[i].code == (BPF_LD | BPF_IMM | BPF_DW)) {
-			tmp_idx = ctx->idx;
-			ctx->idx = addrs[i] / 4;
-#ifdef CONFIG_PPC32
-			PPC_LI32(bpf_to_ppc(insn[i].dst_reg) - 1, (u32)insn[i + 1].imm);
-			PPC_LI32(bpf_to_ppc(insn[i].dst_reg), (u32)insn[i].imm);
-			for (j = ctx->idx - addrs[i] / 4; j < 4; j++)
-				EMIT(PPC_RAW_NOP());
-#else
-			func_addr = ((u64)(u32)insn[i].imm) | (((u64)(u32)insn[i + 1].imm) << 32);
-			PPC_LI64(bpf_to_ppc(insn[i].dst_reg), func_addr);
-			/* overwrite rest with nops */
-			for (j = ctx->idx - addrs[i] / 4; j < 5; j++)
-				EMIT(PPC_RAW_NOP());
-#endif
-			ctx->idx = tmp_idx;
-			i++;
-		}
-	}
-
-	return 0;
-}
-
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
 {
 	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
@@ -234,22 +166,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 skip_init_ctx:
 	code_base = (u32 *)(image + FUNCTION_DESCR_SIZE);
 
-	if (extra_pass) {
-		/*
-		 * Do not touch the prologue and epilogue as they will remain
-		 * unchanged. Only fix the branch target address for subprog
-		 * calls in the body, and ldimm64 instructions.
-		 *
-		 * This does not change the offsets and lengths of the subprog
-		 * call instruction sequences and hence, the size of the JITed
-		 * image as well.
-		 */
-		bpf_jit_fixup_addresses(fp, code_base, &cgctx, addrs);
-
-		/* There is no need to perform the usual passes. */
-		goto skip_codegen_passes;
-	}
-
 	/* Code generation passes 1-2 */
 	for (pass = 1; pass < 3; pass++) {
 		/* Now build the prologue, body code & epilogue for real. */
@@ -268,7 +184,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 				proglen - (cgctx.idx * 4), cgctx.seen);
 	}
 
-skip_codegen_passes:
 	if (bpf_jit_enable > 1)
 		/*
 		 * Note that we output the base address of the code_base
-- 
2.38.1

