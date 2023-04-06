Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9761E6D915D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjDFIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDFIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:20:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD9DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=id3WiveMxpavuQmUN2xqspEpuvTQmvx1SGFNzOo5wiA=; b=jRTi1DwZVd0WMNgzKzsSqgWOgX
        mgevkkX4j+u0pqlfWh/8Equk9WmT2PppXiV5rbqFmKveguoPapefX+P43HvkUR1xn8/X+0UmaWaMS
        ZDHt4LFQZiEmHDMkso2aS+2S3lr49/byLgi8ENYg2rUv4nD3e4fvEgeSRrS35Dmgc225qvMmWmyH0
        Lp7+ATCpY6t9m0ZJ7ysLXR1QIVtoaqXhnb6yTa0iINm0CNJ9ov/aqhmHuOIjYdBoUbMVTMkY2jF/P
        a0UO34NTkt/7Lva7+j3XRC+By0oZxFi5RalaWIgvAaRGxtUO13RdOhsPG5lFv/GImJtWL4yNbVzga
        2rH++C1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkKqI-00AT8F-0b;
        Thu, 06 Apr 2023 08:19:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B63D3000DC;
        Thu,  6 Apr 2023 10:19:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7302824C025F0; Thu,  6 Apr 2023 10:19:33 +0200 (CEST)
Date:   Thu, 6 Apr 2023 10:19:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 4/9] x86/clear_page: parameterize clear_page*() to
 specify length
Message-ID: <20230406081933.GD386572@hirez.programming.kicks-ass.net>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-5-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403052233.1880567-5-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:22:28PM -0700, Ankur Arora wrote:
> Change clear_page*() to take a length parameter.
> Rename to clear_pages_*().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

> diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
> index ecbfb4dd3b01..6069acf6072f 100644
> --- a/arch/x86/lib/clear_page_64.S
> +++ b/arch/x86/lib/clear_page_64.S
> @@ -2,6 +2,8 @@
>  #include <linux/linkage.h>
>  #include <asm/asm.h>
>  #include <asm/export.h>
> +#include <asm/cpufeatures.h>
> +#include <asm/alternative.h>
>  
>  /*
>   * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
> @@ -13,18 +15,30 @@
>  /*
>   * Zero a page.
>   * %rdi	- page
> + * %esi	- page-length
> + *
> + * Clobbers: %rax, %rcx
>   */
> -SYM_FUNC_START(clear_page_rep)
> -	movl $4096/8,%ecx
> +SYM_FUNC_START(clear_pages_rep)
> +	movl %esi, %ecx
>  	xorl %eax,%eax
> +	shrl $3,%ecx
>  	rep stosq
>  	RET
> -SYM_FUNC_END(clear_page_rep)
> -EXPORT_SYMBOL_GPL(clear_page_rep)
> +SYM_FUNC_END(clear_pages_rep)
> +EXPORT_SYMBOL_GPL(clear_pages_rep)
>  
> -SYM_FUNC_START(clear_page_orig)
> +/*
> + * Original page zeroing loop.
> + * %rdi	- page
> + * %esi	- page-length
> + *
> + * Clobbers: %rax, %rcx, %rflags
> + */
> +SYM_FUNC_START(clear_pages_orig)
> +	movl   %esi, %ecx
>  	xorl   %eax,%eax
> -	movl   $4096/64,%ecx
> +	shrl   $6,%ecx
>  	.p2align 4
>  .Lloop:
>  	decl	%ecx
> @@ -41,16 +55,23 @@ SYM_FUNC_START(clear_page_orig)
>  	jnz	.Lloop
>  	nop
>  	RET
> -SYM_FUNC_END(clear_page_orig)
> -EXPORT_SYMBOL_GPL(clear_page_orig)
> +SYM_FUNC_END(clear_pages_orig)
> +EXPORT_SYMBOL_GPL(clear_pages_orig)
>  
> -SYM_FUNC_START(clear_page_erms)
> -	movl $4096,%ecx
> +/*
> + * Zero a page.
> + * %rdi	- page
> + * %esi	- page-length
> + *
> + * Clobbers: %rax, %rcx
> + */
> +SYM_FUNC_START(clear_pages_erms)
> +	movl %esi, %ecx
>  	xorl %eax,%eax
>  	rep stosb
>  	RET
> -SYM_FUNC_END(clear_page_erms)
> -EXPORT_SYMBOL_GPL(clear_page_erms)
> +SYM_FUNC_END(clear_pages_erms)
> +EXPORT_SYMBOL_GPL(clear_pages_erms)

So it seems to me that clear_user_*() and clear_page_*() are now very
similar; is there really no way to de-duplicate all that?
