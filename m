Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F75EADA3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiIZRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiIZRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:08:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33782630
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA8C60E74
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A613C433C1;
        Mon, 26 Sep 2022 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664208871;
        bh=9mZcmdodNYy0rjsITnD/NXiAYxYxK3U+9un+VPbrPkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBuE/xwGLEeZ6roaFJUFS6djsXxPwuG1dCuSfA81AoTrZn0z7J7G8x/NSMb6AYrgB
         JDBr/L8v/m5x+vDaD7Y6lt9Ub1GkD9wqn2CGJFiXouY/AcK40BYnbS6QrAL5437hIx
         rkL35UueI3VjGdjCFX63Afu0loMGh4pp5uzVNR8PEu70Tm9l+zo0gA0hJxrNPBax56
         lzeSqkktvtttmgsOozfaswfETeYCcjcj9z/olFM+GzFGNsfgZJPPRXUZsx7EOdEyLd
         FKVQlX0A5mJwxRJ2Ud77xCHhMS7KNQGGVj+oGJVJ4ZQiSNU5RzLjzEmz3j+9mTnJnK
         2CQBAQ9vFtPCA==
Date:   Tue, 27 Sep 2022 00:05:03 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/4] riscv: consolidate ret_from_kernel_thread into
 ret_from_fork
Message-ID: <YzHNr13U+SdwJHo1@xhacker>
References: <20220925175356.681-1-jszhang@kernel.org>
 <20220925175356.681-3-jszhang@kernel.org>
 <CAJF2gTTqup62EM9LZQ-9daKk11O0geax9Z3HmTMOxYy2mAwm=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTTqup62EM9LZQ-9daKk11O0geax9Z3HmTMOxYy2mAwm=w@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 07:25:30AM +0800, Guo Ren wrote:
> On Mon, Sep 26, 2022 at 2:03 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > The ret_from_kernel_thread() behaves similarly with ret_from_fork(),
> > the only difference is whether call the fn(arg) or not, this can be
> > acchieved by testing fn is NULL or not, I.E s0 is 0 or not.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/entry.S   | 11 +++--------
> >  arch/riscv/kernel/process.c |  5 ++---
> >  2 files changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 2207cf44a3bc..a3e1ed2fa2ac 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -323,20 +323,15 @@ END(handle_kernel_stack_overflow)
> >
> >  ENTRY(ret_from_fork)
> >         call schedule_tail
> > -       move a0, sp /* pt_regs */
> > -       la ra, ret_from_exception
> > -       tail syscall_exit_to_user_mode
> > -ENDPROC(ret_from_fork)
> > -
> > -ENTRY(ret_from_kernel_thread)
> > -       call schedule_tail
> > +       beqz s0, 1f     /* not from kernel thread */

Hi Guo,

> We can't use s0 as condition for ret_from_fork/ret_from_kernel_thread.
> The s0=0 is also okay for ret_from_fork.

IIUC, in ret_from_fork, the s0 comes p->thread.s[0] rather than s0 in
pt_regs.

> 
>         /* p->thread holds context to be restored by __switch_to() */
>         if (unlikely(args->fn)) {
>                 /* Kernel thread */
>                 memset(childregs, 0, sizeof(struct pt_regs));
>                 childregs->gp = gp_in_global;
>                 /* Supervisor/Machine, irqs on: */
>                 childregs->status = SR_PP | SR_PIE;
> 
>                 p->thread.ra = (unsigned long)ret_from_kernel_thread;
>                 p->thread.s[0] = (unsigned long)args->fn;
>                 p->thread.s[1] = (unsigned long)args->fn_arg;
>         } else {
>                 *childregs = *(current_pt_regs());
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 if (usp) /* User fork */
>                         childregs->sp = usp;
>                 if (clone_flags & CLONE_SETTLS)
>                         childregs->tp = tls;
>                 childregs->a0 = 0; /* Return value of fork() */
>                 p->thread.ra = (unsigned long)ret_from_fork;
>         }
>         p->thread.sp = (unsigned long)childregs; /* kernel sp */
> 

<snip>

> > @@ -182,8 +180,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> >                 if (clone_flags & CLONE_SETTLS)
> >                         childregs->tp = tls;
> >                 childregs->a0 = 0; /* Return value of fork() */
> > -               p->thread.ra = (unsigned long)ret_from_fork;
> > +               p->thread.s[0] = 0;

Here we assign 0 to p->thread.s[0]

Thanks
