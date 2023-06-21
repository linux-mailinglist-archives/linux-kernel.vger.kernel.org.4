Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51892737B41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFUGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFUGYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:24:51 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE101728
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:24:44 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5700b15c12fso59592877b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687328684; x=1689920684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTFcKk5yj6ONKRod/bPWHf143pKAe8JVYa9EBKtFRCk=;
        b=Uh27PZQVZTobhWdsYjwiui6xjJnZt1e17dLGFUR6svS51mSPKDzx+7tf+sBD0ZX2wn
         ZWdS2TOZI7unaSK68lLkh57jF3Q4Qn03mile5ZpnNa0ufndd6/yW5bc9lPDpAQoKN2zK
         yI5CqlqtFgVOg7ey1Mqia5gIQz6BwqSXpXujFogXQ58+Jhow0EWY3+nfFx5HOyx4Ir/a
         EPwKA+y4+kKmK0ZGVNAUqLUmgQgecQeBp9aY+cs9H3TC9Vaezo9U5kr2k2Hx2J8sKyHF
         FVd9LzMcnlAHrx9FU7Q5pgqfhG5ZvwkHK3Js0nE5UXlog/QE3RNU+T88Rnot6F7qz1SB
         akDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687328684; x=1689920684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTFcKk5yj6ONKRod/bPWHf143pKAe8JVYa9EBKtFRCk=;
        b=lL8SY8sE/7ApkESshTDG1XF6ccyg3AzKXcjv0tMD7Gl4U/ee26ut2F1uOa/E4kDBbv
         S7yHeBiYWKkgKvUnMis05G1GGVlfOjQgUG0eUmNK6EaRWbzb5KkhCA90CijTQTpN8T82
         rD2SiAc46r+OHmEjGhmYvPtK4cynAlWYuw18yboitpS8MBC8Hj1PSyUTmuL8I9P5GE2y
         Vi9mqzHfCGNmfVX+P0F+NGwiH7LimwbxTrzLLzI0swkFu+7i/+HGQzLEGDev/qkEYcUO
         lxPpEHJOYIzOJ8HF1BjOeqWVTaYun84JRt2bSID1JLxtB98eduzknHlS26DgAnOLOkwY
         zurw==
X-Gm-Message-State: AC+VfDymQsYKW1Mc+xD5PA8lnt76IFcxC5GRgrwAF0ZGOJq98PuWueB8
        iICRPYKTq6WfqI1ePBcOSRGaNqv7lLXcDj9OkbbiAOzpsgM=
X-Google-Smtp-Source: ACHHUZ59YY8aNIdSFx/YFsKcHrCg/TmeyOKpzggkA+kU1VCt/AkqHGCtHqHQkhe3ClChl1XHM7X4xmS0Zj7ok2DAvwI=
X-Received: by 2002:a81:4a55:0:b0:56d:4d34:20c with SMTP id
 x82-20020a814a55000000b0056d4d34020cmr16188103ywa.37.1687328684041; Tue, 20
 Jun 2023 23:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620131251.30483-1-zhangqing@loongson.cn>
In-Reply-To: <20230620131251.30483-1-zhangqing@loongson.cn>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Wed, 21 Jun 2023 14:24:32 +0800
Message-ID: <CAMpQs4+Y+FNhuZcUM8FkXyKU6mhqEWXyDYPC3UdJYwps-_PgwA@mail.gmail.com>
Subject: Re: [RFC PATCH] LoongArch: KGDB: Add Basic KGDB support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing:

On Tue, Jun 20, 2023 at 9:13=E2=80=AFPM Qing Zhang <zhangqing@loongson.cn> =
wrote:
>
> Add Kgdb debug support for LoongArch kernel debugging, more support
> and testing is working in progress.
>
> Kgdb is intended to be used as a source level debugger for thekernel,
> It is used along with gdb to debug a kernel. The expectation is that
> gdb can be used to "break in" to the kernel to inspect memory, variables
> and look through call stack information similar to the way an application
> developer would use gdb to debug an application.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 79412304a01f..dd823823b7fc 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -85,6 +85,7 @@ config LOONGARCH
>         select GPIOLIB
>         select HAS_IOPORT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_KGDB

