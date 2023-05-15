Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2702F7032E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbjEOQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjEOQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92C095;
        Mon, 15 May 2023 09:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ECE9620A8;
        Mon, 15 May 2023 16:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2382C433D2;
        Mon, 15 May 2023 16:28:41 +0000 (UTC)
Date:   Mon, 15 May 2023 17:28:38 +0100
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
Message-ID: <ZGJdtmP13pv06xDH@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
 <69f9e058bb1ad95905a62a4fc8461b064872af97.1683623618.git.petr.tesarik.ext@huawei.com>
 <ZGEuYxR2PM6wHeDh@arm.com>
 <20230515104847.6dfdf31b@meshulam.tesarici.cz>
 <20230515120054.0115a4eb@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515120054.0115a4eb@meshulam.tesarici.cz>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(some of you replies may have been filtered to various of my mailboxes,
depending on which lists you cc'ed; replying here)

On Mon, May 15, 2023 at 12:00:54PM +0200, Petr Tesařík wrote:
> On Mon, 15 May 2023 10:48:47 +0200
> Petr Tesařík <petr@tesarici.cz> wrote:
> > On Sun, 14 May 2023 19:54:27 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > Now, thinking about the list_head access and the flag ordering, since it
> > > doesn't matter, you might as well not bother with the flag at all and
> > > rely on list_add() and list_empty() ordering vs the hypothetical 'blah'
> > > access. Both of these use READ/WRITE_ONCE() for setting
> > > dma_io_tlb_dyn_slots.next. You only need an smp_wmb() after the
> > > list_add() and an smp_rmb() before a list_empty() check in
>                       ^^^^^^^^^
> Got it, finally. Well, that's exactly something I don't want to do.
> For example, on arm64 (seeing your email address), smp_rmb() translates
> to a "dsb ld" instruction. I would expect that this is more expensive
> than a "ldar", generated by smp_load_acquire().

It translates to a dmb ishld which is on par with ldar (dsb is indeed a
lot more expensive but that's not generated here).

> > > is_swiotlb_buffer(), no dma_iotlb_have_dyn variable.  
> > 
> > Wait, let me check that I understand you right. Do you suggest that I
> > convert dma_io_tlb_dyn_slots to a lockless list and get rid of the
> > spinlock?
> > 
> > I'm sure it can be done for list_add() and list_del(). I'll have
> > to think about list_move().
> 
> Hm, even the documentation of llist_empty() says that it is "not
> guaranteed to be accurate or up to date". If it could be, I'm quite
> sure the authors would have gladly implemented it as such.

It doesn't but neither does your flag. If you want a guarantee, you'd
need locks because a llist_empty() on its own can race with other
llist_add/del_*() that may not yet be visible to a CPU at exactly that
moment. BTW, the llist implementation cannot delete a random element, so
not sure this is suitable for your implementation (it can only delete
the first element or the whole list).

I do think you need to change your invariants and not rely on an
absolute list_empty() or some flag:

P0:
	list_add(paddr);
	WRITE_ONCE(blah, paddr);

P1:
	paddr = READ_ONCE(blah);
	list_empty();

Your invariant (on P1) should be blah == paddr => !list_empty(). If
there is another P2 removing paddr from the list, this wouldn't work
(nor your flag) but the assumption is that a correctly written driver
that still has a reference to paddr doesn't use it after being removed
from the list (i.e. it doesn't do a dma_unmap(paddr) and still continue
to use this paddr for e.g. dma_sync()).

For such invariant, you'd need ordering between list_add() and the
write of paddr (smp_wmb() would do). On P1, you need an smp_rmb() before
list_empty() since the implementation does a READ_ONCE only).

You still need the locks for list modifications and list traversal as I
don't see how you can use the llist implementation with random element
removal.


There is another scenario to take into account on the list_del() side.
Let's assume that there are other elements on the list, so
list_empty() == false:

P0:
	list_del(paddr);
	/* the memory gets freed, added to some slab or page free list */
	WRITE_ONCE(slab_free_list, __va(paddr));

P1:
	paddr = __pa(READ_ONCE(slab_free_list));/* re-allocating paddr freed on P0 */
	if (!list_empty()) {			/* assuming other elements on the list */
		/* searching the list */
		list_for_each() {
			if (pos->paddr) == __pa(vaddr))
				/* match */
		}
	}

On P0, you want the list update to be visible before the memory is freed
(and potentially reallocated on P1). An smp_wmb() on P0 would do. For
P1, we don't care about list_empty() as there can be other elements
already. But we do want any list elements reading during the search to
be ordered after the slab_free_list reading. The smp_rmb() you'd add for
the case above would suffice.

-- 
Catalin
