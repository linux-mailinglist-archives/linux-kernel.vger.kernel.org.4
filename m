Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D736B743D40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjF3OLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjF3OLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:11:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8FB4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:11:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso31299041fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688134305; x=1690726305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMItCX27/MIVUDkiZFXumQzM5rfwDzJ1LdMHuAHxfqw=;
        b=C8pyzTd8gBrJFMi7dym9iwqfROSkkVu/vkZLEpEmZv0qWGr7J5L94wSwwwrVAYu5KI
         9QPyFOOA9qUYqFO4TnI3Mm4DiN5BxHfLp69pijOPM/ndwLftNj086mllOSc1bewqS3zZ
         lJwC4DTEF/EehjPAES2ElJ+mH8KDSjtRnOQE//dd7ftL28zKqfbxN2dDBWRc+/NRXBO3
         9mCntLItwCnfWAGZSpMELRvmz1guU8t0GdBBoPysvE9Qv/21Jqe5ylUo9muyED+IWn2P
         pvqNR3N/gs00Va9pSkBifpUG1MS9AA3OUMQEQjH3lNe9WMpYCqgbsGURTRNZA6aX2f3C
         MitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688134305; x=1690726305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMItCX27/MIVUDkiZFXumQzM5rfwDzJ1LdMHuAHxfqw=;
        b=A0/SUbOPTeZ5JnehTPJHWMwlzp9ta6Dvs6ZV93c/cZz49NP8M3a53KU5MGHx0mY2Sy
         JIzI9Oq57/L5R2ynPEKXU1O+pfJPf4GQYMjWveuVFonM0i1rlUopv0TKfsye2DTyUGxP
         waxju3Z4Km+kF/6K87Nx8zghTO7vrrX4cNuS9sjSCF29UzfbmKuqiH4FN0rYol7LbiQw
         2ELhs5oohat4Ynu5HuWqUle9NHvCvxUaGbdaMb0nmZt8TLYd6abZnSmsVMuB00CI9SzL
         xMYrEydjUelkuqN8Oeaf6bOg1sxx9GELbTaApIcmsFafMmHssN65N8Wd4+uhyhcARxCy
         kNpg==
X-Gm-Message-State: ABy/qLYmRbJthhzFi/10x5Y3+bwhKuSyoGzjnSz9G0hGUYzL5JW2UOFR
        db4574LvwK7Gvrbgr2mJWbkHx2im6pNvEGAifA==
X-Google-Smtp-Source: APBJJlGr5YWmXUMoHNTB7AwNyXLuRxbHcgZnkD7kMKd1nBOqk+qB/BozWzc89kmoa2SzB/3LfnhFIkKSALBVZLRqEgE=
X-Received: by 2002:a2e:90d7:0:b0:2b4:5fdd:f583 with SMTP id
 o23-20020a2e90d7000000b002b45fddf583mr2020758ljg.51.1688134304693; Fri, 30
 Jun 2023 07:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230628230015.105355-1-brgerst@gmail.com> <98A1A198-8907-47EB-9264-20FA651DE487@zytor.com>
In-Reply-To: <98A1A198-8907-47EB-9264-20FA651DE487@zytor.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 30 Jun 2023 10:11:32 -0400
Message-ID: <CAMzpN2ji1qJ+OoGJts=WRjZQ+nx1eB0+zL=MnoBqh_3kguZP-w@mail.gmail.com>
Subject: Re: [PATCH] x86/32: Use a thread flag to track SYSENTER status
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
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

I was looking at merging and simplifying the SYSENTER/SYSCALL MSR
setup code, and the ss1 hack was making that more difficult.  I
haven't finished that part yet as I'm waiting for the dust to settle
on the 32-bit syscall disabling patches.

