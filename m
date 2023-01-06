Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C1A660989
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjAFWcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 17:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjAFWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:32:52 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5819C26;
        Fri,  6 Jan 2023 14:32:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so4473127wml.0;
        Fri, 06 Jan 2023 14:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AhAhOU/uGoo2X3e1MOFtnbyUliuMZXrFsZUiQSHWWjA=;
        b=JCNdokdT//MoBJ0Ioc+bIngwj0C/IE3y+onac6AA0gEGpUM7TlKT1IgAcXVh6utEy0
         6NwfC8ATfGCLSkR7OHlWCcMdpX4wj/TGQ9kKLdDxxrKThK0+UiHHaVRdmELuYrG1guaa
         twzYU1WcnZAmDSN3+lFEQxhgr0+hUFfAhMryGP6d8JjBQQZzGnqoDC5+N1tBBbZCUBIy
         p9Wjx0BrA24+05iMt0nK+4mYO8oN8o8+cEUNFAAKlP/3FeyNYl7HWoklBfu7gu9e13P3
         kdVskYUdzKoV3Pbi+5NzjwiCYg5cqjgexCUiPKyNi10Ts8AiY9My5pENs0bIdrWAA2Q/
         acrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhAhOU/uGoo2X3e1MOFtnbyUliuMZXrFsZUiQSHWWjA=;
        b=LLtdyz72LrUfE/KYV+J8XZf+bkiwwiQBq5rBS0Zii6JNpfmrM45E27Wu4uwoDnhh2T
         iZH9lvgc2Ztn5KNT3aUBm+lnmyKeXAC6NqqM53VpFJEmT0joeZgpOskjZnsQ23qY3aKz
         J2ptv14SSusyQ7I4XOENHqHQQHnrV2owVgeHKjAvsQu05XSHtyj6G3Wf3O4fwRI0YJvU
         3At8B/xxMPypN2adctWSoo6QxTKpkquootlr17FILMmdWHV7JxeYClQ7ugL2Aus/SyaE
         DyjkS5bhMbKhpAf4O5TgPHeAUrLj69EfxFqaHupd8qQMkj30iyaWn/EQxfaHEaducl76
         2m7A==
X-Gm-Message-State: AFqh2krI5vVa+Z+K85lxKRpj5Eh9e6SG31ME+SIH+ty/6wMDzVVnduCd
        rM3RnzBhXcUPeGIOPKe6sk4=
X-Google-Smtp-Source: AMrXdXtIA94jXVemT1nUt0qWIjlXoiHDgXxccMeiZkPNBOz1kjMMUWHE2GGjF/VAu7h2OtaC84zpfQ==
X-Received: by 2002:a05:600c:1e10:b0:3d3:404a:8a1b with SMTP id ay16-20020a05600c1e1000b003d3404a8a1bmr39893316wmb.8.1673044368190;
        Fri, 06 Jan 2023 14:32:48 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c2cdb00b003a84375d0d1sm8145976wmc.44.2023.01.06.14.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 14:32:46 -0800 (PST)
Date:   Fri, 6 Jan 2023 22:32:46 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Y7ihjpFaYy2QuORd@lucifer>
References: <20230101094523.1522109-1-rppt@kernel.org>
 <20230101094523.1522109-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230101094523.1522109-3-rppt@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 11:45:23AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  Documentation/mm/physical_memory.rst | 322 +++++++++++++++++++++++++++
>  1 file changed, 322 insertions(+)
>
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 2ab7b8c1c863..fcf52f1db16b 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -3,3 +3,325 @@
>  ===============
>  Physical Memory
>  ===============
> +
> +Linux is available for a wide range of architectures so there is a need for an
> +architecture-independent abstraction to represent the physical memory. This
> +chapter describes the structures used to manage physical memory in a running
> +system.
> +
> +The first principal concept prevalent in the memory management is
> +`Non-Uniform Memory Access (NUMA)
> +<https://en.wikipedia.org/wiki/Non-uniform_memory_access>`_.
> +With multi-core and multi-socket machines, memory may be arranged into banks
> +that incur a different cost to access depending on the “distance” from the
> +processor. For example, there might be a bank of memory assigned to each CPU or
> +a bank of memory very suitable for DMA near peripheral devices.

Absolutely wonderfully written. Perhaps put a sub-heading for NUMA here?

An aside, but I think it'd be a good idea to mention base pages, folios and
folio order pretty early on as they get touched as concepts all over the place
in physical memory (but perhaps can wait for other contribs!)

