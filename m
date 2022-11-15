Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39623629440
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiKOJYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKOJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:24:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9847A23A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3226B6158A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9211DC43470
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668504285;
        bh=VBBU8gt7nZhNcPeyVFy69+oCNGNi0pwrFFJfnV8uazM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jv23gyuWdVE5zCZ/txQLBAPbv/UHL1/phqmNDSdbifXtuXca+uGnQjrrCoIabFt8O
         DRZF5Ar/XW5O9OTXmHbKK/iR3FOjTMMDC2eI2cQHLZ44xmySNFJSjA59FCLlL48g4g
         CmjZoK6iV+M3fr+AEe+bzfX+wO01gKOAQY2uFbf5btxU2jW5xnJyIX/eEDnKKQ8nq0
         h12xRvHFP0HWW20yEf0leGPLO6UtYUKiilJuJoKdffJmYHmgriq12FN6NXkFqsGJXp
         UgMdUsvEhPbTlHS4kUIjmgxuEUdVWuoTLcnXCuZZKNS1BNEF6b/eGHOz6ZIVlwWccp
         T7y4v78qM5Sdw==
Received: by mail-ej1-f44.google.com with SMTP id t25so34495775ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:24:45 -0800 (PST)
X-Gm-Message-State: ANoB5plNL1xxLTZF1qXPrv7hSL3UQDtoQqo1/1cHyybaB06bx+O8mrUc
        T/DxPyRuK4iv72F7FMa0LmO6VQlFufwYez9E/Zk=
X-Google-Smtp-Source: AA0mqf4f9TQK/hLr5g0dDsD2+nHOPaHzvprm8DI9Jy2sb8waTNGQQPu+9QHzknWw/tldYnuUwHQFXfA2EIgc37PVnAI=
X-Received: by 2002:a17:906:f113:b0:78d:addf:67c1 with SMTP id
 gv19-20020a170906f11300b0078daddf67c1mr13041697ejb.272.1668504283706; Tue, 15
 Nov 2022 01:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20221115025527.13382-1-zhangqing@loongson.cn> <20221115025527.13382-6-zhangqing@loongson.cn>
 <CAAhV-H6ceu-UfSNBEpBJOvOtvuS8hufoiEtjAT1fXdQX+T11Kg@mail.gmail.com> <1288f936-7e43-592a-8061-d9df94573c4d@loongson.cn>
In-Reply-To: <1288f936-7e43-592a-8061-d9df94573c4d@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 15 Nov 2022 17:24:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H62-QSXjxOQK8ZJqBgJv2xX7UU_6OC275hRzG0Ou03xRA@mail.gmail.com>
Message-ID: <CAAhV-H62-QSXjxOQK8ZJqBgJv2xX7UU_6OC275hRzG0Ou03xRA@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] LoongArch/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>
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

On Tue, Nov 15, 2022 at 5:22 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Hi, Huacai
>
> On 2022/11/15 =E4=B8=8B=E5=8D=884:41, Huacai Chen wrote:
> > Hi, Qing,
> >
> > Patch5 and Patch6 are small and related, maybe they can be combined
> > with a name "LoongArch/ftrace: Add DYNAMIC_FTRACE_WITH_{ARGS,REGS}
> > support"
> I think they should be independent due to different use scenarios.
From the commit message it seems  DYNAMIC_FTRACE_WITH_ARGS depend on
DYNAMIC_FTRACE_WITH_REGS.

