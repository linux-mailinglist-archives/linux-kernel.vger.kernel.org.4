Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40225FEB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJNI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJNI6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8745B14EC4B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CE6961A3E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8999DC433B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665737900;
        bh=jjLpNiBtYUiuOX7cnEKMRg+pshJMGQgSYBE4bgVEUIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ef/3XGuFVgUUNlF1CkC9qw6I+JqB7jQOVfGbhBOLpsl16VCmb+d514fxn2DpzYxYw
         Hhu1A//L1dLqw7XGRdb56GabTHhDqRenlZuu1NDOJGFF2hYXqGeJ1UGfGUJfUi8Sgm
         TUq4penAHlqQd3dzB2WFLy106LhHP4CyzkufCQlfNZ1WZKkUs0JxdeiNYRG6LPYUsb
         F29ddHnA8qvS8HAxWpp/8aP29DE3qSjhRp11k3ckiLm4KB2cbNcomxWJO6KyFfENK+
         gNjueg6UgkvaCLQ+8lHAY3BBffrIMGrCK6ToL4MxNMl0GCtgd0/jxr1CoehvVcM8TJ
         5TBrLZ+79Fvlg==
Received: by mail-ed1-f41.google.com with SMTP id e18so5946240edj.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:58:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Wcyo/ebMvbPlXRse3T6NhQJMeIXiuwsm9pdpMi0qqxAIMtcSy
        zuD8OWOa/wQ2qtMtBarS0y6tdYrRbRexFYT2JlE=
X-Google-Smtp-Source: AMsMyM4wO+ShrjWkuHUfgMw2Cp3IocIUPMPT5y53aZgRfsRMZolMats/QrCYYwSZQffgVQDjZqisQCwpWV6Z3z2l3c4=
X-Received: by 2002:aa7:d4d9:0:b0:45c:7eae:d8d8 with SMTP id
 t25-20020aa7d4d9000000b0045c7eaed8d8mr3411632edr.254.1665737898655; Fri, 14
 Oct 2022 01:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221013154000.3462836-1-chenhuacai@loongson.cn>
 <8a8fa581-94a9-649d-8c01-f1afd4bc9514@xen0n.name> <CAAhV-H5U1c_wfWLuxMaHD6c9-k+g-iSqgtcJVwceoL13J7hEiA@mail.gmail.com>
 <ae6260e5-0eb6-a615-7032-6481cd186f3f@loongson.cn>
In-Reply-To: <ae6260e5-0eb6-a615-7032-6481cd186f3f@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 14 Oct 2022 16:58:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4H5x=XmShR7s_=bwTE8mN37QTt7t8QRaYy1i3oYQKWgw@mail.gmail.com>
Message-ID: <CAAhV-H4H5x=XmShR7s_=bwTE8mN37QTt7t8QRaYy1i3oYQKWgw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: BPF: Avoid declare variables in switch-case
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:18 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 10/14/2022 09:13 AM, Huacai Chen wrote:
> > Hi, Xuerui,
> >
> > On Fri, Oct 14, 2022 at 12:43 AM WANG Xuerui <kernel@xen0n.name> wrote:
> >>
> >> On 10/13/22 23:40, Huacai Chen wrote:
> >>> Not all compilers support declare variables in switch-case, so move
> >>> declarations to the beginning of a function. Otherwise we may get such
> >>> build errors:
>
> ...
>
> >>>
> >>>   static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
> >>>   {
> >>> -     const bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
> >>> -                       BPF_CLASS(insn->code) == BPF_JMP32;
> >>> +     u8 t0 = -1;
> >> Here "t0" seems to be a versatile temp value, while the "t1" below is
> >> the actual GPR $t1. What about renaming "t0" to something like "tmp" to
> >> reduce confusion? I believe due to things like "t0 = LOONGARCH_GPR_ZERO"
> >> the "t0" is 100% not an actual mapping to $t0.
> > I rename t7 to t0 because there is no t3-t6, t7 looks very strange.
> > But from emit_cond_jmp() the 3rd and 4th parameters have no difference
> > so I suppose t0 is just OK, then whether rename it to tmp depends on
> > Tiezhu's opinion.
> >
>
> Use "tmp" seems better due to it is a temp value.
OK, then I will use tmp or just tm for alignment.

>
> >>> +     u64 func_addr;
> >>> +     bool func_addr_fixed;
> >>> +     int i = insn - ctx->prog->insnsi;
> >>> +     int ret, jmp_offset;
> >>>       const u8 code = insn->code;
> >>>       const u8 cond = BPF_OP(code);
> >>>       const u8 t1 = LOONGARCH_GPR_T1;
> >>> @@ -400,8 +402,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
> >>>       const u8 dst = regmap[insn->dst_reg];
> >>>       const s16 off = insn->off;
> >>>       const s32 imm = insn->imm;
> >>> -     int jmp_offset;
> >>> -     int i = insn - ctx->prog->insnsi;
> >>> +     const u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
> >>> +     const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
> >> Please consider reducing diff damage and not touching parts not directly
> >> affected by this change. For example this "is32" declaration and
> >> initialization was moved although not related to this change.
>
> It looks reasonable, one change per patch is better.
>
> > I think defining variables from simple to complex and grouping them
> > can make life easier. :)
> >
>
> No strong opinion on this, I am OK either way.
>
> Thanks,
> Tiezhu
>
>
