Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AACD5E5A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 06:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIVEP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 00:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIVEPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 00:15:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8128832CC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 21:15:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECF331F8DB;
        Thu, 22 Sep 2022 04:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663820122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjD8rPTf8lcbI7hYOccNQfDum1yqtk7Eqs7SD0RHwLw=;
        b=dUmG1yIErk4qsNgbsFq+xuzScYW3ciQu8Tj5t7+g57G2H4LiRcSTjiY/sCBttj8e955ooV
        sRmDWO0VkRqOL4gtM2H+kBsLrFYglkqcc2tAmSorfeobVim2A6EUPSm2lH3iDbsXK67w1W
        sS/iQv2BU2tmOn9nmgHYqkehpWtlbfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663820122;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjD8rPTf8lcbI7hYOccNQfDum1yqtk7Eqs7SD0RHwLw=;
        b=uSHSU/CAvx2hNoUld+4CAJsUJp5e5zK1+uG4mj25fq2oNHy8rKOqZccpV/uldyNiZ9qigg
        9MrVvPBwEPvzZ2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E3A6139EF;
        Thu, 22 Sep 2022 04:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G3JUDFrhK2NEBAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 22 Sep 2022 04:15:22 +0000
Date:   Thu, 22 Sep 2022 06:15:20 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] hugetlb: freeze allocated pages before creating
 hugetlb pages
Message-ID: <YyvhWDLIgsR4AXc0@localhost.localdomain>
References: <20220921202702.106069-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921202702.106069-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 01:27:02PM -0700, Mike Kravetz wrote:
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

Looks good to me, and it makes the code much more simple:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