> +
> +Each bank is called a node and the concept is represented under Linux by a
> +``struct pglist_data`` even if the architecture is UMA. This structure is
> +always referenced to by it's typedef ``pg_data_t``. A pg_data_t structure
> +for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
> +``nid`` is the ID of that node.
> +
> +For NUMA architectures, the node structures are allocated by the architecture
> +specific code early during boot. Usually, these structures are allocated
> +locally on the memory bank they represent. For UMA architectures, only one
> +static pg_data_t structure called ``contig_page_data`` is used. Nodes will
> +be discussed further in Section :ref:`Nodes <nodes>`
> +
> +Each node may be divided up into a number of blocks called zones which
> +represent ranges within memory. These ranges are usually determined by
> +architectural constraints for accessing the physical memory. A zone is
> +described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each zone
> +has one of the types described below.

I don't think it's quite right to say 'may' be divided up into zones, as they
absolutely will be so (and the entire phsyical memory allocator hinges on being
zoned, even if trivially in UMA/single zone cases).

Also it's struct zone right, not zone_struct/zone_t?

I think it's important to clarify that a given zone does not map to a single
struct zone, rather that a struct zone (contained within a pg_data_t object's
array node_zones[]) represents only the portion of the zone that resides in this
node.

It's fiddly because when I talk about a zone like this I am referring to one of
the 'classifications' of zones you mention below, e.g. ZONE_DMA, ZONE_DMA32,
etc. but you might also want to refer to a zone as being equivalent to a struct
zone object.

I think the clearest thing however is to use the term zone to refer to each of
the ZONE_xxx types, e.g. 'this memory is located in ZONE_NORMAL' and to clarify
that one zone can span different individual struct zones (and thus nodes).

I know it's tricky because you and others have rightly pointed out that my own
explanation of this is confusing, and it is something I intend to rejig a bit
myself!

> +
> +`ZONE_DMA` and `ZONE_DMA32`
> +  represent memory suitable for DMA by peripheral devices that cannot
> +  access all of the addressable memory. Depending on the architecture,
> +  either of these zone types or even they both can be disabled at build
> +  time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32`` configuration
> +  options. Some 64-bit platforms may need both zones as they support
> +  peripherals with different DMA addressing limitations.

It might be worth pointing out ZONE_DMA spans an incredibly little range that
probably won't matter for any peripherals this side of the cretaceous period,
though that may be more colour than might suit the docs :) perhaps worth
pointing out that ZONE_DMA32 spans the first 32-bits of physical address space
just to nail down that a zone refers to the memory range and yes it in this case
at least is quite as simple as this.

> +
> +`ZONE_NORMAL`
> +  is for normal memory that can be accessed by the kernel all the time. DMA
> +  operations can be performed on pages in this zone if the DMA devices support
> +  transfers to all addressable memory. ZONE_NORMAL is always enabled.
> +

Might be worth saying 'this is where memory ends up if not otherwise in another
zone'.

> +`ZONE_HIGHMEM`
> +  is the part of the physical memory that is not covered by a permanent mapping
> +  in the kernel page tables. The memory in this zone is only accessible to the
> +  kernel using temporary mappings. This zone is available only some 32-bit
> +  architectures and is enabled with ``CONFIG_HIGHMEM``.
> +

I comment here only to say 'wow I am so glad I chose to only focus on 64-bit so
I could side-step all the awkward discussion of high pages' :)

> +`ZONE_MOVABLE`
> +  is for normal accessible memory, just like ZONE_NORMAL. The difference is
> +  that most pages in ZONE_MOVABLE are movable. That means that while virtual
> +  addresses of these pages do not change, their content may move between
> +  different physical pages. ZONE_MOVABLE is only enabled when one of
> +  `kernelcore`, `movablecore` and `movable_node` parameters is present in the
> +  kernel command line. See :ref:`Page migration <page_migration>` for
> +  additional details.
> +
> +`ZONE_DEVICE`
> +  represents memory residing on devices such as PMEM and GPU. It has different
> +  characteristics than RAM zone types and it exists to provide :ref:`struct
> +  page <Pages>` and memory map services for device driver identified physical
> +  address ranges. ZONE_DEVICE is enabled with configuration option
> +  ``CONFIG_ZONE_DEVICE``.
> +
> +It is important to note that many kernel operations can only take place using
> +ZONE_NORMAL so it is the most performance critical zone. Zones are discussed
> +further in Section :ref:`Zones <zones>`.
> +
> +The relation between node and zone extents is determined by the physical memory
> +map reported by the firmware, architectural constraints for memory addressing
> +and certain parameters in the kernel command line.

Perhaps worth mentioning device tree here? Though perhaps encapsulated in the
'firmware' reference.

