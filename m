Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5596080A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJUVSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJUVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9387A2A4E24
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6C2561F8E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7D7C433D6;
        Fri, 21 Oct 2022 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387094;
        bh=lNMTqMjhK1y8wiMz79oWkjOtjdhIp9WkAVwBJUh/kaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hh8YtN8AxnWUGkIkwfNjdnp3qyCNqcD/fifW3dmMQ2+g/DJHBOuem4WYf1CENjENw
         fm9/pZlUuwvAZKnTb1ZGFo9fGjiNA8cJoN2LmQSSzwk91+wdWnpoSdS6bivUhAhuoR
         WPAaLexRQR9SrWLIHcEPeXOJdTmFcRUarNadK5KGL7P4P9tMPNaXs6CKVhpCSQeyPU
         pwp8qFuxO1qNaolj6HmLAovHhZrawy4I7nTg43t8XwEGHTEo7SkZNV2pjm3YO7tlUU
         MXiWTvq8Mhvdjz5NFjmtuQiLupn4BdbEWZcDloW4xOX/u6SPNvEVQjeLBljj+UftEa
         onMMxnqzse3qw==
Date:   Fri, 21 Oct 2022 14:18:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] compiler-gcc: remove attribute support check for
 `__no_sanitize_address__`
Message-ID: <Y1MMlE3A2Gdw599+@dev-arch.thelio-3990X>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-2-ojeda@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:53PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 4.8, while the minimum GCC version
> supported by the kernel is GCC 5.1.
> 
> Therefore, remove the check.
> 
> Link: https://godbolt.org/z/84v56vcn8
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-gcc.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index b9530d3515ac..bfce7f4d0978 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -82,11 +82,7 @@
>  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
>  
> -#if __has_attribute(__no_sanitize_address__)
>  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> -#else
> -#define __no_sanitize_address
> -#endif
>  
>  #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
>  #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
> -- 
> 2.38.1
> 
> 
