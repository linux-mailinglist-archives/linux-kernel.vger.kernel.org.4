Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45156DD080
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDKDvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDKDvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:51:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E012118;
        Mon, 10 Apr 2023 20:51:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4D5E68BEB; Tue, 11 Apr 2023 05:51:31 +0200 (CEST)
Date:   Tue, 11 Apr 2023 05:51:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Alexander Graf <graf@amazon.com>
Subject: Re: [RFC v1 3/4] swiotlb: Allow dynamic allocation of bounce
 buffers
Message-ID: <20230411035131.GA15795@lst.de>
References: <cover.1679309810.git.petr.tesarik.ext@huawei.com> <0334a54332ab75312c9de825548b616439dcc9f5.1679309810.git.petr.tesarik.ext@huawei.com> <20230328040724.GB25506@lst.de> <4268fa4e-4f0f-a2f6-a2a5-5b78ca4a073d@huaweicloud.com> <20230407055548.GC6803@lst.de> <20230407124627.74528415@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230407124627.74528415@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 12:46:27PM +0200, Petr Tesařík wrote:
> >  b) find a way to migrate a buffer into other memory, similar to
> >     how page migration works for page cache
> 
> Let me express the idea in my own words to make sure I get it right.
> When a DMA buffer is imported, but before it is ultimately pinned in
> memory, the importing device driver checks whether the buffer meets its
> DMA constraints. If not, it calls a function provided by the exporting
> device driver to migrate the buffer.

Yes.

> This makes sense, but:
> 
>   1) The operation must be implemented in the exporting driver; this
>      will take some time.
> 
>   2) In theory, there may be no overlap between the exporting device
>      and the importing device. OTOH I'm not aware of any real-world
>      example, so we can probably return a suitable error code, and
>      that's it.

Indeed.  And if there is no overlap, which as you said is indeed
very unlikely but in theory possible, we could still keep migrating
forther and back.

One important thing that we should do is to consolidate more of the
dma-buf implementation code.  Right now they just seem to be a wild
mess of copy and pasted boilerplate code unfortunately.

> Anyway, I have already written in another reply that my original use
> case is moot, because a more recent distribution can do the job without
> using dma-buf, so it has been fixed in user space, be it in GNOME,
> pipewire, or Mesa (I don't really have to know).
> 
> At this point I would go with the assumption that large buffers
> allocated by media subsystems will not hit swiotlb. Consequently, I
> don't plan to spend more time on this branch of the story.

Sounds fine to me, and thanks for taking the effort so far.

> > > BTW my testing also suggests that the streaming DMA API is quite
> > > inefficient, because UAS performance _improved_ with swiotlb=force.
> > > Sure, this should probably be addressed in the UAS and/or xHCI driver,
> > > but what I mean is that moving away from swiotlb may even cause
> > > performance regressions, which is counter-intuitive. At least I would
> > > _not_ have expected it.  
> > 
> > That is indeed very odd.  Are you running with a very slow iommu
> > driver there?   Or what is the actual use case there in general?
> 
> This was on a Raspberry Pi 4, which does not have any IOMMU. IOW it
> looks like copying data around can be faster than sending it straight
> to the device. When I have some more time, I must investigate what is
> really happening there, because it does not make any sense to me.

If you're not using an IOMMU that doesn't actually make any sense to
me.  swiotlb calls into exactly the same routines as dma-direct does
for the dma setup on each I/O, just after copying the data.  So if you
do have some spare cycles to investigate what is going on here, I'd
be really curious about the results.
