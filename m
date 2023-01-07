Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB6660C70
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 05:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjAGEg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 23:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 23:36:53 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B948461D;
        Fri,  6 Jan 2023 20:36:52 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-150debe2b7cso3774394fac.0;
        Fri, 06 Jan 2023 20:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/dKals/u5D+/6Pld/lkPkgV1DxDZq2eowycP708Hyc=;
        b=fYcDjhoqIkZoXzyZl/4BX18B0uT7l1EqaMeTAhKox62aR/ITgJ/WadedH3NH/BokFT
         /2t3GiR9ec+b+IJoupvxln9tUsSabZfQTE236t9IAbjZ77HB72df6o/dZnTmzx41e9k1
         Lsh39X7xQbw3TXjcAMWwf5ULlJFX9y7Sgv0Jc6/B7+p4m6kwXzjnWpgGfPIclusfhFCD
         vZ3lNqJgwIfTxuNPCo/eWkW4kUNWCyudbkSLwB9TnZb8AovsLgY8dM76/DWsDGuTY94J
         LV0xmX3vEV2YsmWkLjrRIL5qVZgzWuLFrju5obyvQo4KcLj2jmD1XESQWBlNBc3A/6Rx
         rv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/dKals/u5D+/6Pld/lkPkgV1DxDZq2eowycP708Hyc=;
        b=s1nnIiRMl9k49RZ5KQTpVTTAME0H+pArXx2+RWnISwFaSSS/y9UIVrkOAyZeI7wJel
         VSaKEda1oia19O2fL2NIQA0M6X5w7nQw02J/B05P6tUEnXtf0L4VPbWcMmP6d6vqanW4
         0/N0+atGhfp08bzIEzxpMIIxaYcgF84Y+Qmqwd4goHpHFWoRaULU7Y/lA5/6AK45G2Ih
         1PO+p6VgBPmSjSp8JNcmsDgP54BM/po1KhinixjIDPVIRJGg0oDavzaroCl32ldFHkCy
         oybZQbwsFTxwIQn4LuFhZTotaj+drNi4Y+2HDCryIOHGGNCg7ZaIY6kFhMb+I7bmnYEO
         3AHA==
X-Gm-Message-State: AFqh2kqLkJOPdmFy51UT15JoHqOIDYri49iDy1mj4Spd4wtkuiH8oTTW
        DfrRIBz4QV0CrANUyYf91EA=
X-Google-Smtp-Source: AMrXdXs2UMAwXRmnln7Rz3Uk4aTGJ01ih6jlqapJU6F0D4hBZjzBrG4Zm/Sq/y7M+4OLMeSCXTmQcg==
X-Received: by 2002:a05:6870:8294:b0:157:ded4:d8f6 with SMTP id q20-20020a056870829400b00157ded4d8f6mr504124oae.40.1673066209842;
        Fri, 06 Jan 2023 20:36:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6-20020a4ad646000000b004d89527a54bsm1260578oos.20.2023.01.06.20.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 20:36:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 6 Jan 2023 20:36:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
Message-ID: <20230107043647.GA605829@roeck-us.net>
References: <20230107040203.never.112-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107040203.never.112-kees@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 08:02:07PM -0800, Kees Cook wrote:
> Since the long memcpy tests may stall a system for tens of seconds
> in virtualized architecture environments, split those tests off under
> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Guenter, does this give you the needed flexibility to turn on the memcpy
> kunit tests again in your slower environments?

I'll be traveling this weekend. Give me until early next week to give
it a try.

Thanks,
Guenter

> ---
>  lib/Kconfig.debug  |  9 +++++++++
>  lib/memcpy_kunit.c | 17 +++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2c78d0e761c..b5e94807f41c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config MEMCPY_SLOW_KUNIT_TEST
> +	tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS
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
> index 89128551448d..cc1f36335a9b 100644
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
> @@ -549,8 +558,8 @@ static void strtomem_test(struct kunit *test)
>  static struct kunit_case memcpy_test_cases[] = {
>  	KUNIT_CASE(memset_test),
>  	KUNIT_CASE(memcpy_test),
> -	KUNIT_CASE(memcpy_large_test),
>  	KUNIT_CASE(memmove_test),
> +	KUNIT_CASE(memcpy_large_test),
>  	KUNIT_CASE(memmove_large_test),
>  	KUNIT_CASE(memmove_overlap_test),
>  	KUNIT_CASE(strtomem_test),
> -- 
> 2.34.1
> 
