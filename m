Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7348E5F0AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiI3LrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiI3Lqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E79EB3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6E5622F0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D22C43470
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664538136;
        bh=KFROWPn73/7rJP9SI4CZud7oy+CCbKgOqA6fz7R31+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZjqGS3asHUSkBp9ZBlUW7q6K3X+XdXJZcMOS9as2NE9T6EvcUfm075rOUpaUXv6co
         DE9grf8QOP5h1aBZH/tnqSzIwPr+1wzQUlEmj93ecfQg7vQ61Zw2rWQdJCZ69Hq02h
         Jb6zP4iacZV3IKjIZsJdC+lB+bWU6XpLuTxixKrbjcPvcHQc2kphK63Dn44IScHfme
         TGRJy4rz0q0QbwdWD7fmY7SkyAHn5wDiDh+AqzTFb/FX8ZarxJqhpRo/onU2uH1vY4
         kSiJT7YaBsBaQfeHGtRhOlu90f9U9t0iprXWtehZ0T+aAjIOdcHSJo/5kzO4LDXKV7
         krH40VTxHy5ww==
Received: by mail-oi1-f174.google.com with SMTP id g130so4416900oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:42:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf3yl2yFAjMlVLdOGQchjc3oiD7KpnkhqrKtxwEgfIg9QG1JomBe
        1BLfpNceKzEFMhpu/AhRpVlqMYJ66oTrnhUyvZo=
X-Google-Smtp-Source: AMsMyM5fW7Z9eq8pH8iy/nhc1CcydnvenfTlTFms6cUFftUrU9LVXkgPcsDKEo/+VsWTpv7ZvXQ2G6yD9nRxsht64cE=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr9076652oiw.112.1664538135880; Fri, 30
 Sep 2022 04:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220925175356.681-1-jszhang@kernel.org> <20220925175356.681-3-jszhang@kernel.org>
 <CAJF2gTTqup62EM9LZQ-9daKk11O0geax9Z3HmTMOxYy2mAwm=w@mail.gmail.com>
 <YzHNr13U+SdwJHo1@xhacker> <CAJF2gTRbvvMcdm7ZrAeow=Dm7=HXx59+4g-3mBqb2-SN5mOpZg@mail.gmail.com>
 <YzR471Zo4LbSCJoX@xhacker>
