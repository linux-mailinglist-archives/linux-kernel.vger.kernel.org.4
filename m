Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E045F636678
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiKWRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiKWRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:03:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A20994A73
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:03:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD7E921A20;
        Wed, 23 Nov 2022 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669223006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOTqESa3U7W1bqo4V15GNCzXDu459rGsEt2ugIrp2oo=;
        b=P7YAkbJdM0MPjlher8/nZaZlAvbB5SpS4NQTqUjziAAGNcKgQZy61aewO4JVcnBIq0LeiK
        2sq34Wvrg6WL1ZlOKiqIYDalzhJ9FYZnKnb1LQcW8Mts+ZyjHFUnphlpInf9bwp3rOfQSX
        CsPvaoBnhAR4SXwUDZsI0D7st4RpSPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669223006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOTqESa3U7W1bqo4V15GNCzXDu459rGsEt2ugIrp2oo=;
        b=ct7u2HKkDhEc2h4wRrne/VdJiY9EG+3LNhuq2lQ5tMb6YwBYdcdf+9mX1U4cPUaWZ+HoX7
        YkC0t/bht/r8hzCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EDA213AE7;
        Wed, 23 Nov 2022 17:03:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PkBhGl5SfmOscAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Nov 2022 17:03:26 +0000
Message-ID: <bdafa84a-e5db-471b-fdb2-34ecbf09c225@suse.cz>
Date:   Wed, 23 Nov 2022 18:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 -next 1/2] mm/slb: add is_kmalloc_cache() helper
 function
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20221123123159.2325763-1-feng.tang@intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221123123159.2325763-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject should say mm/slab

On 11/23/22 13:31, Feng Tang wrote:
> commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
> kmalloc") introduces 'SLAB_KMALLOC' bit specifying whether a
> kmem_cache is a kmalloc cache for slab/slub (slob doesn't have
> dedicated kmalloc caches).
> 
> Add a helper inline function for other components like kasan to
> simplify code.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Patch 2 seems to depend on patches in Andrew's tree so it's simpler if he
takes both of these too.

Thanks,
Vlastimil

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

