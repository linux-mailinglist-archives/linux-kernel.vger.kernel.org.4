Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D562FE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiKRTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiKRTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:54:32 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F15BBDF8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:53:59 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n18so4040095qvt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTkZJtVY5XmhfNv7KEDFzEPgp2PbnMTNm5bzoTjVX44=;
        b=harKvWAe2XzGhlXiR+b9U8hjr4RbG/BX3y25dewQ8sxKyaK9LVcEWsN7bfxiOtHld0
         nMglUBazLIdl9NjFeq8ZJRUcOYofXrlc78VkLk+Q6KjGvDMZgOLbigihpLJUXoJ4dCOv
         q11wzDRofhwLIkkf0RRkNSrVvl6dtEdyB/3CQ8BeINSR+jwDgKJzTw0suZoeo/7/LPif
         AHGNJgd5411mheSa4PnTgYioWhbhqabVAwnut7brb/xfLt/uFgGRfhpMovTJmFTSkpNo
         GIXiD3p1rmuQuDFV6N7BFIWJg5vKK/G0sTlCOrbdU0wFaz0R7Syg/oVArUfTnvDgimLR
         M6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTkZJtVY5XmhfNv7KEDFzEPgp2PbnMTNm5bzoTjVX44=;
        b=vrzF/iRBwM/mqnbYTEhC9pHyvwbd5ww8YKbyJ6U5Z/1hLqVvc9cZq4DbettVfaG03O
         JQnNaHL7Jemq2qCopnjOgIh0gFWJ8nNU0L+M1TcHjqsqMYG/8r3pp172RjSBGvsaf9co
         UkbdmzCjR6Kz/mNmQlry/SjwbG707NYQn8eA4sXUYgz8XA5iIDc0QfLdq6XmQ/lmdu9V
         qyjmzpkNQj10lptvrZb66eaxGbw8ltxGMK/gzrvkDhEbYfrGa5Fm0RQUstsbfgrQR8rk
         5mXXUNmzMWU7+ONSKpPzh77MkYJNSFzTmBjYd5I4w0SXEdOqRk1CsNNq9srSKpNp3BDN
         LHrg==
X-Gm-Message-State: ANoB5plZ5sbB/tMD0cUtgmuWCro6LRqFFZAH0rQVrR9lgX8WHYuQdamA
        bS8PCLnIPZPPFxxX/9sXJIdGVQ==
X-Google-Smtp-Source: AA0mqf6Te08Zxqvc2w5Mn1xSCMQ1xVrd815EyVks/x8cj1j74xJ+/SgYbBBtiLde3nbUuHxYX9vBvQ==
X-Received: by 2002:a05:6214:3d8a:b0:4b1:c5bb:25f2 with SMTP id om10-20020a0562143d8a00b004b1c5bb25f2mr8137014qvb.101.1668801238793;
        Fri, 18 Nov 2022 11:53:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id l14-20020a37f90e000000b006cfc7f9eea0sm2917523qkj.122.2022.11.18.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:53:58 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:54:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3fi7gxaMxkvceVN@cmpxchg.org>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-4-nphamcs@gmail.com>
 <Y3ayb4kx/m3oDsSN@google.com>
 <Y3cKUxgXs23XFVVo@cmpxchg.org>
 <Y3fb3X7qRN10lCAN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3fb3X7qRN10lCAN@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:24:13AM -0800, Minchan Kim wrote:
> On Thu, Nov 17, 2022 at 11:30:11PM -0500, Johannes Weiner wrote:
> > On Thu, Nov 17, 2022 at 02:15:11PM -0800, Minchan Kim wrote:
> > > On Thu, Nov 17, 2022 at 08:38:37AM -0800, Nhat Pham wrote:
> > > > This helps determines the coldest zspages as candidates for writeback.
> > > > 
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  mm/zsmalloc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 46 insertions(+)
> > > > 
> > > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > > index 326faa751f0a..2557b55ec767 100644
> > > > --- a/mm/zsmalloc.c
> > > > +++ b/mm/zsmalloc.c
> > > > @@ -239,6 +239,11 @@ struct zs_pool {
> > > >  	/* Compact classes */
> > > >  	struct shrinker shrinker;
> > > > 
> > > > +#ifdef CONFIG_ZPOOL
> > > > +	/* List tracking the zspages in LRU order by most recently added object */
> > > > +	struct list_head lru;
> > > > +#endif
> > > > +
> > > >  #ifdef CONFIG_ZSMALLOC_STAT
> > > >  	struct dentry *stat_dentry;
> > > >  #endif
> > > > @@ -260,6 +265,12 @@ struct zspage {
> > > >  	unsigned int freeobj;
> > > >  	struct page *first_page;
> > > >  	struct list_head list; /* fullness list */
> > > > +
> > > > +#ifdef CONFIG_ZPOOL
> > > > +	/* links the zspage to the lru list in the pool */
> > > > +	struct list_head lru;
> > > > +#endif
> > > > +
> > > >  	struct zs_pool *pool;
> > > >  #ifdef CONFIG_COMPACTION
> > > >  	rwlock_t lock;
> > > > @@ -352,6 +363,18 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
> > > >  	kmem_cache_free(pool->zspage_cachep, zspage);
> > > >  }
> > > > 
> > > > +#ifdef CONFIG_ZPOOL
> > > > +/* Moves the zspage to the front of the zspool's LRU */
> > > > +static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
> > > > +{
> > > > +	assert_spin_locked(&pool->lock);
> > > > +
> > > > +	if (!list_empty(&zspage->lru))
> > > > +		list_del(&zspage->lru);
> > > > +	list_add(&zspage->lru, &pool->lru);
> > > > +}
> > > > +#endif
> > > > +
> > > >  /* pool->lock(which owns the handle) synchronizes races */
> > > >  static void record_obj(unsigned long handle, unsigned long obj)
> > > >  {
> > > > @@ -953,6 +976,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
> > > >  	}
> > > > 
> > > >  	remove_zspage(class, zspage, ZS_EMPTY);
> > > > +#ifdef CONFIG_ZPOOL
> > > > +	list_del(&zspage->lru);
> > > > +#endif
> > > >  	__free_zspage(pool, class, zspage);
> > > >  }
> > > > 
> > > > @@ -998,6 +1024,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
> > > >  		off %= PAGE_SIZE;
> > > >  	}
> > > > 
> > > > +#ifdef CONFIG_ZPOOL
> > > > +	INIT_LIST_HEAD(&zspage->lru);
> > > > +#endif
> > > > +
> > > >  	set_freeobj(zspage, 0);
> > > >  }
> > > > 
> > > > @@ -1418,6 +1448,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > > >  		fix_fullness_group(class, zspage);
> > > >  		record_obj(handle, obj);
> > > >  		class_stat_inc(class, OBJ_USED, 1);
> > > > +
> > > > +#ifdef CONFIG_ZPOOL
> > > > +		/* Move the zspage to front of pool's LRU */
> > > > +		move_to_front(pool, zspage);
> > > > +#endif
> > > >  		spin_unlock(&pool->lock);
> > > > 
> > > >  		return handle;
> > > > @@ -1444,6 +1479,10 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > > > 
> > > >  	/* We completely set up zspage so mark them as movable */
> > > >  	SetZsPageMovable(pool, zspage);
> > > > +#ifdef CONFIG_ZPOOL
> > > > +	/* Move the zspage to front of pool's LRU */
> > > > +	move_to_front(pool, zspage);
> > > > +#endif
> > > >  	spin_unlock(&pool->lock);
> > > 
> > > Why do we move the zspage in the alloc instead of accessor?
> > > 
> > > Isn't zs_map_object better place since it's clear semantic
> > > that user start to access the object?
> > 
> > Remember that this is used for swap, and these entries aren't accessed
> > on an ongoing basis while in the pool. An access means swapin. So
> > functionally this is fine.
> > 
> > On cleaner choices, I would actually agree with you that map would be
> > more appropriate. But all I can do is repeat replies from previous
> > questions: We're not reinventing the wheel here. zbud and z3fold do it
> > this way, and this follows their precedent. We've talked about wanting
> > to generalize the LRU, and that's a heck of a lot easier if we have
> > copies of *one* implementation that we can deduplicate - instead of
> > having to merge multiple implementations with arbitrary differences.
> 
> It's already very weird to add the LRU logic into allocator but since
> you have talked that you are working general LRU concept what I
> preferred and this temporal work would be beneficial to get all the
> requirements for the work, I wanted to help this as interim solution
> since I know the general LRU is bigger work than this. However, 
> If you also agree the suggestion(adding LRU into mapping function
> rather than allocation) and it doesn't change any behavior, why not?

map is called during writeback and load, where we wouldn't want to
update the LRU. Sure, you can filter for RO/WO, but that's also not
generic from an interface POV because it's entirely specific to zswap
operations which type of accesses *should* rotate the LRU. We'd also
call LRU code from previously untested contexts and thereby lose our
existing prod testing of these patches.

I think your asking to take risks and introduce variance into a code
base we're already trying to unify, for something that isn't actually
cleaner or more generic.

So respectfully, I disagree with this change request rather strongly.
