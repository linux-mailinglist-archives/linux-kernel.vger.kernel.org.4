Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20B637824
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKXLzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiKXLzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:55:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6163CC5B67
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:55:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3EC4620F6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5F2C433C1;
        Thu, 24 Nov 2022 11:55:05 +0000 (UTC)
Date:   Thu, 24 Nov 2022 11:55:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, amit.pundir@linaro.org,
        andersson@kernel.org, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <Y39blgEueyegkz6C@arm.com>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
 <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad>
 <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:42:27PM +0530, Sibi Sankar wrote:
> On 11/21/22 12:12, Manivannan Sadhasivam wrote:
> > On Fri, Nov 18, 2022 at 12:33:49PM +0000, Will Deacon wrote:
> > > On Fri, Nov 18, 2022 at 04:24:02PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Nov 14, 2022 at 05:38:00PM +0000, Catalin Marinas wrote:
> > > > > On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
> > > > > > Clearly that driver is completely broken though. If the DMA allocation came
> > > > > > from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
> > > > > > shenanigans wouldn't work, so if it backed by struct pages then the whole
> > > > > > dance is still pointless because *a cacheable linear mapping exists*, and
> > > > > > it's just relying on the reduced chance that anything's going to re-fetch
> > > > > > the linear map address after those pages have been allocated, exactly as I
> > > > > > called out previously[1].
> > > > > 
> > > > > So I guess a DMA pool that's not mapped in the linear map, together with
> > > > > memremap() instead of vmap(), would work around the issue. But the
> > > > > driver needs fixing, not the arch code.
> > > > 
> > > > Okay, thanks for the hint. Can you share how to allocate the dma-pool that's
> > > > not part of the kernel's linear map? I looked into it but couldn't find a way.
> > > 
> > > The no-map property should take care of this iirc
> > 
> > Yeah, we have been using it in other places of the same driver. But as per
> > Sibi, we used dynamic allocation for metadata validation since there was no
> > memory reserved statically for that.
> 
> Unlike the other portions in the driver that required statically defined
> no-map carveouts, metadata just needed a contiguous memory for
> authentication. Re-using existing carveouts for this metadata region
> may not work due to modem FW limitations and declaring a new carveout for
> metadata will break the device tree bindings. That's the reason for
> using DMA_ATTR_NO_KERNEL_MAPPING for dma_alloc_attr and vmpa/vunmap with
> VM_FLUSH_RESET_PERMS before passing the memory onto modem. Are there other
> suggestions for achieving the same without breaking bindings?

Your DMA_ATTR_NO_KERNEL_MAPPING workaround doesn't work, it only makes
the failure rate smaller. All this attribute does is avoiding creating a
non-cacheable mapping but you still have the kernel linear mapping in
place that may be speculatively accessed by the CPU. You were just lucky
so far not to have hit the issue. So I'd rather see this fixed properly
with a no-map carveout. Maybe you can reuse an existing carveout if the
driver already needs some and avoid changing the DT. More complicated
options include allocating memory and unmapping it from the linear map
with set_memory_valid(), though that's not exported to modules and it
also requires the linear map to be pages only, not block mappings.

Yet another option is to have the swiotlb buffer unmapped from the
kernel linear map and use the bounce buffer for this. That's more
involved (Robin has some patches, though for a different reason and they
may not make it upstream).

-- 
Catalin
