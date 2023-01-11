Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB961665B55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjAKMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjAKMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:25:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE610FC1;
        Wed, 11 Jan 2023 04:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C51C2CE1B16;
        Wed, 11 Jan 2023 12:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B80C433EF;
        Wed, 11 Jan 2023 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673439898;
        bh=bVAjXqboLDicl+ZTd7HBoOMhof0CuCWy3ut4Gr+zlkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2QpjVxB+4TgL5NZ334u9FSlDMkWEMlOybl75y/9KVv/WZILycdN3ztnzLoGRlgO3
         UfZBqM1OYh5kGREnx1DdbaYWZprGmaleY7HQcPlteEgJH3j4Z5obD/yg+QbEc1d6Fn
         SMlYSBeWVjqZ7g+pxya/gllHcjPGg+tfNn9zMKIAVkbEQ/aRLmEi+UUkE1PkWzNZrW
         9x+lTKT96QsxORXX551trD77gXFZ3GOrMk2aT4i5ZOANpUPr1RmWVoejkKh0vRgc5N
         xvn1F07M99RurtIUh3qPQoiXdBJqcDH3/3sfGXQenHZMvIGYyZBMBtJ/KwLodfARDH
         Gb926IGNsRHCg==
Date:   Wed, 11 Jan 2023 14:24:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y76qi7OB0gcigqZA@kernel.org>
References: <20230110152358.2641910-1-rppt@kernel.org>
 <20230110152358.2641910-3-rppt@kernel.org>
 <Y72YMk21sSJLfUiz@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y72YMk21sSJLfUiz@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 05:54:10PM +0100, Michal Hocko wrote:
> On Tue 10-01-23 17:23:58, Mike Rapoport wrote:
> [...]
> > +* ``ZONE_DMA`` and ``ZONE_DMA32`` represent memory suitable for DMA by
> > +  peripheral devices that cannot access all of the addressable memory.
> 
> I think it would be better to not keep the historical DMA based menaning
> and teach that future developers. You can say something like
> 
> ZONE_DMA and ZONE_DMA32 have historically been used for memory suitable
> for DMA. For many years there are better more robust interfaces to
> get memory with DMA specific requirements (Documentation/core-api/dma-api.rst).

But even today ZONE_DMA(32) means that the memory is suitable for DMA. This
is nicely encapsulated with dma APIs and there should be no new GFP_DMA
users, but still memory outside ZONE_DMA is not suitable for DMA.
 
> > +  Depending on the architecture, either of these zone types or even they both
> > +  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
> > +  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may need
> > +  both zones as they support peripherals with different DMA addressing
> > +  limitations.
> > +
> > +* ``ZONE_NORMAL`` is for normal memory that can be accessed by the kernel all
> > +  the time. DMA operations can be performed on pages in this zone if the DMA
> > +  devices support transfers to all addressable memory. ``ZONE_NORMAL`` is
> > +  always enabled.
> > +
> > +* ``ZONE_HIGHMEM`` is the part of the physical memory that is not covered by a
> > +  permanent mapping in the kernel page tables. The memory in this zone is only
> > +  accessible to the kernel using temporary mappings. This zone is available
> > +  only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM``.
> > +
> > +* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMAL``.
> > +  The difference is that most pages in ``ZONE_MOVABLE`` are movable.
> 
> This is really confusing because those pages are not really movable. You
> cannot move a page itself. I guess you meant to say something like
> 
> The difference is that there are means to migrate memory via
> migrate_pages interface. A typical example would be a memory mapped to
> userspace which can be rellocate the underlying memory content and
> update page tables so that userspace doesn't notice the physical data
> placement has changed.
 
I agree that this sentence is a bit confusing, but there's a clarification
below. Also, I'd like to keep this at high level without going to the
details about how exactly the pages can be migrated.

