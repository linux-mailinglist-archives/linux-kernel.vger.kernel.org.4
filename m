Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9FB72CD11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjFLRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjFLRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:41:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EFC192
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sNl+hcryem5Y2/j0f2cuNCgFGRudQH14t8rQ8cm/MbI=; b=ouxD9IGfTfZnLyn9OTfUsnd8nV
        ikl5mOZEPvINin0YG/uuz8Vmd3EmL3v2JrtasamcPwgkgZZK/lk3QLAq2qvnJYvNLweiZv4wa70yf
        U/1hkqg9xQDVeMIRJdSCNc3p4etLodMrI93p263iJ19Qtn7F/0C4yIK/3v9lSmNT0TVV3+KgBCBuy
        DDmexoIeChjyIrP81oD4HDoQogjvxhX9DZ+jEnZPpNhqauI2l7fswV5JUFMNHugWFh+MyHHTdxWL4
        A21JLUyH1UmN9jwKXSPBpnCH17v4bdGh4xIn6Jc684SEL/UvxfQZxJyyIohyhubr7uhEwvhD9NDyi
        VYdTM8CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8lXp-002sqC-KJ; Mon, 12 Jun 2023 17:41:33 +0000
Date:   Mon, 12 Jun 2023 18:41:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, almasrymina@google.com,
        linmiaohe@huawei.com, minhquangbui99@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page
 to folios
Message-ID: <ZIdYzZGSUzYumrCT@casper.infradead.org>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-6-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101223059.460937-6-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:30:55PM -0700, Sidhartha Kumar wrote:
> +++ b/mm/hugetlb.c
> @@ -2815,7 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>  {
>  	struct hstate *h;
> -	struct page *head;
> +	struct folio *folio = page_folio(page);

Is this safe?  I was reviewing a different patch today, and I spotted
this.  With THP, we can relatively easily hit this case:

struct page points to a page with pfn 0x40305, in a folio of order 2.
We call page_folio() on it and the resulting pointer is for the folio
with pfn 0x40304.
If we don't have our own refcount (or some other protection ...) against
freeing, the folio can now be freed and reallocated.  Say it's now part
of an order-3 folio.
Our 'folio' pointer is now actually a pointer to a tail page, and we
have various assertions that a folio pointer doesn't point to a tail
page, so they trigger.

It seems to me that this ...

        /*
         * The page might have been dissolved from under our feet, so make sure
         * to carefully check the state under the lock.
         * Return success when racing as if we dissolved the page ourselves.
         */
        spin_lock_irq(&hugetlb_lock);
        if (folio_test_hugetlb(folio)) {
                h = folio_hstate(folio);
        } else {
                spin_unlock_irq(&hugetlb_lock);
                return 0;
        }

implies that we don't have our own reference on the folio, so we might
find a situation where the folio pointer we have is no longer a folio
pointer.

Maybe the page_folio() call should be moved inside the hugetlb_lock
protection?  Is that enough?  I don't know enough about how hugetlb
pages are split, freed & allocated to know what's going on.

But then we _drop_ the lock, and keep referring to ...

> @@ -2841,10 +2840,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
>  	if (hstate_is_gigantic(h))
>  		return -ENOMEM;
>  
> -	if (page_count(head) && !isolate_hugetlb(head, list))
> +	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
>  		ret = 0;
> -	else if (!page_count(head))
> -		ret = alloc_and_dissolve_huge_page(h, head, list);
> +	else if (!folio_ref_count(folio))
> +		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);

And I fall back to saying "I don't know enough to know if this is safe".
