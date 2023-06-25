Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7573D4AA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjFYVqM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:46:08 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECAE9E;
        Sun, 25 Jun 2023 14:46:07 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qDXYW-002uoq-2P; Sun, 25 Jun 2023 23:46:00 +0200
Received: from dynamic-089-014-168-195.89.14.pool.telefonica.de ([89.14.168.195] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qDXYV-000RqL-Po; Sun, 25 Jun 2023 23:45:59 +0200
Message-ID: <eb2e34f5ebd541e648a6052e022d219cf0d65583.camel@physik.fu-berlin.de>
Subject: Re: [patch 08/17] sh/cpu: Switch to arch_cpu_finalize_init()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Tom Lendacky <thomas.lendacky@amd.com>
Date:   Sun, 25 Jun 2023 23:45:58 +0200
In-Reply-To: <20230613224545.371697797@linutronix.de>
References: <20230613223827.532680283@linutronix.de>
         <20230613224545.371697797@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.168.195
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-14 at 01:39 +0200, Thomas Gleixner wrote:
> check_bugs() is about to be phased out. Switch over to the new
> arch_cpu_finalize_init() implementation.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/sh/Kconfig                 |    1 
>  arch/sh/include/asm/bugs.h      |   74 ----------------------------------------
>  arch/sh/include/asm/processor.h |    2 +
>  arch/sh/kernel/idle.c           |    1 
>  arch/sh/kernel/setup.c          |   55 +++++++++++++++++++++++++++++
>  5 files changed, 59 insertions(+), 74 deletions(-)
> 
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -6,6 +6,7 @@ config SUPERH
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
>  	select ARCH_HAS_BINFMT_FLAT if !MMU
> +	select ARCH_HAS_CPU_FINALIZE_INIT
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> --- a/arch/sh/include/asm/bugs.h
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_SH_BUGS_H
> -#define __ASM_SH_BUGS_H
> -
> -/*
> - * This is included by init/main.c to check for architecture-dependent bugs.
> - *
> - * Needs:
> - *	void check_bugs(void);
> - */
> -
> -/*
> - * I don't know of any Super-H bugs yet.
> - */
> -
> -#include <asm/processor.h>
> -
> -extern void select_idle_routine(void);
> -
> -static void __init check_bugs(void)
> -{
> -	extern unsigned long loops_per_jiffy;
> -	char *p = &init_utsname()->machine[2]; /* "sh" */
> -
> -	select_idle_routine();
> -
> -	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
> -
> -	switch (current_cpu_data.family) {
> -	case CPU_FAMILY_SH2:
> -		*p++ = '2';
> -		break;
> -	case CPU_FAMILY_SH2A:
> -		*p++ = '2';
> -		*p++ = 'a';
> -		break;
> -	case CPU_FAMILY_SH3:
> -		*p++ = '3';
> -		break;
> -	case CPU_FAMILY_SH4:
> -		*p++ = '4';
> -		break;
> -	case CPU_FAMILY_SH4A:
> -		*p++ = '4';
> -		*p++ = 'a';
> -		break;
> -	case CPU_FAMILY_SH4AL_DSP:
> -		*p++ = '4';
> -		*p++ = 'a';
> -		*p++ = 'l';
> -		*p++ = '-';
> -		*p++ = 'd';
> -		*p++ = 's';
> -		*p++ = 'p';
> -		break;
> -	case CPU_FAMILY_UNKNOWN:
> -		/*
> -		 * Specifically use CPU_FAMILY_UNKNOWN rather than
> -		 * default:, so we're able to have the compiler whine
> -		 * about unhandled enumerations.
> -		 */
> -		break;
> -	}
> -
> -	printk("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
> -
> -#ifndef __LITTLE_ENDIAN__
> -	/* 'eb' means 'Endian Big' */
> -	*p++ = 'e';
> -	*p++ = 'b';
> -#endif
> -	*p = '\0';
> -}
> -#endif /* __ASM_SH_BUGS_H */
> --- a/arch/sh/include/asm/processor.h
> +++ b/arch/sh/include/asm/processor.h
> @@ -166,6 +166,8 @@ extern unsigned int instruction_size(uns
>  #define instruction_size(insn)	(2)
>  #endif
>  
> +void select_idle_routine(void);
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #include <asm/processor_32.h>
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -15,6 +15,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/smp.h>
>  #include <linux/atomic.h>
> +#include <asm/processor.h>
>  #include <asm/smp.h>
>  #include <asm/bl_bit.h>
>  
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -43,6 +43,7 @@
>  #include <asm/smp.h>
>  #include <asm/mmu_context.h>
>  #include <asm/mmzone.h>
> +#include <asm/processor.h>
>  #include <asm/sparsemem.h>
>  #include <asm/platform_early.h>
>  
> @@ -354,3 +355,57 @@ int test_mode_pin(int pin)
>  {
>  	return sh_mv.mv_mode_pins() & pin;
>  }
> +
> +void __init arch_cpu_finalize_init(void)
> +{
> +	char *p = &init_utsname()->machine[2]; /* "sh" */
> +
> +	select_idle_routine();
> +
> +	current_cpu_data.loops_per_jiffy = loops_per_jiffy;
> +
> +	switch (current_cpu_data.family) {
> +	case CPU_FAMILY_SH2:
> +		*p++ = '2';
> +		break;
> +	case CPU_FAMILY_SH2A:
> +		*p++ = '2';
> +		*p++ = 'a';
> +		break;
> +	case CPU_FAMILY_SH3:
> +		*p++ = '3';
> +		break;
> +	case CPU_FAMILY_SH4:
> +		*p++ = '4';
> +		break;
> +	case CPU_FAMILY_SH4A:
> +		*p++ = '4';
> +		*p++ = 'a';
> +		break;
> +	case CPU_FAMILY_SH4AL_DSP:
> +		*p++ = '4';
> +		*p++ = 'a';
> +		*p++ = 'l';
> +		*p++ = '-';
> +		*p++ = 'd';
> +		*p++ = 's';
> +		*p++ = 'p';
> +		break;
> +	case CPU_FAMILY_UNKNOWN:
> +		/*
> +		 * Specifically use CPU_FAMILY_UNKNOWN rather than
> +		 * default:, so we're able to have the compiler whine
> +		 * about unhandled enumerations.
> +		 */
> +		break;
> +	}
> +
> +	pr_info("CPU: %s\n", get_cpu_subtype(&current_cpu_data));
> +
> +#ifndef __LITTLE_ENDIAN__
> +	/* 'eb' means 'Endian Big' */
> +	*p++ = 'e';
> +	*p++ = 'b';
> +#endif
> +	*p = '\0';
> +}

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
