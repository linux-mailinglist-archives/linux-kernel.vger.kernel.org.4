Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19C5741046
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjF1Lpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:45:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbjF1Lpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:45:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 493B3C14;
        Wed, 28 Jun 2023 04:46:32 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.29.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8063F663;
        Wed, 28 Jun 2023 04:45:46 -0700 (PDT)
Date:   Wed, 28 Jun 2023 12:45:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
Message-ID: <ZJwdZ_cStUp0cXyS@FVFF77S0Q05N>
References: <20230628094938.2318171-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628094938.2318171-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:49:18AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> An otherwise correct change to the atomic operations uncovered an
> existing bug in the sparc __arch_xchg() function, which is calls
> __xchg_called_with_bad_pointer() when its arguments are unknown at
> compile time:
> 
> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
> 
> This now happens because gcc determines that it's better to not inline the
> function. Avoid this by just marking the function as __always_inline
> to force the compiler to do the right thing here.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Aha; you saved me writing a patch! :)

We should probably do likewise for all the other bits like __cmpxchg(), but
either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/sparc/include/asm/cmpxchg_32.h | 2 +-
>  arch/sparc/include/asm/cmpxchg_64.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
> index 7a1339533d1d7..d0af82c240b73 100644
> --- a/arch/sparc/include/asm/cmpxchg_32.h
> +++ b/arch/sparc/include/asm/cmpxchg_32.h
> @@ -15,7 +15,7 @@
>  unsigned long __xchg_u32(volatile u32 *m, u32 new);
>  void __xchg_called_with_bad_pointer(void);
>  
> -static inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
> +static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>  {
>  	switch (size) {
>  	case 4:
> diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
> index 66cd61dde9ec1..3de25262c4118 100644
> --- a/arch/sparc/include/asm/cmpxchg_64.h
> +++ b/arch/sparc/include/asm/cmpxchg_64.h
> @@ -87,7 +87,7 @@ xchg16(__volatile__ unsigned short *m, unsigned short val)
>  	return (load32 & mask) >> bit_shift;
>  }
>  
> -static inline unsigned long
> +static __always_inline unsigned long
>  __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>  {
>  	switch (size) {
> -- 
> 2.39.2
> 
