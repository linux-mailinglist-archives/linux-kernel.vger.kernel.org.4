Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AF864A466
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiLLPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiLLPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:48:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ABD6363
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vaLl2lmaBY1A7ozGAH59ujZxWxDJ+CzoiCtu0mQiesw=; b=a2W12krnsiY2NXtqCTv98uv6yB
        MGsPHbvqEcJapFUa9opC2ddhGoMNkTi5pXgnNVdNV2snBJRLrL8miGFMrgl8wmpl8Lni1XWv0LWR4
        lSaG+c6oPxVzBSWMOa0PWuYDVNP6Grto1SNAT2oYUYz7KoNU+/ulXYGe3ZUdll9Rt7YX0gkKp/J3L
        CRWB/Qc0oO3NXsOSkQeQbf68kUXVJZ47/iEpzQAEZvkYV2w+1eNX0+XKCGBKDui58fC5vyQcgG56i
        uVL6Sgfw5FNtZlkKIGr/uXdXWXnwN0i4hOqmqOlSU51myUHN5MEabZ0JV/QpK75/AFjBFcGfKi8CL
        BBB1S+eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4l2L-00BCCI-2K; Mon, 12 Dec 2022 15:48:13 +0000
Date:   Mon, 12 Dec 2022 15:48:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        kernel-team@meta.com
Subject: Re: [PATCH v3 3/4] cachestat: implement cachestat syscall
Message-ID: <Y5dNPYVNyjHgGCD6@casper.infradead.org>
References: <20221208202808.908690-1-nphamcs@gmail.com>
 <20221208202808.908690-4-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208202808.908690-4-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 12:28:07PM -0800, Nhat Pham wrote:
> +		struct address_space *mapping = f.file->f_mapping;
> +		pgoff_t first_index = off >> PAGE_SHIFT;
> +		pgoff_t last_index =
> +			len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> +		XA_STATE(xas, &mapping->i_pages, first_index);
> +		struct folio *folio;
> +
> +		rcu_read_lock();
> +		xas_for_each(&xas, folio, last_index) {
> +			if (xas_retry(&xas, folio) || !folio)
> +				continue;

!folio can't be true.  xas_for_each() terminates when folio is NULL.

> +			if (xa_is_value(folio)) {
> +				/* page is evicted */
> +				void *shadow = (void *)folio;
> +				bool workingset; /* not used */
> +
> +				cs.nr_evicted += 1;
> +
> +#ifdef CONFIG_SWAP /* implies CONFIG_MMU */
> +				if (shmem_mapping(mapping)) {
> +					/* shmem file - in swap cache */
> +					swp_entry_t swp = radix_to_swp_entry(folio);
> +
> +					shadow = get_shadow_from_swap_cache(swp);
> +				}
> +#endif
> +				if (workingset_test_recent(shadow, true, &workingset))
> +					cs.nr_recently_evicted += 1;
> +
> +				continue;
> +			}
> +
> +			/* page is in cache */
> +			cs.nr_cache += 1;
> +
> +			if (folio_test_dirty(folio))
> +				cs.nr_dirty += 1;
> +
> +			if (folio_test_writeback(folio))
> +				cs.nr_writeback += 1;

A folio may represent more than one page.  That's the point of folios.
So there should be something in here which does

	unsigned long nr = folio_nr_pages();

and then all these '1' should be 'nr'.

Except that you may need to adjust nr if 'first_index' > folio->index, or
'last_index' < folio->index + nr.

You should test this with XFS, AFS or erofs to be sure you're getting
results that look right.

