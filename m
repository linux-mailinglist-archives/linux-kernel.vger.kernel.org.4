Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5905BFD62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIUL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiIUL5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:57:13 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623489900;
        Wed, 21 Sep 2022 04:57:11 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 92BC33C1695;
        Wed, 21 Sep 2022 11:48:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a305 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BFA8F3C1381;
        Wed, 21 Sep 2022 11:48:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663760927; a=rsa-sha256;
        cv=none;
        b=pKPBwF6pxbd1LU8Lc9aJoFH/gqyP6dbNdLhqjxAUqCuLuSt3oS161J5mWqjSHzdJ4E3Obw
        XL1s/5b4v6KGQhAXqbo5YyJbO0f8hkCMmPLs7Bb6nszp3zZpz3fwNBwyb7GA85wyytuR4c
        bx8yQxW+CZ3IuEIzvpwpmKxmh/GI3C/h4MaqWdlTGLHJXYAqdIMRQMxukYa9fgyN2ZlG8L
        7tf/oFVEuSb/ajmjPprPVswTHYofw3NASVkf6tv698EETa7gv0KgZBg+Rijsj8NOxtePUW
        ldVmHtAuFOXMz72znqdXlgwAOggc1wEMHvW/H4aV03zWLbEEMftot2aJdQyTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663760927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=turS0/qDnZ8iNE8y4GFP580mlFQaC1N6+0yaiTc66YM=;
        b=ATAbUebTwYDHRWc0lyjt/qAJBb+3HtdHy/ZsEDljfyzG2jTQBIajlo5Bl2sN2YvI0W/Xh+
        hGdqRIbnVCC09pU/hOtUSFppmpaComsZcTF3IRH5xKcLbJ4f3PXcHNKc/UrhCMyFQPxOMw
        gAa9ds03BiZ+ZwNf9mb9GBzfoKnUw4gf4y3wefEURsGX+bgcOIAu/xce37fiI9pWXnuqlU
        cp4nfRntGH7DpdweSXvxFhuft/3f/YoNv6LklcNFz4zD+IWDOSnrDtzVZ6u+9y8UPYlDlk
        lrqEtjN6AVoMBpL6q01dvVp9Jnai0sqMTQ5HbNI0hMG1qFzNWkmUPWQji7jgeg==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-4rvqn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Keen-Decisive: 171df644725e00e6_1663760928146_3647263239
X-MC-Loop-Signature: 1663760928146:295560323
X-MC-Ingress-Time: 1663760928146
Received: from pdx1-sub0-mail-a305 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.129.208 (trex/6.7.1);
        Wed, 21 Sep 2022 11:48:48 +0000
Received: from [192.168.0.182] (bras-vprn-toroon4834w-lp130-16-184-147-84-238.dsl.bell.ca [184.147.84.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a305 (Postfix) with ESMTPSA id 4MXcBQ0kg7zQk;
        Wed, 21 Sep 2022 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
        s=dreamhost; t=1663760927;
        bh=turS0/qDnZ8iNE8y4GFP580mlFQaC1N6+0yaiTc66YM=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=sQ0uPr+QE8N73w9wUEu6/3L6Z7YDzh5EOIrMydkuHzDPZWmu5/nys3EFcgjvL0LtC
         EptS0OsTiUPkFKfceHLREwhwsC3by7Fmz/X0ybKSR674bPepdOxKcB0PALwV7nTrpr
         GWINZGg3bdDePFi9bUZaZsQ869ejcC+f3lPwJPtyFKe6bhoE620kBvEchFtJtl/JLf
         E6kevXFkJTIVFq3KRyKEK/ldwQDjDR3e86LmhliHsRJVfcG3O18aHbTm91nNRSWSFh
         Yi6CybDVTdV/y4iOrHhWkFCQaR3qKnh0r0sIGt8dCMRHAkTZ4gVy6WaEq6XqgYPVd2
         x8Pvl6t9IOlGA==
Message-ID: <b8f5f716-3ee6-87fd-d0e2-b1c35c98e0b0@gotplt.org>
Date:   Wed, 21 Sep 2022 07:48:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] fortify: Explicitly check bounds are compile-time
 constants
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-3-keescook@chromium.org>
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <20220920192202.190793-3-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-20 15:22, Kees Cook wrote:
> In preparation for replacing __builtin_object_size() with
> __builtin_dynamic_object_size(), all the compile-time size checks need
> to check that the bounds variables are, in fact, known at compile-time.
> Enforce what was guaranteed with __bos(). In other words, since all uses
> of __bos() were constant expressions, it was not required to test for
> this. When these change to __bdos(), they _may_ be constant expressions,
> and the checks are only valid when the prior condition holds. This
> results in no binary differences.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   include/linux/fortify-string.h | 50 +++++++++++++++++++++-------------
>   1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index ff879efe94ed..71c0a432c638 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -80,6 +80,12 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>   #define POS	__pass_object_size(1)
>   #define POS0	__pass_object_size(0)
>   
> +#define __compiletime_lessthan(bounds, length)	(	\
> +	__builtin_constant_p(length) &&			\
> +	__builtin_constant_p(bounds) &&			\
> +	bounds < length					\
> +)

So with the gcc ranger, the compiler has lately been quite successful at 
computing a constant `bounds < length` even though bounds and length are 
not constant.  So perhaps this:

#define __compiletime_lessthan (bounds, length) (	\
	__builtin_constant (bounds < length) &&		\
	bounds < length					\
)

might succeed in a few more cases.

Thanks,
Sid

