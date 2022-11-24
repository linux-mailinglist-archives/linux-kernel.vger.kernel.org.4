Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7336637260
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKXGa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKXGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:30:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F43CDAD28
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19CA561FEF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B513BC433D6;
        Thu, 24 Nov 2022 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669271437;
        bh=LSSfW3Zh2RwJhUxrBUj2wRpVCu4TImcNtfrvTVyJ6T0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=dIkR6A+6/KlvAkLyhTrsAdN67t8IlIYzfUMxh+erkNGSTZJBOtkPJOLVPEiqCVE0K
         Qgt4gK9at3st/MI0LmKN+3P2eBTcAxbdLwfGI3Tb7nc2uiGxyD48JXJJRrvFZ8R9aa
         fPdEwbDplC0tLgctsPvyiAXIdMJP7kjL0uhOsouYke6/go/AJQrD0XSemw/mx7k7ap
         OFRll7F6TFUhemoSAZgzma0YPPkDKADiaTAHeTxv8AdrO0oi9Go6VFaL6lc5HlWncP
         YW8olexFs9306wN2rPZc5sI/nkxnkmriuaGuCuIyV/cdJkVhT5fQ2DNELpmj3pS/as
         MRJm9gOwhYnrA==
Date:   Thu, 24 Nov 2022 06:30:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, Deepak Gupta <debug@rivosinc.com>,
        palmer@dabbelt.com
CC:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH] riscv: VMAP_STACK overflow detection thread-safe
User-Agent: K-9 Mail for Android
In-Reply-To: <20221124005006.1788315-1-debug@rivosinc.com>
References: <20221124005006.1788315-1-debug@rivosinc.com>
Message-ID: <A190DD6B-18A3-4DFE-AF8B-D5D50B6B6409@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Deepak,
Guo Ren s issues aside, there's some process bits here=2E

On 24 November 2022 00:50:06 GMT, Deepak Gupta <debug@rivosinc=2Ecom> wrot=
e:
>commit 31da94c25aea835ceac00575a9fd206c5a833fed added support for

Please check the documentation for how to format commit references in patc=
h text=2E
As a reader, a hash requires access to a git tree to do anything with=2E
Id show you the format but I am on my phone ;)

>CONFIG_VMAP_STACK=2E If overflow is detected, CPU switches to `shadow_sta=
ck`
>temporarily before switching finally to per-cpu `overflow_stack`=2E
>
>If two CPUs/harts are racing and end up in over flowing kernel stack, one
>or both will end up corrupting each other state because `shadow_stack` is
>not per-cpu=2E
>
>Following are the changes in this patch
>
> - Defines an asm macro to obtain per-cpu symbols in destination
>   register=2E
> - Computing per-cpu symbol requires a temporary register=2E When stack i=
s
>   out of question, a place is needed to spill a register=2E `thread_info=
`
>   is good location to have spill register=2E
> - In entry=2ES when overflow is detected x31 is spilled into thread_info=
=2E
>   x31 is used as temp reg for asm macro to locate per-cpu overflow stack
>
>Other relevant disccussion on this
>https://lore=2Ekernel=2Eorg/linux-riscv/Y347B0x4VUNOd6V7@xhacker/T/#t

Link: foo

