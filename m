Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4886366D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiKWRSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbiKWRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:18:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C23CC3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:18:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id g10so12884313qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwvPiJ/FeIr0Mz9lZfh35WWzSLWvCKU31ofAXU9cKEM=;
        b=gr6DO3Oh3skW8tb7D2/B9WOQNEtkPRHHjzUdtvmzXPZka6wGY/ceBYbCRSyXSY5AP9
         V0vFrXdXO51oP5M9qw+n5uAdYAR51QxT7SFnBDaccuwY2V933/n+FmLYRj8L1Ahk4hmQ
         2xH1fYb4CEJKv8BoukY3TDmI1xnM+nOm1yoaEKh5ANXUcap3zZK1+OY7DoE1uvROFHxZ
         v+9+PzwLsDn/7H5Lnzt4mlH6OFeBxspzcMWWMBUJCKR9XQmHADzkFo/TKhXOuriwKU78
         kfDrZ3nlYvYEmmmTzwJWkuExmBQ3uCMJ/zyoDt1SjW4TM58DPZ1lfbKmYWRBgPKX5Q1x
         X4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwvPiJ/FeIr0Mz9lZfh35WWzSLWvCKU31ofAXU9cKEM=;
        b=xVWR0w/jFUFem14FRrCxTUJL8RbDd2k8TZEO0GXat5EsKLwzlSt9EU2KsNE8memRw4
         LLtsHSNW2Db4LNMyA0lOUJ2f/X37t1c8HjqH5s7VB5yCGw4SCpbPL/vpLxzNUU1/q2nR
         Hl8c58AHq3ynEXmr4bpuD2jXivXJXEFMLW4t9LfPEZI24wEy862UDPUs2rrRnEI9AoKv
         CuF711aj7ogoq/I5ysUJMqwiZFpPOaDBKmSbH0ndrOA3a7Z1qE0z2xVOCpCLnGiAE2Bu
         LLE3C7gLiYnCnTXgnTVQFOKYJoCP4mzSYJxB/StWj+MYaCX9/ryuZwtoD1YPBZYKcleQ
         eWgw==
X-Gm-Message-State: ANoB5pm1lE/XrQ02f83ssnhk2XBUkUk1S88pmZYc7Wj5vhYlAyp03/Gr
        Yq7xnBcxp3j96QYzg3Uuoy8KAA==
X-Google-Smtp-Source: AA0mqf7xRfTB/UejWMIfr3NInpGb5Rlt1+RLepAPyJ05e/VDNphvwLRHhnkFG3PQr5xRQ8tpVnC/og==
X-Received: by 2002:a37:9a15:0:b0:6fb:6221:18a3 with SMTP id c21-20020a379a15000000b006fb622118a3mr26200055qke.230.1669223900337;
        Wed, 23 Nov 2022 09:18:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id fz10-20020a05622a5a8a00b003a50d92f9b4sm10141541qtb.1.2022.11.23.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:18:19 -0800 (PST)
Date:   Wed, 23 Nov 2022 12:18:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y35V9vTQgOe9al/1@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3xuKXmNjs87q3AW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xuKXmNjs87q3AW@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:37:29PM +0900, Sergey Senozhatsky wrote:
> On (22/11/18 16:15), Nhat Pham wrote:
> [..]
> > +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
> > +{
> > +	int i, obj_idx, ret = 0;
> > +	unsigned long handle;
> > +	struct zspage *zspage;
> > +	struct page *page;
> > +	enum fullness_group fullness;
> > +
> > +	/* Lock LRU and fullness list */
> > +	spin_lock(&pool->lock);
> > +	if (list_empty(&pool->lru)) {
> > +		spin_unlock(&pool->lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = 0; i < retries; i++) {
> > +		struct size_class *class;
> > +
> > +		zspage = list_last_entry(&pool->lru, struct zspage, lru);
> > +		list_del(&zspage->lru);
> > +
> > +		/* zs_free may free objects, but not the zspage and handles */
> > +		zspage->under_reclaim = true;
> > +
> > +		class = zspage_class(pool, zspage);
> > +		fullness = get_fullness_group(class, zspage);
> > +
> > +		/* Lock out object allocations and object compaction */
> > +		remove_zspage(class, zspage, fullness);
> > +
> > +		spin_unlock(&pool->lock);
> > +
> > +		/* Lock backing pages into place */
> > +		lock_zspage(zspage);
> > +
> > +		obj_idx = 0;
> > +		page = zspage->first_page;
> > +		while (1) {
> > +			handle = find_alloced_obj(class, page, &obj_idx);
> > +			if (!handle) {
> > +				page = get_next_page(page);
> > +				if (!page)
> > +					break;
> > +				obj_idx = 0;
> > +				continue;
> > +			}
> > +
> > +			/*
> > +			 * This will write the object and call zs_free.
> > +			 *
> > +			 * zs_free will free the object, but the
> > +			 * under_reclaim flag prevents it from freeing
> > +			 * the zspage altogether. This is necessary so
> > +			 * that we can continue working with the
> > +			 * zspage potentially after the last object
> > +			 * has been freed.
> > +			 */
> > +			ret = pool->zpool_ops->evict(pool->zpool, handle);
> > +			if (ret)
> > +				goto next;
> > +
> > +			obj_idx++;
> > +		}
> > +
> > +next:
> > +		/* For freeing the zspage, or putting it back in the pool and LRU list. */
> > +		spin_lock(&pool->lock);
> > +		zspage->under_reclaim = false;
> > +
> > +		if (!get_zspage_inuse(zspage)) {
> > +			/*
> > +			 * Fullness went stale as zs_free() won't touch it
> > +			 * while the page is removed from the pool. Fix it
> > +			 * up for the check in __free_zspage().
> > +			 */
> > +			zspage->fullness = ZS_EMPTY;
> > +
> > +			__free_zspage(pool, class, zspage);
> > +			spin_unlock(&pool->lock);
> > +			return 0;
> > +		}
> > +
> > +		putback_zspage(class, zspage);
> > +		list_add(&zspage->lru, &pool->lru);
> > +		unlock_zspage(zspage);
> 
> We probably better to cond_resched() somewhere here. Or in zs_zpool_shrink()
> loop.

Hm, yeah I suppose that could make sense if we try more than one page.

We always hold either the pool lock or the page locks, and we probably
don't want to schedule with the page locks held. So it would need to
actually lockbreak the pool lock. And then somebody can steal the page
and empty the LRU under us, so we need to check that on looping, too.

Something like this?

for (i = 0; i < retries; i++) {
	spin_lock(&pool->lock);
	if (list_empty(&pool->lru)) {
		spin_unlock(&pool->lock);
		return -EINVAL;
	}
	zspage = list_last_entry(&pool->lru, ...);

	...

	putback_zspage(class, zspage);
	list_add(&zspage->lru, &pool->lru);
	unlock_zspage(zspage);
	spin_unlock(&pool->lock);

	cond_resched();
}
return -EAGAIN;
