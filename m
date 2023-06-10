Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E172AE83
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFJT73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFJT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:59:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090D358E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:59:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30ad458f085so2136531f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686427164; x=1689019164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH6F4IpPs6WqwDutFEw1CeMpDeXOPSGi61HT3b4tF54=;
        b=pq6MkclAqqXNn+gzx4D066TG0+Coqb+LuXHvlzjEbQf7n6G9HOhm93O74uKGIM5Hzw
         ZDBHHO60qQjQxGVXSAtv4QufMA5vPBfZRAZnQ2rEGoZDg3MGaY5z+p9nF5l1IFFrNmQA
         seRUzRIkI+FbEems6/PrBv+L1KxKLjDmnTUoYsULz4qWxZuVWAlfBrOAPCh4QCo9gC6P
         CAsVaa27exiL9n3NDGFoOhXC99oCSF0pubSmTJ6OkIRWje0mZOp2QKIKS0BoL3qxBMNV
         anLmNtaWYyXOARg6emTJ2uf39lzUAhJ6F0NT3rqePS/kha2t7bNcYatsYJ7wl3OMj7fO
         hjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686427164; x=1689019164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH6F4IpPs6WqwDutFEw1CeMpDeXOPSGi61HT3b4tF54=;
        b=BIm1nxfC4P1G/V41o9ct4hyD2sFManAVweLw6b9XUYWz6QLaPDuflwq178K4OiQcmC
         ixV2pdMDsBP0/XHRGvRDjcCj6NG+Hxw8pO0oymt/ZfslfiUk2IBDOSgR4WPLfSUtNH0P
         D/oftJYT7MyfGtYFDeGb+/wWe61cysn6g2NtFT0oXLHTCFg0PHE7wox3Taj+6jknl372
         HTbgVDPyLjsP02/6udVION1Ct9MNsoTcq2G3FvyoGp8F2iEdtvdcnOqwT8WStoBeZE6T
         Rph63YMhrFMTngxvBKUH5TM9CzvgZlIrI8bkOUw5F89g2RASo1TNR0TPltmD3EpwNcC/
         7+8A==
X-Gm-Message-State: AC+VfDwfZF5ALef7p9OXe5ZZ7goR74uzR0XsIpfGxFoK3HG50MwbQuXV
        FAswUPV4cDGD0BisAA7amwxUfQ==
X-Google-Smtp-Source: ACHHUZ6+VEOi+STjrbBGZOKsuBAvGn4quAt/4Ww7GrPoS2S/QMTzO+t/tJgopO6iBsQbNWu3/XgouA==
X-Received: by 2002:a05:600c:5123:b0:3f7:e78e:8a41 with SMTP id o35-20020a05600c512300b003f7e78e8a41mr7063994wms.18.1686427164344;
        Sat, 10 Jun 2023 12:59:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t12-20020adfeb8c000000b0030ae6432504sm7861646wrn.38.2023.06.10.12.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:59:23 -0700 (PDT)
Date:   Sat, 10 Jun 2023 22:59:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] vsscanf(): Integer overflow is a conversion
 failure
Message-ID: <2551923b-8c92-4ae7-90ec-2482c9e546e3@kadam.mountain>
References: <20230610170743.2510-1-demi@invisiblethingslab.com>
 <20230610170743.2510-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610170743.2510-2-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 01:07:41PM -0400, Demi Marie Obenour wrote:
> ---
>  .../hive_isp_css_include/platform_support.h   |  1 -
>  include/linux/limits.h                        |  1 +
>  include/linux/mfd/wl1273-core.h               |  3 -
>  include/vdso/limits.h                         |  3 +
>  lib/vsprintf.c                                | 82 ++++++++++++++-----
>  5 files changed, 67 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
> index 0cdef4a5e8b1bed9884133f1a0b9d853d59d43a4..e29b96d8bebf14839f6dd48fdc6c0f8b029ef31d 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
> @@ -27,7 +27,6 @@
>  
>  #define UINT16_MAX USHRT_MAX
>  #define UINT32_MAX UINT_MAX
> -#define UCHAR_MAX  (255)
>  
>  #define CSS_ALIGN(d, a) d __attribute__((aligned(a)))
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

It looks like you're going to have to redo these patches anyway for
various reasons.  Could you pull the U/SCHAR_MAX changes out into a
separate patch?

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 40f560959b169b4c4ac6154d658cfe76cfd0c5a6..8caccdcda0a2b470cda70c9b3837de37207eb512 100644
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

It's not clear what this FIXME is for, but probably it should go next to
the cp += (rv & ~KSTRTOX_OVERFLOW); line?  Does anyone know what it
means?  Maybe just delete it.

> +		if (overflow)
> +			*overflow = !!(rv & KSTRTOX_OVERFLOW);
>  		cp += (rv & ~KSTRTOX_OVERFLOW);
>  	} else {

*overflow isn't initialized on the else path.

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
>  /**
> @@ -3441,7 +3447,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  		unsigned long long u;
>  	} val;
>  	s16 field_width;
> -	bool is_sign;
> +	bool is_sign, overflow, allow_overflow;
>  
>  	while (*fmt) {
>  		/* skip any white space in format */
> @@ -3464,6 +3470,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			break;
>  		++fmt;
>  
> +		allow_overflow = *fmt == '!';
> +		fmt += (int)allow_overflow;
> +
>  		/* skip this conversion.
>  		 * advance both strings to next white space
>  		 */
> @@ -3649,45 +3658,80 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
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
> +		if (unlikely(overflow && !allow_overflow))

So that means that *overflow can be uninitialized here.

> +			break;
>  
>  		switch (qualifier) {

regards,
dan carpenter