> +
> +For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of RAM the
> +entire memory will be on node 0 and there will be three zones: ZONE_DMA,
> +ZONE_NORMAL and ZONE_HIGHMEM::
> +
> +  0                                                            2G
> +  +-------------------------------------------------------------+
> +  |                            node 0                           |
> +  +-------------------------------------------------------------+
> +
> +  0         16M                    896M                        2G
> +  +----------+-----------------------+--------------------------+
> +  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
> +  +----------+-----------------------+--------------------------+
> +
> +
> +With a kernel built with ZONE_DMA disabled and ZONE_DMA32 enabled and booted
> +with `movablecore=80%` parameter on an arm64 machine with 16 Gbytes of RAM
> +equally split between two nodes, there will be ZONE_DMA32, ZONE_NORMAL and
> +ZONE_MOVABLE on node 0, and ZONE_NORMAL and ZONE_MOVABLE on node 1::
> +
> +
> +  1G                                9G                         17G
> +  +--------------------------------+ +--------------------------+
> +  |              node 0            | |          node 1          |
> +  +--------------------------------+ +--------------------------+
> +
> +  1G       4G        4200M          9G          9320M          17G
> +  +---------+----------+-----------+ +------------+-------------+
> +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> +  +---------+----------+-----------+ +------------+-------------+
> +

Excellent diagrams!

> +.. _nodes:
> +
> +Nodes
> +=====
> +
> +As we have mentioned, each node in memory is described by a ``pg_data_t`` which
> +is a typedef for a ``struct pglist_data``. When allocating a page, by default
> +Linux uses a node-local allocation policy to allocate memory from the node
> +closest to the running CPU. As processes tend to run on the same CPU, it is
> +likely the memory from the current node will be used. The allocation policy can
> +be controlled by users as described in
> +`Documentation/admin-guide/mm/numa_memory_policy.rst`.
> +
> +Most NUMA architectures maintain an array of pointers to the node
> +structures. The actual structures are allocated early during boot when
> +architecture specific code parses the physical memory map reported by the
> +firmware. The bulk of the node initialization happens slightly later in the
> +boot process by free_area_init() function, described later in Section
> +:ref:`Initialization <initialization>`.
> +
> +
> +Along with the node structures, kernel maintains an array of ``nodemask_t``
> +bitmasks called `node_states`. Each bitmask in this array represents a set of
> +nodes with particular properties as defined by `enum node_states`:
> +
> +`N_POSSIBLE`
> +  The node could become online at some point.
> +`N_ONLINE`
> +  The node is online.
> +`N_NORMAL_MEMORY`
> +  The node has regular memory.
> +`N_HIGH_MEMORY`
> +  The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
> +  aliased to `N_NORMAL_MEMORY`.
> +`N_MEMORY`
> +  The node has memory(regular, high, movable)
> +`N_CPU`
> +  The node has one or more CPUs
> +
> +For each node that has a property described above, the bit corresponding to the
> +node ID in the ``node_states[<property>]`` bitmask is set.
> +
> +For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
> +
> +  node_states[N_POSSIBLE]
> +  node_states[N_ONLINE]
> +  node_states[N_NORMAL_MEMORY]
> +  node_states[N_MEMORY]
> +  node_states[N_CPU]
> +
> +For various operations possible with nodemasks please refer to
> +`include/linux/nodemask.h
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/nodemask.h>`_.
> +
> +Among other things, nodemasks are used to provide macros for node traversal,
> +namely `for_each_node()` and `for_each_online_node()`.
> +
> +For instance, to call a function foo() for each online node::
> +
> +	for_each_online_node(nid) {
> +		pg_data_t *pgdat = NODE_DATA(nid);
> +
> +		foo(pgdat);
> +	}
> +
> +Node structure
> +--------------
> +
> +The struct pglist_data is declared in `include/linux/mmzone.h
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mmzone.h>`_.
> +Here we briefly describe fields of this structure:

Perhaps worth saying 'The node structure' just to reiterate.

> +
> +General
> +~~~~~~~
> +
> +`node_zones`
> +  The zones for this node.  Not all of the zones may be populated, but it is
> +  the full list. It is referenced by this node's node_zonelists as well as
> +  other node's node_zonelists.

Perhaps worth describing what zonelists (and equally zonerefs) are here or
above, and that this is the canonical place where zones reside. Maybe reference
populated_zone() and for_each_populated_zone() in reference to the fact that not
all here may be populated?

