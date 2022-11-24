Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7256372DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKXHRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXHRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:17:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706F5B5B3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:10:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y4so722308plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 23:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jja9XTQbcOpxJT6BC92l/ktRp5NVTN5aRcgCJwanFfA=;
        b=SWUFjLgJc1E4JHHUvLXO0xDd2lJtF3chzFZ1pcpzGOOebm3/hHsUZyxVRuKPmDiSxV
         /ZVa7YW9ydPtlxA8U3I15ohFDvVIYxDmqIAVn4zmZTUSkeWGGK98/xsk3SoOWSN2zJ1h
         fA2tr6gRP389utSUgOG3DXo0trpnSWSb7Wr28KlYG9/7GKtx6uKPsSpvy6S7gx5qJy5N
         G+tLzH792WiMr4pkDM91h8nUIf/27AiiWJWYQYsOtkMkSfWpyYMcFlvYDZ1LsNVi8cAs
         wrdQNl7vPan7iewLHSLrOm3bd8peiRZnfa7Oh0YMuYny5pts0985uBFvuwuWeNPPz3D4
         OdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jja9XTQbcOpxJT6BC92l/ktRp5NVTN5aRcgCJwanFfA=;
        b=wDrFgtfXnm/ezHvLeUHGkD2Gy4CR/mGLNFaG1fy5WfIRvqnfNCYiLLOS1ROFxL9C1R
         oV0NQo9qD4/opZ1rDep71T9E+xZ7PPxdzvnugiv1215atBjVHqJaEFrKmrsfUGDU+hNh
         OUc2mtCoN4ORNvjsr9Wjiq+gMNRDY5rySMpP/4WQ7nMOcU7RW7R+7xG5kPNQzOE5wjQH
         4EW/thr2IJWiaAlwzOo37UxBfrlQTiPFdXMn/UzPB7HFFTZLkZ+DT+S/5fRmrSEPkcAS
         buk8zowq8WdWO6XXioCGU2o1MDY6uTp/wF95xMa33iqzB26jnc2zDaYSRTUyoFgfjwku
         HR7g==
X-Gm-Message-State: ANoB5plceuwWJTMlbvjqEsDpD5Ue4FECJj8P137h1cgOWILRuh+OZScz
        r5CKkE08Rq5fCwTDmoo4x6M04az8yaozhQ==
X-Google-Smtp-Source: AA0mqf46uF4U3SzITdseV4srQ5vSJuGw4m7D2wUMptgEYy098/aAeelhHnQRbXn5iwO08yg7iMcdAA==
X-Received: by 2002:a17:902:9889:b0:186:5f82:3812 with SMTP id s9-20020a170902988900b001865f823812mr19689939plp.51.1669273824886;
        Wed, 23 Nov 2022 23:10:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b00183c6784704sm375608pls.291.2022.11.23.23.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:10:24 -0800 (PST)
Date:   Wed, 23 Nov 2022 23:10:22 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221124071022.GA1149630@debug.ba.rivosinc.com>
References: <20221124005006.1788315-1-debug@rivosinc.com>
 <CAJF2gTQ=Vr6neABtz9JSCei6oPEsyWTpb-Y=Rxt5jy6n1VEtGA@mail.gmail.com>
 <CAKC1njRfxNx8r5SP7qsbouCFfb1L4w63paQibb=cFCBhWDXNXA@mail.gmail.com>
 <CAJF2gTRC-qm76=aaLh75amO0JJLO2P4eZaJXH-TBSV0c7iqUBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJF2gTRC-qm76=aaLh75amO0JJLO2P4eZaJXH-TBSV0c7iqUBA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 02:31:25PM +0800, Guo Ren wrote:
