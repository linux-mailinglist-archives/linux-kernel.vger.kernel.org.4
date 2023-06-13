Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF21772DCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbjFMItI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbjFMItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:49:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F923C9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B71FD62ED2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CFCC433A4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686646141;
        bh=fkTcYXnnODoZaFJg2UKlm/SmZquUIwJqB4u8HHmm8ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TtFhoaMdqFjIV3nG0qPhO2EodgKhv45BGHccH3vrptUTN3vESLcz1S9aQAUCGKG0N
         0Va5HNoW3m+yunDDXKLLF8nwhI7aH/to9whdsmLj/oqpE4nyWvdAf/6XfyqBqqjkmt
         DFPt3yzPgEgD4N2i9zc4122BmeHMn+dUHJDQxmlG4yS9FJoKCFGXpiRAal7EiCZ+GQ
         EWfx7bC8WNuJvtJO6DEfux0t5NF/BO4HiBXxP1r16IcZCw3byXQ3+RonMakJ1dFOvI
         Z3TjwUVRtXAJ/Z9Bltn+gfiros4ycBcFry3nAwM+cswfYTEZgEow12SgFcCYfg34ZQ
         sS8FoLUJh4MDQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-97458c97333so875861166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:49:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDzd29KYBN21fvTqgvU5afZt/OxcLUMjFyX/gR6zqJ+F1thSXI9b
        hoP+Karwgufe3cemlwskHp/dX78QkGUr7KTkChY=
X-Google-Smtp-Source: ACHHUZ6wp2VuzDoDQ87Zc1LbXPtFM+HS9UxKOtKze/Q5AN9sFsbjTss1ZjX9wT+MsT0Ffb0o+nfyB77zVAbzKfQ1HsM=
X-Received: by 2002:a17:907:1c03:b0:96f:32ae:a7e1 with SMTP id
 nc3-20020a1709071c0300b0096f32aea7e1mr12562187ejc.63.1686646139188; Tue, 13
 Jun 2023 01:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230613011439.59168-1-jianghaoran@kylinos.cn> <20230613060329.356201-1-jianghaoran@kylinos.cn>
In-Reply-To: <20230613060329.356201-1-jianghaoran@kylinos.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 13 Jun 2023 16:48:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Fz59Wmmu9Y0TQS18uw4UfEGg_J+Xj_gX46MhvF1C-MA@mail.gmail.com>
Message-ID: <CAAhV-H7Fz59Wmmu9Y0TQS18uw4UfEGg_J+Xj_gX46MhvF1C-MA@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/rethook: Replace kretprobe with rethook on LoongArch
To:     Haoran Jiang <jianghaoran@kylinos.cn>
Cc:     conor.dooley@microchip.com, hejinyang@loongson.cn, jhrhhao@163.com,
        kernel@xen0n.name, l3b2w1@gmail.com, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, masahiroy@kernel.org,
        mhiramat@kernel.org, palmer@rivosinc.com, tangyouling@loongson.cn,
        yangtiezhu@loongson.cn, zhangqing@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 2:09=E2=80=AFPM Haoran Jiang <jianghaoran@kylinos.c=
n> wrote:
>
> That's an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> Replace kretprobe with rethook on x86")and commit b57c2f124098
> ("riscv: add riscv rethook implementation") to LoongArch.
> Mainly refer to this commit
> b57c2f124098 ("riscv: add riscv rethook implementation").
>
> Replaces the kretprobe code with rethook on LoongArch. With this patch,
> kretprobe on LoongArch uses the rethook instead of kretprobe specific
> trampoline code.
>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
>
> ---
> v3:
> 1,Fixed some format and spelling issues
> 2,According to this commit 571a2a50a8fc
> (rethook, fprobe: do not trace rethook related functions),
> the problem described in this commit Should be modified on LoongArch.
>
> v2:
> Modified the patch format and commit message.
> ---
>  arch/loongarch/Kconfig                        |  1 +
>  arch/loongarch/include/asm/kprobes.h          |  3 ---
>  arch/loongarch/kernel/Makefile                |  7 ++++-
>  arch/loongarch/kernel/kprobes.c               | 20 --------------
>  arch/loongarch/kernel/rethook.c               | 27 +++++++++++++++++++
>  arch/loongarch/kernel/rethook.h               |  8 ++++++
>  ...obes_trampoline.S =3D> rethook_trampoline.S} |  6 ++---
>  7 files changed, 45 insertions(+), 27 deletions(-)
>  create mode 100644 arch/loongarch/kernel/rethook.c
>  create mode 100644 arch/loongarch/kernel/rethook.h
>  rename arch/loongarch/kernel/{kprobes_trampoline.S =3D> rethook_trampoli=
ne.S} (93%)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931..5800aa52c82f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -120,6 +120,7 @@ config LOONGARCH
>         select HAVE_PERF_REGS
>         select HAVE_PERF_USER_STACK_DUMP
>         select HAVE_REGS_AND_STACK_ACCESS_API
> +       select HAVE_RETHOOK
>         select HAVE_RSEQ
>         select HAVE_SAMPLE_FTRACE_DIRECT
>         select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/includ=
e/asm/kprobes.h
> index 798020ae02c6..7b9fc3ed71c3 100644
> --- a/arch/loongarch/include/asm/kprobes.h
> +++ b/arch/loongarch/include/asm/kprobes.h
> @@ -49,9 +49,6 @@ bool kprobe_fault_handler(struct pt_regs *regs, int tra=
pnr);
>  bool kprobe_breakpoint_handler(struct pt_regs *regs);
>  bool kprobe_singlestep_handler(struct pt_regs *regs);
>
> -void __kretprobe_trampoline(void);
> -void *trampoline_probe_handler(struct pt_regs *regs);
> -
>  #else /* !CONFIG_KPROBES */
>
>  static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) { ret=
urn false; }
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 9a72d91cd104..7106ca996e55 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -52,6 +52,11 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) +=3D unwind_prologue.o
>  obj-$(CONFIG_PERF_EVENTS)      +=3D perf_event.o perf_regs.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)       +=3D hw_breakpoint.o
>
> -obj-$(CONFIG_KPROBES)          +=3D kprobes.o kprobes_trampoline.o
> +obj-$(CONFIG_KPROBES)          +=3D kprobes.o
> +obj-$(CONFIG_RETHOOK)          +=3D rethook.o rethook_trampoline.o
> +
> +CFLAGS_REMOVE_rethook.o =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_rethook_trampoline.o =3D $(CC_FLAGS_FTRACE)
Move them to below CFLAGS_REMOVE_perf_event.o =3D $(CC_FLAGS_FTRACE), thank=
s.

