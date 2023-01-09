Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE2662807
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbjAIOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjAIOD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:03:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0954EB0E;
        Mon,  9 Jan 2023 06:03:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEE860F9A;
        Mon,  9 Jan 2023 14:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8581C433EF;
        Mon,  9 Jan 2023 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673273038;
        bh=XDPThGpaR2A08Y5i5XDOoJYueRBv/oUcKLeKgGTtfng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPFE8jpoWjguzwsWpnR+NPXoZ8b51wBtY/XhNgkEI8KWdo63mdqVBK4l1+brr9CLk
         8v6FqHQIFDrG345qKqDWG0iaDz88bD52HeFnAUO5zzD6H2sON4IJo/yrmWR79Qgxr2
         /PP8Z3tZT6E2wez5MhjDUSamEoohDqK2CEseSW4ON2WKgLRRI0mXZDQmuU6NyM68/x
         mRc/mpICsfRNEqAfc7rp1OakuNMsv8GsI+AyFURQFlXOd75aThAEY4PcDU5Brw6CZo
         q3GXDSvpf+QfP++Rbl9iaNfLHzbaPjC1c0zXFDLl79efiKEiT7+lV8wajy24gI87l9
         4hwjAA8mGKh6Q==
Date:   Mon, 9 Jan 2023 16:03:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y7wev+uJTAeWj4j4@kernel.org>
References: <20230101094523.1522109-1-rppt@kernel.org>
 <20230101094523.1522109-3-rppt@kernel.org>
 <Y7jtLoPrj71tOWwY@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7jtLoPrj71tOWwY@debian.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 10:55:26AM +0700, Bagas Sanjaya wrote:
> On Sun, Jan 01, 2023 at 11:45:23AM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> 
> No patch description really?

The subject says it all, but I can copy it to the description as well.
 
> > +Each node may be divided up into a number of blocks called zones which
> > +represent ranges within memory. These ranges are usually determined by
> > +architectural constraints for accessing the physical memory. A zone is
> > +described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each zone
> > +has one of the types described below.
> > +
> > +`ZONE_DMA` and `ZONE_DMA32`
> > +  represent memory suitable for DMA by peripheral devices that cannot
> > +  access all of the addressable memory. Depending on the architecture,
> > +  either of these zone types or even they both can be disabled at build
> > +  time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32`` configuration
> > +  options. Some 64-bit platforms may need both zones as they support
> > +  peripherals with different DMA addressing limitations.
> > +
> > +`ZONE_NORMAL`
> > +  is for normal memory that can be accessed by the kernel all the time. DMA
> > +  operations can be performed on pages in this zone if the DMA devices support
> > +  transfers to all addressable memory. ZONE_NORMAL is always enabled.
> > +
> > +`ZONE_HIGHMEM`
> > +  is the part of the physical memory that is not covered by a permanent mapping
> > +  in the kernel page tables. The memory in this zone is only accessible to the
> > +  kernel using temporary mappings. This zone is available only some 32-bit
> > +  architectures and is enabled with ``CONFIG_HIGHMEM``.
> > +
> > +`ZONE_MOVABLE`
> > +  is for normal accessible memory, just like ZONE_NORMAL. The difference is
> > +  that most pages in ZONE_MOVABLE are movable. That means that while virtual
> > +  addresses of these pages do not change, their content may move between
> > +  different physical pages. ZONE_MOVABLE is only enabled when one of
> > +  `kernelcore`, `movablecore` and `movable_node` parameters is present in the
> > +  kernel command line. See :ref:`Page migration <page_migration>` for
> > +  additional details.
> > +
> > +`ZONE_DEVICE`
> > +  represents memory residing on devices such as PMEM and GPU. It has different
> > +  characteristics than RAM zone types and it exists to provide :ref:`struct
> > +  page <Pages>` and memory map services for device driver identified physical
> > +  address ranges. ZONE_DEVICE is enabled with configuration option
> > +  ``CONFIG_ZONE_DEVICE``.
> 
> I think bullet lists should do the job better, since the zone names are
> connected directly to their representations:

Agree.
 
> > +For example, with 32-bit kernel on an x86 UMA machine with 2 Gbytes of RAM the
> > +entire memory will be on node 0 and there will be three zones: ZONE_DMA,
> > +ZONE_NORMAL and ZONE_HIGHMEM::
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
> > +With a kernel built with ZONE_DMA disabled and ZONE_DMA32 enabled and booted
> > +with `movablecore=80%` parameter on an arm64 machine with 16 Gbytes of RAM
> > +equally split between two nodes, there will be ZONE_DMA32, ZONE_NORMAL and
> > +ZONE_MOVABLE on node 0, and ZONE_NORMAL and ZONE_MOVABLE on node 1::
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
> I see inconsistency of formatting keywords: some are in inline code and some
> are not. I'm leaning towards inlining them all:

Sure, thanks for the patch :)
 
> > +For various operations possible with nodemasks please refer to
> > +`include/linux/nodemask.h
> > +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/nodemask.h>`_.
> 
> Instead of linking to Linus's tree, just inline the source path:

Ok.
 
> > +.. _zones:
> > +
> > +Zones
> > +=====
> > +
> > +.. _pages:
> > +
> > +Pages
> > +=====
> > +
> > +.. _folios:
> > +
> > +Folios
> > +======
> > +
> > +.. _initialization:
> > +
> > +Initialization
> > +==============
> 
> Are these sections stubs (no fields list for each types)? If so, add
> admonitions to inform readers:

Ok.
 
-- 
Sincerely yours,
Mike.
