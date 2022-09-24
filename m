Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF25E9065
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 01:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiIXXEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 19:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIXXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 19:04:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4B13DD7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XI8SnLt7fZCje/Cy7JRzciHbS6L1kHCIzjqI91qcSR4=; b=BMyoGJSG0g0/RlZuDE0QvWc0ms
        tqhssJEgIUyZlG7FKDSSy/Kb+q9MjbBu1/JaoESSsI3DCIoe/YANY9dIGiUmPQT3Zwm2FzHzoCmBi
        i84VL1LoSCvHgU7fNORqvzeQpVYlURTRCDf5uWj4oey8m1XAfS65MflsD2Sa9SfIVPfbsNcnMRrjp
        c9JVeDo1IKZI68+KzVtOda8AuyXVSPgABmVYqvyATo3cxAkuowhCKr2BtEPQjSXgREmyZtRywINdV
        bTxsDyegQW/oe67fTx5f15Q9VkbSwBN1dHg1lB1pGklXeSQtZomra6NeYxAhDNH3Fn7GinvKmx3kf
        JjgXoJgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocECO-0096Ty-1O; Sat, 24 Sep 2022 23:04:40 +0000
Date:   Sun, 25 Sep 2022 00:04:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] mm: move PG_slab flag to page_type
Message-ID: <Yy+NCJ525S+HzP4k@casper.infradead.org>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919125708.276864-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:57:08PM +0900, Hyeonggon Yoo wrote:
> For now, only SLAB uses _mapcount field as a number of active objects in
> a slab, and other slab allocators do not use it. As 16 bits are enough
> for that, use remaining 16 bits of _mapcount as page_type even when
> SLAB is used. And then move PG_slab flag to page_type!
> 
> Note that page_type is always placed in upper 16 bits of _mapcount to
> avoid confusing normal _mapcount as page_type. As underflow (actually
> I mean, yeah, overflow) is not a concern anymore, use more lower bits
> except bit zero.
> 
> Add more folio helpers for PAGE_TYPE_OPS() not to break existing
> slab implementations.
> 
> Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
> check if _mapcount is properly set at free.
> 
> Exclude PG_slab from hwpoison and show_page_flags() for now.
> 
> Note that with this patch, page_mapped() and folio_mapped() always return
> false for slab page.

This is an interesting approach.  It raises some questions.

First, you say that folio_mapped() returns false for slab pages.  That's
only true for order-0 slab pages.  For larger pages,

        if (!folio_test_large(folio))
                return atomic_read(&folio->_mapcount) >= 0;
        if (atomic_read(folio_mapcount_ptr(folio)) >= 0)
                return true;

so that's going to depend what folio_mapcount_ptr() aliases with.

Second, this patch changes the behaviour of PageSlab() when applied to
tail pages.  Which raises the further question of what PageBuddy(),
PageTable(), PageGuard() and PageIsolated() should do for multi-page
folios, if that is even possible.

Third, can we do this without that awkward __u16 thing?  Perhaps

-#define PG_buddy        0x00000080
-#define PG_offline      0x00000100
-#define PG_table        0x00000200
-#define PG_guard        0x00000400
+#define PG_buddy        0x00010000
+#define PG_offline      0x00020000
+#define PG_table        0x00040000
+#define PG_guard        0x00080000
+#define PG_slab         0x00100000

... and then use wrappers in slab.c to access the bottom 16 bits?

