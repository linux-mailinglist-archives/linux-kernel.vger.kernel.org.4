Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480FC72AA08
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjFJHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjFJHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 03:51:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281093A8C;
        Sat, 10 Jun 2023 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e993wCnDw9cGSzHO3lA4YECEyqTNXOWktvMD8n9Ni8w=; b=NFydZQOJpvXZKorY75hNir585N
        L6a9rdeYoXfmClisnE93A6Sj4O6Kfc/eHZKnRq5bRcsZlYswnXFQ06Wx3itGIDhajWm7IRlwnm37H
        jUBwzy1me9B9e042+vob8oQHB5NoYr2id87qvCKwarkdQqfG2QxajfMeUWI9Mxa5wZKe5IYJJD7Ek
        o4hk8csDjBS/8TgSOYDEUg5vtnW7AmIKUMHZ5B9g/bkdaPiHvCjMdDIR6bbZMeZnJ6YAAOLdfFwV6
        C7eSM2WWsNnv4AZLNTpGS3pP7Mg+FQnw82CQfkJcBTjEvRiH3FtBl1NpzTalPZ45iqkaNcOuK2Zt1
        4GAZJmBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7tNa-00FUrA-2s;
        Sat, 10 Jun 2023 07:51:22 +0000
Date:   Sat, 10 Jun 2023 00:51:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/4] vsscanf(): Return -ERANGE on integer overflow
Message-ID: <ZIQrevjNjMn9cBRM@infradead.org>
References: <20230610025759.1813-1-demi@invisiblethingslab.com>
 <20230610025759.1813-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610025759.1813-2-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Richard and Linus as they're having another overflow checking
discussion and we should probably merge those]

On Fri, Jun 09, 2023 at 10:57:57PM -0400, Demi Marie Obenour wrote:
> Userspace sets errno to ERANGE, but the kernel can't do that.

That seems like a very parse commit log, and also kinda besides
the point - the kernel always returns error in-line and not through
errno.  I think you need to document here why we want to do the
overflow checking (not that I doubt it, but it really needs to be
in the commit message).

Leaving the rest of the quote here for the new arrivals.

