Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626B5EB606
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiIZXz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiIZXzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:55:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF679680
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE1C6B816E9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44F2C43143
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664236543;
        bh=3oWBp5OuNgMk4osp9P8nypPw1Pry43XjuA12xTaf6Ak=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q+3y1fZVt2CGEGfpERpVE/yGjAX+Q/+EktIKab/h9I7bSZeiCveYzq7/QHfIz4yj8
         QyOTxGJ4Ba82eaie2j8xzJ1PiuWq8KGDThO+Eb//aB3WEjyI91j+ex2vLRvmv4qliI
         gYabKf4lS2MBZgyQXs8ezO0CuByHzfI9RAUL3LVq/boVIyRb047Jo1mb1FgORoN4fI
         TYuLq9Bjj46lY0THdKqEOfOaktRRlbGo1azMhjy0Fwo1BgdKqKHZU3z5NcB3n79uL9
         L4BzLoH+GthPQ//1qCbKnfxXjYn4ASrzDZvJzj3aMgiW1YpIrt4W/lxICeFtP/Bm82
         8jlqimysawzaw==
Received: by mail-ot1-f48.google.com with SMTP id r34-20020a05683044a200b0065a12392fd7so5450034otv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:55:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2ALDFsOmBjGNXxafWqMtzHy6oFP+5Hcv6DsoJp78RUwKAdzu2o
        YnrCWbCa4T5xmQLsr2qw+Vyk/7MDMJLzFLVGQbc=
X-Google-Smtp-Source: AMsMyM4f+D6DvJ/+x2of0iu+4OrOFy9HHMiCsEQmpdrH1/bZ+CR9gVfL7hSG/foSTOwrT+0d+IevqmOtrzL8lQnAWdc=
X-Received: by 2002:a9d:37b6:0:b0:65c:abc:c1d7 with SMTP id
 x51-20020a9d37b6000000b0065c0abcc1d7mr5909560otb.308.1664236542750; Mon, 26
 Sep 2022 16:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220925175356.681-1-jszhang@kernel.org> <20220925175356.681-3-jszhang@kernel.org>
 <CAJF2gTTqup62EM9LZQ-9daKk11O0geax9Z3HmTMOxYy2mAwm=w@mail.gmail.com> <YzHNr13U+SdwJHo1@xhacker>
In-Reply-To: <YzHNr13U+SdwJHo1@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Sep 2022 07:55:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRbvvMcdm7ZrAeow=Dm7=HXx59+4g-3mBqb2-SN5mOpZg@mail.gmail.com>
Message-ID: <CAJF2gTRbvvMcdm7ZrAeow=Dm7=HXx59+4g-3mBqb2-SN5mOpZg@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 12:14 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On Mon, Sep 26, 2022 at 07:25:30AM +0800, Guo Ren wrote:
> > On Mon, Sep 26, 2022 at 2:03 AM Jisheng Zhang <jszhang@kernel.org> wrot=
e:
> > >
> > > The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
> > > the only difference is whether call the fn(arg) or not, this can be
> > > acchieved by testing fn is NULL or not, I.E s0 is 0 or not.
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/riscv/kernel/entry.S   | 11 +++--------
> > >  arch/riscv/kernel/process.c |  5 ++---
> > >  2 files changed, 5 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > index 2207cf44a3bc..a3e1ed2fa2ac 100644
> > > --- a/arch/riscv/kernel/entry.S
> > > +++ b/arch/riscv/kernel/entry.S
> > > @@ -323,20 +323,15 @@ END(handle_kernel_stack_overflow)
> > >
> > >  ENTRY(ret_from_fork)
> > >         call schedule_tail
> > > -       move a0, sp /* pt_regs */
> > > -       la ra, ret_from_exception
> > > -       tail syscall_exit_to_user_mode
> > > -ENDPROC(ret_from_fork)
> > > -
> > > -ENTRY(ret_from_kernel_thread)
> > > -       call schedule_tail
> > > +       beqz s0, 1f     /* not from kernel thread */
>
> Hi Guo,
>
> > We can't use s0 as condition for ret_from_fork/ret_from_kernel_thread.
> > The s0=3D0 is also okay for ret_from_fork.
>
> IIUC, in ret_from_fork, the s0 comes p->thread.s[0] rather than s0 in
> pt_regs.
Yes, you are correct.

>
> >
> >         /* p->thread holds context to be restored by __switch_to() */
> >         if (unlikely(args->fn)) {
> >                 /* Kernel thread */
> >                 memset(childregs, 0, sizeof(struct pt_regs));
> >                 childregs->gp =3D gp_in_global;
> >                 /* Supervisor/Machine, irqs on: */
> >                 childregs->status =3D SR_PP | SR_PIE;
> >
> >                 p->thread.ra =3D (unsigned long)ret_from_kernel_thread;
> >                 p->thread.s[0] =3D (unsigned long)args->fn;
> >                 p->thread.s[1] =3D (unsigned long)args->fn_arg;
> >         } else {
> >                 *childregs =3D *(current_pt_regs());
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Oh, I'm wrong, It's switch_to_restore -> exception_restore.

> >                 if (usp) /* User fork */
> >                         childregs->sp =3D usp;
> >                 if (clone_flags & CLONE_SETTLS)
> >                         childregs->tp =3D tls;
> >                 childregs->a0 =3D 0; /* Return value of fork() */
> >                 p->thread.ra =3D (unsigned long)ret_from_fork;
> >         }
> >         p->thread.sp =3D (unsigned long)childregs; /* kernel sp */
> >
>
> <snip>
>
> > > @@ -182,8 +180,9 @@ int copy_thread(struct task_struct *p, const stru=
ct kernel_clone_args *args)
> > >                 if (clone_flags & CLONE_SETTLS)
> > >                         childregs->tp =3D tls;
> > >                 childregs->a0 =3D 0; /* Return value of fork() */
> > > -               p->thread.ra =3D (unsigned long)ret_from_fork;
> > > +               p->thread.s[0] =3D 0;
>
> Here we assign 0 to p->thread.s[0]
I missed that.

