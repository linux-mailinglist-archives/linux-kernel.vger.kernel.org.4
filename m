Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142CB629366
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiKOImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiKOImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB495582
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:42:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A7E56155A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E34AC433D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668501728;
        bh=kvBS09XpTJEIyHfHC9MG/ZaSti9KUsIt1TDs3aHvIqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I/m6OT8hKBUPSJsly2xf44L6xj8KiD2maeIoa+VsRAAzmbAzv7InCJoR27pSL/LNe
         S7MxF67gUPyQPaCXqDbCLqJwVLmKZAb8XZdYhWXVsAcHQKr1EtIDW6CpGcyc4803Ug
         apSVxEggl+hkJ2yIy/pmy3qOSqaV555o8prKkzey6L3yINepZIIl5YPcmHdSYjeWfT
         d5pLW2m2OYSlz97u0jxTF9kESNXTuVFgqqI78fXHm6oOW3ifEuxumjffqDY1e1T+Lb
         zMngNvPa5w2Bwz1b256ygrnZDp99lXxB/AJJEbeambTceULp3qCutfqq47TFw18kl1
         Nq8MVIimRhtbw==
Received: by mail-ed1-f53.google.com with SMTP id x102so5625590ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:42:08 -0800 (PST)
X-Gm-Message-State: ANoB5pkgKpX1IyFtYqWW0IwhQMdNRsMsnRZE4RJR21wAN99q9IpnCSm0
        1OmOLjtAhX91HCI8V81OYOhZrw0ELpqRmzCoEFM=
X-Google-Smtp-Source: AA0mqf6khhM0r68FPELDg5hxVyRYNd8WiZk1cCiOsVSeNNe1juNY/zCbEH/R1uZN5PKxUbvJ4PnbkUS0viqxgsWt+jw=
X-Received: by 2002:a05:6402:3715:b0:462:32bf:613a with SMTP id
 ek21-20020a056402371500b0046232bf613amr13654158edb.78.1668501726670; Tue, 15
 Nov 2022 00:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20221115025527.13382-1-zhangqing@loongson.cn> <20221115025527.13382-6-zhangqing@loongson.cn>
In-Reply-To: <20221115025527.13382-6-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 15 Nov 2022 16:41:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ceu-UfSNBEpBJOvOtvuS8hufoiEtjAT1fXdQX+T11Kg@mail.gmail.com>
Message-ID: <CAAhV-H6ceu-UfSNBEpBJOvOtvuS8hufoiEtjAT1fXdQX+T11Kg@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] LoongArch/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Qing,

Patch5 and Patch6 are small and related, maybe they can be combined
with a name "LoongArch/ftrace: Add DYNAMIC_FTRACE_WITH_{ARGS,REGS}
support"

Huacai

On Tue, Nov 15, 2022 at 10:55 AM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> This patch implements DYNAMIC_FTRACE_WITH_REGS on LoongArch, which allows
> a traced function's arguments (and some other registers) to be captured
> into a struct pt_regs, allowing these to be inspected and modified.
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/include/asm/ftrace.h |  3 +++
>  arch/loongarch/kernel/ftrace_dyn.c  | 17 ++++++++++++++
>  arch/loongarch/kernel/mcount-dyn.S  | 36 +++++++++++++++++++++++++++--
>  4 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 615ce62422b8..12e3e91a68ae 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -90,6 +90,7 @@ config LOONGARCH
>         select HAVE_DEBUG_STACKOVERFLOW
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_DYNAMIC_FTRACE
> +       select HAVE_DYNAMIC_FTRACE_WITH_REGS
>         select HAVE_EBPF_JIT
>         select HAVE_EXIT_THREAD
>         select HAVE_FAST_GUP
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 76ca58767f4d..a3f974a7a5ce 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -28,6 +28,9 @@ struct dyn_ftrace;
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>  #define ftrace_init_nop ftrace_init_nop
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#define ARCH_SUPPORTS_FTRACE_OPS 1
> +#endif
>  #endif /* CONFIG_DYNAMIC_FTRACE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_FUNCTION_TRACER */
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index 3fe791b6783e..ec3d951be50c 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -99,6 +99,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>         return ftrace_modify_code(pc, old, new, true);
>  }
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
> +                       unsigned long addr)
> +{
> +       unsigned long pc;
> +       long offset;
> +       u32 old, new;
> +
> +       pc = rec->ip + LOONGARCH_INSN_SIZE;
> +
> +       old = larch_insn_gen_bl(pc, old_addr);
> +       new = larch_insn_gen_bl(pc, addr);
> +
> +       return ftrace_modify_code(pc, old, new, true);
> +}
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
>  void arch_ftrace_update_code(int command)
>  {
>         command |= FTRACE_MAY_SLEEP;
> diff --git a/arch/loongarch/kernel/mcount-dyn.S b/arch/loongarch/kernel/mcount-dyn.S
> index 0c12cc108e6f..02835186b463 100644
> --- a/arch/loongarch/kernel/mcount-dyn.S
> +++ b/arch/loongarch/kernel/mcount-dyn.S
> @@ -27,7 +27,7 @@
>   * follows the LoongArch psABI well.
>   */
>
> -       .macro  ftrace_regs_entry
> +       .macro  ftrace_regs_entry allregs=0
>         PTR_ADDI sp, sp, -PT_SIZE
>         /* Save trace function ra at PT_ERA */
>         PTR_S   ra, sp, PT_ERA
> @@ -43,16 +43,48 @@
>         PTR_S   a7, sp, PT_R11
>         PTR_S   fp, sp, PT_R22
>
> +       .if \allregs
> +       PTR_S   t0, sp, PT_R12
> +       PTR_S   t1, sp, PT_R13
> +       PTR_S   t2, sp, PT_R14
> +       PTR_S   t3, sp, PT_R15
> +       PTR_S   t4, sp, PT_R16
> +       PTR_S   t5, sp, PT_R17
> +       PTR_S   t6, sp, PT_R18
> +       PTR_S   t7, sp, PT_R19
> +       PTR_S   t8, sp, PT_R20
> +       PTR_S   s0, sp, PT_R23
> +       PTR_S   s1, sp, PT_R24
> +       PTR_S   s2, sp, PT_R25
> +       PTR_S   s3, sp, PT_R26
> +       PTR_S   s4, sp, PT_R27
> +       PTR_S   s5, sp, PT_R28
> +       PTR_S   s6, sp, PT_R29
> +       PTR_S   s7, sp, PT_R30
> +       PTR_S   s8, sp, PT_R31
> +       PTR_S   tp, sp, PT_R2
> +       /* Clear it for later use as a flag sometimes. */
> +       PTR_S   zero, sp, PT_R0
> +       PTR_S   $r21, sp, PT_R21
> +       .endif
> +
>         PTR_ADDI t8, sp, PT_SIZE
>         PTR_S   t8, sp, PT_R3
>
>         .endm
>
>  SYM_CODE_START(ftrace_caller)
> -       ftrace_regs_entry
> +       ftrace_regs_entry allregs=0
>         b       ftrace_common
>  SYM_CODE_END(ftrace_caller)
>
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +SYM_CODE_START(ftrace_regs_caller)
> +       ftrace_regs_entry allregs=1
> +       b       ftrace_common
> +SYM_CODE_END(ftrace_regs_caller)
> +#endif
> +
>  SYM_CODE_START(ftrace_common)
>         PTR_ADDI        a0, ra, -8      /* arg0: ip */
>         move            a1, t0          /* arg1: parent_ip */
> --
> 2.36.0
>
>