Huacai
>
> Thanks,
> -Qing
> >
> > Huacai
> >
> > On Tue, Nov 15, 2022 at 10:55 AM Qing Zhang <zhangqing@loongson.cn> wro=
te:
> >>
> >> This patch implements DYNAMIC_FTRACE_WITH_REGS on LoongArch, which all=
ows
> >> a traced function's arguments (and some other registers) to be capture=
d
> >> into a struct pt_regs, allowing these to be inspected and modified.
> >>
> >> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> >> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> >> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> >> ---
> >>   arch/loongarch/Kconfig              |  1 +
> >>   arch/loongarch/include/asm/ftrace.h |  3 +++
> >>   arch/loongarch/kernel/ftrace_dyn.c  | 17 ++++++++++++++
> >>   arch/loongarch/kernel/mcount-dyn.S  | 36 +++++++++++++++++++++++++++=
--
> >>   4 files changed, 55 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index 615ce62422b8..12e3e91a68ae 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -90,6 +90,7 @@ config LOONGARCH
> >>          select HAVE_DEBUG_STACKOVERFLOW
> >>          select HAVE_DMA_CONTIGUOUS
> >>          select HAVE_DYNAMIC_FTRACE
> >> +       select HAVE_DYNAMIC_FTRACE_WITH_REGS
> >>          select HAVE_EBPF_JIT
> >>          select HAVE_EXIT_THREAD
> >>          select HAVE_FAST_GUP
> >> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/incl=
ude/asm/ftrace.h
> >> index 76ca58767f4d..a3f974a7a5ce 100644
> >> --- a/arch/loongarch/include/asm/ftrace.h
> >> +++ b/arch/loongarch/include/asm/ftrace.h
> >> @@ -28,6 +28,9 @@ struct dyn_ftrace;
> >>   int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> >>   #define ftrace_init_nop ftrace_init_nop
> >>
> >> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> >> +#endif
> >>   #endif /* CONFIG_DYNAMIC_FTRACE */
> >>   #endif /* __ASSEMBLY__ */
> >>   #endif /* CONFIG_FUNCTION_TRACER */
> >> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kerne=
l/ftrace_dyn.c
> >> index 3fe791b6783e..ec3d951be50c 100644
> >> --- a/arch/loongarch/kernel/ftrace_dyn.c
> >> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> >> @@ -99,6 +99,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_=
ftrace *rec,
> >>          return ftrace_modify_code(pc, old, new, true);
> >>   }
> >>
> >> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr=
,
> >> +                       unsigned long addr)
> >> +{
> >> +       unsigned long pc;
> >> +       long offset;
> >> +       u32 old, new;
> >> +
> >> +       pc =3D rec->ip + LOONGARCH_INSN_SIZE;
> >> +
> >> +       old =3D larch_insn_gen_bl(pc, old_addr);
> >> +       new =3D larch_insn_gen_bl(pc, addr);
> >> +
> >> +       return ftrace_modify_code(pc, old, new, true);
> >> +}
> >> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >> +
> >>   void arch_ftrace_update_code(int command)
> >>   {
> >>          command |=3D FTRACE_MAY_SLEEP;
> >> diff --git a/arch/loongarch/kernel/mcount-dyn.S b/arch/loongarch/kerne=
l/mcount-dyn.S
> >> index 0c12cc108e6f..02835186b463 100644
> >> --- a/arch/loongarch/kernel/mcount-dyn.S
> >> +++ b/arch/loongarch/kernel/mcount-dyn.S
> >> @@ -27,7 +27,7 @@
> >>    * follows the LoongArch psABI well.
> >>    */
> >>
> >> -       .macro  ftrace_regs_entry
> >> +       .macro  ftrace_regs_entry allregs=3D0
> >>          PTR_ADDI sp, sp, -PT_SIZE
> >>          /* Save trace function ra at PT_ERA */
> >>          PTR_S   ra, sp, PT_ERA
> >> @@ -43,16 +43,48 @@
> >>          PTR_S   a7, sp, PT_R11
> >>          PTR_S   fp, sp, PT_R22
> >>
> >> +       .if \allregs
> >> +       PTR_S   t0, sp, PT_R12
> >> +       PTR_S   t1, sp, PT_R13
> >> +       PTR_S   t2, sp, PT_R14
> >> +       PTR_S   t3, sp, PT_R15
> >> +       PTR_S   t4, sp, PT_R16
> >> +       PTR_S   t5, sp, PT_R17
> >> +       PTR_S   t6, sp, PT_R18
> >> +       PTR_S   t7, sp, PT_R19
> >> +       PTR_S   t8, sp, PT_R20
> >> +       PTR_S   s0, sp, PT_R23
> >> +       PTR_S   s1, sp, PT_R24
> >> +       PTR_S   s2, sp, PT_R25
> >> +       PTR_S   s3, sp, PT_R26
> >> +       PTR_S   s4, sp, PT_R27
> >> +       PTR_S   s5, sp, PT_R28
> >> +       PTR_S   s6, sp, PT_R29
> >> +       PTR_S   s7, sp, PT_R30
> >> +       PTR_S   s8, sp, PT_R31
> >> +       PTR_S   tp, sp, PT_R2
> >> +       /* Clear it for later use as a flag sometimes. */
> >> +       PTR_S   zero, sp, PT_R0
> >> +       PTR_S   $r21, sp, PT_R21
> >> +       .endif
> >> +
> >>          PTR_ADDI t8, sp, PT_SIZE
> >>          PTR_S   t8, sp, PT_R3
> >>
> >>          .endm
> >>
> >>   SYM_CODE_START(ftrace_caller)
> >> -       ftrace_regs_entry
> >> +       ftrace_regs_entry allregs=3D0
> >>          b       ftrace_common
> >>   SYM_CODE_END(ftrace_caller)
> >>
> >> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> >> +SYM_CODE_START(ftrace_regs_caller)
> >> +       ftrace_regs_entry allregs=3D1
> >> +       b       ftrace_common
> >> +SYM_CODE_END(ftrace_regs_caller)
> >> +#endif
> >> +
> >>   SYM_CODE_START(ftrace_common)
> >>          PTR_ADDI        a0, ra, -8      /* arg0: ip */
> >>          move            a1, t0          /* arg1: parent_ip */
> >> --
> >> 2.36.0
> >>
> >>
>
>
