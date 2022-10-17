Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11A6009B3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJQJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJQJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:00:14 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED54D1ADBF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:00:04 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.167.46])
        by gateway (Coremail) with SMTP id _____8AxzNiRGU1jGAUAAA--.108S3;
        Mon, 17 Oct 2022 17:00:02 +0800 (CST)
Received: from mail-lf1-f46.google.com (unknown [209.85.167.46])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtuOOGU1j3AkAAA--.212S3;
        Mon, 17 Oct 2022 17:00:00 +0800 (CST)
Received: by mail-lf1-f46.google.com with SMTP id s20so16430274lfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:00:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf3EdwIa8Gy5ZllYXnOjRrF0eXINfXIDTIdELQQSI7n/nsHc2a45
        KA/1VOUMU2nBcstKs0JtG6hBnT7v+mo9AVRXwdZQiA==
X-Google-Smtp-Source: AMsMyM4EF+0VQo2iAXqT7ur2uS/oRmaPyE6kV80+wkiIb/PG7mAGEMH/7SrxhastQxoyKVE05c4FTMOe4YHJa0T3WtM=
X-Received: by 2002:a05:6512:258e:b0:4a2:802d:f5ee with SMTP id
 bf14-20020a056512258e00b004a2802df5eemr3401372lfb.129.1665997197341; Mon, 17
 Oct 2022 01:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
In-Reply-To: <20221017022330.2383060-1-chenhuacai@loongson.cn>
From:   Rui Wang <wangrui@loongson.cn>
Date:   Mon, 17 Oct 2022 16:59:45 +0800
X-Gmail-Original-Message-ID: <CAHirt9jRBV_Err56c8TZXk2EkQHXmLayPHvRANinY-cXyvww=g@mail.gmail.com>
Message-ID: <CAHirt9jRBV_Err56c8TZXk2EkQHXmLayPHvRANinY-cXyvww=g@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CM-TRANSID: AQAAf8BxtuOOGU1j3AkAAA--.212S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZF47Zw47XrW3WF1DAr1xuFg_yoW8Zr1UXo
        WrZFy0kw4rA3yYkFy8Jws3Xr4jgrykKr40vay2v3Z8GF4rXa4avrWjkw4jywnaqa1rtrZ7
        G3y3uFWqywn7tan8n29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Oy
        CJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Mon, Oct 17, 2022 at 10:25 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Loongson-2 series (Loongson-2K500, Loongson-2K1000) don't support
