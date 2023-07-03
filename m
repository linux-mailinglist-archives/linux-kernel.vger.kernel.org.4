Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F847463B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjGCUKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGCUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:10:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C46E72
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 13:10:48 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-346099c6f43so187405ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688415048; x=1691007048;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUC3FVpBPWS4ikSEsOA9mN51Dh3oGNvpuz1E7SS7pW8=;
        b=W6kvFMDOO6Pl9UTrtrK/jSx6v+0H/Opp73681u2iMUCVFXuT7Xje1tIpNGfz1OaDyI
         VdpgH4fgCf20sjpsoiuAFEmhPPa/1fgffTYdj3vIWsjrtTf4ZIMPAEEyEqn+TESCrxYC
         jVL2jjdqW4g19xqp7Vk9iXwlYXhOWERqW+jJ3fewh0u57Q7HtZ97zNAqbygOMecYkgKy
         NccrUgeF/Q7ybFa8mpZs8LHdguO00gPjBTZKJWSCFvpT5ELfqEGN2UYpwWiGp9MgkG1C
         nAq90GyIebUccUhPv31VP1GCX2PPuXAyDPp29hvB62v4WAQLF1I6bkjPIgquivizEeAX
         DoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688415048; x=1691007048;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUC3FVpBPWS4ikSEsOA9mN51Dh3oGNvpuz1E7SS7pW8=;
        b=JpltNjZv2KF9Bh9NdZhTHj1e6rmAAHwLIhZTIRR12Eq7oJ5782ZpcBUb6aASbIQHG3
         Ucdvk6hUB2XmwRxUsZjafbZ0l3M27uB0zzDibGQtkF4PmJ2QJOPKm3/bIpr/jUpCmXIY
         AvQFvAVXp2Cpss98UJvmPt3gsZwugIN2BlOdwwryuMS1LzlWrjtVH62O51nnolZgkWkF
         ZlKKzSy2q8egCkUwGvFEYlk56oH/2o4eYFGR/egYUhMvJvIrf532gZlNmoXUMHiEPT0g
         15JowZjq7nherIVeE5v26CcDNSZVYTANhAKGOtpsLb3wljTibKshfOvKTL1Fl2ROuSKJ
         UhEw==
X-Gm-Message-State: ABy/qLabTO7gNpx3eaREAnAPI2AC24QGLaRuWjMHJruA3IRBREZlvJHR
        R3sXZ6F3oSCtr1tDN2xwNyG/sA==
X-Google-Smtp-Source: APBJJlFfY6YmIHiIaFwzFZfADRfTPdrEmECH4yvf25yM58GDY9iJ7h2R/a1TW56egdogUK+tAz/sNA==
X-Received: by 2002:a05:6e02:1d03:b0:33b:71e6:d6b4 with SMTP id i3-20020a056e021d0300b0033b71e6d6b4mr18168ila.14.1688415047707;
        Mon, 03 Jul 2023 13:10:47 -0700 (PDT)
Received: from [2620:0:1008:15:17fc:1b56:71df:89b7] ([2620:0:1008:15:17fc:1b56:71df:89b7])
        by smtp.gmail.com with ESMTPSA id f4-20020aa78b04000000b0066884d4efdbsm14887991pfd.12.2023.07.03.13.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 13:10:47 -0700 (PDT)
Date:   Mon, 3 Jul 2023 13:10:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Matteo Rizzo <matteorizzo@google.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, jannh@google.com
Subject: Re: [PATCH] mm/slub: refactor freelist to use custom type
In-Reply-To: <20230703143820.152479-1-matteorizzo@google.com>
Message-ID: <abd3f78b-5027-f859-27c8-296108ec8e92@google.com>
References: <20230703143820.152479-1-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023, Matteo Rizzo wrote:

> From: Jann Horn <jannh@google.com>
> 
> Currently the SLUB code represents encoded freelist entries as "void*".
> That's misleading, those things are encoded under
> CONFIG_SLAB_FREELIST_HARDENED so that they're not actually dereferencable.
> 
> Give them their own type, and split freelist_ptr() into one function per
> direction (one for encoding, one for decoding).
> 

I don't feel strongly about this.