On Thu, Jun 29, 2023 at 11:18=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On June 28, 2023 4:00:15 PM PDT, Brian Gerst <brgerst@gmail.com> wrote:
> >When a task is in VM86 mode, the SYSENTER instruction must be disabled
> >to prevent kernel stack corruption.  Use a thread flag to track when a
> >task needs SYSENTER disabled instead of abusing the ss1 field of the
> >TSS.
> >
> >Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >---
> > arch/x86/include/asm/processor.h   | 26 ++------------------------
> > arch/x86/include/asm/switch_to.h   | 12 ------------
> > arch/x86/include/asm/thread_info.h |  5 ++++-
> > arch/x86/include/asm/vm86.h        |  8 ++++++++
> > arch/x86/kernel/cpu/common.c       | 10 +---------
> > arch/x86/kernel/process.c          |  4 +++-
> > arch/x86/kernel/process_32.c       |  1 -
> > arch/x86/kernel/vm86_32.c          |  8 ++++----
> > 8 files changed, 22 insertions(+), 52 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pro=
cessor.h
> >index b216ac80ebcc..96a5e3e5bb7b 100644
> >--- a/arch/x86/include/asm/processor.h
> >+++ b/arch/x86/include/asm/processor.h
> >@@ -226,23 +226,7 @@ struct x86_hw_tss {
> >       unsigned long           sp0;
> >       unsigned short          ss0, __ss0h;
> >       unsigned long           sp1;
> >-
> >-      /*
> >-       * We don't use ring 1, so ss1 is a convenient scratch space in
> >-       * the same cacheline as sp0.  We use ss1 to cache the value in
> >-       * MSR_IA32_SYSENTER_CS.  When we context switch
> >-       * MSR_IA32_SYSENTER_CS, we first check if the new value being
> >-       * written matches ss1, and, if it's not, then we wrmsr the new
> >-       * value and update ss1.
> >-       *
> >-       * The only reason we context switch MSR_IA32_SYSENTER_CS is
> >-       * that we set it to zero in vm86 tasks to avoid corrupting the
> >-       * stack if we were to go through the sysenter path from vm86
> >-       * mode.
> >-       */
> >-      unsigned short          ss1;    /* MSR_IA32_SYSENTER_CS */
> >-
> >-      unsigned short          __ss1h;
> >+      unsigned short          ss1, __ss1h;
> >       unsigned long           sp2;
> >       unsigned short          ss2, __ss2h;
> >       unsigned long           __cr3;
> >@@ -419,16 +403,11 @@ struct thread_struct {
> >       unsigned long           sp0;
> > #endif
> >       unsigned long           sp;
> >-#ifdef CONFIG_X86_32
> >-      unsigned long           sysenter_cs;
> >-#else
> >+#ifdef CONFIG_X86_64
> >       unsigned short          es;
> >       unsigned short          ds;
> >       unsigned short          fsindex;
> >       unsigned short          gsindex;
> >-#endif
> >-
> >-#ifdef CONFIG_X86_64
> >       unsigned long           fsbase;
> >       unsigned long           gsbase;
> > #else
> >@@ -648,7 +627,6 @@ static inline void spin_lock_prefetch(const void *x)
> > #ifdef CONFIG_X86_32
> > #define INIT_THREAD  {                                                 =
         \
> >       .sp0                    =3D TOP_OF_INIT_STACK,                   =
   \
> >-      .sysenter_cs            =3D __KERNEL_CS,                         =
   \
> > }
> >
> > #define KSTK_ESP(task)                (task_pt_regs(task)->sp)
> >diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/swi=
tch_to.h
> >index 5c91305d09d2..53d34c6fb581 100644
> >--- a/arch/x86/include/asm/switch_to.h
> >+++ b/arch/x86/include/asm/switch_to.h
> >@@ -49,18 +49,6 @@ do {                                                 =
                       \
> >       ((last) =3D __switch_to_asm((prev), (next)));                    =
 \
> > } while (0)
> >
> >-#ifdef CONFIG_X86_32
> >-static inline void refresh_sysenter_cs(struct thread_struct *thread)
> >-{
> >-      /* Only happens when SEP is enabled, no need to test "SEP"arately=
: */
> >-      if (unlikely(this_cpu_read(cpu_tss_rw.x86_tss.ss1) =3D=3D thread-=
>sysenter_cs))
> >-              return;
> >-
> >-      this_cpu_write(cpu_tss_rw.x86_tss.ss1, thread->sysenter_cs);
> >-      wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
> >-}
> >-#endif
> >-
> > /* This is used when switching tasks or entering/exiting vm86 mode. */
> > static inline void update_task_stack(struct task_struct *task)
> > {
> >diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/t=
hread_info.h
> >index f1cccba52eb9..7f7332290ee1 100644
> >--- a/arch/x86/include/asm/thread_info.h
> >+++ b/arch/x86/include/asm/thread_info.h
> >@@ -78,6 +78,7 @@ struct thread_info {
> >  * - these are process state flags that various assembly files
> >  *   may need to access
> >  */
> >+#define TIF_DISABLE_SYSENTER  0       /* disable SYSENTER for VM86 mode=
 */
> > #define TIF_NOTIFY_RESUME     1       /* callback before returning to u=
ser */
> > #define TIF_SIGPENDING                2       /* signal pending */
> > #define TIF_NEED_RESCHED      3       /* rescheduling necessary */
> >@@ -101,6 +102,7 @@ struct thread_info {
> > #define TIF_LAZY_MMU_UPDATES  27      /* task is updating the mmu lazil=
y */
> > #define TIF_ADDR32            29      /* 32-bit address space on 64 bit=
s */
> >
> >+#define _TIF_DISABLE_SYSENTER (1 << TIF_DISABLE_SYSENTER)
> > #define _TIF_NOTIFY_RESUME    (1 << TIF_NOTIFY_RESUME)
> > #define _TIF_SIGPENDING               (1 << TIF_SIGPENDING)
> > #define _TIF_NEED_RESCHED     (1 << TIF_NEED_RESCHED)
> >@@ -126,7 +128,8 @@ struct thread_info {
> > /* flags to check in __switch_to() */
> > #define _TIF_WORK_CTXSW_BASE                                  \
> >       (_TIF_NOCPUID | _TIF_NOTSC | _TIF_BLOCKSTEP |           \
> >-       _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE)
> >+       _TIF_SSBD | _TIF_SPEC_FORCE_UPDATE |                   \
> >+       _TIF_DISABLE_SYSENTER)
> >
> > /*
> >  * Avoid calls to __switch_to_xtra() on UP as STIBP is not evaluated.
> >diff --git a/arch/x86/include/asm/vm86.h b/arch/x86/include/asm/vm86.h
> >index 9e8ac5073ecb..9e3cdbfe6e45 100644
> >--- a/arch/x86/include/asm/vm86.h
> >+++ b/arch/x86/include/asm/vm86.h
> >@@ -72,6 +72,12 @@ static inline int invalid_vm86_irq(int irq)
> >
> > void release_vm86_irqs(struct task_struct *);
> >
> >+static inline void refresh_sysenter_cs(bool disable_sysenter)
> >+{
> >+      /* Only happens when SEP is enabled, no need to test "SEP"arately=
: */
> >+      wrmsr(MSR_IA32_SYSENTER_CS, disable_sysenter ? 0 : __KERNEL_CS , =
0);
> >+}
> >+
> > #else
> >
> > #define handle_vm86_fault(a, b)
> >@@ -86,6 +92,8 @@ static inline void save_v86_state(struct kernel_vm86_r=
egs *a, int b) { }
> >
> > #define free_vm86(t) do { } while(0)
> >
> >+static inline void refresh_sysenter_cs(bool disable_sysenter) { }
> >+
> > #endif /* CONFIG_VM86 */
> >
> > #endif /* _ASM_X86_VM86_H */
> >diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> >index cf5275a67f39..aaf636e4d1de 100644
> >--- a/arch/x86/kernel/cpu/common.c
> >+++ b/arch/x86/kernel/cpu/common.c
> >@@ -1933,22 +1933,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> > #ifdef CONFIG_X86_32
> > void enable_sep_cpu(void)
> > {
> >-      struct tss_struct *tss;
> >       int cpu;
> >
> >       if (!boot_cpu_has(X86_FEATURE_SEP))
> >               return;
> >
> >       cpu =3D get_cpu();
> >-      tss =3D &per_cpu(cpu_tss_rw, cpu);
> >
> >-      /*
> >-       * We cache MSR_IA32_SYSENTER_CS's value in the TSS's ss1 field -=
-
> >-       * see the big comment in struct x86_hw_tss's definition.
> >-       */
> >-
> >-      tss->x86_tss.ss1 =3D __KERNEL_CS;
> >-      wrmsr(MSR_IA32_SYSENTER_CS, tss->x86_tss.ss1, 0);
> >+      wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
> >       wrmsr(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu)=
 + 1), 0);
> >       wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32, 0)=
;
> >
> >diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> >index cc7a642f8c9d..cd2c483b91c1 100644
> >--- a/arch/x86/kernel/process.c
> >+++ b/arch/x86/kernel/process.c
> >@@ -75,7 +75,6 @@ __visible DEFINE_PER_CPU_PAGE_ALIGNED(struct tss_struc=
t, cpu_tss_rw) =3D {
> >               .sp1 =3D TOP_OF_INIT_STACK,
> >
> >               .ss0 =3D __KERNEL_DS,
> >-              .ss1 =3D __KERNEL_CS,
> > #endif
> >               .io_bitmap_base =3D IO_BITMAP_OFFSET_INVALID,
> >        },
> >@@ -713,6 +712,9 @@ void __switch_to_xtra(struct task_struct *prev_p, st=
ruct task_struct *next_p)
> >               /* Enforce MSR update to ensure consistent state */
> >               __speculation_ctrl_update(~tifn, tifn);
> >       }
> >+
> >+      if (unlikely((tifp ^ tifn) & _TIF_DISABLE_SYSENTER))
> >+              refresh_sysenter_cs((tifn & _TIF_DISABLE_SYSENTER) !=3D 0=
);
> > }
> >
> > /*
> >diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> >index 708c87b88cc1..c609faa3e50e 100644
> >--- a/arch/x86/kernel/process_32.c
> >+++ b/arch/x86/kernel/process_32.c
> >@@ -196,7 +196,6 @@ __switch_to(struct task_struct *prev_p, struct task_=
struct *next_p)
> >        * case prev or next is vm86.
> >        */
> >       update_task_stack(next_p);
> >-      refresh_sysenter_cs(next);
> >       this_cpu_write(pcpu_hot.top_of_stack,
> >                      (unsigned long)task_stack_page(next_p) +
> >                      THREAD_SIZE);
> >diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> >index e9e803a4d44c..9d25793ba999 100644
> >--- a/arch/x86/kernel/vm86_32.c
> >+++ b/arch/x86/kernel/vm86_32.c
> >@@ -143,10 +143,10 @@ void save_v86_state(struct kernel_vm86_regs *regs,=
 int retval)
