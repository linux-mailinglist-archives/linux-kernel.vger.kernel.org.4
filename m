Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF600743285
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF3CHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjF3CHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:07:04 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70B33AA7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:07:00 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx38fCOJ5kWx0EAA--.6594S3;
        Fri, 30 Jun 2023 10:06:58 +0800 (CST)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSPBOJ5khnYSAA--.14368S3;
        Fri, 30 Jun 2023 10:06:58 +0800 (CST)
Subject: Re: [RFC PATCH] LoongArch: KGDB: Add Basic KGDB support
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230620131251.30483-1-zhangqing@loongson.cn>
 <CAMpQs4+Y+FNhuZcUM8FkXyKU6mhqEWXyDYPC3UdJYwps-_PgwA@mail.gmail.com>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <1b4008d7-2000-d275-0e12-84b3b1c77304@loongson.cn>
Date:   Fri, 30 Jun 2023 10:06:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMpQs4+Y+FNhuZcUM8FkXyKU6mhqEWXyDYPC3UdJYwps-_PgwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxbSPBOJ5khnYSAA--.14368S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9fXoWfuF4rXrykCFy7ZFWrGr4kuFX_yoW8tF4DJo
        W5AF4qyr4xJF12yFZxJ34DWF4DZw15Gw1kAFZ5Awsxu3W5Ka4jgr4ay3Wjvr43CF18Jr4U
        Ca45X39ava4DKr1rl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
        9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
        UjIYCTnIWjp_UUUYW7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
        8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc zhangqing.qz@outlook.com +cc zhangqing199801@gmail.com

Hi, Binbin

Thank you, the relevant personnel of the company will fix it

and send the new version.


-Qing

