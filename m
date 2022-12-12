Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60C64A2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiLLN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiLLN6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:58:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 680C8C5A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:58:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F58E1FB;
        Mon, 12 Dec 2022 05:58:43 -0800 (PST)
Received: from [10.57.88.235] (unknown [10.57.88.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A96BD3F71E;
        Mon, 12 Dec 2022 05:58:01 -0800 (PST)
Message-ID: <13f18a56-ac47-6a80-2d67-5add6ad49c37@arm.com>
Date:   Mon, 12 Dec 2022 13:57:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix incorrect description of DMB
 instruction
To:     Harry Song <jundongsong1@gmail.com>, will@kernel.org,
        joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221209135304.3306-1-jundongsong1@gmail.com>
Content-Language: en-GB
In-Reply-To: <20221209135304.3306-1-jundongsong1@gmail.com>
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

On 2022-12-09 13:53, Harry Song wrote:
> The current comment is a description of the DSB instruction:
> previous commit [1].
> 
> In the ARM architecture manual, DSB and DMB instructions
> are described as follows:
> 
> DMB: The DMB instruction does not ensure the completion of
> any of the memory accesses for which it ensures relative order.i
> 
> DSB: A DSB instruction is a memory barrier that ensures that
> memory accesses that occur before the DSB instruction have
> completed before the completion of the DSB instruction.
> 
> So after dsb is replaced with dmb, the description here is not correct.
> DMB instructions do not ensure that memory access has been completed,
> but rather ensure the order of instructions.

Except a memory access and MMIO write are to different destinations, so 
it's likely that in practice the only way the CPU/interconnect can 
enforce that ordering and guarantee that the memory access will be 
observed by a peripheral as soon as the MMIO write completes is to wait 
for the memory access to complete before allowing the MMIO write to 
proceed beyond the point at which they diverge.

Furthermore, "update the cons pointer" is not a defined architectural 
term anyway, and certainly to me it rather implies the entire process of 
the SMMU receiving the value and updating its internal queue state, 
which necessarily implies completion of the MMIO write and thus 
completion of everything ordered before it. If the comment had been 
overly-specific and said "before executing the following store to the 
cons register", then it might be deserving of getting into this level of 
detail, but as it is, meh. Even then it's not like this is architecture 
code using an explicit dmb(); ultimately it's a Linux driver describing 
an overall behaviour it expects from a Linux barrier operation in terms 
of the Linux memory model.

Frankly the much bigger complaint I have with this comment is that 
although it does technically explain the purpose of having some barrier 
here, it does a pretty terrible job of clarifying *why* it's open-coded 
and can't be achieved with standard Linux memory model primitives, 
particularly since __iomb() is undocumented (other than 
"arm64-specific") and appears nowhere else in the entire kernel.

Thanks,
Robin.

>    a76a37777f2c ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer") [1]
> 
> Signed-off-by: Harry Song <jundongsong1@gmail.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d5df91c5..fb229c0ab 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -139,8 +139,8 @@ static bool queue_consumed(struct arm_smmu_ll_queue *q, u32 prod)
>   static void queue_sync_cons_out(struct arm_smmu_queue *q)
>   {
>   	/*
> -	 * Ensure that all CPU accesses (reads and writes) to the queue
> -	 * are complete before we update the cons pointer.
> +	 * Ensure the relative order of cpu accesses (reads and writes)
> +	 * to the queue before update the cons pointer.
>   	 */
>   	__iomb();
>   	writel_relaxed(q->llq.cons, q->cons_reg);
