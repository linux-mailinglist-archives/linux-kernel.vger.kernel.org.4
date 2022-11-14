Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D56278F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiKNJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236760AbiKNJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:27:00 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69FC8231
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:26:58 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8BxWtjhCXJjq9sGAA--.18977S3;
        Mon, 14 Nov 2022 17:26:57 +0800 (CST)
Received: from [10.136.12.12] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxNlfeCXJjBnsSAA--.31671S3;
        Mon, 14 Nov 2022 17:26:56 +0800 (CST)
Subject: Re: [PATCH v2 3/5] LoongArch: Add kretprobe support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
 <1664326209-13995-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7N-N2400ivdczJrfJ9Ht12JUbOADxExF87wVPFEj_c_g@mail.gmail.com>
 <dd3fc4ab-6bbb-2fa5-8d5e-b8206b42518c@loongson.cn>
 <CAAhV-H4ok2r2FarFszwYJ6Hah4m7ieNf6egnXyZhUf1ESDUhXg@mail.gmail.com>
 <a528e970-29ac-2fcb-b749-cfae3fbe5a18@loongson.cn>
 <CAAhV-H7uaFeND1-iSHmLXMFJonRTbiu81EnFGjyHZ0uN9bVXZw@mail.gmail.com>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <80db649d-ea12-796c-b76c-49933953e9a8@loongson.cn>
Date:   Mon, 14 Nov 2022 17:26:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7uaFeND1-iSHmLXMFJonRTbiu81EnFGjyHZ0uN9bVXZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxNlfeCXJjBnsSAA--.31671S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuw1kJw4xCr4DWF4fWw4rKrg_yoW3tryUpr
        WkAFn8Zr4UZrnFyr90q34Fqr97tr1kXr17WFy8Jr48Kr4qgr17Jr1UAr17CF1xGr1UJr10
        qr1rGrW3uFy5J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
        yTuYvjxUclApUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/14 下午4:51, Huacai Chen wrote:

