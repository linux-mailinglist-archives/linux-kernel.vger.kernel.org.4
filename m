Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E866633565
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKVGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKVGhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:37:38 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA56356
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:37:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y4so12736891plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6nEzvRMqkEoaAWST80S3Bt5GCknL1xuC4oMibyvkh8=;
        b=X8lz3R6KuIPbAa9xJs09TMxgQ67PyPXHpxyQt3ICa55h+zNm7zl05/tkdJRImGv/dL
         AVeZUbNJzJ6NESVqnv14Qv5DIZubGpQiWvsiHE5yQzyX1xD+NqxeuLzyp32PlzSSveC1
         MVGKwaGwz8lIgKvTgt8VXiHh1W4vhEqnQ9Lqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6nEzvRMqkEoaAWST80S3Bt5GCknL1xuC4oMibyvkh8=;
        b=QlEjMub3rmcejvOQ9dhQkrVWuvh5egiyG+3ZEirZkkccSbAPLLSNVjJGIkqIBICpoo
         PeWHDzKMhw+XB2uZU7aeDqKJbKUVcdFlChfjueSzN0RwTSda3H3N0PLGoHbAOifmnPJ9
         q3P5hsKffBI20bfFhpJY9j2sNNFe59Qy0HTn7PZKW8og2+wHSCUBlp6S5CpeLAD3o3Iz
         8p3XUaArRhAAFmOwm7bAsUUjeUmsq+aCN7E+srQYwOYuVdUNVuWFek9OLtOsG2vpyBZa
         gpaqFz1ZyaouiW1lq5wQDKprSVt6CWCkBq1gyXvJH27OK/2LpLp30X/LqIhIAY5XNDSp
         44tQ==
X-Gm-Message-State: ANoB5pkluRMBDsgjZs/sJLYfAZqCnmpaWC0JwBkRaIHJYwmJIlp2kQzq
        Xa1T/PgZdwGWQLZC2m5zSPLjsA==
X-Google-Smtp-Source: AA0mqf4me3LmE5Ydwmvho1icfTJxdfYUlmZsQmKxWcn7KJMIT1xrasqsj7WHV/d3azBoJ9/iaoi3Vw==
X-Received: by 2002:a17:90b:1282:b0:214:1804:d96b with SMTP id fw2-20020a17090b128200b002141804d96bmr23650840pjb.90.1669099055073;
        Mon, 21 Nov 2022 22:37:35 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id y65-20020a626444000000b0056d73ef41fdsm9809385pfb.75.2022.11.21.22.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 22:37:34 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:37:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3xuKXmNjs87q3AW@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
[..]
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> +{
> +	int i, obj_idx, ret = 0;
> +	unsigned long handle;
> +	struct zspage *zspage;
> +	struct page *page;
> +	enum fullness_group fullness;
> +
> +	/* Lock LRU and fullness list */
> +	spin_lock(&pool->lock);
> +	if (list_empty(&pool->lru)) {
> +		spin_unlock(&pool->lock);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < retries; i++) {
> +		struct size_class *class;
> +
> +		zspage = list_last_entry(&pool->lru, struct zspage, lru);
> +		list_del(&zspage->lru);
> +
> +		/* zs_free may free objects, but not the zspage and handles */
> +		zspage->under_reclaim = true;
> +
> +		class = zspage_class(pool, zspage);
> +		fullness = get_fullness_group(class, zspage);
> +
> +		/* Lock out object allocations and object compaction */
> +		remove_zspage(class, zspage, fullness);
> +
> +		spin_unlock(&pool->lock);
> +
> +		/* Lock backing pages into place */
> +		lock_zspage(zspage);
> +
> +		obj_idx = 0;
> +		page = zspage->first_page;
> +		while (1) {
> +			handle = find_alloced_obj(class, page, &obj_idx);
> +			if (!handle) {
> +				page = get_next_page(page);
> +				if (!page)
> +					break;
> +				obj_idx = 0;
> +				continue;
> +			}
> +
> +			/*
> +			 * This will write the object and call zs_free.
> +			 *
> +			 * zs_free will free the object, but the
> +			 * under_reclaim flag prevents it from freeing
> +			 * the zspage altogether. This is necessary so
> +			 * that we can continue working with the
> +			 * zspage potentially after the last object
> +			 * has been freed.
> +			 */
> +			ret = pool->zpool_ops->evict(pool->zpool, handle);
> +			if (ret)
> +				goto next;
> +
> +			obj_idx++;
> +		}
> +
> +next:
> +		/* For freeing the zspage, or putting it back in the pool and LRU list. */
> +		spin_lock(&pool->lock);
> +		zspage->under_reclaim = false;
> +
> +		if (!get_zspage_inuse(zspage)) {
> +			/*
> +			 * Fullness went stale as zs_free() won't touch it
> +			 * while the page is removed from the pool. Fix it
> +			 * up for the check in __free_zspage().
> +			 */
> +			zspage->fullness = ZS_EMPTY;
> +
> +			__free_zspage(pool, class, zspage);
> +			spin_unlock(&pool->lock);
> +			return 0;
> +		}
> +
> +		putback_zspage(class, zspage);
> +		list_add(&zspage->lru, &pool->lru);
> +		unlock_zspage(zspage);

We probably better to cond_resched() somewhere here. Or in zs_zpool_shrink()
loop.

> +	}
> +
> +	spin_unlock(&pool->lock);
> +	return -EAGAIN;
> +}
