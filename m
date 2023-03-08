Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62C6B0886
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCHNVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCHNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:20:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E9B4B4F4A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:16:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA59A106F;
        Wed,  8 Mar 2023 05:09:14 -0800 (PST)
Received: from [10.57.90.59] (unknown [10.57.90.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110903F67D;
        Wed,  8 Mar 2023 05:08:29 -0800 (PST)
Message-ID: <8291b66d-b9b8-47c9-f5ed-a4e951c92154@arm.com>
Date:   Wed, 8 Mar 2023 13:08:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow
 acknowledgment
To:     Tomas Krcka <krckatom@amazon.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230308092048.71390-1-krckatom@amazon.de>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230308092048.71390-1-krckatom@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-08 09:20, Tomas Krcka wrote:
> When an overflow occurs in the event queue, the SMMU toggles overflow
> flag OVFLG in the PROD register.
> The evtq thread is supposed to acknowledge the overflow flag by toggling
> flag OVACKFLG in the CONS register, otherwise the overflow condition is
> still active (OVFLG != OVACKFLG).
> 
> Currently the acknowledge register is toggled after clearing the event
> queue but is never propagated to the hardware. It would be done next
> time when executing evtq thread.
> 
> The SMMU still adds elements to the queue when the overflow condition is
> active but any subsequent overflow information after clearing the event
> queue will be lost.
> 
> This change keeps the SMMU in sync as it's expected by design.

If I've understood correctly, the upshot of this is that if the queue 
has overflowed once, become empty, then somehow goes from empty to full 
before we manage to consume a single event, we won't print the "events 
lost" message a second time.

Have you seen this happen in practice? TBH if the event queue ever 
overflows even once it's indicative that the system is hosed anyway, so 
it's not clear to me that there's any great loss of value in sometimes 
failing to repeat a warning for a chronic ongoing operational failure.

It could be argued that we have a subtle inconsistency between 
arm_smmu_evtq_thread() and arm_smmu_priq_thread() here, but the fact is 
that the Event queue and PRI queue *do* have different overflow 
behaviours, so it could equally be argued that inconsistency in the code 
helps reflect that. FWIW I can't say I have a strong preference either way.

Thanks,
Robin.

> Signed-off-by: Tomas Krcka <krckatom@amazon.de>
> Suggested-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f2425b0f0cd6..acc1ff5ff69b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1579,6 +1579,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>   	/* Sync our overflow flag, as we believe we're up to speed */
>   	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
>   		    Q_IDX(llq, llq->cons);
> +	queue_sync_cons_out(q);
>   	return IRQ_HANDLED;
>   }
>   
