Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7972A611781
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJ1Q2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJ1Q2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:28:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44CC4204AC5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:28:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08251FB;
        Fri, 28 Oct 2022 09:28:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DCC43F534;
        Fri, 28 Oct 2022 09:28:03 -0700 (PDT)
Date:   Fri, 28 Oct 2022 17:27:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        revest@chromium.org, will@kernel.org
Subject: Re: [PATCH 1/4] ftrace: pass fregs to arch_ftrace_set_direct_caller()
Message-ID: <Y1wDAoFugdR8WIsP@FVFF77S0Q05N>
References: <20221024140846.3555435-1-mark.rutland@arm.com>
 <20221024140846.3555435-2-mark.rutland@arm.com>
 <20221024104845.3c898d85@gandalf.local.home>
 <Y1bFsXt5njFNa01Q@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1bFsXt5njFNa01Q@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 06:04:49PM +0100, Mark Rutland wrote:
> On Mon, Oct 24, 2022 at 10:48:45AM -0400, Steven Rostedt wrote:
> > On Mon, 24 Oct 2022 15:08:43 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -429,6 +429,7 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
> > >  }
> > >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> > >  
> > > +#ifdef CONFIG_FUNCTION_TRACER
> > 
> > Instead of adding the above preprocessor check, the below chunk should be
> > moved into the CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS block above.
> 
> Sure; but note that doing that naively means 'struct ftrace_regs' won't always
> be declared (e.g. if !CONFIG_FUNCTION_TRACER), and will result in warnings, e.g.
> 
> |   CC      arch/x86/kernel/asm-offsets.s
> | In file included from ./include/linux/kvm_host.h:32,
> |                  from arch/x86/kernel/../kvm/vmx/vmx.h:5,
> |                  from arch/x86/kernel/asm-offsets.c:22:
> | ./include/linux/ftrace.h:444:57: error: ‘struct ftrace_regs’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> |   444 | static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
> |       |                                                         ^~~~~~~~~~~
> | cc1: all warnings being treated as errors
> | make[1]: *** [scripts/Makefile.build:118: arch/x86/kernel/asm-offsets.s] Error 1
> | make: *** [Makefile:1270: prepare0] Error 2
> 
> ... so I'll either need to add some ifdeffery, for CONFIG_FUNCTION_TRACER, or I
> can hoist the declaration of 'struct ftrace_regs' to not depend on
> CONFIG_FUNCTION_TRACER.
> 
> I guess the latter is preferable, e.g.
> 
> | diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> | index 2b34fec40a39..f201fcbfffb0 100644
> | --- a/include/linux/ftrace.h
> | +++ b/include/linux/ftrace.h
> | @@ -37,9 +37,10 @@ extern void ftrace_boot_snapshot(void);
> |  static inline void ftrace_boot_snapshot(void) { }
> |  #endif
> |  
> | -#ifdef CONFIG_FUNCTION_TRACER
> |  struct ftrace_ops;
> |  struct ftrace_regs;
> | +
> | +#ifdef CONFIG_FUNCTION_TRACER
> |  /*
> |   * If the arch's mcount caller does not support all of ftrace's
> |   * features, then it must call an indirect function that
> 
> ... so I've done that locally for now.

The kbuild robot complained that this led to x86 getting multiple definitions
of arch_ftrace_set_direct_caller(), so I've also added the below:

| diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
| index 788e7c1f6463c..6f9b9fee04132 100644
| --- a/arch/x86/include/asm/ftrace.h
| +++ b/arch/x86/include/asm/ftrace.h
| @@ -59,6 +59,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
|  #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
|  #endif
|  
| +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
|  /*
|   * When a ftrace registered caller is tracing a function that is
|   * also set by a register_ftrace_direct() call, it needs to be
| @@ -71,6 +72,7 @@ static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsi
|         /* Emulate a call */
|         fregs->regs.orig_ax = addr;
|  }
| +#endif
|  
|  #ifdef CONFIG_DYNAMIC_FTRACE

... AFAICT s390 doesn't need similar treatment.

Thanks,
Mark.
