Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1AF5B69EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIMIxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIMIxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:53:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C99A15A15
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:53:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so10698706pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4TPm3yDLRTUXMkcwAeJgiJwg94hbEBwyJGZBnuCnHu4=;
        b=R/7fEVh0ld47AI+yT4mpK9pSrSlHMlxfAe2/cVTTVBOpEIa4h4GNW+xXfhIzk3QTX+
         6Qlti3fMhSlMHd5FPjj1MFSvMzShflGSaoaJDomDDyPLN6ias0+5ctiuvSZyRtxdd6U3
         bVTG7ncvWs/FnrrnyPUAqKq8mfsYV40lfY8oIfdOn5TYX386djn8Uzp7brER/fDfPPWT
         wVEcmHHguOV00Tr+9cbxRBr+n0fCbPZzTRhadih2qoAIgpj3QLoUTUFec8BEVkRjOhsB
         eEbs1HrKHjukPKAakVy4LzfHc4vxPB/Qf+5ZqwaQsamDXkklSA8VbmeqDvCx6SXtl3hK
         F0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4TPm3yDLRTUXMkcwAeJgiJwg94hbEBwyJGZBnuCnHu4=;
        b=YVJZEobkZ2iI0DmFX5tuyGX203kPCmRNe+gwmsMgcrIHdxRdV9q5NY9gRh3o0xTfbx
         d8a0YJ/JHttsf3qjRq0PnQKoF3pc0A26jKGIDvhbTnfSBGLZbn0WnNALAbLPQIux0n5I
         yrMUQxqp5dFGaVI7vfm4GqFLNScqSNq2x5wCxuIg+jn7fTagzP6pOClB6OcUBqKzecFi
         teCBrZXSPmyTAid046VIh5pQQ/HxzFGKP9vw/RKtns5R9I57O7mklT3w+bUVQDiDv48z
         INgzeYwKo51ynB8PYAd9dI2vq6EQFJaHC4/9reixlzds9+kzEBHgFd3INAUwDDpFkPLY
         6AFQ==
X-Gm-Message-State: ACgBeo0hfKFHHwvASfLjnCRdM16c8sf5ICtgIvba5qe4D9d38mPgikr8
        IIPMSVpV+nlxu1P9P5M68M0=
X-Google-Smtp-Source: AA6agR7OkLp6prd6BnIGRKEsYjR4a4I4pGQbxWjkrYV9QYCSVPnFfcptq7+ntz6UTmplxN7h8tjqiQ==
X-Received: by 2002:a17:902:d48d:b0:178:306d:f75c with SMTP id c13-20020a170902d48d00b00178306df75cmr9442090plg.73.1663059212848;
        Tue, 13 Sep 2022 01:53:32 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id l19-20020a639853000000b0043957e4f85asm16626pgo.12.2022.09.13.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 01:53:31 -0700 (PDT)
Date:   Tue, 13 Sep 2022 17:53:25 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 4/4] mm/slub: extend redzone check to extra allocated
 kmalloc space than requested