Merge thread & fork is not a good idea, and using fp as the flag is so impl=
icit.

=E2=9E=9C  linux git:(rv64sv32) grep ret_from_fork arch -r | grep entry.S
arch/arc/kernel/entry.S:ENTRY(ret_from_fork)
arch/arc/kernel/entry.S:END(ret_from_fork)
arch/csky/kernel/entry.S:ENTRY(ret_from_fork)
arch/x86/kernel/process_32.c: * the task-switch, and shows up in
ret_from_fork in entry.S,
arch/alpha/kernel/entry.S:      .globl  ret_from_fork
arch/alpha/kernel/entry.S:      .ent    ret_from_fork
arch/alpha/kernel/entry.S:ret_from_fork:
arch/alpha/kernel/entry.S:.end ret_from_fork
arch/loongarch/kernel/entry.S:SYM_CODE_START(ret_from_fork)
arch/loongarch/kernel/entry.S:SYM_CODE_END(ret_from_fork)
arch/hexagon/kernel/vm_entry.S: .globl ret_from_fork
arch/hexagon/kernel/vm_entry.S:ret_from_fork:
arch/microblaze/kernel/entry.S:   (copy_thread makes ret_from_fork the
return address in each new thread's
arch/microblaze/kernel/entry.S:C_ENTRY(ret_from_fork):
arch/m68k/kernel/entry.S:ENTRY(ret_from_fork)
arch/arm64/kernel/entry.S:SYM_CODE_START(ret_from_fork)
arch/arm64/kernel/entry.S:SYM_CODE_END(ret_from_fork)
arch/arm64/kernel/entry.S:NOKPROBE(ret_from_fork)
arch/riscv/kernel/entry.S:ENTRY(ret_from_fork)
arch/riscv/kernel/entry.S:ENDPROC(ret_from_fork)
arch/s390/kernel/entry.S:# a new process exits the kernel with ret_from_for=
k
arch/s390/kernel/entry.S:ENTRY(ret_from_fork)
arch/s390/kernel/entry.S:       brasl   %r14,__ret_from_fork
arch/s390/kernel/entry.S:ENDPROC(ret_from_fork)
arch/mips/kernel/entry.S:FEXPORT(ret_from_fork)
arch/openrisc/kernel/entry.S:   /* All syscalls return here... just
pay attention to ret_from_fork
arch/openrisc/kernel/entry.S:ENTRY(ret_from_fork)
arch/openrisc/kernel/entry.S:    * that may be either schedule(),
ret_from_fork(), or
arch/nios2/kernel/entry.S:ENTRY(ret_from_fork)
arch/xtensa/kernel/entry.S:ENTRY(ret_from_fork)
arch/xtensa/kernel/entry.S:ENDPROC(ret_from_fork)
arch/sparc/kernel/entry.S:      .globl  ret_from_fork
arch/sparc/kernel/entry.S:ret_from_fork:
=E2=9E=9C  linux git:(rv64sv32) grep ret_from_kernel_thread arch -r | grep =
entry.S
arch/csky/kernel/entry.S:ENTRY(ret_from_kernel_thread)
arch/alpha/kernel/entry.S:      .globl  ret_from_kernel_thread
arch/alpha/kernel/entry.S:      .ent    ret_from_kernel_thread
arch/alpha/kernel/entry.S:ret_from_kernel_thread:
arch/alpha/kernel/entry.S:.end ret_from_kernel_thread
arch/parisc/kernel/entry.S:ENTRY(ret_from_kernel_thread)
arch/parisc/kernel/entry.S:END(ret_from_kernel_thread)
arch/loongarch/kernel/entry.S:SYM_CODE_START(ret_from_kernel_thread)
arch/loongarch/kernel/entry.S:SYM_CODE_END(ret_from_kernel_thread)
arch/microblaze/kernel/entry.S:C_ENTRY(ret_from_kernel_thread):
arch/m68k/kernel/entry.S:ENTRY(ret_from_kernel_thread)
arch/riscv/kernel/entry.S:ENTRY(ret_from_kernel_thread)
arch/riscv/kernel/entry.S:ENDPROC(ret_from_kernel_thread)
arch/mips/kernel/entry.S:FEXPORT(ret_from_kernel_thread)
arch/openrisc/kernel/entry.S:    * ret_from_kernel_thread().  If we
are returning to a new thread,
arch/nios2/kernel/entry.S:ENTRY(ret_from_kernel_thread)
arch/xtensa/kernel/entry.S:ENTRY(ret_from_kernel_thread)
arch/xtensa/kernel/entry.S:ENDPROC(ret_from_kernel_thread)
arch/sparc/kernel/entry.S:      .globl  ret_from_kernel_thread
arch/sparc/kernel/entry.S:ret_from_kernel_thread:

Many architectures use a similar style. If you want to continue the
patch, I think you should first rename ret_from_fork properly, and
give an explicit flag definition, not just setting fp =3D 0.

>
> Thanks



--=20
Best Regards
 Guo Ren
