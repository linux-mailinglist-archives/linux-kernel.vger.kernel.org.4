Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49E164E75C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiLPGrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLPGqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:46:51 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94D755ABF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:46:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A8D8E68AA6; Fri, 16 Dec 2022 07:46:45 +0100 (CET)
Date:   Fri, 16 Dec 2022 07:46:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        hch@lst.de, m.szyprowski@samsung.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices
 disappeared (due BUG at mm/page_alloc.c:3592!)
Message-ID: <20221216064645.GA24446@lst.de>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, it seems like the sound noncontig alloc code that I already
commented on as potentially bogus GFP_GOMP mapping trips this.  I think
for now the right thing would be to revert the hunk in dma-iommu.c
(see patch below).  The other thing to try would be to remove both
uses GFP_COMP in sound/core/memalloc.c, which should have the same
effect.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9297b741f5e80e..f798c44e090337 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -744,9 +744,6 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	/* IOMMU can map any pages, so himem can also be used here */
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
-	/* It makes no sense to muck about with huge pages */
-	gfp &= ~__GFP_COMP;
-
 	while (count) {
 		struct page *page = NULL;
 		unsigned int order_size;
