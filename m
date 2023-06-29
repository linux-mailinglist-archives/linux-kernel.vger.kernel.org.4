Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CAD742953
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjF2PTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjF2PSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:18:55 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422819A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:18:53 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 35TFIdwO1868793
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 29 Jun 2023 08:18:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 35TFIdwO1868793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023061001; t=1688051920;
        bh=J9CJexqW6+HyHRhe3TTtbGtrUhy6lE+Z/bxUQ6tMNCw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=AwUsmfjKfu5L4OtOOSlYmE7fph926vBLL07oU6dYDFrjgU70FcKGncostKa3scOVG
         GZXXtYrNbrk/OSLChq6g5Y1xscdKYKPHx+FwHNSVNiSWCvhrk45ng4nwvFQ0Gy/plq
         HRZB3HImneC4tL6xkWr9HC//0VtRMeiWl7hU2KkBdjgIvAWD41Sc01bGwjaOTwhg0N
         rPxovbe01DH/1p/fxw2jpQbxmM6yHVijnIsHFz81J9InCTwj9x1344Ghn95VN1RiUj
         6SPiBqMS8Yd2wVl54NMiPryk3SEq4XUuynCx5xoRN7oZ6qAxTgVv4zuuGaCEFWavPU
         8aapbdSNsEgRg==
