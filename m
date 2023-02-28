Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC016A5FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjB1TsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjB1TsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90C1CF5E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677613642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qEFLf5PLiDm1XqQlabR9wXxvhN/9FzZfFHYx13O7GVs=;
        b=ef3cnaCs+arVX/fazsxgOw2PEROTipGXeuX40Vo6qatbTYXhyohfd5U6RByl73QhT//E96
        WRP8XVQdE0p829X+wIQ/rLKjevqPL0/vrQ0/xKFlBbcel+IVaH2G1us47SAEvfk7cFM1+Q
        qMCLVgb2hbbWGdWk/Tno9wlA7HSmviY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-DKmFVjuvOa-JMyuSBLRd3A-1; Tue, 28 Feb 2023 14:47:16 -0500
X-MC-Unique: DKmFVjuvOa-JMyuSBLRd3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AF7A800B23;
        Tue, 28 Feb 2023 19:47:16 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4C174010E86;
        Tue, 28 Feb 2023 19:47:15 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 0DD43400E71A2; Tue, 28 Feb 2023 16:36:00 -0300 (-03)
Date:   Tue, 28 Feb 2023 16:36:00 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Message-ID: <Y/5XoAnv43zYzxLR@tpad>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
 <6b6cd2fe-2309-b471-8950-3c4334462e69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b6cd2fe-2309-b471-8950-3c4334462e69@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:53:47PM +0100, David Hildenbrand wrote:
> On 09.02.23 16:01, Marcelo Tosatti wrote:
> > Draining of pages from the local pcp for a remote zone was necessary
> > since:
> > 
> > "Note that remote node draining is a somewhat esoteric feature that is
> > required on large NUMA systems because otherwise significant portions
> > of system memory can become trapped in pcp queues. The number of pcp is
> > determined by the number of processors and nodes in a system. A system
> > with 4 processors and 2 nodes has 8 pcps which is okay. But a system
> > with 1024 processors and 512 nodes has 512k pcps with a high potential
> > for large amount of memory being caught in them."
> > 
> > Since commit 443c2accd1b6679a1320167f8f56eed6536b806e
> > ("mm/page_alloc: remotely drain per-cpu lists"), drain_all_pages() is able
> > to remotely free those pages when necessary.
> > 
> 
> I'm a bit new to that piece of code, so sorry for the dummy questions. I'm
> staring at linux master,
> 
> (1) I think you're removing the single user of drain_zone_pages(). So we
>     should remove drain_zone_pages() as well.

Done.

> (2) drain_zone_pages() documents that we're draining the PCP
>     (bulk-freeing them) of the current CPU on remote nodes. That bulk-
>     freeing will properly adjust free memory counters. What exactly is
>     the impact when no longer doing that? Won't the "snapshot" of some
>     counters eventually be wrong? Do we care?

Don't see why the snapshot of counters will be wrong.

Instead of freeing pages on pcp list of remote nodes after they are
considered idle ("3 seconds idle till flush"), what will happen is that
drain_all_pages() will free those pcps, for example after an allocation
fails on direct reclaim:

        page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);

        /*
         * If an allocation failed after direct reclaim, it could be because
         * pages are pinned on the per-cpu lists or in high alloc reserves.
         * Shrink them and try again
         */
        if (!page && !drained) {
                unreserve_highatomic_pageblock(ac, false);
                drain_all_pages(NULL);
                drained = true;
                goto retry;
        }

In both cases the pages are freed (and counters maintained) here:

