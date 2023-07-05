Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F108748021
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjGEIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjGEIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:52:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AAD1716;
        Wed,  5 Jul 2023 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Mcsjo0emh8tYgWsppImcB9AHweArJWJl12Gf8jRhOQ=; b=dJ/Bq9Uh77rfHDu62fLZHMUrCA
        M3C0hYNpC/NN3is+jkmvZj/by5bpQZlK64GLIxB01SFAPwtVP40eW7Sn35TNOPfblXvXyLFA93bx+
        DU8A3V8qvvFG3cZhXxwtdy6Y3MZoV2yZgNjsgXnVtkPqmxrjPgtZfOZ4tUZr5Dxk7NM2kEgzpRpsN
        9pk4idSySMBmRkfjCVDCtcFyiRgyQQovn7UFyY/sPke1QXJ44cNlcEUohLs8hQMqJiK/9fXunTsEC
        OwmxlSaLp1n6Zm47uSizPclqI364QK9CXLtn/jg1qP/pU9Fb5Pi7UBs2y+qct2a8wFmJ+DJyFgX7d
        7TycpfPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGyFL-00C2sy-1I;
        Wed, 05 Jul 2023 08:52:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66CA83001E7;
        Wed,  5 Jul 2023 10:52:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B3562028F056; Wed,  5 Jul 2023 10:52:22 +0200 (CEST)
Date:   Wed, 5 Jul 2023 10:52:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mhiramat@kernel.org,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/retpoline,kprobes: Fix position of thunk
 sections with CONFIG_LTO_CLANG
Message-ID: <20230705085222.GF462772@hirez.programming.kicks-ass.net>
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-2-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705081547.25130-2-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:15:46AM +0200, Petr Pavlu wrote:
> Linker script arch/x86/kernel/vmlinux.lds.S matches the thunk sections
> ".text.__x86.*" from arch/x86/lib/retpoline.S as follows:
> 
> .text {
>   [...]
>   TEXT_TEXT
>   [...]
>   __indirect_thunk_start = .;
>   *(.text.__x86.*)
>   __indirect_thunk_end = .;
>   [...]
> }
> 
> Macro TEXT_TEXT references TEXT_MAIN which normally expands to only
> ".text". However, with CONFIG_LTO_CLANG, TEXT_MAIN becomes
> ".text .text.[0-9a-zA-Z_]*" which wrongly matches also the thunk
> sections. The range [__indirect_thunk_start, __indirect_thunk_end] is
> then empty.
> 
> A visible result is that function insn_is_indirect_jump() misbehaves and
> optprobes become allowed in functions where they are not potentially
> safe.
> 
> Fix the problem by using ".." as the first separator, for instance,
> ".text..__x86.indirect_thunk". This pattern is utilized by other

First I hear of this, but yes, indeed.

> explicit section names which start with one of the standard prefixes,
> such as ".text" or ".data", and that need to be individually selected in
> the linker script.
> 
> Fixes: dc5723b02e52 ("kbuild: add support for Clang LTO")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/kernel/vmlinux.lds.S | 2 +-
>  arch/x86/lib/retpoline.S      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 03c885d3640f..a4cd04c458df 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -134,7 +134,7 @@ SECTIONS
>  		SOFTIRQENTRY_TEXT
>  #ifdef CONFIG_RETPOLINE
>  		__indirect_thunk_start = .;
> -		*(.text.__x86.*)
> +		*(.text..__x86.*)
>  		__indirect_thunk_end = .;
>  #endif
>  		STATIC_CALL_TEXT
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 3fd066d42ec0..3bea96341d00 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -12,7 +12,7 @@
>  #include <asm/percpu.h>
>  #include <asm/frame.h>
>  
> -	.section .text.__x86.indirect_thunk
> +	.section .text..__x86.indirect_thunk
>  
>  
>  .macro POLINE reg
> @@ -131,7 +131,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
>   */
>  #ifdef CONFIG_RETHUNK
>  
> -	.section .text.__x86.return_thunk
> +	.section .text..__x86.return_thunk
>  
>  /*
>   * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
> -- 
> 2.35.3
> 