Date:   Thu, 29 Jun 2023 08:18:36 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/32: Use a thread flag to track SYSENTER status
User-Agent: K-9 Mail for Android
In-Reply-To: <20230628230015.105355-1-brgerst@gmail.com>
References: <20230628230015.105355-1-brgerst@gmail.com>
Message-ID: <98A1A198-8907-47EB-9264-20FA651DE487@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 28, 2023 4:00:15 PM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>When a task is in VM86 mode, the SYSENTER instruction must be disabled
>to prevent kernel stack corruption=2E  Use a thread flag to track when a
>task needs SYSENTER disabled instead of abusing the ss1 field of the
>TSS=2E
>
>Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>---
> arch/x86/include/asm/processor=2Eh   | 26 ++------------------------
> arch/x86/include/asm/switch_to=2Eh   | 12 ------------
> arch/x86/include/asm/thread_info=2Eh |  5 ++++-
> arch/x86/include/asm/vm86=2Eh        |  8 ++++++++
> arch/x86/kernel/cpu/common=2Ec       | 10 +---------
> arch/x86/kernel/process=2Ec          |  4 +++-
> arch/x86/kernel/process_32=2Ec       |  1 -
> arch/x86/kernel/vm86_32=2Ec          |  8 ++++----
> 8 files changed, 22 insertions(+), 52 deletions(-)
>
>diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm/pr=
ocessor=2Eh
>index b216ac80ebcc=2E=2E96a5e3e5bb7b 100644
>--- a/arch/x86/include/asm/processor=2Eh
>+++ b/arch/x86/include/asm/processor=2Eh
>@@ -226,23 +226,7 @@ struct x86_hw_tss {
> 	unsigned long		sp0;
> 	unsigned short		ss0, __ss0h;
> 	unsigned long		sp1;
>-
>-	/*
>-	 * We don't use ring 1, so ss1 is a convenient scratch space in
>-	 * the same cacheline as sp0=2E  We use ss1 to cache the value in
>-	 * MSR_IA32_SYSENTER_CS=2E  When we context switch
>-	 * MSR_IA32_SYSENTER_CS, we first check if the new value being
>-	 * written matches ss1, and, if it's not, then we wrmsr the new
>-	 * value and update ss1=2E
>-	 *
>-	 * The only reason we context switch MSR_IA32_SYSENTER_CS is
>-	 * that we set it to zero in vm86 tasks to avoid corrupting the
>-	 * stack if we were to go through the sysenter path from vm86
>-	 * mode=2E
>-	 */
>-	unsigned short		ss1;	/* MSR_IA32_SYSENTER_CS */
>-
>-	unsigned short		__ss1h;
>+	unsigned short		ss1, __ss1h;
> 	unsigned long		sp2;
> 	unsigned short		ss2, __ss2h;
> 	unsigned long		__cr3;
>@@ -419,16 +403,11 @@ struct thread_struct {
> 	unsigned long		sp0;
> #endif
> 	unsigned long		sp;
>-#ifdef CONFIG_X86_32
>-	unsigned long		sysenter_cs;
>-#else
>+#ifdef CONFIG_X86_64
> 	unsigned short		es;
> 	unsigned short		ds;
> 	unsigned short		fsindex;
> 	unsigned short		gsindex;
>-#endif
>-
>-#ifdef CONFIG_X86_64
> 	unsigned long		fsbase;
> 	unsigned long		gsbase;
> #else
>@@ -648,7 +627,6 @@ static inline void spin_lock_prefetch(const void *x)
> #ifdef CONFIG_X86_32
> #define INIT_THREAD  {							  \
> 	=2Esp0			=3D TOP_OF_INIT_STACK,			  \
>-	=2Esysenter_cs		=3D __KERNEL_CS,				  \
> }
>=20
> #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
>diff --git a/arch/x86/include/asm/switch_to=2Eh b/arch/x86/include/asm/sw=
itch_to=2Eh
>index 5c91305d09d2=2E=2E53d34c6fb581 100644
>--- a/arch/x86/include/asm/switch_to=2Eh
>+++ b/arch/x86/include/asm/switch_to=2Eh
>@@ -49,18 +49,6 @@ do {									\
> 	((last) =3D __switch_to_asm((prev), (next)));			\
> } while (0)
>=20
>-#ifdef CONFIG_X86_32
>-static inline void refresh_sysenter_cs(struct thread_struct *thread)
>-{
>-	/* Only happens when SEP is enabled, no need to test "SEP"arately: */
>-	if (unlikely(this_cpu_read(cpu_tss_rw=2Ex86_tss=2Ess1) =3D=3D thread->s=
ysenter_cs))
>-		return;
>-
>-	this_cpu_write(cpu_tss_rw=2Ex86_tss=2Ess1, thread->sysenter_cs);
>-	wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
>-}
>-#endif
>-
> /* This is used when switching tasks or entering/exiting vm86 mode=2E */
> static inline void update_task_stack(struct task_struct *task)
> {
>diff --git a/arch/x86/include/asm/thread_info=2Eh b/arch/x86/include/asm/=
thread_info=2Eh
>index f1cccba52eb9=2E=2E7f7332290ee1 100644
>--- a/arch/x86/include/asm/thread_info=2Eh
>+++ b/arch/x86/include/asm/thread_info=2Eh
>@@ -78,6 +78,7 @@ struct thread_info {
>  * - these are process state flags that various assembly files
>  *   may need to access
>  */
>+#define TIF_DISABLE_SYSENTER	0	/* disable SYSENTER for VM86 mode */
> #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
> #define TIF_SIGPENDING		2	/* signal pending */
> #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
>@@ -101,6 +102,7 @@ struct thread_info {
> #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
> #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
>=20
>+#define _TIF_DISABLE_SYSENTER	(1 << TIF_DISABLE_SYSENTER)
> #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
> #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
> #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>@@ -126,7 +128,8 @@ struct thread_info {
> /* flags to check in __switch_to() */
> #define _TIF_WORK_CTXSW_BASE					\
> 	(_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |		\
>-	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
>+	 _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE | 			\
>+	 _TIF_DISABLE_SYSENTER)
>=20
> /*
>  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated=2E
>diff --git a/arch/x86/include/asm/vm86=2Eh b/arch/x86/include/asm/vm86=2E=
h
>index 9e8ac5073ecb=2E=2E9e3cdbfe6e45 100644
>--- a/arch/x86/include/asm/vm86=2Eh
>+++ b/arch/x86/include/asm/vm86=2Eh
>@@ -72,6 +72,12 @@ static inline int invalid_vm86_irq(int irq)
>=20
> void release_vm86_irqs(struct task_struct *);
>=20
>+static inline void refresh_sysenter_cs(bool disable_sysenter)
>+{
>+	/* Only happens when SEP is enabled, no need to test "SEP"arately: */
>+	wrmsr(MSR_IA32_SYSENTER_CS, disable_sysenter ? 0 : __KERNEL_CS , 0);
>+}
>+
> #else
>=20
> #define handle_vm86_fault(a, b)
>@@ -86,6 +92,8 @@ static inline void save_v86_state(struct kernel_vm86_re=
gs *a, int b) { }
>=20
> #define free_vm86(t) do { } while(0)
>=20
>+static inline void refresh_sysenter_cs(bool disable_sysenter) { }
>+
> #endif /* CONFIG_VM86 */
>=20
> #endif /* _ASM_X86_VM86_H */
>diff --git a/arch/x86/kernel/cpu/common=2Ec b/arch/x86/kernel/cpu/common=
=2Ec
>index cf5275a67f39=2E=2Eaaf636e4d1de 100644
>--- a/arch/x86/kernel/cpu/common=2Ec
>+++ b/arch/x86/kernel/cpu/common=2Ec
>@@ -1933,22 +1933,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> #ifdef CONFIG_X86_32
> void enable_sep_cpu(void)
> {
>-	struct tss_struct *tss;
> 	int cpu;
>=20
> 	if (!boot_cpu_has(X86_FEATURE_SEP))
> 		return;
>=20
> 	cpu =3D get_cpu();
>-	tss =3D &per_cpu(cpu_tss_rw, cpu);
>=20
>-	/*
>-	 * We cache MSR_IA32_SYSENTER_CS's value in the TSS's ss1 field --
>-	 * see the big comment in struct x86_hw_tss's definition=2E
>-	 */
>-
>-	tss->x86_tss=2Ess1 =3D __KERNEL_CS;
>-	wrmsr(MSR_IA32_SYSENTER_CS, tss->x86_tss=2Ess1, 0);
>+	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
> 	wrmsr(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1),=
 0);
> 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32, 0);
>=20
>diff --git a/arch/x86/kernel/process=2Ec b/arch/x86/kernel/process=2Ec
>index cc7a642f8c9d=2E=2Ecd2c483b91c1 100644
>--- a/arch/x86/kernel/process=2Ec
>+++ b/arch/x86/kernel/process=2Ec
>@@ -75,7 +75,6 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struct=
, cpu_tss_rw) =3D {
> 		=2Esp1 =3D TOP_OF_INIT_STACK,
>=20
> 		=2Ess0 =3D __KERNEL_DS,
>-		=2Ess1 =3D __KERNEL_CS,
> #endif
> 		=2Eio_bitmap_base	=3D IO_BITMAP_OFFSET_INVALID,
> 	 },
>@@ -713,6 +712,9 @@ void __switch_to_xtra(struct task_struct *prev_p, str=
uct task_struct *next_p)
> 		/* Enforce MSR update to ensure consistent state */
> 		__speculation_ctrl_update(~tifn, tifn);
> 	}
>+
>+	if (unlikely((tifp ^ tifn) & _TIF_DISABLE_SYSENTER))
>+		refresh_sysenter_cs((tifn & _TIF_DISABLE_SYSENTER) !=3D 0);
> }
>=20
> /*
>diff --git a/arch/x86/kernel/process_32=2Ec b/arch/x86/kernel/process_32=
=2Ec
>index 708c87b88cc1=2E=2Ec609faa3e50e 100644
>--- a/arch/x86/kernel/process_32=2Ec
>+++ b/arch/x86/kernel/process_32=2Ec
>@@ -196,7 +196,6 @@ __switch_to(struct task_struct *prev_p, struct task_s=
truct *next_p)
> 	 * case prev or next is vm86=2E
> 	 */
> 	update_task_stack(next_p);
>-	refresh_sysenter_cs(next);
> 	this_cpu_write(pcpu_hot=2Etop_of_stack,
> 		       (unsigned long)task_stack_page(next_p) +
> 		       THREAD_SIZE);
>diff --git a/arch/x86/kernel/vm86_32=2Ec b/arch/x86/kernel/vm86_32=2Ec
>index e9e803a4d44c=2E=2E9d25793ba999 100644
>--- a/arch/x86/kernel/vm86_32=2Ec
>+++ b/arch/x86/kernel/vm86_32=2Ec
>@@ -143,10 +143,10 @@ void save_v86_state(struct kernel_vm86_regs *regs, =
int retval)
> exit_vm86:
> 	preempt_disable();
> 	tsk->thread=2Esp0 =3D vm86->saved_sp0;
>-	tsk->thread=2Esysenter_cs =3D __KERNEL_CS;
> 	update_task_stack(tsk);
>-	refresh_sysenter_cs(&tsk->thread);
> 	vm86->saved_sp0 =3D 0;
>+	if (test_and_clear_thread_flag(TIF_DISABLE_SYSENTER))
>+		refresh_sysenter_cs(false);
> 	preempt_enable();
>=20
> 	memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));
>@@ -332,8 +332,8 @@ static long do_sys_vm86(struct vm86plus_struct __user=
 *user_vm86, bool plus)
> 	tsk->thread=2Esp0 +=3D 16;
>=20
> 	if (boot_cpu_has(X86_FEATURE_SEP)) {
>-		tsk->thread=2Esysenter_cs =3D 0;
>-		refresh_sysenter_cs(&tsk->thread);
>+		set_thread_flag(TIF_DISABLE_SYSENTER);
>+		refresh_sysenter_cs(true);
> 	}
>=20
> 	update_task_stack(tsk);

As much as I find the ss1 hack putrid, is this purely a cleanup or is ther=
e a stronger motivation for it? Could you clarify in the patch comment?
