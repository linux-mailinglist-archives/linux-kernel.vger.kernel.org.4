Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2803C60DF14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiJZKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiJZKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:55:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189872CE16;
        Wed, 26 Oct 2022 03:55:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C36412205C;
        Wed, 26 Oct 2022 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666781709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HAt5FBKV9RL7hs9/QVd1WPZhp817cXu5ejrQL8koQQ=;
        b=DY7nP7u7byFCYE4a1N87hZqzJhPb+jr1Q3OIe8/c4C3KjWUseIqdicIE6BP0jYd33vpHvJ
        cCDpeYvbW5UO7j5AXluqvgoneobDTXjCUZ5Qbca+h+yMKVpANiGFrdRPKV4rMpsVLbiBKU
        X74VdzU4XpLaxdpVyBjqQ3V4auxPMEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666781709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HAt5FBKV9RL7hs9/QVd1WPZhp817cXu5ejrQL8koQQ=;
        b=dwpQ2ciGf2nOdP59aa3pSGwP9SmNb6VOKUCj17ItsVnNtDd5GOukLh6JAL+2wuIin/4+nk
        yH2Tpg5ukDSr4+BQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 920FC2C141;
        Wed, 26 Oct 2022 10:55:07 +0000 (UTC)
Date:   Wed, 26 Oct 2022 11:55:00 +0100
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
Message-ID: <20221026105500.n6ddzqqf5ozjswsp@suse.de>
References: <20221020215318.4193269-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221020215318.4193269-1-opendmb@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:53:09PM -0700, Doug Berger wrote:
> MOTIVATION:
> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
> controllers with each mapped in a different address range within
> a Uniform Memory Architecture. Some users of these systems have
> expressed the desire to locate ZONE_MOVABLE memory on each
> memory controller to allow user space intensive processing to
> make better use of the additional memory bandwidth.
> Unfortunately, the historical monotonic layout of zones would
> mean that if the lowest addressed memory controller contains
> ZONE_MOVABLE memory then all of the memory available from
> memory controllers at higher addresses must also be in the
> ZONE_MOVABLE zone. This would force all kernel memory accesses
> onto the lowest addressed memory controller and significantly
> reduce the amount of memory available for non-movable
> allocations.
> 

I didn't review the first version of this patch because others, particularly
David Hildenbrand highlighted many of the concerns I had. I broadly followed
the discussion but didn't respond because I live in a permanent state of
having too much to do but with a new version, I have to say something.

The three big questions he initially asked were

	How large are these areas typically?
	How large are they in comparison to other memory in the system?
	How is this memory currently presented to the system?
	Can you share some more how exactly ZONE_MOVABLE would help here to make
		better use of the memory bandwidth?

Zones are about addressing limitations primarily and frankly, ZONE_MOVABLE
was a bad idea in retrospect. Today, the preferred approach would have
been to create a separate NUMA node with distance-1 to the local node
(fudge by adding 1 to the local distance "10" for zonelist purposes)
that was ZONE_MOVABLE with the zonelists structured such that GFP_MOVABLE
allocations would prefer the "movable" node first. While I don't recall
why I did not take that approach, it most likely was because CONFIG_NUMA
was not always set, it was only intended for hugetlbfs allocations and
maybe I didn't have the necessary skill or foresight to take that approach.

Hotplugs requirements are somewhat different, the primary motivation that
I'm aware of is being able to guarantee they can be offlined, particularly
nodes, which can be done in some circumstances. Generally hotplug does
not care what uses the memory as long as it can be removed later. The
requirements for restricted access to high speed memory is different.

There is a high degree of uncertainity of how these regions are to be
used by applications to get access to the high speed memory, to quote

	I'm not certain what is typical because these systems are highly
	configurable and Broadcom's customers have different ideas about
	application processing.

	...

	The Designated Movable Block concept introduced here has the
	potential to offer useful services to different constituencies. I
	tried to highlight this in my V1 patch set with the hope of
	attracting some interest, but it can complicate the overall
	discussion, so I would like to maybe narrow the discussion here. It
	may be good to keep them in mind when assessing the overall value,
	but perhaps the "other opportunities" can be covered as a follow
	on discussion.

I note the "potential" part here because we don't actually know. A
major limitation of ZONE_MOVABLE is that there is no way of controlling
access from userspace to restrict the high-speed memory to a designated
application, only to all applications in general. The primary interface
to control access to memory with different characteristics is mempolicies
which is NUMA orientated, not zone orientated. So, if there is a special
application that requires exclusive access, it's very difficult to configure
based on zones.  Furthermore, page table pages mapping data located in the
high-speed region are stored in the slower memory which potentially impacts
the performance if the working set of the application exceeds TLB reach.
Finally, while there is mention that Broadcom may have some special
interface to determine what applications can use the high-speed region,
it's hardware-specific as opposed to something that belongs in the core mm.

I agree that keeping the high-speed memory in a local node and using "sticky"
pageblocks or CMA has limitations of its own but in itself, that does not
justify using ZONE_MOVABLE in my opinion. The statement that ARM can have
multiple controllers with equal distance and bandwidth (if I'm reading it
correctly) but places them in different zones.... that's just a bit weird if
there are no other addressing limitations. It's not obvious why ARM would do
that, but it also does not matter because it shouldn't be a core mm concern.

There are already examples of where memory is physically "local" to
the CPU but has different bandwidth or latency including High Bandwidth
(HBM), Sub-NUMA Clustering (SNC), PMEM as a memory-life device and some
AMD EPYC Chips, particularly the first generation where a sockets memory
controllers had different distances. With the broadcom controllers,
it sounds like a local memory controller but the bandwidth available
differs. It's functionally equivalent to HBM.

The fact that the memory access is physically local to the CPU socket is
irrelevant when the characteristics of that locality differs. NUMA stands
for Non-Uniform Memory Access and if bandwidth to different address ranges
differs, then the system is inherently NUMA even if that is inconvenient.

While I have not evaluated the implementation in detail, there is already
infrastructure dealing with tiered memory (memory that is local but has
different characteristics) with support for moving memory between tiers
depending on access patterns. Memory policies can be used to restrict
access to what processes can access the higher bandwidth memory. Given the
use case for DSM, I suspect that the intent is "application data uses high
bandwidth memory where possible and kernel uses lower bandwidth memory"
which is probably fine for an appliance because there is only one workload
but it's not a generic solution suitable.

Going back to the original questions;

	How large are these areas typically?
	How large are they in comparison to other memory in the system?

I am treating this as the same question because the consequencs are the
same. A high ratio of !MOVABLE:MOVABLE can cause big problems including
premature OOM, surprising reclaim behaviour etc

	How is this memory currently presented to the system?

It's local, but with different characteristics so it's inherently NUMA
because it's Non-Uniform, there is no getting away from that.

	Can you share some more how exactly ZONE_MOVABLE would help here to make
		better use of the memory bandwidth?

In the appliance case, it doesn't matter if the intent is that "all
application data should use high bandwidth memory where possible and
the application phase behaviour is predictable" and that may very well
work fine for the users of the Broadcom platforms with multiple memory
controllers. It does not work at all for the general where access must
be restricted to a subset of tasks in a general system that can only be
controlled with memory policies.

The high bandwidth memory should be representated as a NUMA node, optionally
to create that node as ZONE_MOVABLE and relying on the zonelists to select
the movable zone as the first preference.

-- 
Mel Gorman
SUSE Labs
