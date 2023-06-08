Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC67285D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjFHQw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjFHQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:52:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D51FEB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:52:52 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75d4df773b4so64657085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686243171; x=1688835171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiBhLGWbITC43BT7KiNGlbnSE+yVfhOycw9l7fHnG08=;
        b=aVeSKvRPTf0sr7EyyKyVsYEUOB3eE8Ql7hj/pFjKhSvhkvD/LVG1Id53z3qsV1+A6T
         6i1qa/EoVJINgnJ4TIEdEPBlXKUtPgidGRmSzpSKr3Ebyd1KjjwZZzikyz9yaDyq7Xx3
         xHxUKjCeM33JYdQYEjHa4oEciyIkjLPoxQvYZN/fyTR3sAbQFqFUmvnWR1VOsDUfLYoo
         Kmusa2BE6UV5C7NVFZOodzg4sXee54p//oV/YtkeujKwHgvsTjzWQBQA7enAo9BaJ+/Z
         q7Zjd8Fu62Xs53rAVvc90fMhqNJiu1Bd821WodXe++oHWPGTG4MtiGQHLCaJwHNlXiCR
         b1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686243171; x=1688835171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiBhLGWbITC43BT7KiNGlbnSE+yVfhOycw9l7fHnG08=;
        b=D5cLEkhRDI/iIANEUeJHuAGqmpugg9h5Fbgt+QYFRM/vnhlFdeaoxVXc1uhHyCzoUT
         XBc6GpYffgy6f4VDQ4a9oBhnLrQTjYxX7y9jH0CNr7ff/Yi1zbj1ZjKbAb7+zF8DAPYC
         9KxtmGmZB95khPYoGKyBtH+vv8enPO55mjtgOEoHlqLcoMWQzInU1g4LStc4cK+0BF3X
         MMnXRC67JG0TXOroUg4+TAYd63klhQ+bIjuO+u90ln0KYScse60fEjoline7NiEp7Bm3
         2ase7uvpGL645JiJeWZJCAG9FuhiwETtWdERzv4VYiOg4G4gKazbs4khXLRa92ur0K5c
         na/Q==
X-Gm-Message-State: AC+VfDwLlVwI9w1iRYG2fc0yeSt4U6L5Hdi0P0n2qQadjJTmu6YYb+Go
        XDGfhfvs3DFYX14abk6P2pNdM4WHgSZSLPrdDVQ=
X-Google-Smtp-Source: ACHHUZ5QwtZUohNsMeuxDEXfaQKw4Cn1nPDm7p/M573oU6iRH/1talz/+q8EeRRn07HRSl6frtGFJA==
X-Received: by 2002:a05:620a:4391:b0:75e:c588:bb41 with SMTP id a17-20020a05620a439100b0075ec588bb41mr6068044qkp.66.1686243171452;
        Thu, 08 Jun 2023 09:52:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a06d600b0074fafbea974sm460308qky.2.2023.06.08.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:52:51 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:52:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230608165250.GG352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-2-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:56:05PM +0200, Domenico Cerasuolo wrote:
> @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
>  	return NULL;
>  }
>  
> +static int zswap_shrink(struct zswap_pool *pool)
> +{
> +	struct zswap_entry *lru_entry, *tree_entry = NULL;
> +	struct zswap_header *zhdr;
> +	struct zswap_tree *tree;
> +	int swpoffset;
> +	int ret;
> +
> +	/* get a reclaimable entry from LRU */
> +	spin_lock(&pool->lru_lock);
> +	if (list_empty(&pool->lru)) {
> +		spin_unlock(&pool->lru_lock);
> +		return -EINVAL;
> +	}
> +	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> +	list_del_init(&lru_entry->lru);
> +	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
> +	tree = zswap_trees[swp_type(zhdr->swpentry)];
> +	zpool_unmap_handle(pool->zpool, lru_entry->handle);
> +	/*
> +	 * Once the pool lock is dropped, the lru_entry might get freed. The
> +	 * swpoffset is copied to the stack, and lru_entry isn't deref'd again
> +	 * until the entry is verified to still be alive in the tree.
> +	 */
> +	swpoffset = swp_offset(zhdr->swpentry);
> +	spin_unlock(&pool->lru_lock);
> +
> +	/* hold a reference from tree so it won't be freed during writeback */
> +	spin_lock(&tree->lock);
> +	tree_entry = zswap_entry_find_get(&tree->rbroot, swpoffset);
> +	if (tree_entry != lru_entry) {
> +		if (tree_entry)
> +			zswap_entry_put(tree, tree_entry);
> +		spin_unlock(&tree->lock);
> +		return -EAGAIN;
> +	}
> +	spin_unlock(&tree->lock);
> +
> +	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
> +
> +	spin_lock(&tree->lock);
> +	if (ret) {
> +		spin_lock(&pool->lru_lock);
> +		list_move(&lru_entry->lru, &pool->lru);
> +		spin_unlock(&pool->lru_lock);
> +	}
> +	zswap_entry_put(tree, tree_entry);

On re-reading this, I find the lru_entry vs tree_entry distinction
unnecessarily complicated. Once it's known that the thing coming off
the LRU is the same thing as in the tree, there is only "the entry".

How about 'entry' and 'tree_entry', and after validation use 'entry'
throughout the rest of the function?
