Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1276ED262
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjDXQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:24:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286365B95
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:24:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5286311be47so335891a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682353493; x=1684945493;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ec5rnpGl1sXrFHB3DIjsS4ZKrDnQgNacloNoA+YyYQ=;
        b=D7tq8Eaw7vA261Dwg/q4yomzdKYnXO1D3Uf59Xit37qeJm8PqkSOa/YnIiTewUASGN
         e9jxzSRVPK4XvKgzMAQpi0LuRTQ5uuheqgXAVyod/IXkvK0y+sjZDodcqdtSNOdOcZWQ
         kI8Z8G0DTJ/TMko5t6YarnKvu0P+qh/GeUW40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353493; x=1684945493;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ec5rnpGl1sXrFHB3DIjsS4ZKrDnQgNacloNoA+YyYQ=;
        b=VfZDvCsJm7zxT4XETNxND1afuBolyIgxWZ3FtU8WpkwLocC7xG/msDjrKRIUCIxwmZ
         hY5AIJDb2FZIurSxvEJSk/LSHnR+vpDE6vkyuIwtL1usnkIyAba6TSnU9pRS8PfCnk85
         fLC+FZQgPvvZjeUMr+my8zsbbqEhzZLWbPA5a0DMGB0y0MVeGJRMz+xnkJuMv2XR8AOK
         peMNJ+QhAVguIDjlHdXp1x00+BdcWUCIOoqJwmQyM6aHS4wDpT1348GVbBvLNCAQckra
         i4n+6HmopOt9CsEe+lcorjBmLbTW6gcD+EnxiCAgNAnycChi8CJMmL1tUj6VxsU+ACxY
         iKPA==
X-Gm-Message-State: AAQBX9eM0u/XObPVgbO6PRg0/7ELrJY5FUFYyIsL9V3hk5LD7LY3GLiy
        1OpPciXry3LD5S2Jhi1vdNphSg==
X-Google-Smtp-Source: AKy350aKTqSXh6yHEIq6KpoXi00j0ZgJNGRkl4/Lr67APjoo2sYoexotse6/Dw5Srs51ftzpuR3luQ==
X-Received: by 2002:a17:90a:4e07:b0:247:19ac:9670 with SMTP id n7-20020a17090a4e0700b0024719ac9670mr13749994pjh.26.1682353493627;
        Mon, 24 Apr 2023 09:24:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090a67c900b002465ff5d829sm6599949pjm.13.2023.04.24.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:24:53 -0700 (PDT)
Message-ID: <6446ad55.170a0220.c82cd.cedc@mx.google.com>
X-Google-Original-Message-ID: <202304240922.@keescook>
Date:   Mon, 24 Apr 2023 09:24:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, andy@kernel.org,
        ndesaulniers@google.com, nathan@kernel.org
Subject: Re: [PATCH] string: use __builtin_memcpy() in strlcpy/strlcat
References: <20230424112313.3408363-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424112313.3408363-1-glider@google.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 01:23:13PM +0200, Alexander Potapenko wrote:
> lib/string.c is built with -ffreestanding, which prevents the compiler
> from replacing certain functions with calls to their library versions.
> 
> On the other hand, this also prevents Clang and GCC from instrumenting
> calls to memcpy() when building with KASAN, KCSAN or KMSAN:
>  - KASAN normally replaces memcpy() with __asan_memcpy() with the
>    additional cc-param,asan-kernel-mem-intrinsic-prefix=1;
>  - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
>    __msan_memcpy() by default.
> 
> To let the tools catch memory accesses from strlcpy/strlcat, replace
> the calls to memcpy() with __builtin_memcpy(), which KASAN, KCSAN and
> KMSAN are able to replace even in -ffreestanding mode.
> 
> This preserves the behavior in normal builds (__builtin_memcpy() ends up
> being replaced with memcpy()), and does not introduce new instrumentation
> in unwanted places, as strlcpy/strlcat are already instrumented.
> 
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.com/
> ---
>  lib/string.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/string.c b/lib/string.c
> index 3d55ef8901068..be26623953d2e 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -110,7 +110,7 @@ size_t strlcpy(char *dest, const char *src, size_t size)
>  
>  	if (size) {
>  		size_t len = (ret >= size) ? size - 1 : ret;
> -		memcpy(dest, src, len);
> +		__builtin_memcpy(dest, src, len);
>  		dest[len] = '\0';
>  	}
>  	return ret;
> @@ -260,7 +260,7 @@ size_t strlcat(char *dest, const char *src, size_t count)
>  	count -= dsize;
>  	if (len >= count)
>  		len = count-1;
> -	memcpy(dest, src, len);
> +	__builtin_memcpy(dest, src, len);
>  	dest[len] = 0;
>  	return res;

I *think* this isn't a problem for CONFIG_FORTIFY, since these will be
replaced and checked separately -- but it still seems strange that you
need to explicitly use __builtin_memcpy.

Does this end up changing fortify coverage?

-- 
Kees Cook
