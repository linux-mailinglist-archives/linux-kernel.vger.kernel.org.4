Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33165C885
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjACVAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjACVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:00:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA38EE33
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 13:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lQIrLUPIl+i/y2McQ1KqovnwZ37cPRNSnM0HrSIfVis=; b=U5Yd3TP8tnDWS6O60ptT4qa7jt
        RBmNen4FN/NtclUgVvGiIGuxpwRXoVrRtBWIXk6Kz+9PnIBEq/LjhjQCR8WNFd05sR8P0kE++2lnC
        +OMZS9ptA/MakBJ+CgZs0v9O7oIeHFgdXDuqUFU8UPxnPpE2ZmOKeuSc474x00KOj4b4refXOIYqr
        3p0RLQjw/wztNADrYv+gAl3+1fcOK0cBniioz1Ab/Kj+P5pXzb0R1Kdv3396Q60d0+/J9e4y7wa9u
        WaYNRmJRiQ2Ax9rLQpRQfmWshtiUFfLrqePpUupI3yrrEjIg6iB8DUXiiARn9hMRnTxyxIZp66CLB
        ElF5w8WQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCoOK-00EPEc-NI; Tue, 03 Jan 2023 21:00:12 +0000
Date:   Tue, 3 Jan 2023 21:00:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 3/8] mm/hugetlb: convert
 dequeue_hugetlb_page_node functions to folios
Message-ID: <Y7SXXF4sGEjR1um5@casper.infradead.org>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-4-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-4-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 01:13:35PM -0600, Sidhartha Kumar wrote:
> +static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
> +								int nid)
>  {
>  	struct page *page;
> +	struct folio *folio;
>  	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
>  
>  	lockdep_assert_held(&hugetlb_lock);
>  	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> -		if (pin && !is_longterm_pinnable_page(page))
> +		folio = page_folio(page);

I'd argue that you can pull folios directly off the hugepage_freelists.
Since they're attached through the 'lru', you know they're not tail
pages, because lru.prev aliases with compound_head.

The rest looks good.
