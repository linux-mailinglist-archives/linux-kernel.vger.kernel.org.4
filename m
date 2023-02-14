Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D34695F81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBNJnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjBNJnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:43:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C4CA07
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 923D5B81CA5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5763EC433D2;
        Tue, 14 Feb 2023 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676367795;
        bh=JgiePJOXuSHNcYNssB2GnhcYmi8KQG3kSVOb03KPjqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWLSMcarZUjF2q75pRtslttXe5d9W5s3zjYdOqjCaqj+eqmveF8cULy4HEV49RCCG
         NIjeJG3dK9R3fA2phdX8XYFjLoR0Z0AeE36wLTLOifLxBDgDQE5zQU23GuLHi4WLUg
         ShXAinWiRKmrxlbBY2ppiw2bqayPQly7Njf3L9HjAQkI277kpiuFrEvuRYOyj4vF2M
         G040hImP5Q+f0TSzFYzLIw/vWWCSgjxlqtRQOqXzTg1uuWbYmznA/r59UXP7HCy9z3
         6ua4GpJyZFJ5XCqBtTrPdfVPFsxU5b/ETNi0fO0ej9BW3qYnYP1ILoo7teg8zGYxLE
         mdn0T4MdlSmLQ==
Date:   Tue, 14 Feb 2023 11:43:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+tXrK/g1Nrd/q1h@kernel.org>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:17:03AM +0100, David Hildenbrand wrote:
> On 14.02.23 09:42, Vlastimil Babka wrote:
> > On 2/13/23 12:00, Qi Zheng wrote:
> > > 
> > > 
> > > On 2023/2/13 16:47, Vlastimil Babka wrote:
> > > > On 2/12/23 12:03, Qi Zheng wrote:
> > > > > In x86, numa_register_memblks() is only interested in
> > > > > those nodes which have enough memory, so it skips over
> > > > > all nodes with memory below NODE_MIN_SIZE (treated as
> > > > > a memoryless node). Later on, we will initialize these
> > > > > memoryless nodes (allocate pgdat in free_area_init()
> > > > > and build zonelist etc), and will online these nodes
> > > > > in init_cpu_to_node() and init_gi_nodes().
> > > > > 
> > > > > After boot, these memoryless nodes are in N_ONLINE
> > > > > state but not in N_MEMORY state. But we can still allocate
> > > > > pages from these memoryless nodes.
> > > > > 
> > > > > In SLUB, we only process nodes in the N_MEMORY state,
> > > > > such as allocating their struct kmem_cache_node. So if
> > > > > we allocate a page from the memoryless node above to
> > > > > SLUB, the struct kmem_cache_node of the node corresponding
> > > > > to this page is NULL, which will cause panic.
> > > > > 
> > > > > For example, if we use qemu to start a two numa node kernel,
> > > > > one of the nodes has 2M memory (less than NODE_MIN_SIZE),
> > > > > and the other node has 2G, then we will encounter the
> > > > > following panic:
> > > > > 
> > > > > [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > > [    0.150783] #PF: supervisor write access in kernel mode
> > > > > [    0.151488] #PF: error_code(0x0002) - not-present page
> > > > > <...>
> > > > > [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> > > > > <...>
> > > > > [    0.169781] Call Trace:
> > > > > [    0.170159]  <TASK>
> > > > > [    0.170448]  deactivate_slab+0x187/0x3c0
> > > > > [    0.171031]  ? bootstrap+0x1b/0x10e
> > > > > [    0.171559]  ? preempt_count_sub+0x9/0xa0
> > > > > [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
> > > > > [    0.172735]  ? bootstrap+0x1b/0x10e
> > > > > [    0.173236]  bootstrap+0x6b/0x10e
> > > > > [    0.173720]  kmem_cache_init+0x10a/0x188
> > > > > [    0.174240]  start_kernel+0x415/0x6ac
> > > > > [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
> > > > > [    0.175417]  </TASK>
> > > > > [    0.175713] Modules linked in:
> > > > > [    0.176117] CR2: 0000000000000000
> > > > > 
> > > > > In addition, we can also encountered this panic in the actual
> > > > > production environment. We set up a 2c2g container with two
> > > > > numa nodes, and then reserved 128M for kdump, and then we
> > > > > can encountered the above panic in the kdump kernel.
> > > > > 
> > > > > To fix it, we can filter memoryless nodes when allocating
> > > > > pages.
> > > > > 
> > > > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > > > Reported-by: Teng Hu <huteng.ht@bytedance.com>
> > > > 
> > > > Well AFAIK the key mechanism to only allocate from "good" nodes is the
> > > > zonelist, we shouldn't need to start putting extra checks like this. So it
> > > > seems to me that the code building the zonelists should take the
> > > > NODE_MIN_SIZE constraint in mind.
> > > 
> > > Indeed. How about the following patch:
> > 
> > +Cc also David, forgot earlier.
> > 
> > Looks good to me, at least.
> > 
> > > @@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
> > > *used_node_mask)
> > >           int min_val = INT_MAX;
> > >           int best_node = NUMA_NO_NODE;
> > > 
> > > -       /* Use the local node if we haven't already */
> > > -       if (!node_isset(node, *used_node_mask)) {
> > > +       /*
> > > +        * Use the local node if we haven't already. But for memoryless
> > > local
> > > +        * node, we should skip it and fallback to other nodes.
> > > +        */
> > > +       if (!node_isset(node, *used_node_mask) && node_state(node,
> > > N_MEMORY)) {
> > >                   node_set(node, *used_node_mask);
> > >                   return node;
> > >           }
> > > 
> > > For memoryless node, we skip it and fallback to other nodes when
> > > build its zonelists.
> > > 
> > > Say we have node0 and node1, and node0 is memoryless, then:
> > > 
> > > [    0.102400] Fallback order for Node 0: 1
> > > [    0.102931] Fallback order for Node 1: 1
> > > 
> > > In this way, we will not allocate pages from memoryless node0.
> > > 
> 
> In offline_pages(), we'll first build_all_zonelists() to then
> node_states_clear_node()->node_clear_state(node, N_MEMORY);
> 
> So at least on the offlining path, we wouldn't detect it properly yet I
> assume, and build a zonelist that contains a now-memory-less node?

Another question is what happens if a new memory is plugged into a node
that had < NODE_MIN_SIZE of memory and after hotplug it stops being
"memoryless". 

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
