Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2266CBE38
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjC1L4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjC1L40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:56:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B19006
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7B5EB81C21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C3BC4339C;
        Tue, 28 Mar 2023 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680004578;
        bh=U2DW5wR8I1ZnOjNwxXw2mRrvf2AHqGXqR88pB/8UTYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTwWYfZU4J2Ib3dwZ3Njl4iJAtPe6BdRRvfxDIXxOCIDjXfGboRrRwg/4MECJZ9dq
         S4njcNJePJLjHlIaEqKd9aEN+Y4yAKvxfiMZxB1nMurJuT7a8R3wghHhWebHrsO2cV
         35MoaiM2qKybmShAHRDXSOg79kbRJ2ee4Mc0tnYVtL7OErOHu8J7ZRHskbpkaWYBbp
         N//kqpY4lYkPV1qApP1eHmGGesgiJ2vhwHDBfONhRGM4bIlP0AVtMrL33rtsO7gmR1
         mV/IuGla5NpHQGnqICuA0edO+WU9g5RDQG3t8x88VbNc/v4f4fBaC2FVIK80yoMRWg
         vMrClSn5jmncw==
Date:   Tue, 28 Mar 2023 12:56:13 +0100
From:   Will Deacon <will@kernel.org>
To:     "Krcka, Tomas" <krckatom@amazon.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
Message-ID: <20230328115613.GB1159@willie-the-truck>
References: <20230308092048.71390-1-krckatom@amazon.de>
 <20230327121234.GA31342@willie-the-truck>
 <8845FA6A-45F1-4090-B4A2-C0C28F709095@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8845FA6A-45F1-4090-B4A2-C0C28F709095@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 07:13:52AM +0000, Krcka, Tomas wrote:
> 
> > On 27. Mar 2023, at 14:12, Will Deacon <will@kernel.org> wrote:
> > 
> > 
> > On Wed, Mar 08, 2023 at 09:20:47AM +0000, Tomas Krcka wrote:
> >> When an overflow occurs in the event queue, the SMMU toggles overflow
> >> flag OVFLG in the PROD register.
> >> The evtq thread is supposed to acknowledge the overflow flag by toggling
> >> flag OVACKFLG in the CONS register, otherwise the overflow condition is
> >> still active (OVFLG != OVACKFLG).
> >> 
> >> Currently the acknowledge register is toggled after clearing the event
> >> queue but is never propagated to the hardware. It would be done next
> >> time when executing evtq thread.
> >> 
> >> The SMMU still adds elements to the queue when the overflow condition is
> >> active but any subsequent overflow information after clearing the event
> >> queue will be lost.
> >> 
> >> This change keeps the SMMU in sync as it's expected by design.
> >> 
> >> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
> >> Suggested-by: KarimAllah Ahmed <karahmed@amazon.de>
> >> ---
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> index f2425b0f0cd6..acc1ff5ff69b 100644
> >> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> @@ -1579,6 +1579,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >>      /* Sync our overflow flag, as we believe we're up to speed */
> >>      llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
> >>                  Q_IDX(llq, llq->cons);
> >> +     queue_sync_cons_out(q);
> >>      return IRQ_HANDLED;
> >> }
> > 
> > I think I probably did mean to have something like this, but can we
> > only do the actual h/w update if overflow has occurred? Otherwise I think
> > we're pointlessly writing back the same value most of the time.
> > 
> > Will
> 
> Yes, we can, but then same applies for the priq as well, there we also write back
> every time.

Sure, feel free to update both.

Will
