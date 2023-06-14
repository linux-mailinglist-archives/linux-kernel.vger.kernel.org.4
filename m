Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64D72D77B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbjFMCxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjFMCxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:53:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9811734;
        Mon, 12 Jun 2023 19:53:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-652d76be8c2so5492384b3a.3;
        Mon, 12 Jun 2023 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686624794; x=1689216794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3R3RZvz5t7u2FrRguPhM7I6OHwZlHgebZcb5fE7XJc=;
        b=Jrmhly/VsdcsiEtSClZcmP0QeCJIBhwUKHTVU3hqABM/2sgYIv0WSH8OIPl/Lrz+9H
         xSxLMGF5XH+m0RAdViHnGuTLFluBBdInvo6FdBWwLJKqec9tN52qYEoMoa8HP7ezpOgU
         l+LqiQ5rXBpiiEh3VV47QO4R7Teis278Z1a6oFlYsjIzSZGOrSbctH+o2yvw8EpJb0iv
         EYhYrMyiqRDa9XTm41Ng6I12Za2vSFArvTrRJ9KpvL7oclhqdTVeJOMlPguftJkf0U2Q
         HMvykz/DlxBUUVXGAGrXQPfkSEdg9HA1M+kX23mhDbh+tYieHaKIRktR0Xn6PKilnCTV
         FtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686624794; x=1689216794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3R3RZvz5t7u2FrRguPhM7I6OHwZlHgebZcb5fE7XJc=;
        b=XwNiC43N66eukpvHF/SNO3WX7+tCvGB9hxNTRisqSE4hn5NPx9nDw42cW5jwJ4p5aL
         pVTj2gJVDnT7PsuH7Z04U4t9pE8XShTOHmYNJM7s5lv5bDUUJydoKzMzbgGUk6vGJOA5
         sqmZP8ed1gSdsIgYJx9VWunV5D7VJXu6PNTXvx+6taolMfVvyNm7WtvOea2Q1Qxe1FpD
         8DjSWKUc4IA3Hx27q06yphSz4pOE4KwxGAXGGoqG7dHUCR+skP/jqtnZja1DpvB0vSrl
         5nLn75b2/7Z/0KDb1JaPfQx4pG3VQZDwmLFj2n7tORHUVDYKvrDkJ1NVDD8foOsCDJcN
         eaAw==
X-Gm-Message-State: AC+VfDwHkyyog8fF3t8Ly8HDXmUl4C7hobmA3dYRrwY2PVcIviIsoDvV
        ty94pa5FI0sS0AD675b3nLXWLXZF2nyhbDgl
X-Google-Smtp-Source: ACHHUZ7Ae8rgG3HTB+RJK0Rj+PIIUgHf2clxuOrhMiezp1XjGMD1BUNgWk1R0tEA+3PO576JBZhGOg==
X-Received: by 2002:a05:6a20:9382:b0:101:4e04:cef1 with SMTP id x2-20020a056a20938200b001014e04cef1mr13666481pzh.27.1686624794260;
        Mon, 12 Jun 2023 19:53:14 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.85])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b00543e9e17207sm8240207pgv.30.2023.06.12.19.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 19:53:13 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     yhs@meta.com, alexei.starovoitov@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v5 2/3] bpf, x86: allow function arguments up to 12 for TRACING
Date:   Tue, 13 Jun 2023 10:52:25 +0800
Message-Id: <20230613025226.3167956-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613025226.3167956-1-imagedong@tencent.com>
References: <20230613025226.3167956-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
on the kernel functions whose arguments count less than 6. This is not
friendly at all, as too many functions have arguments count more than 6.

According to the current kernel version, below is a statistics of the
function arguments count:

argument count | function count
7              | 704
8              | 270
9              | 84
10             | 47
11             | 47
12             | 27
13             | 22
14             | 5
15             | 0
16             | 1

Therefore, let's enhance it by increasing the function arguments count
allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.

For the case that we don't need to call origin function, which means
without BPF_TRAMP_F_CALL_ORIG, we need only copy the function arguments
that stored in the frame of the caller to current frame. The arguments
of arg6-argN are stored in "$rbp + 0x18", we need copy them to
"$rbp - regs_off + (6 * 8)".

For the case with BPF_TRAMP_F_CALL_ORIG, we need prepare the arguments
in stack before call origin function, which means we need alloc extra
"8 * (arg_count - 6)" memory in the top of the stack. Note, there should
not be any data be pushed to the stack before call the origin function.
Then, we have to store rbx with 'mov' instead of 'push'.

We use EMIT3_off32() or EMIT4() for "lea" and "sub". The range of the
imm in "lea" and "sub" is [-128, 127] if EMIT4() is used. Therefore,
we use EMIT3_off32() instead if the imm out of the range.

