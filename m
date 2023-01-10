Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62972664E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAJVkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjAJVkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:40:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7081BB15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e1CeQZ2DgFjP1xZe09NucTQ1MWmAvdWc0wEK/Lislo8=; b=FNRC4BiOpk1zAkBDovxmqH0dTm
        UMZOxA6zBLXuVTQpK/ChQMVS9U7GnCUhWqGKtsLZKirjKOFktW+ItiRV7QiaR2FOE8yOQD+gibgwp
        Zmmx+TzfqkkzKqCzA55oVkr9sXXZ84HBFy5097PoGjih8cRG6pbouGdOODIXFBPb4aWORHicPWixC
        RBe1dT7442C+WjamHXUKOCPGMBRWVOxxZ5OhBksi/DPXoPsO43IZ7kY45OVZYZD2LbmLSWwJFtu9q
        QouvPxMAMP+DxQ6od4y8hXb5IpKVz04KH4pJRujDbXV9u5H5XaNnbJavnV5w1Xb1SZf3yVLG7xon4
        mBjSiWeg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFMLw-003YRq-0B; Tue, 10 Jan 2023 21:40:16 +0000
Date:   Tue, 10 Jan 2023 21:40:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable v2 8/8] mm/hugetlb: convert
 demote_free_huge_page to folios
Message-ID: <Y73bP5CFT/8T/DvO@casper.infradead.org>
References: <20230110212821.984047-1-sidhartha.kumar@oracle.com>
 <20230110212821.984047-9-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110212821.984047-9-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 03:28:21PM -0600, Sidhartha Kumar wrote:
> @@ -3505,6 +3505,7 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  {
>  	int nr_nodes, node;
>  	struct page *page;
> +	struct folio *folio;
>  
>  	lockdep_assert_held(&hugetlb_lock);
>  
> @@ -3518,8 +3519,8 @@ static int demote_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
>  		list_for_each_entry(page, &h->hugepage_freelists[node], lru) {
>  			if (PageHWPoison(page))
>  				continue;
> -
> -			return demote_free_huge_page(h, page);
> +			folio = page_folio(page);
> +			return demote_free_hugetlb_folio(h, folio);
>  		}
>  	}

Can't this be
		list_for_each_entry(folio, &h->hugepage_freelists[node], lru)

which avoids the call to page_folio() here.

I think the call to PageHWPoison is actually wrong here.  That would
only check the hwpoison bit on the first page, whereas we want to know
about the hwpoison bit on any page (don't we?)  So this should be
folio_test_has_hwpoisoned()?

Or is that a THP-thing that is different for hugetlb pages?
