Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBEC7285BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbjFHQtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjFHQst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:48:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CED19B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:48:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75d4094f9baso72781785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1686242925; x=1688834925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eh7ovuRzwnQF+N3S+z1MROh6pC2Xrfb7xbMh6ffJFxQ=;
        b=KWBJf47Wd4Jr3NOyKj9Bp8reo1vLdCc/4FYcz9oS0+TvYg4TqE18pKlKbGEdaa/iWy
         zd9Ysx/FHezhwFZ38jIurN40SFgseEyyeXgVODTzfYmPlWqGQ/P4h2SQSurx5iL+KA6B
         TiAE3RSLOFkG/oM4ptTxIizIwvVSrqKIAdIK2xLD843NdR9fmidBhsoy4dW73Wmhq0Ln
         GIHBEknDMdrdYaiW1JXf0M5E1xgXDAtRH7KUgw4jHQxD3Ei3ch8OjOyYCwj7U119hkzG
         mjIXPxMaRJWd2JqLadd7ts1tCmzR+jJ3vwiRCCcCNTjTFPGzNROL/elMH6+j+p+Lz9LF
         VAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242925; x=1688834925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh7ovuRzwnQF+N3S+z1MROh6pC2Xrfb7xbMh6ffJFxQ=;
        b=W3wWHapgbIOfWelswnzN+Uihik2gt2tRXV1fccpX/EOu/00frbxHHcxbX9O9owTVZI
         AbHi7ShMsDnq5fEmhU8UL2zdP+cY+pARWD7f2Tv2JYravjENLtSBG9WjprxSh9nVj6XN
         QCBWSJwfeS3kwTsnOJyccAK7pO2nhKa/XL7ZLBn68lp/Ebczj0iwof+Iz8xesJR3InSZ
         xfKwkD9MenC3IrSCVVrrItjOcS/it2/B7Ogaja6vjE3OnHR+puNNC4ebvo6hEhstIO81
         6jDGtdAJ6JrFNNg6tAxYnsGaSWD+T8wJ8/VVR5f760Kyh+hcL30hA3phScBpGZT7qQ48
         KI9A==
X-Gm-Message-State: AC+VfDztliIzSpemp4o8UkS39nfKWMz9MuVoRAxzDVZHeYSMDRnnhSxt
        wG05uSUbAZdlqadDlOTou/T9ig==
X-Google-Smtp-Source: ACHHUZ4DWP4YHK7s4uiExJLyVWdUVHB0evCNiHq/6Xc0Uvk97WnRft+vlfpDHW4CiR/Aj3scHjMAWQ==
X-Received: by 2002:a05:620a:4690:b0:75d:5321:fa40 with SMTP id bq16-20020a05620a469000b0075d5321fa40mr6248864qkb.51.1686242925405;
        Thu, 08 Jun 2023 09:48:45 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a06d600b0074fafbea974sm457688qky.2.2023.06.08.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:48:45 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:48:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v2 6/7] mm: zswap: simplify writeback function
Message-ID: <20230608164844.GF352940@cmpxchg.org>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
 <20230606145611.704392-7-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606145611.704392-7-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Domenico,

On Tue, Jun 06, 2023 at 04:56:10PM +0200, Domenico Cerasuolo wrote:
> Previously, in zswap, the writeback function was passed to zpool drivers
> for their usage in calling the writeback operation. However, since the
> drivers did not possess references to entries and the function was
> specifically designed to work with handles, the writeback process has
> been modified to occur directly within zswap.

I'm having trouble parsing this sentence.

> Consequently, this change allows for some simplification of the
> writeback function, taking into account the updated workflow.

How about:

zswap_writeback_entry() used to be a callback for the backends, which
don't know about struct zswap_entry.

Now that the only user is the generic zswap LRU reclaimer, it can be
simplified: pass the pinned zswap_entry directly, and consolidate the
refcount management in the shrink function.

> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 69 ++++++++++++++----------------------------------------
>  1 file changed, 17 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2831bf56b168..ef8604812352 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -250,7 +250,8 @@ static bool zswap_has_pool;
>  	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
>  		 zpool_get_type((p)->zpool))
>  
> -static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
> +static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
> +				 struct zswap_tree *tree);
>  static int zswap_pool_get(struct zswap_pool *pool);
>  static void zswap_pool_put(struct zswap_pool *pool);
>  
> @@ -632,15 +633,21 @@ static int zswap_shrink(struct zswap_pool *pool)
>  	}
>  	spin_unlock(&tree->lock);
>  
> -	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
> +	ret = zswap_writeback_entry(lru_entry, zhdr, tree);
>  
>  	spin_lock(&tree->lock);
>  	if (ret) {
>  		spin_lock(&pool->lru_lock);
>  		list_move(&lru_entry->lru, &pool->lru);
>  		spin_unlock(&pool->lru_lock);

This could use a comment.

		/* Writeback failed, put entry back on LRU */

> +		zswap_entry_put(tree, tree_entry);

This put is a common factor in both branches, so you can consolidate.

> +	} else {
> +		/* free the local reference */
> +		zswap_entry_put(tree, tree_entry);
> +		/* free the entry if it's not been invalidated*/

Missing space between text and */

> +		if (lru_entry == zswap_rb_search(&tree->rbroot, swpoffset))
> +			zswap_entry_put(tree, tree_entry);
>  	}
> -	zswap_entry_put(tree, tree_entry);
>  	spin_unlock(&tree->lock);

The success path freeing (hopefully the common path) is now
unfortunately hidden in fairly deep indentation. I think this would be
better with a goto for the error case.

All together, something like this?

	if (ret) {
		/* Writeback failed, put entry back on LRU */
		...
		goto put_unlock;
	}

	/*
	 * Writeback started successfully, the page now belongs to the
	 * swapcache. Drop the base ref from the tree - unless invalidate
	 * already took it out while we had the tree->lock released for IO.
	 */
	if (lru_entry == zswap_rb_search(&tree->rb_root, swpoffset))
		zswap_entry_put(tree, entry);

put_unlock:
	/* Drop local reference */
	zswap_entry_put(tree, tree_entry);
	spin_unlock(&tree->lock);

	return ret ? -EAGAIN : 0;

Btw, it's unsettling that we drop the tree reference without
explicitly removing the entry for the tree. We rely on the final put
that frees the entry to do tree removal, but this doesn't happen if
somebody else is holding a reference; the entry can remain in the tree
long after we've officially handed over ownership of the data to
swapcache. TTBOMK there are currently no bugs because of that, but
it's a data corruption waiting to happen.

This should be:

	/*
	 * Writeback started successfully, the page now belongs to the
	 * swapcache. Drop the entry from zswap - unless invalidate already
	 * took it out while we had the tree->lock released for IO.
	 */
	if (entry == zswap_rb_search(&tree->rb_root, swpoffset))
		zswap_invalidate_entry(tree, entry);

Would you care to send a follow-up patch?
