Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0326B674CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjATFnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATFny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:43:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75865A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7mSwR5Y0cDoaofS+SYCx3DCXdbofPPtO+Pvvj0DejHE=; b=AAtbPr4IEovx1NM4Zm0y0jAFzL
        Z8avf6ODlkJKEU4jPCCpel0dRxZSdJLgNT0I46T8QP3zGnudyX2VngP7EslecHtQdeKpP33HmXJ5Y
        lLDwlkomFaPm/jTrXxtyOddMPcYqSujrc05vdj/+L5djti7+lkuLa9byohNDIqqiE2vNimGYvix/K
        /Xbb8MKggofUU986rMpYfZ5CrFEz3j5AT36KRON41EPX0/+vYqp9umduGUQQFR+zO62tXPlHCJ5mz
        9FOuHjU+NmzmB05o0DvJBrORXay5w5PTS4fcRl8GLPyQxW1FjLsHCE0rjIbGM5+IiqKoT4zccBuue
        UPTfDcPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIkBk-001hds-Qp; Fri, 20 Jan 2023 05:43:44 +0000
Date:   Fri, 20 Jan 2023 05:43:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, jhubbard@nvidia.com
Subject: Re: [PATCH 2/9] mm/hugetlb: convert hugetlbfs_pagecache_present() to
 folios
Message-ID: <Y8oqEOICcNV762IA@casper.infradead.org>
References: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
 <20230119211446.54165-3-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119211446.54165-3-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:14:39PM -0800, Sidhartha Kumar wrote:
> +++ b/mm/hugetlb.c
> @@ -5653,15 +5653,15 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
>  {
>  	struct address_space *mapping;
>  	pgoff_t idx;
> -	struct page *page;
> +	struct folio *folio;
>  
>  	mapping = vma->vm_file->f_mapping;
>  	idx = vma_hugecache_offset(h, vma, address);
>  
> -	page = find_get_page(mapping, idx);
> -	if (page)
> -		put_page(page);
> -	return page != NULL;
> +	folio = filemap_get_folio(mapping, idx);
> +	if (folio)
> +		folio_put(folio);
> +	return folio != NULL;
>  }

Seems to me this function could be ...

	struct address_space *mapping = vma->vm_file->f_mapping;
	pgoff_t index = vma_hugecache_offset(h, vma, address);
	bool present;

	rcu_read_lock();
	present = page_cache_next_miss(mapping, index, 1) != index;
	rcu_read_unlock();

	return present;

No need to get/drop a refcount on the folio.  It's a bit similar to
filemap_range_has_page(), but the API is wrong.  Maybe there's room
for a little refactoring here.