> +
>   /**
>    * strncpy - Copy a string to memory with non-guaranteed NUL padding
>    *
> @@ -117,7 +123,7 @@ char *strncpy(char * const POS p, const char *q, __kernel_size_t size)
>   {
>   	size_t p_size = __builtin_object_size(p, 1);
>   
> -	if (__builtin_constant_p(size) && p_size < size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__write_overflow();
>   	if (p_size < size)
>   		fortify_panic(__func__);
> @@ -224,7 +230,7 @@ __FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, s
>   	 * If size can be known at compile time and is greater than
>   	 * p_size, generate a compile time write overflow error.
>   	 */
> -	if (__builtin_constant_p(size) && size > p_size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__write_overflow();
>   
>   	/*
> @@ -281,15 +287,16 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
>   		/*
>   		 * Length argument is a constant expression, so we
>   		 * can perform compile-time bounds checking where
> -		 * buffer sizes are known.
> +		 * buffer sizes are also known at compile time.
>   		 */
>   
>   		/* Error when size is larger than enclosing struct. */
> -		if (p_size > p_size_field && p_size < size)
> +		if (__compiletime_lessthan(p_size_field, p_size) &&
> +		    __compiletime_lessthan(p_size, size))
>   			__write_overflow();
>   
>   		/* Warn when write size is larger than dest field. */
> -		if (p_size_field < size)
> +		if (__compiletime_lessthan(p_size_field, size))
>   			__write_overflow_field(p_size_field, size);
>   	}
>   	/*
> @@ -365,25 +372,28 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>   		/*
>   		 * Length argument is a constant expression, so we
>   		 * can perform compile-time bounds checking where
> -		 * buffer sizes are known.
> +		 * buffer sizes are also known at compile time.
>   		 */
>   
>   		/* Error when size is larger than enclosing struct. */
> -		if (p_size > p_size_field && p_size < size)
> +		if (__compiletime_lessthan(p_size_field, p_size) &&
> +		    __compiletime_lessthan(p_size, size))
>   			__write_overflow();
> -		if (q_size > q_size_field && q_size < size)
> +		if (__compiletime_lessthan(q_size_field, q_size) &&
> +		    __compiletime_lessthan(q_size, size))
>   			__read_overflow2();
>   
>   		/* Warn when write size argument larger than dest field. */
> -		if (p_size_field < size)
> +		if (__compiletime_lessthan(p_size_field, size))
>   			__write_overflow_field(p_size_field, size);
>   		/*
>   		 * Warn for source field over-read when building with W=1
>   		 * or when an over-write happened, so both can be fixed at
>   		 * the same time.
>   		 */
> -		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
> -		    q_size_field < size)
> +		if ((IS_ENABLED(KBUILD_EXTRA_WARN1) ||
> +		     __compiletime_lessthan(p_size_field, size)) &&
> +		    __compiletime_lessthan(q_size_field, size))
>   			__read_overflow2_field(q_size_field, size);
>   	}
>   	/*
> @@ -494,7 +504,7 @@ __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
>   {
>   	size_t p_size = __builtin_object_size(p, 0);
>   
> -	if (__builtin_constant_p(size) && p_size < size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__read_overflow();
>   	if (p_size < size)
>   		fortify_panic(__func__);
> @@ -508,9 +518,9 @@ int memcmp(const void * const POS0 p, const void * const POS0 q, __kernel_size_t
>   	size_t q_size = __builtin_object_size(q, 0);
>   
>   	if (__builtin_constant_p(size)) {
> -		if (p_size < size)
> +		if (__compiletime_lessthan(p_size, size))
>   			__read_overflow();
> -		if (q_size < size)
> +		if (__compiletime_lessthan(q_size, size))
>   			__read_overflow2();
>   	}
>   	if (p_size < size || q_size < size)
> @@ -523,7 +533,7 @@ void *memchr(const void * const POS0 p, int c, __kernel_size_t size)
>   {
>   	size_t p_size = __builtin_object_size(p, 0);
>   
> -	if (__builtin_constant_p(size) && p_size < size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__read_overflow();
>   	if (p_size < size)
>   		fortify_panic(__func__);
> @@ -535,7 +545,7 @@ __FORTIFY_INLINE void *memchr_inv(const void * const POS0 p, int c, size_t size)
>   {
>   	size_t p_size = __builtin_object_size(p, 0);
>   
> -	if (__builtin_constant_p(size) && p_size < size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__read_overflow();
>   	if (p_size < size)
>   		fortify_panic(__func__);
> @@ -547,7 +557,7 @@ __FORTIFY_INLINE void *kmemdup(const void * const POS0 p, size_t size, gfp_t gfp
>   {
>   	size_t p_size = __builtin_object_size(p, 0);
>   
> -	if (__builtin_constant_p(size) && p_size < size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__read_overflow();
>   	if (p_size < size)
>   		fortify_panic(__func__);
> @@ -563,11 +573,13 @@ char *strcpy(char * const POS p, const char * const POS q)
>   	size_t size;
>   
>   	/* If neither buffer size is known, immediately give up. */
> -	if (p_size == SIZE_MAX && q_size == SIZE_MAX)
> +	if (__builtin_constant_p(p_size) &&
> +	    __builtin_constant_p(q_size) &&
> +	    p_size == SIZE_MAX && q_size == SIZE_MAX)
>   		return __underlying_strcpy(p, q);
>   	size = strlen(q) + 1;
>   	/* Compile-time check for const size overflow. */
> -	if (__builtin_constant_p(size) && p_size < size)
> +	if (__compiletime_lessthan(p_size, size))
>   		__write_overflow();
>   	/* Run-time check for dynamic size overflow. */
>   	if (p_size < size)
