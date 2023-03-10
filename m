Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A736B4B36
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjCJPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjCJPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:35:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7B210868D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:22:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4FB4B822BD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7C0C433EF;
        Fri, 10 Mar 2023 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678461745;
        bh=K74NS78MWn372sPYD7Kq3OkGpFtcZEPbEVL3Js1ieNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1uhN3h3qfjIOeVZqtBT1aGRojWt3hGXbXH+v7kjtnzyb/gg5ryCQ+sm/oH/isrl8
         MVTmNHjxoiClbTkM1yxjLRydflPRsfEzOjwLHt+MkJEH6MQcderE5tTO7DBMW6xb8Q
         /Jd15nedC+scEimCV7+4w+ysUpJh3DgGDDxy5fT40+dWTU0QAmT645dDZuwuzg8iWe
         4ngGVK/4b2+YGz72PHTFlVtfNsmle9FeVKjmWCwROAAkTSxG9YJ488bDDfSJek+fnC
         1J28pNYVnNpbIUCiymn8sjwignSggmlpnqSkb0acd0PxSCXyMhCScsqoA/KAa/epoT
         PGyhw5A0ZvMow==
Date:   Sat, 11 Mar 2023 00:22:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] LoongArch: Add support for function error injection
Message-Id: <20230311002221.721ef2d91e7defb65dd77b36@kernel.org>
In-Reply-To: <fb573603-edc1-9c87-5739-a33e5e1db6e1@loongson.cn>
References: <1678173001-16852-1-git-send-email-yangtiezhu@loongson.cn>
        <fb573603-edc1-9c87-5739-a33e5e1db6e1@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 10:07:09 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> This feature is related with kprobes, add Masami to CC.
> 
> On 03/07/2023 03:10 PM, Tiezhu Yang wrote:
> > Inspired by the commit 42d038c4fb00 ("arm64: Add support for function error
> > injection") and commit ee55ff803b38 ("riscv: Add support for function error
> > injection"), support function error injection for LoongArch.
> >
> > Mainly implement two functions:
> > (1) regs_set_return_value() which is used to overwrite the return value,
> > (2) override_function_with_return() which is used to override the probed
> > function returning and jump to its caller.
> >
> > Here is a simple test under CONFIG_FUNCTION_ERROR_INJECTION and
> > CONFIG_FAIL_FUNCTION:
> >
> >   # echo sys_clone > /sys/kernel/debug/fail_function/inject
> >   # echo 100 > /sys/kernel/debug/fail_function/probability
> >   # dmesg
> >   bash: fork: Invalid argument
> >   # dmesg
> >   ...
> >   FAULT_INJECTION: forcing a failure.
> >   name fail_function, interval 1, probability 100, space 0, times 1
> >   ...
> >   Call Trace:
> >   [<90000000002238f4>] show_stack+0x5c/0x180
> >   [<90000000012e384c>] dump_stack_lvl+0x60/0x88
> >   [<9000000000b1879c>] should_fail_ex+0x1b0/0x1f4
> >   [<900000000032ead4>] fei_kprobe_handler+0x28/0x6c
> >   [<9000000000230970>] kprobe_breakpoint_handler+0xf0/0x118
> >   [<90000000012e3e60>] do_bp+0x2c4/0x358
> >   [<9000000002241924>] exception_handlers+0x1924/0x10000
> >   [<900000000023b7d0>] sys_clone+0x0/0x4
> >   [<90000000012e4744>] do_syscall+0x7c/0x94
> >   [<9000000000221e44>] handle_syscall+0xc4/0x160
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks for porting! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> > ---
> >  arch/loongarch/Kconfig              |  1 +
> >  arch/loongarch/include/asm/ptrace.h |  6 ++++++
> >  arch/loongarch/lib/Makefile         |  2 ++
> >  arch/loongarch/lib/error-inject.c   | 10 ++++++++++
> >  4 files changed, 19 insertions(+)
> >  create mode 100644 arch/loongarch/lib/error-inject.c
> >
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index 7fd5125..b16ff7e 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -99,6 +99,7 @@ config LOONGARCH
> >  	select HAVE_FAST_GUP
> >  	select HAVE_FTRACE_MCOUNT_RECORD
> >  	select HAVE_FUNCTION_ARG_ACCESS_API
> > +	select HAVE_FUNCTION_ERROR_INJECTION
> >  	select HAVE_FUNCTION_GRAPH_TRACER
> >  	select HAVE_FUNCTION_TRACER
> >  	select HAVE_GENERIC_VDSO
> > diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> > index d761db9..db7332a 100644
> > --- a/arch/loongarch/include/asm/ptrace.h
> > +++ b/arch/loongarch/include/asm/ptrace.h
> > @@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_regs *regs)
> >  	return regs->regs[4];
> >  }
> >
> > +static inline void regs_set_return_value(struct pt_regs *regs,
> > +					 unsigned long val)
> > +{
> > +	regs->regs[4] = val;
> > +}
> > +
> >  #define instruction_pointer(regs) ((regs)->csr_era)
> >  #define profile_pc(regs) instruction_pointer(regs)
> >
> > diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> > index 40bde63..30b1595 100644
> > --- a/arch/loongarch/lib/Makefile
> > +++ b/arch/loongarch/lib/Makefile
> > @@ -5,3 +5,5 @@
> >
> >  lib-y	+= delay.o memset.o memcpy.o memmove.o \
> >  	   clear_user.o copy_user.o dump_tlb.o unaligned.o
> > +
> > +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> > diff --git a/arch/loongarch/lib/error-inject.c b/arch/loongarch/lib/error-inject.c
> > new file mode 100644
> > index 0000000..afc9e1c
> > --- /dev/null
> > +++ b/arch/loongarch/lib/error-inject.c
> > @@ -0,0 +1,10 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/error-injection.h>
> > +#include <linux/kprobes.h>
> > +
> > +void override_function_with_return(struct pt_regs *regs)
> > +{
> > +	instruction_pointer_set(regs, regs->regs[1]);
> > +}
> > +NOKPROBE_SYMBOL(override_function_with_return);
> >
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
