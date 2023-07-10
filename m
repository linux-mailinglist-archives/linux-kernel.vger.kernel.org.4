Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7407B74E25B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGJX6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGJX6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EC81A8;
        Mon, 10 Jul 2023 16:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCA261142;
        Mon, 10 Jul 2023 23:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3260EC433C8;
        Mon, 10 Jul 2023 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689033521;
        bh=irRYoyD2g2+00LlYqM5wE8Ub9YnQWH+M3sbXLQm91hQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJeSt6n1RSXZToMdezxkj1NDAFYtgzm1PY9cyhRtCtnDfAxX9bXFZff+zJh1uE8q6
         g+T9MinEvdr8yF8VL/mEt+cr8kl78oTd421IHbzPl/F5EhGLZ93zeevjXVvA+BivPO
         7m9r6uhGad09LL5csHd/xClQoxeZWbdOot4vNNRdblQYJGIa+qE9cFAwvpYMWfMZO8
         SDEUgwFVKdyvvHwBcCIyS1qxM/UbvYRwZArJxwJ2B+p4KNU3cfmIBM4pI/9fHgKvh5
         mLcW1Q9oYzV+99ylZbvJkVdSohyGxlPcaJeBxc+8/A55a7SB3meXKNleUoc8AtlnUn
         4ecxOx+AdiWWQ==
Date:   Tue, 11 Jul 2023 08:58:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] x86/kprobes: Prohibit probing on compiler
 generated CFI checking code
Message-Id: <20230711085837.fac80c964ea7667cb75bd6e5@kernel.org>
In-Reply-To: <20230710161643.GB3040258@hirez.programming.kicks-ass.net>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
        <168899127520.80889.15418363018799407058.stgit@devnote2>
        <20230710161643.GB3040258@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 18:16:43 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 10, 2023 at 09:14:35PM +0900, Masami Hiramatsu (Google) wrote:
> > +	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
> > +		/*
> > +		 * The compiler generates the following instruction sequence
> > +		 * for indirect call checks and cfi.c decodes this;
> > +		 *
> > +		 *   movl    -<id>, %r10d       ; 6 bytes
> > +		 *   addl    -4(%reg), %r10d    ; 4 bytes
> > +		 *   je      .Ltmp1             ; 2 bytes
> > +		 *   ud2                        ; <- regs->ip
> > +		 *   .Ltmp1:
> > +		 *
> > +		 * Also, these movl and addl are used for showing expected
> > +		 * type. So those must not be touched.
> > +		 */
> > +		__addr = recover_probed_instruction(buf, addr);
> > +		if (!__addr)
> > +			return 0;
> > +
> > +		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
> > +			return 0;
> > +
> > +		if (insn.opcode.value == 0xBA)
> > +			offset = 12;
> > +		else if (insn.opcode.value == 0x3)
> > +			offset = 6;
> > +		else
> > +			goto out;
> 
> Notably, the JE will already be avoided?
> 
> > +
> > +		/* This movl/addl is used for decoding CFI. */
> > +		if (is_cfi_trap(addr + offset))
> > +			return 0;
> > +	}
> >  
> > +out:
> >  	return (addr == paddr);
> >  }
> 
> Hmm, so I was thinking something like the below, which also catches
> things when we rewrite kCFI to FineIBT, except I don't think we care if
> the FineIBT callsite gets re-written. FineIBT only relies on the __cfi_
> symbol not getting poked at (which the previous patches should ensure).

Oh, is FineIBT different from kCFI? I thought those are same. But anyway
for kCFI=y && FineIBT=n case, I think this code still needed.

> 
> Additionally is_cfi_trap() is horrifically slow -- it's a full linear
> search of the entire kcfi_traps array, it doesn't have any smarts on
> (#UD can hardly be considered a fast path).

Yeah, register_kprobe() is not a fast path in most cases. So I think
this is OK at this point. We can speed it up by sorting the array by
address and binary search later.

> 
> So I tihnk I'm ok with the above, just adding the below for reference
> (completely untested and everything).

I wonder the distance can be used outside of x86. CFI implementation
depends on the arch?

> 
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks!

> 
> 
> ---
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index f7f6042eb7e6..b812dee76909 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -293,6 +293,11 @@ static int can_probe(unsigned long paddr)
>  #endif
>  		addr += insn.length;
>  	}
> +	/*
> +	 * Don't allow poking the kCFI/FineIBT callsites.
> +	 */
> +	if (IS_ENABLED(CONFIG_CFI_CLANG) && cfi_call_site(addr))
> +		return 0;
>  
>  	return (addr == paddr);
>  }
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 08caad776717..2656e6ffa013 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -31,16 +31,22 @@ static inline unsigned long trap_address(s32 *p)
>  	return (unsigned long)((long)p + (long)*p);
>  }
>  
> -static bool is_trap(unsigned long addr, s32 *start, s32 *end)
> +static long cfi_trap_distance(unsigned long addr, s32 *start, s32 *end)
>  {
> +	long dist = LONG_MAX;
>  	s32 *p;
>  
>  	for (p = start; p < end; ++p) {
> -		if (trap_address(p) == addr)
> -			return true;
> +		long d = trap_address(p) - addr;
> +
> +		if (abs(dist) < abs(d)) {
> +			dist = d;
> +			if (dist == 0)
> +				return 0;
> +		}
>  	}
>  
> -	return false;
> +	return dist;
>  }
>  
>  #ifdef CONFIG_MODULES
> @@ -66,25 +72,25 @@ void module_cfi_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
>  	}
>  }
>  
> -static bool is_module_cfi_trap(unsigned long addr)
> +static long module_cfi_trap_distance(unsigned long addr)
>  {
>  	struct module *mod;
> -	bool found = false;
> +	long dist = LONG_MAX;
>  
>  	rcu_read_lock_sched_notrace();
>  
>  	mod = __module_address(addr);
>  	if (mod)
> -		found = is_trap(addr, mod->kcfi_traps, mod->kcfi_traps_end);
> +		dist = cfi_trap_distance(addr, mod->kcfi_traps, mod->kcfi_traps_end);
>  
>  	rcu_read_unlock_sched_notrace();
>  
>  	return found;
>  }
>  #else /* CONFIG_MODULES */
> -static inline bool is_module_cfi_trap(unsigned long addr)
> +static long module_cfi_trap_distance(unsigned long addr)
>  {
> -	return false;
> +	return LONG_MAX;
>  }
>  #endif /* CONFIG_MODULES */
>  
> @@ -93,9 +99,24 @@ extern s32 __stop___kcfi_traps[];
>  
>  bool is_cfi_trap(unsigned long addr)
>  {
> -	if (is_trap(addr, __start___kcfi_traps, __stop___kcfi_traps))
> +	long dist = cfi_trap_distance(addr, __start___kcfi_traps, __stop___kcfi_traps);
> +	if (!dist)
> +		return true;
> +
> +	return module_cfi_trap_distance(addr) == 0;
> +}
> +
> +bool cfi_call_site(unsigned long addr)
> +{
> +	long dist = cfi_trap_distance(addr, __start___kcfi_traps, __stop___kcfi_traps);
> +	if (dist >= -12 && dist <= 0)
> +		return true;
> +
> +	dist = module_cfi_trap_distance(addr);
> +	if (dist >= -12 && dist <= 0)
>  		return true;
>  
> -	return is_module_cfi_trap(addr);
> +	return false;
>  }
> +
>  #endif /* CONFIG_ARCH_USES_CFI_TRAPS */


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
