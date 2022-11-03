Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77C7617DF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKCNcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:32:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC8C635D;
        Thu,  3 Nov 2022 06:32:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so1600300pfh.6;
        Thu, 03 Nov 2022 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opwfbW0762ODyDc7uXtbMZOYVw4Y0uBaxSM8z+IHWTE=;
        b=pBEvOPt8RqH/Q7RQT7xTZBt7qG/22c6e0IXqun2iUIkaf09m62O6gBpaECjyRKx0te
         V4kaEbd3mx28yQpCm/IclIHtbJwyNpGOdZCRR3vHVgq+Tfh8XfLgDyqXspnNjy33+Geb
         Eqqnpl/2OC76Q3TTmyTDd1edUwehiBhkAMpcn4iwFDJtIrXl3kbK+ktQ2lDSi7N1F/+B
         qatWJGBwIH1/vZASQF7Oi1CkQ1/BUr4ajPUznBW3Kjke0pPrRKHuODemY2XydnCNR0fM
         2CzYV8sq/LZGGwEecTgQXHitJQxaHi/wPAd8b2U6CK2bu2VnnYN0CKBassB2KzobsF1Z
         6KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opwfbW0762ODyDc7uXtbMZOYVw4Y0uBaxSM8z+IHWTE=;
        b=zCcRFZY7o6txRIiF55AwRrSi58eUbY4EIXQp6/RY4dApmF06dRhmpw2+gouOhu5NJH
         S8jpdSldYxg3WoSwo7CTNg01y2TA4pYP478t+CeLjUIjjFLtQZXtHZpdnBCCtvzTFuQA
         mQbsQNdFJFBtRXWg27ccHD9uCdcv4NhrnvHU/uDtL3aLIGHf9OFOMqChzW98YySGG8nb
         NBP0tmt39Hmzoh7cz5mkbZ9wciu0EQRx48XPcjS4PNyu5HIG7U3leaiA6vf+VRudn14Y
         2e3jx0qHMMBWR5Dwzn5f2W7LPEwkViBlcZAw5kXNG4tBBgaypZ5Ir4ZpD2G01hQN8evs
         9M8w==
X-Gm-Message-State: ACrzQf3sJ7TaiX5OTITihZLDLDKY9412I5Orl0KDZZfQ0MIpK4I2R4p3
        MY0CePPS0hkdjg0rDJ0OjR4=
X-Google-Smtp-Source: AMsMyM4x2PHt1DutjHxdBXGcFzCyFqfybLisdTBbqdK9sJ87ldXvyLGv53ZB/Co/v1POBSzAH437Wg==
X-Received: by 2002:a63:5853:0:b0:46f:fdfc:a651 with SMTP id i19-20020a635853000000b0046ffdfca651mr9429044pgm.385.1667482368756;
        Thu, 03 Nov 2022 06:32:48 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id y133-20020a62ce8b000000b00565cbad9616sm770509pfg.6.2022.11.03.06.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:32:47 -0700 (PDT)
Date:   Thu, 3 Nov 2022 22:32:38 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        David Gow <davidgow@google.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/6] slab: Clean up SLOB vs kmalloc() definition
Message-ID: <Y2PC9tz6OyU8yYtu@hyeyoo>
References: <20221101222520.never.109-kees@kernel.org>
 <20221101223321.1326815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101223321.1326815-1-keescook@chromium.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:33:09PM -0700, Kees Cook wrote:
> As already done for kmalloc_node(), clean up the #ifdef usage in the
> definition of kmalloc() so that the SLOB-only version is an entirely
> separate and much more readable function.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/slab.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 90877fcde70b..e08fe7978b5c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -559,15 +559,15 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node) __assume_page_align
>   *	Try really hard to succeed the allocation but fail
>   *	eventually.
>   */
> +#ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  {
>  	if (__builtin_constant_p(size)) {
> -#ifndef CONFIG_SLOB
>  		unsigned int index;
> -#endif
> +
>  		if (size > KMALLOC_MAX_CACHE_SIZE)
>  			return kmalloc_large(size, flags);
> -#ifndef CONFIG_SLOB
> +
>  		index = kmalloc_index(size);
>  
>  		if (!index)
> @@ -576,10 +576,18 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
>  		return kmalloc_trace(
>  				kmalloc_caches[kmalloc_type(flags)][index],
>  				flags, size);
> -#endif
>  	}
>  	return __kmalloc(size, flags);
>  }
> +#else
> +static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
> +{
> +	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
> +		return kmalloc_large(size, flags);
> +
> +	return __kmalloc(size, flags);
> +}
> +#endif
>  
>  #ifndef CONFIG_SLOB
>  static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
> -- 
> 2.34.1

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
