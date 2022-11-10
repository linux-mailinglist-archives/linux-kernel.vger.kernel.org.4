Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C43624651
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiKJPsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiKJPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:48:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:48:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 43F6222999;
        Thu, 10 Nov 2022 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668095316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3QJBtM4MnGOZMLT0ADfXmiVyB/zENfV6p3Drb9JBbs=;
        b=zskpez+6BQephEy8Wiz2FE8+VfHE1YRC6JFOsQBrpgPQLxjLzEyyNfD4Qb/lumHY7QY1mG
        H5J5YxQhfYbZKzWbK42esgKfIYy6gP1/FLU7/R4mGjTeakgOmouJJHt7Xo8WZW4gd8o29E
        4BAwpaejFVK06fWHta3gQmw9Z5zuHpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668095316;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3QJBtM4MnGOZMLT0ADfXmiVyB/zENfV6p3Drb9JBbs=;
        b=zwMcF9Q1r+FQdJIrJ4Nnhm384FgU1dof6X0sojrpKvcnpH0y+ET6p18GKsfQf0rTDs7J4u
        CP++s1rqSCnW+hDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 047A813B58;
        Thu, 10 Nov 2022 15:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yQlpAFQdbWPjUgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Nov 2022 15:48:36 +0000
Message-ID: <e2dd7c7c-b0b7-344a-de37-4624f5339bce@suse.cz>
Date:   Thu, 10 Nov 2022 16:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 3/3] mm/slub: extend redzone check to extra allocated
 kmalloc space than requested
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <20221021032405.1825078-4-feng.tang@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221021032405.1825078-4-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 05:24, Feng Tang wrote:
> kmalloc will round up the request size to a fixed size (mostly power
> of 2), so there could be a extra space than what is requested, whose
> size is the actual buffer size minus original request size.
> 
> To better detect out of bound access or abuse of this space, add
> redzone sanity check for it.
> 
> In current kernel, some kmalloc user already knows the existence of
> the space and utilizes it after calling 'ksize()' to know the real
> size of the allocated buffer. So we skip the sanity check for objects
> which have been called with ksize(), as treating them as legitimate
> users.

Hm so once Kees's effort is finished and all ksize() users behave correctly,
we can drop all that skip_orig_size_check() code, right?

> In some cases, the free pointer could be saved inside the latter
> part of object data area, which may overlap the redzone part(for
> small sizes of kmalloc objects). As suggested by Hyeonggon Yoo,
> force the free pointer to be in meta data area when kmalloc redzone
> debug is enabled, to make all kmalloc objects covered by redzone
> check.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Looks fine, but a suggestion below:

> ---
>  mm/slab.h        |  4 ++++
>  mm/slab_common.c |  4 ++++
>  mm/slub.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 8b4ee02fc14a..1dd773afd0c4 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -885,4 +885,8 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif
>  
> +#ifdef CONFIG_SLUB_DEBUG
> +void skip_orig_size_check(struct kmem_cache *s, const void *object);
> +#endif
> +
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 33b1886b06eb..0bb4625f10a2 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1037,6 +1037,10 @@ size_t __ksize(const void *object)
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
> index adff7553b54e..76581da6b9df 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -829,6 +829,17 @@ static inline void set_orig_size(struct kmem_cache *s,
>  	if (!slub_debug_orig_size(s))
>  		return;
>  
> +#ifdef CONFIG_KASAN_GENERIC
> +	/*
> +	 * KASAN could save its free meta data in object's data area at
> +	 * offset 0, if the size is larger than 'orig_size', it will
> +	 * overlap the data redzone in [orig_size+1, object_size], and
> +	 * the check should be skipped.
> +	 */
> +	if (kasan_metadata_size(s, true) > orig_size)
> +		orig_size = s->object_size;
> +#endif
> +
>  	p += get_info_end(s);
>  	p += sizeof(struct track) * 2;
>  
> @@ -848,6 +859,11 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
>  	return *(unsigned int *)p;
>  }
>  
> +void skip_orig_size_check(struct kmem_cache *s, const void *object)
> +{
> +	set_orig_size(s, (void *)object, s->object_size);
> +}
> +
>  static void slab_bug(struct kmem_cache *s, char *fmt, ...)
>  {
>  	struct va_format vaf;
> @@ -966,13 +982,27 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
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

Wondering if we can remove this if - memset and instead below:

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

This continues by:
    memset(p + s->object_size, val, s->inuse - s->object_size);
Instead we could do this, no?
    memset(p + orig_size, val, s->inuse - orig_size);

> @@ -1120,6 +1150,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>  	u8 *p = object;
>  	u8 *endobject = object + s->object_size;
> +	unsigned int orig_size;
>  
>  	if (s->flags & SLAB_RED_ZONE) {
>  		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1129,6 +1160,17 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
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
> @@ -4206,7 +4248,8 @@ static int calculate_sizes(struct kmem_cache *s)
>  	 */
>  	s->inuse = size;
>  
> -	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
> +	if (slub_debug_orig_size(s) ||
> +	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
>  	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
>  	    s->ctor) {
>  		/*

