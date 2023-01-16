Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5930466B541
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAPBau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAPBar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:30:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB8E5263
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27A85B80D08
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F35C433F2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673832642;
        bh=12T2X8RDZ1M1Qeqp6qv7sg6t335xyVN/wcF126qOz2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qz/uYj54Ev6DnMw2g9p59ewh3+Y7ERvUDO0MF9t22bQraj4SP8E/iwvlFxGcu/dU9
         A+hJbo9KappWH5TV4aNtNu5sSKZccJAKH24IM8JtrJjNlsk5ABTbrGD3YfK4TTkCTR
         y90qFPJuH9EHLFBiZQ2rAaxajpehjYL1beSIeDW+5BF6Y7toEKGvEAFMH5yynqDDli
         BgNWBHaP5W/q9NXL7TopDMW/hzOvPJIM94SaS4iJ7X9sHjeoLovRO89zxwKB1SElA8
         y4cqlYoCO77tKhpAQORHm8/2CuWxGw+sQZ9hnQp21ciJsbCVeOQYV1Eihh7ENrG8uz
         fjhc6szT4bpXA==
Received: by mail-ed1-f53.google.com with SMTP id x36so4162523ede.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:30:42 -0800 (PST)
X-Gm-Message-State: AFqh2kpB1fJbOSrWryU5URGWmMFZyg3IAmSK5IK0YVyaTzOqWM6uew/C
        XB/4RcbgZa/YPoQmO6yS3Affl2+ZA30Uq6ApRUA=
X-Google-Smtp-Source: AMrXdXv8A3JF4RJX30XsJ4oatMOZj4macNi7wKOkVFBcS8MFHhP3XslFpk/4riVhRcDzxQpgCLX+IB+wytY6Cc3sJ9s=
X-Received: by 2002:aa7:cf17:0:b0:49d:10b0:6ed8 with SMTP id
 a23-20020aa7cf17000000b0049d10b06ed8mr722647edy.254.1673832640914; Sun, 15
 Jan 2023 17:30:40 -0800 (PST)
MIME-Version: 1.0
References: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
 <1673255274-18238-2-git-send-email-tangyouling@loongson.cn> <6f1a1f3c-4569-c427-76ae-2f7093cb5e9f@loongson.cn>
In-Reply-To: <6f1a1f3c-4569-c427-76ae-2f7093cb5e9f@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 16 Jan 2023 09:30:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H55Kj4gMnORHfQUYJ3KBueLv7j+ktkNP9cE-=32nEShzg@mail.gmail.com>
Message-ID: <CAAhV-H55Kj4gMnORHfQUYJ3KBueLv7j+ktkNP9cE-=32nEShzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] LoongArch: Use trampoline for exception handlers and
 kill la.abs
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 2:38 PM Jinyang He <hejinyang@loongson.cn> wrote:
>
> Hi, Ruoyao and Youling,
>
> I care about the performance when NUMA enabled. We set CSR.EENTRY
> for each possible cpus where is NUMA-relative. So, I guess the more
> codes in NUMA-relative memory makes more performance. If we just set
> handler_trampoline as exception handler, the performance may be
> influenced.
So copying both the handlers and handler_trampoline can solve the
problem? If that is possible, please do that on top of the latest code
in
https://github.com/loongson/linux/commits/loongarch-next

