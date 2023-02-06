Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0356968C001
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjBFO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBFO0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:26:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432E76B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lnr+6hGLYXVY9PbWvQvS7JVX3UOb5tmZl31wK5H0c8k=; b=O4KGV6IjSJHdwfV1kn9LLlkjeP
        qA/3iTqUf3fyA4xu5nLIMDoChRAno6SqcDp8uK1OYFvpYvbZnmYuxEldSg+xPaRjjcx1Lo/cgJXFH
        xco1uDqJJ/vsWgAQtVhZjcM4Y1GEO+A954hDcyAHyhJAo9zxQmBSXeoahkjSvaYyXb0/MZNQtGMHv
        Zj0sF1ZbYj8JZchsrT39IE2mSFA/9fLqGzPhiR8nIve+LVCrzN783YhWJdnrja3E0tB0AeNL4gFR1
        Zv1nfhA22KbWFeNd0aHZ44IYkTqcYvzFfSJ8gf8Jtd00GpOm7JGQa4MVXtavuEKBNXyzH6u/e8VuF
        mps94PhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP2RG-00Gp2l-7i; Mon, 06 Feb 2023 14:25:46 +0000
Date:   Mon, 6 Feb 2023 14:25:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+EN6oDi5k5L9651@casper.infradead.org>
References: <20230206112856.1802547-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206112856.1802547-1-stevensd@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> @@ -1747,6 +1748,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
>  	int nr_none = 0, result = SCAN_SUCCEED;
>  	bool is_shmem = shmem_file(file);
> +	bool i_mmap_locked = false;

you don't need this ...

> +	 * While iterating, we may drop the page cache lock multiple times. It
> +	 * is safe to replace pages in the page cache with hpage while doing so
> +	 * because nobody is able to map or otherwise access the content of
> +	 * hpage until we unlock it. However, we cannot insert hpage into empty
> +	 * indicies until we know we won't have to drop the page cache lock

"indices".

> @@ -1967,6 +1974,46 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		put_page(page);
>  		goto xa_unlocked;
>  	}
> +
> +	if (nr_none) {
> +		struct vm_area_struct *vma;
> +		int nr_none_check = 0;
> +
> +		xas_unlock_irq(&xas);
> +		i_mmap_lock_read(mapping);
> +		i_mmap_locked = true;
> +		xas_lock_irq(&xas);
> +
> +		xas_set(&xas, start);
> +		for (index = start; index < end; index++) {
> +			if (!xas_next(&xas))
> +				nr_none_check++;
> +		}
> +
> +		if (nr_none != nr_none_check) {
> +			result = SCAN_PAGE_FILLED;

... you can unlock the i_mmap_lock here before the goto.


I think you need to add a case in madvise_collapse_errno().  It should
probably return -EBUSY, I would think?
