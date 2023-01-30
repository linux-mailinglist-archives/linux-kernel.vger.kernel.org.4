Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC31680571
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjA3FMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjA3FMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:12:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BED23845
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 21:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MS+Rl30LKC38gIgaEPBq9Y744hbvgXHkTTwFaNB2Z2k=; b=QNdah6QKy+fPpeNSIHVQ4PzJOu
        kZI1oBvm6NEf/LPSMGgVsDmqhZHbeIxOkFZvP7deHvCja4Qn+GbBO3Uhx2bu6jTI9tbTtqEaj74ie
        BunXceY8RNH29YEm32oF7/cYRZtJ3HTk5cAtk1M/RkqTDLNg4AuAIP5sH8akYCqoml/oaimpRw5XF
        V/SIzi6OxH6vdl6g+twfTYUwbOXgRYcf1XoaQ4MuJ3EMav4ReJIW8hZWWjigh1Iab48kNqhAIgoGV
        CRlYRp01GNd+i4B7qtrg75MHTHQZsn+UZZ4Ov4oyl+rHojUmau8sBvAemjxmnfQ3hNzPQalOy207r
        /v2+Gqqg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMMSK-00A3xt-5q; Mon, 30 Jan 2023 05:11:48 +0000
Date:   Mon, 30 Jan 2023 05:11:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC v3 2/4] mm: move PG_slab flag to page_type
Message-ID: <Y9dRlNhh6O99tg4E@casper.infradead.org>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-3-42.hyeyoo@gmail.com>
 <15fda061-72d9-2ee9-0e9f-6f0f732a7382@suse.cz>
 <Y9dI88l2YJZfZ8ny@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9dI88l2YJZfZ8ny@hyeyoo>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 01:34:59PM +0900, Hyeonggon Yoo wrote:
> > Seems like quite some changes to page_type to accomodate SLAB, which is
> > hopefully going away soon(TM). Could we perhaps avoid that?
> 
> If it could be done with less changes, I'll try to avoid that.

Let me outline the idea I had for removing PG_slab:

Observe that PG_reserved and PG_slab are mutually exclusive.  Also,
if PG_reserved is set, no other flags are set.  If PG_slab is set, only
PG_locked is used.  Many of the flags are only for use by anon/page
cache pages (eg referenced, uptodate, dirty, lru, active, workingset,
waiters, error, owner_priv_1, writeback, mappedtodisk, reclaim,
swapbacked, unevictable, mlocked).

Redefine PG_reserved as PG_kernel.  Now we can use the other _15_
flags to indicate pagetype, as long as PG_kernel is set.  So, eg
PageSlab() can now be (page->flags & PG_type) == PG_slab where

#define PG_kernel	0x00001
#define PG_type		(PG_kernel | 0x7fff0)
#define PG_slab		(PG_kernel | 0x00010)
#define PG_reserved	(PG_kernel | 0x00020)
#define PG_buddy	(PG_kernel | 0x00030)
#define PG_offline	(PG_kernel | 0x00040)
#define PG_table	(PG_kernel | 0x00050)
#define PG_guard	(PG_kernel | 0x00060)

That frees up the existing PG_slab, lets us drop the page_type field
altogether and gives us space to define all the page types we might
want (eg PG_vmalloc)

We'll want to reorganise all the flags which are for anon/file pages
into a contiguous block.  And now that I think about it, vmalloc pages
can be mapped to userspace, so they can get marked dirty, so only
14 bits are available.  Maybe rearrange to ...

PG_locked	0x000001
PG_writeback	0x000002
PG_head		0x000004
PG_dirty	0x000008
PG_owner_priv_1	0x000010
PG_arch_1	0x000020
PG_private	0x000040
PG_waiters	0x000080
PG_kernel	0x000100
PG_referenced	0x000200
PG_uptodate	0x000400
PG_lru		0x000800
PG_active	0x001000
PG_workingset	0x002000
PG_error	0x004000
PG_private_2	0x008000
PG_mappedtodisk	0x010000
PG_reclaim	0x020000
PG_swapbacked	0x040000
PG_unevictable	0x080000
PG_mlocked	0x100000

... or something.  There are a number of constraints and it may take
a few iterations to get this right.  Oh, and if this is the layout
we use, then:

PG_type		0x1fff00
PG_reserved	(PG_kernel | 0x200)
PG_slab		(PG_kernel | 0x400)
PG_buddy	(PG_kernel | 0x600)
PG_offline	(PG_kernel | 0x800)
PG_table	(PG_kernel | 0xa00)
PG_guard	(PG_kernel | 0xc00)
PG_vmalloc	(PG_kernel | 0xe00)

This is going to make show_page_flags() more complex :-P

Oh, and while we're doing this, we should just make PG_mlocked
unconditional.  NOMMU doesn't need the extra space in page flags
(for what?  their large number of NUMA nodes?)