Please list the Kconfig options in alphabetical order.
>         select HAVE_ARCH_JUMP_LABEL
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/loongarch/include/asm/kgdb.h b/arch/loongarch/include/a=
sm/kgdb.h
> new file mode 100644
> index 000000000000..35ef7a46beb5
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kgdb.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_LOONGARCH_KGDB_H
> +#define _ASM_LOONGARCH_KGDB_H
> +
> +#define KGDB_GDB_REG_SIZE       64
> +#define GDB_SIZEOF_REG          sizeof(u64)
> +
> +#define BUFMAX                  2048
> +#define DBG_ALL_REG_NUM         78
> +#define DBG_MAX_REG_NUM         33
> +#define NUMREGBYTES             (DBG_MAX_REG_NUM * sizeof(GDB_SIZEOF_REG=
))
> +#define NUMCRITREGBYTES         (12 * sizeof(GDB_SIZEOF_REG))
> +#define BREAK_INSTR_SIZE        4
> +#define CACHE_FLUSH_IS_SAFE     0
> +
> +extern void arch_kgdb_breakpoint(void);
> +extern void *saved_vectors[32];
> +extern void handle_exception(struct pt_regs *regs);
> +extern void breakinst(void);
> +extern int kgdb_ll_trap(int cmd, const char *str,
> +                       struct pt_regs *regs, long err, int trap, int sig=
);
> +
> +#endif /* __ASM_KGDB_H_ */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 8e279f04f9e7..cbe109cd93ba 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -60,4 +60,6 @@ obj-$(CONFIG_UPROBES)         +=3D uprobes.o
>
>  obj-$(CONFIG_JUMP_LABEL)       +=3D jump_label.o
>
> +obj-$(CONFIG_KGDB)             +=3D kgdb.o
> +
>  CPPFLAGS_vmlinux.lds           :=3D $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
> new file mode 100755
> index 000000000000..ecd9ec873cf7
> --- /dev/null
> +++ b/arch/loongarch/kernel/kgdb.c
> @@ -0,0 +1,584 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/ptrace.h>              /* for linux pt_regs struct */
> +#include <linux/hw_breakpoint.h>
> +#include <linux/kgdb.h>
> +#include <linux/kdebug.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <asm/inst.h>
> +#include <asm/fpu.h>
> +#include <asm/cacheflush.h>
> +#include <asm/processor.h>
> +#include <asm/sigcontext.h>
> +#include <asm/irq_regs.h>
> +#include <asm/ptrace.h>
> +#include <asm/hw_breakpoint.h>
> +int kgdb_watch_activated;
> +
> +struct dbg_reg_def_t dbg_reg_def[DBG_ALL_REG_NUM] =3D {
> +       { "r0", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[0]) },
> +       { "r1", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[1]) },
> +       { "r2", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[2]) },
> +       { "r3", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[3]) },
> +       { "r4", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[4]) },
> +       { "r5", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[5]) },
> +       { "r6", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[6]) },
> +       { "r7", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[7]) },
> +       { "r8", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[8]) },
> +       { "r9", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[9]) },
> +       { "r10", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[10]) },
> +       { "r11", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[11]) },
> +       { "r12", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[12]) },
> +       { "r13", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[13]) },
> +       { "r14", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[14]) },
> +       { "r15", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[15]) },
> +       { "r16", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[16]) },
> +       { "r17", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[17]) },
> +       { "r18", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[18]) },
> +       { "r19", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[19]) },
> +       { "r20", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[20]) },
> +       { "r21", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[21]) },
> +       { "r22", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[22]) },
> +       { "r23", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[23]) },
> +       { "r24", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[24]) },
> +       { "r25", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[25]) },
> +       { "r26", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[26]) },
> +       { "r27", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[27]) },
> +       { "r28", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[28]) },
> +       { "r29", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[29]) },
> +       { "r30", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[30]) },
> +       { "r31", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[31]) },
> +       { "pc", GDB_SIZEOF_REG, offsetof(struct pt_regs, csr_era) },
> +       { "f0", GDB_SIZEOF_REG, 0 },
> +       { "f1", GDB_SIZEOF_REG, 1 },
> +       { "f2", GDB_SIZEOF_REG, 2 },
> +       { "f3", GDB_SIZEOF_REG, 3 },
> +       { "f4", GDB_SIZEOF_REG, 4 },
> +       { "f5", GDB_SIZEOF_REG, 5 },
> +       { "f6", GDB_SIZEOF_REG, 6 },
> +       { "f7", GDB_SIZEOF_REG, 7 },
> +       { "f8", GDB_SIZEOF_REG, 8 },
> +       { "f9", GDB_SIZEOF_REG, 9 },
> +       { "f10", GDB_SIZEOF_REG, 10 },
> +       { "f11", GDB_SIZEOF_REG, 11 },
> +       { "f12", GDB_SIZEOF_REG, 12 },
> +       { "f13", GDB_SIZEOF_REG, 13 },
> +       { "f14", GDB_SIZEOF_REG, 14 },
> +       { "f15", GDB_SIZEOF_REG, 15 },
> +       { "f16", GDB_SIZEOF_REG, 16 },
> +       { "f17", GDB_SIZEOF_REG, 17 },
> +       { "f18", GDB_SIZEOF_REG, 18 },
> +       { "f19", GDB_SIZEOF_REG, 19 },
> +       { "f20", GDB_SIZEOF_REG, 20 },
> +       { "f21", GDB_SIZEOF_REG, 21 },
> +       { "f22", GDB_SIZEOF_REG, 22 },
> +       { "f23", GDB_SIZEOF_REG, 23 },
> +       { "f24", GDB_SIZEOF_REG, 24 },
> +       { "f25", GDB_SIZEOF_REG, 25 },
> +       { "f26", GDB_SIZEOF_REG, 26 },
> +       { "f27", GDB_SIZEOF_REG, 27 },
> +       { "f28", GDB_SIZEOF_REG, 28 },
> +       { "f29", GDB_SIZEOF_REG, 29 },
> +       { "f30", GDB_SIZEOF_REG, 30 },
> +       { "f31", GDB_SIZEOF_REG, 31 },
> +       { "fcc0", 1, 0 },
> +       { "fcc1", 1, 1 },
> +       { "fcc2", 1, 2 },
> +       { "fcc3", 1, 3 },
> +       { "fcc4", 1, 4 },
> +       { "fcc5", 1, 5 },
> +       { "fcc6", 1, 6 },
> +       { "fcc7", 1, 7 },
> +       { "fcsr", GDB_SIZEOF_REG, 0 },
> +       { "scr0", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr0) },
> +       { "scr1", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr1) },
> +       { "scr2", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr2) },
> +       { "scr3", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr2) },
> +};
> +
> +int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
> +{
> +       int fp_reg;
> +
> +       if (regno < 0 || regno >=3D DBG_ALL_REG_NUM)
> +               return -EINVAL;
> +
> +       if (dbg_reg_def[regno].offset !=3D -1 && regno < 33) {
> +               memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
> +                      dbg_reg_def[regno].size);
> +       } else if (current && dbg_reg_def[regno].offset !=3D -1 && regno =
< 78) {
> +               /* FP registers 32 -> 77 */
> +               if (!(regs->csr_euen & CSR_EUEN_FPEN))
> +                       return 0;
> +               if (regno =3D=3D 72) {
> +                       /* Process the fcsr/fsr (register 70) */
> +                       memcpy((void *)&current->thread.fpu.fcsr, mem,
> +                              dbg_reg_def[regno].size);
> +               } else if (regno >=3D 64 && regno < 72) {
> +                       /* Process the fcc */
> +                       fp_reg =3D dbg_reg_def[regno].offset;
> +                       memcpy((char *)&current->thread.fpu.fcc + fp_reg,=
 mem,
> +                              dbg_reg_def[regno].size);
> +               } else if (regno >=3D 73 && regno < 77) {
> +                       /* Process the scr */
> +                       memcpy((void *)&current->thread + dbg_reg_def[reg=
no].offset, mem,
> +                              dbg_reg_def[regno].size);
> +               } else {
> +                       fp_reg =3D dbg_reg_def[regno].offset;
> +                       memcpy((void *)&current->thread.fpu.fpr[fp_reg], =
mem, dbg_reg_def[regno].size);
> +               }
> +               restore_fp(current);
> +       }

