Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4170062ECDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 05:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiKRE3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 23:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRE3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 23:29:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD41AD97
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:29:50 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l2so2473579qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 20:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTToeUbo/I6A+yeg0A23kiy55DPhxnbXYNCgTS9YFP0=;
        b=8JZgZuBCQUrGdUyof1lFOwNJklwkGMmn66bvebQZMWX5RXNDsZpVLzJPTg3iTTNgqk
         Q+hnZ7xO0x4Yo1xfExuxn4E7tP0g2cliTJ5pnvXrI9F01f3YmiCytP32+JJkwrb4cAx2
         znzoo8p7F50mV1yTB0wlO2BGQRl1vL1GLa7ETW3LqxzgrasqVztR8E3/lyJWRBQKz7Ha
         B47vjyRqpYpbZFxACxBeLgRp3l1ujGALASGNGwIfbvAbWJauBVOIeDej+yd2g9DjUNhC
         axW436LvqgfEW8lrAB8VxYzolxxF/uShR+/jz870LfOv5GPtv9GO9uh4SFVpCo00GMy/
         aF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTToeUbo/I6A+yeg0A23kiy55DPhxnbXYNCgTS9YFP0=;
        b=sSl9ClqC5haTLDPGZ+7wMd4yf+6gbYcspWlGYEcwuH0QDKutFLusIQPdb0XfHr9vBe
         UOtcYfAXCU7Kzqu7Laeoyycqm6afgjtGItSXLkwVs8GDIJ5xEg/7iJ3Lfi/cVRJd+9A0
         QNLMz6bnHiyTzcTPejCyYXsoMHPYv+4mQZ2UWZOV60HRSCNWx9GSPsNIkcFE7pOgHeOn
         OdpZQaR+4t/hg05KJKBdDmhPvo0mhd8VkB5gpOYdTqv3N0C5ElU6vQCei46HK9E71/E5
         xq0sR/zH3v3gSZBuZ7k+R/4tTyDEZAnMuUEIkVbNAJLCxvUXTDxZSxntQgs6YpeH92Gu
         2aYw==
X-Gm-Message-State: ANoB5pmixsPJE9E2j88sINV/dBv7c8s3LZ/RRFQ6+cxXLZgSEnTRIn9M
        39KVCV/wd8wtLqVkdCWPY1qYxg==
X-Google-Smtp-Source: AA0mqf6kdwsd0Ac7KvFF9V8mmXyJXvqRDkVkXzItreJ6LO1CPyXHdHfhhuqVkFqtaPuSAc1Ia/owlQ==
X-Received: by 2002:a05:622a:4110:b0:3a5:4502:3d67 with SMTP id cc16-20020a05622a411000b003a545023d67mr5234952qtb.270.1668745789362;
        Thu, 17 Nov 2022 20:29:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id br35-20020a05620a462300b006cfc01b4461sm1767979qkb.118.2022.11.17.20.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:29:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:30:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3cKUxgXs23XFVVo@cmpxchg.org>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-4-nphamcs@gmail.com>
 <Y3ayb4kx/m3oDsSN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ayb4kx/m3oDsSN@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:15:11PM -0800, Minchan Kim wrote:
> On Thu, Nov 17, 2022 at 08:38:37AM -0800, Nhat Pham wrote:
> > This helps determines the coldest zspages as candidates for writeback.
> > 
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zsmalloc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 326faa751f0a..2557b55ec767 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -239,6 +239,11 @@ struct zs_pool {
> >  	/* Compact classes */
> >  	struct shrinker shrinker;
> > 
> > +#ifdef CONFIG_ZPOOL
> > +	/* List tracking the zspages in LRU order by most recently added object */
> > +	struct list_head lru;
> > +#endif
> > +
> >  #ifdef CONFIG_ZSMALLOC_STAT
> >  	struct dentry *stat_dentry;
> >  #endif
> > @@ -260,6 +265,12 @@ struct zspage {
> >  	unsigned int freeobj;
> >  	struct page *first_page;
> >  	struct list_head list; /* fullness list */
> > +
> > +#ifdef CONFIG_ZPOOL
> > +	/* links the zspage to the lru list in the pool */
> > +	struct list_head lru;
> > +#endif
> > +
> >  	struct zs_pool *pool;
> >  #ifdef CONFIG_COMPACTION
> >  	rwlock_t lock;
> > @@ -352,6 +363,18 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
> >  	kmem_cache_free(pool->zspage_cachep, zspage);
> >  }
> > 
> > +#ifdef CONFIG_ZPOOL
> > +/* Moves the zspage to the front of the zspool's LRU */
> > +static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
> > +{
> > +	assert_spin_locked(&pool->lock);
> > +
> > +	if (!list_empty(&zspage->lru))
> > +		list_del(&zspage->lru);
> > +	list_add(&zspage->lru, &pool->lru);
> > +}
> > +#endif
> > +
> >  /* pool->lock(which owns the handle) synchronizes races */
> >  static void record_obj(unsigned long handle, unsigned long obj)
> >  {
> > @@ -953,6 +976,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
> >  	}
> > 
> >  	remove_zspage(class, zspage, ZS_EMPTY);
> > +#ifdef CONFIG_ZPOOL
> > +	list_del(&zspage->lru);
> > +#endif
> >  	__free_zspage(pool, class, zspage);
> >  }
> > 
> > @@ -998,6 +1024,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
> >  		off %= PAGE_SIZE;
> >  	}
> > 
> > +#ifdef CONFIG_ZPOOL
> > +	INIT_LIST_HEAD(&zspage->lru);
> > +#endif
> > +
> >  	set_freeobj(zspage, 0);
> >  }
> > 
> > @@ -1418,6 +1448,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> >  		fix_fullness_group(class, zspage);
> >  		record_obj(handle, obj);
> >  		class_stat_inc(class, OBJ_USED, 1);
> > +
> > +#ifdef CONFIG_ZPOOL
> > +		/* Move the zspage to front of pool's LRU */
> > +		move_to_front(pool, zspage);
> > +#endif
> >  		spin_unlock(&pool->lock);
> > 
> >  		return handle;
> > @@ -1444,6 +1479,10 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > 
> >  	/* We completely set up zspage so mark them as movable */
> >  	SetZsPageMovable(pool, zspage);
> > +#ifdef CONFIG_ZPOOL
> > +	/* Move the zspage to front of pool's LRU */
> > +	move_to_front(pool, zspage);
> > +#endif
> >  	spin_unlock(&pool->lock);
> 
> Why do we move the zspage in the alloc instead of accessor?
> 
> Isn't zs_map_object better place since it's clear semantic
> that user start to access the object?

Remember that this is used for swap, and these entries aren't accessed
on an ongoing basis while in the pool. An access means swapin. So
functionally this is fine.

On cleaner choices, I would actually agree with you that map would be
more appropriate. But all I can do is repeat replies from previous
questions: We're not reinventing the wheel here. zbud and z3fold do it
this way, and this follows their precedent. We've talked about wanting
to generalize the LRU, and that's a heck of a lot easier if we have
copies of *one* implementation that we can deduplicate - instead of
having to merge multiple implementations with arbitrary differences.

So as you review these patches, please compare what they do to zbud
and z3fold. Those existing zpool implementations have been a common
answer in response to review questions.