static inline void __free_one_page(struct page *page,
                unsigned long pfn,
                struct zone *zone, unsigned int order,
                int migratetype, fpi_t fpi_flags)
{
        struct capture_control *capc = task_capc(zone);
        unsigned long buddy_pfn = 0;
        unsigned long combined_pfn;
        struct page *buddy;
        bool to_tail;

        VM_BUG_ON(!zone_is_initialized(zone));
        VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);

        VM_BUG_ON(migratetype == -1);
        if (likely(!is_migrate_isolate(migratetype)))
                __mod_zone_freepage_state(zone, 1 << order, migratetype);

        VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
        VM_BUG_ON_PAGE(bad_range(zone, page), page);

        while (order < MAX_ORDER - 1) {
                if (compaction_capture(capc, page, order, migratetype)) {
                        __mod_zone_freepage_state(zone, -(1 << order),
                                                                migratetype);
                        return;
                }

> Describing the difference between instructed refresh of vmstat and "remotely
> drain per-cpu lists" in order to move free memory from the pcp to the buddy
> would be great.

The difference is that now remote PCPs will be drained on demand, either via
kcompactd or direct reclaim (through drain_all_pages), when memory is
low.

For example, with the following test:

dd if=/dev/zero of=file bs=1M count=32000 on a tmpfs filesystem:

      kcompactd0-116     [005] ...1 228232.042873: drain_all_pages <-kcompactd_do_work
      kcompactd0-116     [005] ...1 228232.042873: __drain_all_pages <-kcompactd_do_work
              dd-479485  [003] ...1 228232.455130: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
              dd-479485  [011] ...1 228232.721994: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
     gnome-shell-3750    [015] ...1 228232.723729: __drain_all_pages <-__alloc_pages_slowpath.constprop.0

The commit message was indeed incorrect. Updated one:

"mm/vmstat: remove remote node draining

Draining of pages from the local pcp for a remote zone should not be
necessary, since once the system is low on memory (or compaction on a
zone is in effect), drain_all_pages should be called freeing any unused
pcps."

Thanks!

> Because removing this code here looks nice, but I am not 100% sure about the
> implications. CCing Mel as well.
> 
> 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-vmstat-remote/include/linux/mmzone.h
> > ===================================================================
> > --- linux-vmstat-remote.orig/include/linux/mmzone.h
> > +++ linux-vmstat-remote/include/linux/mmzone.h
> > @@ -577,9 +577,6 @@ struct per_cpu_pages {
> >   	int high;		/* high watermark, emptying needed */
> >   	int batch;		/* chunk size for buddy add/remove */
> >   	short free_factor;	/* batch scaling factor during free */
> > -#ifdef CONFIG_NUMA
> > -	short expire;		/* When 0, remote pagesets are drained */
> > -#endif
> >   	/* Lists of pages, one per migrate type stored on the pcp-lists */
> >   	struct list_head lists[NR_PCP_LISTS];
> > Index: linux-vmstat-remote/mm/vmstat.c
> > ===================================================================
> > --- linux-vmstat-remote.orig/mm/vmstat.c
> > +++ linux-vmstat-remote/mm/vmstat.c
> > @@ -803,7 +803,7 @@ static int fold_diff(int *zone_diff, int
> >    *
> >    * The function returns the number of global counters updated.
> >    */
> > -static int refresh_cpu_vm_stats(bool do_pagesets)
> > +static int refresh_cpu_vm_stats(void)
> >   {
> >   	struct pglist_data *pgdat;
> >   	struct zone *zone;
> > @@ -814,9 +814,6 @@ static int refresh_cpu_vm_stats(bool do_
> >   	for_each_populated_zone(zone) {
> >   		struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
> > -#ifdef CONFIG_NUMA
> > -		struct per_cpu_pages __percpu *pcp = zone->per_cpu_pageset;
> > -#endif
> >   		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> >   			int v;
> > @@ -826,44 +823,8 @@ static int refresh_cpu_vm_stats(bool do_
> >   				atomic_long_add(v, &zone->vm_stat[i]);
> >   				global_zone_diff[i] += v;
> > -#ifdef CONFIG_NUMA
> > -				/* 3 seconds idle till flush */
> > -				__this_cpu_write(pcp->expire, 3);
> > -#endif
> >   			}
> >   		}
> > -#ifdef CONFIG_NUMA
> > -
> > -		if (do_pagesets) {
> > -			cond_resched();
> > -			/*
> > -			 * Deal with draining the remote pageset of this
> > -			 * processor
> > -			 *
> > -			 * Check if there are pages remaining in this pageset
> > -			 * if not then there is nothing to expire.
> > -			 */
> > -			if (!__this_cpu_read(pcp->expire) ||
> > -			       !__this_cpu_read(pcp->count))
> > -				continue;
> > -
> > -			/*
> > -			 * We never drain zones local to this processor.
> > -			 */
> > -			if (zone_to_nid(zone) == numa_node_id()) {
> > -				__this_cpu_write(pcp->expire, 0);
> > -				continue;
> > -			}
> > -
> > -			if (__this_cpu_dec_return(pcp->expire))
> > -				continue;
> > -
> > -			if (__this_cpu_read(pcp->count)) {
> > -				drain_zone_pages(zone, this_cpu_ptr(pcp));
> > -				changes++;
> > -			}
> > -		}
> > -#endif
> >   	}
> 
> I think you can then also get rid of the "changes" local variable and do a
> "return fold_diff(global_zone_diff, global_node_diff);" directly.

Done.