>
>Tested by `echo EXHAUST_STACK > /sys/kernel/debug/provoke-crash/DIRECT`
>
>[  286=2E223273] Insufficient stack space to handle exception!/debug/prov=
oke-crash/DIRECT
>[  286=2E223878] Task stack:     [0xff20000010a98000=2E=2E0xff20000010a9c=
000]
>[  286=2E224411] Overflow stack: [0xff600001f7d98370=2E=2E0xff600001f7d99=
370]
>[  286=2E226057] CPU: 1 PID: 205 Comm: bash Not tainted 6=2E1=2E0-rc2-000=
01-g328a1f96f7b9 #34
>[  286=2E227139] Hardware name: riscv-virtio,qemu (DT)
>[  286=2E228000] epc : __memset+0x60/0xfc
>[  286=2E229299]  ra : recursive_loop+0x48/0xc6 [lkdtm]
>[  286=2E231457] epc : ffffffff808de0e4 ra : ffffffff0163a752 sp : ff2000=
0010a97e80
>[  286=2E232207]  gp : ffffffff815c0330 tp : ff600000820ea280 t0 : ff2000=
0010a97e88
>[  286=2E233584]  t1 : 000000000000002e t2 : 3233206874706564 s0 : ff2000=
0010a982b0
>[  286=2E234293]  s1 : 0000000000000012 a0 : ff20000010a97e88 a1 : 000000=
0000000000
>[  286=2E234998]  a2 : 0000000000000400 a3 : ff20000010a98288 a4 : 000000=
0000000000
>[  286=2E235697]  a5 : 0000000000000000 a6 : fffffffffffe43f0 a7 : 00007f=
ffffffffff
>[  286=2E236384]  s2 : ff20000010a97e88 s3 : ffffffff01644680 s4 : ff2000=
0010a9be90
>[  286=2E237743]  s5 : ff600000842ba6c0 s6 : 00aaaaaac29e42b0 s7 : 00ffff=
fff0aa3684
>[  286=2E238691]  s8 : 00aaaaaac2978040 s9 : 0000000000000065 s10: 00ffff=
ff8a7cad10
>[  286=2E239591]  s11: 00ffffff8a76a4e0 t3 : ffffffff815dbaf4 t4 : ffffff=
ff815dbaf4
>[  286=2E240537]  t5 : ffffffff815dbab8 t6 : ff20000010a9bb48
>[  286=2E241540] status: 0000000200000120 badaddr: ff20000010a97e88 cause=
: 000000000000000f
>[  286=2E242979] Kernel panic - not syncing: Kernel stack overflow
>[  286=2E244106] CPU: 1 PID: 205 Comm: bash Not tainted 6=2E1=2E0-rc2-000=
01-g328a1f96f7b9 #34
>[  286=2E245276] Hardware name: riscv-virtio,qemu (DT)
>[  286=2E245929] Call Trace:
>[  286=2E246954] [<ffffffff80006754>] dump_backtrace+0x30/0x38
>[  286=2E247813] [<ffffffff808de798>] show_stack+0x40/0x4c
>[  286=2E248429] [<ffffffff808ea2a8>] dump_stack_lvl+0x44/0x5c
>[  286=2E249439] [<ffffffff808ea2d8>] dump_stack+0x18/0x20
>[  286=2E250056] [<ffffffff808dec06>] panic+0x126/0x2fe
>[  286=2E250642] [<ffffffff800065ea>] walk_stackframe+0x0/0xf0
>[  286=2E251357] [<ffffffff0163a752>] recursive_loop+0x48/0xc6 [lkdtm]
>[  286=2E253321] SMP: stopping secondary CPUs
>[  286=2E256724] ---[ end Kernel panic - not syncing: Kernel stack overfl=
ow ]---

For stack traces, especially long ones, please cut out the timestamps=2E


>Fixes: 31da94c25aea835ceac00575a9fd206c5a833fed

https://gist=2Egithubusercontent=2Ecom/conor-pwbot/8882fc7ef7cd4fe83377457=
4fbf509f5/raw/d360ec7aebfaa6c2d043e9bd87f59745ad6a4c85/desc

Please use the correct format for fixes tags=2E

>Cc: Guo Ren <guoren@kernel=2Eorg>
>Cc: Jisheng Zhang <jszhang@kernel=2Eorg>
>
>Signed-off-by: Deepak Gupta <debug@rivosinc=2Ecom>

All of the tags need to be in one block, so:

Link:
Fixes:
SoB:

Thanks,
Conor=2E