> unaligned access in hardware, while Loongson-3 series (Loongson-3A5000,
> Loongson-3C5000) are configurable whether support unaligned access in
> hardware. This patch add unaligned access emulation for those LoongArch
> processors without hardware support.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Simplify READ_FPR and WRITE_FPR.
>
>  arch/loongarch/Kconfig            |   2 +
>  arch/loongarch/include/asm/inst.h |  14 ++
>  arch/loongarch/kernel/Makefile    |   3 +-
>  arch/loongarch/kernel/traps.c     |  27 ++
>  arch/loongarch/kernel/unaligned.c | 393 ++++++++++++++++++++++++++++++
>  arch/loongarch/lib/Makefile       |   2 +-
>  arch/loongarch/lib/unaligned.S    |  93 +++++++
>  7 files changed, 532 insertions(+), 2 deletions(-)
>  create mode 100644 arch/loongarch/kernel/unaligned.c
>  create mode 100644 arch/loongarch/lib/unaligned.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0a6ef613124c..a8dc58e8162a 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -122,6 +122,8 @@ config LOONGARCH
>         select RTC_LIB
>         select SMP
>         select SPARSE_IRQ
> +       select SYSCTL_ARCH_UNALIGN_ALLOW
> +       select SYSCTL_ARCH_UNALIGN_NO_WARN
>         select SYSCTL_EXCEPTION_TRACE
>         select SWIOTLB
>         select TRACE_IRQFLAGS_SUPPORT
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index fce1843ceebb..e96b5345f389 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -76,6 +76,10 @@ enum reg2i12_op {
>         ldbu_op         = 0xa8,
>         ldhu_op         = 0xa9,
>         ldwu_op         = 0xaa,
> +       flds_op         = 0xac,
> +       fsts_op         = 0xad,
> +       fldd_op         = 0xae,
> +       fstd_op         = 0xaf,
>  };
>
>  enum reg2i14_op {
> @@ -146,6 +150,10 @@ enum reg3_op {
>         ldxbu_op        = 0x7040,
>         ldxhu_op        = 0x7048,
>         ldxwu_op        = 0x7050,
> +       fldxs_op        = 0x7060,
> +       fldxd_op        = 0x7068,
> +       fstxs_op        = 0x7070,
> +       fstxd_op        = 0x7078,
>         amswapw_op      = 0x70c0,
>         amswapd_op      = 0x70c1,
>         amaddw_op       = 0x70c2,
> @@ -566,4 +574,10 @@ static inline void emit_##NAME(union loongarch_instruction *insn,  \
>
>  DEF_EMIT_REG3SA2_FORMAT(alsld, alsld_op)
>
> +struct pt_regs;
> +
> +unsigned long unaligned_read(void *addr, void *value, unsigned long n, bool sign);
> +unsigned long unaligned_write(void *addr, unsigned long value, unsigned long n);
> +void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc);
> +
>  #endif /* _ASM_INST_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 42be564278fa..2ad2555b53ea 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -7,7 +7,8 @@ extra-y         := vmlinux.lds
>
>  obj-y          += head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>                    traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
> -                  elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o
> +                  elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
> +                  unaligned.o
>
>  obj-$(CONFIG_ACPI)             += acpi.o
>  obj-$(CONFIG_EFI)              += efi.o
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 1a4dce84ebc6..7ea62faeeadb 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -368,13 +368,40 @@ asmlinkage void noinstr do_ade(struct pt_regs *regs)
>         irqentry_exit(regs, state);
>  }
>
> +/* sysctl hooks */
> +int unaligned_enabled __read_mostly = 1;       /* Enabled by default */
> +int no_unaligned_warning __read_mostly = 1;    /* Only 1 warning by default */
> +
>  asmlinkage void noinstr do_ale(struct pt_regs *regs)
>  {
> +       unsigned int *pc;
>         irqentry_state_t state = irqentry_enter(regs);
>
> +       perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, regs->csr_badvaddr);
> +
> +       /*
> +        * Did we catch a fault trying to load an instruction?
> +        */
> +       if (regs->csr_badvaddr == regs->csr_era)
> +               goto sigbus;
> +       if (user_mode(regs) && !test_thread_flag(TIF_FIXADE))
> +               goto sigbus;
> +       if (!unaligned_enabled)
> +               goto sigbus;
> +       if (!no_unaligned_warning)
> +               show_registers(regs);
> +
> +       pc = (unsigned int *)exception_era(regs);
> +
> +       emulate_load_store_insn(regs, (void __user *)regs->csr_badvaddr, pc);
> +
> +       goto out;
> +
> +sigbus:
>         die_if_kernel("Kernel ale access", regs);
>         force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
>
> +out:
>         irqentry_exit(regs, state);
>  }
>
> diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
> new file mode 100644
> index 000000000000..f367424b762a
> --- /dev/null
> +++ b/arch/loongarch/kernel/unaligned.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handle unaligned accesses by emulation.
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + *
> + */
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/signal.h>
> +#include <linux/debugfs.h>
> +#include <linux/perf_event.h>
> +
> +#include <asm/asm.h>
> +#include <asm/branch.h>
> +#include <asm/fpu.h>
> +#include <asm/inst.h>
> +
> +#include "access-helper.h"
> +
> +#ifdef CONFIG_DEBUG_FS
> +static u32 unaligned_instructions_user;
> +static u32 unaligned_instructions_kernel;
> +#endif
> +
> +static inline unsigned long read_fpr(unsigned int fd)
> +{
> +#define READ_FPR(fd, __value)          \
> +       __asm__ __volatile__("movfr2gr.d %0, $f"#fd"\n\t" : "=r"(__value));
> +
> +       unsigned long __value;
> +
> +       switch (fd) {
> +       case 0:
> +               READ_FPR(0, __value);
> +               break;
> +       case 1:
> +               READ_FPR(1, __value);
> +               break;
> +       case 2:
> +               READ_FPR(2, __value);
> +               break;
> +       case 3:
> +               READ_FPR(3, __value);
> +               break;
> +       case 4:
> +               READ_FPR(4, __value);
> +               break;
> +       case 5:
> +               READ_FPR(5, __value);
> +               break;
> +       case 6:
> +               READ_FPR(6, __value);
> +               break;
> +       case 7:
> +               READ_FPR(7, __value);
> +               break;
> +       case 8:
> +               READ_FPR(8, __value);
> +               break;
> +       case 9:
> +               READ_FPR(9, __value);
> +               break;
> +       case 10:
> +               READ_FPR(10, __value);
> +               break;
> +       case 11:
> +               READ_FPR(11, __value);
> +               break;
> +       case 12:
> +               READ_FPR(12, __value);
> +               break;
> +       case 13:
> +               READ_FPR(13, __value);
> +               break;
> +       case 14:
> +               READ_FPR(14, __value);
> +               break;
> +       case 15:
> +               READ_FPR(15, __value);
> +               break;
> +       case 16:
> +               READ_FPR(16, __value);
> +               break;
> +       case 17:
> +               READ_FPR(17, __value);
> +               break;
> +       case 18:
> +               READ_FPR(18, __value);
> +               break;
> +       case 19:
> +               READ_FPR(19, __value);
> +               break;
> +       case 20:
> +               READ_FPR(20, __value);
> +               break;
> +       case 21:
> +               READ_FPR(21, __value);
> +               break;
> +       case 22:
> +               READ_FPR(22, __value);
> +               break;
> +       case 23:
> +               READ_FPR(23, __value);
> +               break;
> +       case 24:
> +               READ_FPR(24, __value);
> +               break;
> +       case 25:
> +               READ_FPR(25, __value);
> +               break;
> +       case 26:
> +               READ_FPR(26, __value);
> +               break;
> +       case 27:
> +               READ_FPR(27, __value);
> +               break;
> +       case 28:
> +               READ_FPR(28, __value);
> +               break;
> +       case 29:
> +               READ_FPR(29, __value);
> +               break;
> +       case 30:
> +               READ_FPR(30, __value);
> +               break;
> +       case 31:
> +               READ_FPR(31, __value);
> +               break;
> +       default:
> +               panic("unexpected fd '%d'", fd);
> +       }
> +#undef READ_FPR
> +       return __value;
> +}
> +
> +static inline void write_fpr(unsigned int fd, unsigned long value)
> +{
> +#define WRITE_FPR(fd, value)           \
> +       __asm__ __volatile__("movgr2fr.d $f"#fd", %0\n\t" :: "r"(value));
> +
> +       switch (fd) {
> +       case 0:
> +               WRITE_FPR(0, value);
> +               break;
> +       case 1:
> +               WRITE_FPR(1, value);
> +               break;
> +       case 2:
> +               WRITE_FPR(2, value);
> +               break;
> +       case 3:
> +               WRITE_FPR(3, value);
> +               break;
> +       case 4:
> +               WRITE_FPR(4, value);
> +               break;
> +       case 5:
> +               WRITE_FPR(5, value);
> +               break;
> +       case 6:
> +               WRITE_FPR(6, value);
> +               break;
> +       case 7:
> +               WRITE_FPR(7, value);
> +               break;
> +       case 8:
> +               WRITE_FPR(8, value);
> +               break;
> +       case 9:
> +               WRITE_FPR(9, value);
> +               break;
> +       case 10:
> +               WRITE_FPR(10, value);
> +               break;
> +       case 11:
> +               WRITE_FPR(11, value);
> +               break;
> +       case 12:
> +               WRITE_FPR(12, value);
> +               break;
> +       case 13:
> +               WRITE_FPR(13, value);
> +               break;
> +       case 14:
> +               WRITE_FPR(14, value);
> +               break;
> +       case 15:
> +               WRITE_FPR(15, value);
> +               break;
> +       case 16:
> +               WRITE_FPR(16, value);
> +               break;
> +       case 17:
> +               WRITE_FPR(17, value);
> +               break;
> +       case 18:
> +               WRITE_FPR(18, value);
> +               break;
> +       case 19:
> +               WRITE_FPR(19, value);
> +               break;
> +       case 20:
> +               WRITE_FPR(20, value);
> +               break;
> +       case 21:
> +               WRITE_FPR(21, value);
> +               break;
> +       case 22:
> +               WRITE_FPR(22, value);
> +               break;
> +       case 23:
> +               WRITE_FPR(23, value);
> +               break;
> +       case 24:
> +               WRITE_FPR(24, value);
> +               break;
> +       case 25:
> +               WRITE_FPR(25, value);
> +               break;
> +       case 26:
> +               WRITE_FPR(26, value);
> +               break;
> +       case 27:
> +               WRITE_FPR(27, value);
> +               break;
> +       case 28:
> +               WRITE_FPR(28, value);
> +               break;
> +       case 29:
> +               WRITE_FPR(29, value);
> +               break;
> +       case 30:
> +               WRITE_FPR(30, value);
> +               break;
> +       case 31:
> +               WRITE_FPR(31, value);
> +               break;
> +       default:
> +               panic("unexpected fd '%d'", fd);
> +       }
> +#undef WRITE_FPR
> +}
> +
> +void emulate_load_store_insn(struct pt_regs *regs, void __user *addr, unsigned int *pc)
> +{
> +       bool user = user_mode(regs);
> +       unsigned int res;
> +       unsigned long origpc;
> +       unsigned long origra;
> +       unsigned long value = 0;
> +       union loongarch_instruction insn;
> +
> +       origpc = (unsigned long)pc;
> +       origra = regs->regs[1];
> +
> +       perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
> +
> +       /*
> +        * This load never faults.
> +        */
> +       __get_inst(&insn.word, pc, user);
> +       if (user && !access_ok(addr, 8))
> +               goto sigbus;
> +
> +       if (insn.reg2i12_format.opcode == ldd_op ||
> +               insn.reg2i14_format.opcode == ldptrd_op ||
> +               insn.reg3_format.opcode == ldxd_op) {
> +               res = unaligned_read(addr, &value, 8, 1);
> +               if (res)
> +                       goto fault;
> +               regs->regs[insn.reg2i12_format.rd] = value;
> +       } else if (insn.reg2i12_format.opcode == ldw_op ||
> +               insn.reg2i14_format.opcode == ldptrw_op ||
> +               insn.reg3_format.opcode == ldxw_op) {
> +               res = unaligned_read(addr, &value, 4, 1);
> +               if (res)
> +                       goto fault;
> +               regs->regs[insn.reg2i12_format.rd] = value;
> +       } else if (insn.reg2i12_format.opcode == ldwu_op ||
> +               insn.reg3_format.opcode == ldxwu_op) {
> +               res = unaligned_read(addr, &value, 4, 0);
> +               if (res)
> +                       goto fault;
> +               regs->regs[insn.reg2i12_format.rd] = value;
> +       } else if (insn.reg2i12_format.opcode == ldh_op ||
> +               insn.reg3_format.opcode == ldxh_op) {
> +               res = unaligned_read(addr, &value, 2, 1);
> +               if (res)
> +                       goto fault;
> +               regs->regs[insn.reg2i12_format.rd] = value;
> +       } else if (insn.reg2i12_format.opcode == ldhu_op ||
> +               insn.reg3_format.opcode == ldxhu_op) {
> +               res = unaligned_read(addr, &value, 2, 0);
> +               if (res)
> +                       goto fault;
> +               regs->regs[insn.reg2i12_format.rd] = value;
> +       } else if (insn.reg2i12_format.opcode == std_op ||
> +               insn.reg2i14_format.opcode == stptrd_op ||
> +               insn.reg3_format.opcode == stxd_op) {
> +               value = regs->regs[insn.reg2i12_format.rd];
> +               res = unaligned_write(addr, value, 8);
> +               if (res)
> +                       goto fault;
> +       } else if (insn.reg2i12_format.opcode == stw_op ||
> +               insn.reg2i14_format.opcode == stptrw_op ||
> +               insn.reg3_format.opcode == stxw_op) {
> +               value = regs->regs[insn.reg2i12_format.rd];
> +               res = unaligned_write(addr, value, 4);
> +               if (res)
> +                       goto fault;
> +       } else if (insn.reg2i12_format.opcode == sth_op ||
> +               insn.reg3_format.opcode == stxh_op) {
> +               value = regs->regs[insn.reg2i12_format.rd];
> +               res = unaligned_write(addr, value, 2);
> +               if (res)
> +                       goto fault;
> +       } else if (insn.reg2i12_format.opcode == fldd_op ||
> +               insn.reg3_format.opcode == fldxd_op) {
> +               res = unaligned_read(addr, &value, 8, 1);
> +               if (res)
> +                       goto fault;
> +               write_fpr(insn.reg2i12_format.rd, value);
> +       } else if (insn.reg2i12_format.opcode == flds_op ||
> +               insn.reg3_format.opcode == fldxs_op) {
> +               res = unaligned_read(addr, &value, 4, 1);
> +               if (res)
> +                       goto fault;
> +               write_fpr(insn.reg2i12_format.rd, value);
> +       } else if (insn.reg2i12_format.opcode == fstd_op ||
> +               insn.reg3_format.opcode == fstxd_op) {
> +               value = read_fpr(insn.reg2i12_format.rd);
> +               res = unaligned_write(addr, value, 8);
> +               if (res)
> +                       goto fault;
> +       } else if (insn.reg2i12_format.opcode == fsts_op ||
> +               insn.reg3_format.opcode == fstxs_op) {
> +               value = read_fpr(insn.reg2i12_format.rd);
> +               res = unaligned_write(addr, value, 4);
> +               if (res)
> +                       goto fault;
> +       } else
> +               goto sigbus;

So many condtional branches for linear instruction matching, use
switch case is better?

0000000000000238 <emulate_load_store_insn>:
...
 35c:    1470180f     lu12i.w         $t3, 229568(0x380c0)
 360:    580141af     beq             $t1, $t3, 320(0x140)    # 4a0
<emulate_load_store_insn+0x268>
 364:    1451000f     lu12i.w         $t3, 165888(0x28800)
 368:    5801dd8f     beq             $t0, $t3, 476(0x1dc)    # 544
<emulate_load_store_insn+0x30c>
 36c:    0280900f     addi.w          $t3, $zero, 36(0x24)
 370:    5801d5cf     beq             $t2, $t3, 468(0x1d4)    # 544
<emulate_load_store_insn+0x30c>
 374:    1470100f     lu12i.w         $t3, 229504(0x38080)
 378:    5801cdaf     beq             $t1, $t3, 460(0x1cc)    # 544
<emulate_load_store_insn+0x30c>
 37c:    1455000f     lu12i.w         $t3, 174080(0x2a800)
 380:    5801f18f     beq             $t0, $t3, 496(0x1f0)    # 570
<emulate_load_store_insn+0x338>
 384:    1470500f     lu12i.w         $t3, 230016(0x38280)
 388:    5801e9af     beq             $t1, $t3, 488(0x1e8)    # 570
<emulate_load_store_insn+0x338>
 38c:    1450800f     lu12i.w         $t3, 164864(0x28400)
 390:    5801ed8f     beq             $t0, $t3, 492(0x1ec)    # 57c
<emulate_load_store_insn+0x344>
 394:    1470080f     lu12i.w         $t3, 229440(0x38040)
 398:    5801e5af     beq             $t1, $t3, 484(0x1e4)    # 57c
<emulate_load_store_insn+0x344>
 39c:    1454800f     lu12i.w         $t3, 173056(0x2a400)
 3a0:    5801f98f     beq             $t0, $t3, 504(0x1f8)    # 598
<emulate_load_store_insn+0x360>
 3a4:    1470480f     lu12i.w         $t3, 229952(0x38240)
 3a8:    5801f1af     beq             $t1, $t3, 496(0x1f0)    # 598
<emulate_load_store_insn+0x360>
 3ac:    1453800f     lu12i.w         $t3, 171008(0x29c00)
 3b0:    5802098f     beq             $t0, $t3, 520(0x208)    # 5b8
<emulate_load_store_insn+0x380>
 3b4:    02809c0f     addi.w          $t3, $zero, 39(0x27)
 3b8:    580201cf     beq             $t2, $t3, 512(0x200)    # 5b8
<emulate_load_store_insn+0x380>
 3bc:    1470380f     lu12i.w         $t3, 229824(0x381c0)
 3c0:    5801f9af     beq             $t1, $t3, 504(0x1f8)    # 5b8
<emulate_load_store_insn+0x380>
 3c4:    1453000f     lu12i.w         $t3, 169984(0x29800)
 3c8:    58021d8f     beq             $t0, $t3, 540(0x21c)    # 5e4
<emulate_load_store_insn+0x3ac>
 3cc:    0280940f     addi.w          $t3, $zero, 37(0x25)
 3d0:    580215cf     beq             $t2, $t3, 532(0x214)    # 5e4
<emulate_load_store_insn+0x3ac>
 3d4:    1470300e     lu12i.w         $t2, 229760(0x38180)
 3d8:    58020dae     beq             $t1, $t2, 524(0x20c)    # 5e4
<emulate_load_store_insn+0x3ac>
 3dc:    1452800e     lu12i.w         $t2, 168960(0x29400)
 3e0:    58020d8e     beq             $t0, $t2, 524(0x20c)    # 5ec
<emulate_load_store_insn+0x3b4>
 3e4:    1470280e     lu12i.w         $t2, 229696(0x38140)
 3e8:    580205ae     beq             $t1, $t2, 516(0x204)    # 5ec
<emulate_load_store_insn+0x3b4>
 3ec:    1457000e     lu12i.w         $t2, 178176(0x2b800)
 3f0:    5802058e     beq             $t0, $t2, 516(0x204)    # 5f4
<emulate_load_store_insn+0x3bc>
 3f4:    1470680e     lu12i.w         $t2, 230208(0x38340)
 3f8:    5801fdae     beq             $t1, $t2, 508(0x1fc)    # 5f4
<emulate_load_store_insn+0x3bc>
 3fc:    1456000e     lu12i.w         $t2, 176128(0x2b000)
 400:    5802258e     beq             $t0, $t2, 548(0x224)    # 624
<emulate_load_store_insn+0x3ec>
 404:    1470600e     lu12i.w         $t2, 230144(0x38300)
 408:    58021dae     beq             $t1, $t2, 540(0x21c)    # 624
<emulate_load_store_insn+0x3ec>
 40c:    1457800e     lu12i.w         $t2, 179200(0x2bc00)
 410:    5802218e     beq             $t0, $t2, 544(0x220)    # 630
<emulate_load_store_insn+0x3f8>
 414:    1470780e     lu12i.w         $t2, 230336(0x383c0)
 418:    580219ae     beq             $t1, $t2, 536(0x218)    # 630
<emulate_load_store_insn+0x3f8>
 41c:    1456800e     lu12i.w         $t2, 177152(0x2b400)
 420:    58000d8e     beq             $t0, $t2, 12(0xc)    # 42c
<emulate_load_store_insn+0x1f4>
 424:    1470700c     lu12i.w         $t0, 230272(0x38380)
 428:    5ffed9ac     bne             $t1, $t0, -296(0x3fed8)    # 300
<emulate_load_store_insn+0xc8>
...

Regards,
Rui

> +
> +
> +#ifdef CONFIG_DEBUG_FS
> +       if (user)
> +               unaligned_instructions_user++;
> +       else
> +               unaligned_instructions_kernel++;
> +#endif
> +
> +       compute_return_era(regs);
> +       return;
> +
> +fault:
> +       /* roll back jump/branch */
> +       regs->csr_era = origpc;
> +       regs->regs[1] = origra;
> +       /* Did we have an exception handler installed? */
> +       if (fixup_exception(regs))
> +               return;
> +
> +       die_if_kernel("Unhandled kernel unaligned access", regs);
> +       force_sig(SIGSEGV);
> +
> +       return;
> +
> +sigbus:
> +       die_if_kernel("Unhandled kernel unaligned access", regs);
> +       force_sig(SIGBUS);
> +
> +       return;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int __init debugfs_unaligned(void)
> +{
> +       struct dentry *d;
> +
> +       d = debugfs_create_dir("loongarch", NULL);
> +       if (!d)
> +               return -ENOMEM;
> +
> +       debugfs_create_u32("unaligned_instructions_user",
> +                               S_IRUGO, d, &unaligned_instructions_user);
> +       debugfs_create_u32("unaligned_instructions_kernel",
> +                               S_IRUGO, d, &unaligned_instructions_kernel);
> +
> +       return 0;
> +}
> +arch_initcall(debugfs_unaligned);
> +#endif
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index e36635fccb69..867895530340 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -3,4 +3,4 @@
>  # Makefile for LoongArch-specific library files.
>  #
>
> -lib-y  += delay.o clear_user.o copy_user.o dump_tlb.o
> +lib-y  += delay.o clear_user.o copy_user.o dump_tlb.o unaligned.o
> diff --git a/arch/loongarch/lib/unaligned.S b/arch/loongarch/lib/unaligned.S
> new file mode 100644
> index 000000000000..03210cb5a18d
> --- /dev/null
> +++ b/arch/loongarch/lib/unaligned.S
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/errno.h>
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +
> +.macro fixup_ex from, to, fix
> +.if \fix
> +       .section .fixup, "ax"
> +\to:   li.w    a0, -EFAULT
> +       jr      ra
> +       .previous
> +.endif
> +       .section __ex_table, "a"
> +       PTR     \from\()b, \to\()b
> +       .previous
> +.endm
> +
> +/*
> + * unsigned long unaligned_read(void *addr, void *value, unsigned long n, bool sign)
> + *
> + * a0: addr
> + * a1: value
> + * a2: n
> + * a3: sign
> + */
> +SYM_FUNC_START(unaligned_read)
> +       beqz    a2, 5f
> +
> +       li.w    t1, 8
> +       li.w    t2, 0
> +
> +       addi.d  t0, a2, -1
> +       mul.d   t1, t0, t1
> +       add.d   a0, a0, t0
> +
> +       beq     a3, zero, 2f
> +1:     ld.b    t3, a0, 0
> +       b       3f
> +
> +2:     ld.bu   t3, a0, 0
> +3:     sll.d   t3, t3, t1
> +       or      t2, t2, t3
> +       addi.d  t1, t1, -8
> +       addi.d  a0, a0, -1
> +       addi.d  a2, a2, -1
> +       bgt     a2, zero, 2b
> +4:     st.d    t2, a1, 0
> +
> +       move    a0, a2
> +       jr      ra
> +
> +5:     li.w    a0, -EFAULT
> +       jr      ra
> +
> +       fixup_ex 1, 6, 1
> +       fixup_ex 2, 6, 0
> +       fixup_ex 4, 6, 0
> +SYM_FUNC_END(unaligned_read)
> +
> +/*
> + * unsigned long unaligned_write(void *addr, unsigned long value, unsigned long n)
> + *
> + * a0: addr
> + * a1: value
> + * a2: n
> + */
> +SYM_FUNC_START(unaligned_write)
> +       beqz    a2, 3f
> +
> +       li.w    t0, 0
> +1:     srl.d   t1, a1, t0
> +2:     st.b    t1, a0, 0
> +       addi.d  t0, t0, 8
> +       addi.d  a2, a2, -1
> +       addi.d  a0, a0, 1
> +       bgt     a2, zero, 1b
> +
> +       move    a0, a2
> +       jr      ra
> +
> +3:     li.w    a0, -EFAULT
> +       jr      ra
> +
> +       fixup_ex 2, 4, 1
> +SYM_FUNC_END(unaligned_write)
> --
> 2.31.1
>

