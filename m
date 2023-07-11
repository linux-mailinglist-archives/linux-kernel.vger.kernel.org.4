Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC01074F8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjGKUHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGKUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:07:38 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800921710
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:07:36 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3466725f0beso10301935ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1689106056; x=1691698056;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7TG1lUj0yJWDC5b+2n3oNphhdUmDaepbVWboQ5kMxE=;
        b=Eb1w8ReYUnJelgvbnGD4EywSbvbMPEAuj/XVCUCFp5PSuJpPBxkYmxDqnS8XaOBy6l
         JaxlTH2+vK23MB8MpLTQQA2M6NcCIYdFSpeyt9LAmN4XpUFD3G1GfnnvFIltR8l2kRFM
         N5tuokQflFtLoa5tybN9tOHUSyj5TReRMI71qwpaVQNg3GG84uRGQR+5/BJT4Ud35IhF
         GXqsIxQjwJuKzEpgtZ6xVQzF8bGzctmoWXmVELD1ainWZs1QHnN44AkJiJ28FUi6h+FE
         d57lQb+RIV9/1t6QHGtdurqt8QJJMYdhjrFoSqMbP6rPXu2rDFzXJXBkKvPNOb6FNDrt
         9AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689106056; x=1691698056;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7TG1lUj0yJWDC5b+2n3oNphhdUmDaepbVWboQ5kMxE=;
        b=R7UdmkZGNMas7uZA6irflJw5Ft4JWxi0BBTxtSzyJxHYWJ28LQhOhUmKP9y/Hual1a
         D2+4cBriC+sUNITDKARK7Z027BdT/muveDP0TH6Md4d3bIjrigEF1x44u0+pGZGYTUJ8
         hEI65SjBmhWEz/lYRcZ4ZYgIfVin8XHC5HFnkZONY92Rr+T+B/wigDAPdIhPygdIaygc
         x3yA+lfMGbGOtbHn+SnnW94PuKvvHS5PfIOi8EC8gSsbQ0vZtxZsWul8Q1A5j9s1rDHn
         cd4qzR3OO+EVo6X6oXLijX7jhqLfLpBBeE42LyqNwlhmJgPURQp3SHmf037P4Lqpy5nG
         TGJg==
X-Gm-Message-State: ABy/qLYsGAuBguK5ane9neQjKmP4DjejoP00rcKAefaTBo8EvoUx/CXU
        /6G1OgnOwXXW9GpgUTKCJGItDw==
X-Google-Smtp-Source: APBJJlHH/A0ynEPhulRc0XOXsfd8vCwRXOP8X4iPwibR6XfghVL81TfEMun2W6skCVBnX6vWXsq+TQ==
X-Received: by 2002:a92:dac7:0:b0:346:732f:2d20 with SMTP id o7-20020a92dac7000000b00346732f2d20mr2606616ilq.2.1689106055732;
        Tue, 11 Jul 2023 13:07:35 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090a960200b00262e9fbd5fbsm8416378pjo.32.2023.07.11.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:07:35 -0700 (PDT)
Date:   Tue, 11 Jul 2023 13:07:35 -0700 (PDT)
X-Google-Original-Date: Tue, 11 Jul 2023 13:06:45 PDT (-0700)
Subject:     Re: [PATCH bpf] riscv, bpf: Fix inconsistent JIT image generation
In-Reply-To: <830ab76b-ea2a-d522-73f9-b9392aecd0a4@iogearbox.net>
CC:     bjorn@kernel.org, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Topel <bjorn@rivosinc.com>, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, pulehui@huawei.com, luke.r.nels@gmail.com,
        xi.wang@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     daniel@iogearbox.net
