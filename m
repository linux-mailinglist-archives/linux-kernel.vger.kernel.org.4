Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0855E6355CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiKWJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiKWJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:21:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D8C10B6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E341F1F85D;
        Wed, 23 Nov 2022 09:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669195263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ChOqSLee0rmz2oTzjZlbgB7fmW7X2/L74cYDn2AHg0=;
        b=WQgMsxhWcA7MCx0a41UrCz/u4JTsY7RUImEW8PnEu86WjiGAMCg3F6nUUhlX3EuBRuacWo
        n0Gmoyuyg2nUK106MstNWvNnXiTaKLrexqJL6wt5lMK+g8h4ug02CiIP8GSqG9KN0DCje4
        n2sC97Bu+gU0Yh6mJfkXKuufRRNfGNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669195263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ChOqSLee0rmz2oTzjZlbgB7fmW7X2/L74cYDn2AHg0=;
        b=aSmEAcQJzrRTGdpNNKAo51TflwLScKhMBU23sl1iudaK2Oa+hdXzyHqSrn7y5JtZCArsSX
        ga2uwae5AtXn6jAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A97A513A37;
        Wed, 23 Nov 2022 09:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QgwtKP/lfWMEDQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Nov 2022 09:21:03 +0000
Message-ID: <74d14df1-faa7-dc12-d406-ba038682e134@suse.cz>
Date:   Wed, 23 Nov 2022 10:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH -next 1/2] mm/slab: add is_kmalloc_cache() helper macro
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20221121135024.1655240-1-feng.tang@intel.com>
 <20221121121938.1f202880ffe6bb18160ef785@linux-foundation.org>
 <Y3xeYF5NipSbBFSZ@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y3xeYF5NipSbBFSZ@feng-clx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 06:30, Feng Tang wrote:
> On Mon, Nov 21, 2022 at 12:19:38PM -0800, Andrew Morton wrote:
>> On Mon, 21 Nov 2022 21:50:23 +0800 Feng Tang <feng.tang@intel.com> wrote:
>> 
>> > +#ifndef CONFIG_SLOB
>> > +#define is_kmalloc_cache(s) ((s)->flags & SLAB_KMALLOC)
>> > +#else
>> > +#define is_kmalloc_cache(s) (false)
>> > +#endif
>> 
>> Could be implemented as a static inline C function, yes?
> 
> Right, I also did try inline function first, and met compilation error: 
> 
> "
> ./include/linux/slab.h: In function ‘is_kmalloc_cache’:
> ./include/linux/slab.h:159:18: error: invalid use of undefined type ‘struct kmem_cache’
>   159 |         return (s->flags & SLAB_KMALLOC);
>       |                  ^~
> "
> 
> The reason is 'struct kmem_cache' definition for slab/slub/slob sit
> separately in slab_def.h, slub_def.h and mm/slab.h, and they are not
> included in this 'include/linux/slab.h'. So I chose the macro way.

You could try mm/slab.h instead, below the slub_def.h includes there.
is_kmalloc_cache(s) shouldn't have random consumers in the kernel anyway.
It's fine if kasan includes it, as it's intertwined with slab a lot anyway.

> Btw, I've worked on some patches related with sl[auo]b recently, and
> really felt the pain when dealing with 3 allocators, on both reading
> code and writing patches. And I really like the idea of fading away
> SLOB as the first step :)

Can't agree more :)

>> If so, that's always best.  For (silly) example, consider the behaviour
>> of
>> 
>> 	x = is_kmalloc_cache(s++);
>> 
>> with and without CONFIG_SLOB.
> 
> Another solution I can think of is putting the implementation into
> slab_common.c, like the below?

The overhead of function call between compilation units (sans LTO) is not
worth it.

> Thanks,
> Feng
> 
> ---
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 067f0e80be9e..e4fcdbfb3477 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -149,6 +149,17 @@
>  
>  struct list_lru;
>  struct mem_cgroup;
> +
> +#ifndef CONFIG_SLOB
> +extern bool is_kmalloc_cache(struct kmem_cache *s);
> +#else
> +static inline bool is_kmalloc_cache(struct kmem_cache *s)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * struct kmem_cache related prototypes
>   */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a5480d67f391..860e804b7c0a 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -77,6 +77,13 @@ __setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
>  __setup("slab_nomerge", setup_slab_nomerge);
>  __setup("slab_merge", setup_slab_merge);
>  
> +#ifndef CONFIG_SLOB
> +bool is_kmalloc_cache(struct kmem_cache *s)
> +{
> +	return (s->flags & SLAB_KMALLOC);
> +}
> +#endif
> +
>  /*
>   * Determine the size of a slab object
>   */

