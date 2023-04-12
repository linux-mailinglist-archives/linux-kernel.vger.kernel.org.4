Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C26E01A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDLWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDLWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C434659F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:03:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3066392B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B555C433EF;
        Wed, 12 Apr 2023 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681337031;
        bh=tefIW53ZJKwIqOdZsSJl2ug2/mxFBL2MwlQe6fIar5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iq5PQ4osESwUKnDUSdpSV3y1JKWndWE3bB36t9LoMuVuTLD3i6CvQvgl6U72MlTuC
         dqhafdhs+5oM0ElgpFUcGFnErtcRt2BGoR0qQ0y4K4qlOW6XKOqc5lGePKbyZ8bwcf
         gzRtyTokxw05pe3hmj9TRZN+6bQn3I6jwaSZXMZDRS5yMjekEdcMm+5Oih6G7/nw9t
         +jm2is6aEJfWfcaAjYLg+CS1HFTjHSSNXD2JjBlDpRFAaNUekzga5YU+dWkKEy/IEk
         9jjrmCuzmLwQosxDXqRTEa2DS1tKlYpQ1WS9HqM70Ee2OIKEpNjYOQurT4iWuaAqBV
         gzCefz8cgu8Fw==
Date:   Wed, 12 Apr 2023 15:03:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     ndesaulniers@google.com
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] start_kernel: add no_stack_protector fn attr
Message-ID: <20230412220348.GA1120303@dev-arch.thelio-3990X>
References: <20230412-no_stackp-v1-0-46a69b507a4b@google.com>
 <20230412-no_stackp-v1-1-46a69b507a4b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412-no_stackp-v1-1-46a69b507a4b@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:32:12AM -0700, ndesaulniers@google.com wrote:
> Back during the discussion of
> commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
> we discussed the need for a function attribute to control the omission
> of stack protectors on a per-function basis; at the time Clang had
> support for no_stack_protector but GCC did not. This was fixed in
> gcc-11. Now that the function attribute is available, let's start using
> it.
> 
> Callers of boot_init_stack_canary need to use this function attribute
> unless they're compiled with -fno-stack-protector, otherwise the canary
> stored in the stack slot of the caller will differ upon the call to
> boot_init_stack_canary. This will lead to a call to __stack_chk_fail
> then panic.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722
> Link: https://lore.kernel.org/all/20200316130414.GC12561@hirez.programming.kicks-ass.net/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I applied this in front of Josh's series and defconfig no longer panics
on boot :)

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/powerpc/kernel/smp.c           |  1 +
>  include/linux/compiler_attributes.h | 12 ++++++++++++
>  init/main.c                         |  3 ++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 6b90f10a6c81..7d4c12b1abb7 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1603,6 +1603,7 @@ static void add_cpu_to_masks(int cpu)
>  }
>  
>  /* Activate a secondary processor. */
> +__no_stack_protector
>  void start_secondary(void *unused)
>  {
>  	unsigned int cpu = raw_smp_processor_id();
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index e659cb6fded3..84864767a56a 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -255,6 +255,18 @@
>   */
>  #define __noreturn                      __attribute__((__noreturn__))
>  
> +/*
> + * Optional: only supported since GCC >= 11.1, clang >= 7.0.
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fstack_005fprotector-function-attribute
> + *   clang: https://clang.llvm.org/docs/AttributeReference.html#no-stack-protector-safebuffers
> + */
> +#if __has_attribute(__no_stack_protector__)
> +# define __no_stack_protector		__attribute__((__no_stack_protector__))
> +#else
> +# define __no_stack_protector
> +#endif
> +
>  /*
>   * Optional: not supported by gcc.
>   *
> diff --git a/init/main.c b/init/main.c
> index bb87b789c543..213baf7b8cb1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -941,7 +941,8 @@ static void __init print_unknown_bootoptions(void)
>  	memblock_free(unknown_options, len);
>  }
>  
> -asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> +asmlinkage __visible __init __no_sanitize_address __no_stack_protector
> +void start_kernel(void)
>  {
>  	char *command_line;
>  	char *after_dashes;
> 
> -- 
> 2.40.0.577.gac1e443424-goog
> 
> 
