Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA66D7064C2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjEQJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:58:43 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1A35580;
        Wed, 17 May 2023 02:58:26 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 6B409163772;
        Wed, 17 May 2023 11:58:22 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1684317502; bh=WhnfW/mNpML+q2vB7o5SxfZBdLz/zpvDWou9zmU6K08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b2G+mGDs3X7jGbTxNRGMvDaOp+pASwt8O3+PV+zwt6N5+/4XQEX/muYWn7+C1lTm4
         1J65WG88OPP8glU6VVwbJHKZ7nqADENiNYEhaHlSDGR62ihbw6lLMZQid3D/QGg9K0
         p5Rq2wM7rNyaqK9w6otk4OU726Am08OS332pk2j73wsFz7JS6Vq7sQolPQ73P0CkJP
         u2Z7IjwhrroeV114wIJ0846G+iOiJHLI/PfLL36nt/U0iPYuWfJCq2OWLReIPXutpD
         ylB+EWOL7TExQ6zoG3f3fOmu02hxHVXFstnL9mGkrWG2wDMUzp+v1LfgUIEELznx5j
         1NIrwlLNxC/pA==
Date:   Wed, 17 May 2023 11:58:21 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20230517115821.4bf63bf5@meshulam.tesarici.cz>
In-Reply-To: <ZGShP6i1Ed0kTF83@arm.com>
References: <cover.1683623618.git.petr.tesarik.ext@huawei.com>
        <346abecdb13b565820c414ecf3267275577dbbf3.1683623618.git.petr.tesarik.ext@huawei.com>
        <BYAPR21MB168874BC467BFCEC133A9DCDD7789@BYAPR21MB1688.namprd21.prod.outlook.com>
        <20230516061309.GA7219@lst.de>
        <20230516083942.0303b5fb@meshulam.tesarici.cz>
        <ZGPEgsplBSsI9li3@arm.com>
        <20230517083510.0cd7fa1a@meshulam.tesarici.cz>
        <20230517065653.GA25016@lst.de>
        <ZGShP6i1Ed0kTF83@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 10:41:19 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, May 17, 2023 at 08:56:53AM +0200, Christoph Hellwig wrote:
> > Just thinking out loud:
> > 
> >  - what if we always way overallocate the swiotlb buffer
> >  - and then mark the second half / two thirds / <pull some number out
> >    of the thin air> slots as used, and make that region available
> >    through a special CMA mechanism as ZONE_MOVABLE (but not allowing
> >    other CMA allocations to dip into it).
> > 
> > This allows us to have a single slot management for the entire
> > area, but allow reclaiming from it.  We'd probably also need to make
> > this CMA variant irq safe.  
> 
> I think this could work. It doesn't need to be ZONE_MOVABLE (and we
> actually need this buffer in ZONE_DMA). But we can introduce a new
> migrate type, MIGRATE_SWIOTLB, and movable page allocations can use this
> range. The CMA allocations go to free_list[MIGRATE_CMA], so they won't
> overlap.
> 
> One of the downsides is that migrating movable pages still needs a
> sleep-able context.

Pages can be migrated by a separate worker thread when the number of
free slots reaches a low watermark.

> Another potential confusion is is_swiotlb_buffer() for pages in this
> range allocated through the normal page allocator. We may need to check
> the slots as well rather than just the buffer boundaries.

Ah, yes, I forgot about this part; thanks for the reminder.

Indeed, movable pages can be used for the page cache, and drivers do
DMA to/from buffers in the page cache.

Let me recap:

- Allocated chunks must still be tracked with this approach.
- The pool of available slots cannot be grown from interrupt context.

So, what exactly is the advantage compared to allocating additional
swiotlb chunks from CMA?

> (we are actually looking at a MIGRATE_METADATA type for the arm64 memory
> tagging extension which uses a 3% carveout of the RAM for storing the
> tags and people want that reused somehow; we have some WIP patches but
> we'll post them later this summer)
> 
> > This could still be combined with more aggressive use of per-device
> > swiotlb area, which is probably a good idea based on some hints.
> > E.g. device could hint an amount of inflight DMA to the DMA layer,
> > and if there are addressing limitations and the amout is large enough
> > that could cause the allocation of a per-device swiotlb area.  
> 
> If we go for one large-ish per-device buffer for specific cases, maybe
> something similar to the rmem_swiotlb_setup() but which can be
> dynamically allocated at run-time and may live alongside the default
> swiotlb. The advantage is that it uses a similar slot tracking to the
> default swiotlb, no need to invent another. This per-device buffer could
> also be allocated from the MIGRATE_SWIOTLB range if we make it large
> enough at boot. It would be seen just a local accelerator for devices
> that use bouncing frequently or from irq context.

A per-device pool could also be used for small buffers. IIRC somebody
was interested in that.

Petr T
