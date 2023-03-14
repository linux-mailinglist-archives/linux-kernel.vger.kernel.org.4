Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343506B8D54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCNIbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCNIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:31:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279835B5D0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SrrMtPSCVL7CXZNapSPVU/lnr45o7G/FAUywmNipyoA=; b=bhL/N2dK7N8xzpToiHwJjkz19U
        yy8xe/UY5nBr/SxwDlMD4Vgfamc1SuFUJpcOti1rlmBrb59hjtk6LnwRJy/FiIiPK+6zWaxdGRSvf
        hljBSmwvGNDdwaHp91WpRmb6uDn3XuMBtrfPJ8wVxGIwUIY1MmgC0IpEL7Nj/uETT/jubKH/VW9If
        EPwP505jermzK3b2h58HrbwBg9ujNExFJLG+BBWtb8bB/qXZEKUH6WPMJdsVzWeyu99XomTgKs43s
        OhfuYW+UnbhuEV7kd96N7LboqYpV+KYI6Xb0pr60uh5ML56w4TnlRjahguqoMAtTfisJRiMmEMSYK
        s/6FhNyw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc043-00CjO6-HV; Tue, 14 Mar 2023 08:31:23 +0000
Date:   Tue, 14 Mar 2023 08:31:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        vishal.moola@gmail.com, sidhartha.kumar@oracle.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 2/3] userfaultfd: convert __mcopy_atomic_hugetlb() to use
 a folio
Message-ID: <ZBAw21yANYPFKMi4@casper.infradead.org>
References: <20230314033734.481904-1-zhangpeng362@huawei.com>
 <20230314033734.481904-3-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314033734.481904-3-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 03:37:33AM +0000, Peng Zhang wrote:
> +++ b/include/linux/mm.h
> @@ -3546,9 +3546,8 @@ extern void copy_user_huge_page(struct page *dst, struct page *src,
>  				unsigned long addr_hint,
>  				struct vm_area_struct *vma,
>  				unsigned int pages_per_huge_page);
> -extern long copy_huge_page_from_user(struct page *dst_page,
> +extern long copy_large_folio_from_user(struct folio *dst_folio,

You can drop the 'extern'.

> +++ b/mm/memory.c
> @@ -5769,26 +5769,28 @@ void copy_user_huge_page(struct page *dst, struct page *src,
>  	process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
>  }
>  
> -long copy_huge_page_from_user(struct page *dst_page,
> +long copy_large_folio_from_user(struct folio *dst_folio,
>  				const void __user *usr_src,
> -				unsigned int pages_per_huge_page,
>  				bool allow_pagefault)
>  {
>  	void *page_kaddr;
>  	unsigned long i, rc = 0;
> -	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
> +	unsigned int nr_pages = folio_nr_pages(dst_folio);
> +	unsigned long ret_val = nr_pages * PAGE_SIZE;
>  	struct page *subpage;
> +	struct folio *inner_folio;

What is an 'inner folio'?

> -	for (i = 0; i < pages_per_huge_page; i++) {
> -		subpage = nth_page(dst_page, i);
> +	for (i = 0; i < nr_pages; i++) {
> +		subpage = folio_page(dst_folio, i);
> +		inner_folio = page_folio(subpage);
>  		if (allow_pagefault)
> -			page_kaddr = kmap(subpage);
> +			page_kaddr = kmap_local_folio(inner_folio, 0);

This doesn't do what you think it does.  Did you test this?

>  		else
>  			page_kaddr = kmap_atomic(subpage);

Pretty sure all this should be converted to kmap_local and the atomic
bits should go away.

>  		rc = copy_from_user(page_kaddr,
>  				usr_src + i * PAGE_SIZE, PAGE_SIZE);
>  		if (allow_pagefault)
> -			kunmap(subpage);
> +			kunmap_local(page_kaddr);
>  		else
>  			kunmap_atomic(page_kaddr);
>  
> @@ -5796,7 +5798,7 @@ long copy_huge_page_from_user(struct page *dst_page,
>  		if (rc)
>  			break;
>  
> -		flush_dcache_page(subpage);
> +		flush_dcache_folio(inner_folio);

The flush should probably be pulled outside the loop.

> +			err = copy_large_folio_from_user(folio,
> +						(const void __user *) src_addr, true);

I wonder if this shouldn't be 'copy_folio_from_user()'.  after all,
it'll work for any size folio, right?

