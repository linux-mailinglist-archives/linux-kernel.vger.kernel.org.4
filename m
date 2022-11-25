Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD9663912D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiKYVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiKYVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:41:21 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9A57B53
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:41:19 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so4866944pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ejsyx9JujnljUWTN7Ecee9VHK797cwGQlW2KeRRVwNo=;
        b=Z9ILE85qMXHxghEsAK10yd/InuKi81Ja31mm9NUBQPAh3+V1hV6Yx/GAO5XBMlnbLf
         W9kn0LwMiwGOKKFyR6md0GzNljfh2HesxIUXWa9DBEvJltiGtbR4DYS8IkiBYOO/aC+Q
         QaR6i/870wFH04kvDqdllWk1GS0MK82rfl33oKP0IGNOHlR1rbtqo440GAFn/WfLuOoe
         uABB/wuD6zxUdtas42TvvV8pGcC/QB8LI2zFZ/9SjXFRC6CLIZ9kXobvxJE5lL+64nj1
         y4zC02sito2nIyN03M8Sz1/QbixG9b4+G+UOAcVjHsT2TADLK3oPoxvu+bQ6Cglx1cD1
         cXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ejsyx9JujnljUWTN7Ecee9VHK797cwGQlW2KeRRVwNo=;
        b=cDP79PPeo8gf4ghljLk/eDB/In8JMyNHqZNBfqdRKVZv0QI01u99DxBoNwWbd+uO5B
         594/yW7GEdePW5B4VeTUxuxoObVtC4aiUorwvYSDB+Oc4oJ3IAU3WexqC6KeBylLlo+e
         5M8VhAxOzCI3l+b8sejrs6A0wcHYWFjdiuWr6iP4T3TaVqck47LQb2qGxfeu419o97wr
         pzPCvioI2m79v6WBk/DwmVJW1UQ+OMzQmqyb7nbfXz/vSAiml942GByB6NG7l+93zWlb
         DOFfPKug/nDTnsgVFGPkcUhhhFIEeyNQIQLnGDlIk8UW33N0eDVpWjzLIDqAcBmMFa5J
         jYMQ==
X-Gm-Message-State: ANoB5pnP2DLYAPtWqlqjkZwSyNbouvW2O2RNLMxCrr9KYbio+RSNnxAx
        vCdQb6DpGgr1I+mXXrB+Og7OZA==
X-Google-Smtp-Source: AA0mqf6PbHe6y4MmG1N2eAF5A1U/RMYy666jQjdoB1lfs8QX6F1U2W6+cPzDZP9TOvZEawsy5DmMiQ==
X-Received: by 2002:a63:2144:0:b0:470:8a45:32a8 with SMTP id s4-20020a632144000000b004708a4532a8mr35228314pgm.543.1669412478812;
        Fri, 25 Nov 2022 13:41:18 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id t25-20020aa79479000000b00565cbad9616sm3538850pfq.6.2022.11.25.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 13:41:18 -0800 (PST)
Date:   Fri, 25 Nov 2022 13:41:16 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <20221125214116.GC2037421@debug.ba.rivosinc.com>
References: <20221124094845.1907443-1-debug@rivosinc.com>
 <Y3+NMjOQW+yA1Kqj@xhacker>
 <Y4CnIkPFrJqVwCqV@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y4CnIkPFrJqVwCqV@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:29:38PM +0800, Jisheng Zhang wrote:
>On Thu, Nov 24, 2022 at 11:26:46PM +0800, Jisheng Zhang wrote:
>> On Thu, Nov 24, 2022 at 01:48:45AM -0800, Deepak Gupta wrote:
>> > commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
>> > support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches to
>> > `shadow_stack` temporarily before switching finally to per-cpu
>> > `overflow_stack`.
>> >
>> > If two CPUs/harts are racing and end up in over flowing kernel stack, one
>> > or both will end up corrupting each other state because `shadow_stack` is
>> > not per-cpu. This patch optimizes per-cpu overflow stack switch by
>> > directly picking per-cpu `overflow_stack` and gets rid of `shadow_stack`.
>> >
>> > Following are the changes in this patch
>> >
>> >  - Defines an asm macro to obtain per-cpu symbols in destination
>> >    register.
>> >  - In entry.S, when overflow is detected, per-cpu overflow stack is
>> >    located using per-cpu asm macro. Computing per-cpu symbol requires
>> >    a temporary register. x31 is saved away into CSR_SCRATCH
>>
>> This only works if CSR_SCRATCH doesn't contain any valid reg saving,
>> but.. see below.
>>
>> >    (CSR_SCRATCH is anyways zero since we're in kernel).
>> >
>>
>> To be honest, before [1] I have similar idea to keep the percpu usage,
>> however, the solution doesn't work. The key here is that there's
>> another VMAP_STACK bug in current riscv implementation: it only checks
>> vmap stack overflow when comming from kernelspace, but vmap should
>> check when comming from both kernelspace and userspace. So we can't
>> assume CSR_SCRATCH is always zero and free to use. The only available
>> solution is my fix[1] which only makes use of tp. But since[1] modifies
>
>I found one bug in fix[1] and I also found an elegant solution of the
>race codition which can still keep the percpu usage, we need to combine
>our methods together. see below.
>
>> lots of code, it's not idea to merge it as a fix, so [2] is suggested
>> and sent out.
>
>>
>> PS: I planed to send a fix for the missing FROM_USERSPACE after the
>> race fix is merged.
>>
>>
>> [1]https://lore.kernel.org/linux-riscv/20220925175356.681-1-jszhang@kernel.org/T/#t
>> [2]https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
>>
>> > Please see Links for additional relevant disccussion and alternative
>> > solution.
>> >
>> > Tested by `echo EXHAUST_STACK > /sys/kernel/debug/provoke-crash/DIRECT`
>> > Kernel crash log below
>> >
>> >  Insufficient stack space to handle exception!/debug/provoke-crash/DIRECT
>> >  Task stack:     [0xff20000010a98000..0xff20000010a9c000]
>> >  Overflow stack: [0xff600001f7d98370..0xff600001f7d99370]
>> >  CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>> >  Hardware name: riscv-virtio,qemu (DT)
>> >  epc : __memset+0x60/0xfc
>> >   ra : recursive_loop+0x48/0xc6 [lkdtm]
>> >  epc : ffffffff808de0e4 ra : ffffffff0163a752 sp : ff20000010a97e80
>> >   gp : ffffffff815c0330 tp : ff600000820ea280 t0 : ff20000010a97e88
>> >   t1 : 000000000000002e t2 : 3233206874706564 s0 : ff20000010a982b0
>> >   s1 : 0000000000000012 a0 : ff20000010a97e88 a1 : 0000000000000000
>> >   a2 : 0000000000000400 a3 : ff20000010a98288 a4 : 0000000000000000
>> >   a5 : 0000000000000000 a6 : fffffffffffe43f0 a7 : 00007fffffffffff
>> >   s2 : ff20000010a97e88 s3 : ffffffff01644680 s4 : ff20000010a9be90
>> >   s5 : ff600000842ba6c0 s6 : 00aaaaaac29e42b0 s7 : 00fffffff0aa3684
>> >   s8 : 00aaaaaac2978040 s9 : 0000000000000065 s10: 00ffffff8a7cad10
>> >   s11: 00ffffff8a76a4e0 t3 : ffffffff815dbaf4 t4 : ffffffff815dbaf4
>> >   t5 : ffffffff815dbab8 t6 : ff20000010a9bb48
>> >  status: 0000000200000120 badaddr: ff20000010a97e88 cause: 000000000000000f
>> >  Kernel panic - not syncing: Kernel stack overflow
>> >  CPU: 1 PID: 205 Comm: bash Not tainted 6.1.0-rc2-00001-g328a1f96f7b9 #34
>> >  Hardware name: riscv-virtio,qemu (DT)
>> >  Call Trace:
>> >  [<ffffffff80006754>] dump_backtrace+0x30/0x38
>> >  [<ffffffff808de798>] show_stack+0x40/0x4c
>> >  [<ffffffff808ea2a8>] dump_stack_lvl+0x44/0x5c
>> >  [<ffffffff808ea2d8>] dump_stack+0x18/0x20
>> >  [<ffffffff808dec06>] panic+0x126/0x2fe
>> >  [<ffffffff800065ea>] walk_stackframe+0x0/0xf0
>> >  [<ffffffff0163a752>] recursive_loop+0x48/0xc6 [lkdtm]
>> >  SMP: stopping secondary CPUs
>> >  ---[ end Kernel panic - not syncing: Kernel stack overflow ]---
>> >
>> > Cc: Guo Ren <guoren@kernel.org>
>> > Cc: Jisheng Zhang <jszhang@kernel.org>
>> > Link: https://lore.kernel.org/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t
>> > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >
>> > ---
>> > v1 --> v2:
>> >  - asm macro to locate per-cpu symbol requires a temp reg.
>> >    When stack overflow happens, in trap handler we don't have spare regs
>> >    except sp.
>> >    v1 had a place holder in `thread_info` to spill a register.
>> >    v2 instead uses CSR_SCRATCH register because it's free to use.
>> >
>> >  - v2 made per-cpu macro more readable.
>> >  - v2 fixed a bug that would've broken 32bit support.
>> >
>> >  - v1 called it a fix over 31da94c25aea. v2 calls it alternative/
>> >    optimization solution
>> > ---
>> >  arch/riscv/include/asm/asm.h    | 17 ++++++++++
>> >  arch/riscv/kernel/asm-offsets.c |  1 +
>> >  arch/riscv/kernel/entry.S       | 57 ++++++---------------------------
>> >  arch/riscv/kernel/traps.c       | 12 +------
>> >  4 files changed, 29 insertions(+), 58 deletions(-)
>> >
>> > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> > index 1b471ff73178..1eb479cb9ae4 100644
>> > --- a/arch/riscv/include/asm/asm.h
>> > +++ b/arch/riscv/include/asm/asm.h
>> > @@ -69,6 +69,7 @@
>> >
>> >  #ifdef __ASSEMBLY__
>> >
>> > +#include <asm/asm-offsets.h>
>> >  /* Common assembly source macros */
>> >
>> >  /*
>> > @@ -80,6 +81,22 @@
>> >  	.endr
>> >  .endm
>> >
>> > +#ifdef CONFIG_32BIT
>> > +#define PER_CPU_OFFSET_SHIFT 2
>> > +#else
>> > +#define PER_CPU_OFFSET_SHIFT 3
>> > +#endif
>> > +
>> > +.macro asm_per_cpu dst sym tmp
>> > +	REG_L \tmp, TASK_TI_CPU_NUM(tp)
>> > +	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
>> > +	la    \dst, __per_cpu_offset
>> > +	add   \dst, \dst, \tmp
>> > +	REG_L \tmp, 0(\dst)
>> > +	la    \dst, \sym
>> > +	add   \dst, \dst, \tmp
>> > +.endm
>> > +
>> >  #endif /* __ASSEMBLY__ */
>> >
>> >  #endif /* _ASM_RISCV_ASM_H */
>> > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> > index df9444397908..a7da051159cf 100644
>> > --- a/arch/riscv/kernel/asm-offsets.c
>> > +++ b/arch/riscv/kernel/asm-offsets.c
>> > @@ -38,6 +38,7 @@ void asm_offsets(void)
>> >  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>> >  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>> >
>> > +	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>> >  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>> >  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>> >  	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> > index b9eda3fcbd6d..2e90d9ccddd0 100644
>> > --- a/arch/riscv/kernel/entry.S
>> > +++ b/arch/riscv/kernel/entry.S
>> > @@ -10,9 +10,11 @@
>> >  #include <asm/asm.h>
>> >  #include <asm/csr.h>
>> >  #include <asm/unistd.h>
>> > +#include <asm/page.h>
>> >  #include <asm/thread_info.h>
>> >  #include <asm/asm-offsets.h>
>> >  #include <asm/errata_list.h>
>> > +#include <linux/sizes.h>
>> >
>> >  #if !IS_ENABLED(CONFIG_PREEMPTION)
>> >  .set resume_kernel, restore_all
>> > @@ -404,54 +406,15 @@ handle_syscall_trace_exit:
>> >
>> >  #ifdef CONFIG_VMAP_STACK
>> >  handle_kernel_stack_overflow:
>> > -	la sp, shadow_stack
>> > -	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>> > +	/* we reach here from kernel context, sscratch must be 0 */
>
>this is not correct. if we reach here from kernel context, sscratch
>holds the kernel tp(see the "csrr tp, CSR_SCRATCH" at the beginning
>of handle exception), and tp reg holds the kernel tp as well; if we
>reach here from user context, sscratch holds the user tp, while tp
>reg holds the kernel tp.
>When vmap stack overflow happen, we will panic soon, we can drop user
>tp, thus we can always save current tp to sscratch no matter we come
>from kernelspace or userspace, then we can restore tp from sscratch
>later.

Yes I think I should said that CSR_SCRATCH is truly scratch space here 
(instead of saying it's zero)

Because `tp` is actually pointing to kernel thread pointer.
User space `tp` always gets restored as we restore `x4` on way back to user mode 
during restore of registers.

Either ways its scratch space because we can be here only when we took trap(s) 
while in kernel mode. 

Coming in from user space and running into low kernel stack situation should be 
a kernel bug.

>
>> > +	csrrw x31, CSR_SCRATCH, x31
>
>we can use tp as the tmp reg
>> > +	asm_per_cpu sp, overflow_stack, x31
>> > +	li x31, OVERFLOW_STACK_SIZE
>> > +	add sp, sp, x31
>> > +	/* zero out x31 again and restore x31 */
>> > +	xor x31, x31, x31
>> > +	csrrw x31, CSR_SCRATCH, x31
>
>we just need to restore tp from sscratch here.
>
>So all in all, the code looks like:
>	/*
>	 * if we reach here from kernel context, sscratch
>	 * holds the kernel tp, while the tp reg holds kernel tp as well;
>	 * if we reach here from user context, sscratch holds the user tp,
>	 * while the tp reg holds kernel tp. Once vmap stack overflow
>	 * happens, kernel panic is comming soon, we can drop user
>	 * tp, but we care about kernel tp. Here, we save tp reg to
>	 * sscratch no matter where we are from, then we can restore
>	 * tp from sscratch.
>	 */
>	csrw CSR_SCRATCH, tp
>	asm_per_cpu sp, overflow_stack, tp
>	li tp, OVERFLOW_STACK_SIZE
>	add sp, sp, tp
>	/* restore kernel tp */
>	csrr tp, CSR_SCRATCH
>> >
>> > -	//save caller register to shadow stack
>> > -	addi sp, sp, -(PT_SIZE_ON_STACK)
>> > -	REG_S x1,  PT_RA(sp)
>> > -	REG_S x5,  PT_T0(sp)
>> > -	REG_S x6,  PT_T1(sp)
>> > -	REG_S x7,  PT_T2(sp)
>> > -	REG_S x10, PT_A0(sp)
>> > -	REG_S x11, PT_A1(sp)
>> > -	REG_S x12, PT_A2(sp)
>> > -	REG_S x13, PT_A3(sp)
>> > -	REG_S x14, PT_A4(sp)
>> > -	REG_S x15, PT_A5(sp)
>> > -	REG_S x16, PT_A6(sp)
>> > -	REG_S x17, PT_A7(sp)
>> > -	REG_S x28, PT_T3(sp)
>> > -	REG_S x29, PT_T4(sp)
>> > -	REG_S x30, PT_T5(sp)
>> > -	REG_S x31, PT_T6(sp)
>> > -
>> > -	la ra, restore_caller_reg
>> > -	tail get_overflow_stack
>> > -
>> > -restore_caller_reg:
>> > -	//save per-cpu overflow stack
>> > -	REG_S a0, -8(sp)
>> > -	//restore caller register from shadow_stack
>> > -	REG_L x1,  PT_RA(sp)
>> > -	REG_L x5,  PT_T0(sp)
>> > -	REG_L x6,  PT_T1(sp)
>> > -	REG_L x7,  PT_T2(sp)
>> > -	REG_L x10, PT_A0(sp)
>> > -	REG_L x11, PT_A1(sp)
>> > -	REG_L x12, PT_A2(sp)
>> > -	REG_L x13, PT_A3(sp)
>> > -	REG_L x14, PT_A4(sp)
>> > -	REG_L x15, PT_A5(sp)
>> > -	REG_L x16, PT_A6(sp)
>> > -	REG_L x17, PT_A7(sp)
>> > -	REG_L x28, PT_T3(sp)
>> > -	REG_L x29, PT_T4(sp)
>> > -	REG_L x30, PT_T5(sp)
>> > -	REG_L x31, PT_T6(sp)
>> > -
>> > -	//load per-cpu overflow stack
>> > -	REG_L sp, -8(sp)
>> >  	addi sp, sp, -(PT_SIZE_ON_STACK)
>> >
>> >  	//save context to overflow stack
>> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> > index f3e96d60a2ff..eef3a87514c7 100644
>> > --- a/arch/riscv/kernel/traps.c
>> > +++ b/arch/riscv/kernel/traps.c
>> > @@ -208,18 +208,8 @@ int is_valid_bugaddr(unsigned long pc)
>> >  #endif /* CONFIG_GENERIC_BUG */
>> >
>> >  #ifdef CONFIG_VMAP_STACK
>> > -static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>> > +DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>> >  		overflow_stack)__aligned(16);
>> > -/*
>> > - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
>> > - * to get per-cpu overflow stack(get_overflow_stack).
>> > - */
>> > -long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
>> > -asmlinkage unsigned long get_overflow_stack(void)
>> > -{
>> > -	return (unsigned long)this_cpu_ptr(overflow_stack) +
>> > -		OVERFLOW_STACK_SIZE;
>> > -}
>> >
>> >  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>> >  {
>> > --
>> > 2.25.1
>> >
