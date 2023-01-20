Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE60674CED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjATGAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjATGAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:00:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9DA3EFE5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=grTPQVs1o65Goog9D411dPyOgF0S6jRwshWihcoTPGM=; b=AiVphAZwRIN0bxGiIURZtJrD5W
        6xPn51wT93XyajnEGvoZPto3pOPOSaau1L3dZgkJht5L0c3PPesyQXaWf0o4vjvaHhpQa7sqBe6DT
        gjHEK8ZdiaqAiYLRuc8yqbbUc39taM2LMi4JIkkjpVMW1AbGLcC08VWYnFMG5Sk2C+0929pUqsD0j
        JC+PZ7tWKcZdryy+XtZFxLsZWE9sxcbORKbbuVv9gEiQZ3VKZw8ig/AxHqlB79qTwe3+jQB3+l1wG
        iFRjY7KcgaqfRBz4ARwNFSmqKg01wGlEVlyCgO3lj54aoofEv4LiY4RuMpQbxOXovBlcaBcuC3rUP
        SjhrliFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIkRZ-001iHW-G2; Fri, 20 Jan 2023 06:00:05 +0000
Date:   Fri, 20 Jan 2023 06:00:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
Subject: Re: [PATCH 4/9] mm/rmap: change hugepage_add_new_anon_rmap to take
 in a folio
Message-ID: <Y8ot5Y01TWmB4sBj@casper.infradead.org>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-5-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119211446.54165-5-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:14:41PM -0800, Sidhartha Kumar wrote:
> @@ -5599,9 +5603,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  		goto out_release_all;
>  	}
>  
> -	copy_user_huge_page(new_page, old_page, address, vma,
> +	copy_user_huge_page(&new_folio->page, old_page, address, vma,
>  			    pages_per_huge_page(h));

We have a folio_copy(), but it feels to me like we need a
folio_copy_user() so that we can use copy_user_page() on machines
with virtual caches.

> @@ -6176,6 +6186,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	spinlock_t *ptl;
>  	int ret = -ENOMEM;
>  	struct page *page;
> +	struct folio *folio = NULL;
>  	int writable;
>  	bool page_in_pagecache = false;
>  
> @@ -6251,12 +6262,15 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  		*pagep = NULL;
>  	}
>  
> +	if (page)
> +		folio = page_folio(page);
> +
>  	/*
> -	 * The memory barrier inside __SetPageUptodate makes sure that
> +	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * preceding stores to the page contents become visible before
>  	 * the set_pte_at() write.
>  	 */
> -	__SetPageUptodate(page);
> +	__folio_mark_uptodate(folio);

I suggest that "page" can never be NULL or __SetPageUptodate() would
have crashed.

