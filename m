Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B0A704C39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjEPLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjEPLWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3D359D;
        Tue, 16 May 2023 04:22:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDD663875;
        Tue, 16 May 2023 11:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5D5C433D2;
        Tue, 16 May 2023 11:22:05 +0000 (UTC)
Date:   Tue, 16 May 2023 12:22:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v2 RESEND 7/7] swiotlb: per-device flag if there are
 dynamically allocated buffers
Message-ID: <ZGNnWmw4eDsh9hBN@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
 <69f9e058bb1ad95905a62a4fc8461b064872af97.1683623618.git.petr.tesarik.ext@huawei.com>
 <ZGEuYxR2PM6wHeDh@arm.com>
 <20230515104847.6dfdf31b@meshulam.tesarici.cz>
 <20230515120054.0115a4eb@meshulam.tesarici.cz>
 <ZGJdtmP13pv06xDH@arm.com>
 <20230516095512.3c99c35e@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516095512.3c99c35e@meshulam.tesarici.cz>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 09:55:12AM +0200, Petr Tesařík wrote:
> On Mon, 15 May 2023 17:28:38 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > There is another scenario to take into account on the list_del() side.
> > Let's assume that there are other elements on the list, so
> > list_empty() == false:
> > 
> > P0:
> > 	list_del(paddr);
> > 	/* the memory gets freed, added to some slab or page free list */
> > 	WRITE_ONCE(slab_free_list, __va(paddr));
> > 
> > P1:
> > 	paddr = __pa(READ_ONCE(slab_free_list));/* re-allocating paddr freed on P0 */
> > 	if (!list_empty()) {			/* assuming other elements on the list */
> > 		/* searching the list */
> > 		list_for_each() {
> > 			if (pos->paddr) == __pa(vaddr))
> > 				/* match */
> > 		}
> > 	}
> > 
> > On P0, you want the list update to be visible before the memory is freed
> > (and potentially reallocated on P1). An smp_wmb() on P0 would do. For
> > P1, we don't care about list_empty() as there can be other elements
> > already. But we do want any list elements reading during the search to
> > be ordered after the slab_free_list reading. The smp_rmb() you'd add for
> > the case above would suffice.
> 
> Yes, but to protect against concurrent insertions/deletions, a spinlock
> is held while searching the list. The spin lock provides the necessary
> memory barriers implicitly.

Well, mostly. The spinlock acquire/release semantics ensure that
accesses within the locked region are not observed outside the
lock/unlock. But it doesn't guarantee anything about accesses outside
such region in relation to the accesses within the region. For example:

P0:
	spin_lock_irqsave(&swiotlb_dyn_lock);
	list_del(paddr);
	spin_unlock_irqrestore(&swiotlb_dyn_lock);

	/* the blah write below can be observed before list_del() above */
	WRITE_ONCE(blah, paddr);

	/* that's somewhat tricker but slab_free_list update can also be
	 * seen before list_del() above on certain architectures */
	spin_lock_irqsave(&slab_lock);
 	WRITE_ONCE(slab_free_list, __va(paddr));
	spin_unlock_irqrestore(&slab_lock);

On most architectures, the writing of the pointer to a slab structure
(assuming some spinlocks) would be ordered against the list_del() from
the swiotlb code. Apart from powerpc where the spin_unlock() is not
necessarily ordered against the subsequent spin_lock(). The architecture
selects ARCH_WEAK_RELEASE_ACQUIRE which in turns makes
smp_mb__after_unlock_lock() an smp_mb() (rather than no-op on all the
other architectures).

On arm64 we have smp_mb__after_spinlock() which ensures that memory
accesses prior to spin_lock() are not observed after accesses within the
locked region. I don't think this matters for your case but I thought
I'd mention it.

-- 
Catalin
