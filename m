Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBA740CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjF1J0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:26:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237766AbjF1JNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:13:01 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FD8D1EC05B8;
        Wed, 28 Jun 2023 11:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687943579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NVtRlj5I08R++RoPxQ54xGtU2gNgZw79vCwf/atJuDw=;
        b=Z0nLJzFHmJB+Y6xBWq6bdmoYKYfKsgYdjBF001gvSytYN5Jc9h18lH8+ax0xNqSRTQY+uh
        RPFpJOSg6PsSl3oyn2ku4xCOoKrsdAtKT1mzQ/7aBd6bVTkVC818B1Mz+Lm/tWtdDgyQ+R
        nKEYosp3TJHKnZp1PSYXfc2iN42V/lc=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A_xJ3FoRzJ_7; Wed, 28 Jun 2023 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687943576; bh=NVtRlj5I08R++RoPxQ54xGtU2gNgZw79vCwf/atJuDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j28dN/aAhOgyWjhnUk4JOSvGMbN/eqExq7UtDI1YK9bWmJU6q2NzMuaGeGlm4P3kh
         BYV9UL6wZJNFr8YsuxwqJoq2d+v3VfgfVj6g14zseE4ow8ugH47uRM4MeBQa2mqQ+Z
         Nc3w6fH8plCKhKkVRby4uEuqKULhNRA6QhGYm4uFLsFAgdcUZHCqkT9+464dM1+rfq
         x3R7i7Yzo8Gj7z8HGJYGNPTjbSu3aS6Bja3YCQMm+9DYWPAlyVEhwTzeXLaldAlJGi
         vLCucP5Fneqb9LteKiIWe+a69PUbFi0rMJ3NeZceorXR8nHDyRK7BJVfxYbIk2qCWv
         m6y45DrUkrB1G2t3aMGQHtTH+O/CAmL5b5UgR+RE1lX5hVODC47veA9t/fAlDt6CDv
         f03R7t5P9jR5Ou3R/nwJp+6uWF4i4NGfo7dlI6jBIdL39M4v0zBskhQBxqtAxTtydP
         1eCpuaFxyR4Om/kLWICDhTxDlIf64qrh/8kEz5iTGCDUrgCctKwrRb4heRQcctk0dT
         EMr2hULHC4+ZQG8DUxwln96uMKDSiDVJ4F4/ta4STvHTtGMBsIZyk8SU5NNDhFBZ2L
         7FHZBnNsx6O5hwBe53quNiQa1AxVhNLeRoxcUbATHFfr4Oaz8FXwjufiTkrt5LD9dH
         FAhZgbjX44PRzOeUB3yU6LvI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC74E40E01E1;
        Wed, 28 Jun 2023 09:12:46 +0000 (UTC)
Date:   Wed, 28 Jun 2023 11:12:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86@kernel.org, edumazet@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: x86/csum: Remove unnecessary odd handling
Message-ID: <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628020657.957880-1-goldstein.w.n@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Linus who's been poking at this yesterday.

+ lkml. Please always CC lkml when sending patches.

On Tue, Jun 27, 2023 at 09:06:57PM -0500, Noah Goldstein wrote:
> The special case for odd aligned buffers is unnecessary and mostly
> just adds overhead. Aligned buffers is the expectations, and even for
> unaligned buffer, the only case that was helped is if the buffer was
> 1-byte from word aligned which is ~1/7 of the cases. Overall it seems
> highly unlikely to be worth to extra branch.
> 
> It was left in the previous perf improvement patch because I was
> erroneously comparing the exact output of `csum_partial(...)`, but
> really we only need `csum_fold(csum_partial(...))` to match so its
> safe to remove.
> 
> All csum kunit tests pass.
> 
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
>  arch/x86/lib/csum-partial_64.c | 37 ++--------------------------------
>  1 file changed, 2 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index cea25ca8b8cf..d06112e98893 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -11,28 +11,6 @@
>  #include <asm/checksum.h>
>  #include <asm/word-at-a-time.h>
>  
> -static inline unsigned short from32to16(unsigned a)
> -{
> -	unsigned short b = a >> 16;
> -	asm("addw %w2,%w0\n\t"
> -	    "adcw $0,%w0\n"
> -	    : "=r" (b)
> -	    : "0" (b), "r" (a));
> -	return b;
> -}
> -
> -static inline __wsum csum_tail(u64 temp64, int odd)
> -{
> -	unsigned int result;
> -
> -	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> -	if (unlikely(odd)) {
> -		result = from32to16(result);
> -		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> -	}
> -	return (__force __wsum)result;
> -}
> -
>  /*
>   * Do a checksum on an arbitrary memory area.
>   * Returns a 32bit checksum.
> @@ -47,17 +25,6 @@ static inline __wsum csum_tail(u64 temp64, int odd)
>  __wsum csum_partial(const void *buff, int len, __wsum sum)
>  {
>  	u64 temp64 = (__force u64)sum;
> -	unsigned odd;
> -
> -	odd = 1 & (unsigned long) buff;
> -	if (unlikely(odd)) {
> -		if (unlikely(len == 0))
> -			return sum;
> -		temp64 = ror32((__force u32)sum, 8);
> -		temp64 += (*(unsigned char *)buff << 8);
> -		len--;
> -		buff++;
> -	}
>  
>  	/*
>  	 * len == 40 is the hot case due to IPv6 headers, but annotating it likely()
> @@ -73,7 +40,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    "adcq $0,%[res]"
>  		    : [res] "+r"(temp64)
>  		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
> -		return csum_tail(temp64, odd);
> +		return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>  	}
>  	if (unlikely(len >= 64)) {
>  		/*
> @@ -143,7 +110,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    : [res] "+r"(temp64)
>  		    : [trail] "r"(trail));
>  	}
> -	return csum_tail(temp64, odd);
> +	return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>  }
>  EXPORT_SYMBOL(csum_partial);
>  
> -- 
> 2.34.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