Would it be better to change if-else to switch-case?
> +
> +       return 0;
> +}
> +
> +char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
> +{
> +       int fp_reg;
> +
> +       if (regno >=3D DBG_ALL_REG_NUM || regno < 0)
> +               return NULL;
> +
> +       if (dbg_reg_def[regno].offset !=3D -1 && regno < 33) {
> +               /* First 32 registers */
> +               memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
> +                      dbg_reg_def[regno].size);
> +       } else if (current && dbg_reg_def[regno].offset !=3D -1 && regno =
< 78) {
> +               /* FP registers 32 -> 77 */
> +               if (!(regs->csr_euen & CSR_EUEN_FPEN))
> +                       goto out;
> +               save_fp(current);
> +               if (regno =3D=3D 72) {
> +                       /* Process the fcsr/fsr (register 70) */
> +                       memcpy(mem, (void *)&current->thread.fpu.fcsr,
> +                              dbg_reg_def[regno].size);
> +               } else if (regno >=3D 64 && regno < 72) {
> +                       /* Process the fcc */
> +                       fp_reg =3D dbg_reg_def[regno].offset;
> +                       memcpy(mem, (char *)&current->thread.fpu.fcc + fp=
_reg,
> +                              dbg_reg_def[regno].size);
> +               } else if (regno >=3D 73 && regno < 77) {
> +                       /* Process the scr */
> +                       memcpy(mem, (void *)&current->thread + dbg_reg_de=
f[regno].offset,
> +                              dbg_reg_def[regno].size);
> +               } else {
> +                       fp_reg =3D dbg_reg_def[regno].offset;
> +                       memcpy(mem, (void *)&current->thread.fpu.fpr[fp_r=
eg], dbg_reg_def[regno].size);
> +               }
> +       }

