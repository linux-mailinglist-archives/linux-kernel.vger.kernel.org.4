Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D419D695E99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjBNJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjBNJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:12:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD825955
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:10:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D125FCE1B08
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF00C433EF;
        Tue, 14 Feb 2023 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676365843;
        bh=zDLP5vq/kpbSxtr1+sXH9q7wGXcZI0mMiWLpHLK2+UQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRIcIonFiC+MOufs4FQ7v38JVNldc7NqPdKRgZhxnhM4aLRa1Rn8oDC8Cs+9mE/0P
         DOyvCPBA52dajp/EDpnAWa9GeuYcAbK8sUogXSrMNou2CQuNd0hjSaApkGtaNV7wqi
         CvJu4mWVnni+E2EzwCRRW3DslgfAcPM3CCqvyR0mrAwfNfS3eZwvaTCbSvKKqPuIXJ
         n5f2a/6w56vUpiAUcOyE+1xTey46bBZm90r4EIiOFJhbpcyJw/JxvnbC9vSX2T6ZRk
         wc0RBFXEjLnB/7rU9bkzaP2D9kk85KQe+U60ya1ey2zUsQA/goPf3JFuqejS9nEhBm
         SfIADTD8mnHXw==
Date:   Tue, 14 Feb 2023 11:10:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+tQDN/TmdTPFFR6@kernel.org>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:47:43AM +0100, Vlastimil Babka wrote:
> On 2/12/23 12:03, Qi Zheng wrote:
> > In x86, numa_register_memblks() is only interested in
> > those nodes which have enough memory, so it skips over
> > all nodes with memory below NODE_MIN_SIZE (treated as
> > a memoryless node). Later on, we will initialize these
> > memoryless nodes (allocate pgdat in free_area_init()
> > and build zonelist etc), and will online these nodes
> > in init_cpu_to_node() and init_gi_nodes().
> > 
> > After boot, these memoryless nodes are in N_ONLINE
> > state but not in N_MEMORY state. But we can still allocate
> > pages from these memoryless nodes.
> > 
> > In SLUB, we only process nodes in the N_MEMORY state,
> > such as allocating their struct kmem_cache_node. So if
> > we allocate a page from the memoryless node above to
> > SLUB, the struct kmem_cache_node of the node corresponding
> > to this page is NULL, which will cause panic.
> > 
> > For example, if we use qemu to start a two numa node kernel,
> > one of the nodes has 2M memory (less than NODE_MIN_SIZE),
> > and the other node has 2G, then we will encounter the
> > following panic:
> > 
> > [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > [    0.150783] #PF: supervisor write access in kernel mode
> > [    0.151488] #PF: error_code(0x0002) - not-present page
> > <...>
> > [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> > <...>
> > [    0.169781] Call Trace:
> > [    0.170159]  <TASK>
> > [    0.170448]  deactivate_slab+0x187/0x3c0
> > [    0.171031]  ? bootstrap+0x1b/0x10e
> > [    0.171559]  ? preempt_count_sub+0x9/0xa0
> > [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
> > [    0.172735]  ? bootstrap+0x1b/0x10e
> > [    0.173236]  bootstrap+0x6b/0x10e
> > [    0.173720]  kmem_cache_init+0x10a/0x188
> > [    0.174240]  start_kernel+0x415/0x6ac
> > [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
> > [    0.175417]  </TASK>
> > [    0.175713] Modules linked in:
> > [    0.176117] CR2: 0000000000000000
> > 
> > In addition, we can also encountered this panic in the actual
> > production environment. We set up a 2c2g container with two
> > numa nodes, and then reserved 128M for kdump, and then we
> > can encountered the above panic in the kdump kernel.
> > 
> > To fix it, we can filter memoryless nodes when allocating
> > pages.
> > 
> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > Reported-by: Teng Hu <huteng.ht@bytedance.com>
> 
> Well AFAIK the key mechanism to only allocate from "good" nodes is the
> zonelist, we shouldn't need to start putting extra checks like this. So it
> seems to me that the code building the zonelists should take the
> NODE_MIN_SIZE constraint in mind.

Why just not drop the memory for nodes with size < NODE_MIN_SIZE from
memblock at the first place?
Then we won't need runtime checks at all.
 
> > ---
> >  mm/page_alloc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 588555754601..b9cce56f4e21 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4188,6 +4188,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
> >  			(alloc_flags & ALLOC_CPUSET) &&
> >  			!__cpuset_zone_allowed(zone, gfp_mask))
> >  				continue;
> > +
> > +		/* Don't allocate page from memoryless nodes. */
> > +		if (!node_state((zone_to_nid(zone)), N_MEMORY))
> > +			continue;
> > +
> >  		/*
> >  		 * When allocating a page cache page for writing, we
> >  		 * want to get it from a node that is within its dirty
> 

-- 
Sincerely yours,
Mike.