>---
> arch/riscv/include/asm/asm=2Eh         | 11 ++++++
> arch/riscv/include/asm/thread_info=2Eh |  3 ++
> arch/riscv/kernel/asm-offsets=2Ec      |  4 +++
> arch/riscv/kernel/entry=2ES            | 54 ++++------------------------
> arch/riscv/kernel/traps=2Ec            | 12 +------
> 5 files changed, 26 insertions(+), 58 deletions(-)
>
>diff --git a/arch/riscv/include/asm/asm=2Eh b/arch/riscv/include/asm/asm=
=2Eh
>index 1b471ff73178=2E=2E373eba843331 100644
>--- a/arch/riscv/include/asm/asm=2Eh
>+++ b/arch/riscv/include/asm/asm=2Eh
>@@ -69,6 +69,7 @@
>=20
> #ifdef __ASSEMBLY__
>=20
>+#include <asm/asm-offsets=2Eh>
> /* Common assembly source macros */
>=20
> /*
>@@ -80,6 +81,16 @@
> 	=2Eendr
> =2Eendm
>=20
>+=2Emacro asm_per_cpu dst sym tmp
>+	REG_L \tmp, TASK_TI_CPU_NUM(tp)
>+	slli \tmp, \tmp, 0x3
>+	la \dst, __per_cpu_offset
>+	add \dst, \dst, \tmp
>+	REG_L \tmp, 0(\dst)
>+	la \dst, \sym
>+	add \dst, \dst, \tmp
>+=2Eendm
>+
> #endif /* __ASSEMBLY__ */
>=20
> #endif /* _ASM_RISCV_ASM_H */
>diff --git a/arch/riscv/include/asm/thread_info=2Eh b/arch/riscv/include/=
asm/thread_info=2Eh
>index 67322f878e0d=2E=2E7e17dc07cf11 100644
>--- a/arch/riscv/include/asm/thread_info=2Eh
>+++ b/arch/riscv/include/asm/thread_info=2Eh
>@@ -65,6 +65,9 @@ struct thread_info {
> 	 */
> 	long			kernel_sp;	/* Kernel stack pointer */
> 	long			user_sp;	/* User stack pointer */
>+#ifdef CONFIG_VMAP_STACK
>+	long			spill_reg;      /* per cpu scratch space to spill a single regis=
ter */
>+#endif
> 	int			cpu;
> };
>=20
>diff --git a/arch/riscv/kernel/asm-offsets=2Ec b/arch/riscv/kernel/asm-of=
fsets=2Ec
>index df9444397908=2E=2Ebed3c83bfb8f 100644
>--- a/arch/riscv/kernel/asm-offsets=2Ec
>+++ b/arch/riscv/kernel/asm-offsets=2Ec
>@@ -38,6 +38,10 @@ void asm_offsets(void)
> 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info=2Ekernel_sp);
> 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info=2Euser_sp);
>=20
>+	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info=2Ecpu);
>+#ifdef CONFIG_VMAP_STACK
>+	OFFSET(TASK_TI_SPILL_REG, task_struct, thread_info=2Espill_reg);
>+#endif
> 	OFFSET(TASK_THREAD_F0,  task_struct, thread=2Efstate=2Ef[0]);
> 	OFFSET(TASK_THREAD_F1,  task_struct, thread=2Efstate=2Ef[1]);
> 	OFFSET(TASK_THREAD_F2,  task_struct, thread=2Efstate=2Ef[2]);
>diff --git a/arch/riscv/kernel/entry=2ES b/arch/riscv/kernel/entry=2ES
>index b9eda3fcbd6d=2E=2E12f285cec136 100644
>--- a/arch/riscv/kernel/entry=2ES
>+++ b/arch/riscv/kernel/entry=2ES
>@@ -10,9 +10,11 @@
> #include <asm/asm=2Eh>
> #include <asm/csr=2Eh>
> #include <asm/unistd=2Eh>
>+#include <asm/page=2Eh>
> #include <asm/thread_info=2Eh>
> #include <asm/asm-offsets=2Eh>
> #include <asm/errata_list=2Eh>
>+#include <linux/sizes=2Eh>
>=20
> #if !IS_ENABLED(CONFIG_PREEMPTION)
> =2Eset resume_kernel, restore_all
>@@ -404,54 +406,12 @@ handle_syscall_trace_exit:
>=20
> #ifdef CONFIG_VMAP_STACK
> handle_kernel_stack_overflow:
>-	la sp, shadow_stack
>-	addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>+	REG_S x31, TASK_TI_SPILL_REG(tp)
>+	asm_per_cpu sp, overflow_stack, x31
>+	li x31, OVERFLOW_STACK_SIZE
>+	add sp, sp, x31
>+	REG_L x31, TASK_TI_SPILL_REG(tp)
>=20
>-	//save caller register to shadow stack
>-	addi sp, sp, -(PT_SIZE_ON_STACK)
>-	REG_S x1,  PT_RA(sp)
>-	REG_S x5,  PT_T0(sp)
>-	REG_S x6,  PT_T1(sp)
>-	REG_S x7,  PT_T2(sp)
>-	REG_S x10, PT_A0(sp)
>-	REG_S x11, PT_A1(sp)
>-	REG_S x12, PT_A2(sp)
>-	REG_S x13, PT_A3(sp)
>-	REG_S x14, PT_A4(sp)
>-	REG_S x15, PT_A5(sp)
>-	REG_S x16, PT_A6(sp)
>-	REG_S x17, PT_A7(sp)
>-	REG_S x28, PT_T3(sp)
>-	REG_S x29, PT_T4(sp)
>-	REG_S x30, PT_T5(sp)
>-	REG_S x31, PT_T6(sp)
>-
>-	la ra, restore_caller_reg
>-	tail get_overflow_stack
>-
>-restore_caller_reg:
>-	//save per-cpu overflow stack
>-	REG_S a0, -8(sp)
>-	//restore caller register from shadow_stack
>-	REG_L x1,  PT_RA(sp)
>-	REG_L x5,  PT_T0(sp)
>-	REG_L x6,  PT_T1(sp)
>-	REG_L x7,  PT_T2(sp)
>-	REG_L x10, PT_A0(sp)
>-	REG_L x11, PT_A1(sp)
>-	REG_L x12, PT_A2(sp)
>-	REG_L x13, PT_A3(sp)
>-	REG_L x14, PT_A4(sp)
>-	REG_L x15, PT_A5(sp)
>-	REG_L x16, PT_A6(sp)
>-	REG_L x17, PT_A7(sp)
>-	REG_L x28, PT_T3(sp)
>-	REG_L x29, PT_T4(sp)
>-	REG_L x30, PT_T5(sp)
>-	REG_L x31, PT_T6(sp)
>-
>-	//load per-cpu overflow stack
>-	REG_L sp, -8(sp)
> 	addi sp, sp, -(PT_SIZE_ON_STACK)
>=20
> 	//save context to overflow stack
>diff --git a/arch/riscv/kernel/traps=2Ec b/arch/riscv/kernel/traps=2Ec
>index f3e96d60a2ff=2E=2Eeef3a87514c7 100644
>--- a/arch/riscv/kernel/traps=2Ec
>+++ b/arch/riscv/kernel/traps=2Ec
>@@ -208,18 +208,8 @@ int is_valid_bugaddr(unsigned long pc)
> #endif /* CONFIG_GENERIC_BUG */
>=20
> #ifdef CONFIG_VMAP_STACK
>-static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>+DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
> 		overflow_stack)__aligned(16);
>-/*
>- * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry=2ES) i=
s used
>- * to get per-cpu overflow stack(get_overflow_stack)=2E
>- */
>-long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)];
>-asmlinkage unsigned long get_overflow_stack(void)
>-{
>-	return (unsigned long)this_cpu_ptr(overflow_stack) +
>-		OVERFLOW_STACK_SIZE;
>-}
>=20
> asmlinkage void handle_bad_stack(struct pt_regs *regs)
> {
