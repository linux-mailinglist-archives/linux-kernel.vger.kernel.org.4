Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2163C74F781
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGKRub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKRu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:50:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71410C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:50:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso34882885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689097827; x=1691689827;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Od3z6lgfWejEpTrv/o+yIiM7PB4PG6s5bm3VIUVJmM=;
        b=1zCEm0TjXOYNc1rfynH2/Z3AWqGj+miHradfJaypI3bSJbOdjV2r1avpSHroQEKCe9
         tO2en3v9lK5eH4qRsiYhkSCvF98UdNUpWmmok+gVcZRrorSJUCl6ZRJbqWy4I9QmgmSh
         BsDLqjI6hU/oc42a2F3ZZQjPiKvjkf+12jgv2ViXY8mnKzfJ61IYpBBII/6MY4RtFWzZ
         VxxUIidOK1z0wquGM9bac6Dzycj21Rog/GA/ahYcuzf1+9PEkzRmYrhpbtzs4blgznUT
         Tnjx5BXciXrGi9N9Xx3dVkF1hfa3bDp2emg4L95UOrd8XOSGJ2tc7a/wFe2QfZUUrFwr
         /+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689097827; x=1691689827;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Od3z6lgfWejEpTrv/o+yIiM7PB4PG6s5bm3VIUVJmM=;
        b=N5siR6D3Y0HQhHqQTHkn92GmHYFAT8I19Thd0yGEZv9ACVfkC6krp08ZTdZXtuSo4O
         dESnpeoUE2nl+Gduz4vrWRmv8E1uLKYxt1RKLJH+51cJFqTaJSYylmJSAKxiTYAzguZF
         3m070hGljAFXraL+3oVQfoLGHackls+OU88wDzT5P/lqnRrDjsJW2UYsyaSTvJWu+yus
         EPO5FKoHkviwL4/EsP8OzsLiVNBm+r+0GzwBE50oiGSQiuRnvWwYssymSMOc1MiUtjqs
         kO5Z/kRr0u1BZuAvThcvlYQk6J10dBNewGW5bUolSfnaXYYL9h0hbYmQKrygSPYvSmrK
         oyzQ==
X-Gm-Message-State: ABy/qLZe38rqt8GL/5kGYQP8dMiKPecuF/CMg7o9cnxAa+TLJ98gmcjB
        8SQN+C8LUuig5wW/Om+XL0uF6A==
X-Google-Smtp-Source: APBJJlG2w3IH9uUrApfSKSdlopd7bGHAnrQwSQSpa6WXOfuGbTR3QFr6z8ZN7CEPBQUKhz7Dqx+r0Q==
X-Received: by 2002:a17:903:447:b0:1b8:a31b:ac85 with SMTP id iw7-20020a170903044700b001b8a31bac85mr15502963plb.41.1689097826708;
        Tue, 11 Jul 2023 10:50:26 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id ja1-20020a170902efc100b001b1a2c14a4asm2221425plb.38.2023.07.11.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:50:26 -0700 (PDT)
Date:   Tue, 11 Jul 2023 10:50:26 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Jul 2023 10:49:36 PDT (-0700)
Subject:     Re: [PATCH bpf] riscv, bpf: Fix inconsistent JIT image generation
In-Reply-To: <20230710074131.19596-1-bjorn@kernel.org>
CC:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Topel <bjorn@rivosinc.com>, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, pulehui@huawei.com, luke.r.nels@gmail.com,
        xi.wang@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bjorn@kernel.org
