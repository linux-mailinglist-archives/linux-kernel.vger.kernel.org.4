Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB467BADD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjAYT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjAYT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:29:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0428D2F;
        Wed, 25 Jan 2023 11:29:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B581615C7;
        Wed, 25 Jan 2023 19:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F88C4339E;
        Wed, 25 Jan 2023 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674674939;
        bh=e26NG6knwaYVcB1yQ5DxesL+2c1hEGvZdYEi2xrkBMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wt+KjoOHmo3AK6SngjGadIkO/LfiEDMVWsgdJAUW6Xx4aPiWLI8HIRJ2TXm4PQpwh
         hsZVLtNYcYOgiZdSXVCX/tYSvc5AQfV0F/NUlH7MJgxQ6DEO5mN+HAdlAerI2hEvvq
         BfGXc7GM+2uU4hG+3e2KYHov9HYIwGNpXY2VZe+HM6br3qU4laKtE6lIvSGf8I9CWN
         7RFbxxkSQ1RYJ5//RR23Ee4RYVUJOSpWUrJ/n5SiVTpGoILRLJQqCp2IEeAYzengpS
         nDx1rJBGu8INx2vDQw272EgdQsVrp5kgj4Xs8G9UZgHmIQ3Vcg+8vZXY7YJE5HdCto
         fOXq8CEsMqrrA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v5 1/1] docs/mm: Physical Memory: add structure, introduction and nodes description
Date:   Wed, 25 Jan 2023 21:28:41 +0200
Message-Id: <20230125192841.25342-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230125192841.25342-1-rppt@kernel.org>
References: <20230125192841.25342-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Add structure, introduction and Nodes section to Physical Memory
chapter.

As the new documentation references core-api/dma-api and mm/page_reclaim,
add page labels to those documents.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/core-api/dma-api.rst   |   2 +
 Documentation/mm/page_reclaim.rst    |   2 +
 Documentation/mm/physical_memory.rst | 347 +++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 829f20a193ca..c847a5b0a0d3 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -1,3 +1,5 @@
+.. _dma_api:
+
 ============================================
 Dynamic DMA mapping using the generic device
 ============================================
diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_reclaim.rst
index 50a30b7f8ac3..3fccde066436 100644
--- a/Documentation/mm/page_reclaim.rst
+++ b/Documentation/mm/page_reclaim.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _page_reclaim:
+
 ============
 Page Reclaim
 ============
diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 2ab7b8c1c863..d24220d62475 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -3,3 +3,350 @@
 ===============
 Physical Memory
 ===============