On 2023/6/21 下午2:24, Binbin Zhou wrote:
> Hi Qing:
>
> On Tue, Jun 20, 2023 at 9:13 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>> Add Kgdb debug support for LoongArch kernel debugging, more support
>> and testing is working in progress.
>>
>> Kgdb is intended to be used as a source level debugger for thekernel,
>> It is used along with gdb to debug a kernel. The expectation is that
>> gdb can be used to "break in" to the kernel to inspect memory, variables
>> and look through call stack information similar to the way an application
>> developer would use gdb to debug an application.
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 79412304a01f..dd823823b7fc 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -85,6 +85,7 @@ config LOONGARCH
>>          select GPIOLIB
>>          select HAS_IOPORT
>>          select HAVE_ARCH_AUDITSYSCALL
>> +       select HAVE_ARCH_KGDB
> Please list the Kconfig options in alphabetical order.
>>          select HAVE_ARCH_JUMP_LABEL
>>          select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>          select HAVE_ARCH_MMAP_RND_BITS if MMU
>> diff --git a/arch/loongarch/include/asm/kgdb.h b/arch/loongarch/include/asm/kgdb.h
>> new file mode 100644
>> index 000000000000..35ef7a46beb5
>> --- /dev/null
>> +++ b/arch/loongarch/include/asm/kgdb.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_LOONGARCH_KGDB_H
>> +#define _ASM_LOONGARCH_KGDB_H
>> +
>> +#define KGDB_GDB_REG_SIZE       64
>> +#define GDB_SIZEOF_REG          sizeof(u64)
>> +
>> +#define BUFMAX                  2048
>> +#define DBG_ALL_REG_NUM         78
>> +#define DBG_MAX_REG_NUM         33
>> +#define NUMREGBYTES             (DBG_MAX_REG_NUM * sizeof(GDB_SIZEOF_REG))
>> +#define NUMCRITREGBYTES         (12 * sizeof(GDB_SIZEOF_REG))
>> +#define BREAK_INSTR_SIZE        4
>> +#define CACHE_FLUSH_IS_SAFE     0
>> +
>> +extern void arch_kgdb_breakpoint(void);
>> +extern void *saved_vectors[32];
>> +extern void handle_exception(struct pt_regs *regs);
>> +extern void breakinst(void);
>> +extern int kgdb_ll_trap(int cmd, const char *str,
>> +                       struct pt_regs *regs, long err, int trap, int sig);
>> +
>> +#endif /* __ASM_KGDB_H_ */
>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>> index 8e279f04f9e7..cbe109cd93ba 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -60,4 +60,6 @@ obj-$(CONFIG_UPROBES)         += uprobes.o
>>
>>   obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
>>
>> +obj-$(CONFIG_KGDB)             += kgdb.o
>> +
>>   CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
>> diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
>> new file mode 100755
>> index 000000000000..ecd9ec873cf7
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/kgdb.c
>> @@ -0,0 +1,584 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 Loongson Technology Corporation Limited
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/ptrace.h>              /* for linux pt_regs struct */
>> +#include <linux/hw_breakpoint.h>
>> +#include <linux/kgdb.h>
>> +#include <linux/kdebug.h>
>> +#include <linux/sched.h>
>> +#include <linux/smp.h>
>> +#include <asm/inst.h>
>> +#include <asm/fpu.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/processor.h>
>> +#include <asm/sigcontext.h>
>> +#include <asm/irq_regs.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/hw_breakpoint.h>
>> +int kgdb_watch_activated;
>> +
>> +struct dbg_reg_def_t dbg_reg_def[DBG_ALL_REG_NUM] = {
>> +       { "r0", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[0]) },
>> +       { "r1", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[1]) },
>> +       { "r2", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[2]) },
>> +       { "r3", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[3]) },
>> +       { "r4", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[4]) },
>> +       { "r5", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[5]) },
>> +       { "r6", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[6]) },
>> +       { "r7", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[7]) },
>> +       { "r8", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[8]) },
>> +       { "r9", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[9]) },
>> +       { "r10", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[10]) },
>> +       { "r11", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[11]) },
>> +       { "r12", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[12]) },
>> +       { "r13", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[13]) },
>> +       { "r14", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[14]) },
>> +       { "r15", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[15]) },
>> +       { "r16", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[16]) },
>> +       { "r17", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[17]) },
>> +       { "r18", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[18]) },
>> +       { "r19", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[19]) },
>> +       { "r20", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[20]) },
>> +       { "r21", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[21]) },
>> +       { "r22", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[22]) },
>> +       { "r23", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[23]) },
>> +       { "r24", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[24]) },
>> +       { "r25", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[25]) },
>> +       { "r26", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[26]) },
>> +       { "r27", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[27]) },
>> +       { "r28", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[28]) },
>> +       { "r29", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[29]) },
>> +       { "r30", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[30]) },
>> +       { "r31", GDB_SIZEOF_REG, offsetof(struct pt_regs, regs[31]) },
>> +       { "pc", GDB_SIZEOF_REG, offsetof(struct pt_regs, csr_era) },
>> +       { "f0", GDB_SIZEOF_REG, 0 },
>> +       { "f1", GDB_SIZEOF_REG, 1 },
>> +       { "f2", GDB_SIZEOF_REG, 2 },
>> +       { "f3", GDB_SIZEOF_REG, 3 },
>> +       { "f4", GDB_SIZEOF_REG, 4 },
>> +       { "f5", GDB_SIZEOF_REG, 5 },
>> +       { "f6", GDB_SIZEOF_REG, 6 },
>> +       { "f7", GDB_SIZEOF_REG, 7 },
>> +       { "f8", GDB_SIZEOF_REG, 8 },
>> +       { "f9", GDB_SIZEOF_REG, 9 },
>> +       { "f10", GDB_SIZEOF_REG, 10 },
>> +       { "f11", GDB_SIZEOF_REG, 11 },
>> +       { "f12", GDB_SIZEOF_REG, 12 },
>> +       { "f13", GDB_SIZEOF_REG, 13 },
>> +       { "f14", GDB_SIZEOF_REG, 14 },
>> +       { "f15", GDB_SIZEOF_REG, 15 },
>> +       { "f16", GDB_SIZEOF_REG, 16 },
>> +       { "f17", GDB_SIZEOF_REG, 17 },
>> +       { "f18", GDB_SIZEOF_REG, 18 },
>> +       { "f19", GDB_SIZEOF_REG, 19 },
>> +       { "f20", GDB_SIZEOF_REG, 20 },
>> +       { "f21", GDB_SIZEOF_REG, 21 },
>> +       { "f22", GDB_SIZEOF_REG, 22 },
>> +       { "f23", GDB_SIZEOF_REG, 23 },
>> +       { "f24", GDB_SIZEOF_REG, 24 },
>> +       { "f25", GDB_SIZEOF_REG, 25 },
>> +       { "f26", GDB_SIZEOF_REG, 26 },
>> +       { "f27", GDB_SIZEOF_REG, 27 },
>> +       { "f28", GDB_SIZEOF_REG, 28 },
>> +       { "f29", GDB_SIZEOF_REG, 29 },
>> +       { "f30", GDB_SIZEOF_REG, 30 },
>> +       { "f31", GDB_SIZEOF_REG, 31 },
>> +       { "fcc0", 1, 0 },
>> +       { "fcc1", 1, 1 },
>> +       { "fcc2", 1, 2 },
>> +       { "fcc3", 1, 3 },
>> +       { "fcc4", 1, 4 },
>> +       { "fcc5", 1, 5 },
>> +       { "fcc6", 1, 6 },
>> +       { "fcc7", 1, 7 },
>> +       { "fcsr", GDB_SIZEOF_REG, 0 },
>> +       { "scr0", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr0) },
>> +       { "scr1", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr1) },
>> +       { "scr2", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr2) },
>> +       { "scr3", GDB_SIZEOF_REG, offsetof(struct thread_struct, scr2) },
>> +};
>> +
>> +int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>> +{
>> +       int fp_reg;
>> +
>> +       if (regno < 0 || regno >= DBG_ALL_REG_NUM)
>> +               return -EINVAL;
>> +
>> +       if (dbg_reg_def[regno].offset != -1 && regno < 33) {
>> +               memcpy((void *)regs + dbg_reg_def[regno].offset, mem,
>> +                      dbg_reg_def[regno].size);
>> +       } else if (current && dbg_reg_def[regno].offset != -1 && regno < 78) {
>> +               /* FP registers 32 -> 77 */
>> +               if (!(regs->csr_euen & CSR_EUEN_FPEN))
>> +                       return 0;
>> +               if (regno == 72) {
>> +                       /* Process the fcsr/fsr (register 70) */
>> +                       memcpy((void *)&current->thread.fpu.fcsr, mem,
>> +                              dbg_reg_def[regno].size);
>> +               } else if (regno >= 64 && regno < 72) {
>> +                       /* Process the fcc */
>> +                       fp_reg = dbg_reg_def[regno].offset;
>> +                       memcpy((char *)&current->thread.fpu.fcc + fp_reg, mem,
>> +                              dbg_reg_def[regno].size);
>> +               } else if (regno >= 73 && regno < 77) {
>> +                       /* Process the scr */
>> +                       memcpy((void *)&current->thread + dbg_reg_def[regno].offset, mem,
>> +                              dbg_reg_def[regno].size);
>> +               } else {
>> +                       fp_reg = dbg_reg_def[regno].offset;
>> +                       memcpy((void *)&current->thread.fpu.fpr[fp_reg], mem, dbg_reg_def[regno].size);
>> +               }
>> +               restore_fp(current);
>> +       }
> Would it be better to change if-else to switch-case?
>> +
>> +       return 0;
>> +}
>> +
>> +char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>> +{
>> +       int fp_reg;
>> +
>> +       if (regno >= DBG_ALL_REG_NUM || regno < 0)
>> +               return NULL;
>> +
>> +       if (dbg_reg_def[regno].offset != -1 && regno < 33) {
>> +               /* First 32 registers */
>> +               memcpy(mem, (void *)regs + dbg_reg_def[regno].offset,
>> +                      dbg_reg_def[regno].size);
>> +       } else if (current && dbg_reg_def[regno].offset != -1 && regno < 78) {
>> +               /* FP registers 32 -> 77 */
>> +               if (!(regs->csr_euen & CSR_EUEN_FPEN))
>> +                       goto out;
>> +               save_fp(current);
>> +               if (regno == 72) {
>> +                       /* Process the fcsr/fsr (register 70) */
>> +                       memcpy(mem, (void *)&current->thread.fpu.fcsr,
>> +                              dbg_reg_def[regno].size);
>> +               } else if (regno >= 64 && regno < 72) {
>> +                       /* Process the fcc */
>> +                       fp_reg = dbg_reg_def[regno].offset;
>> +                       memcpy(mem, (char *)&current->thread.fpu.fcc + fp_reg,
>> +                              dbg_reg_def[regno].size);
>> +               } else if (regno >= 73 && regno < 77) {
>> +                       /* Process the scr */
>> +                       memcpy(mem, (void *)&current->thread + dbg_reg_def[regno].offset,
>> +                              dbg_reg_def[regno].size);
>> +               } else {
>> +                       fp_reg = dbg_reg_def[regno].offset;
>> +                       memcpy(mem, (void *)&current->thread.fpu.fpr[fp_reg], dbg_reg_def[regno].size);
>> +               }
>> +       }
> Ditto.
>
>> +out:
>> +       return dbg_reg_def[regno].name;
>> +
>> +}
>> +
>> +void sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *p)
>> +{
>> +       int reg;
>> +       u64 *ptr = (u64 *)gdb_regs, *gdbregs = ptr;
>> +
>> +       *(ptr++) = 0;
>> +       *(ptr++) = p->thread.reg01;
>> +       *(ptr++) = (long)p;
>> +       *(ptr++) = p->thread.reg03;
>> +       for (reg = 4; reg < 23; reg++)
>> +               *(ptr++) = 0;
>> +
>> +       /* S0 - S8 */
>> +       *(ptr++) = p->thread.reg23;
>> +       *(ptr++) = p->thread.reg24;
>> +       *(ptr++) = p->thread.reg25;
>> +       *(ptr++) = p->thread.reg26;
>> +       *(ptr++) = p->thread.reg27;
>> +       *(ptr++) = p->thread.reg28;
>> +       *(ptr++) = p->thread.reg29;
>> +       *(ptr++) = p->thread.reg30;
>> +       *(ptr++) = p->thread.reg31;
>> +
>> +       /*
>> +        * PC
>> +        * use return address (RA), i.e. the moment after return from resume()
>> +        */
>> +       *(ptr++) = p->thread.reg01;
>> +
>> +       ptr = gdbregs + 73;
>> +       *(ptr++) = p->thread.scr0;
>> +       *(ptr++) = p->thread.scr1;
>> +       *(ptr++) = p->thread.scr2;
>> +       *(ptr++) = p->thread.scr3;
>> +}
>> +
>> +void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>> +{
>> +       regs->csr_era = pc;
>> +}
>> +
>> +static inline void kgdb_arch_update_addr(struct pt_regs *regs,
>> +                                        char *remcom_in_buffer)
>> +{
>> +       unsigned long addr;
>> +       char *ptr;
>> +
>> +       ptr = &remcom_in_buffer[1];
>> +       if (kgdb_hex2long(&ptr, &addr))
>> +               regs->csr_era = addr;
>> +}
>> +
>> +static struct hw_breakpoint {
>> +       unsigned                enabled;
>> +       unsigned long           addr;
>> +       int                     len;
>> +       int                     type;
>> +       struct perf_event       * __percpu *pev;
>> +} breakinfo[LOONGARCH_MAX_BRP];
>> +
>> +static int hw_break_reserve_slot(int breakno)
>> +{
>> +       int cpu;
>> +       int cnt = 0;
>> +       struct perf_event **pevent;
>> +
>> +       for_each_online_cpu(cpu) {
>> +               cnt++;
>> +               pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
>> +               if (dbg_reserve_bp_slot(*pevent))
>> +                       goto fail;
>> +       }
>> +
>> +       return 0;
>> +
>> +fail:
>> +       for_each_online_cpu(cpu) {
>> +               cnt--;
>> +               if (!cnt)
>> +                       break;
>> +               pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
>> +               dbg_release_bp_slot(*pevent);
>> +       }
>> +       return -1;
>> +}
>> +
>> +static int hw_break_release_slot(int breakno)
>> +{
>> +       struct perf_event **pevent;
>> +       int cpu;
>> +
>> +       if (dbg_is_early)
>> +               return 0;
>> +
>> +       for_each_online_cpu(cpu) {
>> +               pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
>> +               if (dbg_release_bp_slot(*pevent))
>> +                       /*
>> +                        * The debugger is responsible for handing the retry on
>> +                        * remove failure.
>> +                        */
>> +                       return -1;
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int
>> +kgdb_set_hw_break(unsigned long addr, int len, enum kgdb_bptype bptype)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < LOONGARCH_MAX_BRP; i++)
>> +               if (!breakinfo[i].enabled)
>> +                       break;
>> +       if (i == LOONGARCH_MAX_BRP)
>> +               return -1;
>> +
>> +       switch (bptype) {
>> +       case BP_HARDWARE_BREAKPOINT:
>> +               len = 1;
>> +               breakinfo[i].type = LOONGARCH_BREAKPOINT_EXECUTE;
>> +               break;
>> +       case BP_WRITE_WATCHPOINT:
>> +               breakinfo[i].type = LOONGARCH_BREAKPOINT_STORE;
>> +               break;
>> +       case BP_ACCESS_WATCHPOINT:
>> +               breakinfo[i].type = LOONGARCH_BREAKPOINT_LOAD && LOONGARCH_BREAKPOINT_STORE;
>> +               break;
>> +       default:
>> +               return -1;
>> +       }
>> +       switch (len) {
>> +       case 1:
>> +               breakinfo[i].len = LOONGARCH_BREAKPOINT_LEN_1;
>> +               break;
>> +       case 2:
>> +               breakinfo[i].len = LOONGARCH_BREAKPOINT_LEN_2;
>> +               break;
>> +       case 4:
>> +               breakinfo[i].len = LOONGARCH_BREAKPOINT_LEN_4;
>> +               break;
>> +       case 8:
>> +               breakinfo[i].len = LOONGARCH_BREAKPOINT_LEN_8;
>> +               break;
>> +       default:
>> +               return -1;
>> +       }
>> +       breakinfo[i].addr = addr;
>> +       if (hw_break_reserve_slot(i)) {
>> +               breakinfo[i].addr = 0;
>> +               return -1;
>> +       }
>> +       breakinfo[i].enabled = 1;
>> +
>> +       return 0;
>> +}
>> +
>> +static int
>> +kgdb_remove_hw_break(unsigned long addr, int len, enum kgdb_bptype bptype)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < LOONGARCH_MAX_BRP; i++)
>> +               if (breakinfo[i].addr == addr && breakinfo[i].enabled)
>> +                       break;
>> +       if (i == LOONGARCH_MAX_BRP)
>> +               return -1;
>> +
>> +       if (hw_break_release_slot(i)) {
>> +               printk(KERN_ERR "Cannot remove hw breakpoint at %lx\n", addr);
>> +               return -1;
>> +       }
>> +       breakinfo[i].enabled = 0;
>> +
>> +       return 0;
>> +}
>> +
>> +static void kgdb_disable_hw_debug(struct pt_regs *regs)
>> +{
>> +       int i;
>> +       int cpu = raw_smp_processor_id();
>> +       struct perf_event *bp;
>> +
>> +       /* Disable hardware debugging while we are in kgdb: */
>> +       csr_xchg32(0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
>> +       regs->csr_prmd &= ~CSR_PRMD_PWE;
>> +
>> +       for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
>> +               if (!breakinfo[i].enabled)
>> +                       continue;
>> +               bp = *per_cpu_ptr(breakinfo[i].pev, cpu);
>> +               if (bp->attr.disabled == 1)
>> +                       continue;
>> +               arch_uninstall_hw_breakpoint(bp);
>> +               bp->attr.disabled = 1;
>> +       }
>> +}
>> +
>> +static void kgdb_remove_all_hw_break(void)
>> +{
>> +       int i;
>> +       int cpu = raw_smp_processor_id();
>> +       struct perf_event *bp;
>> +
>> +       for (i = 0; i < LOONGARCH_MAX_BRP; i++) {
>> +               if (!breakinfo[i].enabled)
>> +                       continue;
>> +               bp = *per_cpu_ptr(breakinfo[i].pev, cpu);
>> +               if (!bp->attr.disabled) {
>> +                       arch_uninstall_hw_breakpoint(bp);
>> +                       bp->attr.disabled = 1;
>> +                       continue;
>> +               }
>> +               if (hw_break_release_slot(i))
>> +                       printk(KERN_ERR "KGDB: hw bpt remove failed %lx\n", breakinfo[i].addr);
>> +               breakinfo[i].enabled = 0;
>> +       }
>> +       csr_xchg32(0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
>> +       kgdb_watch_activated = 0;
>> +}
>> +
>> +static void kgdb_correct_hw_break(void)
>> +{
>> +       int breakno, activated = 0;
>> +
>> +       for (breakno = 0; breakno < LOONGARCH_MAX_BRP; breakno++) {
>> +               struct perf_event *bp;
>> +               struct arch_hw_breakpoint *info;
>> +               int val;
>> +               int cpu = raw_smp_processor_id();
>> +
>> +               if (!breakinfo[breakno].enabled)
>> +                       continue;
>> +               bp = *per_cpu_ptr(breakinfo[breakno].pev, cpu);
>> +               info = counter_arch_bp(bp);
>> +               if (bp->attr.disabled != 1)
>> +                       continue;
>> +               bp->attr.bp_addr = breakinfo[breakno].addr;
>> +               bp->attr.bp_len = breakinfo[breakno].len;
>> +               bp->attr.bp_type = breakinfo[breakno].type;
>> +               info->address = breakinfo[breakno].addr;
>> +               info->ctrl.len = breakinfo[breakno].len;
>> +               info->ctrl.type = breakinfo[breakno].type;
>> +               val = arch_install_hw_breakpoint(bp);
>> +               if (!val)
>> +                       bp->attr.disabled = 0;
>> +               activated = 1;
>> +       }
>> +
>> +       csr_xchg32(activated ? CSR_CRMD_WE : 0, CSR_CRMD_WE, LOONGARCH_CSR_CRMD);
>> +       kgdb_watch_activated = activated;
>> +}
>> +
>> +const struct kgdb_arch arch_kgdb_ops = {
>> +       .gdb_bpt_instr          = {0x00, 0x00, break_op, 0x00},
> Unlike our internal code repository:
> .gdb_bpt_instr          = { 0x00, 0x00, break_op >> 1, 0x00 },
>
> Why？
>
>> +       .flags                  = KGDB_HW_BREAKPOINT,
>> +       .set_hw_breakpoint      = kgdb_set_hw_break,
>> +       .remove_hw_breakpoint   = kgdb_remove_hw_break,
>> +       .disable_hw_break       = kgdb_disable_hw_debug,
>> +       .remove_all_hw_break    = kgdb_remove_all_hw_break,
>> +       .correct_hw_break       = kgdb_correct_hw_break,
>> +};
>> +
>> +int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>> +                              char *remcom_in_buffer, char *remcom_out_buffer,
>> +                              struct pt_regs *regs)
>> +{
>> +       regs->csr_prmd |= CSR_PRMD_PWE;
>> +
>> +       switch (remcom_in_buffer[0]) {
>> +       case 'c':
>> +               kgdb_arch_update_addr(regs, remcom_in_buffer);
>> +               return 0;
>> +       }
>> +
>> +       return -1;
>> +}
>> +
>> +static struct hard_trap_info {
>> +       unsigned char tt;       /* Trap type code for LoongArch */
>> +       unsigned char signo;    /* Signal that we map this trap into */
>> +} hard_trap_info[] = {
>> +       { 1, SIGBUS },
>> +       { 2, SIGBUS },
>> +       { 3, SIGBUS },
>> +       { 4, SIGBUS },
>> +       { 5, SIGBUS },
>> +       { 6, SIGBUS },
>> +       { 7, SIGBUS },
>> +       { 8, SIGBUS },
>> +       { 9, SIGBUS },
>> +       { 10, SIGBUS },
>> +       { 12, SIGTRAP },                /* break */
>> +       { 13, SIGBUS },
>> +       { 14, SIGBUS },
>> +       { 15, SIGFPE },
>> +       { 16, SIGFPE },
>> +       { 17, SIGFPE },
>> +       { 18, SIGFPE },
>> +       { 0, 0}                 /* Must be last */
>> +};
>> +
>> +void arch_kgdb_breakpoint(void)
>> +{
>> +       __asm__ __volatile__(
>> +               ".globl breakinst\n\t"
>> +               "nop\n"
>> +               "breakinst:\tbreak 0\n\t");
>> +}
>> +
>> +void kgdb_call_nmi_hook(void *ignored)
>> +{
>> +       kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
>> +}
>> +
>> +void kgdb_roundup_cpus(void)
>> +{
>> +       local_irq_enable();
>> +       smp_call_function(kgdb_call_nmi_hook, NULL, 0);
>> +       local_irq_disable();
>> +}
>> +
>> +static int compute_signal(int tt)
>> +{
>> +       struct hard_trap_info *ht;
>> +
>> +       for (ht = hard_trap_info; ht->tt && ht->signo; ht++)
>> +               if (ht->tt == tt)
>> +                       return ht->signo;
>> +
>> +       return SIGTRAP;         /* default for things we don't know about */
>> +}
>> +
>> +/*
>> + * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
>> + * then try to fall into the debugger
>> + */
>> +static int kgdb_loongarch_notify(struct notifier_block *self, unsigned long cmd,
>> +                           void *ptr)
>> +{
>> +       struct die_args *args = (struct die_args *)ptr;
>> +       struct pt_regs *regs = args->regs;
>> +       int trap = read_csr_excode();
>> +
>> +       /* Userspace events, ignore. */
>> +       if (user_mode(regs))
>> +               return NOTIFY_DONE;
>> +
>> +       if (atomic_read(&kgdb_active) != -1)
>> +               kgdb_nmicallback(smp_processor_id(), regs);
>> +
>> +       if (kgdb_handle_exception(trap, compute_signal(trap), cmd, regs))
>> +               return NOTIFY_DONE;
>> +
>> +       if (atomic_read(&kgdb_setting_breakpoint))
>> +               if ((regs->csr_era == (unsigned long)breakinst))
>> +                       regs->csr_era += 4;
>> +
>> +       /* In SMP mode, __flush_cache_all does IPI */
>> +       local_irq_enable();
>> +       flush_cache_all();
>> +
>> +       return NOTIFY_STOP;
>> +}
>> +
>> +#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
>> +int kgdb_ll_trap(int cmd, const char *str,
>> +                struct pt_regs *regs, long err, int trap, int sig)
>> +{
>> +       struct die_args args = {
>> +               .regs   = regs,
>> +               .str    = str,
>> +               .err    = err,
>> +               .trapnr = trap,
>> +               .signr  = sig,
>> +
>> +       };
>> +
>> +       if (!kgdb_io_module_registered)
>> +               return NOTIFY_DONE;
>> +
>> +       return kgdb_loongarch_notify(NULL, cmd, &args);
>> +}
>> +#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
>> +
>> +static struct notifier_block kgdb_notifier = {
>> +       .notifier_call = kgdb_loongarch_notify,
>> +};
>> +
>> +int kgdb_arch_init(void)
>> +{
>> +       register_die_notifier(&kgdb_notifier);
> I noticed that we have the following codes in our internal code repository:
>         dbcn = csr_read32(LOONGARCH_CSR_MWPC) & 0x3f.
>         ibcn = csr_read32(LOONGARCH_CSR_FWPC) & 0x3f.
>         boot_cpu_data.watch_dreg_count = dbcn - kgdb_watch_dcount.
>         boot_cpu_data.watch_ireg_count = ibcn - kgdb_watch_icount.
>
> Why is it not needed here?
>
>> +       return 0;
>> +}
>> +
>> +/*
>> + *     kgdb_arch_exit - Perform any architecture specific uninitalization.
>> + *
>> + *     This function will handle the uninitalization of any architecture
>> + *     specific callbacks, for dynamic registration and unregistration.
>> + */
> Incorrect comment indentation, one space is fine.
>
> And, there are also several differences from our internal code
> repository as follows:
>
> 1.
> arch/loongarch/include/asm/stackframe.h
> @@ -159,6 +159,10 @@
>          cfi_st  u0, PT_R21, \docfi
>          csrrd   u0, PERCPU_BASE_KS
>   9:
> +#ifdef CONFIG_KGDB
> +       li.w    t0, CSR_CRMD_WE
> +       csrxchg t0, t0, LOONGARCH_CSR_CRMD
> +#endif
>          UNWIND_HINT_REGS
>          .endm
>
> 2.
> arch/loongarch/kernel/entry.S
> @@ -59,6 +59,10 @@ SYM_FUNC_START(handle_syscall)
>
>          SAVE_STATIC
>
> +#ifdef CONFIG_KGDB
> +       li.w    t1, CSR_CRMD_WE
> +       csrxchg t1, t1, LOONGARCH_CSR_CRMD
> +#endif
>          UNWIND_HINT_REGS
>
>          move            u0, t0
>
> Are these two changes being missed?
>
> Thanks.
> Binbin
>
>> +void kgdb_arch_exit(void)
>> +{
>> +       unregister_die_notifier(&kgdb_notifier);
>> +}
>> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
>> index 22179cf6f33c..a2a220375a8a 100644
>> --- a/arch/loongarch/kernel/traps.c
>> +++ b/arch/loongarch/kernel/traps.c
>> @@ -695,6 +695,12 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
>>
>>          bcode = (opcode & 0x7fff);
>>
>> +#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
>> +        if (kgdb_ll_trap(DIE_TRAP, "Break", regs, code, current->thread.trap_nr,
>> +                        SIGTRAP) == NOTIFY_STOP)
>> +               return;
>> +#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
>> +
>>          /*
>>           * notify the kprobe handlers, if instruction is likely to
>>           * pertain to them.
>> --
>> 2.36.0
>>
>>

