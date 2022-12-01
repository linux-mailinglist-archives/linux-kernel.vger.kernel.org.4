Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3463F48B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiLAPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiLAPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:54:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF46A8976
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3887FCE1D15
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4364EC433D6;
        Thu,  1 Dec 2022 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669910055;
        bh=KgUzMsnJxl5S84ksRk/ivCiFuctafV1QIdNmjNmeVz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qeIACNxujix93s88GjoojcGg/BMy8NUgGxzPiEEICMPCDMLNuvsMxf9qqv4JwINkG
         jb83En2iCUhf12QEEQ2qK76W0W+OPMfXggHkGQA8WDdGTWOaMPTiCuJO+JOyDpBmSg
         DZviX3YW84bYt9WV9j2pJpgDSTvJIfSNDF8lUdVjvj99c083qYRC5a2N21I1y0JZZs
         FxwqSlKHVl8XZ7vqNcn9gZg9uAl+fN6EwMHm4iUV3XtsCEOMJqD9wn6J/AlT9dEOLb
         bMvedttQVHoYC7mcmPIeFo3Ofk+cHCgekZ3VSQGcSdpUEdD8+AJ6+dUGhzCSau+Vhs
         owlYrezZUOhoQ==
Date:   Fri, 2 Dec 2022 00:54:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH 1/3] arm64: Prohibit probing on arch_stack_walk()
Message-Id: <20221202005411.49ee4e946e6c790bf482dbd9@kernel.org>
In-Reply-To: <Y4i+hBAPyOIelFL1@FVFF77S0Q05N>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
        <166990554210.253128.7378208454827328942.stgit@devnote3>
        <Y4i+hBAPyOIelFL1@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022 14:47:32 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Hi Masami,
> 
> On Thu, Dec 01, 2022 at 11:39:02PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Make arch_stack_walk() as NOKPROBE_SYMBOL and make other inline functions
> > called from arch_stack_walk() as nokprobe_inline so that user does not
> > put probe on it, because this function can be used from return_address()
> > which is already NOKPROBE_SYMBOL.
> 
> I think it would make sense to make this noinstr rather than NOKPROBES, since
> it's also used in the bowels of ftrace, and any instrumentation is liable to
> lead to some mutual recursion.

Yeah, OK. So use noinstr instead of notrace.

> 
> > Without this, if the kernel built with CONFIG_LOCKDEP=y, just probing
> > arch_stack_walk() via <tracefs>/kprobe_events will crash the kernel on
> > arm64.
> > 
> >  # echo p arch_stack_walk >> ${TRACEFS}/kprobe_events
> >  # echo 1 > ${TRACEFS}/events/kprobes/enable
> >   kprobes: Failed to recover from reentered kprobes.
> >   kprobes: Dump kprobe:
> >   .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
> >   ------------[ cut here ]------------
> >   kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
> >   kprobes: Failed to recover from reentered kprobes.
> >   kprobes: Dump kprobe:
> >   .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
> >   ------------[ cut here ]------------
> >   kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
> >   PREEMPT SMP
> >   Modules linked in:
> >   CPU: 0 PID: 17 Comm: migration/0 Tainted: G                 N 6.1.0-rc5+ #6
> >   Hardware name: linux,dummy-virt (DT)
> >   Stopper: 0x0 <- 0x0
> >   pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   pc : kprobe_breakpoint_handler+0x178/0x17c
> >   lr : kprobe_breakpoint_handler+0x178/0x17c
> >   sp : ffff8000080d3090
> >   x29: ffff8000080d3090 x28: ffff0df5845798c0 x27: ffffc4f59057a774
> >   x26: ffff0df5ffbba770 x25: ffff0df58f420f18 x24: ffff49006f641000
> >   x23: ffffc4f590579768 x22: ffff0df58f420f18 x21: ffff8000080d31c0
> >   x20: ffffc4f590579768 x19: ffffc4f590579770 x18: 0000000000000006
> >   x17: 5f6b636174735f68 x16: 637261203d207264 x15: 64612e202c30203d
> >   x14: 2074657366666f2e x13: 30633178302f3078 x12: 302b6b6c61775f6b
> >   x11: 636174735f686372 x10: ffffc4f590dc5bd8 x9 : ffffc4f58eb31958
> >   x8 : 00000000ffffefff x7 : ffffc4f590dc5bd8 x6 : 80000000fffff000
> >   x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
> >   x2 : 0000000000000000 x1 : ffff0df5845798c0 x0 : 0000000000000064
> >   Call trace:
> >   kprobes: Failed to recover from reentered kprobes.
> >   kprobes: Dump kprobe:
> >   .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
> >   ------------[ cut here ]------------
> >   kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
> > 
> > Fixes: 39ef362d2d45 ("arm64: Make return_address() use arch_stack_walk()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/arm64/kernel/stacktrace.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 634279b3b03d..b0e913f944b4 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -23,7 +23,7 @@
> >   *
> >   * The regs must be on a stack currently owned by the calling task.
> >   */
> > -static inline void unwind_init_from_regs(struct unwind_state *state,
> > +static nokprobe_inline void unwind_init_from_regs(struct unwind_state *state,
> >  					 struct pt_regs *regs)
> >  {
> >  	unwind_init_common(state, current);
> > @@ -40,7 +40,7 @@ static inline void unwind_init_from_regs(struct unwind_state *state,
> >   *
> >   * The function which invokes this must be noinline.
> >   */
> > -static __always_inline void unwind_init_from_caller(struct unwind_state *state)
> > +static nokprobe_inline void unwind_init_from_caller(struct unwind_state *state)
> 
> This code must be __always_inline to get the correct caller context, so making
> this nokprobe_inline breaks a CONFIG_KPROBES=n build of the kernel.

Oops, indeed.

> 
> This also shouldn't be necessary; nokprobe_inline *is* __always_inline when
> CONFIG_KPROBES=y.
> 
> As above, I'd prefer that we mark these helpers as __always_inline and mark the
> main entry point as noinstr.

OK.

Thank you,

> 
> Thanks,
> Mark.
> 
> >  {
> >  	unwind_init_common(state, current);
> >  
> > @@ -58,7 +58,7 @@ static __always_inline void unwind_init_from_caller(struct unwind_state *state)
> >   * duration of the unwind, or the unwind will be bogus. It is never valid to
> >   * call this for the current task.
> >   */
> > -static inline void unwind_init_from_task(struct unwind_state *state,
> > +static nokprobe_inline void unwind_init_from_task(struct unwind_state *state,
> >  					 struct task_struct *task)
> >  {
> >  	unwind_init_common(state, task);
> > @@ -218,3 +218,4 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
> >  
> >  	unwind(&state, consume_entry, cookie);
> >  }
> > +NOKPROBE_SYMBOL(arch_stack_walk);
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
