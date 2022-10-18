Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781346031FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJRSJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:09:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE15EDC3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:09:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so16769152pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMuB6JFVOyqdER293NidtAVyJ00hndHqLd79moXaHH0=;
        b=SxYPEtw1Hj5BFRZDYafhryK1ZYRdbiUnWYfKg15cY1nFw12NqO02a1GaNaOuboCMBU
         8pr14H3IG12creGd4eh7liWjX4Q7+qLBx2jm1ijLnt9DVPI4xKjOpEzNmw9aYINcVoCO
         jU9F09m0lmsYurKxFboCZmTZsT/EJAqeU2+iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMuB6JFVOyqdER293NidtAVyJ00hndHqLd79moXaHH0=;
        b=vgkTBjjZ4GWv4+3j0ft6Q4UDgcoQeMT7jcT0Xf1mmaYJyNo8cDoSUQ7A11YA140M4a
         BMrVkTFv/5iezqRBnBWvLNLBf/Qw7NSyx9sF8r4PTjblkrF8EZnr6VCTVhTLfsmO3Bmw
         XlaNIcErouwQrZ9GTVIeq6V9hmTENcvHd6NmWUYOhq2yWNZHaiSRij29OSJu4MJzXEPd
         C1ypvcYG9XCvAWVZdc3JM617Db38hQ6I+ZH1Ocx8qrWGIwg8D29WiyiiCeROLLhdSi65
         OK3ELXVFDXb8g2bfEDfOvgVLeqxlrZaC6dy9K1QXozUSsfedEGV2CTEVx7BYQSnXLyoY
         1dZA==
X-Gm-Message-State: ACrzQf1ymrYXkAH4492HhUzFLMbZmdgapwJhmbeBCCeowzaurn5mg5XK
        cw2ZHg+UizbIjzwPkYAmMeupgQ==
X-Google-Smtp-Source: AMsMyM6sH8lJy6qNaJdS/u0S3H6KQmscXj0Oh/cd8tbO9gAP/DRFhipqT+FR1orWSQKW7y9lw94/gw==
X-Received: by 2002:a17:90a:2d8e:b0:20d:b4ee:aed3 with SMTP id p14-20020a17090a2d8e00b0020db4eeaed3mr29163279pjd.61.1666116555354;
        Tue, 18 Oct 2022 11:09:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s187-20020a625ec4000000b005662e18c899sm9503828pfb.68.2022.10.18.11.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:09:14 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:09:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <202210181020.79AF7F7@keescook>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:35:50PM +0200, Peter Zijlstra wrote:
> Implement an alternative CFI scheme that merges both the fine-grained
> nature of kCFI but also takes full advantage of the coarse grained
> hardware CFI as provided by IBT.

Very nice to have!

> To contrast:
> 
>   kCFI is a pure software CFI scheme and relies on being able to read
> text -- specifically the instruction *before* the target symbol, and
> does the hash validation *before* doing the call (otherwise control
> flow is compromised already).
> 
>   FineIBT is a software and hardware hybrid scheme; by ensuring every
> branch target starts with a hash validation it is possible to place
> the hash validation after the branch. This has several advantages:
> 
>    o the (hash) load is avoided; no memop; no RX requirement.
> 
>    o IBT WAIT-FOR-ENDBR state is a speculation stop; by placing
>      the hash validation in the immediate instruction after
>      the branch target there is a minimal speculation window
>      and the whole is a viable defence against SpectreBHB.

I still think it's worth noting it does technically weaken the
"attacker-controlled executable memory content injection" attack
requirements, too. While an attacker needs to make sure they place an
ENDBR at the start of their injected code, they no longer need to also
learn and inject the CFI hash too, as the malicious code can just not
do the check at all. The difference in protection currently isn't much.

It's not a very difficult requirement to get attacker-controlled bytes
into executable memory, as there are already existing APIs that provide
this to varying degrees of reachability, utility, and discoverability --
for example, BPF JIT when constant blinding isn't enabled (the unfortunate
default). And with the hashes currently being deterministic, there's no
secret that needs to be exposed first; an attack can just calculate it.
An improvement for kCFI would be to mutate all the hashes both at build
time (perhaps using the same seed infrastructure that randstruct depends
on for sharing a seed across compilation units), and at boot time, so
an actual .text content exposure is needed to find the target hash value.

> Obviously this patch relies on kCFI (upstream), but additionally it also
> relies on the padding from the call-depth-tracking patches
> (tip/x86/core). It uses this padding to place the hash-validation while
> the call-sites are re-written to modify the indirect target to be 16
> bytes in front of the original target, thus hitting this new preamble.
> 
> Notably, there is no hardware that needs call-depth-tracking (Skylake)
> and supports IBT (Tigerlake and onwards).
> 
> Suggested-by: Joao Moreira (Intel) <joao@overdrivepizza.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [...]
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2464,13 +2464,23 @@ config FUNCTION_PADDING_BYTES
>  	default FUNCTION_PADDING_CFI if CFI_CLANG
>  	default FUNCTION_ALIGNMENT
>  
> +config CALL_PADDING
> +	def_bool n
> +	depends on CC_HAS_ENTRY_PADDING && OBJTOOL
> +	select FUNCTION_ALIGNMENT_16B
> +
> +config FINEIBT
> +	def_bool y
> +	depends on X86_KERNEL_IBT && CFI_CLANG
> +	select CALL_PADDING

To that end, can we please make this a prompted choice?

And this is a good time to ping you about this patch as well:
https://lore.kernel.org/lkml/20220902234213.3034396-1-keescook@chromium.org/

> [...]
> +#ifdef CONFIG_FINEIBT
> +/*
> + * kCFI						FineIBT
> + *
> + * __cfi_\func:					__cfi_\func:
> + *	movl   $0x12345678,%eax			     endbr64			// 4

kCFI emits endbr64 here first too ...

> + *	nop					     subl   $0x12345678,%r10d   // 7
> + *	nop					     jz     1f			// 2
> + *	nop					     ud2			// 2
> + *	nop					1:   nop			// 1
> + *	nop
> + *	nop
> + *	nop
> + *	nop
> + *	nop
> + *	nop
> + *	nop

Tangent: why are these nop instead of 0xcc? These bytes aren't executed
ever are they?

-- 
Kees Cook