>On Thu, Nov 24, 2022 at 1:57 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Inline.
>>
>> On Wed, Nov 23, 2022 at 5:28 PM Guo Ren <guoren@kernel.org> wrote:
>> >
>> >
>> >
>> > On Thu, Nov 24, 2022 at 8:50 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >> commit 31da94c25aea835ceac00575a9fd206c5a833fed added support for
>> >> CONFIG_VMAP_STACK. If overflow is detected, CPU switches to `shadow_stack`
>> >> temporarily before switching finally to per-cpu `overflow_stack`.
>> >>
>> >> If two CPUs/harts are racing and end up in over flowing kernel stack, one
>> >> or both will end up corrupting each other state because `shadow_stack` is
>> >> not per-cpu.
>> >>
>> >> Following are the changes in this patch
>> >>
>> >>  - Defines an asm macro to obtain per-cpu symbols in destination
>> >>    register.
>> >>  - Computing per-cpu symbol requires a temporary register. When stack is
>> >>    out of question, a place is needed to spill a register. `thread_info`
>> >>    is good location to have spill register.
>> >>  - In entry.S when overflow is detected x31 is spilled into thread_info.
>> >>    x31 is used as temp reg for asm macro to locate per-cpu overflow stack
>> >>
>> >> Other relevant disccussion on this
>> >> https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
>> >>
>> >> Tested by `echo EXHAUST_STACK > /sys/kernel/debug/provoke-crash/DIRECT`
>> >>
>> >> [  286.223273] Insufficient stack space to handle exception!/debug/provoke-crash/DIRECT
>> >> [  286.223878] Task stack:     [0xff20000010a98000..0xff20000010a9c000]
>> >> [  286.224411] Overflow stack: [0xff600001f7d98370..0xff600001f7d99370]
>> >> [  286.226057] CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>> >> [  286.227139] Hardware name: riscv-virtio,qemu (DT)
>> >> [  286.228000] epc : __memset+0x60/0xfc
>> >> [  286.229299]  ra : recursive_loop+0x48/0xc6 [lkdtm]
>> >> [  286.231457] epc : ffffffff808de0e4 ra : ffffffff0163a752 sp : ff20000010a97e80
>> >> [  286.232207]  gp : ffffffff815c0330 tp : ff600000820ea280 t0 : ff20000010a97e88
>> >> [  286.233584]  t1 : 000000000000002e t2 : 3233206874706564 s0 : ff20000010a982b0
>> >> [  286.234293]  s1 : 0000000000000012 a0 : ff20000010a97e88 a1 : 0000000000000000
>> >> [  286.234998]  a2 : 0000000000000400 a3 : ff20000010a98288 a4 : 0000000000000000
>> >> [  286.235697]  a5 : 0000000000000000 a6 : fffffffffffe43f0 a7 : 00007fffffffffff
>> >> [  286.236384]  s2 : ff20000010a97e88 s3 : ffffffff01644680 s4 : ff20000010a9be90
>> >> [  286.237743]  s5 : ff600000842ba6c0 s6 : 00aaaaaac29e42b0 s7 : 00fffffff0aa3684
>> >> [  286.238691]  s8 : 00aaaaaac2978040 s9 : 0000000000000065 s10: 00ffffff8a7cad10
>> >> [  286.239591]  s11: 00ffffff8a76a4e0 t3 : ffffffff815dbaf4 t4 : ffffffff815dbaf4
>> >> [  286.240537]  t5 : ffffffff815dbab8 t6 : ff20000010a9bb48
>> >> [  286.241540] status: 0000000200000120 badaddr: ff20000010a97e88 cause: 000000000000000f
>> >> [  286.242979] Kernel panic - not syncing: Kernel stack overflow
>> >> [  286.244106] CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>> >> [  286.245276] Hardware name: riscv-virtio,qemu (DT)
>> >> [  286.245929] Call Trace:
>> >> [  286.246954] [<ffffffff80006754>] dump_backtrace+0x30/0x38
>> >> [  286.247813] [<ffffffff808de798>] show_stack+0x40/0x4c
>> >> [  286.248429] [<ffffffff808ea2a8>] dump_stack_lvl+0x44/0x5c
>> >> [  286.249439] [<ffffffff808ea2d8>] dump_stack+0x18/0x20
>> >> [  286.250056] [<ffffffff808dec06>] panic+0x126/0x2fe
>> >> [  286.250642] [<ffffffff800065ea>] walk_stackframe+0x0/0xf0
>> >> [  286.251357] [<ffffffff0163a752>] recursive_loop+0x48/0xc6 [lkdtm]
>> >> [  286.253321] SMP: stopping secondary CPUs
>> >> [  286.256724] ---[ end Kernel panic - not syncing: Kernel stack overflow ]---
>> >>
>> >> Fixes: 31da94c25aea835ceac00575a9fd206c5a833fed
>> >
>> > The patch gives more significant change than the Fixes, and Fixes would expand to the previous stable versions. Please don't set it as a Fixes, but an improved OVERSTACK dead path performance feature.
>> >
>>
>> Not a performance feature but more like correctness.
>> If kernel died and two CPUs raced to kernel stack overflow,
>> death post-mortem should be straightforward.
>We already have had a fixup, and your patch likes a feature with a
>significant change.
>https://lore.kernel.org/linux-riscv/20221030124517.2370-1-jszhang@kernel.org/
>If it is for correctness, the simple lock is enough.

Sure lock is enough. 
It's different way to solve the problem. 
But I don't think it qualifies as significant change.