It works well for the FENTRY/FEXIT/MODIFY_RETURN.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v5:
- consider the case of the struct in arguments can't be hold by regs
v4:
- make the stack 16-byte aligned if passing args on-stack is needed
- add the function arguments statistics to the commit log
v3:
- use EMIT3_off32() for "lea" and "sub" only on necessary
- make 12 as the maximum arguments count
v2:
- instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow
- make MAX_BPF_FUNC_ARGS as the maximum argument count
---
 arch/x86/net/bpf_jit_comp.c | 221 +++++++++++++++++++++++++++++++-----
 1 file changed, 195 insertions(+), 26 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a407fbbffecd..47c699594dd8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1857,37 +1857,165 @@ st:			if (is_imm8(insn->off))
 	return proglen;
 }
 
-static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
-		      int stack_size)
+static inline void clean_stack_garbage(const struct btf_func_model *m,
+				       u8 **pprog, int nr_args_on_stack,
+				       int stack_size)
 {
-	int i;
+	int arg_size, off;
+	u8 *prog;
+
+	if (nr_args_on_stack != 1)
+		return;
+
+	/* the size of the last argument */
+	arg_size = m->arg_size[m->nr_args - 1];
+
+	/* Generally speaking, the compiler will pass the arguments
+	 * on-stack with "push" instruction, which will take 8-byte
+	 * on the stack. On this case, there won't be garbage values
+	 * while we copy the arguments from origin stack frame to current
+	 * in BPF_DW.
+	 *
+	 * However, sometimes the compiler will only allocate 4-byte on
+	 * the stack for the arguments. For now, this case will only
+	 * happen if there is only one argument on-stack and its size
+	 * not more than 4 byte. On this case, there will be garbage
+	 * values on the upper 4-byte where we store the argument on
+	 * current stack frame.
+	 *
+	 * arguments on origin stack:
+	 *
+	 * stack_arg_1(4-byte) xxx(4-byte)
+	 *
+	 * what we copy:
+	 *
+	 * stack_arg_1(8-byte): stack_arg_1(origin) xxx
+	 *
+	 * and the xxx is the garbage values which we should clean here.
+	 */
+	if (arg_size <= 4) {
+		off = -(stack_size - 4);
+		prog = *pprog;
+		/* mov DWORD PTR [rbp + off], 0 */
+		if (!is_imm8(off))
+			EMIT2_off32(0xC7, 0x85, off);
+		else
+			EMIT3(0xC7, 0x45, off);
+		EMIT(0, 4);
+		*pprog = prog;
+	}
+}
+
+static void save_args(const struct btf_func_model *m, u8 **prog,
+		      int stack_size, bool on_stack)
+{
+	int arg_regs, first_off, nr_regs = 0, nr_stack = 0;
+	int i, j;
 
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i = 0; i < min(nr_regs, 6); i++)
-		emit_stx(prog, BPF_DW, BPF_REG_FP,
-			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(stack_size - i * 8));
+	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
+		arg_regs = (m->arg_size[i] + 7) / 8;
+
+		/* According to the research of Yonghong, struct members
+		 * should be all in register or all on the stack.
+		 * Meanwhile, the compiler will pass the argument on regs
+		 * if the remained regs can hold the argument.
+		 *
+		 * Disorder of the args can happen. For example:
+		 *
+		 * struct foo_struct {
+		 *     long a;
+		 *     int b;
+		 * };
+		 * int foo(char, char, char, char, char, struct foo_struct,
+		 *         char);
+		 *
+		 * the arg1-5,arg7 will be passed by regs, and arg6 will
+		 * by stack.
+		 *
+		 * Therefore, we should keep the same logic as here when
+		 * we restore the regs in restore_regs.
+		 */
+		if (nr_regs + arg_regs > 6) {
+			/* copy function arguments from origin stack frame
+			 * into current stack frame.
+			 *
+			 * The starting address of the arguments on-stack
+			 * is:
+			 *   rbp + 8(push rbp) +
+			 *   8(return addr of origin call) +
+			 *   8(return addr of the caller)
+			 * which means: rbp + 24
+			 */
+			for (j = 0; j < arg_regs; j++) {
+				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
+					 nr_stack * 8 + 0x18);
+				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
+					 -stack_size);
+
+				if (!nr_stack)
+					first_off = stack_size;
+				stack_size -= 8;
+				nr_stack++;
+			}
+		} else {
+			/* Only copy the arguments on-stack to current
+			 * 'stack_size' and ignore the regs, used to
+			 * prepare the arguments on-stack for orign call.
+			 */
+			if (on_stack) {
+				nr_regs += arg_regs;
+				continue;
+			}
+
+			/* copy the arguments from regs into stack */
+			for (j = 0; j < arg_regs; j++) {
+				emit_stx(prog, BPF_DW, BPF_REG_FP,
+					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + i,
+					 -stack_size);
+				stack_size -= 8;
+				nr_regs++;
+			}
+		}
+	}
+
+	clean_stack_garbage(m, prog, nr_stack, first_off);
 }
 
