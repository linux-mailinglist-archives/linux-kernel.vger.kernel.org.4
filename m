Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634F46627FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjAIOCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjAIOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:01:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D437266;
        Mon,  9 Jan 2023 06:00:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk16so8233718wrb.11;
        Mon, 09 Jan 2023 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6spJSBkMNBIx4KLHawdyLw2aO1QaVfFr4NtHTqtzCbE=;
        b=nkbYfZjyGvvRuFvxDCyjPlGYpkB6tABKLC5RkpfMPARFPnxqaKS1Eut4diploFKW0H
         4/0NMSkAWlKiyYRO7IJm2irGCh6pk+rZRDzwr6sRII7mO/TFDeOmLVzrwvAqdgFWct/u
         bBq9vKpFDVZSWI5HyMoPJQldKMMX21zJp44Oz1dyQE5zqaUVoZIIqrqBMBKrHwGFKYqA
         /KtCGJEvUSxhbqT9jXgwqegtYf28MX6zvdA5pAbKfs4PP8keCdiVSUepCnaSPtnxx2o3
         oceDw9YdMxOn0ytwGHLFIRgetKeoAT3oi/ouQ0Hf5D5DPUAG1t2JayHQe/+Lj0626zLe
         ru3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6spJSBkMNBIx4KLHawdyLw2aO1QaVfFr4NtHTqtzCbE=;
        b=0xVWP+rD1YVdp5c5nQHsHCT5MMaaF9T9KJg8zAfZrqm8B0hEkZ7rFGorTjvl1iYI2L
         HeZunvK91JQFHg0Sb3AehIKR0gT2hws4Mhqx8o5x5BzujGK5NMkwqaUa9Clw+ygv5PvJ
         Ux53raMlJJn1dSPjqP6f6Qst0TtNj1oRk928CBjncxvLMIrNx8M5Jh9g7pzdxPm8+sL6
         ZCtSvbSN1iKZf0qUqg+3jfJULO0EVfxYuFTJsmEXXYHeCG5LZ7vfDj9chuG1rmsrhKt6
         ofVdZMcrf5gVz0ZCS+C5DVexb+wGJXMy5yMoJiVwqSfmd++Z4VDsfw2c3Z2inpiezsa2
         v1Zg==
X-Gm-Message-State: AFqh2kpn+0LeYP4gisTJ6mqtYwJo/wrEqQL+ioNpKiy61qrAxXESPGxe
        2B2ROfLsZktHP8+u+14HN4Y=
X-Google-Smtp-Source: AMrXdXvGu2ASXCfdXWvXzwAEeGjzYTgMzEXlB4bWjfNqar20I5zAnR0hWG1MoWde0sg/fCYFFzh19w==
X-Received: by 2002:adf:fd0b:0:b0:29b:2ce6:9f2e with SMTP id e11-20020adffd0b000000b0029b2ce69f2emr16530171wrr.27.1673272841486;
        Mon, 09 Jan 2023 06:00:41 -0800 (PST)
Received: from localhost (host81-157-153-247.range81-157.btcentralplus.com. [81.157.153.247])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4707000000b00291f1a5ced6sm8526567wrq.53.2023.01.09.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:00:40 -0800 (PST)
Date:   Mon, 9 Jan 2023 14:00:39 +0000
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
Message-ID: <Y7weBwWoz9VBNj73@lucifer>
References: <20230101094523.1522109-1-rppt@kernel.org>
 <20230101094523.1522109-3-rppt@kernel.org>
 <Y7ihjpFaYy2QuORd@lucifer>
 <Y7wXm/3POivfwSHE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7wXm/3POivfwSHE@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 03:33:15PM +0200, Mike Rapoport wrote:
> > Absolutely wonderfully written.
>
> Thanks to Mel :)
>

I should have known :)

> > > +Each node may be divided up into a number of blocks called zones which
> > > +represent ranges within memory. These ranges are usually determined by
> > > +architectural constraints for accessing the physical memory. A zone is
> > > +described by a ``struct zone_struct``, typedeffed to ``zone_t`` and each zone
> > > +has one of the types described below.
> >
> > I don't think it's quite right to say 'may' be divided up into zones, as they
> > absolutely will be so (and the entire phsyical memory allocator hinges on being
> > zoned, even if trivially in UMA/single zone cases).
>
> Not necessarily. ZONE_DMA or ZONE_NORMAL may span the entire memory.

I see what you mean, here again we get the confusion around zones as a term (And
Willy has yet to propose a 'zolio' :), what I meant to say is that every byte of
memory is in a zone, though a zone may span a node, multiple nodes or all nodes.

