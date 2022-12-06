Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FE643A62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiLFAmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiLFAlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:41:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80886DFD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:41:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0BED614F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D46C433D7;
        Tue,  6 Dec 2022 00:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670287300;
        bh=PHYevn3Vh1bRzHgX8jaY2KGyymMFzZcEuYmLigdgpFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HREFEuzQkgTBk6bZMKgFTiB8CEqWJP4JL8snfVoRvIFSkAZ+1NqBLredgeO8ut1cI
         BOCHfhAqHxu+dA2bgYxP72JxkG+Gy/Sb6KaWcp3aGAOaIyiFMGTIitp2hUrt2OkapU
         UjjZ/H0gJGeA1B5qfjLOwgoLEHrUJ9rGV8e4GsBICCkZLUqsLbhGscY9VEN+qfj3uR
         jcOUGDFq3BRpWgEw3W6ccjdbsGFr9S8LQVsrLgFc0+etQ/hbpIelyT4Mf4ZxXMLSvC
         M7DFFBwFk0gz9Zjfm9ZLS0b5J3tleD6OzTi2zgEMy56r7dlgWBo1NP5HB5ECKb3ABq
         DYs50wj3+Gm9A==
Date:   Tue, 6 Dec 2022 09:41:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: Prohibit instrumentation on
 arch_stack_walk()
Message-Id: <20221206094137.389e4c374f4be060af19f33a@kernel.org>
In-Reply-To: <Y4n66ioPq0BZF4Pi@FVFF77S0Q05N>
References: <166994750386.439920.1754385804350980158.stgit@devnote3>
        <166994751368.439920.3236636557520824664.stgit@devnote3>
        <Y4n66ioPq0BZF4Pi@FVFF77S0Q05N>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 13:17:30 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Dec 02, 2022 at 11:18:33AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Mark arch_stack_walk() as noinstr instead of notrace and inline functions
> > called from arch_stack_walk() as __always_inline so that user does not
> > put any instrumentations on it, because this function can be used from
> > return_address() which is used by lockdep.
> 
> Hmmm... since arch_stack_walk is marked as notrace, that will be prohibited by
> default unless the kernel was built with CONFIG_KPROBE_EVENTS_ON_NOTRACE=y,
> and the commit message for that says:
> 
> │ This option disables such protection and allows you to put kprobe                                                                                                                                   │
> │ events on ftrace functions for debugging ftrace by itself.                                                                                                                                          │
> │ Note that this might let you shoot yourself in the foot.
> 
> ... and IIUC we generally don't expect people to set that, and that might be
> worth calling out in the commit message.

Yeah, but that is the feature for kprobe events, and not applied to
the kprobes itself. Maybe I should use a test kprobe module to
put a probe on it.

> 
> > Without this, if the kernel built with CONFIG_LOCKDEP=y, just probing
> > arch_stack_walk() via <tracefs>/kprobe_events will crash the kernel on
> > arm64.
> > 
> >  # echo p arch_stack_walk >> ${TRACEFS}/kprobe_events
> >  # echo 1 > ${TRACEFS}/events/kprobes/enable
> 
> I had a go at testing this patch, and it fixes the crash with the reproducer
> above, but there are plenty of other instances in stacktrace.c that lead to the
> same sort of crash, e.g.
> 
> # echo p stackinfo_get_task >> ${TRACEFS}/kprobe_events
> # echo 1 > ${TRACEFS}/events/kprobes/enable

Oops, thanks for pointing! Hmm, I thought stackinfo_get_task() is an
inlined function usually. Maybe we should make it nokprobe_inline.
But this is just one case. I need to scan all symbols to trace...

> 
> ... so I think there's more that we need to do to fix this generally.
> 
> Note: I found interesting functions to try tracing by looking at the output of:
> 
>   aarch64-linux-objdump -t arch/arm64/kernel/stacktrace.o | grep -w '.text'
> 
> That all said, I think this patch is nice-to-have, and that we can address the
> other cases as a follow-up, so for this patch as-is (with or without some
> wording regarding CONFIG_KPROBE_EVENTS_ON_NOTRACE):
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

> 
> Mark.
> 
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
> >  Changes in v2:
> >   - Use noinstr instead of NOKPROBE_SYMBOL()
> >   - Use __always_inline because nokprobe_inline will be changed if
> >     CONFIG_KPROBES=n.
> >   - Fix indentation.
> > ---
> >  arch/arm64/kernel/stacktrace.c |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 634279b3b03d..117e2c180f3c 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -23,8 +23,8 @@
> >   *
> >   * The regs must be on a stack currently owned by the calling task.
> >   */
> > -static inline void unwind_init_from_regs(struct unwind_state *state,
> > -					 struct pt_regs *regs)
> > +static __always_inline void unwind_init_from_regs(struct unwind_state *state,
> > +						  struct pt_regs *regs)
> >  {
> >  	unwind_init_common(state, current);
> >  
> > @@ -58,8 +58,8 @@ static __always_inline void unwind_init_from_caller(struct unwind_state *state)
> >   * duration of the unwind, or the unwind will be bogus. It is never valid to
> >   * call this for the current task.
> >   */
> > -static inline void unwind_init_from_task(struct unwind_state *state,
> > -					 struct task_struct *task)
> > +static __always_inline void unwind_init_from_task(struct unwind_state *state,
> > +						  struct task_struct *task)
> >  {
> >  	unwind_init_common(state, task);
> >  
> > @@ -186,7 +186,7 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
> >  			: stackinfo_get_unknown();		\
> >  	})
> >  
> > -noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
> > +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry,
> >  			      void *cookie, struct task_struct *task,
> >  			      struct pt_regs *regs)
> >  {
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