Huacai
>
>
> Thanks,
>
> Jinyang
>
>
> On 2023-01-09 17:07, Youling Tang wrote:
> > From: Xi Ruoyao <xry111@xry111.site>
> >
> > Use a trampoline as an exception handlers, which can kill some use of
> > la.abs in preparation for the subsequent support of the PIE kernel.
> >
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/stackframe.h |  8 +++----
> >   arch/loongarch/include/asm/uaccess.h    |  1 -
> >   arch/loongarch/kernel/entry.S           |  6 +++---
> >   arch/loongarch/kernel/genex.S           | 20 +++++++++---------
> >   arch/loongarch/kernel/head.S            |  2 +-
> >   arch/loongarch/kernel/traps.c           |  4 +++-
> >   arch/loongarch/mm/tlbex.S               | 28 +++++++------------------
> >   7 files changed, 29 insertions(+), 40 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
> > index 4ca953062b5b..96c94035b5d0 100644
> > --- a/arch/loongarch/include/asm/stackframe.h
> > +++ b/arch/loongarch/include/asm/stackframe.h
> > @@ -76,8 +76,8 @@
> >    * kernelsp array for it. It stores the current sp in t0 and loads the
> >    * new value in sp.
> >    */
> > -     .macro  get_saved_sp docfi=0
> > -     la.abs    t1, kernelsp
> > +     .macro    get_saved_sp docfi=0
> > +     la.pcrel  t1, kernelsp
> >   #ifdef CONFIG_SMP
> >       csrrd     t0, PERCPU_BASE_KS
> >       LONG_ADD  t1, t1, t0
> > @@ -89,8 +89,8 @@
> >       LONG_L    sp, t1, 0
> >       .endm
> >
> > -     .macro  set_saved_sp stackp temp temp2
> > -     la.abs    \temp, kernelsp
> > +     .macro    set_saved_sp stackp temp temp2
> > +     la.pcrel  \temp, kernelsp
> >   #ifdef CONFIG_SMP
> >       LONG_ADD  \temp, \temp, u0
> >   #endif
> > diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
> > index 255899d4a7c3..0d22991ae430 100644
> > --- a/arch/loongarch/include/asm/uaccess.h
> > +++ b/arch/loongarch/include/asm/uaccess.h
> > @@ -22,7 +22,6 @@
> >   extern u64 __ua_limit;
> >
> >   #define __UA_ADDR   ".dword"
> > -#define __UA_LA              "la.abs"
> >   #define __UA_LIMIT  __ua_limit
> >
> >   /*
> > diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
> > index d53b631c9022..ca01afdbec3f 100644
> > --- a/arch/loongarch/kernel/entry.S
> > +++ b/arch/loongarch/kernel/entry.S
> > @@ -18,9 +18,9 @@
> >       .text
> >       .cfi_sections   .debug_frame
> >       .align  5
> > -SYM_FUNC_START(handle_syscall)
> > +SYM_FUNC_START(handle_sys)
> >       csrrd   t0, PERCPU_BASE_KS
> > -     la.abs  t1, kernelsp
> > +     la.pcrel        t1, kernelsp
> >       add.d   t1, t1, t0
> >       move    t2, sp
> >       ld.d    sp, t1, 0
> > @@ -66,7 +66,7 @@ SYM_FUNC_START(handle_syscall)
> >       bl      do_syscall
> >
> >       RESTORE_ALL_AND_RET
> > -SYM_FUNC_END(handle_syscall)
> > +SYM_FUNC_END(handle_sys)
> >
> >   SYM_CODE_START(ret_from_fork)
> >       bl      schedule_tail           # a0 = struct task_struct *prev
> > diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> > index 75e5be807a0d..d3df0fa725a2 100644
> > --- a/arch/loongarch/kernel/genex.S
> > +++ b/arch/loongarch/kernel/genex.S
> > @@ -32,9 +32,8 @@ SYM_FUNC_START(__arch_cpu_idle)
> >   SYM_FUNC_END(__arch_cpu_idle)
> >
> >   SYM_FUNC_START(handle_vint)
> > -     BACKUP_T0T1
> >       SAVE_ALL
> > -     la.abs  t1, __arch_cpu_idle
> > +     la.pcrel        t1, __arch_cpu_idle
> >       LONG_L  t0, sp, PT_ERA
> >       /* 32 byte rollback region */
> >       ori     t0, t0, 0x1f
> > @@ -43,8 +42,7 @@ SYM_FUNC_START(handle_vint)
> >       LONG_S  t0, sp, PT_ERA
> >   1:  move    a0, sp
> >       move    a1, sp
> > -     la.abs  t0, do_vint
> > -     jirl    ra, t0, 0
> > +     bl      do_vint
> >       RESTORE_ALL_AND_RET
> >   SYM_FUNC_END(handle_vint)
> >
> > @@ -67,12 +65,10 @@ SYM_FUNC_END(except_vec_cex)
> >       .macro  BUILD_HANDLER exception handler prep
> >       .align  5
> >       SYM_FUNC_START(handle_\exception)
> > -     BACKUP_T0T1
> >       SAVE_ALL
> >       build_prep_\prep
> >       move    a0, sp
> > -     la.abs  t0, do_\handler
> > -     jirl    ra, t0, 0
> > +     bl      do_\handler
> >       RESTORE_ALL_AND_RET
> >       SYM_FUNC_END(handle_\exception)
> >       .endm
> > @@ -89,7 +85,11 @@ SYM_FUNC_END(except_vec_cex)
> >       BUILD_HANDLER watch watch none
> >       BUILD_HANDLER reserved reserved none    /* others */
> >
> > -SYM_FUNC_START(handle_sys)
> > -     la.abs  t0, handle_syscall
> > +SYM_FUNC_START(handler_trampoline)
> > +     csrwr   t0, EXCEPTION_KS0
> > +     csrwr   t1, EXCEPTION_KS1
> > +     pcaddi  t0, 0
> > +     ld.d    t0, t0, 16
> >       jr      t0
> > -SYM_FUNC_END(handle_sys)
> > +     nop
> > +SYM_FUNC_END(handler_trampoline)
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > index 57bada6b4e93..aa6181714ec3 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -117,7 +117,7 @@ SYM_CODE_START(smpboot_entry)
> >       li.w            t0, 0x00                # FPE=0, SXE=0, ASXE=0, BTE=0
> >       csrwr           t0, LOONGARCH_CSR_EUEN
> >
> > -     la.abs          t0, cpuboot_data
> > +     la.pcrel        t0, cpuboot_data
> >       ld.d            sp, t0, CPU_BOOT_STACK
> >       ld.d            tp, t0, CPU_BOOT_TINFO
> >
> > diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> > index 7ea62faeeadb..0e8faaca3679 100644
> > --- a/arch/loongarch/kernel/traps.c
> > +++ b/arch/loongarch/kernel/traps.c
> > @@ -61,6 +61,7 @@ extern asmlinkage void handle_lasx(void);
> >   extern asmlinkage void handle_reserved(void);
> >   extern asmlinkage void handle_watch(void);
> >   extern asmlinkage void handle_vint(void);
> > +extern asmlinkage void handler_trampoline(void);
> >
> >   static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
> >                          const char *loglvl, bool user)
> > @@ -716,7 +717,8 @@ void per_cpu_trap_init(int cpu)
> >   /* Install CPU exception handler */
> >   void set_handler(unsigned long offset, void *addr, unsigned long size)
> >   {
> > -     memcpy((void *)(eentry + offset), addr, size);
> > +     memcpy((void *)(eentry + offset), &handler_trampoline, 24);
> > +     memcpy((void *)(eentry + offset + 24), &addr, 8);
> >       local_flush_icache_range(eentry + offset, eentry + offset + size);
> >   }
> >
> > diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> > index 58781c6e4191..cfaacdac518c 100644
> > --- a/arch/loongarch/mm/tlbex.S
> > +++ b/arch/loongarch/mm/tlbex.S
> > @@ -24,8 +24,7 @@
> >       move            a0, sp
> >       REG_S           a2, sp, PT_BVADDR
> >       li.w            a1, \write
> > -     la.abs          t0, do_page_fault
> > -     jirl            ra, t0, 0
> > +     bl              do_page_fault
> >       RESTORE_ALL_AND_RET
> >       SYM_FUNC_END(tlb_do_page_fault_\write)
> >       .endm
> > @@ -34,20 +33,16 @@
> >       tlb_do_page_fault 1
> >
> >   SYM_FUNC_START(handle_tlb_protect)
> > -     BACKUP_T0T1
> >       SAVE_ALL
> >       move            a0, sp
> >       move            a1, zero
> >       csrrd           a2, LOONGARCH_CSR_BADV
> >       REG_S           a2, sp, PT_BVADDR
> > -     la.abs          t0, do_page_fault
> > -     jirl            ra, t0, 0
> > +     bl              do_page_fault
> >       RESTORE_ALL_AND_RET
> >   SYM_FUNC_END(handle_tlb_protect)
> >
> >   SYM_FUNC_START(handle_tlb_load)
> > -     csrwr           t0, EXCEPTION_KS0
> > -     csrwr           t1, EXCEPTION_KS1
> >       csrwr           ra, EXCEPTION_KS2
> >
> >       /*
> > @@ -116,7 +111,7 @@ smp_pgtable_change_load:
> >
> >   #ifdef CONFIG_64BIT
> >   vmalloc_load:
> > -     la.abs          t1, swapper_pg_dir
> > +     la.pcrel        t1, swapper_pg_dir
> >       b               vmalloc_done_load
> >   #endif
> >
> > @@ -187,13 +182,10 @@ tlb_huge_update_load:
> >   nopage_tlb_load:
> >       dbar            0
> >       csrrd           ra, EXCEPTION_KS2
> > -     la.abs          t0, tlb_do_page_fault_0
> > -     jr              t0
> > +     b               tlb_do_page_fault_0
> >   SYM_FUNC_END(handle_tlb_load)
> >
> >   SYM_FUNC_START(handle_tlb_store)
> > -     csrwr           t0, EXCEPTION_KS0
> > -     csrwr           t1, EXCEPTION_KS1
> >       csrwr           ra, EXCEPTION_KS2
> >
> >       /*
> > @@ -263,7 +255,7 @@ smp_pgtable_change_store:
> >
> >   #ifdef CONFIG_64BIT
> >   vmalloc_store:
> > -     la.abs          t1, swapper_pg_dir
> > +     la.pcrel        t1, swapper_pg_dir
> >       b               vmalloc_done_store
> >   #endif
> >
> > @@ -336,13 +328,10 @@ tlb_huge_update_store:
> >   nopage_tlb_store:
> >       dbar            0
> >       csrrd           ra, EXCEPTION_KS2
> > -     la.abs          t0, tlb_do_page_fault_1
> > -     jr              t0
> > +     b               tlb_do_page_fault_1
> >   SYM_FUNC_END(handle_tlb_store)
> >
> >   SYM_FUNC_START(handle_tlb_modify)
> > -     csrwr           t0, EXCEPTION_KS0
> > -     csrwr           t1, EXCEPTION_KS1
> >       csrwr           ra, EXCEPTION_KS2
> >
> >       /*
> > @@ -411,7 +400,7 @@ smp_pgtable_change_modify:
> >
> >   #ifdef CONFIG_64BIT
> >   vmalloc_modify:
> > -     la.abs          t1, swapper_pg_dir
> > +     la.pcrel        t1, swapper_pg_dir
> >       b               vmalloc_done_modify
> >   #endif
> >
> > @@ -483,8 +472,7 @@ tlb_huge_update_modify:
> >   nopage_tlb_modify:
> >       dbar            0
> >       csrrd           ra, EXCEPTION_KS2
> > -     la.abs          t0, tlb_do_page_fault_1
> > -     jr              t0
> > +     b               tlb_do_page_fault_1
> >   SYM_FUNC_END(handle_tlb_modify)
> >
> >   SYM_FUNC_START(handle_tlb_refill)
>
