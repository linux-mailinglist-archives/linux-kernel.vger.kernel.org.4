Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9886EBFB0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjDWNMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B86170A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4357660C44
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 13:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7BFC433D2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682255551;
        bh=0031/scqhLp0WEja20wYDqHeTQ71Br55rcOHz3KzjCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W7bcJSPnViEYycltJWP7jRDaphfWbAHjGHu+YiIPmSBJsmSAd1eQlvDO8Y/cTnhTr
         /mnqy0vRCP9leJ4NHSWvviJjLLO+0TFIDXtpZ9l41WBX2zswhM6ahDtGeNVMR/PXyY
         W1o76eJ88VNAAY7hODOJIqBngL6KrtAU4LZrOtIOlGTIsSnVJ393C5A1YZx38lxPeO
         cYilw6A5m6Fyw35ghen2NBofOLQkZ3TMcvM7RSmTu8cg7+zBkjaAZAR6SAWaKkft0F
         JMOZgNdm6JV0cECoivk/SzVN3NfVAbEqz8TxS8xHCamdkluSjtggOKdmxsNcDcWHTv
         aRzG0/k7vHJIA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-505035e3368so5807299a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:12:31 -0700 (PDT)
X-Gm-Message-State: AAQBX9deSPRn9aF97EyRQs85SmTz9enAMxFCY109wOjGvUm0mwO1GKbs
        64umB8NsnCC8hkXFNP0xgkTSx4xf80VDC7scjGY=
X-Google-Smtp-Source: AKy350YYaPyjy0YWODJRE3MhXCZaxJ64XYq0eUUyYnqujWuzv624lkG2tV47lTjGOZpHARhvSjrjgMyRvBIXRxygX1M=
X-Received: by 2002:aa7:d444:0:b0:509:c6e6:c002 with SMTP id
 q4-20020aa7d444000000b00509c6e6c002mr3824303edr.39.1682255549908; Sun, 23 Apr
 2023 06:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn> <1681898221-27828-5-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1681898221-27828-5-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 23 Apr 2023 21:12:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Z_Y+XC-yMGRA1zq9FBU-tAVK+8+Jd4t5x4L4DFXAPJA@mail.gmail.com>
Message-ID: <CAAhV-H7Z_Y+XC-yMGRA1zq9FBU-tAVK+8+Jd4t5x4L4DFXAPJA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] LoongArch: Add uprobes support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Wed, Apr 19, 2023 at 5:57=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Uprobes is the user-space counterpart to kprobes, this commit
> adds uprobes support for LoongArch.
>
> Here is a simple example with CONFIG_UPROBE_EVENTS=3Dy:
>
>   # cat test.c
>   #include <stdio.h>
>
>   int add(int a, int b)
>   {
>           return a + b;
>   }
>
>   int main()
>   {
>           return add(2, 7);
>   }
>   # gcc test.c -o /tmp/test
>   # nm /tmp/test | grep add
>   0000000120004194 T add
>   # cd /sys/kernel/debug/tracing
>   # echo > uprobe_events
>   # echo "p:myuprobe /tmp/test:0x4194 %r4 %r5" > uprobe_events
>   # echo "r:myuretprobe /tmp/test:0x4194 %r4" >> uprobe_events
>   # echo 1 > events/uprobes/enable
>   # echo 1 > tracing_on
>   # /tmp/test
>   # cat trace
>   ...
>   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>   #              | |         |   |||||     |         |
>               test-1060    [001] DNZff  1015.770620: myuprobe: (0x1200041=
94) arg1=3D0x2 arg2=3D0x7
>               test-1060    [001] DNZff  1015.770930: myuretprobe: (0x1200=
041f0 <- 0x120004194) arg1=3D0x9
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig               |   3 +
>  arch/loongarch/include/asm/uprobes.h |  36 +++++++++
>  arch/loongarch/kernel/Makefile       |   1 +
>  arch/loongarch/kernel/traps.c        |   9 +--
>  arch/loongarch/kernel/uprobes.c      | 142 +++++++++++++++++++++++++++++=
++++++
>  5 files changed, 186 insertions(+), 5 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/uprobes.h
>  create mode 100644 arch/loongarch/kernel/uprobes.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 7fd5125..ab66ad2 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -574,6 +574,9 @@ config ARCH_MMAP_RND_BITS_MIN
>  config ARCH_MMAP_RND_BITS_MAX
>         default 18
>
> +config ARCH_SUPPORTS_UPROBES
> +       def_bool y
> +
>  menu "Power management options"
>
>  config ARCH_SUSPEND_POSSIBLE
> diff --git a/arch/loongarch/include/asm/uprobes.h b/arch/loongarch/includ=
e/asm/uprobes.h
> new file mode 100644
> index 0000000..59e2683
> --- /dev/null
> +++ b/arch/loongarch/include/asm/uprobes.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_LOONGARCH_UPROBES_H
> +#define __ASM_LOONGARCH_UPROBES_H
> +
> +#include <asm/inst.h>
> +
> +typedef u32 uprobe_opcode_t;
> +
> +#define MAX_UINSN_BYTES                8
> +#define UPROBE_XOL_SLOT_BYTES  MAX_UINSN_BYTES
In old versions we define UPROBE_XOL_SLOT_BYTES to 128, why we use 8 now?

