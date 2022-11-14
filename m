Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25255628741
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiKNRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKNRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:38:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DA4091E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:38:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80FD861321
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 17:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3797DC433C1;
        Mon, 14 Nov 2022 17:38:04 +0000 (UTC)
Date:   Mon, 14 Nov 2022 17:38:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <Y3J8+O7Y3f3onH0P@arm.com>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
> On 2022-11-14 14:11, Will Deacon wrote:
> > On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
> > > This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> > > 
> > > As reported by Amit [1], dropping cache invalidation from
> > > arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> > > (most probably on other Qcom platforms too). The reason is, Qcom
> > > qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> > > for validation. The modem has a secure block (XPU) that will trigger a
> > > whole system crash if the shared memory is accessed by the CPU while modem
> > > is poking at it.
> > > 
> > > To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
> > > with no kernel mapping, vmap's it, copies the firmware metadata and
> > > unvmap's it. Finally the address is then shared with modem for metadata
> > > validation [2].
> > > 
> > > Now because of the removal of cache invalidation from
> > > arch_dma_prep_coherent(), there will be cache lines associated with this
> > > memory even after sharing with modem. So when the CPU accesses it, the XPU
> > > violation gets triggered.
> > 
> > This last past is a non-sequitur: the buffer is no longer mapped on the CPU
> > side, so how would the CPU access it?
> 
> Right, for the previous change to have made a difference the offending part
> of this buffer must be present in some cache somewhere *before* the DMA
> buffer allocation completes.
> 
> Clearly that driver is completely broken though. If the DMA allocation came
> from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
> shenanigans wouldn't work, so if it backed by struct pages then the whole
> dance is still pointless because *a cacheable linear mapping exists*, and
> it's just relying on the reduced chance that anything's going to re-fetch
> the linear map address after those pages have been allocated, exactly as I
> called out previously[1].

So I guess a DMA pool that's not mapped in the linear map, together with
memremap() instead of vmap(), would work around the issue. But the
driver needs fixing, not the arch code.

-- 
Catalin