> On Mon, Nov 14, 2022 at 4:32 PM Jinyang He <hejinyang@loongson.cn> wrote:
>> On 2022/11/14 下午2:50, Huacai Chen wrote:
>>
>>> On Mon, Nov 14, 2022 at 2:11 PM Jinyang He <hejinyang@loongson.cn> wrote:
>>>> On 2022/11/14 下午12:43, Huacai Chen wrote:
>>>>
>>>>> Hi, Tiezhu and Jinyang,
>>>>>
>>>>> On Wed, Sep 28, 2022 at 8:50 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>> Use the generic kretprobe trampoline handler to add kretprobe
>>>>>> support for LoongArch.
>>>>>>
>>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>>> ---
>>>>>>     arch/loongarch/Kconfig                     |  1 +
>>>>>>     arch/loongarch/kernel/Makefile             |  2 +-
>>>>>>     arch/loongarch/kernel/kprobes.c            | 24 ++++++++
>>>>>>     arch/loongarch/kernel/kprobes_trampoline.S | 97 ++++++++++++++++++++++++++++++
>>>>>>     4 files changed, 123 insertions(+), 1 deletion(-)
>>>>>>     create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
>>>>>>
>>>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>>>>> index 8debd70..877be6a 100644
>>>>>> --- a/arch/loongarch/Kconfig
>>>>>> +++ b/arch/loongarch/Kconfig
>>>>>> @@ -95,6 +95,7 @@ config LOONGARCH
>>>>>>            select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>>>>>            select HAVE_IRQ_TIME_ACCOUNTING
>>>>>>            select HAVE_KPROBES
>>>>>> +       select HAVE_KRETPROBES
>>>>>>            select HAVE_MOD_ARCH_SPECIFIC
>>>>>>            select HAVE_NMI
>>>>>>            select HAVE_PCI
>>>>>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>>>>>> index ff98d8a..48f50607 100644
>>>>>> --- a/arch/loongarch/kernel/Makefile
>>>>>> +++ b/arch/loongarch/kernel/Makefile
>>>>>> @@ -33,6 +33,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
>>>>>>
>>>>>>     obj-$(CONFIG_PERF_EVENTS)      += perf_event.o perf_regs.o
>>>>>>
>>>>>> -obj-$(CONFIG_KPROBES)          += kprobes.o
>>>>>> +obj-$(CONFIG_KPROBES)          += kprobes.o kprobes_trampoline.o
>>>>>>
>>>>>>     CPPFLAGS_vmlinux.lds           := $(KBUILD_CFLAGS)
>>>>>> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
>>>>>> index c11f6e0..ca3f1dc 100644
>>>>>> --- a/arch/loongarch/kernel/kprobes.c
>>>>>> +++ b/arch/loongarch/kernel/kprobes.c
>>>>>> @@ -306,6 +306,30 @@ int __init arch_populate_kprobe_blacklist(void)
>>>>>>                                             (unsigned long)__irqentry_text_end);
>>>>>>     }
>>>>>>
>>>>>> +/* Called from __kretprobe_trampoline */
>>>>>> +void __used *trampoline_probe_handler(struct pt_regs *regs)
>>>>>> +{
>>>>>> +       return (void *)kretprobe_trampoline_handler(regs, NULL);
>>>>>> +}
>>>>>> +NOKPROBE_SYMBOL(trampoline_probe_handler);
>>>>>> +
>>>>>> +void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>>>>>> +                           struct pt_regs *regs)
>>>>>> +{
>>>>>> +       ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
>>>>>> +       ri->fp = NULL;
>>>>>> +
>>>>>> +       /* Replace the return addr with trampoline addr */
>>>>>> +       regs->regs[1] = (unsigned long)&__kretprobe_trampoline;
>>>>>> +}
>>>>>> +NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>>>>>> +
>>>>>> +int arch_trampoline_kprobe(struct kprobe *p)
>>>>>> +{
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +NOKPROBE_SYMBOL(arch_trampoline_kprobe);
>>>>>> +
>>>>>>     int __init arch_init_kprobes(void)
>>>>>>     {
>>>>>>            return 0;
>>>>>> diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loongarch/kernel/kprobes_trampoline.S
>>>>>> new file mode 100644
>>>>>> index 0000000..9888ab8
>>>>>> --- /dev/null
>>>>>> +++ b/arch/loongarch/kernel/kprobes_trampoline.S
>>>>>> @@ -0,0 +1,97 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>>>> +#include <linux/linkage.h>
>>>>>> +#include <asm/stackframe.h>
>>>>>> +
>>>>>> +       .text
>>>>>> +
>>>>>> +       .macro save_all_base_regs
>>>>>> +       cfi_st  zero, PT_R0
>>>>>> +       cfi_st  ra, PT_R1
>>>>>> +       cfi_st  tp, PT_R2
>>>>>> +       cfi_st  a0, PT_R4
>>>>>> +       cfi_st  a1, PT_R5
>>>>>> +       cfi_st  a2, PT_R6
>>>>>> +       cfi_st  a3, PT_R7
>>>>>> +       cfi_st  a4, PT_R8
>>>>>> +       cfi_st  a5, PT_R9
>>>>>> +       cfi_st  a6, PT_R10
>>>>>> +       cfi_st  a7, PT_R11
>>>>>> +       cfi_st  t0, PT_R12
>>>>>> +       cfi_st  t1, PT_R13
>>>>>> +       cfi_st  t2, PT_R14
>>>>>> +       cfi_st  t3, PT_R15
>>>>>> +       cfi_st  t4, PT_R16
>>>>>> +       cfi_st  t5, PT_R17
>>>>>> +       cfi_st  t6, PT_R18
>>>>>> +       cfi_st  t7, PT_R19
>>>>>> +       cfi_st  t8, PT_R20
>>>>>> +       cfi_st  u0, PT_R21
>>>>>> +       cfi_st  fp, PT_R22
>>>>>> +       cfi_st  s0, PT_R23
>>>>>> +       cfi_st  s1, PT_R24
>>>>>> +       cfi_st  s2, PT_R25
>>>>>> +       cfi_st  s3, PT_R26
>>>>>> +       cfi_st  s4, PT_R27
>>>>>> +       cfi_st  s5, PT_R28
>>>>>> +       cfi_st  s6, PT_R29
>>>>>> +       cfi_st  s7, PT_R30
>>>>>> +       cfi_st  s8, PT_R31
>>>>>> +       addi.d  t0, sp, PT_SIZE
>>>>>> +       LONG_S  t0, sp, PT_R3
>>>>>> +       csrrd   t0, LOONGARCH_CSR_CRMD
>>>>>> +       andi    t0, t0, 0x7 /* extract bit[1:0] PLV, bit[2] IE */
>>>>>> +       LONG_S  t0, sp, PT_PRMD
>>>>>> +       .endm
>>>>>> +
>>>>>> +       .macro restore_all_base_regs
>>>>>> +       cfi_ld  zero, PT_R0
>>>>>> +       cfi_ld  tp, PT_R2
>>>>>> +       cfi_ld  a0, PT_R4
>>>>>> +       cfi_ld  a1, PT_R5
>>>>>> +       cfi_ld  a2, PT_R6
>>>>>> +       cfi_ld  a3, PT_R7
>>>>>> +       cfi_ld  a4, PT_R8
>>>>>> +       cfi_ld  a5, PT_R9
>>>>>> +       cfi_ld  a6, PT_R10
>>>>>> +       cfi_ld  a7, PT_R11
>>>>>> +       cfi_ld  t0, PT_R12
>>>>>> +       cfi_ld  t1, PT_R13
>>>>>> +       cfi_ld  t2, PT_R14
>>>>>> +       cfi_ld  t3, PT_R15
>>>>>> +       cfi_ld  t4, PT_R16
>>>>>> +       cfi_ld  t5, PT_R17
>>>>>> +       cfi_ld  t6, PT_R18
>>>>>> +       cfi_ld  t7, PT_R19
>>>>>> +       cfi_ld  t8, PT_R20
>>>>>> +       cfi_ld  u0, PT_R21
>>>>>> +       cfi_ld  fp, PT_R22
>>>>>> +       cfi_ld  s0, PT_R23
>>>>>> +       cfi_ld  s1, PT_R24
>>>>>> +       cfi_ld  s2, PT_R25
>>>>>> +       cfi_ld  s3, PT_R26
>>>>>> +       cfi_ld  s4, PT_R27
>>>>>> +       cfi_ld  s5, PT_R28
>>>>>> +       cfi_ld  s6, PT_R29
>>>>>> +       cfi_ld  s7, PT_R30
>>>>>> +       cfi_ld  s8, PT_R31
>>>>>> +       LONG_L  t0, sp, PT_PRMD
>>>>>> +       li.d    t1, 0x7 /* mask bit[1:0] PLV, bit[2] IE */
>>>>>> +       csrxchg t0, t1, LOONGARCH_CSR_CRMD
>>>>>> +       .endm
>>>>> Do you think we need to save and restore all regs here?
>>>>>
>>>>> Huacai
>>>> Hi, Huacai,
>>>>
>>>>
>>>> Note that it is not function context. In the original kprobe design, it is
>>>> triggered by 'break' and then trap into exception with all pt_regs saved.
>>>> The all pt_regs will be visible to the user. So I think in this version
>>>> we should also support all regs to user. BTW, due to all exceptions is
>>>> trapped by 'break' something in pt_regs is not needed, like estat,
>>>> badvaddr and so on.
>>> OK, but I still have some questions:
>>> 1, Why $r0 need save/restore?
>> Surely $r0 can be not saved, as now we do not have strange purpose
>> to make PT_R0 as a flag.
>>
>>
>>> 2, Why save $r1 but not restore?
>> My wrong idea is $r1 should be saved at CSR_ERA, to plays it like
>> exception happened. But its value always equal the address of
>> __kretprobe_trampoline. The kretprobe is something like fgraph. The real
>> return address is returned by trampoline_probe_handler. And at present,
>> the real return address is replaced in pt_regs->csr_era in
>> __kretprobe_trampoline_handler(). So the $r1 saved in CSR_ERA will
>> be destroied at __kretprobe_trampoline_handler() actually.
>> That's why $r1 saved also is not needed.
>>
>> And both way to get return address from return value or get return address
>>
>> from pt_regs is same on LoongArch because arch_kretprobe_fixup_return()
>>
>> does nothing. But I think get return address from pt_regs is more reliable.
>>
>>
>>> 3, What is the purpose of CRMD magic?
>> PT_CRMD magic is just exception context. It gives us a chance e.g.
>> set ie off at func head, and ie on at func return.
> ARM64 and RISC-V don't have such magics, so maybe they are unneeded?
>
ARM64 have noted "Construct a useful saved PSTATE" in kprobes_trampoline.S.

And it seems we provide more interfaces than RISC-V. ?


Thanks,

Jinyang


>>>>>> +
>>>>>> +SYM_CODE_START(__kretprobe_trampoline)
>>>>>> +       addi.d  sp, sp, -PT_SIZE
>>>>>> +       save_all_base_regs
>>>>>> +
>>>>>> +       move a0, sp /* pt_regs */
>>>>>> +
>>>>>> +       bl trampoline_probe_handler
>>>>>> +
>>>>>> +       /* use the result as the return-address */
>>>>>> +       move ra, a0
>>>>>> +
>>>>>> +       restore_all_base_regs
>>>>>> +       addi.d  sp, sp, PT_SIZE
>>>>>> +
>>>>>> +       jr ra
>>>>>> +SYM_CODE_END(__kretprobe_trampoline)
>>>>>> --
>>>>>> 2.1.0
>>>>>>
>>>>>>

