Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A962821B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbiKNOLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiKNOLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:11:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0102B24BF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:11:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9270A611B8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A8EC433D6;
        Mon, 14 Nov 2022 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668435076;
        bh=R4w9DILmxJRYx6Loru62AND9DGI5a9aHJHQSFYiQLKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyYtRwg41NC23yLj85GG3+t1EJwqSNTBQeSXgrDEJkWe+wwS2McNV9xBUFc6sdwfw
         0UC5OGNPnXRmaQGoOOQJN/DHTsl2FdKY+r1Me2fQXz+wsQjb4VtTq3mftsrHdVj2Ui
         znqIEEWLrUZGVV+YHuCKi7lNffizgN4xsNf2Hi3xnW86ErVi6NLTQc14JV+p6EWKxf
         Y6vOHagJ+lEifEvIvn+BG91jPEvvF+HYCSq2aV0aZIqLMBDE+tIUoaCppGo6ldpvXh
         a9ZP1K98pE1BEUaalvISh7Soa3/bA1Yvbu/Qq5p20Dc4NkhA6ZXPMZbTadLRfvIXDo
         AvLBMmgTGIhNg==
Date:   Mon, 14 Nov 2022 14:11:10 +0000
From:   Will Deacon <will@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     catalin.marinas@arm.com, robin.murphy@arm.com,
        amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221114141109.GG30263@willie-the-truck>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
> This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> 
> As reported by Amit [1], dropping cache invalidation from
> arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> (most probably on other Qcom platforms too). The reason is, Qcom
> qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> for validation. The modem has a secure block (XPU) that will trigger a
> whole system crash if the shared memory is accessed by the CPU while modem
> is poking at it.
> 
> To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
> with no kernel mapping, vmap's it, copies the firmware metadata and
> unvmap's it. Finally the address is then shared with modem for metadata
> validation [2].
> 
> Now because of the removal of cache invalidation from
> arch_dma_prep_coherent(), there will be cache lines associated with this
> memory even after sharing with modem. So when the CPU accesses it, the XPU
> violation gets triggered.

This last past is a non-sequitur: the buffer is no longer mapped on the CPU
side, so how would the CPU access it?

As I just replied to Amit, we need more information about what this
"access" is and how it is being detected.

Will