In-Reply-To: <YzR471Zo4LbSCJoX@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 30 Sep 2022 19:42:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQxC6uxhbaZ_ftH6a4p58fp0C26r54EV5X5SdDr4xwmqQ@mail.gmail.com>
Message-ID: <CAJF2gTQxC6uxhbaZ_ftH6a4p58fp0C26r54EV5X5SdDr4xwmqQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] riscv: consolidate ret_from_kernel_thread into ret_from_fork
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:49 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 07:55:27AM +0800, Guo Ren wrote:
> > On Tue, Sep 27, 2022 at 12:14 AM Jisheng Zhang <jszhang@kernel.org> wro=
te:
> > >
> > > On Mon, Sep 26, 2022 at 07:25:30AM +0800, Guo Ren wrote:
> > > > On Mon, Sep 26, 2022 at 2:03 AM Jisheng Zhang <jszhang@kernel.org> =
wrote:
> > > > >
> > > > > The ret_from_kernel_thread() behaves similarly with ret_from_fork=
(),
> > > > > the only difference is whether call the fn(arg) or not, this can =
be
> > > > > acchieved by testing fn is NULL or not, I.E s0 is 0 or not.
> > > > >
> > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > > ---
> > > > >  arch/riscv/kernel/entry.S   | 11 +++--------
> > > > >  arch/riscv/kernel/process.c |  5 ++---
> > > > >  2 files changed, 5 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.=
S
> > > > > index 2207cf44a3bc..a3e1ed2fa2ac 100644
> > > > > --- a/arch/riscv/kernel/entry.S
> > > > > +++ b/arch/riscv/kernel/entry.S
> > > > > @@ -323,20 +323,15 @@ END(handle_kernel_stack_overflow)
> > > > >
> > > > >  ENTRY(ret_from_fork)
> > > > >         call schedule_tail
> > > > > -       move a0, sp /* pt_regs */
> > > > > -       la ra, ret_from_exception
> > > > > -       tail syscall_exit_to_user_mode
> > > > > -ENDPROC(ret_from_fork)
> > > > > -
> > > > > -ENTRY(ret_from_kernel_thread)
> > > > > -       call schedule_tail
> > > > > +       beqz s0, 1f     /* not from kernel thread */
> > >
> > > Hi Guo,
> > >
> > > > We can't use s0 as condition for ret_from_fork/ret_from_kernel_thre=
ad.
> > > > The s0=3D0 is also okay for ret_from_fork.
> > >
> > > IIUC, in ret_from_fork, the s0 comes p->thread.s[0] rather than s0 in
> > > pt_regs.
> > Yes, you are correct.
> >
> > >
> > > >
> > > >         /* p->thread holds context to be restored by __switch_to() =
*/
> > > >         if (unlikely(args->fn)) {
> > > >                 /* Kernel thread */
> > > >                 memset(childregs, 0, sizeof(struct pt_regs));
> > > >                 childregs->gp =3D gp_in_global;
> > > >                 /* Supervisor/Machine, irqs on: */
> > > >                 childregs->status =3D SR_PP | SR_PIE;
> > > >
> > > >                 p->thread.ra =3D (unsigned long)ret_from_kernel_thr=
ead;
> > > >                 p->thread.s[0] =3D (unsigned long)args->fn;
> > > >                 p->thread.s[1] =3D (unsigned long)args->fn_arg;
> > > >         } else {
> > > >                 *childregs =3D *(current_pt_regs());
> > > >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Oh, I'm wrong, It's switch_to_restore -> exception_restore.
> >
> > > >                 if (usp) /* User fork */
> > > >                         childregs->sp =3D usp;
> > > >                 if (clone_flags & CLONE_SETTLS)
> > > >                         childregs->tp =3D tls;
> > > >                 childregs->a0 =3D 0; /* Return value of fork() */
> > > >                 p->thread.ra =3D (unsigned long)ret_from_fork;
> > > >         }
> > > >         p->thread.sp =3D (unsigned long)childregs; /* kernel sp */
> > > >
> > >
> > > <snip>
> > >
> > > > > @@ -182,8 +180,9 @@ int copy_thread(struct task_struct *p, const =
struct kernel_clone_args *args)
> > > > >                 if (clone_flags & CLONE_SETTLS)
> > > > >                         childregs->tp =3D tls;
> > > > >                 childregs->a0 =3D 0; /* Return value of fork() */
> > > > > -               p->thread.ra =3D (unsigned long)ret_from_fork;
> > > > > +               p->thread.s[0] =3D 0;
> > >
> > > Here we assign 0 to p->thread.s[0]
> > I missed that.
> >
> > Merge thread & fork is not a good idea, and using fp as the flag is so =
implicit.
> >
> > =E2=9E=9C  linux git:(rv64sv32) grep ret_from_fork arch -r | grep entry=
.S
> > arch/arc/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/arc/kernel/entry.S:END(ret_from_fork)
> > arch/csky/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/x86/kernel/process_32.c: * the task-switch, and shows up in
> > ret_from_fork in entry.S,
> > arch/alpha/kernel/entry.S:      .globl  ret_from_fork
> > arch/alpha/kernel/entry.S:      .ent    ret_from_fork
> > arch/alpha/kernel/entry.S:ret_from_fork:
> > arch/alpha/kernel/entry.S:.end ret_from_fork
> > arch/loongarch/kernel/entry.S:SYM_CODE_START(ret_from_fork)
> > arch/loongarch/kernel/entry.S:SYM_CODE_END(ret_from_fork)
> > arch/hexagon/kernel/vm_entry.S: .globl ret_from_fork
> > arch/hexagon/kernel/vm_entry.S:ret_from_fork:
> > arch/microblaze/kernel/entry.S:   (copy_thread makes ret_from_fork the
> > return address in each new thread's
> > arch/microblaze/kernel/entry.S:C_ENTRY(ret_from_fork):
> > arch/m68k/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/arm64/kernel/entry.S:SYM_CODE_START(ret_from_fork)
> > arch/arm64/kernel/entry.S:SYM_CODE_END(ret_from_fork)
> > arch/arm64/kernel/entry.S:NOKPROBE(ret_from_fork)
> > arch/riscv/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/riscv/kernel/entry.S:ENDPROC(ret_from_fork)
> > arch/s390/kernel/entry.S:# a new process exits the kernel with ret_from=
_fork
> > arch/s390/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/s390/kernel/entry.S:       brasl   %r14,__ret_from_fork
> > arch/s390/kernel/entry.S:ENDPROC(ret_from_fork)
> > arch/mips/kernel/entry.S:FEXPORT(ret_from_fork)
> > arch/openrisc/kernel/entry.S:   /* All syscalls return here... just
> > pay attention to ret_from_fork
> > arch/openrisc/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/openrisc/kernel/entry.S:    * that may be either schedule(),
> > ret_from_fork(), or
> > arch/nios2/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/xtensa/kernel/entry.S:ENTRY(ret_from_fork)
> > arch/xtensa/kernel/entry.S:ENDPROC(ret_from_fork)
> > arch/sparc/kernel/entry.S:      .globl  ret_from_fork
> > arch/sparc/kernel/entry.S:ret_from_fork:
> > =E2=9E=9C  linux git:(rv64sv32) grep ret_from_kernel_thread arch -r | g=
rep entry.S
> > arch/csky/kernel/entry.S:ENTRY(ret_from_kernel_thread)
> > arch/alpha/kernel/entry.S:      .globl  ret_from_kernel_thread
> > arch/alpha/kernel/entry.S:      .ent    ret_from_kernel_thread
> > arch/alpha/kernel/entry.S:ret_from_kernel_thread:
> > arch/alpha/kernel/entry.S:.end ret_from_kernel_thread
> > arch/parisc/kernel/entry.S:ENTRY(ret_from_kernel_thread)
> > arch/parisc/kernel/entry.S:END(ret_from_kernel_thread)
> > arch/loongarch/kernel/entry.S:SYM_CODE_START(ret_from_kernel_thread)
> > arch/loongarch/kernel/entry.S:SYM_CODE_END(ret_from_kernel_thread)
> > arch/microblaze/kernel/entry.S:C_ENTRY(ret_from_kernel_thread):
> > arch/m68k/kernel/entry.S:ENTRY(ret_from_kernel_thread)
> > arch/riscv/kernel/entry.S:ENTRY(ret_from_kernel_thread)
> > arch/riscv/kernel/entry.S:ENDPROC(ret_from_kernel_thread)
> > arch/mips/kernel/entry.S:FEXPORT(ret_from_kernel_thread)
> > arch/openrisc/kernel/entry.S:    * ret_from_kernel_thread().  If we
> > are returning to a new thread,
> > arch/nios2/kernel/entry.S:ENTRY(ret_from_kernel_thread)
> > arch/xtensa/kernel/entry.S:ENTRY(ret_from_kernel_thread)
> > arch/xtensa/kernel/entry.S:ENDPROC(ret_from_kernel_thread)
> > arch/sparc/kernel/entry.S:      .globl  ret_from_kernel_thread
> > arch/sparc/kernel/entry.S:ret_from_kernel_thread:
> >
> > Many architectures use a similar style. If you want to continue the
> > patch, I think you should first rename ret_from_fork properly, and
> > give an explicit flag definition, not just setting fp =3D 0.
> >
>
> Above list also shows many architectures don't have a
> ret_from_kernel_thread, I think the reason is simple it behaves
> similarly as ret_from_fork.
After looking at x86 & arm64, you've convinced me.

Acked-by: Guo Ren <guoren@kernel.org>

> As for flag, IMHO, we may missed something as clearing the s[12]
> array in thread_struct when user fork, because s[12] may contain
> random kernel memory content, which may be finally leaked to
> userspace. This is a security hole.
>
> A trivial patch of memset(0) can fix it, after this fix, checking the
> s[0] is straightforward.
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 67e7cd123ceb..50a0f7e4327c 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -174,6 +174,7 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>                 p->thread.s[0] =3D (unsigned long)args->fn;
>                 p->thread.s[1] =3D (unsigned long)args->fn_arg;
>         } else {
> +               memset(&p->thread.s, 0, sizeof(p->thread.s));
Good catch. s[12] may leave some information about the kernel.

It could be a separate patch with a Fixes flag.

>                 *childregs =3D *(current_pt_regs());
>                 if (usp) /* User fork */
>                         childregs->sp =3D usp;
>


--=20
Best Regards
 Guo Ren
