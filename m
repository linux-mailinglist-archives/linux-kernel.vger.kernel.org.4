Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68F74868B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGEOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGEOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30607CE;
        Wed,  5 Jul 2023 07:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A08615CB;
        Wed,  5 Jul 2023 14:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5379EC433C8;
        Wed,  5 Jul 2023 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688568038;
        bh=8lOxVmG05F0ecJWHeVz8zcLl0eVMk/+f7NxbVDTmM5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUvE4++pU/R3wqyF2xYjVo21LAIkMLfnSeYF3fzPIqd9pQo1PnN6+mgRy9U39+dWh
         c0NLq3ey/HlAB/j6u1cqiBFE8i2LyGrg2agO8Wq0HA9e5Fxq+kcnw1r9xbBmHa3xWV
         TbBrmIncTK6ZtVYNoz4n10xWVrtnl/vJ8acDDhzTaNAdIoQ7ur1HIVKRy/V3mlNWDg
         k/x8W/mmF7P71l1ssy9Ke+Edzn8U/R3zCOZCY+RG7qyphxzPsERdiS8N3BjvuqGZwm
         IbWWypy7rLDS6mAi1w93mZw9LW4iuxNzXYNx4OYdWSay+nytXhq5ARXmYsIW4JyUeT
         iizD+X2Znk4/w==
Date:   Wed, 5 Jul 2023 23:40:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Message-Id: <20230705234032.eb0758a3c3fa412169862fab@kernel.org>
In-Reply-To: <20230705081547.25130-3-petr.pavlu@suse.com>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
        <20230705081547.25130-3-petr.pavlu@suse.com>
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

On Wed,  5 Jul 2023 10:15:47 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Functions can_optimize() and insn_is_indirect_jump() consider jumps to
> the range [__indirect_thunk_start, __indirect_thunk_end] as indirect
> jumps and prevent use of optprobes in functions containing them.
> 
> Linker script arch/x86/kernel/vmlinux.lds.S places into this range also
> the special section .text.__x86.return_thunk which contains the return
> thunk. It causes that machines which use the return thunk as
> a mitigation and don't have it patched by any alternative then end up
> not being able to use optprobes in any regular function.

Ah, I got it. So with retpoline, the 'ret' instruction is replaced by
'jmp __x86_return_thunk' and the "__x86_return_thunk" is also listed in
the __indirect_thunk_start/end.
Good catch!

And I think Peter's suggestion is simpler and easier to understand.
Can you update this?

Thank you,

> 
> The return thunk doesn't need to be treated as an indirect jump from the
> perspective of insn_is_indirect_jump(). It returns to a caller and
> cannot land into an optprobe jump operand which is the purpose of the
> insn_is_indirect_jump() check.
> 
> Fix the problem by defining the symbols __indirect_thunk_start and
> __indirect_thunk_end directly in arch/x86/lib/retpoline.S. This is
> possible because commit 9bc0bb50727c ("objtool/x86: Rewrite retpoline
> thunk calls") made all indirect thunks present in a single section.
>
> Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 2 --
>  arch/x86/lib/retpoline.S      | 4 ++++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
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
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 3bea96341d00..f45a3e7f776f 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -14,6 +14,7 @@
>  
>  	.section .text..__x86.indirect_thunk
>  
> +SYM_ENTRY(__indirect_thunk_start, SYM_L_GLOBAL, SYM_A_NONE)
>  
>  .macro POLINE reg
>  	ANNOTATE_INTRA_FUNCTION_CALL
> @@ -125,6 +126,9 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
>  #include <asm/GEN-for-each-reg.h>
>  #undef GEN
>  #endif
> +
> +SYM_ENTRY(__indirect_thunk_end, SYM_L_GLOBAL, SYM_A_NONE)
> +
>  /*
>   * This function name is magical and is used by -mfunction-return=thunk-extern
>   * for the compiler to generate JMPs to it.
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