> +
> +`node_zonelists` The list of all zones in all nodes. This list defines the
> +  order of zones that allocations are preferred from. The `node_zonelists` is
> +  set up by build_zonelists() in mm/page_alloc.c during the initialization of
> +  core memory management structures.
> +
> +`nr_zones`
> +  Number of populated zones in this node.
> +
> +`node_mem_map`
> +  For UMA systems that use FLATMEM memory model the 0's node (and the only)
> +  `node_mem_map` is array of struct pages representing each physical frame.
> +
> +`node_page_ext`
> +  For UMA systems that use FLATMEM memory model the 0's (and the only) node
> +  `node_mem_map` is array of extensions of struct pages. Available only in the
> +  kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
> +
> +`node_start_pfn`
> +  The page frame number of the starting page frame in this node.
> +
> +`node_present_pages`
> +  Total number of physical pages present in this node.
> +
> +`node_spanned_pages`
> +  Total size of physical page range, including holes.
> +

I think it'd be useful to discuss briefly the meaning of managed, spanned and
present pages in the context of zones.

> +`node_size_lock`
> +  A lock that protects the fields defining the node extents. Only defined when
> +  at least one of ``CONFIG_MEMORY_HOTPLUG`` or
> +  ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` configuration options are enabled.
> +
> +  pgdat_resize_lock() and pgdat_resize_unlock() are provided to manipulate
> +  node_size_lock without checking for CONFIG_MEMORY_HOTPLUG or
> +  CONFIG_DEFERRED_STRUCT_PAGE_INIT.
> +
> +`node_id`
> +  The Node ID (NID) of the node, starts at 0.
> +
> +`totalreserve_pages`
> +  This is a per~node reserve of pages that are not available to userspace
> +  allocations.
> +
> +`first_deferred_pfn`
> +  If memory initialization on large machines is deferred then this is the first
> +  PFN that needs to be initialized. Defined only when
> +  ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` is enabled
> +
> +`deferred_split_queue`
> +  Per-node queue of huge pages that their split was deferred. Defined only when ``CONFIG_TRANSPARENT_HUGEPAGE`` is enabled.
> +
> +`__lruvec`
> +  Per-node lruvec holding LRU lists and related parameters. Used only when memory cgroups are disabled. Should not be accessed directly, use mem_cgroup_lruvec() to look up lruvecs instead.
> +
> +Reclaim control
> +~~~~~~~~~~~~~~~
> +
> +See also :ref:`Page Reclaim <page_reclaim>`.
> +
> +`kswapd`
> +  Per-node instance of kswapd kernel thread.
> +
> +`kswapd_wait`, `pfmemalloc_wait`, `reclaim_wait`
> +  Workqueues used to synchronize memory reclaim tasks
> +
> +`nr_writeback_throttled`
> +  Number of tasks that are throttled waiting on dirty pages to clean.
> +
> +`nr_reclaim_start`
> +  Number of pages written while reclaim is throttled waiting for writeback.
> +
> +`kswapd_order`
> +  Controls the order kswapd tries to reclaim
> +
> +`kswapd_highest_zoneidx`
> +  The highest zone index to be reclaimed by kswapd
> +
> +`kswapd_failures`
> +  Number of runs kswapd was unable to reclaim any pages
> +
> +`min_unmapped_pages`
> +  Minimal number of unmapped file backed pages that cannot be reclaimed. Determined by vm.min_unmapped_ratio sysctl.
> +  Only defined when ``CONFIG_NUMA`` is enabled.
> +
> +`min_slab_pages`
> +  Minimal number of SLAB pages that cannot be reclaimed. Determined by vm.min_slab_ratio sysctl.
> +  Only defined when ``CONFIG_NUMA`` is enabled
> +
> +`flags`
> +  Flags controlling reclaim behavior.
> +
> +Compaction control
> +~~~~~~~~~~~~~~~~~~
> +
> +`kcompactd_max_order`
> +  Page order that kcompactd should try to achieve.
> +
> +`kcompactd_highest_zoneidx`
> +  The highest zone index to be compacted by kcompactd.
> +
> +`kcompactd_wait`
> +  Workqueue used to synchronizes memory compaction tasks.
> +
> +`kcompactd`
> +  Per-node instance of kcompactd kernel thread.
> +
> +`proactive_compact_trigger`
> +  Determines if proactive compaction is enabled. Controlled by vm.compaction_proactiveness sysctl.
> +
> +Statistics
> +~~~~~~~~~~
> +
> +`per_cpu_nodestats`
> +  Per-CPU VM statistics for the node
> +
> +`vm_stat`
> +  VM statistics for the node.
> +
> +.. _zones:
> +
> +Zones
> +=====
> +
> +.. _pages:
> +
> +Pages
> +=====
> +
> +.. _folios:
> +
> +Folios
> +======
> +
> +.. _initialization:
> +
> +Initialization
> +==============
> --
> 2.35.1
>

Overall it's fantastically written (you're a gifted writer!) and a great basis
on which to build further documentation.

I hope you can forgive the nitpicking (which unfortunately is a little too easy
when reviewing doc patches I feel) and that my comments are useful!

Cheers, Lorenzo
