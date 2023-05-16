Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0180370464E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjEPH1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjEPH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:26:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1220011C;
        Tue, 16 May 2023 00:26:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so24256520a12.2;
        Tue, 16 May 2023 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684222014; x=1686814014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKdo4MaiBN2b3CtstowQ7vu81lZz1hw49Wy9fx/PYjY=;
        b=j9Ha4Y6EMSL50wdL/5kaGEolLVmaZCdgVYeuY75TwVBqwny4PaWLeu4iziex01xYf4
         Nd62f0WXrdDoTlj5JBCXLYyyrmgbXE66FWPB0O0u9OnNFwXevyohn9n3fMMtc3jP999N
         was38FffkERSxyFljF+u6HI1cxaw8uKsGeQ6mUWrr2ho5APSH75aR9vAo+IndNVkFz7T
         wl580kRtlbhu3NTMQcXGiAt2rKLIURp2xuYZrCWaUgaXIWoKdiebz66Xc7qinK5JUyID
         t5NltsKDGLrpvlEUXY3FgroVJPigwvisLfGWGIj/Nk1CwVufjsLbe1SeH8+2zVVtiinl
         qWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222014; x=1686814014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKdo4MaiBN2b3CtstowQ7vu81lZz1hw49Wy9fx/PYjY=;
        b=hYlACAcvAFWjIv9XouHzZnyaaWPV9zmTD9y37cs+7j9cRNzbcemkLRuDeXMGNSY3Em
         gVEzOWsBKAMAoGRMGchztzb1sMzF6rShndyH5p2d0Mdho9bkJNWcN30IGAFXRAUbco58
         Vo1CzIaiLILQQs6pv0ktXH8jdBrVZPv+8Nm8nisQXWN2mKfgeeDYMcShctJw8KVBdZuM
         VvJozFpYIE9i7L9nBRW2F0jO68Kea33UYYa3QerEaPAi4/XE1uoyD+0+YQzYrONjd2ih
         jSiWMx4xGILnm4AkbUZeMUvIottVGjUfIYgKlJgVHr9HNfUWbwGg+VAk98+SDp9UsFvm
         8zjQ==
X-Gm-Message-State: AC+VfDzYV8btyUerqKyprxSgx4dNiyYUPuYORax2+Jayre7CaZwMiz5e
        ArCbuCOfqhY4ugzImseFQeZysIzD/jh01yv6OfpoqdZE89dXAA==
X-Google-Smtp-Source: ACHHUZ4lWZ9gH1gHWnnNjHviGAG3lgUn3oeL1L+7+6iobLu34Q93nj/lrZRX41u3rdIuWHYjad5Vo4xDTyFd71EA1sA=
X-Received: by 2002:aa7:df11:0:b0:505:4f7:8a50 with SMTP id
 c17-20020aa7df11000000b0050504f78a50mr27120560edy.5.1684222014179; Tue, 16
 May 2023 00:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684120990.git.zegao@tencent.com> <238bad4335d029072ca6000fb404f47376197f39.1684120990.git.zegao@tencent.com>
 <20230516132806.886543f000d93e0c2b26a2f3@kernel.org>
In-Reply-To: <20230516132806.886543f000d93e0c2b26a2f3@kernel.org>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 16 May 2023 15:26:42 +0800
Message-ID: <CAD8CoPBzvFxmRaiXZ=WrvYUaz78NY=1z_dZ03EAJUw9wPrkSoA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rehook, fprobe: mark rethook related functions notrace
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ze Gao <zegao@tencent.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thanks for your review. I've applied the makefile trick to arch files
specific to rethook just as
mentioned by Steven. And here is the link:

https://lore.kernel.org/linux-trace-kernel/20230516071830.8190-2-zegao@tenc=
ent.com/T/#m503e513071e82d5234d80a1b9e15eb126e334608

Unnecessary notrace annotations have been dropped in this new series.

Thank you,
Ze

