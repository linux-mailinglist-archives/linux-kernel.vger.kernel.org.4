Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B76DF001
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDLJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDLJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:02:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28452A9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:02:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BB5C14;
        Wed, 12 Apr 2023 02:03:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7B153F587;
        Wed, 12 Apr 2023 02:02:17 -0700 (PDT)
Date:   Wed, 12 Apr 2023 10:02:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/stackleak: provide fast __stackleak_poison()
 implementation
Message-ID: <ZDZzl3wAH3zszTqu@FVFF77S0Q05N>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
 <20230405130841.1350565-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405130841.1350565-3-hca@linux.ibm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:08:41PM +0200, Heiko Carstens wrote:
> Provide an s390 specific __stackleak_poison() implementation which is
> faster than the generic variant.
> 
> For the original implementation with an enforced 4kb stackframe for the
> getpid() system call the system call overhead increases by a factor of 3 if
> the stackleak feature is enabled. Using the s390 mvc based variant this is
> reduced to an increase of 25% instead.
> 
> This is within the expected area, since the mvc based implementation is
> more or less a memset64() variant which comes with similar results. See
> commit 0b77d6701cf8 ("s390: implement memset16, memset32 & memset64").

With that in mind, could we use memset64() directly (if we made it
noninstr-safe)?

Mark.

> 
> Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/processor.h | 35 +++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> index efffc28cbad8..dc17896a001a 100644
> --- a/arch/s390/include/asm/processor.h
> +++ b/arch/s390/include/asm/processor.h
> @@ -118,6 +118,41 @@ unsigned long vdso_size(void);
>  
>  #define HAVE_ARCH_PICK_MMAP_LAYOUT
>  
> +#define __stackleak_poison __stackleak_poison
> +static __always_inline void __stackleak_poison(unsigned long erase_low,
> +					       unsigned long erase_high,
> +					       unsigned long poison)
> +{
> +	unsigned long tmp, count;
> +
> +	count = erase_high - erase_low;
> +	if (!count)
> +		return;
> +	asm volatile(
> +		"	cghi	%[count],8\n"
> +		"	je	2f\n"
> +		"	aghi	%[count],-(8+1)\n"
> +		"	srlg	%[tmp],%[count],8\n"
> +		"	ltgr	%[tmp],%[tmp]\n"
> +		"	jz	1f\n"
> +		"0:	stg	%[poison],0(%[addr])\n"
> +		"	mvc	8(256-8,%[addr]),0(%[addr])\n"
> +		"	la	%[addr],256(%[addr])\n"
> +		"	brctg	%[tmp],0b\n"
> +		"1:	stg	%[poison],0(%[addr])\n"
> +		"	larl	%[tmp],3f\n"
> +		"	ex	%[count],0(%[tmp])\n"
> +		"	j	4f\n"
> +		"2:	stg	%[poison],0(%[addr])\n"
> +		"	j	4f\n"
> +		"3:	mvc	8(1,%[addr]),0(%[addr])\n"
> +		"4:\n"
> +		: [addr] "+&a" (erase_low), [count] "+&d" (count), [tmp] "=&a" (tmp)
> +		: [poison] "d" (poison)
> +		: "memory", "cc"
> +		);
> +}
> +
>  /*
>   * Thread structure
>   */
> -- 
> 2.37.2
> 
