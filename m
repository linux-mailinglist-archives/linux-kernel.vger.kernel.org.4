Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3A5FE67B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJNBOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJNBN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F13152C5A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5064D619B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92B8C433D6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665710035;
        bh=Ea/O2fe7nNh2hBCq1sb4Ae1w0AEyb6eHwu15T+O/hxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pYb/V6+i2N5ZkYFhpik6ARi4yTHe4DFWSEv3/dDZJEVmv7XVG7peTGYfNZUXU4r+3
         pz0zT9CIQ+UeFt//6uj6IFSN577zgMSK/wOWnOpFx4S1WK5d9TXotc6MJMRPEUm9Ba
         Lcf3ZMI7p0tYPqS3DUbvL8SMi9JqMz3j2fopN9Omr8JiHfUBKC0yboWa2J712/wOtA
         TVk46E2yCE3kv73MmoCNazz6K6loFJUDscnKHP3rbtnzcsiXd33Oqt0nBGeVxkqFlD
         8N2/BMeCFt7hheBKfzoEB8jNDnnMOl5i4K3/25TeAQCt362c+lGQyvHMohO5Y6qjfK
         BrbAeUtAnaq9Q==
Received: by mail-ed1-f46.google.com with SMTP id m15so4872317edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:13:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf23/UfLfTV88kY9nmHZPUYvjsgYi7mC4RH60hztZ1fh7vB4XTJV
        H1bwcjzBgmSx7+L9cozgnllZyojjGvp6PRlaArM=
X-Google-Smtp-Source: AMsMyM6f1hplivOREauXfRNR5hGJofII9G8IW32fzww/gHjspQVZ9mXvr88kXqREljt2Hx+Kdl6kwQq8+6C634JTvKs=
X-Received: by 2002:aa7:d4d9:0:b0:45c:7eae:d8d8 with SMTP id
 t25-20020aa7d4d9000000b0045c7eaed8d8mr2088640edr.254.1665710033821; Thu, 13
 Oct 2022 18:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221013154000.3462836-1-chenhuacai@loongson.cn> <8a8fa581-94a9-649d-8c01-f1afd4bc9514@xen0n.name>
In-Reply-To: <8a8fa581-94a9-649d-8c01-f1afd4bc9514@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 14 Oct 2022 09:13:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5U1c_wfWLuxMaHD6c9-k+g-iSqgtcJVwceoL13J7hEiA@mail.gmail.com>
Message-ID: <CAAhV-H5U1c_wfWLuxMaHD6c9-k+g-iSqgtcJVwceoL13J7hEiA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Avoid declare variables in switch-case
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Fri, Oct 14, 2022 at 12:43 AM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 10/13/22 23:40, Huacai Chen wrote:
> > Not all compilers support declare variables in switch-case, so move
> > declarations to the beginning of a function. Otherwise we may get such
> > build errors:
> >
> > arch/loongarch/net/bpf_jit.c: In function =E2=80=98emit_atomic=E2=80=99=
:
> > arch/loongarch/net/bpf_jit.c:362:3: error: a label can only be part of =
a statement and a declaration is not a statement
> >     u8 r0 =3D regmap[BPF_REG_0];
> >     ^~
> > arch/loongarch/net/bpf_jit.c: In function =E2=80=98build_insn=E2=80=99:
> > arch/loongarch/net/bpf_jit.c:727:3: error: a label can only be part of =
a statement and a declaration is not a statement
> >     u8 t7 =3D -1;
> >     ^~
> > arch/loongarch/net/bpf_jit.c:778:3: error: a label can only be part of =
a statement and a declaration is not a statement
> >     int ret;
> >     ^~~
> > arch/loongarch/net/bpf_jit.c:779:3: error: expected expression before =
=E2=80=98u64=E2=80=99
> >     u64 func_addr;
> >     ^~~
> > arch/loongarch/net/bpf_jit.c:780:3: warning: ISO C90 forbids mixed decl=
arations and code [-Wdeclaration-after-statement]
> >     bool func_addr_fixed;
> >     ^~~~
> > arch/loongarch/net/bpf_jit.c:784:11: error: =E2=80=98func_addr=E2=80=99=
 undeclared (first use in this function); did you mean =E2=80=98in_addr=E2=
