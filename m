Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DCA68ED7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBHLEn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Feb 2023 06:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:04:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E66183
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:04:36 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PBcV738t6z67j7Z;
        Wed,  8 Feb 2023 19:00:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Feb
 2023 11:04:33 +0000
Date:   Wed, 8 Feb 2023 11:04:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     haoxin <xhao@linux.alibaba.com>
CC:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <yangyicong@huawei.com>
Subject: Re: [PATCH -v4 0/9] migrate_pages(): batch TLB flushing
Message-ID: <20230208110432.000011b5@Huawei.com>
In-Reply-To: <2b15a6c8-67a4-8d93-09a4-cdc9f09e6b78@linux.alibaba.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
        <b01e8657-76bd-71e6-929a-4b1131d1aebd@linux.alibaba.com>
        <2b15a6c8-67a4-8d93-09a4-cdc9f09e6b78@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 14:27:32 +0800
haoxin <xhao@linux.alibaba.com> wrote:

> 在 2023/2/8 下午2:21, haoxin 写道:
> >
> > On my arm64 server with 128 cores, 2 numa nodes.
> >
> > I used memhog as benchmark :
> >
> >     numactl -m -C 5 memhog -r100000 1G
> >  
>      Do a fix, numactl -m 0 -C 5 memhog -r100000 1G

Nice results - thanks for sharing.

Just to confirm, is this with this tlb batching on arm64 patch set?
https://lore.kernel.org/linux-arm-kernel/20221117082648.47526-1-yangyicong@huawei.com/

I think that still hasn't been applied upstream.

Jonathan

> 
> > The test result as below:
> >
> >  With this patch:
> >
> >     #time migratepages 8490 0 1
> >
> >     real 0m1.161s
> >
> >     user 0m0.000s
> >
> >     sys 0m1.161s
> >
> > without this patch:
> >
> >     #time migratepages 8460 0 1
> >
> >     real 0m2.068s
> >
> >     user 0m0.001s
> >
> >     sys 0m2.068s
> >
> > So you can see the migration performance improvement about *+78%*
> >
> > This is the perf record info.
> >
> > w/o
> > +   51.07%     0.09%  migratepages  [kernel.kallsyms]  [k] 
> > migrate_folio_extra
> > +   42.43%     0.04%  migratepages  [kernel.kallsyms]  [k] folio_copy
> > +   42.34%    42.34%  migratepages  [kernel.kallsyms]  [k] __pi_copy_page
> > +   33.99%     0.09%  migratepages  [kernel.kallsyms]  [k] rmap_walk_anon
> > +   32.35%     0.04%  migratepages  [kernel.kallsyms]  [k] try_to_migrate
> > *+   27.78%    27.78%  migratepages  [kernel.kallsyms]  [k] 
> > ptep_clear_flush *
> > +    8.19%     6.64%  migratepages  [kernel.kallsyms]  [k] 
> > folio_migrate_flagsmigrati_tlb_flush
> >
> > w/ this patch
> > +   18.57%     0.13%  migratepages     [kernel.kallsyms]   [k] 
> > migrate_pages
> > +   18.23%     0.07%  migratepages     [kernel.kallsyms]   [k] 
> > migrate_pages_batch
> > +   16.29%     0.13%  migratepages     [kernel.kallsyms]   [k] 
> > migrate_folio_move
> > +   12.73%     0.10%  migratepages     [kernel.kallsyms]   [k] 
> > move_to_new_folio
> > +   12.52%     0.06%  migratepages     [kernel.kallsyms]   [k] 
> > migrate_folio_extra
> >
> > Therefore, this patch helps improve performance in page migration
> >
> >
> > So,  you can add Tested-by: Xin Hao <xhao@linux.alibaba.com>
> >
> >
> > 在 2023/2/6 下午2:33, Huang Ying 写道:  
> >> From: "Huang, Ying"<ying.huang@intel.com>
> >>
> >> Now, migrate_pages() migrate folios one by one, like the fake code as
> >> follows,
> >>
> >>    for each folio
> >>      unmap
> >>      flush TLB
> >>      copy
> >>      restore map
> >>
> >> If multiple folios are passed to migrate_pages(), there are
> >> opportunities to batch the TLB flushing and copying.  That is, we can
> >> change the code to something as follows,
> >>
> >>    for each folio
> >>      unmap
> >>    for each folio
> >>      flush TLB
> >>    for each folio
> >>      copy
> >>    for each folio
> >>      restore map
> >>
> >> The total number of TLB flushing IPI can be reduced considerably.  And
> >> we may use some hardware accelerator such as DSA to accelerate the
> >> folio copying.
> >>
> >> So in this patch, we refactor the migrate_pages() implementation and
> >> implement the TLB flushing batching.  Base on this, hardware
> >> accelerated folio copying can be implemented.
> >>
> >> If too many folios are passed to migrate_pages(), in the naive batched
> >> implementation, we may unmap too many folios at the same time.  The
> >> possibility for a task to wait for the migrated folios to be mapped
> >> again increases.  So the latency may be hurt.  To deal with this
> >> issue, the max number of folios be unmapped in batch is restricted to
> >> no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
> >> is at the same level of THP migration.
> >>
> >> We use the following test to measure the performance impact of the
> >> patchset,
> >>
> >> On a 2-socket Intel server,
> >>
> >>   - Run pmbench memory accessing benchmark
> >>
> >>   - Run `migratepages` to migrate pages of pmbench between node 0 and
> >>     node 1 back and forth.
> >>
> >> With the patch, the TLB flushing IPI reduces 99.1% during the test and
> >> the number of pages migrated successfully per second increases 291.7%.
> >>
> >> This patchset is based on v6.2-rc4.
> >>
> >> Changes:
> >>
> >> v4:
> >>
> >> - Fixed another bug about non-LRU folio migration.  Thanks Hyeonggon!
> >>
> >> v3:
> >>
> >> - Rebased on v6.2-rc4
> >>
> >> - Fixed a bug about non-LRU folio migration.  Thanks Mike!
> >>
> >> - Fixed some comments.  Thanks Baolin!
> >>
> >> - Collected reviewed-by.
> >>
> >> v2:
> >>
> >> - Rebased on v6.2-rc3
> >>
> >> - Fixed type force cast warning.  Thanks Kees!
> >>
> >> - Added more comments and cleaned up the code.  Thanks Andrew, Zi, Alistair, Dan!
> >>
> >> - Collected reviewed-by.
> >>
> >> from rfc to v1:
> >>
> >> - Rebased on v6.2-rc1
> >>
> >> - Fix the deadlock issue caused by locking multiple pages synchronously
> >>    per Alistair's comments.  Thanks!
> >>
> >> - Fix the autonumabench panic per Rao's comments and fix.  Thanks!
> >>
> >> - Other minor fixes per comments. Thanks!
> >>
> >> Best Regards,
> >> Huang, Ying  

