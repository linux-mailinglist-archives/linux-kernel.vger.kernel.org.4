Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA10D6080B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJUVTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJUVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6E72A6840
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E11BF61F75
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 21:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6AF1C433D6;
        Fri, 21 Oct 2022 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387121;
        bh=2FFkvVZkTQ0PEfbYfPFvB9iZXcB1wpS7dr0mDk8aJ0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS6ib6/LIiPT2vSvTz+OGN+caOtzyRlmDcCxFXLZSeUGVvrI9ol4o0x26Oikuj8QQ
         c/aFCV0tQXJMgdmx2bOR2MIB/wFG2PDOBax4W0rFvOzD7mw41KzVgKAn5p2V+mXibU
         ONdB0wtmjqmA8LyoMEPsL839AcxvuemQXTgcMuEUX7ql4yAgyJ6pUDTc72xOpVxkFI
         JRTze+sz99w2x1Lfm9KINIOCGV1alx3u0tR3xgFy4pW5EOsu1OziriEuu/x6pTrGyS
         /BTurvNg1HbI2Vrx6UPaHbVkXg4E6L8h2arfqvA2HP/pAmQ+G1mPSDqhHtlgZS5IhK
         h3/MMzfaNgkhg==
Date:   Fri, 21 Oct 2022 14:18:38 -0700
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
Subject: Re: [PATCH 3/5] compiler-gcc: remove attribute support check for
 `__no_sanitize_thread__`
Message-ID: <Y1MMrhxFdYek3sIo@dev-arch.thelio-3990X>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-3-ojeda@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:54PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 5.1, which matches the minimum GCC version
> supported by the kernel.
> 
> Therefore, remove the check.
> 
> Link: https://godbolt.org/z/vbxKejxbx
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler-gcc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index bfce7f4d0978..ba207deb77ca 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -84,7 +84,7 @@
>  
>  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
>  
> -#if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
> +#if defined(__SANITIZE_THREAD__)
>  #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
>  #else
>  #define __no_sanitize_thread
> -- 
> 2.38.1
> 
> 
