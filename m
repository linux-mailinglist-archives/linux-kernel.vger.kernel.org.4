Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EB25FDE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJMQnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJMQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:43:04 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B4514D1F0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1665679378; bh=VdEyN+tgdUlXG37ETOs7UhKMPsgrVlwHgJepyB9XIko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mb2RoOJ809JJaZ5fRcTK6qzxB1uVF8w0AaJ770+zcsFiHbygVA9MPlGpogDopxE03
         PH5Qo5ajZ83+WVaMCzT3AXUsECjlpdeJaZu4z6n2qU3HsEj7MgOzLL7QG0eXtbMWne
         UQu+2oXfKsdWjEK0ZRX3Jm1nFLaLiDtEhGVCjXkA=
Received: from [192.168.9.172] (unknown [101.88.135.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id AE2916009B;
        Fri, 14 Oct 2022 00:42:58 +0800 (CST)
Message-ID: <8a8fa581-94a9-649d-8c01-f1afd4bc9514@xen0n.name>
Date:   Fri, 14 Oct 2022 00:42:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0a1
Subject: Re: [PATCH] LoongArch: BPF: Avoid declare variables in switch-case
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
References: <20221013154000.3462836-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20221013154000.3462836-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 23:40, Huacai Chen wrote:
> Not all compilers support declare variables in switch-case, so move
> declarations to the beginning of a function. Otherwise we may get such
> build errors:
>
> arch/loongarch/net/bpf_jit.c: In function ‘emit_atomic’:
> arch/loongarch/net/bpf_jit.c:362:3: error: a label can only be part of a statement and a declaration is not a statement
>     u8 r0 = regmap[BPF_REG_0];
>     ^~
> arch/loongarch/net/bpf_jit.c: In function ‘build_insn’:
> arch/loongarch/net/bpf_jit.c:727:3: error: a label can only be part of a statement and a declaration is not a statement
>     u8 t7 = -1;
>     ^~
> arch/loongarch/net/bpf_jit.c:778:3: error: a label can only be part of a statement and a declaration is not a statement
>     int ret;
>     ^~~
> arch/loongarch/net/bpf_jit.c:779:3: error: expected expression before ‘u64’
>     u64 func_addr;
>     ^~~
> arch/loongarch/net/bpf_jit.c:780:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>     bool func_addr_fixed;
>     ^~~~
> arch/loongarch/net/bpf_jit.c:784:11: error: ‘func_addr’ undeclared (first use in this function); did you mean ‘in_addr’?
>            &func_addr, &func_addr_fixed);
>             ^~~~~~~~~
>             in_addr
> arch/loongarch/net/bpf_jit.c:784:11: note: each undeclared identifier is reported only once for each function it appears in
> arch/loongarch/net/bpf_jit.c:814:3: error: a label can only be part of a statement and a declaration is not a statement
>     u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
>     ^~~
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> ---
>   arch/loongarch/net/bpf_jit.c | 31 +++++++++++++------------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 43f0a98efe38..2a9b590f47e6 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -279,6 +279,7 @@ static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   	const u8 t1 = LOONGARCH_GPR_T1;
>   	const u8 t2 = LOONGARCH_GPR_T2;
>   	const u8 t3 = LOONGARCH_GPR_T3;
> +	const u8 r0 = regmap[BPF_REG_0];
>   	const u8 src = regmap[insn->src_reg];
>   	const u8 dst = regmap[insn->dst_reg];
>   	const s16 off = insn->off;
> @@ -359,8 +360,6 @@ static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
>   		break;
>   	/* r0 = atomic_cmpxchg(dst + off, r0, src); */
>   	case BPF_CMPXCHG:
> -		u8 r0 = regmap[BPF_REG_0];
> -
>   		move_reg(ctx, t2, r0);
>   		if (isdw) {
>   			emit_insn(ctx, lld, r0, t1, 0);
> @@ -390,8 +389,11 @@ static bool is_signed_bpf_cond(u8 cond)
>   
>   static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
>   {
> -	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
> -			  BPF_CLASS(insn->code) == BPF_JMP32;
> +	u8 t0 = -1;
Here "t0" seems to be a versatile temp value, while the "t1" below is 
the actual GPR $t1. What about renaming "t0" to something like "tmp" to 
reduce confusion? I believe due to things like "t0 = LOONGARCH_GPR_ZERO" 
the "t0" is 100% not an actual mapping to $t0.
> +	u64 func_addr;
> +	bool func_addr_fixed;
> +	int i = insn - ctx->prog->insnsi;
> +	int ret, jmp_offset;
>   	const u8 code = insn->code;
>   	const u8 cond = BPF_OP(code);
>   	const u8 t1 = LOONGARCH_GPR_T1;
> @@ -400,8 +402,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   	const u8 dst = regmap[insn->dst_reg];
>   	const s16 off = insn->off;
>   	const s32 imm = insn->imm;
> -	int jmp_offset;
> -	int i = insn - ctx->prog->insnsi;
> +	const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
> +	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
Please consider reducing diff damage and not touching parts not directly 
affected by this change. For example this "is32" declaration and 
initialization was moved although not related to this change.
>   
>   	switch (code) {
>   	/* dst = src */
> @@ -724,24 +726,23 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   	case BPF_JMP32 | BPF_JSGE | BPF_K:
>   	case BPF_JMP32 | BPF_JSLT | BPF_K:
>   	case BPF_JMP32 | BPF_JSLE | BPF_K:
> -		u8 t7 = -1;
>   		jmp_offset = bpf2la_offset(i, off, ctx);
>   		if (imm) {
>   			move_imm(ctx, t1, imm, false);
> -			t7 = t1;
> +			t0 = t1;
>   		} else {
>   			/* If imm is 0, simply use zero register. */
> -			t7 = LOONGARCH_GPR_ZERO;
> +			t0 = LOONGARCH_GPR_ZERO;
>   		}
>   		move_reg(ctx, t2, dst);
>   		if (is_signed_bpf_cond(BPF_OP(code))) {
> -			emit_sext_32(ctx, t7, is32);
> +			emit_sext_32(ctx, t0, is32);
>   			emit_sext_32(ctx, t2, is32);
>   		} else {
> -			emit_zext_32(ctx, t7, is32);
> +			emit_zext_32(ctx, t0, is32);
>   			emit_zext_32(ctx, t2, is32);
>   		}
> -		if (emit_cond_jmp(ctx, cond, t2, t7, jmp_offset) < 0)
> +		if (emit_cond_jmp(ctx, cond, t2, t0, jmp_offset) < 0)
>   			goto toofar;
>   		break;
>   
> @@ -775,10 +776,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   
>   	/* function call */
>   	case BPF_JMP | BPF_CALL:
> -		int ret;
> -		u64 func_addr;
> -		bool func_addr_fixed;
> -
>   		mark_call(ctx);
>   		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
>   					    &func_addr, &func_addr_fixed);
> @@ -811,8 +808,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   
>   	/* dst = imm64 */
>   	case BPF_LD | BPF_IMM | BPF_DW:
> -		u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
> -
>   		move_imm(ctx, dst, imm64, is32);
>   		return 1;
>   

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

