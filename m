Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C0B62FDED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiKRTYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiKRTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:24:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B4F0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:24:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d192so5827440pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdCngp0163ZOC7R4UmapaO07RFseynPajyc/BjnA5YY=;
        b=XT4lmqMuxy3rDFluUzTnDbQxEYFF7FbgM07BgL4VhzVaTzKKmVo+PDV4EcTmnRINYR
         +8rq5TxSXwBSGjnXmKzBBJFRBya0zSS9UvA5nCbTNaqLWHGtVs+uJ+6KtmORseROIUGQ
         B1gpDbr/ozmrjJ7JdrAVKRqVAtOJKN2vGeRVi2i/HiReNlTDdnW4JwmczynZam6iFkvS
         l5GG+QS27WCGItZ9NeeHqCB7Yw6A4UzklWHdUQKLaSqgqWCUwrAs0FnffHL5GB3zdTfl
         1zxnswIisIkryuQXC22qcvESiu35fkIu+iOMlU3HkZj3FyIjfURti8HhaUA1aC8IjvJ1
         cuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdCngp0163ZOC7R4UmapaO07RFseynPajyc/BjnA5YY=;
        b=hSjCVFTnwwJcFeG05LDfg1SlTqFQHe9E9jr0UHbgEvCiENFrCWT4Nsb1kntFCM3KB0
         tA5d15POlXeLoQwhLhk0crmTLDDGApsCumCr5FZSqxEKe+t/3hrDMcWf8uahjoBasK0v
         +vak/+mByRrUVBIsx22PybfRVLgbi5FA8xFeWQf3WI068J7hDCiQxcj2Kgx+oHm8f9OE
         7OWFbYywHqdHq+amj48jMSIhHFhkrhe9HSYkAzOkg4uHHfSYm7M5+XlBi3KqGMBgC4Fp
         WJyGqVQOrVbpxrv7oM0Ka1TC2T4D1lJpQlw55SZPGWzdpPT99hZwJ0KK6T9scwFlB7ot
         IBAg==
X-Gm-Message-State: ANoB5plTnjJc7AtyGpqWOsJil6VdbCLoEpCtN1ScTOZyj+4QiRJyYN6u
        TnbLXJGnwUkLD8lzwb5Pmrs=
X-Google-Smtp-Source: AA0mqf4YXL5oNrj/5Fz4qpcvyXB/rghSqMveqidcZO95YJiKisNyQ7OZ8TV2mAFd2ngWGl1wdhDLtg==
X-Received: by 2002:a05:6a00:2908:b0:56b:d738:9b with SMTP id cg8-20020a056a00290800b0056bd738009bmr9214469pfb.61.1668799455580;
        Fri, 18 Nov 2022 11:24:15 -0800 (PST)
Received: from google.com ([2620:15c:211:201:bba9:9f92:b2cc:16a4])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b00186b280a441sm4108482plf.239.2022.11.18.11.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:24:15 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 18 Nov 2022 11:24:13 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3fb3X7qRN10lCAN@google.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-4-nphamcs@gmail.com>
 <Y3ayb4kx/m3oDsSN@google.com>
 <Y3cKUxgXs23XFVVo@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3cKUxgXs23XFVVo@cmpxchg.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:30:11PM -0500, Johannes Weiner wrote:
> On Thu, Nov 17, 2022 at 02:15:11PM -0800, Minchan Kim wrote:
> > On Thu, Nov 17, 2022 at 08:38:37AM -0800, Nhat Pham wrote:
> > > This helps determines the coldest zspages as candidates for writeback.
> > > 
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  mm/zsmalloc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > > 
> > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > index 326faa751f0a..2557b55ec767 100644
> > > --- a/mm/zsmalloc.c
> > > +++ b/mm/zsmalloc.c
> > > @@ -239,6 +239,11 @@ struct zs_pool {
> > >  	/* Compact classes */
> > >  	struct shrinker shrinker;
> > > 
> > > +#ifdef CONFIG_ZPOOL
> > > +	/* List tracking the zspages in LRU order by most recently added object */
> > > +	struct list_head lru;
> > > +#endif
> > > +
> > >  #ifdef CONFIG_ZSMALLOC_STAT
> > >  	struct dentry *stat_dentry;
> > >  #endif
> > > @@ -260,6 +265,12 @@ struct zspage {
> > >  	unsigned int freeobj;
> > >  	struct page *first_page;
> > >  	struct list_head list; /* fullness list */
> > > +
> > > +#ifdef CONFIG_ZPOOL
> > > +	/* links the zspage to the lru list in the pool */
> > > +	struct list_head lru;
> > > +#endif
> > > +
> > >  	struct zs_pool *pool;
> > >  #ifdef CONFIG_COMPACTION
> > >  	rwlock_t lock;
> > > @@ -352,6 +363,18 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
> > >  	kmem_cache_free(pool->zspage_cachep, zspage);
> > >  }
> > > 
> > > +#ifdef CONFIG_ZPOOL
> > > +/* Moves the zspage to the front of the zspool's LRU */
> > > +static void move_to_front(struct zs_pool *pool, struct zspage *zspage)
> > > +{
> > > +	assert_spin_locked(&pool->lock);
> > > +
> > > +	if (!list_empty(&zspage->lru))
> > > +		list_del(&zspage->lru);
> > > +	list_add(&zspage->lru, &pool->lru);
> > > +}
> > > +#endif
> > > +
> > >  /* pool->lock(which owns the handle) synchronizes races */
> > >  static void record_obj(unsigned long handle, unsigned long obj)
> > >  {
> > > @@ -953,6 +976,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
> > >  	}
> > > 
> > >  	remove_zspage(class, zspage, ZS_EMPTY);
> > > +#ifdef CONFIG_ZPOOL
> > > +	list_del(&zspage->lru);
> > > +#endif
> > >  	__free_zspage(pool, class, zspage);
> > >  }
> > > 
> > > @@ -998,6 +1024,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
> > >  		off %= PAGE_SIZE;
> > >  	}
> > > 
> > > +#ifdef CONFIG_ZPOOL
> > > +	INIT_LIST_HEAD(&zspage->lru);
> > > +#endif
> > > +
> > >  	set_freeobj(zspage, 0);
> > >  }
> > > 
> > > @@ -1418,6 +1448,11 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > >  		fix_fullness_group(class, zspage);
> > >  		record_obj(handle, obj);
> > >  		class_stat_inc(class, OBJ_USED, 1);
> > > +
> > > +#ifdef CONFIG_ZPOOL
> > > +		/* Move the zspage to front of pool's LRU */
> > > +		move_to_front(pool, zspage);
> > > +#endif
> > >  		spin_unlock(&pool->lock);
> > > 
> > >  		return handle;
> > > @@ -1444,6 +1479,10 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > > 
> > >  	/* We completely set up zspage so mark them as movable */
> > >  	SetZsPageMovable(pool, zspage);
> > > +#ifdef CONFIG_ZPOOL
> > > +	/* Move the zspage to front of pool's LRU */
> > > +	move_to_front(pool, zspage);
> > > +#endif
> > >  	spin_unlock(&pool->lock);
> > 
> > Why do we move the zspage in the alloc instead of accessor?
> > 
> > Isn't zs_map_object better place since it's clear semantic
> > that user start to access the object?
> 
> Remember that this is used for swap, and these entries aren't accessed
> on an ongoing basis while in the pool. An access means swapin. So
> functionally this is fine.
> 
> On cleaner choices, I would actually agree with you that map would be
> more appropriate. But all I can do is repeat replies from previous
> questions: We're not reinventing the wheel here. zbud and z3fold do it
> this way, and this follows their precedent. We've talked about wanting
> to generalize the LRU, and that's a heck of a lot easier if we have
> copies of *one* implementation that we can deduplicate - instead of
> having to merge multiple implementations with arbitrary differences.

It's already very weird to add the LRU logic into allocator but since
you have talked that you are working general LRU concept what I
preferred and this temporal work would be beneficial to get all the
requirements for the work, I wanted to help this as interim solution
since I know the general LRU is bigger work than this. However, 
If you also agree the suggestion(adding LRU into mapping function
rather than allocation) and it doesn't change any behavior, why not?

If the divergence would make harder for your upcoming LRU work, I
totally agree with you but I don't see such one line change makes your
duduplication work harder. At the same time, I am trying to make
zsmalloc *reasonable* rather than "Yeah, I am fine to take something
smelly code since others are already doing it" stance.

> 
> So as you review these patches, please compare what they do to zbud
> and z3fold. Those existing zpool implementations have been a common
> answer in response to review questions.

I did and thought it's weird and the correction is trivial.
