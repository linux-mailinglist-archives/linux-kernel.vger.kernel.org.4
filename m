Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297266A7D2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjANA6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjANA6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:58:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48C8B513
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:58:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w3so25088917ply.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 16:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPFbP44ux+TqG8PMsp6CRRulsUlYZh39NEbSaw7nJ5c=;
        b=hm+r1mS6+fqccO2GQAeVS4l0gIFcR0H3jfO5ihyKL2etM3WuuJ2DDzUg7B3WBu+P8t
         NxbV1YHotNDA/loMYN0jhFKTXfoQqMD8bguZjP0xYtiAo+pst+7Zmcrf9yH9t3i5p5nm
         sZBKV4vTqdxBZhyAc5/L6QT98rnAAB6wOlcWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPFbP44ux+TqG8PMsp6CRRulsUlYZh39NEbSaw7nJ5c=;
        b=KpobWMZakjbteWrPorOA5Hyl6B5U6J7/KZBn//J+98VbrHM1Y3UnmsugAWDpcgxwOY
         l9tZCkCpYLfWxaazXLNkhO8L6vUWj5rFtJZ7TJ4hBDF/cO6gNGZinDCwUrRp4m63LiGR
         SHJvhQ92bs593LpRCFmfMOq64mB+OwfWVxCVUhmKLjm1Gt+7oM7gvhUew+V9biIwaxhx
         KKY5TPPmET3H9K3nG2u9W9lXSegfX0cLrUbp8hR+zep85tMBGoIJ3jIteNhE/RRbLYFG
         vLLToxx7oPYgEVEdXBxJ8Y1pqTlIDrS++VuM0X1C9Pfr+uagqh/L8Wvs39rJcdXMXiF8
         yGWA==
X-Gm-Message-State: AFqh2kogUJKdalPCgMy2WD1tVQgdYCzS7x1f/DAaXTtlxpwJsNWOZ307
        C8QP5gev+LOJBnXlPyu7wp94XQ==
X-Google-Smtp-Source: AMrXdXvcJyeiseIZjdDSYqOnTl8gsdgnikVxMhIW2m1z0x2X1Cy1B8xQ/7WsSxob7IGFomU88LIZcw==
X-Received: by 2002:a17:90b:110a:b0:223:b920:28df with SMTP id gi10-20020a17090b110a00b00223b92028dfmr84499976pjb.29.1673657880624;
        Fri, 13 Jan 2023 16:58:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nh21-20020a17090b365500b0022932d12de1sm1310863pjb.46.2023.01.13.16.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:58:00 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:57:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Daniel Latypov <dlatypov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
Message-ID: <202301131657.8E076628@keescook>
References: <20230114005408.never.756-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114005408.never.756-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gah. this is actually v2. :(

On Fri, Jan 13, 2023 at 04:54:12PM -0800, Kees Cook wrote:
> Since the long memcpy tests may stall a system for tens of seconds
> in virtualized architecture environments, split those tests off under
> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: fix tristate to bool
> v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
> ---
>  lib/Kconfig.debug  |  9 +++++++++
>  lib/memcpy_kunit.c | 15 ++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2c78d0e761c..f90637171453 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config MEMCPY_SLOW_KUNIT_TEST
> +	bool "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS
> +	depends on MEMCPY_KUNIT_TEST
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Some memcpy tests are quite exhaustive in checking for overlaps
> +	  and bit ranges. These can be very slow, so they are split out
> +	  as a separate config.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>  	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..5a545e1b5dbb 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>  	}
>  }
>  
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +		return -EBUSY;
> +	}
>  
>  	/* Get many bit patterns. */
>  	get_random_bytes(large_src, ARRAY_SIZE(large_src));
> @@ -319,6 +323,8 @@ static void init_large(struct kunit *test)
>  
>  	/* Explicitly zero the entire destination. */
>  	memset(large_dst, 0, ARRAY_SIZE(large_dst));
> +
> +	return 0;
>  }
>  
>  /*
> @@ -327,7 +333,9 @@ static void init_large(struct kunit *test)
>   */
>  static void copy_large_test(struct kunit *test, bool use_memmove)
>  {
> -	init_large(test);
> +
> +	if (init_large(test))
> +		return;
>  
>  	/* Copy a growing number of non-overlapping bytes ... */
>  	for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
> @@ -472,7 +480,8 @@ static void memmove_overlap_test(struct kunit *test)
>  	static const int bytes_start = 1;
>  	static const int bytes_end = ARRAY_SIZE(large_src) + 1;
>  
> -	init_large(test);
> +	if (init_large(test))
> +		return;
>  
>  	/* Copy a growing number of overlapping bytes ... */
>  	for (int bytes = bytes_start; bytes < bytes_end;
> -- 
> 2.34.1
> 

-- 
Kees Cook
