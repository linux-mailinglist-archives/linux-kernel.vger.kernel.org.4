Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52BE62F4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiKRMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiKRMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:34:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD96CD0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A50EDB82304
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF0C433C1;
        Fri, 18 Nov 2022 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668774835;
        bh=Z2fM/T11X1JbB9QleHXKH+hbS5Bk9HGFuktcfgKbH8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3iPjRBNF2ZfqPaqUr6W4k0+iNaLxUOY8QUNc6W9c8v3VCztTphdYJuloJRAzvBJG
         E7AJEScYrW7G0Of/D1PzDVOt4Hq+dsxEbFr4I/LY5z8gwrOk5DxMbxK0pmReey+qMO
         D8dAqS629neXU5HMu98AKDTXnIvB1iQWyIlaNSULIfJ8mPf43G+YTLwAvsLqzqXHed
         ltLDl/TzHS4u6+wPqRDPpayfu9Zw0hdW/96V+KIE0SmnuiB8qtPnTTOD6GCMx3fUYn
         znegCqRe2NvbhDS3QnYQ36vNX5t8d6nCR20XBTwrpBd/9ktBGg+whKLnXDL0jKdRIR
         EpVKwnkmjzAxw==
Date:   Fri, 18 Nov 2022 12:33:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>, amit.pundir@linaro.org,
        andersson@kernel.org, quic_sibis@quicinc.com,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221118123349.GC3697@willie-the-truck>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
 <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118105402.GA184726@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:24:02PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 14, 2022 at 05:38:00PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
> > > On 2022-11-14 14:11, Will Deacon wrote:
> > > > On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
> > > > > This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> > > > > 
> > > > > As reported by Amit [1], dropping cache invalidation from
> > > > > arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> > > > > (most probably on other Qcom platforms too). The reason is, Qcom
> > > > > qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> > > > > for validation. The modem has a secure block (XPU) that will trigger a
> > > > > whole system crash if the shared memory is accessed by the CPU while modem
> > > > > is poking at it.
> > > > > 
> > > > > To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
> > > > > with no kernel mapping, vmap's it, copies the firmware metadata and
> > > > > unvmap's it. Finally the address is then shared with modem for metadata
> > > > > validation [2].
> > > > > 
> > > > > Now because of the removal of cache invalidation from
> > > > > arch_dma_prep_coherent(), there will be cache lines associated with this
> > > > > memory even after sharing with modem. So when the CPU accesses it, the XPU
> > > > > violation gets triggered.
> > > > 
> > > > This last past is a non-sequitur: the buffer is no longer mapped on the CPU
> > > > side, so how would the CPU access it?
> > > 
> > > Right, for the previous change to have made a difference the offending part
> > > of this buffer must be present in some cache somewhere *before* the DMA
> > > buffer allocation completes.
> > > 
> > > Clearly that driver is completely broken though. If the DMA allocation came
> > > from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
> > > shenanigans wouldn't work, so if it backed by struct pages then the whole
> > > dance is still pointless because *a cacheable linear mapping exists*, and
> > > it's just relying on the reduced chance that anything's going to re-fetch
> > > the linear map address after those pages have been allocated, exactly as I
> > > called out previously[1].
> > 
> > So I guess a DMA pool that's not mapped in the linear map, together with
> > memremap() instead of vmap(), would work around the issue. But the
> > driver needs fixing, not the arch code.
> > 
> 
> Okay, thanks for the hint. Can you share how to allocate the dma-pool that's
> not part of the kernel's linear map? I looked into it but couldn't find a way.

The no-map property should take care of this iirc

Will
