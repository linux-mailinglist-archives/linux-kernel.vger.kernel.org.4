Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93EF6376EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKXK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKXK5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:57:13 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814C4840B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:57:12 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v28so1317545pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvR5jjAQ32QrpwiKXRFx0nsQpDhgkCSnhCfnlCZrw8c=;
        b=Wt6hrqGpXslJn3dEbv8BymwvP+VI2XLUb9ku4DeGKq5iPG6tvu2eeNGM2v19yYxZXK
         2iRnR7/jW1ANAb4yTmd1xxYGCbojc9uaB4EyDb+7msZO5ciVsPX8KaEtiMImXEuB575P
         EvK04nIJoHOWmIkM4fg5vHxRr89C0WSBB+4qsb57cIuudRRGfwtytv8DdDGufjPLRI95
         MYHi3IHE+zkQ6tYCFbOB5HTfStJyBDWh05kT39T+0XrdQkiVodFxX0Nw/bmbWzem4FjR
         5zpjg4uGJAn+5G8dND+4BdxAo+OC4ytYQfKYo5L2rq9w3u82tLTrrW+tMMZ/5gChi15/
         HdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvR5jjAQ32QrpwiKXRFx0nsQpDhgkCSnhCfnlCZrw8c=;
        b=mx2yktvkvk7epw5TBZvbRRYbOi42GuwqEr8c9/S8FRIAhKhCmr4Q5rCvm+6/C/RJlv
         7OCgOyRU/ihIq/v6WHTCCt+JkslL64ekKUc+Ur+n6QPYYWHFTwEyA5H++UvjqpiDJ3j0
         wNblA/Tpxjl3MNQpzMRcENQu0yflo+2HvtPTbU8yD6U2pRAwZ3OOVxMMXdyPlmPI7xrE
         SL+MFfVJpoU8I4zG/FjiIqJnOSJ6WQxWWcpoJ7WESQ8XM/PuC8RLxblZcOzu0RazPLlJ
         Dn+2mQcCr6/4pZNSdUNJfGybyleYwbhKb/ZuYBdZqzNTfOM79tsAK7Uk2Cp25MpY3/sq
         nv5w==
X-Gm-Message-State: ANoB5pmmwQfMkifsBdVcTPKeuuFflZQfq/oDOQVgu4QwB8TNjZwq9gyk
        C3l+8w1bAVvDW1xoXqP9+bs=
X-Google-Smtp-Source: AA0mqf6D82FN1B5B23pjKABFefH7BTG3GceAoR8ZpAUG4D18G+QXjdKVYpNq9NM9NhJrNfj8+fqa6A==
X-Received: by 2002:a62:54c2:0:b0:56b:fb4f:3d7c with SMTP id i185-20020a6254c2000000b0056bfb4f3d7cmr34951232pfb.54.1669287432162;
        Thu, 24 Nov 2022 02:57:12 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id c4-20020a17090a674400b002189ab866bfsm2956687pjm.5.2022.11.24.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 02:57:11 -0800 (PST)
Date:   Thu, 24 Nov 2022 19:57:04 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 1/2] mm/slb: add is_kmalloc_cache() helper
 function
Message-ID: <Y39OAFcm6svORad4@hyeyoo>
References: <20221123123159.2325763-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123123159.2325763-1-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:31:58PM +0800, Feng Tang wrote:
> commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
> kmalloc") introduces 'SLAB_KMALLOC' bit specifying whether a
> kmem_cache is a kmalloc cache for slab/slub (slob doesn't have
> dedicated kmalloc caches).
> 
> Add a helper inline function for other components like kasan to
> simplify code.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> changlog:
>   
>   since v1:
>   * don't use macro for the helper (Andrew Morton)
>   * place the inline function in mm/slb.h to solve data structure
>     definition issue (Vlastimil Babka)
> 
>  mm/slab.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index e3b3231af742..0d72fd62751a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -325,6 +325,14 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  }
>  #endif
>  
> +static inline bool is_kmalloc_cache(struct kmem_cache *s)
> +{
> +#ifndef CONFIG_SLOB
> +	return (s->flags & SLAB_KMALLOC);
> +#else
> +	return false;
> +#endif
> +}
>  
>  /* Legal flag mask for kmem_cache_create(), for various configurations */
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> -- 
> 2.34.1

With Vlastimil's comment:

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
