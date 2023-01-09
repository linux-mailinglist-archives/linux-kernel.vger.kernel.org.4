Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA60662730
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjAINed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjAINde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:33:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7A3218D;
        Mon,  9 Jan 2023 05:33:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0614E6112A;
        Mon,  9 Jan 2023 13:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDA9C433EF;
        Mon,  9 Jan 2023 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673271210;
        bh=0Ilxi1rMtgAs305FaWmpiguznC+wkJwOtG9vo1iisvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWEnEjc1iN3SVDaTHmDISxS07zcZdzOyHfMFbHBIkG28rGbuAKo7QUuGT3/uOM3Gk
         z8c6mBdGha3cufG4JciS8Dg3dwEmEb+3QoUVh6VmtQoo7N85CeXO2nBerrGGs4uul8
         X3lWIjeC2w8PLvXkyDD4NEVPn73yjwsdraGBzIvMPjyxn/BRqZHku6kaosRvdA1NEa
         YliCXTwh74+axsNgb8Xo08PUlmy/OWdaT9Urik5Nig6wNPuyECA55GCNRf78UraCJg
         +BirGO5zsowURkAi3tHC3ekgykhb9PyStZx2stU8MjSTfovHmAj5ap4jERKeWqxu2n
         tJ18hSkGkVnoA==
Date:   Mon, 9 Jan 2023 15:33:15 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y7wXm/3POivfwSHE@kernel.org>
References: <20230101094523.1522109-1-rppt@kernel.org>
 <20230101094523.1522109-3-rppt@kernel.org>
 <Y7ihjpFaYy2QuORd@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7ihjpFaYy2QuORd@lucifer>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 10:32:46PM +0000, Lorenzo Stoakes wrote:
> On Sun, Jan 01, 2023 at 11:45:23AM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >  Documentation/mm/physical_memory.rst | 322 +++++++++++++++++++++++++++
> >  1 file changed, 322 insertions(+)
> >
> > diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> > index 2ab7b8c1c863..fcf52f1db16b 100644
> > --- a/Documentation/mm/physical_memory.rst
> > +++ b/Documentation/mm/physical_memory.rst
> > @@ -3,3 +3,325 @@
> >  ===============
> >  Physical Memory
> >  ===============
> > +
> > +Linux is available for a wide range of architectures so there is a need for an
> > +architecture-independent abstraction to represent the physical memory. This
> > +chapter describes the structures used to manage physical memory in a running
> > +system.
> > +
> > +The first principal concept prevalent in the memory management is
> > +`Non-Uniform Memory Access (NUMA)
> > +<https://en.wikipedia.org/wiki/Non-uniform_memory_access>`_.
> > +With multi-core and multi-socket machines, memory may be arranged into banks
> > +that incur a different cost to access depending on the “distance” from the
> > +processor. For example, there might be a bank of memory assigned to each CPU or
> > +a bank of memory very suitable for DMA near peripheral devices.
> 
> Absolutely wonderfully written.

Thanks to Mel :)

> Perhaps put a sub-heading for NUMA here?

I consider all this text as an high level overview and I'd prefer to keep
it as a single piece.
 
> An aside, but I think it'd be a good idea to mention base pages, folios and
> folio order pretty early on as they get touched as concepts all over the place
> in physical memory (but perhaps can wait for other contribs!)

The plan is to have "Pages" section Really Soon :)
 
> > +
> > +Each bank is called a node and the concept is represented under Linux by a
> > +``struct pglist_data`` even if the architecture is UMA. This structure is
> > +always referenced to by it's typedef ``pg_data_t``. A pg_data_t structure
> > +for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
> > +``nid`` is the ID of that node.
> > +
> > +For NUMA architectures, the node structures are allocated by the architecture
> > +specific code early during boot. Usually, these structures are allocated
> > +locally on the memory bank they represent. For UMA architectures, only one
> > +static pg_data_t structure called ``contig_page_data`` is used. Nodes will
> > +be discussed further in Section :ref:`Nodes <nodes>`
> > +
> > +Each node may be divided up into a number of blocks called zones which
> > +represent ranges within memory. These ranges are usually determined by
> > +architectural constraints for accessing the physical memory. A zone is
> > +described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each zone
> > +has one of the types described below.
> 
> I don't think it's quite right to say 'may' be divided up into zones, as they
> absolutely will be so (and the entire phsyical memory allocator hinges on being
> zoned, even if trivially in UMA/single zone cases).

Not necessarily. ZONE_DMA or ZONE_NORMAL may span the entire memory.
 
> Also it's struct zone right, not zone_struct/zone_t?

Right, thanks.
 