> Signed-off-by: Jann Horn <jannh@google.com>
> Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  include/linux/slub_def.h |  6 ++++++
>  mm/slub.c                | 37 ++++++++++++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index deb90cf4bffb..c747820a55b4 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -43,6 +43,12 @@ enum stat_item {
>  };
>  
>  #ifndef CONFIG_SLUB_TINY
> +/*
> + * freeptr_t represents a SLUB freelist pointer, which might be encoded
> + * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> + */
> +typedef struct { unsigned long v; } freeptr_t;

Seems strange this would only appear for configs without CONFIG_SLUB_TINY.

Since lots of files include linux/slab.h I think this may start to be used 
in non-slab code.  Not sure why it needs to be added to the header file?

> +
>  /*
>   * When changing the layout, make sure freelist and tid are still compatible
>   * with this_cpu_cmpxchg_double() alignment requirements.
> diff --git a/mm/slub.c b/mm/slub.c
> index e3b5d5c0eb3a..26d0ca02b61d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -365,8 +365,8 @@ static struct workqueue_struct *flushwq;
>   * with an XOR of the address where the pointer is held and a per-cache
>   * random number.
>   */
> -static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
> -				 unsigned long ptr_addr)
> +static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
> +					    void *ptr, unsigned long ptr_addr)
>  {
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	/*
> @@ -379,25 +379,40 @@ static inline void *freelist_ptr(const struct kmem_cache *s, void *ptr,
>  	 * calls get_freepointer() with an untagged pointer, which causes the
>  	 * freepointer to be restored incorrectly.
>  	 */
> -	return (void *)((unsigned long)ptr ^ s->random ^
> -			swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
> +	return (freeptr_t){.v = (unsigned long)ptr ^ s->random ^
> +			swab((unsigned long)kasan_reset_tag((void *)ptr_addr))};
>  #else
> -	return ptr;
> +	return (freeptr_t){.v = (unsigned long)ptr};
>  #endif
>  }
>  
> +static inline void *freelist_ptr_decode(const struct kmem_cache *s,
> +					freeptr_t ptr, unsigned long ptr_addr)
> +{
> +	void *decoded;
> +
> +#ifdef CONFIG_SLAB_FREELIST_HARDENED
> +	/* See the comment in freelist_ptr_encode */
> +	decoded = (void *)(ptr.v ^ s->random ^
> +		swab((unsigned long)kasan_reset_tag((void *)ptr_addr)));
> +#else
> +	decoded = (void *)ptr.v;
> +#endif
> +	return decoded;
> +}
> +
>  /* Returns the freelist pointer recorded at location ptr_addr. */
>  static inline void *freelist_dereference(const struct kmem_cache *s,
>  					 void *ptr_addr)
>  {
> -	return freelist_ptr(s, (void *)*(unsigned long *)(ptr_addr),
> +	return freelist_ptr_decode(s, *(freeptr_t *)(ptr_addr),
>  			    (unsigned long)ptr_addr);
>  }
>  
>  static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  {
>  	object = kasan_reset_tag(object);
> -	return freelist_dereference(s, object + s->offset);
> +	return freelist_dereference(s, (freeptr_t *)(object + s->offset));
>  }
>  
>  #ifndef CONFIG_SLUB_TINY
> @@ -421,15 +436,15 @@ __no_kmsan_checks
>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
>  {
>  	unsigned long freepointer_addr;
> -	void *p;
> +	freeptr_t p;
>  
>  	if (!debug_pagealloc_enabled_static())
>  		return get_freepointer(s, object);
>  
>  	object = kasan_reset_tag(object);
>  	freepointer_addr = (unsigned long)object + s->offset;
> -	copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p));
> -	return freelist_ptr(s, p, freepointer_addr);
> +	copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
> +	return freelist_ptr_decode(s, p, freepointer_addr);
>  }
>  
>  static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
> @@ -441,7 +456,7 @@ static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
>  #endif
>  
>  	freeptr_addr = (unsigned long)kasan_reset_tag((void *)freeptr_addr);
> -	*(void **)freeptr_addr = freelist_ptr(s, fp, freeptr_addr);
> +	*(freeptr_t *)freeptr_addr = freelist_ptr_encode(s, fp, freeptr_addr);
>  }
>  
>  /* Loop over all objects in a slab */
> 
> base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
> 
