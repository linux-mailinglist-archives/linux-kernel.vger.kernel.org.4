Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B969797F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBOKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjBOKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:05:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C7C5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CD7BB81F81
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D08EC433D2;
        Wed, 15 Feb 2023 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676455510;
        bh=+40pgbNx1mfVdszd2dJGbIj51cHRI+hvUPY1VqaVb1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B75bhV0SZSZkVkNzkLMg+bXOBR9kv/dwTgZcuqbbgC0MOOFVbXRLd5B4lOOfJyMfk
         NHMDSSkgNkSJhIA7JY06MEJ0ZuOqfXPk3WE+sFpquBCC9Z3L4fLKEQEPdMO8qunsZ4
         dT/4LRnxrQNrs4hPXOuuFbfYw+Fi+R6f+4E1S1sF9u5jTFHdQaRXSuwa++DEH9cAb8
         TGPPt/BQ0AlgKlza1BZg0UiqPBiop8/5Z2ck5XFVnmQ+i2zFKZ2ZeaTIRBW9T9HKg3
         G8JkNEawIUojXz1TcsNgY+cKwwKFZh3GQfZ/Qme13PGZK0kj4tnGVcOjn/2Dbt2eqA
         OcwAG64AR5ZqQ==
Date:   Wed, 15 Feb 2023 12:04:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Qi Zheng <arch0.zheng@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>, x86@kernel.org
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Message-ID: <Y+yuRggjs0otCXFz@kernel.org>
References: <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
 <a7f8be91-32c1-bfbe-7e81-5b1e818ba01d@redhat.com>
 <a09bfe3a-87e4-f8ce-89bb-c5fde8cc33c9@redhat.com>
 <Y+uO5IE7boORqsne@dhcp22.suse.cz>
 <Y+ymKw1eJaRcmDNN@kernel.org>
 <3a85b2b9-95fa-4123-a7a3-2bd6f8b35c13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a85b2b9-95fa-4123-a7a3-2bd6f8b35c13@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:43:58AM +0100, David Hildenbrand wrote:
> On 15.02.23 10:30, Mike Rapoport wrote:
> > On Tue, Feb 14, 2023 at 02:38:44PM +0100, Michal Hocko wrote:
> > > On Tue 14-02-23 12:58:39, David Hildenbrand wrote:
> > > > On 14.02.23 12:48, David Hildenbrand wrote:
> > > > > On 14.02.23 12:44, Mike Rapoport wrote:
> > > > > > (added x86 folks)
> > > > > > 
> > > > > > On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
> > > > > > > On 14.02.23 12:26, Qi Zheng wrote:
> > > > > > > > On 2023/2/14 19:22, David Hildenbrand wrote:
> > > > > > > > > 
> > > > > > > > > TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
> > > > > > > > > pretty x86 specific thing.
> > > > > > > > > 
> > > > > > > > > Are we sure we want to get NODE_MIN_SIZE involved?
> > > > > > > > 
> > > > > > > > Maybe add an arch_xxx() to handle it?
> > > > > > > 
> > > > > > > I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
> > > > > > > all. It smells like an arch-specific hack looking at
> > > > > > > 
> > > > > > > "Don't confuse VM with a node that doesn't have the minimum amount of
> > > > > > > memory"
> > > > > > > 
> > > > > > > Why shouldn't mm-core deal with that?
> > > > > > 
> > > > > > Well, a node with <4M RAM is not very useful and bears all the overhead of
> > > > > > an extra live node.
> > > > > 
> > > > > And totally not with 4.1M, haha.
> > > > > 
> > > > > I really like the "Might fix boot" in the commit description.
> > > > > 
> > > > > > 
> > > > > > But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
> > > > > > weird HW configurations just live with this?
> > > > > 
> > > > > 
> > > > > ;)
> > > > > 
> > > > 
> > > > Actually, remembering 09f49dca570a ("mm: handle uninitialized numa nodes
> > > > gracefully"), this might be the right thing to do. That commit assumes that
> > > > all offline nodes would get the pgdat allocated in free_area_init(). So that
> > > > we end up with an allocated pgdat for all possible nodes. The reasoning IIRC
> > > > was that we don't care about wasting memory in weird VM setups.
> > > 
> > > Yes, that is the case indeed. I suspect the NODE_MIN_SIZE is a relict of
> > > the past when some PXM entries were incorrect or fishy. I would just
> > > drop the check and see whether something breaks. Or make those involved
> > > back then remember whether this is addressing something that is relevant
> > > these days. Even 5MB node makes (as the memmap is allocated for the
> > > whole memory section anyway and that is 128MB) a very little sense if you ask me.
> > 
> > How about we try this:
> > 
> >  From b670120bcacd3fe34a40d7179c70ca2ab69279e0 Mon Sep 17 00:00:00 2001
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > Date: Wed, 15 Feb 2023 11:12:18 +0200
> > Subject: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
> > 
> > Qi Zheng reports crashes in a production environment and provides a
> > simplified example as a reproducer:
> > 
> >    For example, if we use qemu to start a two NUMA node kernel,
> >    one of the nodes has 2M memory (less than NODE_MIN_SIZE),
> >    and the other node has 2G, then we will encounter the
> >    following panic:
> > 
> >    [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >    [    0.150783] #PF: supervisor write access in kernel mode
> >    [    0.151488] #PF: error_code(0x0002) - not-present page
> >    <...>
> >    [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
> >    <...>
> >    [    0.169781] Call Trace:
> >    [    0.170159]  <TASK>
> >    [    0.170448]  deactivate_slab+0x187/0x3c0
> >    [    0.171031]  ? bootstrap+0x1b/0x10e
> >    [    0.171559]  ? preempt_count_sub+0x9/0xa0
> >    [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
> >    [    0.172735]  ? bootstrap+0x1b/0x10e
> >    [    0.173236]  bootstrap+0x6b/0x10e
> >    [    0.173720]  kmem_cache_init+0x10a/0x188
> >    [    0.174240]  start_kernel+0x415/0x6ac
> >    [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
> >    [    0.175417]  </TASK>
> >    [    0.175713] Modules linked in:
> >    [    0.176117] CR2: 0000000000000000
> > 
> > The crashes happen because of inconsistency between nodemask that has
> > nodes with less than 4MB as memoryless and the actual memory fed into
> > core mm.
> > 
> > The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> > empty node in SRAT parsing") that introduced minimal size of a NUMA node
> > does not explain why a node size cannot be less than 4MB and what boot
> > failures this restriction might fix.
> > 
> > Since then a lot has changed and core mm won't confuse badly about small
> > node sizes.
> > 
> > Drop the limitation for the minimal node size.
> > 
> > Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >   arch/x86/include/asm/numa.h | 7 -------
> >   arch/x86/mm/numa.c          | 7 -------
> >   2 files changed, 14 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> > index e3bae2b60a0d..ef2844d69173 100644
> > --- a/arch/x86/include/asm/numa.h
> > +++ b/arch/x86/include/asm/numa.h
> > @@ -12,13 +12,6 @@
> >   #define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
> > -/*
> > - * Too small node sizes may confuse the VM badly. Usually they
> > - * result from BIOS bugs. So dont recognize nodes as standalone
> > - * NUMA entities that have less than this amount of RAM listed:
> > - */
> > -#define NODE_MIN_SIZE (4*1024*1024)
> > -
> >   extern int numa_off;
> >   /*
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..55e3d895f15c 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -601,13 +601,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >   		if (start >= end)
> >   			continue;
> > -		/*
> > -		 * Don't confuse VM with a node that doesn't have the
> > -		 * minimum amount of memory:
> > -		 */
> > -		if (end && (end - start) < NODE_MIN_SIZE)
> > -			continue;
> > -
> >   		alloc_node_data(nid);
> >   	}
> 
> Hopefully it fixes the issue.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> The 4 MiB looks like the magical MAX_ORDER (and/or pageblock) thingy to me.
> I recall that there were issues in the past when memory exposed to the buddy
> would only be partially covering a pageblock. IIRC, memblock should already
> take care to not expose memory to the buddy that is not aligned to MAX_ORDER
> boundaries -- correct?

I don't remember those issues, but memblock does not align memory freed to
the buddy.

Still, this 4MB looks like a really old magic that was way before memblock
and even SPARSEMEM was experimental back then.

It's possible that the issues were with DISCONTIGMEM or with bootmem.
 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
