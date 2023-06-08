Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82E7285EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjFHRFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFHRFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:05:04 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850B210E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:05:01 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75ebb3d57d0so72667785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686243900; x=1688835900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbEH9BlfFfJdgMptRvUoSctdxcOmDDazNQWd/NtfJrE=;
        b=ieRoR5nN/5HPTyKVwHVP0BEkQwQ9wvNsN/zAulSWc0Ol/uAuLEOAt1Z96gN5qNzHgN
         L+U3ldxPkY0ECJuef6B1DqX8drxR+O6z4wkfNtNSG01QHp5+oIRQdRSLC0vdZ+E+1M4c
         x8CHi7PvGPdiSJ8gPACnRHDoPtORC+XlKHr2fCq31foty1QbPWZdR7ZYa1+mG6lbsuRh
         pPEX427saRnQjrTZQ3PLdlBTPgRDHEVf2EdnG8w1ApcjjZBt877CInwG+LVHv0F/an6l
         J7YPOVt/EwGjmiYPsiTXgRsh9W9Ms92rriCEw4knegjO7MCrNRBmwTbgMm9RtVfy52c2
         MnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243900; x=1688835900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbEH9BlfFfJdgMptRvUoSctdxcOmDDazNQWd/NtfJrE=;
        b=bqGq67urnYFjd/yU5BYAFfePglVovIblnsZKMoruQBJgKvipo9bcOf2Th/RlKDh9XF
         mo8LEd9BXlk8+v3Ha8NNeDKYymyFImAkNuG6Si+oLZa/+Ff1abu9FlvbTS/eZofMjaiX
         hVA7+2GLHJ+0aoMOkvRnrvGYVzft++9Ti2Hyly4adTD7flevEeK1gScZiHvdkPL60ltN
         GLliDjU2Fhn20gM21ImP5NGkmoJMNAXcHZdmO+Um8VSv5EIGUmI1gE6h7BDq2ZkwZnIs
         E5piajY02I/6BQJxzrfUOcM27hvgOtBcSMMQvBWDxdenMpBrKAFzf47gPhOgp0OKlqlN
         HHsQ==
X-Gm-Message-State: AC+VfDzaP18nKMrgoPWQ2T+Yc4HFXhGNOspmj/TjvfW9fZ6B7gls2XBg
        1JoHCkia6x40onloRY5Y+HdCeA==
X-Google-Smtp-Source: ACHHUZ6rLRRG2RURXpCbACQUa/Op54Jl3Jbm9YOJq15oChEqeuhuXJFYvOGy2n2MGgHh3PE4t1DtAw==
X-Received: by 2002:a05:620a:25cc:b0:75e:d8db:5e4 with SMTP id y12-20020a05620a25cc00b0075ed8db05e4mr6668037qko.49.1686243900236;
        Thu, 08 Jun 2023 10:05:00 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id pi48-20020a05620a37b000b0075b053ab66bsm453084qkn.50.2023.06.08.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:04:59 -0700 (PDT)
Date:   Thu, 8 Jun 2023 13:04:59 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230608170459.GH352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-2-cerasuolodomenico@gmail.com>
 <20230608165250.GG352940@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608165250.GG352940@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:52:51PM -0400, Johannes Weiner wrote:
> On Tue, Jun 06, 2023 at 04:56:05PM +0200, Domenico Cerasuolo wrote:
> > @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
> >  	return NULL;
> >  }
> >  
> > +static int zswap_shrink(struct zswap_pool *pool)
> > +{
> > +	struct zswap_entry *lru_entry, *tree_entry = NULL;
> > +	struct zswap_header *zhdr;
> > +	struct zswap_tree *tree;
> > +	int swpoffset;
> > +	int ret;
> > +
> > +	/* get a reclaimable entry from LRU */
> > +	spin_lock(&pool->lru_lock);
> > +	if (list_empty(&pool->lru)) {
> > +		spin_unlock(&pool->lru_lock);
> > +		return -EINVAL;
> > +	}
> > +	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> > +	list_del_init(&lru_entry->lru);
> > +	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
> > +	tree = zswap_trees[swp_type(zhdr->swpentry)];
> > +	zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > +	/*
> > +	 * Once the pool lock is dropped, the lru_entry might get freed. The
> > +	 * swpoffset is copied to the stack, and lru_entry isn't deref'd again
> > +	 * until the entry is verified to still be alive in the tree.
> > +	 */
> > +	swpoffset = swp_offset(zhdr->swpentry);
> > +	spin_unlock(&pool->lru_lock);
> > +
> > +	/* hold a reference from tree so it won't be freed during writeback */
> > +	spin_lock(&tree->lock);
> > +	tree_entry = zswap_entry_find_get(&tree->rbroot, swpoffset);
> > +	if (tree_entry != lru_entry) {
> > +		if (tree_entry)
> > +			zswap_entry_put(tree, tree_entry);
> > +		spin_unlock(&tree->lock);
> > +		return -EAGAIN;
> > +	}
> > +	spin_unlock(&tree->lock);
> > +
> > +	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > +
> > +	spin_lock(&tree->lock);
> > +	if (ret) {
> > +		spin_lock(&pool->lru_lock);
> > +		list_move(&lru_entry->lru, &pool->lru);
> > +		spin_unlock(&pool->lru_lock);
> > +	}
> > +	zswap_entry_put(tree, tree_entry);
> 
> On re-reading this, I find the lru_entry vs tree_entry distinction
> unnecessarily complicated. Once it's known that the thing coming off
> the LRU is the same thing as in the tree, there is only "the entry".
> 
> How about 'entry' and 'tree_entry', and after validation use 'entry'
> throughout the rest of the function?

Even better, safe the tree_entry entirely by getting the reference
from the LRU already, and then just search the tree for a match:

	/* Get an entry off the LRU */
	spin_lock(&pool->lru_lock);
	entry = list_last_entry();
	list_del(&entry->lru);
	zswap_entry_get(entry);
	spin_unlock(&pool->lru_lock);

	/* Check for invalidate() race */
	spin_lock(&tree->lock);
	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
		ret = -EAGAIN;
		goto put_unlock;
	}
	spin_unlock(&tree->lock);

	ret = zswap_writeback_entry();

	spin_lock(&tree->lock);
	if (ret) {
		put_back_on_lru();
		goto put_unlock;
	}

	/* Check for invalidate() race */
	if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
		goto put_unlock;

	/* Drop base reference */
	zswap_entry_put(tree, entry);

put_unlock:
	/* Drop local reference */
	zswap_entry_put(tree, entry);
	spin_unlock(&tree->lock);

	return ret ? -EAGAIN : 0;