+
+Linux is available for a wide range of architectures so there is a need for an
+architecture-independent abstraction to represent the physical memory. This
+chapter describes the structures used to manage physical memory in a running
+system.
+
+The first principal concept prevalent in the memory management is
+`Non-Uniform Memory Access (NUMA)
+<https://en.wikipedia.org/wiki/Non-uniform_memory_access>`_.
+With multi-core and multi-socket machines, memory may be arranged into banks
+that incur a different cost to access depending on the “distance” from the
+processor. For example, there might be a bank of memory assigned to each CPU or
+a bank of memory very suitable for DMA near peripheral devices.
+
+Each bank is called a node and the concept is represented under Linux by a
+``struct pglist_data`` even if the architecture is UMA. This structure is
+always referenced to by it's typedef ``pg_data_t``. ``A pg_data_t`` structure
+for a particular node can be referenced by ``NODE_DATA(nid)`` macro where
+``nid`` is the ID of that node.
+
+For NUMA architectures, the node structures are allocated by the architecture
+specific code early during boot. Usually, these structures are allocated
+locally on the memory bank they represent. For UMA architectures, only one
+static ``pg_data_t`` structure called ``contig_page_data`` is used. Nodes will
+be discussed further in Section :ref:`Nodes <nodes>`
+
+The entire physical address space is partitioned into one or more blocks
+called zones which represent ranges within memory. These ranges are usually
+determined by architectural constraints for accessing the physical memory.
+The memory range within a node that corresponds to a particular zone is
+described by a ``struct zone``, typedeffed to ``zone_t``. Each zone has
+one of the types described below.
+
+* ``ZONE_DMA`` and ``ZONE_DMA32`` historically represented memory suitable for
+  DMA by peripheral devices that cannot access all of the addressable
+  memory. For many years there are better more and robust interfaces to get
+  memory with DMA specific requirements (:ref:`DMA API <dma_api>`), but
+  ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that have
+  restrictions on how they can be accessed.
+  Depending on the architecture, either of these zone types or even they both
+  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
+  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may need
+  both zones as they support peripherals with different DMA addressing
+  limitations.
+
+* ``ZONE_NORMAL`` is for normal memory that can be accessed by the kernel all
+  the time. DMA operations can be performed on pages in this zone if the DMA
+  devices support transfers to all addressable memory. ``ZONE_NORMAL`` is
+  always enabled.
+
+* ``ZONE_HIGHMEM`` is the part of the physical memory that is not covered by a
+  permanent mapping in the kernel page tables. The memory in this zone is only
+  accessible to the kernel using temporary mappings. This zone is available
+  only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM``.
+
+* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMAL``.
+  The difference is that the contents of most pages in ``ZONE_MOVABLE`` is
+  movable. That means that while virtual addresses of these pages do not
+  change, their content may move between different physical pages. Often
+  ``ZONE_MOVABLE`` is populated during memory hotplug, but it may be
+  also populated on boot using one of ``kernelcore``, ``movablecore`` and
+  ``movable_node`` kernel command line parameters. See :ref:`Page migration
+  <page_migration>` and :ref:`Memory Hot(Un)Plug <admin_guide_memory_hotplug>`
+  for additional details.
+
+* ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and GPU.
+  It has different characteristics than RAM zone types and it exists to provide
+  :ref:`struct page <Pages>` and memory map services for device driver
+  identified physical address ranges. ``ZONE_DEVICE`` is enabled with
+  configuration option ``CONFIG_ZONE_DEVICE``.
+
+It is important to note that many kernel operations can only take place using
+``ZONE_NORMAL`` so it is the most performance critical zone. Zones are
+discussed further in Section :ref:`Zones <zones>`.
+
+The relation between node and zone extents is determined by the physical memory
+map reported by the firmware, architectural constraints for memory addressing
+and certain parameters in the kernel command line.
+
+For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of RAM the
+entire memory will be on node 0 and there will be three zones: ``ZONE_DMA``,
+``ZONE_NORMAL`` and ``ZONE_HIGHMEM``::
+
+  0                                                            2G
+  +-------------------------------------------------------------+
+  |                            node 0                           |
+  +-------------------------------------------------------------+
+
+  0         16M                    896M                        2G
+  +----------+-----------------------+--------------------------+
+  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
+  +----------+-----------------------+--------------------------+
+
+
+With a kernel built with ``ZONE_DMA`` disabled and ``ZONE_DMA32`` enabled and
+booted with ``movablecore=80%`` parameter on an arm64 machine with 16 Gbytes of
+RAM equally split between two nodes, there will be ``ZONE_DMA32``,
+``ZONE_NORMAL`` and ``ZONE_MOVABLE`` on node 0, and ``ZONE_NORMAL`` and
+``ZONE_MOVABLE`` on node 1::
+
+
+  1G                                9G                         17G
+  +--------------------------------+ +--------------------------+
+  |              node 0            | |          node 1          |
+  +--------------------------------+ +--------------------------+
+
+  1G       4G        4200M          9G          9320M          17G
+  +---------+----------+-----------+ +------------+-------------+
+  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
+  +---------+----------+-----------+ +------------+-------------+
+
+.. _nodes:
+
+Nodes
+=====
+
+As we have mentioned, each node in memory is described by a ``pg_data_t`` which
+is a typedef for a ``struct pglist_data``. When allocating a page, by default
+Linux uses a node-local allocation policy to allocate memory from the node
+closest to the running CPU. As processes tend to run on the same CPU, it is
+likely the memory from the current node will be used. The allocation policy can
+be controlled by users as described in
+Documentation/admin-guide/mm/numa_memory_policy.rst.
+
+Most NUMA architectures maintain an array of pointers to the node
+structures. The actual structures are allocated early during boot when
+architecture specific code parses the physical memory map reported by the
+firmware. The bulk of the node initialization happens slightly later in the
+boot process by free_area_init() function, described later in Section
+:ref:`Initialization <initialization>`.
+
+
+Along with the node structures, kernel maintains an array of ``nodemask_t``
+bitmasks called ``node_states``. Each bitmask in this array represents a set of
+nodes with particular properties as defined by ``enum node_states``:
+
+``N_POSSIBLE``
+  The node could become online at some point.
+``N_ONLINE``
+  The node is online.
+``N_NORMAL_MEMORY``
+  The node has regular memory.
+``N_HIGH_MEMORY``
+  The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
+  aliased to ``N_NORMAL_MEMORY``.
+``N_MEMORY``
+  The node has memory(regular, high, movable)
+``N_CPU``
+  The node has one or more CPUs
+
+For each node that has a property described above, the bit corresponding to the
+node ID in the ``node_states[<property>]`` bitmask is set.
+
+For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
+
+  node_states[N_POSSIBLE]
+  node_states[N_ONLINE]
+  node_states[N_NORMAL_MEMORY]
+  node_states[N_HIGH_MEMORY]
+  node_states[N_MEMORY]
+  node_states[N_CPU]
+
+For various operations possible with nodemasks please refer to
+``include/linux/nodemask.h``.
+
+Among other things, nodemasks are used to provide macros for node traversal,
+namely ``for_each_node()`` and ``for_each_online_node()``.
+
+For instance, to call a function foo() for each online node::
+
+	for_each_online_node(nid) {
+		pg_data_t *pgdat = NODE_DATA(nid);
+
+		foo(pgdat);
+	}
+
+Node structure
+--------------
+
+The nodes structure ``struct pglist_data`` is declared in
+``include/linux/mmzone.h``. Here we briefly describe fields of this
+structure:
+
+General
+~~~~~~~
+
+``node_zones``
+  The zones for this node.  Not all of the zones may be populated, but it is
+  the full list. It is referenced by this node's node_zonelists as well as
+  other node's node_zonelists.
+
+``node_zonelists``
+  The list of all zones in all nodes. This list defines the order of zones
+  that allocations are preferred from. The ``node_zonelists`` is set up by
+  ``build_zonelists()`` in ``mm/page_alloc.c`` during the initialization of
+  core memory management structures.
+
+``nr_zones``
+  Number of populated zones in this node.
+
+``node_mem_map``
+  For UMA systems that use FLATMEM memory model the 0's node
+  ``node_mem_map`` is array of struct pages representing each physical frame.
+
+``node_page_ext``
+  For UMA systems that use FLATMEM memory model the 0's node
+  ``node_page_ext`` is array of extensions of struct pages. Available only
+  in the kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
+
+``node_start_pfn``
+  The page frame number of the starting page frame in this node.
+
+``node_present_pages``
+  Total number of physical pages present in this node.
+
+``node_spanned_pages``
+  Total size of physical page range, including holes.
+
+``node_size_lock``
+  A lock that protects the fields defining the node extents. Only defined when
+  at least one of ``CONFIG_MEMORY_HOTPLUG`` or
+  ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` configuration options are enabled.
+  ``pgdat_resize_lock()`` and ``pgdat_resize_unlock()`` are provided to
+  manipulate ``node_size_lock`` without checking for ``CONFIG_MEMORY_HOTPLUG``
+  or ``CONFIG_DEFERRED_STRUCT_PAGE_INIT``.
+
+``node_id``
+  The Node ID (NID) of the node, starts at 0.
+
+``totalreserve_pages``
+  This is a per-node reserve of pages that are not available to userspace
+  allocations.
+
+``first_deferred_pfn``
+  If memory initialization on large machines is deferred then this is the first
+  PFN that needs to be initialized. Defined only when
+  ``CONFIG_DEFERRED_STRUCT_PAGE_INIT`` is enabled
+
+``deferred_split_queue``
+  Per-node queue of huge pages that their split was deferred. Defined only when ``CONFIG_TRANSPARENT_HUGEPAGE`` is enabled.
+
+``__lruvec``
+  Per-node lruvec holding LRU lists and related parameters. Used only when
+  memory cgroups are disabled. It should not be accessed directly, use
+  ``mem_cgroup_lruvec()`` to look up lruvecs instead.
+
+Reclaim control
+~~~~~~~~~~~~~~~
+
+See also :ref:`Page Reclaim <page_reclaim>`.
+
+``kswapd``
+  Per-node instance of kswapd kernel thread.
+
+``kswapd_wait``, ``pfmemalloc_wait``, ``reclaim_wait``
+  Workqueues used to synchronize memory reclaim tasks
+
+``nr_writeback_throttled``
+  Number of tasks that are throttled waiting on dirty pages to clean.
+
+``nr_reclaim_start``
+  Number of pages written while reclaim is throttled waiting for writeback.
+
+``kswapd_order``
+  Controls the order kswapd tries to reclaim
+
+``kswapd_highest_zoneidx``
+  The highest zone index to be reclaimed by kswapd
+
+``kswapd_failures``
+  Number of runs kswapd was unable to reclaim any pages
+
+``min_unmapped_pages``
+  Minimal number of unmapped file backed pages that cannot be reclaimed.
+  Determined by ``vm.min_unmapped_ratio`` sysctl. Only defined when
+  ``CONFIG_NUMA`` is enabled.
+
+``min_slab_pages``
+  Minimal number of SLAB pages that cannot be reclaimed. Determined by
+  ``vm.min_slab_ratio sysctl``. Only defined when ``CONFIG_NUMA`` is enabled
+
+``flags``
+  Flags controlling reclaim behavior.
+
+Compaction control
+~~~~~~~~~~~~~~~~~~
+
+``kcompactd_max_order``
+  Page order that kcompactd should try to achieve.
+
+``kcompactd_highest_zoneidx``
+  The highest zone index to be compacted by kcompactd.
+
+``kcompactd_wait``
+  Workqueue used to synchronize memory compaction tasks.
+
+``kcompactd``
+  Per-node instance of kcompactd kernel thread.
+
+``proactive_compact_trigger``
+  Determines if proactive compaction is enabled. Controlled by
+  ``vm.compaction_proactiveness`` sysctl.
+
+Statistics
+~~~~~~~~~~
+
+``per_cpu_nodestats``
+  Per-CPU VM statistics for the node
+
+``vm_stat``
+  VM statistics for the node.
+
+.. _zones:
+
+Zones
+=====
+
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fields.
+
+.. _pages:
+
+Pages
+=====
+
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fields.
+
+.. _folios:
+
+Folios
+======
+
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fields.
+
+.. _initialization:
+
+Initialization
+==============
+
+.. admonition:: Stub
+
+   This section is incomplete. Please list and describe the appropriate fields.
-- 
2.35.1

