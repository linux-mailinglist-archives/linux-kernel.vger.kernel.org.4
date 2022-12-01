Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A524263F317
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiLAOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLAOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:47:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AE56E5C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:47:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FDCBD6E;
        Thu,  1 Dec 2022 06:47:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.38.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77B03F67D;
        Thu,  1 Dec 2022 06:47:36 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:47:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
Subject: Re: [PATCH 1/3] arm64: Prohibit probing on arch_stack_walk()
Message-ID: <Y4i+hBAPyOIelFL1@FVFF77S0Q05N>
References: <166990553243.253128.13594802750635478633.stgit@devnote3>
 <166990554210.253128.7378208454827328942.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166990554210.253128.7378208454827328942.stgit@devnote3>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, Dec 01, 2022 at 11:39:02PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Make arch_stack_walk() as NOKPROBE_SYMBOL and make other inline functions
> called from arch_stack_walk() as nokprobe_inline so that user does not
> put probe on it, because this function can be used from return_address()
> which is already NOKPROBE_SYMBOL.

I think it would make sense to make this noinstr rather than NOKPROBES, since
it's also used in the bowels of ftrace, and any instrumentation is liable to
lead to some mutual recursion.

> Without this, if the kernel built with CONFIG_LOCKDEP=y, just probing
> arch_stack_walk() via <tracefs>/kprobe_events will crash the kernel on
> arm64.
> 
>  # echo p arch_stack_walk >> ${TRACEFS}/kprobe_events
>  # echo 1 > ${TRACEFS}/events/kprobes/enable
>   kprobes: Failed to recover from reentered kprobes.
>   kprobes: Dump kprobe:
>   .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
>   ------------[ cut here ]------------
>   kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
>   kprobes: Failed to recover from reentered kprobes.
>   kprobes: Dump kprobe:
>   .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
>   ------------[ cut here ]------------
>   kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
>   PREEMPT SMP
>   Modules linked in:
>   CPU: 0 PID: 17 Comm: migration/0 Tainted: G                 N 6.1.0-rc5+ #6
>   Hardware name: linux,dummy-virt (DT)
>   Stopper: 0x0 <- 0x0
>   pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : kprobe_breakpoint_handler+0x178/0x17c
>   lr : kprobe_breakpoint_handler+0x178/0x17c
>   sp : ffff8000080d3090
>   x29: ffff8000080d3090 x28: ffff0df5845798c0 x27: ffffc4f59057a774
>   x26: ffff0df5ffbba770 x25: ffff0df58f420f18 x24: ffff49006f641000
>   x23: ffffc4f590579768 x22: ffff0df58f420f18 x21: ffff8000080d31c0
>   x20: ffffc4f590579768 x19: ffffc4f590579770 x18: 0000000000000006
>   x17: 5f6b636174735f68 x16: 637261203d207264 x15: 64612e202c30203d
>   x14: 2074657366666f2e x13: 30633178302f3078 x12: 302b6b6c61775f6b
>   x11: 636174735f686372 x10: ffffc4f590dc5bd8 x9 : ffffc4f58eb31958
>   x8 : 00000000ffffefff x7 : ffffc4f590dc5bd8 x6 : 80000000fffff000
>   x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
>   x2 : 0000000000000000 x1 : ffff0df5845798c0 x0 : 0000000000000064
>   Call trace:
>   kprobes: Failed to recover from reentered kprobes.
>   kprobes: Dump kprobe:
>   .symbol_name = arch_stack_walk, .offset = 0, .addr = arch_stack_walk+0x0/0x1c0
>   ------------[ cut here ]------------
>   kernel BUG at arch/arm64/kernel/probes/kprobes.c:241!
> 
> Fixes: 39ef362d2d45 ("arm64: Make return_address() use arch_stack_walk()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arm64/kernel/stacktrace.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index 634279b3b03d..b0e913f944b4 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -23,7 +23,7 @@
>   *
>   * The regs must be on a stack currently owned by the calling task.
>   */
> -static inline void unwind_init_from_regs(struct unwind_state *state,
> +static nokprobe_inline void unwind_init_from_regs(struct unwind_state *state,
>  					 struct pt_regs *regs)
>  {
>  	unwind_init_common(state, current);
> @@ -40,7 +40,7 @@ static inline void unwind_init_from_regs(struct unwind_state *state,
>   *
>   * The function which invokes this must be noinline.
>   */
> -static __always_inline void unwind_init_from_caller(struct unwind_state *state)
> +static nokprobe_inline void unwind_init_from_caller(struct unwind_state *state)

This code must be __always_inline to get the correct caller context, so making
this nokprobe_inline breaks a CONFIG_KPROBES=n build of the kernel.

This also shouldn't be necessary; nokprobe_inline *is* __always_inline when
CONFIG_KPROBES=y.

As above, I'd prefer that we mark these helpers as __always_inline and mark the
main entry point as noinstr.

Thanks,
Mark.

>  {
>  	unwind_init_common(state, current);
>  
> @@ -58,7 +58,7 @@ static __always_inline void unwind_init_from_caller(struct unwind_state *state)
>   * duration of the unwind, or the unwind will be bogus. It is never valid to
>   * call this for the current task.
>   */
> -static inline void unwind_init_from_task(struct unwind_state *state,
> +static nokprobe_inline void unwind_init_from_task(struct unwind_state *state,
>  					 struct task_struct *task)
>  {
>  	unwind_init_common(state, task);
> @@ -218,3 +218,4 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  
>  	unwind(&state, consume_entry, cookie);
>  }
> +NOKPROBE_SYMBOL(arch_stack_walk);
> 
