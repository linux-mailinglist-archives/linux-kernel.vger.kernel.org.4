Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CB6C3581
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCUPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjCUPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:21:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA493498A9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:20:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D61E2209C;
        Tue, 21 Mar 2023 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679412036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jiD1Ov4GAppGMXcnNtOcT+oui4+HFoeyxzBo5N1dnEk=;
        b=rUrKm6HOPAfLMBy29V2ObSPOPTRScasDh89tMwV6VCNAiRCyc9En/j+NBORMzJb9LFGmV3
        soBIKdu343YoGlmIP0Vbv9qUGlX0aqG4okz5UZwtjbqBrJnosDimCm6bKC+Br6wX3bER/c
        bX63WhRojgOtmJg9BEwU6u+3RZfv92o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679412036;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jiD1Ov4GAppGMXcnNtOcT+oui4+HFoeyxzBo5N1dnEk=;
        b=aPknuomhPEUETIn+g0w3jZXbm5N7tgq6JGcKWk9q7EdR9/+tRR2kDTB2iPXjaWMjAIofeg
        wGZcnSC/p94ZPbDw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 669C72C141;
        Tue, 21 Mar 2023 15:20:35 +0000 (UTC)
Date:   Tue, 21 Mar 2023 15:20:31 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 01/11] mm/vmstat: remove remote node draining
Message-ID: <20230321152031.2bzcury6k6aj7p6k@suse.de>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.656996515@redhat.com>
 <6b6cd2fe-2309-b471-8950-3c4334462e69@redhat.com>
 <Y/5XoAnv43zYzxLR@tpad>
 <3329f63e-5671-1500-0730-cd46ba461d04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3329f63e-5671-1500-0730-cd46ba461d04@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:10:03AM +0100, David Hildenbrand wrote:
> [...]
> 
> > 
> > > (2) drain_zone_pages() documents that we're draining the PCP
> > >      (bulk-freeing them) of the current CPU on remote nodes. That bulk-
> > >      freeing will properly adjust free memory counters. What exactly is
> > >      the impact when no longer doing that? Won't the "snapshot" of some
> > >      counters eventually be wrong? Do we care?
> > 
> > Don't see why the snapshot of counters will be wrong.
> > 
> > Instead of freeing pages on pcp list of remote nodes after they are
> > considered idle ("3 seconds idle till flush"), what will happen is that
> > drain_all_pages() will free those pcps, for example after an allocation
> > fails on direct reclaim:
> > 
> >          page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
> > 
> >          /*
> >           * If an allocation failed after direct reclaim, it could be because
> >           * pages are pinned on the per-cpu lists or in high alloc reserves.
> >           * Shrink them and try again
> >           */
> >          if (!page && !drained) {
> >                  unreserve_highatomic_pageblock(ac, false);
> >                  drain_all_pages(NULL);
> >                  drained = true;
> >                  goto retry;
> >          }
> > 
> > In both cases the pages are freed (and counters maintained) here:
> > 
> > static inline void __free_one_page(struct page *page,
> >                  unsigned long pfn,
> >                  struct zone *zone, unsigned int order,
> >                  int migratetype, fpi_t fpi_flags)
> > {
> >          struct capture_control *capc = task_capc(zone);
> >          unsigned long buddy_pfn = 0;
> >          unsigned long combined_pfn;
> >          struct page *buddy;
> >          bool to_tail;
> > 
> >          VM_BUG_ON(!zone_is_initialized(zone));
> >          VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> > 
> >          VM_BUG_ON(migratetype == -1);
> >          if (likely(!is_migrate_isolate(migratetype)))
> >                  __mod_zone_freepage_state(zone, 1 << order, migratetype);
> > 
> >          VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
> >          VM_BUG_ON_PAGE(bad_range(zone, page), page);
> > 
> >          while (order < MAX_ORDER - 1) {
> >                  if (compaction_capture(capc, page, order, migratetype)) {
> >                          __mod_zone_freepage_state(zone, -(1 << order),
> >                                                                  migratetype);
> >                          return;
> >                  }
> > 
> > > Describing the difference between instructed refresh of vmstat and "remotely
> > > drain per-cpu lists" in order to move free memory from the pcp to the buddy
> > > would be great.
> > 
> > The difference is that now remote PCPs will be drained on demand, either via
> > kcompactd or direct reclaim (through drain_all_pages), when memory is
> > low.
> > 
> > For example, with the following test:
> > 
> > dd if=/dev/zero of=file bs=1M count=32000 on a tmpfs filesystem:
> > 
> >        kcompactd0-116     [005] ...1 228232.042873: drain_all_pages <-kcompactd_do_work
> >        kcompactd0-116     [005] ...1 228232.042873: __drain_all_pages <-kcompactd_do_work
> >                dd-479485  [003] ...1 228232.455130: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> >                dd-479485  [011] ...1 228232.721994: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> >       gnome-shell-3750    [015] ...1 228232.723729: __drain_all_pages <-__alloc_pages_slowpath.constprop.0
> > 
> > The commit message was indeed incorrect. Updated one:
> > 
> > "mm/vmstat: remove remote node draining
> > 
> > Draining of pages from the local pcp for a remote zone should not be
> > necessary, since once the system is low on memory (or compaction on a
> > zone is in effect), drain_all_pages should be called freeing any unused
> > pcps."
> > 
> > Thanks!
> 
> Thanks for the explanation, that makes sense to me. Feel free to add my
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> ... hoping that some others (Mel, Vlastimil?) can have another look.
> 

I was on extended leave and am still in the process of triaging a few
thousand mails so I'm working off memory here instead of the code. This
is a straight-forward enough question to answer quickly in case I forget
later.

Short answer: I'm not a fan of the patch in concept and I do not think it
should be merged.

I agree that drain_all_pages() would free the PCP pages on demand in
direct reclaim context but it happens after reclaim has already
happened. Hence, the reclaim may be necessary and may cause overreclaim
in some situations due to remote CPUs pinning memory in PCP lists.

Similarly, kswapd may trigger early because PCP pages do not contribute
to NR_FREE_PAGES so watermark checks can fail even though pages are
free, just inaccessible.

Finally, remote pages expire because ideally CPUs allocate local memory
assuming memory policies are not forcing use of remote nodes. The expiry
means that remote pages get freed back to the buddy lists after a short
period. By removing the expiry, it's possible that a local allocation will
fail and spill over to a remote node prematurely because free pages were
pinned on the PCP lists.

As this patch has the possibility of reclaiming early in both direct and
kswapd context and increases the risk of remote node fallback, I think it
needs much stronger justification and a warning about the side-effects. For
this version unless I'm very wrong -- NAK :(

-- 
Mel Gorman
SUSE Labs
