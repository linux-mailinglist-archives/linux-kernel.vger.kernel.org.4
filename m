Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCE664DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjAJVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjAJVEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:04:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98295D6AA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8243UaSorgOzEooA7Jj1rWRfF3xm9fokbdVFACQhxcg=; b=Vqd/BhzWkCI89PW/DWxey7skgJ
        Xob9byjR10xxbP7/5mSxw8Uac2rXda9AKLjrYhGT/gRLpI5DDvcw1aJyKxoMBdZRCLSFd0WNNc2YX
        KuWMzRiuKo7V3QjQeoGYR48O5xgIz7e9cnUVx3+hfyOF0K1+fFqt9XvKlvSGiDzpN+LhHw8HTc8WU
        PZaNMdGSBcSstMuJaqGl6XaDERv9HMuN9XyZpbc5h7HOMRlEE0XL5cljfp8c9pJK23OdHBWabCKtr
        E0j00uy2KGnFfi8g05oDU+8gzOelEpEfKyW4p3JX4DAFPD3ZatSuoio8b4Ub4fLnIyWD6MQ2nzJmd
        yojc/aPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFLnh-003XBq-QU; Tue, 10 Jan 2023 21:04:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F6E6300129;
        Tue, 10 Jan 2023 22:04:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FE5F2C4CAB7F; Tue, 10 Jan 2023 22:04:39 +0100 (CET)
Date:   Tue, 10 Jan 2023 22:04:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yian Chen <yian.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Message-ID: <Y73S56t/wDIGEPlK@hirez.programming.kicks-ass.net>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110055204.3227669-4-yian.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:52:00PM -0800, Yian Chen wrote:
> Most of the kernel is mapped at virtual addresses
> in the upper half of the address range. But kernel
> deliberately initialized a temporary mm area
> within the lower half of the address range
> for text poking, see commit 4fc19708b165
> ("x86/alternatives: Initialize temporary mm
> for patching").
> 
> LASS stops access to a lower half address in kernel,
> and this can be deactivated if AC bit in EFLAGS
> register is set. Hence use stac and clac instructions
> around access to the address to avoid triggering a
> LASS #GP fault.
> 
> Kernel objtool validation warns if the binary calls
> to a non-whitelisted function that exists outside of
> the stac/clac guard, or references any function with a
> dynamic function pointer inside the guard; see section
> 9 in the document tools/objtool/Documentation/objtool.txt.
> 
> For these reasons, also considering text poking size is
> usually small, simple modifications have been done
> in function text_poke_memcpy() and text_poke_memset() to
> avoid non-whitelisted function calls inside the stac/clac
> guard.
> 
> Gcc may detect and replace the target with its built-in
> functions. However, the replacement would break the
> objtool validation criteria. Hence, add compiler option
> -fno-builtin for the file.

Please reflow to 72 characters consistently, this is silly.

> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
>  arch/x86/include/asm/smap.h      | 13 +++++++++++++
>  arch/x86/kernel/Makefile         |  2 ++
>  arch/x86/kernel/alternative.c    | 21 +++++++++++++++++++--
>  tools/objtool/arch/x86/special.c |  2 ++
>  4 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
> index bab490379c65..6f7ac0839b10 100644
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -39,6 +39,19 @@ static __always_inline void stac(void)
>  	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
>  }
>  
> +/* Deactivate/activate LASS via AC bit in EFLAGS register */
> +static __always_inline void low_addr_access_begin(void)
> +{
> +	/* Note: a barrier is implicit in alternative() */
> +	alternative("", __ASM_STAC, X86_FEATURE_LASS);
> +}
> +
> +static __always_inline void low_addr_access_end(void)
> +{
> +	/* Note: a barrier is implicit in alternative() */
> +	alternative("", __ASM_CLAC, X86_FEATURE_LASS);
> +}

Can't say I like the name. Also if you look at bit 63 as a sign bit,
it's actively wrong since -1 is lower than 0.

> +
>  static __always_inline unsigned long smap_save(void)
>  {
>  	unsigned long flags;
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 96d51bbc2bd4..f8a455fc56a2 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -7,6 +7,8 @@ extra-y	+= vmlinux.lds
>  
>  CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
>  
> +CFLAGS_alternative.o	+= -fno-builtin
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
>  CFLAGS_REMOVE_tsc.o = -pg
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 7d8c3cbde368..4de8b54fb5f2 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1530,14 +1530,31 @@ __ro_after_init unsigned long poking_addr;
>  
>  static void text_poke_memcpy(void *dst, const void *src, size_t len)
>  {
> -	memcpy(dst, src, len);
> +	const char *s = src;
> +	char *d = dst;
> +
> +	/* The parameter dst ends up referencing to the global variable
> +	 * poking_addr, which is mapped to the low half address space.
> +	 * In kernel, accessing the low half address range is prevented
> +	 * by LASS. So relax LASS prevention while accessing the memory
> +	 * range.
> +	 */
> +	low_addr_access_begin();
> +	while (len-- > 0)
> +		*d++ = *s++;
> +	low_addr_access_end();
>  }
>  
>  static void text_poke_memset(void *dst, const void *src, size_t len)
>  {
>  	int c = *(const int *)src;
> +	char *d = dst;
>  
> -	memset(dst, c, len);
> +	/* The same comment as it is in function text_poke_memcpy */
> +	low_addr_access_begin();
> +	while (len-- > 0)
> +		*d++ = c;
> +	low_addr_access_end();
>  }

This is horrific tinkering :/

Also, what about the EFI mm? IIRC EFI also lives in the user address
space.
