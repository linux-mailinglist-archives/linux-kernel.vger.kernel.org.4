Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEE16B574E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCKBQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCKBQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:16:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDE712EAD4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:16:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09601B82400
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45B7C433EF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678497374;
        bh=fdYt0/TQ3Aj7zgCLO05X233RmzS5yLIi4fZ0RFj4xi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AJZDpvF1/nJL6fn+w60DzREvk7JdbwK7usj70zmvUeeIkfwJ/h5nBiOGtAiEKW22N
         qevp6/k0yD1k5nwg7BRbhP57xUiPgJmA/UPRlpA61g2cSOLvoNrp6ce4Rnl2LkhcUg
         v8/dNGPsJcsRbzIJfjVfxwUoXgZ5qchKVGJ3MiAWNEB3XdKQPc+eEZyy7+iwU5ZQ+q
         ZPOZWvayvSI0QiDzy0myd+3ey69QF3a7ZPWrkPjGh57angYCXRmmNhnrdi/jbNgtc3
         DjDTGDdzIujkQbWXBw87wT5iPP9UUuLaD7eFbaGmLWvbNDIp153rRFs3zwc0QqT2Gk
         0q5wJqKcgGefw==
Received: by mail-ed1-f54.google.com with SMTP id r15so425449edq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:16:14 -0800 (PST)
X-Gm-Message-State: AO0yUKUBpxefNgMfiPYow+yGyqhsAGjv1+koSxxuXkxtk9xX2o+puesL
        FaqfeJEFEVZ7uJQJx9vYUntcCoPitpXdlhZ+onw=
X-Google-Smtp-Source: AK7set95P8vTUn/vE+XOvQiPznq/YJRKwfAlP4aHLONiOGqtz0BUNiG2VToRziHiGlpilYu+etTewxEp7ojGtT/YLwY=
X-Received: by 2002:a17:906:f47:b0:8b0:e909:9136 with SMTP id
 h7-20020a1709060f4700b008b0e9099136mr14396117ejj.1.1678497372982; Fri, 10 Mar
 2023 17:16:12 -0800 (PST)
MIME-Version: 1.0
References: <1678173001-16852-1-git-send-email-yangtiezhu@loongson.cn>
 <fb573603-edc1-9c87-5739-a33e5e1db6e1@loongson.cn> <20230311002221.721ef2d91e7defb65dd77b36@kernel.org>
