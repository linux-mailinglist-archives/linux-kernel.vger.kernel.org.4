Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B236334FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiKVF7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiKVF7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:59:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E312A9A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/dabyszLrJLcZ4mnIdkzcDGXW3b0QS/17vlN2tcOYk=; b=qgAqZiQIlxnncE0oOqdTVVQyUq
        zdR88DGEE+hpdJp4oF0A5V6ykerYoL5iDYsc5A+An0Nu3u5bFKb9qpgLOjD6aRn4PSBiWvuKfIG/M
        3r0gANmpwOfh0uJh439/kL0P5RJQsDMnutkBUN9CAW3N2SHISwkoAHUrovW2PHenKjSETdcPQMsQ8
        Y7hAt2lHksolpozX32NJEBcKtL15WkLNfEYAZCl2S/kU5yCNI4kEhG2rO7huIHNQnKQbgM5VmT8LA
        l9amt7FI+6dJwnoxBt+gx3l/Xrcg5ilTASVpJ4Wdt4Kq9RI1+Tn1rwea+zTlB/BQjQSiWQidytv5r
        m3iYB0iQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxMHu-005zsc-6U; Tue, 22 Nov 2022 05:57:42 +0000
Date:   Tue, 22 Nov 2022 05:57:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm,thp,rmap: rework the use of subpages_mapcount
Message-ID: <Y3xk1hX5QrCZMT4q@casper.infradead.org>
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <c4b8485b-1f26-1a5f-bdf-c6c22611f610@google.com>
 <20221121165938.oid3pemsfkaeq3ws@google.com>
 <Y3vI58VtjiAkorUX@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vI58VtjiAkorUX@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 01:52:23PM -0500, Johannes Weiner wrote:
> That leaves clearing writeback. This can't hold the page lock due to
> the atomic context, so currently we need to take lock_page_memcg() as
> the lock of last resort.
> 
> I wonder if we can have cgroup take the xalock instead: writeback
> ending on file pages always acquires the xarray lock. Swap writeback
> currently doesn't, but we could make it so (swap_address_space).
> 
> The only thing that gives me pause is the !mapping check in
> __folio_end_writeback. File and swapcache pages usually have mappings,
> and truncation waits for writeback to finish before axing
> page->mapping. So AFAICS this can only happen if we call end_writeback
> on something that isn't under writeback - in which case the test_clear
> will fail and we don't update the stats anyway. But I want to be sure.
> 
> Does anybody know from the top of their heads if a page under
> writeback could be without a mapping in some weird cornercase?

I can't think of such a corner case.  We should always wait for
writeback to finish before removing the page from the page cache;
the writeback bit used to be (and kind of still is) an implicit
reference to the page, which means that we can't remove the page
cache's reference to the page without waiting for writeback.

> If we could ensure that the NR_WRITEBACK decs are always protected by
> the xalock, we could grab it from mem_cgroup_move_account(), and then
> kill lock_page_memcg() altogether.

I'm not thrilled by this idea, but I'm not going to veto it.
