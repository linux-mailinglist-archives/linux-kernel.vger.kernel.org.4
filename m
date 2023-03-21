Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666D86C3838
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCURco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCURcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D2A13538
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679419906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgy4ya1FwxC/XDxzCB8Jfy4+qKCjl6s0tQNELR6EvdQ=;
        b=T3ARX4j/57I2EZtyVRI/Q9xKbgF/UH8GqvnOdwDdgiL5mACSvOGykgJXaz1AXlzRdFP1+6
        myEqLSvb+rPSl98HaSKLLcfTM3chhgv/7p+qsuWiDdksezw+cetttwGoLyUIOqp4hRK6OV
        msiPfDckXsfx2Hzyu9UXGIDsohx0YWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-CSeqk2H1NPqZO1WRKhaNgg-1; Tue, 21 Mar 2023 13:31:42 -0400
X-MC-Unique: CSeqk2H1NPqZO1WRKhaNgg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B2E880C8C3;
        Tue, 21 Mar 2023 17:31:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF273175AD;
        Tue, 21 Mar 2023 17:31:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0F9E84038ED8A; Tue, 21 Mar 2023 14:31:23 -0300 (-03)
Date:   Tue, 21 Mar 2023 14:31:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Message-ID: <ZBnp69SHwM5SOttF@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
 <6b6cd2fe-2309-b471-8950-3c4334462e69@redhat.com>
 <Y/5XoAnv43zYzxLR@tpad>
 <3329f63e-5671-1500-0730-cd46ba461d04@redhat.com>
 <20230321152031.2bzcury6k6aj7p6k@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321152031.2bzcury6k6aj7p6k@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:20:31PM +0000, Mel Gorman wrote:
