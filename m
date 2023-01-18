Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DD67297C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjARUdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjARUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:32:22 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FF75F3A5;
        Wed, 18 Jan 2023 12:32:19 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1442977d77dso260743fac.6;
        Wed, 18 Jan 2023 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5afsl4HoXzkYc7n5OJf2Nf55ZwHbUkKJOhGaeA31CE=;
        b=XuCuphEn7vFAiIWMWcu9wpU1F4dt5pvxpSOX4tyHZkdtFxAj1euR95IHhPJN+QSXuf
         lHPwKMqBf3jTsDvaIzmUk4qsGojr2ozVW0G9iwM17F/dSx3FmMV5duSS8AZGPlcj8bQG
         5pE8ds32biAlArhdO853TV+HzP5njFuYWBCUhCksjihkIw4jjNepZEX76YWAv9vMjEFG
         GoVzpaNYiRCRFwx0JtcqbWGebRuTv6AfGuNlgCANBsxm25svnnW1MF9BckHpWj0tf6Dl
         1TWptxyAOez8ts/6WH3jkj15HGJLYL+ZofU4XtzrPEaaaLdD5etFjFR3sDYa284nTSom
         YaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5afsl4HoXzkYc7n5OJf2Nf55ZwHbUkKJOhGaeA31CE=;
        b=nqsyxN6VIINxDLIuHESBcFcCwGFd4BguMqm474zBIPpnvEQU8eSOWUtrYM1toJw2Mu
         fgl2AV8AdBh+oZevt/aJXjztdoyt5DCN2u4ukdYiRZxPhIm1f13QtCeSwZ5ajQfpz+/C
         rnqZYeYtVddz5ySNxYf7605JuvRF893p0DNw4uobRAyPGtJ5GzlKV2zrwGSPrs+70mJE
         eDd372CjkHIbhnfYOrWBTz7e6owP1oo/+/rWfpHFZBoSykdwB1/qSfyy/jqTvc1iPyKl
         Jlphj5UFc85xcpVDkNy3SAi9qUguxeFH/LUgYVzRWx1RPrF+SR5B/ONaPe0VRYBSDNgw
         k30A==
X-Gm-Message-State: AFqh2kqrR0eL9OHFi1g93vF4UnvPRE4ny/Vjqele7jrTgWBSPoqftlop
        IAFZEYvoDJOted99Kv2CvS4=
X-Google-Smtp-Source: AMrXdXvt+1GIPyEwKgECbtF7dcEmoIOyuNWdQSfnYEUhAf+veKcW+sCfnGtJYmoWZi9Btv7HXPX6kw==
X-Received: by 2002:a05:6870:e0ce:b0:15f:3bb9:7b3d with SMTP id a14-20020a056870e0ce00b0015f3bb97b3dmr5169475oab.28.1674073939147;
        Wed, 18 Jan 2023 12:32:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i8-20020a056870344800b0013b92b3ac64sm18772149oah.3.2023.01.18.12.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 12:32:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 18 Jan 2023 12:32:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
Message-ID: <20230118203216.GA987351@roeck-us.net>
References: <20230118200653.give.574-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118200653.give.574-kees@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:06:54PM -0800, Kees Cook wrote:
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
> v3: fix defaults, avoid redundant returns.
> v2: https://lore.kernel.org/all/20230114005408.never.756-kees@kernel.org/
> v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
> ---
>  lib/Kconfig.debug  | 9 +++++++++
>  lib/memcpy_kunit.c | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 881c3f84e88a..149d6403b8a9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2566,6 +2566,15 @@ config MEMCPY_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config MEMCPY_SLOW_KUNIT_TEST
> +	bool "Include exhaustive memcpy tests"
> +	depends on MEMCPY_KUNIT_TEST
> +	default y
> +	help
> +	  Some memcpy tests are quite exhaustive in checking for overlaps
> +	  and bit ranges. These can be very slow, so they are split out
> +	  as a separate config, in case they need to be disabled.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>  	tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..90f3aa9e909f 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -309,6 +309,8 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>  
>  static void init_large(struct kunit *test)
>  {
> +	if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST))
> +		kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
>  
>  	/* Get many bit patterns. */
>  	get_random_bytes(large_src, ARRAY_SIZE(large_src));
> @@ -327,6 +329,7 @@ static void init_large(struct kunit *test)
>   */
>  static void copy_large_test(struct kunit *test, bool use_memmove)
>  {
> +

Some whitespace noise slipped in here.

Guenter

>  	init_large(test);
>  
>  	/* Copy a growing number of non-overlapping bytes ... */
> -- 
> 2.34.1
> 
