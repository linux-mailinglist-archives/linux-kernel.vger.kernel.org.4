Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD83706633
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEQLJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjEQLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF5A5591;
        Wed, 17 May 2023 04:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C86C64587;
        Wed, 17 May 2023 11:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A863EC433D2;
        Wed, 17 May 2023 11:08:58 +0000 (UTC)
Date:   Wed, 17 May 2023 12:08:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 RESEND 4/7] swiotlb: Dynamically allocated bounce
 buffers
Message-ID: <ZGS1xz8Hfhfq3n4Z@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
 <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com>
 <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230516061309.GA7219@lst.de>
 <20230516083942.0303b5fb@meshulam.tesarici.cz>
 <ZGPEgsplBSsI9li3@arm.com>
 <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
 <20230517065653.GA25016@lst.de>
 <ZGShP6i1Ed0kTF83@arm.com>
 <20230517115821.4bf63bf5@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517115821.4bf63bf5@meshulam.tesarici.cz>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:58:21AM +0200, Petr Tesařík wrote:
> On Wed, 17 May 2023 10:41:19 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, May 17, 2023 at 08:56:53AM +0200, Christoph Hellwig wrote:
> > > Just thinking out loud:
> > > 
> > >  - what if we always way overallocate the swiotlb buffer
> > >  - and then mark the second half / two thirds / <pull some number out
> > >    of the thin air> slots as used, and make that region available
> > >    through a special CMA mechanism as ZONE_MOVABLE (but not allowing
> > >    other CMA allocations to dip into it).
> > > 
> > > This allows us to have a single slot management for the entire
> > > area, but allow reclaiming from it.  We'd probably also need to make
> > > this CMA variant irq safe.  
> > 
> > I think this could work. It doesn't need to be ZONE_MOVABLE (and we
> > actually need this buffer in ZONE_DMA). But we can introduce a new
> > migrate type, MIGRATE_SWIOTLB, and movable page allocations can use this
> > range. The CMA allocations go to free_list[MIGRATE_CMA], so they won't
> > overlap.
> > 
> > One of the downsides is that migrating movable pages still needs a
> > sleep-able context.
> 
> Pages can be migrated by a separate worker thread when the number of
> free slots reaches a low watermark.

Indeed, you still need such worker thread.

> > Another potential confusion is is_swiotlb_buffer() for pages in this
> > range allocated through the normal page allocator. We may need to check
> > the slots as well rather than just the buffer boundaries.
> 
> Ah, yes, I forgot about this part; thanks for the reminder.
> 
> Indeed, movable pages can be used for the page cache, and drivers do
> DMA to/from buffers in the page cache.
> 
> Let me recap:
> 
> - Allocated chunks must still be tracked with this approach.
> - The pool of available slots cannot be grown from interrupt context.
> 
> So, what exactly is the advantage compared to allocating additional
> swiotlb chunks from CMA?

This would work as well but it depends on how many other drivers
allocate from the CMA range. Maybe it's simpler to this initially (I
haven't got to your other emails yet).

> > > This could still be combined with more aggressive use of per-device
> > > swiotlb area, which is probably a good idea based on some hints.
> > > E.g. device could hint an amount of inflight DMA to the DMA layer,
> > > and if there are addressing limitations and the amout is large enough
> > > that could cause the allocation of a per-device swiotlb area.  
> > 
> > If we go for one large-ish per-device buffer for specific cases, maybe
> > something similar to the rmem_swiotlb_setup() but which can be
> > dynamically allocated at run-time and may live alongside the default
> > swiotlb. The advantage is that it uses a similar slot tracking to the
> > default swiotlb, no need to invent another. This per-device buffer could
> > also be allocated from the MIGRATE_SWIOTLB range if we make it large
> > enough at boot. It would be seen just a local accelerator for devices
> > that use bouncing frequently or from irq context.
> 
> A per-device pool could also be used for small buffers. IIRC somebody
> was interested in that.

That was me ;) but TBH, I don't care how large the bounce buffer is,
only that it can bounce small structures. If there's some critical path,
people can change the kmalloc() allocation for those structures to make
them cacheline-aligned.

-- 
Catalin