> > > +
> > > +`ZONE_DMA` and `ZONE_DMA32`
> > > +  represent memory suitable for DMA by peripheral devices that cannot
> > > +  access all of the addressable memory. Depending on the architecture,
> > > +  either of these zone types or even they both can be disabled at build
> > > +  time using ``CONFIG_ZONE_DMA`` and ``CONFIG_ZONE_DMA32`` configuration
> > > +  options. Some 64-bit platforms may need both zones as they support
> > > +  peripherals with different DMA addressing limitations.
> >
> > It might be worth pointing out ZONE_DMA spans an incredibly little range that
> > probably won't matter for any peripherals this side of the cretaceous period,
>
> On RPi4 ZONE_DMA spans 1G, which is quite some part of the memory ;-)
>

Ah yeah that's another weirdness, my asahi laptop actually puts everything into
ZONE_DMA so fair point. Arches do complicate things... (hence why I limit my
scope to only one)

> > > +
> > > +`ZONE_NORMAL`
> > > +  is for normal memory that can be accessed by the kernel all the time. DMA
> > > +  operations can be performed on pages in this zone if the DMA devices support
> > > +  transfers to all addressable memory. ZONE_NORMAL is always enabled.
> > > +
> >
> > Might be worth saying 'this is where memory ends up if not otherwise in another
> > zone'.
>
> This may not be the case on !x86.

Yeah again, I am being a fool because I keep burying in my mind the fact that my
Asahi laptop literally doesn't do this... :) I think in 'principle' though it
still is where things should go unless you just decide to have the first zone
only? But in any case, I think then the original explanation is better.

>
> > > +`ZONE_HIGHMEM`
> > > +  is the part of the physical memory that is not covered by a permanent mapping
> > > +  in the kernel page tables. The memory in this zone is only accessible to the
> > > +  kernel using temporary mappings. This zone is available only some 32-bit
> > > +  architectures and is enabled with ``CONFIG_HIGHMEM``.
> > > +
> >
> > I comment here only to say 'wow I am so glad I chose to only focus on 64-bit so
> > I could side-step all the awkward discussion of high pages' :)
> >
> > > +The relation between node and zone extents is determined by the physical memory
> > > +map reported by the firmware, architectural constraints for memory addressing
> > > +and certain parameters in the kernel command line.
> >
> > Perhaps worth mentioning device tree here? Though perhaps encapsulated in the
> > 'firmware' reference.
>
> It is :)

Ack, and that makes sense

>
> > > +Node structure
> > > +--------------
> > > +
> > > +The struct pglist_data is declared in `include/linux/mmzone.h
> > > +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mmzone.h>`_.
> > > +Here we briefly describe fields of this structure:
> >
> > Perhaps worth saying 'The node structure' just to reiterate.
>
> Not sure I follow, can you phrase the entire sentence?
>

Sorry I wasn't clear here, I meant to say simply reiterate that the pglist_data
struct is the one describing a node.

> > > +
> > > +General
> > > +~~~~~~~
> > > +
> > > +`node_zones`
> > > +  The zones for this node.  Not all of the zones may be populated, but it is
> > > +  the full list. It is referenced by this node's node_zonelists as well as
> > > +  other node's node_zonelists.
> >
> > Perhaps worth describing what zonelists (and equally zonerefs) are here or
> > above, and that this is the canonical place where zones reside. Maybe reference
> > populated_zone() and for_each_populated_zone() in reference to the fact that not
> > all here may be populated?
>
> I'd prefer to start simple and than add more content on top.
>

Absolutely, makes sense!

> > > +
> > > +`node_zonelists` The list of all zones in all nodes. This list defines the
> > > +  order of zones that allocations are preferred from. The `node_zonelists` is
> > > +  set up by build_zonelists() in mm/page_alloc.c during the initialization of
> > > +  core memory management structures.
> > > +
> > > +`nr_zones`
> > > +  Number of populated zones in this node.
> > > +
> > > +`node_mem_map`
> > > +  For UMA systems that use FLATMEM memory model the 0's node (and the only)
> > > +  `node_mem_map` is array of struct pages representing each physical frame.
> > > +
> > > +`node_page_ext`
> > > +  For UMA systems that use FLATMEM memory model the 0's (and the only) node
> > > +  `node_mem_map` is array of extensions of struct pages. Available only in the
> > > +  kernels built with ``CONFIG_PAGE_EXTENTION`` enabled.
> > > +
> > > +`node_start_pfn`
> > > +  The page frame number of the starting page frame in this node.
> > > +
> > > +`node_present_pages`
> > > +  Total number of physical pages present in this node.
> > > +
> > > +`node_spanned_pages`
> > > +  Total size of physical page range, including holes.
> > > +
> >
> > I think it'd be useful to discuss briefly the meaning of managed, spanned and
> > present pages in the context of zones.
>
> This will be a part of the Zones section.

Makes sense again!

Overall it's very good. Nitpicking here really!