Message-ID: <mhng-23e85b35-238d-4274-b1b2-aed4a7f9a600@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 13:03:47 PDT (-0700), daniel@iogearbox.net wrote:
> On 7/11/23 7:50 PM, Palmer Dabbelt wrote:
>> On Mon, 10 Jul 2023 00:41:31 PDT (-0700), bjorn@kernel.org wrote:
>>> From: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
>>>
>>> In order to generate the prologue and epilogue, the BPF JIT needs to
>>> know which registers that are clobbered. Therefore, the during
>>> pre-final passes, the prologue is generated after the body of the
>>> program body-prologue-epilogue. Then, in the final pass, a proper
>>> prologue-body-epilogue JITted image is generated.
>>>
>>> This scheme has worked most of the time. However, for some large
>>> programs with many jumps, e.g. the test_kmod.sh BPF selftest with
>>> hardening enabled (blinding constants), this has shown to be
>>> incorrect. For the final pass, when the proper prologue-body-epilogue
>>> is generated, the image has not converged. This will lead to that the
>>> final image will have incorrect jump offsets. The following is an
>>> excerpt from an incorrect image:
>>>
>>>    | ...
>>>    |     3b8:       00c50663                beq     a0,a2,3c4 <.text+0x3c4>
>>>    |     3bc:       0020e317                auipc   t1,0x20e
>>>    |     3c0:       49630067                jalr    zero,1174(t1) # 20e852 <.text+0x20e852>
>>>    | ...
>>>    |  20e84c:       8796                    c.mv    a5,t0
>>>    |  20e84e:       6422                    c.ldsp  s0,8(sp)    # Epilogue start
>>>    |  20e850:       6141                    c.addi16sp      sp,16
>>>    |  20e852:       853e                    c.mv    a0,a5       # Incorrect jump target
>>>    |  20e854:       8082                    c.jr    ra
>>>
>>> The image has shrunk, and the epilogue offset is incorrect in the
>>> final pass.
>>>
>>> Correct the problem by always generating proper prologue-body-epilogue
>>> outputs, which means that the first pass will only generate the body
>>> to track what registers that are touched.
>>>
>>> Fixes: 2353ecc6f91f ("bpf, riscv: add BPF JIT for RV64G")
>>> Signed-off-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
>>> ---
>>>   arch/riscv/net/bpf_jit.h      |  6 +++---
>>>   arch/riscv/net/bpf_jit_core.c | 19 +++++++++++++------
>>>   2 files changed, 16 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>>> index bf9802a63061..2717f5490428 100644
>>> --- a/arch/riscv/net/bpf_jit.h
>>> +++ b/arch/riscv/net/bpf_jit.h
>>> @@ -69,7 +69,7 @@ struct rv_jit_context {
>>>   	struct bpf_prog *prog;
>>>   	u16 *insns;		/* RV insns */
>>>   	int ninsns;
>>> -	int body_len;
>>> +	int prologue_len;
>>>   	int epilogue_offset;
>>>   	int *offset;		/* BPF to RV */
>>>   	int nexentries;
>>> @@ -216,8 +216,8 @@ static inline int rv_offset(int insn, int off, struct rv_jit_context *ctx)
>>>   	int from, to;
>>>
>>>   	off++; /* BPF branch is from PC+1, RV is from PC */
>>> -	from = (insn > 0) ? ctx->offset[insn - 1] : 0;
>>> -	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : 0;
>>> +	from = (insn > 0) ? ctx->offset[insn - 1] : ctx->prologue_len;
>>> +	to = (insn + off > 0) ? ctx->offset[insn + off - 1] : ctx->prologue_len;
>>>   	return ninsns_rvoff(to - from);
>>>   }
>>>
>>> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
>>> index 737baf8715da..7a26a3e1c73c 100644
>>> --- a/arch/riscv/net/bpf_jit_core.c
>>> +++ b/arch/riscv/net/bpf_jit_core.c
>>> @@ -44,7 +44,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>   	unsigned int prog_size = 0, extable_size = 0;
>>>   	bool tmp_blinded = false, extra_pass = false;
>>>   	struct bpf_prog *tmp, *orig_prog = prog;
>>> -	int pass = 0, prev_ninsns = 0, prologue_len, i;
>>> +	int pass = 0, prev_ninsns = 0, i;
>>>   	struct rv_jit_data *jit_data;
>>>   	struct rv_jit_context *ctx;
>>>
>>> @@ -83,6 +83,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>   		prog = orig_prog;
>>>   		goto out_offset;
>>>   	}
>>> +
>>> +	if (build_body(ctx, extra_pass, NULL)) {
>>> +		prog = orig_prog;
>>> +		goto out_offset;
>>> +	}
>>> +
>>>   	for (i = 0; i < prog->len; i++) {
>>>   		prev_ninsns += 32;
>>>   		ctx->offset[i] = prev_ninsns;
>>> @@ -91,12 +97,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>   	for (i = 0; i < NR_JIT_ITERATIONS; i++) {
>>>   		pass++;
>>>   		ctx->ninsns = 0;
>>> +
>>> +		bpf_jit_build_prologue(ctx);
>>> +		ctx->prologue_len = ctx->ninsns;
>>> +
>>>   		if (build_body(ctx, extra_pass, ctx->offset)) {
>>>   			prog = orig_prog;
>>>   			goto out_offset;
>>>   		}
>>> -		ctx->body_len = ctx->ninsns;
>>> -		bpf_jit_build_prologue(ctx);
>>> +
>>>   		ctx->epilogue_offset = ctx->ninsns;
>>>   		bpf_jit_build_epilogue(ctx);
>>>
>>> @@ -162,10 +171,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>
>>>   	if (!prog->is_func || extra_pass) {
>>>   		bpf_jit_binary_lock_ro(jit_data->header);
>>> -		prologue_len = ctx->epilogue_offset - ctx->body_len;
>>>   		for (i = 0; i < prog->len; i++)
>>> -			ctx->offset[i] = ninsns_rvoff(prologue_len +
>>> -						      ctx->offset[i]);
>>> +			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
>>>   		bpf_prog_fill_jited_linfo(prog, ctx->offset);
>>>   out_offset:
>>>   		kfree(ctx->offset);
>>>
>>> base-commit: 496720b7cfb6574a8f6f4d434f23e3d1e6cfaeb9
>>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> I'm assuming this is aimed at the BPF tree, but LMK if you guys want me
>> to pick it up -- I've already got something for this week, so it's easy
>> on my end.  I'm dropping it from my queue and patchwork for now, though.
>
> Sounds good, we applied it to bpf already.

Thanks!

>
> Thanks,
> Daniel
