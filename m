Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61FB68CC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBGCaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGC36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:29:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2E3430F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SASaUnYdxhNK3uDt7Eh9RINEEFziNC6Cq2V1+B/g2OY=; b=WLZaBcaJ5P/wG6jQQ4o2uEYgrB
        jnmuzERagNZXMiDSga9F0Yr9YyhdHtNPVTjqA2xLJbgTYL39VEzQ1NPMcORpHp9l1oM9tz3yBbPuQ
        A3C0E6bbIml9q6+UoP5cW09zwUFPN5YyakV1FavAZU9txjE7POxC8T40FCBXrS0GP2T1FYxzR0vYV
        3SxGpY4EaCtQQFbczKLDCBeb1A8+oyXE+gFJgwBuo0fTpMFca0Wc2oWnKlCCxPckAgHCTcLQhp6hh
        zzIZl1pPaq+nBEV0SNuMhWs+9wgZ7gimLJjdfGjxnBeoBh8aH3uRvPi0Q7q4C9HkdRNhsdEg633gz
        sOv8UGXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPDjo-00HMol-5u; Tue, 07 Feb 2023 02:29:40 +0000
Date:   Tue, 7 Feb 2023 02:29:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+G3lDu3UPFZcFE0@casper.infradead.org>
References: <20230206112856.1802547-1-stevensd@google.com>
 <Y+FOk+ty7OKmkwLL@casper.infradead.org>
 <Y+Fog2dO1kpRBMvr@x1n>
 <Y+F2IdXhqc5187s+@casper.infradead.org>
 <CAD=HUj4yhMLnBNpumxC4urSY2Js5XuekzGP+UOXJmUV=k5nx=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj4yhMLnBNpumxC4urSY2Js5XuekzGP+UOXJmUV=k5nx=A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:37:06AM +0900, David Stevens wrote:
> On Tue, Feb 7, 2023 at 6:50 AM Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Feb 06, 2023 at 03:52:19PM -0500, Peter Xu wrote:
> > > The problem is khugepaged will release pgtable lock during collapsing, so
> > > AFAICT there can be a race where some other thread tries to insert pages
> > > into page cache in parallel with khugepaged right after khugepaged released
> > > the page cache lock.
> > >
> > > For example, it seems to me new page cache can be inserted when khugepaged
> > > is copying small page content to the new hpage.
> 
> This particular race can't happen with either patch, since the missing
> page cache entries are filled when we create the multi-index entry for
> hpage.

Can too.

        for (index = start; index < end; index++) {
...
                        if (xa_is_value(page) || !PageUptodate(page)) {
                                xas_unlock_irq(&xas);
                                /* swap in or instantiate fallocated page */
                                if (shmem_get_folio(mapping->host, index,
                                                &folio, SGP_NOALLOC)) {
                                        result = SCAN_FAIL;
                                        goto xa_unlocked;
                                }
...

So we start the iteration, and then a page fault happens in one of
the indices we've already examined, but we don't have the page on
the list.  It's a nice wide race too because we're bringing the
page in from swap.