> +
> +#define UPROBE_XOLBP_INSN      larch_insn_gen_break(BRK_UPROBE_XOLBP)
> +#define UPROBE_SWBP_INSN       larch_insn_gen_break(BRK_UPROBE_BP)
> +#define UPROBE_SWBP_INSN_SIZE  LOONGARCH_INSN_SIZE
> +
> +struct arch_uprobe {
> +       union {
> +               u32 insn[2];
> +               u32 ixol[2];
> +       };
> +       bool simulate;
> +};
> +
> +struct arch_uprobe_task {
> +       unsigned long saved_trap_nr;
> +};
> +
> +#ifdef CONFIG_UPROBES
> +bool uprobe_breakpoint_handler(struct pt_regs *regs);
> +bool uprobe_singlestep_handler(struct pt_regs *regs);
> +#else /* !CONFIG_UPROBES */
> +static inline bool uprobe_breakpoint_handler(struct pt_regs *regs) { ret=
urn false; }
> +static inline bool uprobe_singlestep_handler(struct pt_regs *regs) { ret=
urn false; }
> +#endif /* CONFIG_UPROBES */
> +
> +#endif /* __ASM_LOONGARCH_UPROBES_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 78d4e33..67b9c26 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -53,5 +53,6 @@ obj-$(CONFIG_PERF_EVENTS)     +=3D perf_event.o perf_re=
gs.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)       +=3D hw_breakpoint.o
>
>  obj-$(CONFIG_KPROBES)          +=3D kprobes.o kprobes_trampoline.o
> +obj-$(CONFIG_UPROBES)          +=3D uprobes.o
>
>  CPPFLAGS_vmlinux.lds           :=3D $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.=
c
> index de8ebe2..cfc2e0c 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -45,6 +45,7 @@
>  #include <asm/tlb.h>
>  #include <asm/types.h>
>  #include <asm/unwind.h>
> +#include <asm/uprobes.h>
>
>  #include "access-helper.h"
>
> @@ -440,7 +441,6 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>         if (regs->csr_prmd & CSR_PRMD_PIE)
>                 local_irq_enable();
>
> -       current->thread.trap_nr =3D read_csr_excode();
>         if (__get_inst(&opcode, (u32 *)era, user))
>                 goto out_sigsegv;
>
> @@ -462,18 +462,17 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>                 else
>                         break;
>         case BRK_UPROBE_BP:
> -               if (notify_die(DIE_UPROBE, "Uprobe", regs, bcode,
> -                              current->thread.trap_nr, SIGTRAP) =3D=3D N=
OTIFY_STOP)
> +               if (uprobe_breakpoint_handler(regs))
>                         goto out;
>                 else
>                         break;
>         case BRK_UPROBE_XOLBP:
> -               if (notify_die(DIE_UPROBE_XOL, "Uprobe_XOL", regs, bcode,
> -                              current->thread.trap_nr, SIGTRAP) =3D=3D N=
OTIFY_STOP)
> +               if (uprobe_singlestep_handler(regs))
As I know, XOL means "execute out of line", is it an alias of "single step"=
?