> > That means
> > +  that while virtual addresses of these pages do not change, their content may
> > +  move between different physical pages. ``ZONE_MOVABLE`` is only enabled when
> > +  one of ``kernelcore``, ``movablecore`` and ``movable_node`` parameters is
> > +  present in the kernel command line. See :ref:`Page migration
> > +  <page_migration>` for additional details.
> 
> This is not really true. The movable zone can be also enabled by memory
> hotplug. In fact it is one of the more common usecases for the zone
> because memory hot remove largerly depends on memory to be migrated for
> offlining to succeed in most cases.

Right. How about this version of ZONE_MOVABLE description:

* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMAL``.
  The difference is that the contents of most pages in ``ZONE_MOVABLE`` is
  movable. That means that while virtual addresses of these pages do not
  change, their content may move between different physical pages. Often
  ``ZONE_MOVABLE`` is populated during memory hotplug, but it may be
  also populated on boot using one of ``kernelcore``, ``movablecore`` and
  ``movable_node`` kernel command line parameters. See :ref:`Page migration
  <page_migration>` and :ref:`Memory Hot(Un)Plug <_admin_guide_memory_hotplug>`
  for additional details.
 
> > +* ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and GPU.
> > +  It has different characteristics than RAM zone types and it exists to provide
> > +  :ref:`struct page <Pages>` and memory map services for device driver
> > +  identified physical address ranges. ``ZONE_DEVICE`` is enabled with
> > +  configuration option ``CONFIG_ZONE_DEVICE``.
> > +
> > +It is important to note that many kernel operations can only take place using
> > +``ZONE_NORMAL`` so it is the most performance critical zone. Zones are
> > +discussed further in Section :ref:`Zones <zones>`.
> > +
> > +The relation between node and zone extents is determined by the physical memory
> > +map reported by the firmware, architectural constraints for memory addressing
> > +and certain parameters in the kernel command line.
> > +
> > +For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of RAM the
> > +entire memory will be on node 0 and there will be three zones: ``ZONE_DMA``,
> > +``ZONE_NORMAL`` and ``ZONE_HIGHMEM``::
> > +
> > +  0                                                            2G
> > +  +-------------------------------------------------------------+
> > +  |                            node 0                           |
> > +  +-------------------------------------------------------------+
> > +
> > +  0         16M                    896M                        2G
> > +  +----------+-----------------------+--------------------------+
> > +  | ZONE_DMA |      ZONE_NORMAL      |       ZONE_HIGHMEM       |
> > +  +----------+-----------------------+--------------------------+
> > +
> > +
> > +With a kernel built with ``ZONE_DMA`` disabled and ``ZONE_DMA32`` enabled and
> > +booted with ``movablecore=80%`` parameter on an arm64 machine with 16 Gbytes of
> > +RAM equally split between two nodes, there will be ``ZONE_DMA32``,
> > +``ZONE_NORMAL`` and ``ZONE_MOVABLE`` on node 0, and ``ZONE_NORMAL`` and
> > +``ZONE_MOVABLE`` on node 1::
> > +
> > +
> > +  1G                                9G                         17G
> > +  +--------------------------------+ +--------------------------+
> > +  |              node 0            | |          node 1          |
> > +  +--------------------------------+ +--------------------------+
> > +
> > +  1G       4G        4200M          9G          9320M          17G
> > +  +---------+----------+-----------+ +------------+-------------+
> > +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> > +  +---------+----------+-----------+ +------------+-------------+
> 
> I think it is useful to note that nodes and zones can overlap in the
> physical address range. It is not uncommong to interleave two nodes and
> it is also possible that memory holes are memory hotplugged into MOVABLE
> zone arbitrarily in the physical address range.

Hmm, not sure I understand what you mean by "overlap".
For interleaved nodes you mean that node 0 may span, say [0x0, 0x2000) and
[0x4000, 06000) and node 1 spans [0x2000, 0x4000) and [0x6000, 0x8000)?

And as for MOVABLE zone, you mean that it can appear between ranges of
NORMAL zone?
 
> Other than that looks good to me and thanks for taking care of filling
> up these gaps! This is highly appreciated.

Thanks!

I'd appreciate more inputs ;-)

> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
