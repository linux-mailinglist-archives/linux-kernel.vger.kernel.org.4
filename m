Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF20722B13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjFEPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjFEPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:30:17 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446751B7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:29:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75ec7e8e826so7230585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685978993; x=1688570993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7fahhDIIIm+5HG8Dmvsrmj63m8zCpLF1SLLkT+qeh8=;
        b=qEBQeBW+ygXY0IdOw46Pi0ThBTwhB9q5Yfl75grXwsON+wGhl0d0bsZ2lF45C0CQBH
         AO0xo7MXkSfBJJm9zFmcyVMiTJuCwL52fFzAyEVd/71oF8ZCyybc0LdNaD1etzGbP1Bo
         TrbMsYhVlIDOQNxgIbkTHQDcANUaIthNs8WvQVOPeI5GqhHnk8sXE3zepQlujMWciWh5
         9NxH4w01PdsP0P7eao+8SpOZpVVlRI7TqnBLfu7hbu6v44WJYH7Zfs/4tK6AOr2Z04E+
         9oAG7g1NtRQ+v1+XYilJPxuH4YEieEudmAINAfEmLrXCb4zkvov+iB+L8Zv4SiTQKyta
         q89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685978993; x=1688570993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7fahhDIIIm+5HG8Dmvsrmj63m8zCpLF1SLLkT+qeh8=;
        b=gmfJaqa75Gc2tv6RmVJmlffXYsawX6MAAPL43SRJuZEL9HXZt2lsdGbdaLvDbAc75n
         i0W/oZ16GSiO8avF30MYwizB2sbjnQFacDjeKc9LeYQERtdEPWbCXUawQ2InicGtPs7q
         ZTyGTtu+n2SS6mfSNCvgg3URXQ+qjaxv6qS+P9IQQisduTDK/bO5KsNcowVwDQ5UiUVw
         vuEhIbcgsSkPTPkvnnuw6iKxdYabh+/XoCIWZ61Qu4n3CnaW08NssNX2urQlyjTRu4/m
         ZLncaXQEkwPD0PzXm05SxcEBXJozh9kWhoaZzmk0K9QY9gRHdNeNKlxznopm7XazfoHj
         n45w==
X-Gm-Message-State: AC+VfDzxrwLPrEUML/O3b8QsFvqHk5iO4YR6eqQ+6+P4lqytKtBRm+wU
        A5YV5W+JRfluxU9Jqp2j2UgmOA==
X-Google-Smtp-Source: ACHHUZ4FAwX6PNYiGDvABAapW8Sd64W8sAGUQtPo26VX5/ofVpX6dK+qxPDe7xMsuQqcoEweHqoHYA==
X-Received: by 2002:a05:620a:2202:b0:75e:bf97:677 with SMTP id m2-20020a05620a220200b0075ebf970677mr51238qkh.43.1685978993405;
        Mon, 05 Jun 2023 08:29:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id f24-20020ae9ea18000000b0075b0c1f4ad6sm4302357qkg.0.2023.06.05.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:29:53 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:29:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230605152952.GA221380@cmpxchg.org>
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605085419.44383-2-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

