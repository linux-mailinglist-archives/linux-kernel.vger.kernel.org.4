Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41D6DF002
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDLJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDLJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:03:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19CB35FE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:03:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A12C14;
        Wed, 12 Apr 2023 02:04:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF793F587;
        Wed, 12 Apr 2023 02:03:48 -0700 (PDT)
Date:   Wed, 12 Apr 2023 10:03:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] stackleak: allow to specify arch specific stackleak
 poison function
Message-ID: <ZDZz8QvPdpGJqMd6@FVFF77S0Q05N>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
 <20230405130841.1350565-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405130841.1350565-2-hca@linux.ibm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:08:40PM +0200, Heiko Carstens wrote:
> Factor out the code that fills the stack with the stackleak poison value
> in order to allow architectures to provide a faster implementation.
> 
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

As on patch 2, it might be nicer to have a noinstr-safe memset64() and use that
directly, but I don't have strong feelings either way, and I'll defer to Kees's
judgement:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  kernel/stackleak.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index c2c33d2202e9..34c9d81eea94 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -70,6 +70,18 @@ late_initcall(stackleak_sysctls_init);
>  #define skip_erasing()	false
>  #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
>  
> +#ifndef __stackleak_poison
> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> +					       unsigned long erase_high,
> +					       unsigned long poison)
> +{
> +	while (erase_low < erase_high) {
> +		*(unsigned long *)erase_low = poison;
> +		erase_low += sizeof(unsigned long);
> +	}
> +}
> +#endif
> +
>  static __always_inline void __stackleak_erase(bool on_task_stack)
>  {
>  	const unsigned long task_stack_low = stackleak_task_low_bound(current);
> @@ -101,10 +113,7 @@ static __always_inline void __stackleak_erase(bool on_task_stack)
>  	else
>  		erase_high = task_stack_high;
>  
> -	while (erase_low < erase_high) {
> -		*(unsigned long *)erase_low = STACKLEAK_POISON;
> -		erase_low += sizeof(unsigned long);
> -	}
> +	__stackleak_poison(erase_low, erase_high, STACKLEAK_POISON);
>  
>  	/* Reset the 'lowest_stack' value for the next syscall */
>  	current->lowest_stack = task_stack_high;
> -- 
> 2.37.2
> 