> On Thu, Mar 02, 2023 at 11:10:03AM +0100, David Hildenbrand wrote:
> > [...]
> > 
> > > 
> > > > (2) drain_zone_pages() documents that we're draining the PCP
> > > >      (bulk-freeing them) of the current CPU on remote nodes. That bulk-
> > > >      freeing will properly adjust free memory counters. What exactly is
> > > >      the impact when no longer doing that? Won't the "snapshot" of some
> > > >      counters eventually be wrong? Do we care?
> > > 
> > > Don't see why the snapshot of counters will be wrong.
> > > 
> > > Instead of freeing pages on pcp list of remote nodes after they are
> > > considered idle ("3 seconds idle till flush"), what will happen is that
> > > drain_all_pages() will free those pcps, for example after an allocation
> > > fails on direct reclaim:
> > > 
> > >          page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> > > 
> > >          /*
> > >           * If an allocation failed after direct reclaim, it could be because
> > >           * pages are pinned on the per-cpu lists or in high alloc reserves.
> > >           * Shrink them and try again
> > >           */
> > >          if (!page && !drained) {
> > >                  unreserve_highatomic_pageblock(ac, false);
> > >                  drain_all_pages(NULL);
> > >                  drained = true;
> > >                  goto retry;
> > >          }
> > > 
> > > In both cases the pages are freed (and counters maintained) here:
> > > 
> > > static inline void __free_one_page(struct page *page,
> > >                  unsigned long pfn,
> > >                  struct zone *zone, unsigned int order,
> > >                  int migratetype, fpi_t fpi_flags)
> > > {
> > >          struct capture_control *capc = task_capc(zone);
> > >          unsigned long buddy_pfn = 0;
> > >          unsigned long combined_pfn;
> > >          struct page *buddy;
> > >          bool to_tail;
> > > 
> > >          VM_BUG_ON(!zone_is_initialized(zone));
> > >          VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> > > 
> > >          VM_BUG_ON(migratetype == -1);
> > >          if (likely(!is_migrate_isolate(migratetype)))
> > >                  __mod_zone_freepage_state(zone, 1 << order, migratetype);
> > > 
> > >          VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
> > >          VM_BUG_ON_PAGE(bad_range(zone, page), page);
> > > 
> > >          while (order < MAX_ORDER - 1) {
> > >                  if (compaction_capture(capc, page, order, migratetype)) {
> > >                          __mod_zone_freepage_state(zone, -(1 << order),
> > >                                                                  migratetype);
> > >                          return;
> > >                  }
> > > 
> > > > Describing the difference between instructed refresh of vmstat and "remotely
> > > > drain per-cpu lists" in order to move free memory from the pcp to the buddy
> > > > would be great.
> > > 
> > > The difference is that now remote PCPs will be drained on demand, either via
> > > kcompactd or direct reclaim (through drain_all_pages), when memory is
> > > low.
> > > 
> > > For example, with the following test:
> > > 
> > > dd if=/dev/zero of=file bs=1M count=32000 on a tmpfs filesystem:
> > > 
> > >        kcompactd0-116     [005] ...1 228232.042873: drain_all_pages <-kcompactd_do_work
> > >        kcompactd0-116     [005] ...1 228232.042873: __drain_all_pages <-kcompactd_do_work
> > >                dd-479485  [003] ...1 228232.455130: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> > >                dd-479485  [011] ...1 228232.721994: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> > >       gnome-shell-3750    [015] ...1 228232.723729: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> > > 
> > > The commit message was indeed incorrect. Updated one:
> > > 
> > > "mm/vmstat: remove remote node draining
> > > 
> > > Draining of pages from the local pcp for a remote zone should not be
> > > necessary, since once the system is low on memory (or compaction on a
> > > zone is in effect), drain_all_pages should be called freeing any unused
> > > pcps."
> > > 
> > > Thanks!
> > 
> > Thanks for the explanation, that makes sense to me. Feel free to add my
> > 
> > Acked-by: David Hildenbrand <david@redhat.com>
> > 
> > ... hoping that some others (Mel, Vlastimil?) can have another look.
> > 
> 
> I was on extended leave and am still in the process of triaging a few
> thousand mails so I'm working off memory here instead of the code. This
> is a straight-forward enough question to answer quickly in case I forget
> later.
> 
> Short answer: I'm not a fan of the patch in concept and I do not think it
> should be merged.
> 
> I agree that drain_all_pages() would free the PCP pages on demand in
> direct reclaim context but it happens after reclaim has already
> happened. Hence, the reclaim may be necessary and may cause overreclaim
> in some situations due to remote CPUs pinning memory in PCP lists.
> 
> Similarly, kswapd may trigger early because PCP pages do not contribute
> to NR_FREE_PAGES so watermark checks can fail even though pages are
> free, just inaccessible.
> 
> Finally, remote pages expire because ideally CPUs allocate local memory
> assuming memory policies are not forcing use of remote nodes. The expiry
> means that remote pages get freed back to the buddy lists after a short
> period. By removing the expiry, it's possible that a local allocation will
> fail and spill over to a remote node prematurely because free pages were
> pinned on the PCP lists.
> 
> As this patch has the possibility of reclaiming early in both direct and
> kswapd context and increases the risk of remote node fallback, I think it
> needs much stronger justification and a warning about the side-effects. For
> this version unless I'm very wrong -- NAK :(

Mel,

Agreed. -v7 of the series dropped this patch and implements draining 
of non-local NUMA node memory on pcp caches to happen from cpu_vm_stats_fold
(which might execute remotely from vmstat_shepherd).
If you can take a look at -v7, it would be awesome.

Subject: [PATCH v7 13/13] vmstat: add pcp remote node draining via cpu_vm_stats_fold

Large NUMA systems might have significant portions
of system memory to be trapped in pcp queues. The number of pcp is
determined by the number of processors and nodes in a system. A system
with 4 processors and 2 nodes has 8 pcps which is okay. But a system
with 1024 processors and 512 nodes has 512k pcps with a high potential
for large amount of memory being caught in them.

Enable remote node draining for the CONFIG_HAVE_CMPXCHG_LOCAL case,
where vmstat_shepherd will perform the aging and draining via
cpu_vm_stats_fold.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>




> 
> -- 
> Mel Gorman
> SUSE Labs
> 
> 

