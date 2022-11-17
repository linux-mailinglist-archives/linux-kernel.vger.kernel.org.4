Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A862D0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiKQBzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKQBzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:55:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AB60E8B;
        Wed, 16 Nov 2022 17:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668650132; x=1700186132;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uuP5q8gUlbvgaw8quTq8oqXHFLQt2Yhg3IPq6GPh/j8=;
  b=ChmhzHvxTU3g8tGyFOqlsWV5x056Vhppal3M6uYw/PTjuq+Av4AjCZtL
   +S6qxTwQZfllKvgFn7r3lGYlhtbvqrVrYKmjR9NZSoHstvoLa6CUSdsTx
   wnDKEUpBYzjUDP3er6DUSFSeWfCaXFM3yJS40Yl/gLB/CCVmLCodEo602
   vNhoUw+ypvnhteV7DbskKZvYEcsfmRO+qtR4je4jeQ1HYrj0hOmJDB1vs
   R/qBJ11YNZoEoaz3DAV1cKwYj5kdAfU27L8nkGaVKm5RK9FYw9P+fMfkX
   WVcuTN0m9oGOBMo57+oi5nf2EqeA+yOjC5eZ9eDqf9HlzqfDLK3hNBasj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300256615"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300256615"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:55:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764562079"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="764562079"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.247]) ([10.254.210.247])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:55:27 -0800
Message-ID: <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
Date:   Thu, 17 Nov 2022 09:55:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
In-Reply-To: <20221116171656.4128212-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/17 1:16, Niklas Schnelle wrote:
> When iommu.strict=1 is set or iommu_set_dma_strict() was called we
> should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 65a3b3d886dc..d9bf94d198df 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> +	if (iommu_dma_strict)
> +		return IOMMU_DOMAIN_DMA;

If any quirky device must work in IOMMU identity mapping mode, this
might introduce functional regression. At least for VT-d platforms, some
devices do require IOMMU identity mapping mode for functionality.

> +
>   	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>   		return IOMMU_DOMAIN_DMA;
>   

Best regards,
baolu