-static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
+static void restore_regs(const struct btf_func_model *m, u8 **prog,
 			 int stack_size)
 {
-	int i;
+	int i, j, arg_regs, nr_regs = 0;
 
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
+	 *
+	 * The logic here is similar to what we do in save_args()
 	 */
-	for (i = 0; i < min(nr_regs, 6); i++)
-		emit_ldx(prog, BPF_DW,
-			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 BPF_REG_FP,
-			 -(stack_size - i * 8));
+	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
+		arg_regs = (m->arg_size[i] + 7) / 8;
+		if (nr_regs + arg_regs <= 6) {
+			for (j = 0; j < arg_regs; j++) {
+				emit_ldx(prog, BPF_DW,
+					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + i,
+					 BPF_REG_FP,
+					 -stack_size);
+				stack_size -= 8;
+				nr_regs++;
+			}
+		} else {
+			stack_size -= 8 * arg_regs;
+		}
+
+		if (nr_regs >= 6)
+			break;
+	}
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
@@ -1915,7 +2043,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
 	/* arg2: lea rsi, [rbp - ctx_cookie_off] */
-	EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
+	if (!is_imm8(-run_ctx_off))
+		EMIT3_off32(0x48, 0x8D, 0xB5, -run_ctx_off);
+	else
+		EMIT4(0x48, 0x8D, 0x75, -run_ctx_off);
 
 	if (emit_rsb_call(&prog, bpf_trampoline_enter(p), prog))
 		return -EINVAL;
@@ -1931,7 +2062,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	emit_nops(&prog, 2);
 
 	/* arg1: lea rdi, [rbp - stack_size] */
-	EMIT4(0x48, 0x8D, 0x7D, -stack_size);
+	if (!is_imm8(-stack_size))
+		EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
+	else
+		EMIT4(0x48, 0x8D, 0x7D, -stack_size);
 	/* arg2: progs[i]->insnsi for interpreter */
 	if (!p->jited)
 		emit_mov_imm64(&prog, BPF_REG_2,
@@ -1961,7 +2095,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	/* arg2: mov rsi, rbx <- start time in nsec */
 	emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_6);
 	/* arg3: lea rdx, [rbp - run_ctx_off] */
-	EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
+	if (!is_imm8(-run_ctx_off))
+		EMIT3_off32(0x48, 0x8D, 0x95, -run_ctx_off);
+	else
+		EMIT4(0x48, 0x8D, 0x55, -run_ctx_off);
 	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), prog))
 		return -EINVAL;
 
@@ -2113,7 +2250,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off;
+	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -2127,8 +2264,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
 			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
-	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
-	if (nr_regs > 6)
+	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
+	 * are passed through regs, the remains are through stack.
+	 */
+	if (nr_regs > MAX_BPF_FUNC_ARGS)
 		return -ENOTSUPP;
 
 	/* Generated trampoline stack layout:
@@ -2147,7 +2286,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
+	 * RBP - rbx_off   [ rbx value       ]  always
+	 *
 	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
+	 *
+	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
+	 *                     [ ...        ]
+	 *                     [ stack_arg2 ]
+	 * RBP - arg_stack_off [ stack_arg1 ]
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2167,9 +2313,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 
 	ip_off = stack_size;
 
+	stack_size += 8;
+	rbx_off = stack_size;
+
 	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off = stack_size;
 
+	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
+		stack_size += (nr_regs - 6) * 8;
+		/* make sure the stack pointer is 16-byte aligned if we
+		 * need pass arguments on stack, which means
+		 *  [stack_size + 8(rbp) + 8(rip) + 8(origin rip)]
+		 * should be 16-byte aligned. Following code depend on
+		 * that stack_size is already 8-byte aligned.
+		 */
+		stack_size += (stack_size % 16) ? 0 : 8;
+	}
+
+	arg_stack_off = stack_size;
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -2189,8 +2351,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	x86_call_depth_emit_accounting(&prog, NULL);
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
-	EMIT1(0x53);		 /* push rbx */
+	if (!is_imm8(stack_size))
+		/* sub rsp, stack_size */
+		EMIT3_off32(0x48, 0x81, 0xEC, stack_size);
+	else
+		/* sub rsp, stack_size */
+		EMIT4(0x48, 0x83, 0xEC, stack_size);
+	/* mov QWORD PTR [rbp - rbx_off], rbx */
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
 
 	/* Store number of argument registers of the traced function:
 	 *   mov rax, nr_regs
@@ -2208,7 +2376,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
 
-	save_regs(m, &prog, nr_regs, regs_off);
+	save_args(m, &prog, regs_off, false);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -2238,7 +2406,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, nr_regs, regs_off);
+		restore_regs(m, &prog, regs_off);
+		save_args(m, &prog, arg_stack_off, true);
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
@@ -2279,7 +2448,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_regs(m, &prog, nr_regs, regs_off);
+		restore_regs(m, &prog, regs_off);
 
 	/* This needs to be done regardless. If there were fmod_ret programs,
 	 * the return value is only updated on the stack and still needs to be
@@ -2298,7 +2467,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
-	EMIT1(0x5B); /* pop rbx */
+	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		/* skip our return address and return to parent */
-- 
2.40.1