=80=99?
> >            &func_addr, &func_addr_fixed);
> >             ^~~~~~~~~
> >             in_addr
> > arch/loongarch/net/bpf_jit.c:784:11: note: each undeclared identifier i=
s reported only once for each function it appears in
> > arch/loongarch/net/bpf_jit.c:814:3: error: a label can only be part of =
a statement and a declaration is not a statement
> >     u64 imm64 =3D (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
> >     ^~~
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> > ---
> >   arch/loongarch/net/bpf_jit.c | 31 +++++++++++++------------------
> >   1 file changed, 13 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 43f0a98efe38..2a9b590f47e6 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -279,6 +279,7 @@ static void emit_atomic(const struct bpf_insn *insn=
, struct jit_ctx *ctx)
> >       const u8 t1 =3D LOONGARCH_GPR_T1;
> >       const u8 t2 =3D LOONGARCH_GPR_T2;
> >       const u8 t3 =3D LOONGARCH_GPR_T3;
> > +     const u8 r0 =3D regmap[BPF_REG_0];
> >       const u8 src =3D regmap[insn->src_reg];
> >       const u8 dst =3D regmap[insn->dst_reg];
> >       const s16 off =3D insn->off;
> > @@ -359,8 +360,6 @@ static void emit_atomic(const struct bpf_insn *insn=
, struct jit_ctx *ctx)
> >               break;
> >       /* r0 =3D atomic_cmpxchg(dst + off, r0, src); */
> >       case BPF_CMPXCHG:
> > -             u8 r0 =3D regmap[BPF_REG_0];
> > -
> >               move_reg(ctx, t2, r0);
> >               if (isdw) {
> >                       emit_insn(ctx, lld, r0, t1, 0);
> > @@ -390,8 +389,11 @@ static bool is_signed_bpf_cond(u8 cond)
> >
> >   static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ct=
x, bool extra_pass)
> >   {
> > -     const bool is32 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU ||
> > -                       BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> > +     u8 t0 =3D -1;
> Here "t0" seems to be a versatile temp value, while the "t1" below is
> the actual GPR $t1. What about renaming "t0" to something like "tmp" to
> reduce confusion? I believe due to things like "t0 =3D LOONGARCH_GPR_ZERO=
"
> the "t0" is 100% not an actual mapping to $t0.
I rename t7 to t0 because there is no t3-t6, t7 looks very strange.
But from emit_cond_jmp() the 3rd and 4th parameters have no difference
so I suppose t0 is just OK, then whether rename it to tmp depends on
Tiezhu's opinion.

> > +     u64 func_addr;
> > +     bool func_addr_fixed;
> > +     int i =3D insn - ctx->prog->insnsi;
> > +     int ret, jmp_offset;
> >       const u8 code =3D insn->code;
> >       const u8 cond =3D BPF_OP(code);
> >       const u8 t1 =3D LOONGARCH_GPR_T1;
> > @@ -400,8 +402,8 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >       const u8 dst =3D regmap[insn->dst_reg];
> >       const s16 off =3D insn->off;
> >       const s32 imm =3D insn->imm;
> > -     int jmp_offset;
> > -     int i =3D insn - ctx->prog->insnsi;
> > +     const u64 imm64 =3D (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
> > +     const bool is32 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU || BPF_C=
LASS(insn->code) =3D=3D BPF_JMP32;
> Please consider reducing diff damage and not touching parts not directly
> affected by this change. For example this "is32" declaration and
> initialization was moved although not related to this change.
I think defining variables from simple to complex and grouping them
can make life easier. :)

Huacai
> >
> >       switch (code) {
> >       /* dst =3D src */
> > @@ -724,24 +726,23 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >       case BPF_JMP32 | BPF_JSGE | BPF_K:
> >       case BPF_JMP32 | BPF_JSLT | BPF_K:
> >       case BPF_JMP32 | BPF_JSLE | BPF_K:
> > -             u8 t7 =3D -1;
> >               jmp_offset =3D bpf2la_offset(i, off, ctx);
> >               if (imm) {
> >                       move_imm(ctx, t1, imm, false);
> > -                     t7 =3D t1;
> > +                     t0 =3D t1;
> >               } else {
> >                       /* If imm is 0, simply use zero register. */
> > -                     t7 =3D LOONGARCH_GPR_ZERO;
> > +                     t0 =3D LOONGARCH_GPR_ZERO;
> >               }
> >               move_reg(ctx, t2, dst);
> >               if (is_signed_bpf_cond(BPF_OP(code))) {
> > -                     emit_sext_32(ctx, t7, is32);
> > +                     emit_sext_32(ctx, t0, is32);
> >                       emit_sext_32(ctx, t2, is32);
> >               } else {
> > -                     emit_zext_32(ctx, t7, is32);
> > +                     emit_zext_32(ctx, t0, is32);
> >                       emit_zext_32(ctx, t2, is32);
> >               }
> > -             if (emit_cond_jmp(ctx, cond, t2, t7, jmp_offset) < 0)
> > +             if (emit_cond_jmp(ctx, cond, t2, t0, jmp_offset) < 0)
> >                       goto toofar;
> >               break;
> >
> > @@ -775,10 +776,6 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
> >
> >       /* function call */
> >       case BPF_JMP | BPF_CALL:
> > -             int ret;
> > -             u64 func_addr;
> > -             bool func_addr_fixed;
> > -
> >               mark_call(ctx);
> >               ret =3D bpf_jit_get_func_addr(ctx->prog, insn, extra_pass=
,
> >                                           &func_addr, &func_addr_fixed)=
;
> > @@ -811,8 +808,6 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >
> >       /* dst =3D imm64 */
> >       case BPF_LD | BPF_IMM | BPF_DW:
> > -             u64 imm64 =3D (u64)(insn + 1)->imm << 32 | (u32)insn->imm=
;
> > -
> >               move_imm(ctx, dst, imm64, is32);
> >               return 1;
> >
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
