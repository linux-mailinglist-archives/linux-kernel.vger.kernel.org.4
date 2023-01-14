Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9066AB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjANLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 06:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjANLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:06:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441944692
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673694358; x=1705230358;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=udMV8JX+KP6e3Bghh1vBqQQN6cho5nFLnToaxFf6c6Q=;
  b=GIDYPQ/P6L5ECUM9CYVXBZl1+8yPjoKSel7mZIN1DpDnQD/4Gfl/YsjL
   3w+YPGV5virUrvnvkiMBrJK9B89aFG19RvkoIzxgRr40Xeihtr38fJH3A
   5vQ5U+1+rUrUC4UbwoEt1bZa44jou8qbzXNrPYqfimn1SqezTiwpD/3Jp
   s4UiZc/VcEJFsf1WYSI//H9QJWxRdufHCoh9H1jKhse47TAUS0dcK+eke
   7ZHFWGcdGXTe3+HL64tud9+ad/98SO8Xo0c05waz9g3z5hK/rKgl+/pMx
   BQyiboRMhmjgPEFUto9zF5kQdqDjOxXNEE8k0T1W1UMft64RZbQa0nuCR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304563857"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="304563857"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 03:05:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="689009802"
X-IronPort-AV: E=Sophos;i="5.97,216,1669104000"; 
   d="scan'208";a="689009802"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.252.188.254]) ([10.252.188.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2023 03:05:54 -0800
Message-ID: <a21db6ce-e0a4-797e-f023-0920dd4f795f@linux.intel.com>
Date:   Sat, 14 Jan 2023 19:05:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com
To:     kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-7-kan.liang@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 6/7] iommu/vt-d: Add IOMMU perfmon overflow handler
 support
In-Reply-To: <20230111202504.378258-7-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/12 4:25, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> While enabled to count events and an event occurrence causes the counter
> value to increment and roll over to or past zero, this is termed a
> counter overflow. The overflow can trigger an interrupt. The IOMMU
> perfmon needs to handle the case properly.
> 
> New HW IRQs are allocated for each IOMMU device for perfmon. The IRQ IDs
> are after the SVM range.
> 
> In the overflow handler, the counter is not frozen. It's very unlikely
> that the same counter overflows again during the period. But it's
> possible that other counters overflow at the same time. Read the
> overflow register at the end of the handler and check whether there are
> more.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c    |  2 +
>   drivers/iommu/intel/iommu.h   | 11 ++++-
>   drivers/iommu/intel/perfmon.c | 82 +++++++++++++++++++++++++++++++++++
>   drivers/iommu/intel/svm.c     |  2 +-
>   4 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index dcafa32875c1..94e314320cd9 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1887,6 +1887,8 @@ static inline int dmar_msi_reg(struct intel_iommu *iommu, int irq)
>   		return DMAR_FECTL_REG;
>   	else if (iommu->pr_irq == irq)
>   		return DMAR_PECTL_REG;
> +	else if (iommu->perf_irq == irq)
> +		return DMAR_PERFINTRCTL_REG;
>   	else
>   		BUG();
>   }
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index bbc5dda903e9..f616e4f3d765 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -130,6 +130,8 @@
>   #define DMAR_PERFCFGOFF_REG	0x310
>   #define DMAR_PERFOVFOFF_REG	0x318
>   #define DMAR_PERFCNTROFF_REG	0x31c
> +#define DMAR_PERFINTRSTS_REG	0x324
> +#define DMAR_PERFINTRCTL_REG	0x328
>   #define DMAR_PERFEVNTCAP_REG	0x380
>   #define DMAR_ECMD_REG		0x400
>   #define DMAR_ECEO_REG		0x408
> @@ -357,6 +359,9 @@
>   
>   #define DMA_VCS_PAS	((u64)1)
>   
> +/* PERFINTRSTS_REG */
> +#define DMA_PERFINTRSTS_PIS	((u32)1)
> +
>   #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
>   do {									\
>   	cycles_t start_time = get_cycles();				\
> @@ -630,8 +635,12 @@ struct iommu_pmu {
>   	struct pmu		pmu;
>   	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
>   	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
> +	unsigned char		irq_name[16];
>   };
>   
> +#define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
> +#define IOMMU_IRQ_ID_OFFSET_PERF	(2 * DMAR_UNITS_SUPPORTED)
> +
>   struct intel_iommu {
>   	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
>   	u64 		reg_phys; /* physical address of hw register set */
> @@ -645,7 +654,7 @@ struct intel_iommu {
>   	int		seq_id;	/* sequence id of the iommu */
>   	int		agaw; /* agaw of this iommu */
>   	int		msagaw; /* max sagaw of this iommu */
> -	unsigned int 	irq, pr_irq;
> +	unsigned int	irq, pr_irq, perf_irq;
>   	u16		segment;     /* PCI segment# */
>   	unsigned char 	name[13];    /* Device Name */
>   
> diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
> index f332232bb345..d0fbf784c827 100644
> --- a/drivers/iommu/intel/perfmon.c
> +++ b/drivers/iommu/intel/perfmon.c
> @@ -476,6 +476,49 @@ static void iommu_pmu_disable(struct pmu *pmu)
>   	ecmd_submit_sync(iommu, DMA_ECMD_FREEZE, 0, false, 0);
>   }
>   
> +static void iommu_pmu_counter_overflow(struct iommu_pmu *iommu_pmu)
> +{
> +	struct perf_event *event;
> +	int i, handled = 0;
> +	u64 status;
> +
> +	/*
> +	 * Two counters may be overflowed very close.
> +	 * Always check whether there are more to handle.
> +	 */

Keep comment style consistent, like this

         /*
          * Two counters may be overflowed very close. Always check whether
          * there are more to handle.
          */

Same to other places.

> +	while ((status = dmar_readq(iommu_pmu->overflow))) {

Unnecessary double brackets?

> +		for_each_set_bit(i, (unsigned long *)&status, iommu_pmu->num_cntr) {
> +			handled++;

"handled" isn't used anywhere. Please cleanup it.

> +
> +			/*
> +			 * Find the assigned event of the counter.
> +			 * Accumulate the value into the event->count.
> +			 */
> +			event = iommu_pmu->event_list[i];
> +			if (WARN_ON_ONCE(!event))

Again, do we need a kernel trace here? This is only because the hardware
reported an wrong event id, right? How about a pr_warn() to let the user
know this?

> +				continue;
> +			iommu_pmu_event_update(event);
> +		}
> +
> +		dmar_writeq(iommu_pmu->overflow, status);
> +	}
> +}
> +
> +static irqreturn_t iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct intel_iommu *iommu = dev_id;
> +
> +	if (!dmar_readl(iommu->reg + DMAR_PERFINTRSTS_REG))
> +		return IRQ_NONE;
> +
> +	iommu_pmu_counter_overflow(iommu->pmu);
> +
> +	/* Clear the status bit */
> +	dmar_writel(iommu->reg + DMAR_PERFINTRSTS_REG, DMA_PERFINTRSTS_PIS);
> +
> +	return IRQ_HANDLED;
> +}
> +
>   static int __iommu_pmu_register(struct intel_iommu *iommu)
>   {
>   	struct iommu_pmu *iommu_pmu = iommu->pmu;
> @@ -658,6 +701,38 @@ void free_iommu_pmu(struct intel_iommu *iommu)
>   	iommu->pmu = NULL;
>   }
>   
> +static int iommu_pmu_set_interrupt(struct intel_iommu *iommu)
> +{
> +	struct iommu_pmu *iommu_pmu = iommu->pmu;
> +	int irq, ret;
> +
> +	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PERF + iommu->seq_id, iommu->node, iommu);
> +	if (irq <= 0)
> +		return -EINVAL;
> +
> +	snprintf(iommu_pmu->irq_name, sizeof(iommu_pmu->irq_name), "dmar%d-perf", iommu->seq_id);
> +
> +	iommu->perf_irq = irq;
> +	ret = request_threaded_irq(irq, NULL, iommu_pmu_irq_handler,
> +				   IRQF_ONESHOT, iommu_pmu->irq_name, iommu);
> +	if (ret) {
> +		dmar_free_hwirq(irq);
> +		iommu->perf_irq = 0;
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
> +{
> +	if (!iommu->perf_irq)
> +		return;
> +
> +	free_irq(iommu->perf_irq, iommu);
> +	dmar_free_hwirq(iommu->perf_irq);
> +	iommu->perf_irq = 0;
> +}
> +
>   static int iommu_pmu_cpu_online(unsigned int cpu)
>   {
>   	if (cpumask_empty(&iommu_pmu_cpu_mask))
> @@ -734,8 +809,14 @@ void iommu_pmu_register(struct intel_iommu *iommu)
>   	if (iommu_pmu_cpuhp_setup(iommu_pmu))
>   		goto unregister;
>   
> +	/* Set interrupt for overflow */
> +	if (iommu_pmu_set_interrupt(iommu))
> +		goto cpuhp_free;
> +
>   	return;
>   
> +cpuhp_free:
> +	iommu_pmu_cpuhp_free(iommu_pmu);
>   unregister:
>   	perf_pmu_unregister(&iommu_pmu->pmu);
>   err:
> @@ -749,6 +830,7 @@ void iommu_pmu_unregister(struct intel_iommu *iommu)
>   	if (!iommu_pmu)
>   		return;
>   
> +	iommu_pmu_unset_interrupt(iommu);
>   	iommu_pmu_cpuhp_free(iommu_pmu);
>   	perf_pmu_unregister(&iommu_pmu->pmu);
>   }
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c76b66263467..b6c5edd80d5d 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -79,7 +79,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>   	}
>   	iommu->prq = page_address(pages);
>   
> -	irq = dmar_alloc_hwirq(DMAR_UNITS_SUPPORTED + iommu->seq_id, iommu->node, iommu);
> +	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
>   	if (irq <= 0) {
>   		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
>   		       iommu->name);

--
Best regards,
baolu
