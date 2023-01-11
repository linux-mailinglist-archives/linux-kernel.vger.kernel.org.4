Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7D8665FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAKQCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjAKQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:02:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C4DFAD;
        Wed, 11 Jan 2023 08:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 546CFB81C66;
        Wed, 11 Jan 2023 16:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE72C433D2;
        Wed, 11 Jan 2023 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673452938;
        bh=K7/h0A8oZBYbzjOJUINJhcgSBwc1sDE2mWca3xe+FO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6+wHZFKC5h0Z66cYAnsAEh9vRyp6guqbqeZXEdtuBMQpYSzdXE5cA5PQBBw27rf/
         9RbbdQTuSXD7l5g3uu5DhVTRUKZiU9A8+VqsHSUW7rzoDNjAZsFBunt5JL4W1UK9dN
         jdavi7yDMk3g/wOc3ROZhEULqz6/gvkFjouGFQwNEBOv2bCuud/LeHdx7JXzeA6QKu
         B6tz1cvB9gWNTZbBBDnUXCaGPiG1uWlvoooIxPruYh00A8kzwCtN0JwBUmD3EMwoa+
         HFM7/oeznxZBd8PBx3+Wx45AdWpNHTOVPsOTdH2g5SURgFfe9e7xEJdwCYQCSpydkE
         j/uvy1BsoUE4A==
Date:   Wed, 11 Jan 2023 18:02:03 +0200
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
Message-ID: <Y77de+xRh+8NXXKn@kernel.org>
References: <20230110152358.2641910-1-rppt@kernel.org>
 <20230110152358.2641910-3-rppt@kernel.org>
 <Y72YMk21sSJLfUiz@dhcp22.suse.cz>
 <Y76qi7OB0gcigqZA@kernel.org>
 <Y767UIx0TQtylJPG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y767UIx0TQtylJPG@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 02:36:16PM +0100, Michal Hocko wrote:
> On Wed 11-01-23 14:24:43, Mike Rapoport wrote:
> > On Tue, Jan 10, 2023 at 05:54:10PM +0100, Michal Hocko wrote:
> > > On Tue 10-01-23 17:23:58, Mike Rapoport wrote:
> > > [...]
> > > > +* ``ZONE_DMA`` and ``ZONE_DMA32`` represent memory suitable for DMA by
> > > > +  peripheral devices that cannot access all of the addressable memory.
> > > 
> > > I think it would be better to not keep the historical DMA based menaning
> > > and teach that future developers. You can say something like
> > > 
> > > ZONE_DMA and ZONE_DMA32 have historically been used for memory suitable
> > > for DMA. For many years there are better more robust interfaces to
> > > get memory with DMA specific requirements (Documentation/core-api/dma-api.rst).
> > 
> > But even today ZONE_DMA(32) means that the memory is suitable for DMA. This
> > is nicely encapsulated with dma APIs and there should be no new GFP_DMA
> > users, but still memory outside ZONE_DMA is not suitable for DMA.
> 
> Well, the thing is that ZONE_DMA means different thing for different
> architectures. For x86 it is effectivelly about ISA attached HW - which
> means almost nothing these days. There is plethora of other HW with
> different address range constrains for DMA transfer so binding the zone
> with DMA is more likely to cause confusion than it helps.

Ok, how about

* ``ZONE_DMA`` and ``ZONE_DMA32`` historically represented memory suitable for
  DMA by peripheral devices that cannot access all of the addressable
  memory. For many years there are better more and robust interfaces to get
  memory with DMA specific requirements (:ref:`DMA API <_dma_api>`), but
  ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that have
  restrictions on how they can be accessed.
  Depending on the architecture, either of these zone types or even they both
  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may need
  both zones as they support peripherals with different DMA addressing
  limitations.
 