In-Reply-To: <20230311002221.721ef2d91e7defb65dd77b36@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 11 Mar 2023 09:15:59 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wQyam2YoGZFnw8Z-tLZJvEHrdfNu1+Yb6Cbs1aKi=bQ@mail.gmail.com>
Message-ID: <CAAhV-H4wQyam2YoGZFnw8Z-tLZJvEHrdfNu1+Yb6Cbs1aKi=bQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add support for function error injection
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Fri, Mar 10, 2023 at 11:22=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> On Fri, 10 Mar 2023 10:07:09 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> > This feature is related with kprobes, add Masami to CC.
> >
> > On 03/07/2023 03:10 PM, Tiezhu Yang wrote:
> > > Inspired by the commit 42d038c4fb00 ("arm64: Add support for function=
 error
> > > injection") and commit ee55ff803b38 ("riscv: Add support for function=
 error
> > > injection"), support function error injection for LoongArch.
> > >
> > > Mainly implement two functions:
> > > (1) regs_set_return_value() which is used to overwrite the return val=
ue,
> > > (2) override_function_with_return() which is used to override the pro=
bed
> > > function returning and jump to its caller.
> > >
> > > Here is a simple test under CONFIG_FUNCTION_ERROR_INJECTION and
> > > CONFIG_FAIL_FUNCTION:
> > >
> > >   # echo sys_clone > /sys/kernel/debug/fail_function/inject
> > >   # echo 100 > /sys/kernel/debug/fail_function/probability
> > >   # dmesg
> > >   bash: fork: Invalid argument
> > >   # dmesg
> > >   ...
> > >   FAULT_INJECTION: forcing a failure.
> > >   name fail_function, interval 1, probability 100, space 0, times 1
> > >   ...
> > >   Call Trace:
> > >   [<90000000002238f4>] show_stack+0x5c/0x180
> > >   [<90000000012e384c>] dump_stack_lvl+0x60/0x88
> > >   [<9000000000b1879c>] should_fail_ex+0x1b0/0x1f4
> > >   [<900000000032ead4>] fei_kprobe_handler+0x28/0x6c
> > >   [<9000000000230970>] kprobe_breakpoint_handler+0xf0/0x118
> > >   [<90000000012e3e60>] do_bp+0x2c4/0x358
> > >   [<9000000002241924>] exception_handlers+0x1924/0x10000
> > >   [<900000000023b7d0>] sys_clone+0x0/0x4
> > >   [<90000000012e4744>] do_syscall+0x7c/0x94
> > >   [<9000000000221e44>] handle_syscall+0xc4/0x160
> > >
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> Thanks for porting! This looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Thanks!
>
> > > ---
> > >  arch/loongarch/Kconfig              |  1 +
> > >  arch/loongarch/include/asm/ptrace.h |  6 ++++++
> > >  arch/loongarch/lib/Makefile         |  2 ++
> > >  arch/loongarch/lib/error-inject.c   | 10 ++++++++++
> > >  4 files changed, 19 insertions(+)
> > >  create mode 100644 arch/loongarch/lib/error-inject.c
> > >
> > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > index 7fd5125..b16ff7e 100644
> > > --- a/arch/loongarch/Kconfig
> > > +++ b/arch/loongarch/Kconfig
> > > @@ -99,6 +99,7 @@ config LOONGARCH
> > >     select HAVE_FAST_GUP
> > >     select HAVE_FTRACE_MCOUNT_RECORD
> > >     select HAVE_FUNCTION_ARG_ACCESS_API
> > > +   select HAVE_FUNCTION_ERROR_INJECTION
> > >     select HAVE_FUNCTION_GRAPH_TRACER
> > >     select HAVE_FUNCTION_TRACER
> > >     select HAVE_GENERIC_VDSO
> > > diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/inc=
lude/asm/ptrace.h
> > > index d761db9..db7332a 100644
> > > --- a/arch/loongarch/include/asm/ptrace.h
> > > +++ b/arch/loongarch/include/asm/ptrace.h
> > > @@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_r=
egs *regs)
> > >     return regs->regs[4];
> > >  }
> > >
> > > +static inline void regs_set_return_value(struct pt_regs *regs,
> > > +                                    unsigned long val)
> > > +{
> > > +   regs->regs[4] =3D val;
> > > +}
> > > +
> > >  #define instruction_pointer(regs) ((regs)->csr_era)
> > >  #define profile_pc(regs) instruction_pointer(regs)
> > >
> > > diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefil=
e
> > > index 40bde63..30b1595 100644
> > > --- a/arch/loongarch/lib/Makefile
> > > +++ b/arch/loongarch/lib/Makefile
> > > @@ -5,3 +5,5 @@
> > >
> > >  lib-y      +=3D delay.o memset.o memcpy.o memmove.o \
> > >        clear_user.o copy_user.o dump_tlb.o unaligned.o
> > > +
> > > +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) +=3D error-inject.o
> > > diff --git a/arch/loongarch/lib/error-inject.c b/arch/loongarch/lib/e=
rror-inject.c
> > > new file mode 100644
> > > index 0000000..afc9e1c
> > > --- /dev/null
> > > +++ b/arch/loongarch/lib/error-inject.c
> > > @@ -0,0 +1,10 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/error-injection.h>
> > > +#include <linux/kprobes.h>
> > > +
> > > +void override_function_with_return(struct pt_regs *regs)
> > > +{
> > > +   instruction_pointer_set(regs, regs->regs[1]);
> > > +}
> > > +NOKPROBE_SYMBOL(override_function_with_return);
> > >
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