Huacai
>                         goto out;
>                 else
>                         break;
>         default:
> +               current->thread.trap_nr =3D read_csr_excode();
>                 if (notify_die(DIE_TRAP, "Break", regs, bcode,
>                                current->thread.trap_nr, SIGTRAP) =3D=3D N=
OTIFY_STOP)
>                         goto out;
> diff --git a/arch/loongarch/kernel/uprobes.c b/arch/loongarch/kernel/upro=
bes.c
> new file mode 100644
> index 0000000..628c39d
> --- /dev/null
> +++ b/arch/loongarch/kernel/uprobes.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/highmem.h>
> +#include <linux/ptrace.h>
> +#include <linux/uprobes.h>
> +#include <linux/sched.h>
> +#include <asm/cacheflush.h>
> +
> +#define UPROBE_TRAP_NR UINT_MAX
> +
> +int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe,
> +                            struct mm_struct *mm, unsigned long addr)
> +{
> +       union loongarch_instruction insn;
> +
> +       if (addr & 0x3)
> +               return -EILSEQ;
> +
> +       insn.word =3D auprobe->insn[0];
> +
> +       if (insns_not_supported(insn))
> +               return -EINVAL;
> +
> +       if (insns_need_simulation(insn)) {
> +               auprobe->ixol[0] =3D larch_insn_gen_nop();
> +               auprobe->simulate =3D true;
> +       } else {
> +               auprobe->ixol[0] =3D auprobe->insn[0];
> +               auprobe->simulate =3D false;
> +       }
> +
> +       auprobe->ixol[1] =3D UPROBE_XOLBP_INSN;
> +
> +       return 0;
> +}
> +
> +int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *reg=
s)
> +{
> +       struct uprobe_task *utask =3D current->utask;
> +
> +       utask->autask.saved_trap_nr =3D current->thread.trap_nr;
> +       current->thread.trap_nr =3D UPROBE_TRAP_NR;
> +       instruction_pointer_set(regs, utask->xol_vaddr);
> +
> +       return 0;
> +}
> +
> +int arch_uprobe_post_xol(struct arch_uprobe *auprobe, struct pt_regs *re=
gs)
> +{
> +       struct uprobe_task *utask =3D current->utask;
> +
> +       WARN_ON_ONCE(current->thread.trap_nr !=3D UPROBE_TRAP_NR);
> +       current->thread.trap_nr =3D utask->autask.saved_trap_nr;
> +       instruction_pointer_set(regs, utask->vaddr + LOONGARCH_INSN_SIZE)=
;
> +
> +       return 0;
> +}
> +
> +void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *=
regs)
> +{
> +       struct uprobe_task *utask =3D current->utask;
> +
> +       current->thread.trap_nr =3D utask->autask.saved_trap_nr;
> +       instruction_pointer_set(regs, utask->vaddr);
> +}
> +
> +bool arch_uprobe_xol_was_trapped(struct task_struct *t)
> +{
> +       if (t->thread.trap_nr !=3D UPROBE_TRAP_NR)
> +               return true;
> +
> +       return false;
> +}
> +
> +bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs =
*regs)
> +{
> +       union loongarch_instruction insn;
> +
> +       if (!auprobe->simulate)
> +               return false;
> +
> +       insn.word =3D auprobe->insn[0];
> +       arch_simulate_insn(insn, regs);
> +
> +       return true;
> +}
> +
> +unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline=
_vaddr,
> +                                               struct pt_regs *regs)
> +{
> +       unsigned long ra =3D regs->regs[1];
> +
> +       regs->regs[1] =3D trampoline_vaddr;
> +
> +       return ra;
> +}
> +
> +bool arch_uretprobe_is_alive(struct return_instance *ret,
> +                            enum rp_check ctx, struct pt_regs *regs)
> +{
> +       if (ctx =3D=3D RP_CHECK_CHAIN_CALL)
> +               return regs->regs[3] <=3D ret->stack;
> +       else
> +               return regs->regs[3] < ret->stack;
> +}
> +
> +int arch_uprobe_exception_notify(struct notifier_block *self,
> +                                unsigned long val, void *data)
> +{
> +       return NOTIFY_DONE;
> +}
> +
> +bool uprobe_breakpoint_handler(struct pt_regs *regs)
> +{
> +       if (uprobe_pre_sstep_notifier(regs))
> +               return true;
> +
> +       return false;
> +}
> +
> +bool uprobe_singlestep_handler(struct pt_regs *regs)
> +{
> +       if (uprobe_post_sstep_notifier(regs))
> +               return true;
> +
> +       return false;
> +}
> +
> +unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
> +{
> +       return instruction_pointer(regs);
> +}
> +
> +void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> +                          void *src, unsigned long len)
> +{
> +       void *kaddr =3D kmap_local_page(page);
> +       void *dst =3D kaddr + (vaddr & ~PAGE_MASK);
> +
> +       memcpy(dst, src, len);
> +       flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
> +       kunmap_local(kaddr);
> +}
> --
> 2.1.0
>