> I think it's important to clarify that a given zone does not map to a single
> struct zone, rather that a struct zone (contained within a pg_data_t object's
> array node_zones[]) represents only the portion of the zone that resides in this
> node.
> 
> It's fiddly because when I talk about a zone like this I am referring to one of
> the 'classifications' of zones you mention below, e.g. ZONE_DMA, ZONE_DMA32,
> etc. but you might also want to refer to a zone as being equivalent to a struct
> zone object.
> 
> I think the clearest thing however is to use the term zone to refer to each of
> the ZONE_xxx types, e.g. 'this memory is located in ZONE_NORMAL' and to clarify
> that one zone can span different individual struct zones (and thus nodes).
> 
> I know it's tricky because you and others have rightly pointed out that my own
> explanation of this is confusing, and it is something I intend to rejig a bit
> myself!

The term 'zone' is indeed somewhat ambiguous, I'll try to come up with more
clear version.
 
> > +
> > +`ZONE_DMA` and `ZONE_DMA32`
> > +  represent memory suitable for DMA by peripheral devices that cannot
> > +  access all of the addressable memory. Depending on the architecture,
> > +  either of these zone types or even they both can be disabled at build
> > +  time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32`` configuration
> > +  options. Some 64-bit platforms may need both zones as they support
> > +  peripherals with different DMA addressing limitations.
> 
> It might be worth pointing out ZONE_DMA spans an incredibly little range that
> probably won't matter for any peripherals this side of the cretaceous period,

On RPi4 ZONE_DMA spans 1G, which is quite some part of the memory ;-)

> > +
> > +`ZONE_NORMAL`
> > +  is for normal memory that can be accessed by the kernel all the time. DMA
> > +  operations can be performed on pages in this zone if the DMA devices support
> > +  transfers to all addressable memory. ZONE_NORMAL is always enabled.
> > +
> 
> Might be worth saying 'this is where memory ends up if not otherwise in another
> zone'.

This may not be the case on !x86.
 
> > +`ZONE_HIGHMEM`
> > +  is the part of the physical memory that is not covered by a permanent mapping
> > +  in the kernel page tables. The memory in this zone is only accessible to the
> > +  kernel using temporary mappings. This zone is available only some 32-bit
> > +  architectures and is enabled with ``CONFIG_HIGHMEM``.
> > +
> 
> I comment here only to say 'wow I am so glad I chose to only focus on 64-bit so
> I could side-step all the awkward discussion of high pages' :)
> 
> > +The relation between node and zone extents is determined by the physical memory
> > +map reported by the firmware, architectural constraints for memory addressing
> > +and certain parameters in the kernel command line.
> 
> Perhaps worth mentioning device tree here? Though perhaps encapsulated in the
> 'firmware' reference.

It is :) 

> > +Node structure
> > +--------------
> > +
> > +The struct pglist_data is declared in `include/linux/mmzone.h
> > +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mmzone.h>`_.
> > +Here we briefly describe fields of this structure:
> 
> Perhaps worth saying 'The node structure' just to reiterate.

Not sure I follow, can you phrase the entire sentence?
 
> > +
> > +General
> > +~~~~~~~
> > +
> > +`node_zones`
> > +  The zones for this node.  Not all of the zones may be populated, but it is
> > +  the full list. It is referenced by this node's node_zonelists as well as
> > +  other node's node_zonelists.
> 
> Perhaps worth describing what zonelists (and equally zonerefs) are here or
> above, and that this is the canonical place where zones reside. Maybe reference
> populated_zone() and for_each_populated_zone() in reference to the fact that not
> all here may be populated?

I'd prefer to start simple and than add more content on top.
 
> > +
> > +`node_zonelists` The list of all zones in all nodes. This list defines the
> > +  order of zones that allocations are preferred from. The `node_zonelists` is
> > +  set up by build_zonelists() in mm/page_alloc.c during the initialization of
> > +  core memory management structures.
> > +
> > +`nr_zones`
> > +  Number of populated zones in this node.
> > +
> > +`node_mem_map`
> > +  For UMA systems that use FLATMEM memory model the 0's node (and the only)
> > +  `node_mem_map` is array of struct pages representing each physical frame.
> > +
> > +`node_page_ext`
> > +  For UMA systems that use FLATMEM memory model the 0's (and the only) node
> > +  `node_mem_map` is array of extensions of struct pages. Available only in the
> > +  kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
> > +
> > +`node_start_pfn`
> > +  The page frame number of the starting page frame in this node.
> > +
> > +`node_present_pages`
> > +  Total number of physical pages present in this node.
> > +
> > +`node_spanned_pages`
> > +  Total size of physical page range, including holes.
> > +
> 
> I think it'd be useful to discuss briefly the meaning of managed, spanned and
> present pages in the context of zones.

This will be a part of the Zones section.
 
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.
