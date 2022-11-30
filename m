Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8039C63CC52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiK3ALU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiK3ALH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:11:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24C716E0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669767061; x=1701303061;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B5h41uyGgikqzhqo86Wn4bWgSPj4zLK0qe0xzVnTtCA=;
  b=bB+zsYKW2Q4dWixmhoJaA55ORHyHSLqIXg66OvWEUHwhybKAmrMS5VNd
   FFdpBYrMrPJEZQw8AJxyI9jPAXFQqRIeuaW/KlL/auqT4rCau9Vn1kuQJ
   cjcoXKapqD4eBulhxpfiN/8XvDqRfAIHXiJ2c30rMrvTeO94l0M9ZTgNP
   W6ORSMISC+bRa+uclw8hQvD9TNfYrEuC+slm7R5R5DrJvhUyqHLKUoAP9
   8fkRINvCuVMzfcytiYzufI7k/VgZJ+oVeWV1ipIQ3cQ8Mx6OMltTE/RVx
   H4UykwqSM1dKJBtd5bjV+LnxelbmIpAyVVCRZBwy2W4/CuoFqO36egvS+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295626202"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="295626202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:11:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="637793416"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="637793416"
Received: from cwang11-mobl.ccr.corp.intel.com (HELO [10.254.210.199]) ([10.254.210.199])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 16:10:57 -0800
Message-ID: <9fd4bf6c-5525-c209-28b6-492558c1dd35@linux.intel.com>
Date:   Wed, 30 Nov 2022 08:10:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2022/11/29 1:04, Jacob Pan wrote:
> QAT devices on Intel Sapphire Rapids and Emerald Rapids have a defect in
> address translation service (ATS). These devices may inadvertently issue
> ATS invalidation completion before posted writes initiated with
> translated address that utilized translations matching the invalidation
> address range, violating the invalidation completion ordering.
> 
> This patch adds an extra device TLB invalidation for the affected devices,
> it is needed to ensure no more posted writes with translated address
> following the invalidation completion. Therefore, the ordering is
> preserved and data-corruption is prevented.
> 
> Device TLBs are invalidated under the following six conditions:
> 1. Device driver does DMA API unmap IOVA
> 2. Device driver unbind a PASID from a process, sva_unbind_device()
> 3. PASID is torn down, after PASID cache is flushed. e.g. process
> exit_mmap() due to crash
> 4. Under SVA usage, called by mmu_notifier.invalidate_range() where
> VM has to free pages that were unmapped
> 5. userspace driver unmaps a DMA buffer
> 6. Cache invalidation in vSVA usage (upcoming)
> 
> For #1 and #2, device drivers are responsible for stopping DMA traffic
> before unmap/unbind. For #3, iommu driver gets mmu_notifier to
> invalidate TLB the same way as normal user unmap which will do an extra
> invalidation. The dTLB invalidation after PASID cache flush does not
> need an extra invalidation.
> 
> Therefore, we only need to deal with #4 and #5 in this patch. #1 is also
> covered by this patch due to common code path with #5.
> 
> Tested-by: Yuzhang Luo <yuzhang.luo@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
> v2
> - removed risky_device() check based on the review by Robin, added comments
>    to explain the exemption.
> - reworked commit message based on the review from Ashok
> ---
>   drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++++++++++++--
>   drivers/iommu/intel/iommu.h |  3 ++
>   drivers/iommu/intel/svm.c   |  4 ++-
>   3 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 996a8b5ee5ee..a97e9247037f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1396,6 +1396,23 @@ static void domain_update_iotlb(struct dmar_domain *domain)
>   	spin_unlock_irqrestore(&domain->lock, flags);
>   }
>   
> +/*
> + * Impacted QAT device IDs ranging from 0x4940 to 0x4943.
> + * This quirk is exempted from risky_device() check because it applies only
> + * to the built-in QAT devices.
> + */

How about adding:

"This quirk is exempted from risky_device() check because it doesn't
effectively grant additional privileges."

?

--
Best regards,
baolu
