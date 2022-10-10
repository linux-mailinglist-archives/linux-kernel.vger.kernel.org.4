Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25555F9DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbiJJLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiJJLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:33:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048636F567
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665401590; x=1696937590;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VOeaJcpwzZJ0pJxWdJglMMEshugCfS9igKMdjRFdHpY=;
  b=jdgK3qAvy9zp8VPJfmi5KoCYRsqrWOpYHaOxQIHDmx50oFkaffCavhZr
   qM9SA/+6ooM9e0vU9MqRKzlzxlzkcKnTWRn5PM7TKfuO+KA+KS1j7v9Bi
   FwiyBBeGbPtdeQqZx3YV9KWLUzHjCIC6diP9X7XKoT+HQbY1UXl/QeVhC
   /1EJ/KOM8DbLUrnyGQ6LlRImzj+5uyx0Jthw8c6M5quRU6yzkLUKduZPR
   XBMLzwKro+8+e19d3z4QVr+K34GAHMQGO3eGDWbc4trwxjkKHJu7uluaS
   myqVnVQllHw+dWI60YolJhvjbzc5AIHQvTS8U4tNql3nPF90JeNxFYRim
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="287440646"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287440646"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 04:32:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="688754888"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="688754888"
Received: from jbai-mobl.ccr.corp.intel.com (HELO [10.254.211.42]) ([10.254.211.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 04:32:45 -0700
Message-ID: <35cf84fb-7672-671a-4354-0fb66bd2f8e7@linux.intel.com>
Date:   Mon, 10 Oct 2022 19:32:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/vt-d: Clean up si_domain in the init_dmars() error
 path
To:     Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221010065608.281860-1-jsnitsel@redhat.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221010065608.281860-1-jsnitsel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/10 14:56, Jerry Snitselaar wrote:
> A splat from kmem_cache_destroy() was seen with a kernel prior to
> commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
> when there was a failure in init_dmars(), because the iommu_domain
> cache still had objects. While the mempool code is now gone, there
> still is a leak of the si_domain memory if init_dmars() fails. So
> clean up si_domain in the init_dmars() error path.
> 
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 31bc50e538a3..8f1f80a4d0c5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3042,6 +3042,8 @@ static int __init init_dmars(void)
>   		disable_dmar_iommu(iommu);
>   		free_dmar_iommu(iommu);
>   	}
> +	if (si_domain)
> +		domain_exit(si_domain);

Thank you for the patch.

Above requires si_domain to be NULL or a valid pointer. So do you also
need to add the following change?

--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2410,6 +2410,7 @@ static int __init si_domain_init(int hw)

         if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
                 domain_exit(si_domain);
+               si_domain = NULL;
                 return -EFAULT;
         }

Best regards,
baolu