On Tue, May 16, 2023 at 12:28=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Mon, 15 May 2023 11:26:41 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > These functions are already marked as NOKPROBE to prevent recusion and
> > we have the same reason to blacklist them if rethook is used with fprob=
e,
> > since they are beyond the recursion-free region ftrace can guard.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >  arch/riscv/kernel/probes/rethook.c | 4 ++--
> >  arch/s390/kernel/rethook.c         | 6 +++---
> >  arch/x86/kernel/rethook.c          | 8 +++++---
> >  kernel/trace/rethook.c             | 8 ++++----
>
> Except for the kernel/trace/rethook.c, those looks good to me.
> Could you drop notrace from kernel/trace/rethook.c? As Steve mentioned
> all functions in that file is automatically notraced.
>
> Thank you,
>
> >  4 files changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/pro=
bes/rethook.c
> > index 5c27c1f50989..803c412a1bea 100644
> > --- a/arch/riscv/kernel/probes/rethook.c
> > +++ b/arch/riscv/kernel/probes/rethook.c
> > @@ -8,14 +8,14 @@
> >  #include "rethook.h"
> >
> >  /* This is called from arch_rethook_trampoline() */
> > -unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *=
regs)
> > +unsigned long __used notrace arch_rethook_trampoline_callback(struct p=
t_regs *regs)
> >  {
> >       return rethook_trampoline_handler(regs, regs->s0);
> >  }
> >
> >  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> >
> > -void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *re=
gs, bool mcount)
> > +void notrace arch_rethook_prepare(struct rethook_node *rhn, struct pt_=
regs *regs, bool mcount)
> >  {
> >       rhn->ret_addr =3D regs->ra;
> >       rhn->frame =3D regs->s0;
> > diff --git a/arch/s390/kernel/rethook.c b/arch/s390/kernel/rethook.c
> > index af10e6bdd34e..ad52119826c1 100644
> > --- a/arch/s390/kernel/rethook.c
> > +++ b/arch/s390/kernel/rethook.c
> > @@ -3,7 +3,7 @@
> >  #include <linux/kprobes.h>
> >  #include "rethook.h"
> >
> > -void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *reg=
s, bool mcount)
> > +void notrace arch_rethook_prepare(struct rethook_node *rh, struct pt_r=
egs *regs, bool mcount)
> >  {
> >       rh->ret_addr =3D regs->gprs[14];
> >       rh->frame =3D regs->gprs[15];
> > @@ -13,7 +13,7 @@ void arch_rethook_prepare(struct rethook_node *rh, st=
ruct pt_regs *regs, bool mc
> >  }
> >  NOKPROBE_SYMBOL(arch_rethook_prepare);
> >
> > -void arch_rethook_fixup_return(struct pt_regs *regs,
> > +void notrace arch_rethook_fixup_return(struct pt_regs *regs,
> >                              unsigned long correct_ret_addr)
> >  {
> >       /* Replace fake return address with real one. */
> > @@ -24,7 +24,7 @@ NOKPROBE_SYMBOL(arch_rethook_fixup_return);
> >  /*
> >   * Called from arch_rethook_trampoline
> >   */
> > -unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs)
> > +unsigned long notrace arch_rethook_trampoline_callback(struct pt_regs =
*regs)
> >  {
> >       return rethook_trampoline_handler(regs, regs->gprs[15]);
> >  }
> > diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> > index 8a1c0111ae79..1f7cef86f73d 100644
> > --- a/arch/x86/kernel/rethook.c
> > +++ b/arch/x86/kernel/rethook.c
> > @@ -64,7 +64,8 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline);
> >  /*
> >   * Called from arch_rethook_trampoline
> >   */
> > -__used __visible void arch_rethook_trampoline_callback(struct pt_regs =
*regs)
> > +__used __visible void notrace arch_rethook_trampoline_callback(struct =
pt_regs
> > +             *regs)
> >  {
> >       unsigned long *frame_pointer;
> >
> > @@ -104,7 +105,7 @@ NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> >  STACK_FRAME_NON_STANDARD_FP(arch_rethook_trampoline);
> >
> >  /* This is called from rethook_trampoline_handler(). */
> > -void arch_rethook_fixup_return(struct pt_regs *regs,
> > +void notrace arch_rethook_fixup_return(struct pt_regs *regs,
> >                              unsigned long correct_ret_addr)
> >  {
> >       unsigned long *frame_pointer =3D (void *)(regs + 1);
> > @@ -114,7 +115,8 @@ void arch_rethook_fixup_return(struct pt_regs *regs=
,
> >  }
> >  NOKPROBE_SYMBOL(arch_rethook_fixup_return);
> >
> > -void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *reg=
s, bool mcount)
> > +void notrace arch_rethook_prepare(struct rethook_node *rh, struct pt_r=
egs
> > +             *regs, bool mcount)
> >  {
> >       unsigned long *stack =3D (unsigned long *)regs->sp;
> >
> > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > index 60f6cb2b486b..e551e86d3927 100644
> > --- a/kernel/trace/rethook.c
> > +++ b/kernel/trace/rethook.c
> > @@ -127,7 +127,7 @@ static void free_rethook_node_rcu(struct rcu_head *=
head)
> >   * Return back the @node to @node::rethook. If the @node::rethook is a=
lready
> >   * marked as freed, this will free the @node.
> >   */
> > -void rethook_recycle(struct rethook_node *node)
> > +void notrace rethook_recycle(struct rethook_node *node)
> >  {
> >       lockdep_assert_preemption_disabled();
> >
> > @@ -194,7 +194,7 @@ void rethook_hook(struct rethook_node *node, struct=
 pt_regs *regs, bool mcount)
> >  NOKPROBE_SYMBOL(rethook_hook);
> >
> >  /* This assumes the 'tsk' is the current task or is not running. */
> > -static unsigned long __rethook_find_ret_addr(struct task_struct *tsk,
> > +static unsigned long notrace __rethook_find_ret_addr(struct task_struc=
t *tsk,
> >                                            struct llist_node **cur)
> >  {
> >       struct rethook_node *rh =3D NULL;
> > @@ -256,7 +256,7 @@ unsigned long rethook_find_ret_addr(struct task_str=
uct *tsk, unsigned long frame
> >  }
> >  NOKPROBE_SYMBOL(rethook_find_ret_addr);
> >
> > -void __weak arch_rethook_fixup_return(struct pt_regs *regs,
> > +void __weak notrace arch_rethook_fixup_return(struct pt_regs *regs,
> >                                     unsigned long correct_ret_addr)
> >  {
> >       /*
> > @@ -268,7 +268,7 @@ void __weak arch_rethook_fixup_return(struct pt_reg=
s *regs,
> >  }
> >
> >  /* This function will be called from each arch-defined trampoline. */
> > -unsigned long rethook_trampoline_handler(struct pt_regs *regs,
> > +unsigned long notrace rethook_trampoline_handler(struct pt_regs *regs,
> >                                        unsigned long frame)
> >  {
> >       struct llist_node *first, *node =3D NULL;
> > --
> > 2.40.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