>
>
>>
>> >>
>> >> Cc: Guo Ren <guoren@kernel.org>
>> >> Cc: Jisheng Zhang <jszhang@kernel.org>
>> >>
>> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >> ---
>> >>  arch/riscv/include/asm/asm.h         | 11 ++++++
>> >>  arch/riscv/include/asm/thread_info.h |  3 ++
>> >>  arch/riscv/kernel/asm-offsets.c      |  4 +++
>> >>  arch/riscv/kernel/entry.S            | 54 ++++------------------------
>> >>  arch/riscv/kernel/traps.c            | 12 +------
>> >>  5 files changed, 26 insertions(+), 58 deletions(-)
>> >>
>> >> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> >> index 1b471ff73178..373eba843331 100644
>> >> --- a/arch/riscv/include/asm/asm.h
>> >> +++ b/arch/riscv/include/asm/asm.h
>> >> @@ -69,6 +69,7 @@
>> >>
>> >>  #ifdef __ASSEMBLY__
>> >>
>> >> +#include <asm/asm-offsets.h>
>> >>  /* Common assembly source macros */
>> >>
>> >>  /*
>> >> @@ -80,6 +81,16 @@
>> >>         .endr
>> >>  .endm
>> >>
>> >> +.macro asm_per_cpu dst sym tmp
>> >> +       REG_L \tmp, TASK_TI_CPU_NUM(tp)
>> >> +       slli \tmp, \tmp, 0x3
>> >> +       la \dst, __per_cpu_offset
>> >> +       add \dst, \dst, \tmp
>> >> +       REG_L \tmp, 0(\dst)
>> >> +       la \dst, \sym
>> >> +       add \dst, \dst, \tmp
>> >
>> > Another tricky asm code of using percpu, I don't know how the percpu maintenance guy thinks.
>>
>> Pretty much the same exists for arm64 as well.
>That's not the reason.
>
>> I don't see anything tricky here.
>I prefer using standard percpu API, not hacking one.

`this_cpu_ptr` is not an API. It's also a C macro which expands similar 
as above written asm macro. First time that macro was written, 
it was a hack and now it's an API.

>
>>
>> >
>> > Percpu is really complex to be used here. That's why I don't like Jisheng's previous idea, although I haven't given an explicitly opposed comment.
>> >
>>
>> Why is per-cpu really complex here?
>> That's why per-cpu exists, right?
>> Compiler generates pretty much same code everywhere for C.
>>
>> > Keep simple and direct.
>> >
>> >>
>> >> +.endm
>> >> +
>> >>  #endif /* __ASSEMBLY__ */
>> >>
>> >>  #endif /* _ASM_RISCV_ASM_H */
>> >> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> >> index 67322f878e0d..7e17dc07cf11 100644
>> >> --- a/arch/riscv/include/asm/thread_info.h
>> >> +++ b/arch/riscv/include/asm/thread_info.h
>> >> @@ -65,6 +65,9 @@ struct thread_info {
>> >>          */
>> >>         long                    kernel_sp;      /* Kernel stack pointer */
>> >>         long                    user_sp;        /* User stack pointer */
>> >> +#ifdef CONFIG_VMAP_STACK
>> >> +       long                    spill_reg;      /* per cpu scratch space to spill a single register */
>> >> +#endif
>> >
>> > Is it worth expanding "struct thread_info" with another reg size? A dead path performance issue affects living cost. May we give a cheap funeral for the OVERFLOW_STACK death?
>> >
>>
>> Yes I had been thinking over it and your point is quite valid.
>> There is a death's charge (in a corner case) to living structures
>> (particularly to all threads)
>> Andrew Bresticker (abrestic@rivosinc.com) suggested using `sscratch`
>> to spill into.
>> I think that makes sense.
>>
>> I'll send a revised patch.
>I think that's not a fix because your patch broke the previous author's design.
>

If that's the concern, I can send it out as "not a fix" but "alternative solution".

>Below is the fixup style:
>https://lore.kernel.org/linux-riscv/20221030124517.2370-1-jszhang@kernel.org/
>Just fix the previous author's design with a simple spinlock?
>
>>
>> >>
>> >>         int                     cpu;
>> >>  };
>> >>
>> >> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> >> index df9444397908..bed3c83bfb8f 100644
>> >> --- a/arch/riscv/kernel/asm-offsets.c
>> >> +++ b/arch/riscv/kernel/asm-offsets.c
>> >> @@ -38,6 +38,10 @@ void asm_offsets(void)
>> >>         OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>> >>         OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>> >>
>> >> +       OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>> >> +#ifdef CONFIG_VMAP_STACK
>> >> +       OFFSET(TASK_TI_SPILL_REG, task_struct, thread_info.spill_reg);
>> >> +#endif
>> >>         OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>> >>         OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>> >>         OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>> >> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> >> index b9eda3fcbd6d..12f285cec136 100644
>> >> --- a/arch/riscv/kernel/entry.S
>> >> +++ b/arch/riscv/kernel/entry.S
>> >> @@ -10,9 +10,11 @@
>> >>  #include <asm/asm.h>
>> >>  #include <asm/csr.h>
>> >>  #include <asm/unistd.h>
>> >> +#include <asm/page.h>
>> >>  #include <asm/thread_info.h>
>> >>  #include <asm/asm-offsets.h>
>> >>  #include <asm/errata_list.h>
>> >> +#include <linux/sizes.h>
>> >>
>> >>  #if !IS_ENABLED(CONFIG_PREEMPTION)
>> >>  .set resume_kernel, restore_all
>> >> @@ -404,54 +406,12 @@ handle_syscall_trace_exit:
>> >>
>> >>  #ifdef CONFIG_VMAP_STACK
>> >>  handle_kernel_stack_overflow:
>> >> -       la sp, shadow_stack
>> >> -       addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>> >> +       REG_S x31, TASK_TI_SPILL_REG(tp)
>> >> +       asm_per_cpu sp, overflow_stack, x31
>> >> +       li x31, OVERFLOW_STACK_SIZE
>> >> +       add sp, sp, x31
>> >> +       REG_L x31, TASK_TI_SPILL_REG(tp)
>> >>
>> >> -       //save caller register to shadow stack
>> >> -       addi sp, sp, -(PT_SIZE_ON_STACK)
>> >> -       REG_S x1,  PT_RA(sp)
>> >> -       REG_S x5,  PT_T0(sp)
>> >> -       REG_S x6,  PT_T1(sp)
>> >> -       REG_S x7,  PT_T2(sp)
>> >> -       REG_S x10, PT_A0(sp)
>> >> -       REG_S x11, PT_A1(sp)
>> >> -       REG_S x12, PT_A2(sp)
>> >> -       REG_S x13, PT_A3(sp)
>> >> -       REG_S x14, PT_A4(sp)
>> >> -       REG_S x15, PT_A5(sp)
>> >> -       REG_S x16, PT_A6(sp)
>> >> -       REG_S x17, PT_A7(sp)
>> >> -       REG_S x28, PT_T3(sp)
>> >> -       REG_S x29, PT_T4(sp)
>> >> -       REG_S x30, PT_T5(sp)
>> >> -       REG_S x31, PT_T6(sp)
>> >> -
>> >> -       la ra, restore_caller_reg
>> >> -       tail get_overflow_stack
>> >> -
>> >> -restore_caller_reg:
>> >> -       //save per-cpu overflow stack
>> >> -       REG_S a0, -8(sp)
>> >> -       //restore caller register from shadow_stack
>> >> -       REG_L x1,  PT_RA(sp)
>> >> -       REG_L x5,  PT_T0(sp)
>> >> -       REG_L x6,  PT_T1(sp)
>> >> -       REG_L x7,  PT_T2(sp)
>> >> -       REG_L x10, PT_A0(sp)
>> >> -       REG_L x11, PT_A1(sp)
>> >> -       REG_L x12, PT_A2(sp)
>> >> -       REG_L x13, PT_A3(sp)
>> >> -       REG_L x14, PT_A4(sp)
>> >> -       REG_L x15, PT_A5(sp)
>> >> -       REG_L x16, PT_A6(sp)
>> >> -       REG_L x17, PT_A7(sp)
>> >> -       REG_L x28, PT_T3(sp)
>> >> -       REG_L x29, PT_T4(sp)
>> >> -       REG_L x30, PT_T5(sp)
>> >> -       REG_L x31, PT_T6(sp)
>> >> -
>> >> -       //load per-cpu overflow stack
>> >> -       REG_L sp, -8(sp)
>> >
>> > Yes, your patch gives a good performance here. But what do we gain?
>> >
>> >>
>> >>         addi sp, sp, -(PT_SIZE_ON_STACK)
>> >>
>> >>         //save context to overflow stack
>> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> >> index f3e96d60a2ff..eef3a87514c7 100644
>> >> --- a/arch/riscv/kernel/traps.c
>> >> +++ b/arch/riscv/kernel/traps.c
>> >> @@ -208,18 +208,8 @@ int is_valid_bugaddr(unsigned long pc)
>> >>  #endif /* CONFIG_GENERIC_BUG */
>> >>
>> >>  #ifdef CONFIG_VMAP_STACK
>> >> -static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>> >> +DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>> >>                 overflow_stack)__aligned(16);
>> >> -/*
>> >> - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
>> >> - * to get per-cpu overflow stack(get_overflow_stack).
>> >> - */
>> >> -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
>> >> -asmlinkage unsigned long get_overflow_stack(void)
>> >> -{
>> >> -       return (unsigned long)this_cpu_ptr(overflow_stack) +
>> >> -               OVERFLOW_STACK_SIZE;
>> >> -}
>> >>
>> >>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>> >>  {
>> >> --
>> >> 2.25.1
>> >>
>> >
>> >
>> > --
>> > Best Regards
>> >  Guo Ren
>
>
>
>-- 
>Best Regards
> Guo Ren
