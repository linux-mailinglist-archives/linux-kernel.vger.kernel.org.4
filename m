Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB125EF19C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiI2JPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiI2JOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:14:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2043B85D;
        Thu, 29 Sep 2022 02:14:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E51421CB1;
        Thu, 29 Sep 2022 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664442888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1u8z4WmR9zvDM9UGZ0h0jsxTnAaUNDEIhFM4nyq/PM=;
        b=pSTH0nuXGokqjtwOc1Njlcdjqhl3KZN82uo0aaMtdAnQh9KDLOmHiHAMvFBOLV4PYjbuRO
        aL16iAi4Oc3JoQkx7iay2MszmfEjL9ZHcesPa/FCL8X/pZBlLC2riFRgV9XH/shGsSOT6O
        2362irwz5VzSGBz2DCZ73j+c+pWIAvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664442888;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1u8z4WmR9zvDM9UGZ0h0jsxTnAaUNDEIhFM4nyq/PM=;
        b=6BtohXscIn2X7OHJ3UG1L7/Pz/2sL4WtXKuVPUfV03r1kEuJZnKjhOIxIVOSPC5oSsvxFM
        LTlIDKMHwrMXJVDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1996A1348E;
        Thu, 29 Sep 2022 09:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Aq94BQhiNWOpMAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Sep 2022 09:14:48 +0000
Message-ID: <0eb638e3-b9ac-6dec-6881-b885c7874b45@suse.cz>
Date:   Thu, 29 Sep 2022 11:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] compiler_types.h: Test for __alloc_size__ again
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Marco Elver <elver@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220929081642.1932200-1-keescook@chromium.org>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220929081642.1932200-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 10:16, Kees Cook wrote:
> While the "alloc_size" attribute is available on all GCC versions, I
> forgot that it gets disabled explicitly by the kernel in GCC < 9.1 due
> to misbehaviors. Add a note to the compiler_attributes.h entry for it,
> and restore the #ifdef in compiler_types.h.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Marco Elver <elver@google.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/CAMuHMdXK+UN1YVZm9DenuXAM8hZRUZJwp=SXsueP7sWiVU3a9A@mail.gmail.com
> Fixes: 63caa04ec60583b1 ("slab: Remove __malloc attribute from realloc functions")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks, I decided to late squash it so we don't needlessly cause issues for
people doing bisections with gcc-8 later.

> ---
> I swear I sent this earlier today, but I don't see it on lore still. Resending,
> so apologies if this is a duplicate.
> ---
>  include/linux/compiler_attributes.h | 3 ++-
>  include/linux/compiler_types.h      | 9 +++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 465be5f072ff..55fbb6091ecf 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -65,7 +65,8 @@
>  
>  /*
>   * Note: do not use this directly. Instead, use __alloc_size() since it is conditionally
> - * available and includes other attributes.
> + * available and includes other attributes. For GCC < 9.1, __alloc_size__ gets undefined
> + * in compiler-gcc.h, due to misbehaviors.
>   *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alloc_005fsize-function-attribute
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#alloc-size
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index f141a6f6b9f6..0717534f8364 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -275,8 +275,13 @@ struct ftrace_likely_data {
>   * be performing a _reallocation_, as that may alias the existing pointer.
>   * For these, use __realloc_size().
>   */
> -#define __alloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__) __malloc
> -#define __realloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__)
> +#ifdef __alloc_size__
> +# define __alloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__) __malloc
> +# define __realloc_size(x, ...)	__alloc_size__(x, ## __VA_ARGS__)
> +#else
> +# define __alloc_size(x, ...)	__malloc
> +# define __realloc_size(x, ...)
> +#endif
>  
>  #ifndef asm_volatile_goto
>  #define asm_volatile_goto(x...) asm goto(x)