> > exit_vm86:
> >       preempt_disable();
> >       tsk->thread.sp0 =3D vm86->saved_sp0;
> >-      tsk->thread.sysenter_cs =3D __KERNEL_CS;
> >       update_task_stack(tsk);
> >-      refresh_sysenter_cs(&tsk->thread);
> >       vm86->saved_sp0 =3D 0;
> >+      if (test_and_clear_thread_flag(TIF_DISABLE_SYSENTER))
> >+              refresh_sysenter_cs(false);
> >       preempt_enable();
> >
> >       memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));
> >@@ -332,8 +332,8 @@ static long do_sys_vm86(struct vm86plus_struct __use=
r *user_vm86, bool plus)
> >       tsk->thread.sp0 +=3D 16;
> >
> >       if (boot_cpu_has(X86_FEATURE_SEP)) {
> >-              tsk->thread.sysenter_cs =3D 0;
> >-              refresh_sysenter_cs(&tsk->thread);
> >+              set_thread_flag(TIF_DISABLE_SYSENTER);
> >+              refresh_sysenter_cs(true);
> >       }
> >
> >       update_task_stack(tsk);
>
> As much as I find the ss1 hack putrid, is this purely a cleanup or is the=
re a stronger motivation for it? Could you clarify in the patch comment?
