Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9937B649D38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiLLLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiLLLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:09:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0985CF5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:59:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF3901FB;
        Mon, 12 Dec 2022 02:46:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.40.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4EA43F5A1;
        Mon, 12 Dec 2022 02:46:14 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:46:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        rostedt@goodmis.org, samitolvanen@google.com, keescook@chromium.org
Subject: Re: [PATCH] ftrace: Allow WITH_ARGS flavour of graph tracer with
 shadow call stack
Message-ID: <Y5cGdBDKikCviu4Z@FVFF77S0Q05N>
References: <20221209143402.3332369-1-ardb@kernel.org>
 <20221211122731.f909ac15e227675229f03ecf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211122731.f909ac15e227675229f03ecf@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 12:27:31PM +0900, Masami Hiramatsu wrote:
> On Fri,  9 Dec 2022 15:34:02 +0100
> Ard Biesheuvel <ardb@kernel.org> wrote:
> 
> > The recent switch on arm64 from DYNAMIC_FTRACE_WITH_REGS to
> > DYNAMIC_FTRACE_WITH_ARGS failed to take into account that we currently
> > require the former in order to allow the function graph tracer to be
> > enabled in combination with shadow call stacks. This means that this is
> > no longer permitted at all, in spite of the fact that either flavour of
> > ftrace works perfectly fine in this combination.
> > 
> > Given that arm64 is the only arch that implements shadow call stacks in
> > the first place, let's update the condition to just reflect the arm64
> > change. When other architectures adopt shadow call stack support, this
> > can be revisited if needed.
> 
> This brings a question. Is the SCS safe if kretprobe(rethook) is enabled?
> it also changes the stack entry after a calling function.

That should be safe.

The SCS push is just an instruction somewhere in the function, and since
kretprobe instruments the first instruction of a function, that intrumentation
will run *before* the SCS push occurs, and so it can safely override the return
address.

The difficulty with ftrace is that the old mcount implementation calls into
ftrace *after* the function prologue, after saving some GPRs to the stack,
signing the return address with pointer authentication, and/or pushing the
return address to the SCS.

The DYNAMIC_FTRACE_WITH_{ARGS,REGS} forms use patchable-function-entry to hook
functions *before* any of that happens, and are safe for the same reason as
kretprobes.

Thanks,
Mark.

> 
> Thank you,
> 
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 072a1b39e3afd0d1..683f365b5e31c856 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -635,7 +635,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
> >  config SHADOW_CALL_STACK
> >  	bool "Shadow Call Stack"
> >  	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
> > -	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
> > +	depends on DYNAMIC_FTRACE_WITH_ARGS || !FUNCTION_GRAPH_TRACER
> >  	help
> >  	  This option enables the compiler's Shadow Call Stack, which
> >  	  uses a shadow stack to protect function return addresses from
> > -- 
> > 2.35.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