> > > > +  Depending on the architecture, either of these zone types or even they both
> > > > +  can be disabled at build time using ``CONFIG_ZONE_DMA`` and
> > > > +  ``CONFIG_ZONE_DMA32`` configuration options. Some 64-bit platforms may need
> > > > +  both zones as they support peripherals with different DMA addressing
> > > > +  limitations.
> > > > +
> > > > +* ``ZONE_NORMAL`` is for normal memory that can be accessed by the kernel all
> > > > +  the time. DMA operations can be performed on pages in this zone if the DMA
> > > > +  devices support transfers to all addressable memory. ``ZONE_NORMAL`` is
> > > > +  always enabled.
> > > > +
> > > > +* ``ZONE_HIGHMEM`` is the part of the physical memory that is not covered by a
> > > > +  permanent mapping in the kernel page tables. The memory in this zone is only
> > > > +  accessible to the kernel using temporary mappings. This zone is available
> > > > +  only on some 32-bit architectures and is enabled with ``CONFIG_HIGHMEM``.
> > > > +
> > > > +* ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMAL``.
> > > > +  The difference is that most pages in ``ZONE_MOVABLE`` are movable.
> > > 
> > > This is really confusing because those pages are not really movable. You
> > > cannot move a page itself. I guess you meant to say something like
> > > 
> > > The difference is that there are means to migrate memory via
> > > migrate_pages interface. A typical example would be a memory mapped to
> > > userspace which can be rellocate the underlying memory content and
> > > update page tables so that userspace doesn't notice the physical data
> > > placement has changed.
> >  
> > I agree that this sentence is a bit confusing, but there's a clarification
> > below. Also, I'd like to keep this at high level without going to the
> > details about how exactly the pages can be migrated.
> 
> Yes, ZONE_MOVABLE is confusing as well. I do not think you do not have
> to elaborate more than just state that the memory should be migrateable.
> 
> > > > That means
> > > > +  that while virtual addresses of these pages do not change, their content may
> > > > +  move between different physical pages. ``ZONE_MOVABLE`` is only enabled when
> > > > +  one of ``kernelcore``, ``movablecore`` and ``movable_node`` parameters is
> > > > +  present in the kernel command line. See :ref:`Page migration
> > > > +  <page_migration>` for additional details.
> > > 
> > > This is not really true. The movable zone can be also enabled by memory
> > > hotplug. In fact it is one of the more common usecases for the zone
> > > because memory hot remove largerly depends on memory to be migrated for
> > > offlining to succeed in most cases.
> > 
> > Right. How about this version of ZONE_MOVABLE description:
> > 
> > * ``ZONE_MOVABLE`` is for normal accessible memory, just like ``ZONE_NORMAL``.
> >   The difference is that the contents of most pages in ``ZONE_MOVABLE`` is
> >   movable. That means that while virtual addresses of these pages do not
> >   change, their content may move between different physical pages. Often
> >   ``ZONE_MOVABLE`` is populated during memory hotplug, but it may be
> >   also populated on boot using one of ``kernelcore``, ``movablecore`` and
> >   ``movable_node`` kernel command line parameters. See :ref:`Page migration
> >   <page_migration>` and :ref:`Memory Hot(Un)Plug <_admin_guide_memory_hotplug>`
> >   for additional details.
> 
> Yes, sounds much better!
> 
> [...]
> > > > +  1G                                9G                         17G
> > > > +  +--------------------------------+ +--------------------------+
> > > > +  |              node 0            | |          node 1          |
> > > > +  +--------------------------------+ +--------------------------+
> > > > +
> > > > +  1G       4G        4200M          9G          9320M          17G
> > > > +  +---------+----------+-----------+ +------------+-------------+
> > > > +  |  DMA32  |  NORMAL  |  MOVABLE  | |   NORMAL   |   MOVABLE   |
> > > > +  +---------+----------+-----------+ +------------+-------------+
> > > 
> > > I think it is useful to note that nodes and zones can overlap in the
> > > physical address range. It is not uncommong to interleave two nodes and
> > > it is also possible that memory holes are memory hotplugged into MOVABLE
> > > zone arbitrarily in the physical address range.
> > 
> > Hmm, not sure I understand what you mean by "overlap".
> > For interleaved nodes you mean that node 0 may span, say [0x0, 0x2000) and
> > [0x4000, 06000) and node 1 spans [0x2000, 0x4000) and [0x6000, 0x8000)?
> 
> Yes. that would be represented by 
> NODE_DATA(0)->start_pfn = 0
> NODE_DATA(0)->node_spanned_pages= 0x6000
> NODE_DATA(1)->start_pfn = 0x4000
> NODE_DATA(1)->node_spanned_pages= 0x6000
> 
> 
> > And as for MOVABLE zone, you mean that it can appear between ranges of
> > NORMAL zone?
> 
> Yes and also other zones as well but that is less likely as those tend
> to be populated from the early boot. But theoretically it can be placed
> in any physical range with page block granularity.

Hmm, these are not easy to explain, but I'll try to come up with something. 
I'd prefer to have this as a followup patch, though.
   
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