On Mon, Jun 05, 2023 at 10:54:13AM +0200, Domenico Cerasuolo wrote:
> @@ -364,6 +369,9 @@ static void zswap_free_entry(struct zswap_entry *entry)
>  	if (!entry->length)
>  		atomic_dec(&zswap_same_filled_pages);
>  	else {
> +		spin_lock(&entry->pool->lock);
> +		list_del_init(&entry->lru);
> +		spin_unlock(&entry->pool->lock);

This should be list_del(), as the entry is freed right after this and
the list isn't reused anymore.

The slab memory is recycled, but the allocation site (commented on
below) doesn't need the list initialized.

However, I think it also needs to check !zpool_evictable(). If
alloc/store doesn't do the list_add(), this would be a double delete.

> @@ -584,14 +592,65 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
>  	return NULL;
>  }
>  
> +static int zswap_shrink(struct zswap_pool *pool)
> +{
> +	struct zswap_entry *lru_entry, *tree_entry = NULL;
> +	struct zswap_header *zhdr;
> +	struct zswap_tree *tree;
> +	swp_entry_t swpentry;
> +	int ret;
> +
> +	/* get a reclaimable entry from LRU */
> +	spin_lock(&pool->lock);
> +	if (list_empty(&pool->lru)) {
> +		spin_unlock(&pool->lock);
> +		return -EINVAL;
> +	}
> +	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> +	list_del_init(&lru_entry->lru);
> +	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
> +	tree = zswap_trees[swp_type(zhdr->swpentry)];
> +	zpool_unmap_handle(pool->zpool, lru_entry->handle);
> +	swpentry = zhdr->swpentry;
> +	spin_unlock(&pool->lock);

Once the pool lock is dropped, the lru_entry might get freed. But the
swpentry is copied to the stack, and lru_entry isn't deref'd again
until the entry is verified to still be alive in the tree.

This could use a comment.

> +	/* hold a reference from tree so it won't be freed during writeback */
> +	spin_lock(&tree->lock);
> +	tree_entry = zswap_entry_find_get(&tree->rbroot, swp_offset(swpentry));
> +	if (tree_entry != lru_entry) {
> +		if (tree_entry)
> +			zswap_entry_put(tree, tree_entry);
> +		spin_unlock(&tree->lock);
> +		return -EAGAIN;
> +	}
> +	spin_unlock(&tree->lock);

It's pretty outrageous how much simpler this is compared to the
<backend>_reclaim_page() functions! The backends have to jump through
a lot of hoops to serialize against freeing, whereas zswap can simply
hold a reference. This is clearly a much better design.

> +	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
> +
> +	spin_lock(&tree->lock);
> +	if (ret) {
> +		spin_lock(&pool->lock);
> +		list_move(&lru_entry->lru, &pool->lru);
> +		spin_unlock(&pool->lock);
> +	}
> +	zswap_entry_put(tree, tree_entry);
> +	spin_unlock(&tree->lock);
> +
> +	return ret ? -EAGAIN : 0;
> +}
> +
>  static void shrink_worker(struct work_struct *w)
>  {
>  	struct zswap_pool *pool = container_of(w, typeof(*pool),
>  						shrink_work);
>  	int ret, failures = 0;
>  
> +	/* zpool_evictable will be removed once all 3 backends have migrated*/

Missing space between text and */

>  	do {
> -		ret = zpool_shrink(pool->zpool, 1, NULL);
> +		if (zpool_evictable(pool->zpool))
> +			ret = zpool_shrink(pool->zpool, 1, NULL);
> +		else
> +			ret = zswap_shrink(pool);
>  		if (ret) {
>  			zswap_reject_reclaim_fail++;
>  			if (ret != -EAGAIN)
> @@ -655,6 +714,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
>  	 */
>  	kref_init(&pool->kref);
>  	INIT_LIST_HEAD(&pool->list);
> +	INIT_LIST_HEAD(&pool->lru);
> +	spin_lock_init(&pool->lock);
>  	INIT_WORK(&pool->shrink_work, shrink_worker);
>  
>  	zswap_pool_debug("created", pool);
> @@ -1270,7 +1331,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	}
>  
>  	/* store */
> -	hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> +	hlen = sizeof(zhdr);
>  	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>  	if (zpool_malloc_support_movable(entry->pool->zpool))
>  		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> @@ -1313,6 +1374,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  			zswap_entry_put(tree, dupentry);
>  		}
>  	} while (ret == -EEXIST);
> +	INIT_LIST_HEAD(&entry->lru);

The list_add() below initializes the entry, so this shouldn't be
needed.

> +	/* zpool_evictable will be removed once all 3 backends have migrated*/
> +	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +		spin_lock(&entry->pool->lock);
> +		list_add(&entry->lru, &entry->pool->lru);
> +		spin_unlock(&entry->pool->lock);
> +	}
>  	spin_unlock(&tree->lock);
>  
>  	/* update stats */