Message-ID: <YyBFBb8f3ZN+jRTf@hyeyoo>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-5-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913065423.520159-5-feng.tang@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 02:54:23PM +0800, Feng Tang wrote:
> kmalloc will round up the request size to a fixed size (mostly power
> of 2), so there could be a extra space than what is requested, whose
> size is the actual buffer size minus original request size.
> 
> To better detect out of bound access or abuse of this space, add
> redzone sanity check for it.
> 
> And in current kernel, some kmalloc user already knows the existence
> of the space and utilizes it after calling 'ksize()' to know the real
> size of the allocated buffer. So we skip the sanity check for objects
> which have been called with ksize(), as treating them as legitimate
> users.
> 
> In some cases, the free pointer could be saved inside the latter
> part of object data area, which may overlap the redzone part(for
> small sizes of kmalloc objects). As suggested by Hyeonggon Yoo,
> force the free pointer to be in meta data area when kmalloc redzone
> debug is enabled, to make all kmalloc objects covered by redzone
> check.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.h        |  4 ++++
>  mm/slab_common.c |  4 ++++
>  mm/slub.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 3cf5adf63f48..5ca04d9c8bf5 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -881,4 +881,8 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +void skip_orig_size_check(struct kmem_cache *s, const void *object);
> +#endif
> +
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8e13e3aac53f..5106667d6adb 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1001,6 +1001,10 @@ size_t __ksize(const void *object)
>  		return folio_size(folio);
>  	}
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> +#endif
> +
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }
>  
> diff --git a/mm/slub.c b/mm/slub.c
> index 6f823e99d8b4..546b30ed5afd 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -812,12 +812,28 @@ static inline void set_orig_size(struct kmem_cache *s,
>  	if (!slub_debug_orig_size(s))
>  		return;
>  
> +#ifdef CONFIG_KASAN_GENERIC
> +	/*
> +	 * KASAN could save its free meta data in object's data area at
> +	 * offset 0, if the size is larger than 'orig_size', it could
> +	 * overlap the data redzone(from 'orig_size+1' to 'object_size'),
> +	 * where the check should be skipped.
> +	 */
> +	if (s->kasan_info.free_meta_size > orig_size)
> +		orig_size = s->object_size;
> +#endif
> +
>  	p += get_info_end(s);
>  	p += sizeof(struct track) * 2;
>  
>  	*(unsigned int *)p = orig_size;
>  }
>  
> +void skip_orig_size_check(struct kmem_cache *s, const void *object)
> +{
> +	set_orig_size(s, (void *)object, s->object_size);
> +}
> +
>  static unsigned int get_orig_size(struct kmem_cache *s, void *object)
>  {
>  	void *p = kasan_reset_tag(object);
> @@ -949,13 +965,27 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
>  {
>  	u8 *p = kasan_reset_tag(object);
> +	unsigned int orig_size = s->object_size;
>  
> -	if (s->flags & SLAB_RED_ZONE)
> +	if (s->flags & SLAB_RED_ZONE) {
>  		memset(p - s->red_left_pad, val, s->red_left_pad);
>  
> +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +			orig_size = get_orig_size(s, object);
> +
> +			/*
> +			 * Redzone the extra allocated space by kmalloc
> +			 * than requested.
> +			 */
> +			if (orig_size < s->object_size)
> +				memset(p + orig_size, val,
> +				       s->object_size - orig_size);
> +		}
> +	}
> +
>  	if (s->flags & __OBJECT_POISON) {
> -		memset(p, POISON_FREE, s->object_size - 1);
> -		p[s->object_size - 1] = POISON_END;
> +		memset(p, POISON_FREE, orig_size - 1);
> +		p[orig_size - 1] = POISON_END;
>  	}
>  
>  	if (s->flags & SLAB_RED_ZONE)
> @@ -1103,6 +1133,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>  	u8 *p = object;
>  	u8 *endobject = object + s->object_size;
> +	unsigned int orig_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1112,6 +1143,17 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
>  			endobject, val, s->inuse - s->object_size))
>  			return 0;
> +
> +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +			orig_size = get_orig_size(s, object);
> +
> +			if (s->object_size > orig_size  &&
> +				!check_bytes_and_report(s, slab, object,
> +					"kmalloc Redzone", p + orig_size,
> +					val, s->object_size - orig_size)) {
> +				return 0;
> +			}
> +		}
>  	} else {
>  		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
>  			check_bytes_and_report(s, slab, p, "Alignment padding",
> @@ -4187,7 +4229,8 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->inuse = size;
>  
> -	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
> +	if (slub_debug_orig_size(s) ||
> +	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
>  	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
>  	    s->ctor) {
>  		/*
> -- 
> 2.34.1
> 

For the slab part:

Looks good to me.
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
