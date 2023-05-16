Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF270558F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjEPR7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEPR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03719B;
        Tue, 16 May 2023 10:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F31563CA4;
        Tue, 16 May 2023 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99991C433D2;
        Tue, 16 May 2023 17:59:33 +0000 (UTC)
Date:   Tue, 16 May 2023 18:59:30 +0100
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
Message-ID: <ZGPEgsplBSsI9li3@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
 <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com>
 <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230516061309.GA7219@lst.de>
 <20230516083942.0303b5fb@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516083942.0303b5fb@meshulam.tesarici.cz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 08:39:42AM +0200, Petr Tesařík wrote:
> On Tue, 16 May 2023 08:13:09 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, May 15, 2023 at 07:43:52PM +0000, Michael Kelley (LINUX) wrote:
> > > FWIW, I don't think the approach you have implemented here will be
> > > practical to use for CoCo VMs (SEV, TDX, whatever else).  The problem
> > > is that dma_direct_alloc_pages() and dma_direct_free_pages() must
> > > call dma_set_decrypted() and dma_set_encrypted(), respectively.  In CoCo
> > > VMs, these calls are expensive because they require a hypercall to the host,
> > > and the operation on the host isn't trivial either.  I haven't measured the
> > > overhead, but doing a hypercall on every DMA map operation and on
> > > every unmap operation has long been something we thought we must
> > > avoid.  The fixed swiotlb bounce buffer space solves this problem by
> > > doing set_decrypted() in batch at boot time, and never
> > > doing set_encrypted().  
> > 
> > I also suspect it doesn't really scale too well due to the number of
> > allocations.  I suspect a better way to implement things would be to
> > add more large chunks that are used just like the main swiotlb buffers.
> > 
> > That is when we run out of space try to allocate another chunk of the
> > same size in the background, similar to what we do with the pool in
> > dma-pool.c.  This means we'll do a fairly large allocation, so we'll
> > need compaction or even CMA to back it up, but the other big upside
> > is that it also reduces the number of buffers that need to be checked
> > in is_swiotlb_buffer or the free / sync side.
> 
> I have considered this approach. The two main issues I ran into were:
> 
> 1. MAX_ORDER allocations were too small (at least with 4K pages), and
>    even then they would often fail.
> 
> 2. Allocating from CMA did work but only from process context.
>    I made a stab at modifying the CMA allocator to work from interrupt
>    context, but there are non-trivial interactions with the buddy
>    allocator. Making them safe from interrupt context looked like a
>    major task.

Can you kick off a worker thread when the swiotlb allocation gets past
some reserve limit? It still has a risk of failing to bounce until the
swiotlb buffer is extended.

> I also had some fears about the length of the dynamic buffer list. I
> observed maximum length for block devices, and then it roughly followed
> the queue depth. Walking a few hundred buffers was still fast enough.
> I admit the list length may become an issue with high-end NVMe and
> I/O-intensive applications.

You could replace the list with an rbtree, O(log n) look-up vs O(n),
could be faster if you have many bounces active.

-- 
Catalin
