Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD274EF08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjGKMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGKMe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCAACA;
        Tue, 11 Jul 2023 05:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D22614A9;
        Tue, 11 Jul 2023 12:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BC2C433CA;
        Tue, 11 Jul 2023 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689078795;
        bh=2vpsagT5QZlKLfr/o2MZb4cm1xSo9BdkzIOfDP4qeZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fDQfSplUiEqlt9e5907LmttL8tvQApwUo/bzKw8FwsB6iini3lg9+vAXEWNjpC87h
         4sn0nt2FCoBMfzh6JQdN6NAxYq2uaF8wj9WhBqHaPaJgERChvPhLO0sx6l7rVK77lf
         z/zzieLlE/08MsozOBCrwQ7/AhA2pujq5415f0Twjl3IQ6BbViXlSeGE/cy2hkXxXt
         2iEothuaUIuDFbBySyHTJjJlc1evlOQ6zilcfq9HaL4QwFqJePXjxKSOonx/NViltQ
         L/I/Mu0PMZHxlah6WWUGCEwdW/ft3QmZPY6yNJ6HLp0z0z5+Yb8wTm5F6kV8OVbM4v
         PJ2mkP6TCHzPw==
Date:   Tue, 11 Jul 2023 21:33:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/retpoline,kprobes: Skip optprobe check for
 indirect jumps with retpolines and IBT
Message-Id: <20230711213311.03b02a936aefbcf5f06b6c3b@kernel.org>
In-Reply-To: <20230711091952.27944-3-petr.pavlu@suse.com>
References: <20230711091952.27944-1-petr.pavlu@suse.com>
        <20230711091952.27944-3-petr.pavlu@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 11:19:52 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> The kprobes optimization check can_optimize() calls
> insn_is_indirect_jump() to detect indirect jump instructions in
> a target function. If any is found, creating an optprobe is disallowed
> in the function because the jump could be from a jump table and could
> potentially land in the middle of the target optprobe.
> 
> With retpolines, insn_is_indirect_jump() additionally looks for calls to
> indirect thunks which the compiler potentially used to replace original
> jumps. This extra check is however unnecessary because jump tables are
> disabled when the kernel is built with retpolines. The same is currently
> the case with IBT.
> 
> Based on this observation, remove the logic to look for calls to
> indirect thunks and skip the check for indirect jumps altogether if the
> kernel is built with retpolines or IBT. Remove subsequently the symbols
> __indirect_thunk_start and __indirect_thunk_end which are no longer
> needed.
> 
> Dropping this logic indirectly fixes a problem where the range
> [__indirect_thunk_start, __indirect_thunk_end] wrongly included also the
> return thunk. It caused that machines which used the return thunk as
> a mitigation and didn't have it patched by any alternative ended up not
> being able to use optprobes in any regular function.

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> 
> Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  arch/x86/include/asm/nospec-branch.h |  3 ---
>  arch/x86/kernel/kprobes/opt.c        | 40 +++++++++++-----------------
>  arch/x86/kernel/vmlinux.lds.S        |  2 --
>  tools/perf/util/thread-stack.c       |  4 +--
>  4 files changed, 17 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 55388c9f7601..c5460be93fa7 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -461,9 +461,6 @@ enum ssb_mitigation {
>  	SPEC_STORE_BYPASS_SECCOMP,
>  };
>  
> -extern char __indirect_thunk_start[];
> -extern char __indirect_thunk_end[];
> -
>  static __always_inline
>  void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
>  {
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 57b0037d0a99..517821b48391 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -226,7 +226,7 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
>  }
>  
>  /* Check whether insn is indirect jump */
> -static int __insn_is_indirect_jump(struct insn *insn)
> +static int insn_is_indirect_jump(struct insn *insn)
>  {
>  	return ((insn->opcode.bytes[0] == 0xff &&
>  		(X86_MODRM_REG(insn->modrm.value) & 6) == 4) || /* Jump */
> @@ -260,26 +260,6 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
>  	return (start <= target && target <= start + len);
>  }
>  
> -static int insn_is_indirect_jump(struct insn *insn)
> -{
> -	int ret = __insn_is_indirect_jump(insn);
> -
> -#ifdef CONFIG_RETPOLINE
> -	/*
> -	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
> -	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
> -	 * older gcc may use indirect jump. So we add this check instead of
> -	 * replace indirect-jump check.
> -	 */
> -	if (!ret)
> -		ret = insn_jump_into_range(insn,
> -				(unsigned long)__indirect_thunk_start,
> -				(unsigned long)__indirect_thunk_end -
> -				(unsigned long)__indirect_thunk_start);
> -#endif
> -	return ret;
> -}
> -
>  /* Decode whole function to ensure any instructions don't jump into target */
>  static int can_optimize(unsigned long paddr)
>  {
> @@ -334,9 +314,21 @@ static int can_optimize(unsigned long paddr)
>  		/* Recover address */
>  		insn.kaddr = (void *)addr;
>  		insn.next_byte = (void *)(addr + insn.length);
> -		/* Check any instructions don't jump into target */
> -		if (insn_is_indirect_jump(&insn) ||
> -		    insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
> +		/*
> +		 * Check any instructions don't jump into target, indirectly or
> +		 * directly.
> +		 *
> +		 * The indirect case is present to handle a code with jump
> +		 * tables. When the kernel uses retpolines, the check should in
> +		 * theory additionally look for jumps to indirect thunks.
> +		 * However, the kernel built with retpolines or IBT has jump
> +		 * tables disabled so the check can be skipped altogether.
> +		 */
> +		if (!IS_ENABLED(CONFIG_RETPOLINE) &&
> +		    !IS_ENABLED(CONFIG_X86_KERNEL_IBT) &&
> +		    insn_is_indirect_jump(&insn))
> +			return 0;
> +		if (insn_jump_into_range(&insn, paddr + INT3_INSN_SIZE,
>  					 DISP32_SIZE))
>  			return 0;
>  		addr += insn.length;
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index a4cd04c458df..dd5b0a68cf84 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -133,9 +133,7 @@ SECTIONS
>  		KPROBES_TEXT
>  		SOFTIRQENTRY_TEXT
>  #ifdef CONFIG_RETPOLINE
> -		__indirect_thunk_start = .;
>  		*(.text..__x86.*)
> -		__indirect_thunk_end = .;
>  #endif
>  		STATIC_CALL_TEXT
>  
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 374d142e7390..c6a0a27b12c2 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -1038,9 +1038,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
>  
>  static bool is_x86_retpoline(const char *name)
>  {
> -	const char *p = strstr(name, "__x86_indirect_thunk_");
> -
> -	return p == name || !strcmp(name, "__indirect_thunk_start");
> +	return strstr(name, "__x86_indirect_thunk_") == name;
>  }
>  
>  /*
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