Ditto.

> +out:
> +       return dbg_reg_def[regno].name;
> +
> +}
> +
> +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_st=
ruct *p)
> +{
> +       int reg;
> +       u64 *ptr =3D (u64 *)gdb_regs, *gdbregs =3D ptr;
> +
> +       *(ptr++) =3D 0;
> +       *(ptr++) =3D p->thread.reg01;
> +       *(ptr++) =3D (long)p;
> +       *(ptr++) =3D p->thread.reg03;
> +       for (reg =3D 4; reg < 23; reg++)
> +               *(ptr++) =3D 0;
> +
> +       /* S0 - S8 */
> +       *(ptr++) =3D p->thread.reg23;
> +       *(ptr++) =3D p->thread.reg24;
> +       *(ptr++) =3D p->thread.reg25;
> +       *(ptr++) =3D p->thread.reg26;
> +       *(ptr++) =3D p->thread.reg27;
> +       *(ptr++) =3D p->thread.reg28;
> +       *(ptr++) =3D p->thread.reg29;
> +       *(ptr++) =3D p->thread.reg30;
> +       *(ptr++) =3D p->thread.reg31;
> +
> +       /*
> +        * PC
> +        * use return address (RA), i.e. the moment after return from res=
ume()
> +        */
> +       *(ptr++) =3D p->thread.reg01;
> +
> +       ptr =3D gdbregs + 73;
> +       *(ptr++) =3D p->thread.scr0;
> +       *(ptr++) =3D p->thread.scr1;
> +       *(ptr++) =3D p->thread.scr2;
> +       *(ptr++) =3D p->thread.scr3;
> +}
> +
> +void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
> +{
> +       regs->csr_era =3D pc;
> +}
> +
> +static inline void kgdb_arch_update_addr(struct pt_regs *regs,
> +                                        char *remcom_in_buffer)
> +{
> +       unsigned long addr;
> +       char *ptr;
> +
> +       ptr =3D &remcom_in_buffer[1];
> +       if (kgdb_hex2long(&ptr, &addr))
> +               regs->csr_era =3D addr;
> +}
> +
> +static struct hw_breakpoint {
> +       unsigned                enabled;
> +       unsigned long           addr;
> +       int                     len;
> +       int                     type;
> +       struct perf_event       * __percpu *pev;
> +} breakinfo[LOONGARCH_MAX_BRP];
> +
> +static int hw_break_reserve_slot(int breakno)
> +{
> +       int cpu;
> +       int cnt =3D 0;
> +       struct perf_event **pevent;
> +
> +       for_each_online_cpu(cpu) {
> +               cnt++;
> +               pevent =3D per_cpu_ptr(breakinfo[breakno].pev, cpu);
> +               if (dbg_reserve_bp_slot(*pevent))
> +                       goto fail;
> +       }
> +
> +       return 0;
> +
> +fail:
> +       for_each_online_cpu(cpu) {
> +               cnt--;
> +               if (!cnt)
> +                       break;
> +               pevent =3D per_cpu_ptr(breakinfo[breakno].pev, cpu);
> +               dbg_release_bp_slot(*pevent);
> +       }
> +       return -1;
> +}
> +
> +static int hw_break_release_slot(int breakno)
> +{
> +       struct perf_event **pevent;
> +       int cpu;
> +
> +       if (dbg_is_early)
> +               return 0;
> +
> +       for_each_online_cpu(cpu) {
> +               pevent =3D per_cpu_ptr(breakinfo[breakno].pev, cpu);
> +               if (dbg_release_bp_slot(*pevent))
> +                       /*
> +                        * The debugger is responsible for handing the re=
try on
> +                        * remove failure.
> +                        */
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
> +static int
> +kgdb_set_hw_break(unsigned long addr, int len, enum kgdb_bptype bptype)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < LOONGARCH_MAX_BRP; i++)
> +               if (!breakinfo[i].enabled)
> +                       break;
> +       if (i =3D=3D LOONGARCH_MAX_BRP)
> +               return -1;
> +
> +       switch (bptype) {
> +       case BP_HARDWARE_BREAKPOINT:
> +               len =3D 1;
> +               breakinfo[i].type =3D LOONGARCH_BREAKPOINT_EXECUTE;
> +               break;
> +       case BP_WRITE_WATCHPOINT:
> +               breakinfo[i].type =3D LOONGARCH_BREAKPOINT_STORE;
> +               break;
> +       case BP_ACCESS_WATCHPOINT:
> +               breakinfo[i].type =3D LOONGARCH_BREAKPOINT_LOAD && LOONGA=
RCH_BREAKPOINT_STORE;
> +               break;
> +       default:
> +               return -1;
> +       }
> +       switch (len) {
> +       case 1:
> +               breakinfo[i].len =3D LOONGARCH_BREAKPOINT_LEN_1;
> +               break;
> +       case 2:
> +               breakinfo[i].len =3D LOONGARCH_BREAKPOINT_LEN_2;
> +               break;
> +       case 4:
> +               breakinfo[i].len =3D LOONGARCH_BREAKPOINT_LEN_4;
> +               break;
> +       case 8:
> +               breakinfo[i].len =3D LOONGARCH_BREAKPOINT_LEN_8;
> +               break;
> +       default:
> +               return -1;
> +       }
> +       breakinfo[i].addr =3D addr;
> +       if (hw_break_reserve_slot(i)) {
> +               breakinfo[i].addr =3D 0;
> +               return -1;
> +       }
> +       breakinfo[i].enabled =3D 1;
> +
> +       return 0;
> +}
> +
> +static int
> +kgdb_remove_hw_break(unsigned long addr, int len, enum kgdb_bptype bptyp=
e)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < LOONGARCH_MAX_BRP; i++)
> +               if (breakinfo[i].addr =3D=3D addr && breakinfo[i].enabled=
)
> +                       break;
> +       if (i =3D=3D LOONGARCH_MAX_BRP)
> +               return -1;
> +
> +       if (hw_break_release_slot(i)) {
> +               printk(KERN_ERR "Cannot remove hw breakpoint at %lx\n", a=
ddr);
> +               return -1;
> +       }
> +       breakinfo[i].enabled =3D 0;
> +
> +       return 0;
> +}
> +
> +static void kgdb_disable_hw_debug(struct pt_regs *regs)
> +{
> +       int i;
> +       int cpu =3D raw_smp_processor_id();
> +       struct perf_event *bp;
> +
> +       /* Disable hardware debugging while we are in kgdb: */
> +       csr_xchg32(0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
> +       regs->csr_prmd &=3D ~CSR_PRMD_PWE;
> +
> +       for (i =3D 0; i < LOONGARCH_MAX_BRP; i++) {
> +               if (!breakinfo[i].enabled)
> +                       continue;
> +               bp =3D *per_cpu_ptr(breakinfo[i].pev, cpu);
> +               if (bp->attr.disabled =3D=3D 1)
> +                       continue;
> +               arch_uninstall_hw_breakpoint(bp);
> +               bp->attr.disabled =3D 1;
> +       }
> +}
> +
> +static void kgdb_remove_all_hw_break(void)
> +{
> +       int i;
> +       int cpu =3D raw_smp_processor_id();
> +       struct perf_event *bp;
> +
> +       for (i =3D 0; i < LOONGARCH_MAX_BRP; i++) {
> +               if (!breakinfo[i].enabled)
> +                       continue;
> +               bp =3D *per_cpu_ptr(breakinfo[i].pev, cpu);
> +               if (!bp->attr.disabled) {
> +                       arch_uninstall_hw_breakpoint(bp);
> +                       bp->attr.disabled =3D 1;
> +                       continue;
> +               }
> +               if (hw_break_release_slot(i))
> +                       printk(KERN_ERR "KGDB: hw bpt remove failed %lx\n=
", breakinfo[i].addr);
> +               breakinfo[i].enabled =3D 0;
> +       }
> +       csr_xchg32(0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
> +       kgdb_watch_activated =3D 0;
> +}
> +
> +static void kgdb_correct_hw_break(void)
> +{
> +       int breakno, activated =3D 0;
> +
> +       for (breakno =3D 0; breakno < LOONGARCH_MAX_BRP; breakno++) {
> +               struct perf_event *bp;
> +               struct arch_hw_breakpoint *info;
> +               int val;
> +               int cpu =3D raw_smp_processor_id();
> +
> +               if (!breakinfo[breakno].enabled)
> +                       continue;
> +               bp =3D *per_cpu_ptr(breakinfo[breakno].pev, cpu);
> +               info =3D counter_arch_bp(bp);
> +               if (bp->attr.disabled !=3D 1)
> +                       continue;
> +               bp->attr.bp_addr =3D breakinfo[breakno].addr;
> +               bp->attr.bp_len =3D breakinfo[breakno].len;
> +               bp->attr.bp_type =3D breakinfo[breakno].type;
> +               info->address =3D breakinfo[breakno].addr;
> +               info->ctrl.len =3D breakinfo[breakno].len;
> +               info->ctrl.type =3D breakinfo[breakno].type;
> +               val =3D arch_install_hw_breakpoint(bp);
> +               if (!val)
> +                       bp->attr.disabled =3D 0;
> +               activated =3D 1;
> +       }
> +
> +       csr_xchg32(activated ? CSR_CRMD_WE : 0, CSR_CRMD_WE, LOONGARCH_CS=
R_CRMD);
> +       kgdb_watch_activated =3D activated;
> +}
> +
> +const struct kgdb_arch arch_kgdb_ops =3D {
> +       .gdb_bpt_instr          =3D {0x00, 0x00, break_op, 0x00},

Unlike our internal code repository:
.gdb_bpt_instr          =3D { 0x00, 0x00, break_op >> 1, 0x00 },

Why=EF=BC=9F

> +       .flags                  =3D KGDB_HW_BREAKPOINT,
> +       .set_hw_breakpoint      =3D kgdb_set_hw_break,
> +       .remove_hw_breakpoint   =3D kgdb_remove_hw_break,
> +       .disable_hw_break       =3D kgdb_disable_hw_debug,
> +       .remove_all_hw_break    =3D kgdb_remove_all_hw_break,
> +       .correct_hw_break       =3D kgdb_correct_hw_break,
> +};
> +
> +int kgdb_arch_handle_exception(int vector, int signo, int err_code,
> +                              char *remcom_in_buffer, char *remcom_out_b=
uffer,
> +                              struct pt_regs *regs)
> +{
> +       regs->csr_prmd |=3D CSR_PRMD_PWE;
> +
> +       switch (remcom_in_buffer[0]) {
> +       case 'c':
> +               kgdb_arch_update_addr(regs, remcom_in_buffer);
> +               return 0;
> +       }
> +
> +       return -1;
> +}
> +
> +static struct hard_trap_info {
> +       unsigned char tt;       /* Trap type code for LoongArch */
> +       unsigned char signo;    /* Signal that we map this trap into */
> +} hard_trap_info[] =3D {
> +       { 1, SIGBUS },
> +       { 2, SIGBUS },
> +       { 3, SIGBUS },
> +       { 4, SIGBUS },
> +       { 5, SIGBUS },
> +       { 6, SIGBUS },
> +       { 7, SIGBUS },
> +       { 8, SIGBUS },
> +       { 9, SIGBUS },
> +       { 10, SIGBUS },
> +       { 12, SIGTRAP },                /* break */
> +       { 13, SIGBUS },
> +       { 14, SIGBUS },
> +       { 15, SIGFPE },
> +       { 16, SIGFPE },
> +       { 17, SIGFPE },
> +       { 18, SIGFPE },
> +       { 0, 0}                 /* Must be last */
> +};
> +
> +void arch_kgdb_breakpoint(void)
> +{
> +       __asm__ __volatile__(
> +               ".globl breakinst\n\t"
> +               "nop\n"
> +               "breakinst:\tbreak 0\n\t");
> +}
> +
> +void kgdb_call_nmi_hook(void *ignored)
> +{
> +       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void kgdb_roundup_cpus(void)
> +{
> +       local_irq_enable();
> +       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> +       local_irq_disable();
> +}
> +
> +static int compute_signal(int tt)
> +{
> +       struct hard_trap_info *ht;
> +
> +       for (ht =3D hard_trap_info; ht->tt && ht->signo; ht++)
> +               if (ht->tt =3D=3D tt)
> +                       return ht->signo;
> +
> +       return SIGTRAP;         /* default for things we don't know about=
 */
> +}
> +
> +/*
> + * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
> + * then try to fall into the debugger
> + */
> +static int kgdb_loongarch_notify(struct notifier_block *self, unsigned l=
ong cmd,
> +                           void *ptr)
> +{
> +       struct die_args *args =3D (struct die_args *)ptr;
> +       struct pt_regs *regs =3D args->regs;
> +       int trap =3D read_csr_excode();
> +
> +       /* Userspace events, ignore. */
> +       if (user_mode(regs))
> +               return NOTIFY_DONE;
> +
> +       if (atomic_read(&kgdb_active) !=3D -1)
> +               kgdb_nmicallback(smp_processor_id(), regs);
> +
> +       if (kgdb_handle_exception(trap, compute_signal(trap), cmd, regs))
> +               return NOTIFY_DONE;
> +
> +       if (atomic_read(&kgdb_setting_breakpoint))
> +               if ((regs->csr_era =3D=3D (unsigned long)breakinst))
> +                       regs->csr_era +=3D 4;
> +
> +       /* In SMP mode, __flush_cache_all does IPI */
> +       local_irq_enable();
> +       flush_cache_all();
> +
> +       return NOTIFY_STOP;
> +}
> +
> +#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
> +int kgdb_ll_trap(int cmd, const char *str,
> +                struct pt_regs *regs, long err, int trap, int sig)
> +{
> +       struct die_args args =3D {
> +               .regs   =3D regs,
> +               .str    =3D str,
> +               .err    =3D err,
> +               .trapnr =3D trap,
> +               .signr  =3D sig,
> +
> +       };
> +
> +       if (!kgdb_io_module_registered)
> +               return NOTIFY_DONE;
> +
> +       return kgdb_loongarch_notify(NULL, cmd, &args);
> +}
> +#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
> +
> +static struct notifier_block kgdb_notifier =3D {
> +       .notifier_call =3D kgdb_loongarch_notify,
> +};
> +
> +int kgdb_arch_init(void)
> +{
> +       register_die_notifier(&kgdb_notifier);

I noticed that we have the following codes in our internal code repository:
       dbcn =3D csr_read32(LOONGARCH_CSR_MWPC) & 0x3f.
       ibcn =3D csr_read32(LOONGARCH_CSR_FWPC) & 0x3f.
       boot_cpu_data.watch_dreg_count =3D dbcn - kgdb_watch_dcount.
       boot_cpu_data.watch_ireg_count =3D ibcn - kgdb_watch_icount.

Why is it not needed here?

> +       return 0;
> +}
> +
> +/*
> + *     kgdb_arch_exit - Perform any architecture specific uninitalizatio=
n.
> + *
> + *     This function will handle the uninitalization of any architecture
> + *     specific callbacks, for dynamic registration and unregistration.
> + */
Incorrect comment indentation, one space is fine.

And, there are also several differences from our internal code
repository as follows:

1.
arch/loongarch/include/asm/stackframe.h
@@ -159,6 +159,10 @@
        cfi_st  u0, PT_R21, \docfi
        csrrd   u0, PERCPU_BASE_KS
 9:
+#ifdef CONFIG_KGDB
+       li.w    t0, CSR_CRMD_WE
+       csrxchg t0, t0, LOONGARCH_CSR_CRMD
+#endif
        UNWIND_HINT_REGS
        .endm

2.
arch/loongarch/kernel/entry.S
@@ -59,6 +59,10 @@ SYM_FUNC_START(handle_syscall)

        SAVE_STATIC

+#ifdef CONFIG_KGDB
+       li.w    t1, CSR_CRMD_WE
+       csrxchg t1, t1, LOONGARCH_CSR_CRMD
+#endif
        UNWIND_HINT_REGS

        move            u0, t0

Are these two changes being missed?

Thanks.
Binbin

> +void kgdb_arch_exit(void)
> +{
> +       unregister_die_notifier(&kgdb_notifier);
> +}
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.=
c
> index 22179cf6f33c..a2a220375a8a 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -695,6 +695,12 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>
>         bcode =3D (opcode & 0x7fff);
>
> +#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
> +        if (kgdb_ll_trap(DIE_TRAP, "Break", regs, code, current->thread.=
trap_nr,
> +                        SIGTRAP) =3D=3D NOTIFY_STOP)
> +               return;
> +#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
> +
>         /*
>          * notify the kprobe handlers, if instruction is likely to
>          * pertain to them.
> --
> 2.36.0
>
>
