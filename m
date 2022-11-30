Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B29963D275
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiK3JvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiK3JvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:51:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE323E8D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:50:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 130so16309285pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCDpuFqBTHvf3fXps1nwbiUOUTIG5grHkE4dg45zXiU=;
        b=BrzfRiAIKgBCwf/1XbC9soyiaZFoKSujRTecLdpKHMQ6JT3GbuZ31zGFA16mTqSSrr
         AcbsaDC1n/l/b36aCiv23bUtWWab/DRNVtySMyVBBMLGJVSF+GnocEeNPY7FpUiwFlos
         J2T2JYnB7cihSiB+izdoW56np0eDooJ0hloGrDeM64hdZPGgyE8AbeTbcI0Cp+UlGyky
         w+kwU4fNc+UzCrvKYmDqX13xJFhTHwsj2FJsarqHOURnI9eE+tAryYe+9NGAZ+9S3F/A
         gAvA/04B0XDfFerVSA3xnyvSWIAuVY+h/9a1cwdgAOgpKUY8UhbGjfvvW1MfX51uW0wI
         D7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCDpuFqBTHvf3fXps1nwbiUOUTIG5grHkE4dg45zXiU=;
        b=SGPPyn27Jv/TTsbrcZucYn1tVCpiiQ4F5EFLA9lnZ2s9v6/mYoi/Zr+e1RBPXdg6ER
         /bDsUr9+y3q1vDryIZ/6HBfAGKcjs1RHUbA18oGrZzElvPtjW6HOJH9xf1FdBd3Mv416
         Uci6hq3SGG2FSJY4ZZEbl3h7UVJSgJfRhc5fisIjjY6zSutHe3yyaiIar/riV4Yqsgov
         oOG4yimNxE13T4qZh7sYPSm7iZPt8FjK/5NA8EKYG2eBpn0a44KzMbUr7OIRNVm8ySFX
         +AsGcGh0hKSTnVQ4971f0d5EkCz4zJhH/BlCJPTalokdksOXd1tw1pi2hG0UyhwX1rGA
         ij3w==
X-Gm-Message-State: ANoB5pmZKJTNUIO2rJZOEoFeR2bg0XAg8YF0X2vHceJCIWNt68GSEo5R
        CEdueW5noShWFUaJt4u4eJ4=
X-Google-Smtp-Source: AA0mqf5MZtBxwaQffNbvd9eCRCcJQb9bmhF7W+k86i7Gt4yWQkn/yUTu1QS9uGzNnbsZN7wiTW32BA==
X-Received: by 2002:a62:1586:0:b0:575:f08b:7a9f with SMTP id 128-20020a621586000000b00575f08b7a9fmr780206pfv.60.1669801858805;
        Wed, 30 Nov 2022 01:50:58 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b0017c19d7c89bsm960582plc.269.2022.11.30.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:50:57 -0800 (PST)
Date:   Wed, 30 Nov 2022 18:50:52 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
Message-ID: <Y4cnfE4n6b1koeR3@hyeyoo>
References: <20221130085451.3390992-1-feng.tang@intel.com>
 <20221130085451.3390992-2-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130085451.3390992-2-feng.tang@intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 04:54:51PM +0800, Feng Tang wrote:
> kmalloc redzone check for slub has been merged, and it's better to add
> a kunit case for it, which is inspired by a real-world case as described
> in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):
> 
> "
>   octeon-hcd will crash the kernel when SLOB is used. This usually happens
>   after the 18-byte control transfer when a device descriptor is read.
>   The DMA engine is always transferring full 32-bit words and if the
>   transfer is shorter, some random garbage appears after the buffer.
>   The problem is not visible with SLUB since it rounds up the allocations
>   to word boundary, and the extra bytes will go undetected.
> "
> 
> To avoid interrupting the normal functioning of kmalloc caches, a
> kmem_cache mimicing kmalloc cache is created with similar flags, and
> kmalloc_trace() is used to really test the orig_size and redzone setup.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
> 
>   since v2:
>     * only add SLAB_KMALLOC to SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTEDa,
>       and use new wrapper of cache creation(Vlastimil Babka)
> 
>   since v1:
>     * create a new cache mimicing kmalloc cache, reduce dependency
>       over global slub_debug setting (Vlastimil Babka)
> 
>  lib/slub_kunit.c | 22 ++++++++++++++++++++++
>  mm/slab.h        |  4 +++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 5b0c8e7eb6dc..ff24879e3afe 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -135,6 +135,27 @@ static void test_clobber_redzone_free(struct kunit *test)
>  	kmem_cache_destroy(s);
>  }
>  
> +static void test_kmalloc_redzone_access(struct kunit *test)
> +{
> +	struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_kmalloc", 32,
> +				SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE);
> +	u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
> +
> +	kasan_disable_current();
> +
> +	/* Suppress the -Warray-bounds warning */
> +	OPTIMIZER_HIDE_VAR(p);
> +	p[18] = 0xab;
> +	p[19] = 0xab;
> +
> +	kmem_cache_free(s, p);
> +	validate_slab_cache(s);
> +	KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +
> +	kasan_enable_current();
> +	kmem_cache_destroy(s);
> +}
> +
>  static int test_init(struct kunit *test)
>  {
>  	slab_errors = 0;
> @@ -154,6 +175,7 @@ static struct kunit_case test_cases[] = {
>  #endif
>  
>  	KUNIT_CASE(test_clobber_redzone_free),
> +	KUNIT_CASE(test_kmalloc_redzone_access),
>  	{}
>  };
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index c71590f3a22b..7cc432969945 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -344,7 +344,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  			  SLAB_ACCOUNT)
>  #elif defined(CONFIG_SLUB)
>  #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
> -			  SLAB_TEMPORARY | SLAB_ACCOUNT | SLAB_NO_USER_FLAGS)
> +			  SLAB_TEMPORARY | SLAB_ACCOUNT | \
> +			  SLAB_NO_USER_FLAGS | SLAB_KMALLOC)
>  #else
>  #define SLAB_CACHE_FLAGS (SLAB_NOLEAKTRACE)
>  #endif
> @@ -364,6 +365,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  			      SLAB_RECLAIM_ACCOUNT | \
>  			      SLAB_TEMPORARY | \
>  			      SLAB_ACCOUNT | \
> +			      SLAB_KMALLOC | \
>  			      SLAB_NO_USER_FLAGS)
>  
>  bool __kmem_cache_empty(struct kmem_cache *);
> -- 
> 2.34.1
> 

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
