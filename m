Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308B262FB22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbiKRRFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbiKRRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:05:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D35543AF5;
        Fri, 18 Nov 2022 09:05:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 593271FDAD;
        Fri, 18 Nov 2022 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668791119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PoBAkgW+tbQL1X9VKozu6shyXKkGgjJ4/KRS+GgGtcI=;
        b=CmYkPhlTaVqQW2wirDoArBSPlcaI8xIBxw/DvZrPAO7O3BJuYBRDawI2nmT/lj6YJBdG4u
        M3qOIWRxGUOh7EaWGVXaFsJkgnDiH2KRuLzFXVZln5LMteKtzKYJq1OCOX/66X3WQ5ZQCb
        ETVRU9hAK8YfxPksIq5I6Lz5UiT2NlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668791119;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PoBAkgW+tbQL1X9VKozu6shyXKkGgjJ4/KRS+GgGtcI=;
        b=wlxI9mM0HjelUGzUi/mDrMDODdAPyJSmG16jxdeeVEIMpK86rXr1ZcUCyE+Akp3RYmBeoz
        ZFXY1vmYJrq20NDQ==
Received: from suse.de (mgorman.udp.ovpn2.nue.suse.de [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 194072C141;
        Fri, 18 Nov 2022 17:05:15 +0000 (UTC)
Date:   Fri, 18 Nov 2022 17:05:10 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/9] mm: introduce Designated Movable Blocks
Message-ID: <20221118170510.kexdiqsfaqwledpm@suse.de>
References: <20221020215318.4193269-1-opendmb@gmail.com>
 <20221026105500.n6ddzqqf5ozjswsp@suse.de>
 <9842ee9c-5fcc-5458-2779-ad9b88468b48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9842ee9c-5fcc-5458-2779-ad9b88468b48@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:33:53PM -0700, Doug Berger wrote:
> > 
> > The three big questions he initially asked were
> > 
> > 	How large are these areas typically?
> > 	How large are they in comparison to other memory in the system?
> > 	How is this memory currently presented to the system?
> > 	Can you share some more how exactly ZONE_MOVABLE would help here to make
> > 		better use of the memory bandwidth?
> > 
> > Zones are about addressing limitations primarily and frankly, ZONE_MOVABLE
> > was a bad idea in retrospect. Today, the preferred approach would have
> > been to create a separate NUMA node with distance-1 to the local node
> > (fudge by adding 1 to the local distance "10" for zonelist purposes)
> > that was ZONE_MOVABLE with the zonelists structured such that GFP_MOVABLE
> > allocations would prefer the "movable" node first.
>
> I'm afraid I don't completely follow what you are suggesting here.
> 

It's not especially important how it could have been done but using a
node would have avoided confusing zones (address limitations) with memory
partitioning (e.g. MOVABLE). Nodes can also interleave but it would have
required CONFIG_NUMA so pointless for GKI and the current discussion other
than with a time machine, GKI might have enabled CONFIG_NUMA :/

> > While I don't recall
> > why I did not take that approach, it most likely was because CONFIG_NUMA
> > was not always set, it was only intended for hugetlbfs allocations and
> > maybe I didn't have the necessary skill or foresight to take that approach.
>
> It remains true that CONFIG_NUMA is not always set and that is a key
> motivator for this patch set. For example, Google is moving to a common GKI
> kernel for their Google TV platform that they are requiring vendors to
> support. Currently the arm64 GKI kernel does not set CONFIG_NUMA and it
> seems unlikely that we will be able to get all vendors to accept such a
> change.
> 

Ok.

> > 
> > Hotplugs requirements are somewhat different, the primary motivation that
> > I'm aware of is being able to guarantee they can be offlined, particularly
> > nodes, which can be done in some circumstances. Generally hotplug does
> > not care what uses the memory as long as it can be removed later. The
> > requirements for restricted access to high speed memory is different.
>
> This is effectively the same requirement that an implementation of
> 'reusable' reserved memory has. A driver that owns reserved memory may not
> care what uses the memory as long as the memory can be reclaimed when the
> driver needs it. This is functionally analogous to memory hotplug. Reserved
> memory that is 'reusable' and compatible with 'shared-dma-pool' uses the CMA
> implementation, but there is room for an alternative implementation that
> shares the memory more aggressively. This is a separate motivator for
> Designated Movable Block support, but I am deferring that discussion since
> it is desirable to have a more extended debate over APIs and such.
> 

There needs to be a better explanation as to why CMA cannot be used or more
importantly why page_alloc.shuffle= should not be used (more on that later.
It's not clear how a movable zone shares memory more aggressively than CMA
would. Both have the problem that the if protected range is too large that
premature memory exhaustion can occur for kernel allocations.

> > 
> > There is a high degree of uncertainity of how these regions are to be
> > used by applications to get access to the high speed memory, to quote
> > 
> > 	I'm not certain what is typical because these systems are highly
> > 	configurable and Broadcom's customers have different ideas about
> > 	application processing.
> > 
> > 	...
> > 
> > 	The Designated Movable Block concept introduced here has the
> > 	potential to offer useful services to different constituencies. I
> > 	tried to highlight this in my V1 patch set with the hope of
> > 	attracting some interest, but it can complicate the overall
> > 	discussion, so I would like to maybe narrow the discussion here. It
> > 	may be good to keep them in mind when assessing the overall value,
> > 	but perhaps the "other opportunities" can be covered as a follow
> > 	on discussion.
> > 
> > I note the "potential" part here because we don't actually know.
>
> I used "potential" here not as in "it might be useful", but rather that
> "different constituencies (i.e. people outside of the Broadcom ecosystem)
> might also find them useful".
> 

That's very vague unfortunately.

> > A
> > major limitation of ZONE_MOVABLE is that there is no way of controlling
> > access from userspace to restrict the high-speed memory to a designated
> > application, only to all applications in general. The primary interface
> > to control access to memory with different characteristics is mempolicies
> > which is NUMA orientated, not zone orientated. So, if there is a special
> > application that requires exclusive access, it's very difficult to configure
> > based on zones.  Furthermore, page table pages mapping data located in the
> > high-speed region are stored in the slower memory which potentially impacts
> > the performance if the working set of the application exceeds TLB reach.
> > Finally, while there is mention that Broadcom may have some special
> > interface to determine what applications can use the high-speed region,
> > it's hardware-specific as opposed to something that belongs in the core mm.
> > 
> > I agree that keeping the high-speed memory in a local node and using "sticky"
> > pageblocks or CMA has limitations of its own but in itself, that does not
> > justify using ZONE_MOVABLE in my opinion. The statement that ARM can have
> > multiple controllers with equal distance and bandwidth (if I'm reading it
> > correctly) but places them in different zones.... that's just a bit weird if
> > there are no other addressing limitations. It's not obvious why ARM would do
> > that, but it also does not matter because it shouldn't be a core mm concern.
>
> There appears to be some confusion regarding my explanation of multiple
> memory controllers on a device like the BCM7278. There is no inherent
> performance difference between the two memory controllers and their attached
> DRAM. They merely provide the opportunity to perform memory accesses in
> parallel for different physical address ranges. The physical address ranges
> were selected by the SoC designers for reasons only known to them, but I'm
> sure they had no consideration of zones in their decision making. The
> selection of zones remains an artifact of the design of Linux.
> 

Ok, so the channels are equal but the channels are not interleaved in
hardware so basically you are trying to implement software-based memory
channel interleaving?

> Since the BCM7278 contains a 4-core SMP cluster and each core can have
> multiple outstanding memory transactions the speed of DDR transactions can
> create a bottleneck for the system. If each memory controller has an
> effective bandwidth of X then, provided the system memory accesses can be
> distributed across both memory controllers, the combined effective bandwidth
> can be additive (X + X = 2X). Of course the actual result is highly
> dependent on the dependent clause "provided the system memory accesses can
> be distributed across both memory controllers". The accesses do not need to
> be evenly distributed to gain a benefit. We just want to reduce any idle
> time on each memory controller.
> 
> It was observed that the monotonic zone layout for a non-NUMA system (like
> this one) creates a bias for kernel space to use lower physical memory
> addresses and user space to use higher physical memory addresses. Broadcom
> customers requested the ability to locate movablecore memory within the
> physical address range of each memory controller and reported that it
> improved their system performance. Unfortunately, I do not have access to
> their data and I doubt they would allow me to share it if I did. I don't
> believe this is really about trying to optimize the performance of a
> specific application as much as trying to prevent overall system performance
> degradation from underutilized memory bandwidth.
> 

So if I'm reading this right, the intent behind using ZONE_MOVABLE at
fixed address ranges is so most (but not all) user pages end up using
one controller and all kernel pages and some user pages use the other
controller. If kernel and userspace accesses are split 50/50, then the
memory bandwidth usage will be split across channels.  However, if the
ratio of kernel:user accesses is large then the bandwidth usage will still
be assymetric.

For example, if there are 10 times more accesses to kernel pages then user
pages, then one channel will receive most of the traffic. The reverse
is also true but to a lesser extent as user pages can use all zones and
kernel accesses use a subset. Depending on the access pattern, creating
separate zones may not help at all and in some cases, could make the problem
worse. The trap is that it might happen to work for a fixed appliance like
a TV with a predictable workload, it may not work in the general case.

Splitting based on the __GFP_MOVABLE does not guarantee that idle time on
a memory controller can be reduced as it relies on the access pattern.

> > There are already examples of where memory is physically "local" to
> > the CPU but has different bandwidth or latency including High Bandwidth
> > (HBM), Sub-NUMA Clustering (SNC), PMEM as a memory-life device and some
> > AMD EPYC Chips, particularly the first generation where a sockets memory
> > controllers had different distances. With the broadcom controllers,
> > it sounds like a local memory controller but the bandwidth available
> > differs. It's functionally equivalent to HBM.
>
> The bandwidth available does not differ, but if too few transactions target
> one of the memory controllers, that controllers bandwidth is underutilized.
> 

This is also a limitation of the patch series. Lets say the bulk of
accesses are to user pages allocated in ZONE_MOVABLE which correlates to
one memory channel then one channel gets saturated anyway.

It also gets more complicated if there are more controllers because the
only division possible is between MOVABLE/everything else. An odd number
of channels will be difficult to split meaningfully.

> > The fact that the memory access is physically local to the CPU socket is
> > irrelevant when the characteristics of that locality differs. NUMA stands
> > for Non-Uniform Memory Access and if bandwidth to different address ranges
> > differs, then the system is inherently NUMA even if that is inconvenient.
>
> The bandwidth to different address ranges does not differ. A single threaded
> application should see no performance difference regardless of where its
> memory is located. However, if multiple application threads are executing in
> parallel and the memory is divided between the memory controllers they will
> be able to do more work per unit of time than if the memory is predominantly
> located on one memory controller.
> 

And if multiple application threads dominantly access user pages then
splitting the zone will not necessarily help, particularly if ZONE_MOVABLE
is not filled as the bulk of the accesses will still use one memory channel.

> > In the appliance case, it doesn't matter if the intent is that "all
> > application data should use high bandwidth memory where possible and
> > the application phase behaviour is predictable" and that may very well
> > work fine for the users of the Broadcom platforms with multiple memory
> > controllers. It does not work at all for the general where access must
> > be restricted to a subset of tasks in a general system that can only be
> > controlled with memory policies.
> > 
> > The high bandwidth memory should be representated as a NUMA node, optionally
> > to create that node as ZONE_MOVABLE and relying on the zonelists to select
> > the movable zone as the first preference.
> > 
> This patch set is fundamentally about greater control over the placement of
> movablecore memory. The current implementation of movablecore requires all
> of the ZONE_MOVABLE memory to be located at the highest physical addresses
> of the system when CONFIG_NUMA is not set. Allowing the specification of a
> base address allows greater flexibility on systems where there are benefits.
> 

Unfortunately, while greater control of the ranges used by ZONE_MOVABLE
will help in some cases, it will not help in others and may be misleading.

If memory accesses need to be interleaved in software then the free lists
need to be broken up into arenas within a zone by some boundary whether
that boundary is is fixed-length ranges, memory sections, memory channels
or specified explicitly on the kernel command line. Any allocation type
can use any arena with tasks moving to another arena based on contention,
pageblock type availability or interleaving round-robin explicitly.
Unfortunately, it's non-trivial to implement and a *lot* of heavy lifting.

A somewhat awful hack would be to reorder top-level MAX_ORDER-1 list at
boot time. By default that list is ordered

1, 2, 3 ...... n-2, n-1, n

If at boot time it was reordered to be

1, n, 2, n-1, 3, n-2 ......

This would interleave all the early allocations across memory channels in
the case where channels are based on large contiguous physical ranges of
memory. Applications starting early would then interleave between channels
but after a period of time, it would be pseudo-random and it's weak.

A similar, and probably better, option is to look at what page_alloc.shuffle=
does and randomly shuffle the free lists to randomly select between the
memory channels. I haven't looked at the implementation recently and forget
how it works exactly. Maybe it would benefit from being able to take ranges
that should be special cased for shuffling, particularly at boot time to
order it "1, n, 2, n-1" as described above or allowing SHUFFLE_ORDER to
be a lower value. Either way, shuffling would achieve similar goals of
spreading allocations between channels without assuming that the access
ratio of kernel:user is close to 1:1.

-- 
Mel Gorman
SUSE Labs
