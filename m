Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21756EF5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbjDZNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbjDZNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:43:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB9F84EC8;
        Wed, 26 Apr 2023 06:43:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E72F4B3;
        Wed, 26 Apr 2023 06:44:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D910C3F64C;
        Wed, 26 Apr 2023 06:43:22 -0700 (PDT)
Date:   Wed, 26 Apr 2023 14:43:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: Re: [PATCH 3/5] LoongArch: ftrace: Add direct call support
Message-ID: <ZEkqdfNk4YKVvxxM@FVFF77S0Q05N>
References: <1682473754-25077-1-git-send-email-tangyouling@loongson.cn>
 <1682473754-25077-4-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682473754-25077-4-git-send-email-tangyouling@loongson.cn>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 26, 2023 at 09:49:12AM +0800, Youling Tang wrote:
> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> register_ftrace_direct[_multi] interfaces allowing users to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modifying direct_caller.
> 
> There are a few cases to distinguish:
> - If a direct call ops is the only one tracing a function:
>   - If the direct called trampoline is within the reach of a 'bl'
>     instruction
>      -> the ftrace patchsite jumps to the trampoline
>   - Else
>      -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline
> 	which reads the ops pointer in the patchsite and jumps to the
>  	direct call address stored in the ops

I think you forgot to update this wording; there's no ops pointer in the
patchsite as you don't implement DYNAMIC_FTRACE_WITH_CALL_OPS.

I think you can delete the "Else" case here, and replace the above with:

- If a direct call ops is the only one tracing a function AND the direct called
  trampoline is within the reach of a 'bl' instruction
  -> the ftrace patchsite jumps to the trampoline 

> - Else
>   -> the ftrace patchsite jumps to the ftrace_regs_caller trampoline and
>      its ops literal points to ftrace_list_ops so it iterates over all
>      registered ftrace ops, including the direct call ops and calls its
>      call_direct_funcs handler which stores the direct called trampoline's
>      address in the ftrace_regs and the ftrace_regs_caller trampoline will

Likewise here, there's no "ops literal" associated with the patchsite.

Otherwise, this looks sane to me.

Mark.

>      return to that address instead of returning to the traced function
> 
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/include/asm/ftrace.h | 12 ++++++++++++
>  arch/loongarch/kernel/ftrace_dyn.c  |  8 ++++++++
>  arch/loongarch/kernel/mcount_dyn.S  |  7 ++++++-
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 3ddde336e6a5..d6068a88d53f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -92,6 +92,7 @@ config LOONGARCH
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EBPF_JIT
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 3418d32d4fc7..f789e680f633 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -57,6 +57,18 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>  #define ftrace_graph_func ftrace_graph_func
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs);
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +static inline void
> +__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
> +{
> +	regs->regs[13] = addr;	/* t1 */
> +}
> +
> +#define arch_ftrace_set_direct_caller(fregs, addr) \
> +	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
> +#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> +
>  #endif
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index 3cc4f8159f48..4062a7e63137 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -66,6 +66,14 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec, struct module *mod
>  	unsigned long pc = rec->ip + LOONGARCH_INSN_SIZE;
>  	struct plt_entry *plt;
>  
> +	/*
> +	 * If a custom trampoline is unreachable, rely on the ftrace_regs_caller
> +	 * trampoline which knows how to indirectly reach that trampoline
> +	 * through ops->direct_call.
> +	 */
> +	if (*addr != FTRACE_ADDR && *addr != FTRACE_REGS_ADDR && !reachable_by_bl(*addr, pc))
> +		*addr = FTRACE_REGS_ADDR;
> +
>  	/*
>  	 * When the target is within range of the 'bl' instruction, use 'addr'
>  	 * as-is and branch to that directly.
> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
> index bbabf06244c2..1008fbc3cabc 100644
> --- a/arch/loongarch/kernel/mcount_dyn.S
> +++ b/arch/loongarch/kernel/mcount_dyn.S
> @@ -42,7 +42,6 @@
>  	.if \allregs
>  	PTR_S		tp, sp, PT_R2
>  	PTR_S		t0, sp, PT_R12
> -	PTR_S		t1, sp, PT_R13
>  	PTR_S		t2, sp, PT_R14
>  	PTR_S		t3, sp, PT_R15
>  	PTR_S		t4, sp, PT_R16
> @@ -64,6 +63,8 @@
>  	PTR_S		zero, sp, PT_R0
>  	.endif
>  	PTR_S		ra, sp, PT_ERA /* Save trace function ra at PT_ERA */
> +	move		t1, zero
> +	PTR_S		t1, sp, PT_R13
>  	PTR_ADDI	t8, sp, PT_SIZE
>  	PTR_S		t8, sp, PT_R3
>  	.endm
> @@ -104,8 +105,12 @@ ftrace_common_return:
>  	PTR_L		a7, sp, PT_R11
>  	PTR_L		fp, sp, PT_R22
>  	PTR_L		t0, sp, PT_ERA
> +	PTR_L		t1, sp, PT_R13
>  	PTR_ADDI	sp, sp, PT_SIZE
> +	bnez		t1,.Ldirect
>  	jr		t0
> +.Ldirect:
> +	jr		t1
>  SYM_CODE_END(ftrace_common)
>  
>  SYM_CODE_START(ftrace_caller)
> -- 
> 2.37.1
> 
