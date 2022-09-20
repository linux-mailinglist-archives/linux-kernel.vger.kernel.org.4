Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F05BDB21
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiITEDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiITEDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:03:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FB632B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:03:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BA571F388;
        Tue, 20 Sep 2022 04:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663646580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lv+1pLscsnrBbnFu732MJDcdMkpx4lhLo+NKm9WmeA=;
        b=1k+hZz9Cx4oQ8CUogRqpFgdCDpxlbOWirCrEmYdOU6PaoZ05Eyr+VcGfAL4YXELauLBlW9
        tWDapyWnG/CDnU/HnsA01wvUjmKS66xWVccLkq9kh7SEdV/r3ykAISEl+qy6yajgpfGl0o
        kVIsJ/c/oMjUOpyJRrpRKca9eL6bRT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663646580;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lv+1pLscsnrBbnFu732MJDcdMkpx4lhLo+NKm9WmeA=;
        b=PYcT9LQHQFl/X6jtNGJymqbsnpaOVlva7lCu4SrTn/6gCPCMCvDJhPZjUsLeGJ5iiQfDeA
        lbqfeDAer9McPICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0A2813ABD;
        Tue, 20 Sep 2022 04:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FVIsLHI7KWOyfwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 20 Sep 2022 04:02:58 +0000
Date:   Tue, 20 Sep 2022 06:02:56 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: freeze allocated pages before creating
 hugetlb pages
Message-ID: <Yyk7cN8KhUlNFmM8@localhost.localdomain>
References: <20220916214638.155744-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916214638.155744-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:46:38PM -0700, Mike Kravetz wrote:
> When creating hugetlb pages, the hugetlb code must first allocate
> contiguous pages from a low level allocator such as buddy, cma or
> memblock.  The pages returned from these low level allocators are
> ref counted.  This creates potential issues with other code taking
> speculative references on these pages before they can be transformed to
> a hugetlb page.  This issue has been addressed with methods and code
> such as that provided in [1].
> 
> Recent discussions about vmemmap freeing [2] have indicated that it
> would be beneficial to freeze all sub pages, including the head page
> of pages returned from low level allocators before converting to a
> hugetlb page.  This helps avoid races if we want to replace the page
> containing vmemmap for the head page.
> 
> There have been proposals to change at least the buddy allocator to
> return frozen pages as described at [3].  If such a change is made, it
> can be employed by the hugetlb code.  However, as mentioned above
> hugetlb uses several low level allocators so each would need to be
> modified to return frozen pages.  For now, we can manually freeze the
> returned pages.  This is done in two places:
> 1) alloc_buddy_huge_page, only the returned head page is ref counted.
>    We freeze the head page, retrying once in the VERY rare case where
>    there may be an inflated ref count.
> 2) prep_compound_gigantic_page, for gigantic pages the current code
>    freezes all pages except the head page.  New code will simply freeze
>    the head page as well.
> 
> In a few other places, code checks for inflated ref counts on newly
> allocated hugetlb pages.  With the modifications to freeze after
> allocating, this code can be removed.
> 
> After hugetlb pages are freshly allocated, they are often added to the
> hugetlb free lists.  Since these pages were previously ref counted, this
> was done via put_page() which would end up calling the hugetlb
> destructor: free_huge_page.  With changes to freeze pages, we simply
> call free_huge_page directly to add the pages to the free list.
> 
> In a few other places, freshly allocated hugetlb pages were immediately
> put into use, and the expectation was they were already ref counted.  In
> these cases, we must manually ref count the page.
> 
> [1] https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/
> [2] https://lore.kernel.org/linux-mm/20220802180309.19340-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/linux-mm/20220809171854.3725722-1-willy@infradead.org/
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Hi Mike,

this looks great and simplifies the code much more.
I got a question though:

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1787,9 +1787,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  
>  	/* we rely on prep_new_huge_page to set the destructor */
>  	set_compound_order(page, order);
> -	__ClearPageReserved(page);
>  	__SetPageHead(page);
> -	for (i = 1; i < nr_pages; i++) {
> +	for (i = 0; i < nr_pages; i++) {
>  		p = nth_page(page, i);
>  
>  		/*
> @@ -1830,17 +1829,19 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
>  		} else {
>  			VM_BUG_ON_PAGE(page_count(p), p);
>  		}
> -		set_compound_head(p, page);
> +		if (i != 0)
> +			set_compound_head(p, page);

Sure I am missing something here, but why we only freeze refcount here
in case it is for demote?
We seem to be doing it inconditionally in alloc_buddy_huge_page.


-- 
Oscar Salvador
SUSE Labs
