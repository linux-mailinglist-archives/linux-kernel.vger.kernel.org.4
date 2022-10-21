Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE96080B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJUVUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJUVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04AA10A0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53C7461F74
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A580C433D6;
        Fri, 21 Oct 2022 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387151;
        bh=0ym+deWNf8WHQjZMGt7fR33IbFBn/5C/Mfi6MMKG+wY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXZQxGO6ABpjSB/rCLtr+y4VAvY8vaEJuB0ZbDnqaG32/01ySyCIa4kH882hMG5Wa
         qv9boYmR/mlmTRp+k3lyGb+jy23gqXkbhQwKgMiopF0bF43btT5RTt8zdsN4UJbHiR
         PRZr2c4OrUNVwLUZAiK3fxWf9Dakf4ylH/YbIi4eMtnVYYDXe89K84FXHbSF7fPK83
         gQbh27vCmB+XPBThhf83cnpwI652JH//w6dzVpT9qriZ6/fZL12UJacAregIXRzIET
         6JA3/jh/KHAiks1RXm6SqEuiyQDylnhzzGFnHQcSFq6aLCsyNgP9DRMit5HhskIpPX
         pWsA6Z3ytfcQg==
Date:   Fri, 21 Oct 2022 14:19:09 -0700
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
Subject: Re: [PATCH 4/5] compiler-gcc: remove attribute support check for
 `__no_sanitize_undefined__`
Message-ID: <Y1MMzWXsF6gSreuW@dev-arch.thelio-3990X>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-4-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-4-ojeda@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:55PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 4.9, while the minimum GCC version
> supported by the kernel is GCC 5.1.
> 
> Therefore, remove the check.
> 
> Link: https://godbolt.org/z/GrMeo6fYr
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-gcc.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index ba207deb77ca..7f2c2bb73815 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -90,11 +90,7 @@
>  #define __no_sanitize_thread
>  #endif
>  
> -#if __has_attribute(__no_sanitize_undefined__)
>  #define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
> -#else
> -#define __no_sanitize_undefined
> -#endif
>  
>  #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
>  #define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
> -- 
> 2.38.1
> 
> 