> 
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> ---
>  include/linux/limits.h          |  1 +
>  include/linux/mfd/wl1273-core.h |  3 --
>  include/vdso/limits.h           |  3 ++
>  lib/vsprintf.c                  | 80 ++++++++++++++++++++++++---------
>  4 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/limits.h b/include/linux/limits.h
> index f6bcc936901071f496e3e85bb6e1d93905b12e32..8f7fd85b41fb46e6992d9e5912da00424119227a 100644
> --- a/include/linux/limits.h
> +++ b/include/linux/limits.h
> @@ -8,6 +8,7 @@
>  
>  #define SIZE_MAX	(~(size_t)0)
>  #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
> +#define SSIZE_MIN	(-SSIZE_MAX - 1)
>  #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
>  
>  #define U8_MAX		((u8)~0U)
> diff --git a/include/linux/mfd/wl1273-core.h b/include/linux/mfd/wl1273-core.h
> index c28cf76d5c31ee1c94a9319a2e2d318bf00283a6..b81a229135ed9f756c749122a8341816031c8311 100644
> --- a/include/linux/mfd/wl1273-core.h
> +++ b/include/linux/mfd/wl1273-core.h
> @@ -204,9 +204,6 @@
>  				 WL1273_IS2_TRI_OPT | \
>  				 WL1273_IS2_RATE_48K)
>  
> -#define SCHAR_MIN (-128)
> -#define SCHAR_MAX 127
> -
>  #define WL1273_FR_EVENT			BIT(0)
>  #define WL1273_BL_EVENT			BIT(1)
>  #define WL1273_RDS_EVENT		BIT(2)
> diff --git a/include/vdso/limits.h b/include/vdso/limits.h
> index 0197888ad0e00b2f853d3f25ffa764f61cca7385..0cad0a2490e5efc194d874025eb3e3b846a5c7b4 100644
> --- a/include/vdso/limits.h
> +++ b/include/vdso/limits.h
> @@ -2,6 +2,9 @@
>  #ifndef __VDSO_LIMITS_H
>  #define __VDSO_LIMITS_H
>  
> +#define UCHAR_MAX	((unsigned char)~0U)
> +#define SCHAR_MAX	((signed char)(UCHAR_MAX >> 1))
> +#define SCHAR_MIN	((signed char)(-SCHAR_MAX - 1))
>  #define USHRT_MAX	((unsigned short)~0U)
>  #define SHRT_MAX	((short)(USHRT_MAX >> 1))
>  #define SHRT_MIN	((short)(-SHRT_MAX - 1))
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index a60d348efb276d66ca07fe464883408df7fdab97..9846d2385f5b9e8f3945a5664d81047e97cf10d5 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -59,7 +59,7 @@
>  bool no_hash_pointers __ro_after_init;
>  EXPORT_SYMBOL_GPL(no_hash_pointers);
>  
> -static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base)
> +static noinline unsigned long long simple_strntoull(const char *startp, size_t max_chars, char **endp, unsigned int base, bool *overflow)
>  {
>  	const char *cp;
>  	unsigned long long result = 0ULL;
> @@ -71,6 +71,8 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
>  	if (prefix_chars < max_chars) {
>  		rv = _parse_integer_limit(cp, base, &result, max_chars - prefix_chars);
>  		/* FIXME */
> +		if (overflow)
> +			*overflow = !!(rv & KSTRTOX_OVERFLOW);
>  		cp += (rv & ~KSTRTOX_OVERFLOW);
>  	} else {
>  		/* Field too short for prefix + digit, skip over without converting */
> @@ -94,7 +96,7 @@ static noinline unsigned long long simple_strntoull(const char *startp, size_t m
>  noinline
>  unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
>  {
> -	return simple_strntoull(cp, INT_MAX, endp, base);
> +	return simple_strntoull(cp, INT_MAX, endp, base, NULL);
>  }
>  EXPORT_SYMBOL(simple_strtoull);
>  
> @@ -130,18 +132,22 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
>  EXPORT_SYMBOL(simple_strtol);
>  
>  static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
> -				 unsigned int base)
> +				 unsigned int base, bool *overflow)
>  {
> +	unsigned long long minand;
> +	bool negate;
> +
>  	/*
>  	 * simple_strntoull() safely handles receiving max_chars==0 in the
>  	 * case cp[0] == '-' && max_chars == 1.
>  	 * If max_chars == 0 we can drop through and pass it to simple_strntoull()
>  	 * and the content of *cp is irrelevant.
>  	 */
> -	if (*cp == '-' && max_chars > 0)
> -		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
> -
> -	return simple_strntoull(cp, max_chars, endp, base);
> +	negate = *cp == '-' && max_chars > 0;
> +	minand = simple_strntoull(cp + negate, max_chars - negate, endp, base, overflow);
> +	if (minand > (unsigned long long)LONG_MAX + negate)
> +		*overflow = true;
> +	return negate ? -minand : minand;
>  }
>  
>  static noinline_for_stack
> @@ -3427,7 +3433,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  		unsigned long long u;
>  	} val;
>  	s16 field_width;
> -	bool is_sign;
> +	bool is_sign, overflow;
>  
>  	while (*fmt) {
>  		/* skip any white space in format */
> @@ -3635,45 +3641,77 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  		if (is_sign)
>  			val.s = simple_strntoll(str,
>  						field_width >= 0 ? field_width : INT_MAX,
> -						&next, base);
> +						&next, base, &overflow);
>  		else
>  			val.u = simple_strntoull(str,
>  						 field_width >= 0 ? field_width : INT_MAX,
> -						 &next, base);
> +						 &next, base, &overflow);
> +		if (unlikely(overflow))
> +			return -ERANGE;
>  
>  		switch (qualifier) {
>  		case 'H':	/* that's 'hh' in format */
> -			if (is_sign)
> +			if (is_sign) {
> +				if (unlikely(val.s < SCHAR_MIN || val.s > SCHAR_MAX))
> +					return -ERANGE;
>  				*va_arg(args, signed char *) = val.s;
> -			else
> +			} else {
> +				if (unlikely(val.u > UCHAR_MAX))
> +					return -ERANGE;
>  				*va_arg(args, unsigned char *) = val.u;
> +			}
>  			break;
>  		case 'h':
> -			if (is_sign)
> +			if (is_sign) {
> +				if (unlikely(val.s < SHRT_MIN || val.s > SHRT_MAX))
> +					return -ERANGE;
>  				*va_arg(args, short *) = val.s;
> -			else
> +			} else {
> +				if (unlikely(val.u > USHRT_MAX))
> +					return -ERANGE;
>  				*va_arg(args, unsigned short *) = val.u;
> +			}
>  			break;
>  		case 'l':
> -			if (is_sign)
> +			if (is_sign) {
> +				if (unlikely(val.s < LONG_MIN || val.s > LONG_MAX))
> +					return -ERANGE;
>  				*va_arg(args, long *) = val.s;
> -			else
> +			} else {
> +				if (unlikely(val.u > ULONG_MAX))
> +					return -ERANGE;
>  				*va_arg(args, unsigned long *) = val.u;
> +			}
>  			break;
>  		case 'L':
> -			if (is_sign)
> +			/* No overflow check needed */
> +			if (is_sign) {
>  				*va_arg(args, long long *) = val.s;
> -			else
> +			} else {
>  				*va_arg(args, unsigned long long *) = val.u;
> +			}
>  			break;
>  		case 'z':
> -			*va_arg(args, size_t *) = val.u;
> +			if (is_sign) {
> +				if (unlikely(val.s < SSIZE_MIN || val.s > SSIZE_MAX))
> +					return -ERANGE;
> +				*va_arg(args, ssize_t *) = val.s;
> +			} else {
> +				if (unlikely(val.u > SIZE_MAX))
> +					return -ERANGE;
> +				*va_arg(args, size_t *) = val.u;
> +			}
>  			break;
>  		default:
> -			if (is_sign)
> +			if (is_sign) {
> +				if (unlikely(val.s < INT_MIN || val.s > INT_MAX))
> +					return -ERANGE;
>  				*va_arg(args, int *) = val.s;
> -			else
> +			} else {
> +				if (unlikely(val.u > UINT_MAX))
> +					return -ERANGE;
>  				*va_arg(args, unsigned int *) = val.u;
> +			}
>  			break;
>  		}
>  		num++;
> -- 
> Sincerely,
> Demi Marie Obenour (she/her/hers)
> Invisible Things Lab
> 
---end quoted text---
