Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B36646A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjAJQyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbjAJQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:54:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F312443A06;
        Tue, 10 Jan 2023 08:54:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 944CB1FED3;
        Tue, 10 Jan 2023 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673369651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6H/L0YNx2q/kJ6wUJLwEfx1DFp++2ZZ2irpOZ5TOO3M=;
        b=fv2EQDPimH98qNOFAgegBCM1OV71ROKSupMw4O9X7YV0iqLkHPby1a0g6ngqudzuLxzZiW
        RccSNzTX5HFnSF/xJ6yVzIO5DCnQaqdO6viHzXFQNhcFWRsNjZroE1wkhqM+PL5GzyzDA9
        V13Vej9bb4mpV+JflrJlWZI6NcxePTw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 744C41358A;
        Tue, 10 Jan 2023 16:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Whd8GTOYvWNvMAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 10 Jan 2023 16:54:11 +0000
Date:   Tue, 10 Jan 2023 17:54:10 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <Y72YMk21sSJLfUiz@dhcp22.suse.cz>
References: <20230110152358.2641910-1-rppt@kernel.org>
 <20230110152358.2641910-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110152358.2641910-3-rppt@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-01-23 17:23:58, Mike Rapoport wrote:
[...]
> +* ``ZONE_DMA`` and ``ZONE_DMA32`` represent memory suitable for DMA by
> +  peripheral devices that cannot access all of the addressable memory.

I think it would be better to not keep the historical DMA based menaning
and teach that future developers. You can say something like

ZONE_DMA and ZONE_DMA32 have historically been used for memory suitable
for DMA. For many years there are better more robust interfaces to
get memory with DMA specific requirements (Documentation/core-api/dma-api.rst).

> +  Depending on the architecture, either of these zone types or even they both
> +  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
> +  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may need
> +  both zones as they support peripherals with different DMA addressing
> +  limitations.
> +
> +* ``ZONE_NORMAL`` is for normal memory that can be accessed by the kernel all
> +  the time. DMA operations can be performed on pages in this zone if the DMA
> +  devices support transfers to all addressable memory. ``ZONE_NORMAL`` is
> +  always enabled.
> +
> +* ``ZONE_HIGHMEM`` is the part of the physical memory that is not covered by a
> +  permanent mapping in the kernel page tables. The memory in this zone is only
> +  accessible to the kernel using temporary mappings. This zone is available
> +  only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM``.
> +
> +* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMAL``.
> +  The difference is that most pages in ``ZONE_MOVABLE`` are movable.

This is really confusing because those pages are not really movable. You
cannot move a page itself. I guess you meant to say something like

The difference is that there are means to migrate memory via
migrate_pages interface. A typical example would be a memory mapped to
userspace which can be rellocate the underlying memory content and
update page tables so that userspace doesn't notice the physical data
placement has changed.

> That means
> +  that while virtual addresses of these pages do not change, their content may
> +  move between different physical pages. ``ZONE_MOVABLE`` is only enabled when
> +  one of ``kernelcore``, ``movablecore`` and ``movable_node`` parameters is
> +  present in the kernel command line. See :ref:`Page migration
> +  <page_migration>` for additional details.

This is not really true. The movable zone can be also enabled by memory
hotplug. In fact it is one of the more common usecases for the zone
because memory hot remove largerly depends on memory to be migrated for
offlining to succeed in most cases.

> +
> +* ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and GPU.
> +  It has different characteristics than RAM zone types and it exists to provide
> +  :ref:`struct page <Pages>` and memory map services for device driver
> +  identified physical address ranges. ``ZONE_DEVICE`` is enabled with
> +  configuration option ``CONFIG_ZONE_DEVICE``.
> +
> +It is important to note that many kernel operations can only take place using
> +``ZONE_NORMAL`` so it is the most performance critical zone. Zones are
> +discussed further in Section :ref:`Zones <zones>`.
> +
> +The relation between node and zone extents is determined by the physical memory
> +map reported by the firmware, architectural constraints for memory addressing
> +and certain parameters in the kernel command line.
> +
> +For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of RAM the
> +entire memory will be on node 0 and there will be three zones: ``ZONE_DMA``,
> +``ZONE_NORMAL`` and ``ZONE_HIGHMEM``::
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
> +With a kernel built with ``ZONE_DMA`` disabled and ``ZONE_DMA32`` enabled and
> +booted with ``movablecore=80%`` parameter on an arm64 machine with 16 Gbytes of
> +RAM equally split between two nodes, there will be ``ZONE_DMA32``,
> +``ZONE_NORMAL`` and ``ZONE_MOVABLE`` on node 0, and ``ZONE_NORMAL`` and
> +``ZONE_MOVABLE`` on node 1::
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

I think it is useful to note that nodes and zones can overlap in the
physical address range. It is not uncommong to interleave two nodes and
it is also possible that memory holes are memory hotplugged into MOVABLE
zone arbitrarily in the physical address range.

Other than that looks good to me and thanks for taking care of filling
up these gaps! This is highly appreciated.
-- 
Michal Hocko
SUSE Labs
