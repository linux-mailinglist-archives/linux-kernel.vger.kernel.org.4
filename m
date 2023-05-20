Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7170A5F0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjETGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 02:21:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6901A1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 23:21:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5472F68CFE; Sat, 20 May 2023 08:21:03 +0200 (CEST)
Date:   Sat, 20 May 2023 08:21:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when
 xen-pcifront is enabling
Message-ID: <20230520062103.GA1225@lst.de>
References: <20230518134253.909623-1-hch@lst.de> <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl> <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl> <20230519124118.GA5869@lst.de> <8617570c-6dc4-74f5-7418-98f04f7e0ece@citrix.com> <20230519125857.GA6994@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519125857.GA6994@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 02:58:57PM +0200, Christoph Hellwig wrote:
> On Fri, May 19, 2023 at 01:49:46PM +0100, Andrew Cooper wrote:
> > > The alternative would be to finally merge swiotlb-xen into swiotlb, in
> > > which case we might be able to do this later.  Let me see what I can
> > > do there.
> > 
> > If that is an option, it would be great to reduce the special-cashing.
> 
> I think it's doable, and I've been wanting it for a while.  I just
> need motivated testers, but it seems like I just found at least two :)

So looking at swiotlb-xen it does these off things where it takes a value
generated originally be xen_phys_to_dma, then only does a dma_to_phys
to go back and call pfn_valid on the result.  Does this make sense, or
is it wrong and just works by accident?  I.e. is the patch below correct?


diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 67aa74d201627d..3396c5766f0dd8 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -90,9 +90,7 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 
 static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
 {
-	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
-	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
-	phys_addr_t paddr = (phys_addr_t)xen_pfn << XEN_PAGE_SHIFT;
+	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
 	/* If the address is outside our domain, it CAN
 	 * have the same virtual address as another address
@@ -234,7 +232,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 done:
 	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr))))
+		if (pfn_valid(PFN_DOWN(phys)))
 			arch_sync_dma_for_device(phys, size, dir);
 		else
 			xen_dma_sync_for_device(dev, dev_addr, size, dir);
@@ -258,7 +256,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 	BUG_ON(dir == DMA_NONE);
 
 	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))))
+		if (pfn_valid(PFN_DOWN(paddr)))
 			arch_sync_dma_for_cpu(paddr, size, dir);
 		else
 			xen_dma_sync_for_cpu(hwdev, dev_addr, size, dir);
@@ -276,7 +274,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
 	if (!dev_is_dma_coherent(dev)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
+		if (pfn_valid(PFN_DOWN(paddr)))
 			arch_sync_dma_for_cpu(paddr, size, dir);
 		else
 			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
@@ -296,7 +294,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
 	if (!dev_is_dma_coherent(dev)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
+		if (pfn_valid(PFN_DOWN(paddr)))
 			arch_sync_dma_for_device(paddr, size, dir);
 		else
 			xen_dma_sync_for_device(dev, dma_addr, size, dir);