Huacai
> +
>
>  CPPFLAGS_vmlinux.lds           :=3D $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kpro=
bes.c
> index 56c8c4b09a42..dbce23ba9970 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -378,26 +378,6 @@ int __init arch_init_kprobes(void)
>         return 0;
>  }
>
> -/* ASM function that handles the kretprobes must not be probed */
> -NOKPROBE_SYMBOL(__kretprobe_trampoline);
> -
> -/* Called from __kretprobe_trampoline */
> -void __used *trampoline_probe_handler(struct pt_regs *regs)
> -{
> -       return (void *)kretprobe_trampoline_handler(regs, NULL);
> -}
> -NOKPROBE_SYMBOL(trampoline_probe_handler);
> -
> -void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -                           struct pt_regs *regs)
> -{
> -       ri->ret_addr =3D (kprobe_opcode_t *)regs->regs[1];
> -       ri->fp =3D NULL;
> -
> -       /* Replace the return addr with trampoline addr */
> -       regs->regs[1] =3D (unsigned long)&__kretprobe_trampoline;
> -}
> -NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>
>  int arch_trampoline_kprobe(struct kprobe *p)
>  {
> diff --git a/arch/loongarch/kernel/rethook.c b/arch/loongarch/kernel/reth=
ook.c
> new file mode 100644
> index 000000000000..b5e7f62f7dea
> --- /dev/null
> +++ b/arch/loongarch/kernel/rethook.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic return hook for LoongArch.
> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +#include "rethook.h"
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *re=
gs)
> +{
> +       return rethook_trampoline_handler(regs, 0);
> +}
> +
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs=
, bool mcount)
> +{
> +       rhn->ret_addr =3D regs->regs[1];
> +       rhn->frame =3D 0;
> +
> +       /* replace return addr with trampoline */
> +       regs->regs[1] =3D (unsigned long)arch_rethook_trampoline;
> +}
> +
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> diff --git a/arch/loongarch/kernel/rethook.h b/arch/loongarch/kernel/reth=
ook.h
> new file mode 100644
> index 000000000000..3f1c1edf0d0b
> --- /dev/null
> +++ b/arch/loongarch/kernel/rethook.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LOONGARCH_RETHOOK_H
> +#define __LOONGARCH_RETHOOK_H
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs=
, bool mcount);
> +
> +#endif
> diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loongarch/=
kernel/rethook_trampoline.S
> similarity index 93%
> rename from arch/loongarch/kernel/kprobes_trampoline.S
> rename to arch/loongarch/kernel/rethook_trampoline.S
> index af94b0d213fa..bd5772c96338 100644
> --- a/arch/loongarch/kernel/kprobes_trampoline.S
> +++ b/arch/loongarch/kernel/rethook_trampoline.S
> @@ -75,7 +75,7 @@
>         csrxchg t0, t1, LOONGARCH_CSR_CRMD
>         .endm
>
> -SYM_CODE_START(__kretprobe_trampoline)
> +SYM_CODE_START(arch_rethook_trampoline)
>         addi.d  sp, sp, -PT_SIZE
>         save_all_base_regs
>
> @@ -84,7 +84,7 @@ SYM_CODE_START(__kretprobe_trampoline)
>
>         move a0, sp /* pt_regs */
>
> -       bl trampoline_probe_handler
> +       bl arch_rethook_trampoline_callback
>
>         /* use the result as the return-address */
>         move ra, a0
> @@ -93,4 +93,4 @@ SYM_CODE_START(__kretprobe_trampoline)
>         addi.d  sp, sp, PT_SIZE
>
>         jr ra
> -SYM_CODE_END(__kretprobe_trampoline)
> +SYM_CODE_END(arch_rethook_trampoline)
> --
> 2.27.0
>