Message-ID: <mhng-37770bfd-e982-4b87-a202-7cc08005b483@palmer-ri-x1c9a>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 00:41:31 PDT (-0700), bjorn@kernel.org wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> In order to generate the prologue and epilogue, the BPF JIT needs to
> know which registers that are clobbered. Therefore, the during
> pre-final passes, the prologue is generated after the body of the
> program body-prologue-epilogue. Then, in the final pass, a proper
> prologue-body-epilogue JITted image is generated.
>
> This scheme has worked most of the time. However, for some large
> programs with many jumps, e.g. the test_kmod.sh BPF selftest with
> hardening enabled (blinding constants), this has shown to be
> incorrect. For the final pass, when the proper prologue-body-epilogue
> is generated, the image has not converged. This will lead to that the
> final image will have incorrect jump offsets. The following is an
> excerpt from an incorrect image:
>
>   | ...
>   |     3b8:       00c50663                beq     a0,a2,3c4 <.text+0x3c4>
>   |     3bc:       0020e317                auipc   t1,0x20e
>   |     3c0:       49630067                jalr    zero,1174(t1) # 20e852 <.text+0x20e852>
>   | ...
>   |  20e84c:       8796                    c.mv    a5,t0
>   |  20e84e:       6422                    c.ldsp  s0,8(sp)    # Epilogue start
>   |  20e850:       6141                    c.addi16sp      sp,16
>   |  20e852:       853e                    c.mv    a0,a5       # Incorrect jump target
>   |  20e854:       8082                    c.jr    ra
>
> The image has shrunk, and the epilogue offset is incorrect in the
> final pass.
>
> Correct the problem by always generating proper prologue-body-epilogue
> outputs, which means that the first pass will only generate the body
> to track what registers that are touched.
>
> Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  arch/riscv/net/bpf_jit.h      |  6 +++---
>  arch/riscv/net/bpf_jit_core.c | 19 +++++++++++++------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index bf9802a63061..2717f5490428 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -69,7 +69,7 @@ struct rv_jit_context {
>  	struct bpf_prog *prog;
>  	u16 *insns;		/* RV insns */
>  	int ninsns;
> -	int body_len;
> +	int prologue_len;
>  	int epilogue_offset;
>  	int *offset;		/* BPF to RV */
>  	int nexentries;
> @@ -216,8 +216,8 @@ static inline int rv_offset(int insn, int off, struct rv_jit_context *ctx)
>  	int from, to;
>
>  	off++; /* BPF branch is from PC+1, RV is from PC */
> -	from = (insn > 0) ? ctx->offset[insn - 1] : 0;
> -	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : 0;
> +	from = (insn > 0) ? ctx->offset[insn - 1] : ctx->prologue_len;
> +	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : ctx->prologue_len;
>  	return ninsns_rvoff(to - from);
>  }
>
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index 737baf8715da..7a26a3e1c73c 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -44,7 +44,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	unsigned int prog_size = 0, extable_size = 0;
>  	bool tmp_blinded = false, extra_pass = false;
>  	struct bpf_prog *tmp, *orig_prog = prog;
> -	int pass = 0, prev_ninsns = 0, prologue_len, i;
> +	int pass = 0, prev_ninsns = 0, i;
>  	struct rv_jit_data *jit_data;
>  	struct rv_jit_context *ctx;
>
> @@ -83,6 +83,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		prog = orig_prog;
>  		goto out_offset;
>  	}
> +
> +	if (build_body(ctx, extra_pass, NULL)) {
> +		prog = orig_prog;
> +		goto out_offset;
> +	}
> +
>  	for (i = 0; i < prog->len; i++) {
>  		prev_ninsns += 32;
>  		ctx->offset[i] = prev_ninsns;
> @@ -91,12 +97,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
>  		pass++;
>  		ctx->ninsns = 0;
> +
> +		bpf_jit_build_prologue(ctx);
> +		ctx->prologue_len = ctx->ninsns;
> +
>  		if (build_body(ctx, extra_pass, ctx->offset)) {
>  			prog = orig_prog;
>  			goto out_offset;
>  		}
> -		ctx->body_len = ctx->ninsns;
> -		bpf_jit_build_prologue(ctx);
> +
>  		ctx->epilogue_offset = ctx->ninsns;
>  		bpf_jit_build_epilogue(ctx);
>
> @@ -162,10 +171,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>
>  	if (!prog->is_func || extra_pass) {
>  		bpf_jit_binary_lock_ro(jit_data->header);
> -		prologue_len = ctx->epilogue_offset - ctx->body_len;
>  		for (i = 0; i < prog->len; i++)
> -			ctx->offset[i] = ninsns_rvoff(prologue_len +
> -						      ctx->offset[i]);
> +			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
>  		bpf_prog_fill_jited_linfo(prog, ctx->offset);
>  out_offset:
>  		kfree(ctx->offset);
>
> base-commit: 496720b7cfb6574a8f6f4d434f23e3d1e6cfaeb9

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

I'm assuming this is aimed at the BPF tree, but LMK if you guys want me 
to pick it up -- I've already got something for this week, so it's easy 
on my end.  I'm dropping it from my queue and patchwork for now, though.

Thanks for the fix!
