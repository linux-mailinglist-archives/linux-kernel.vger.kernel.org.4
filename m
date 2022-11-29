Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC763B8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiK2Dxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbiK2Dxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:53:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C24665C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669694032; x=1701230032;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V86s8+gnQwUzclhc6VLYszDsc8zsrqnmT+BIX1Zrqfo=;
  b=hCJyNa5b1Dv2XTXDMAhMgrLjePWVNrYWWdjWsVN4Bg8OnVyYwWoZNLgW
   5WOrwti7amA4f21CfgVjhUN35JztTV8eG5s2R8a723nVOs9oRDtTlEaG3
   XRwrw+FswF3mNY3gF9wIQonXaeeCi7QybrJryN6EYdG7xqAwlpM+jAadS
   zC7P0Csp28qpf6GevLpWo9s73C/55cpGJ9Qi98RAR2WIuVLOwIVUbnDxb
   8yGiyHWnZk23TL/Gv7/DRF4cnG5t5jc7KewoZNRBWQe+vE0jIXczsUjV9
   B9EEkOAJI6FPW1LNGQCTgyTZ0zpMRfYe6AXZaBlDEIDjLyao1L5lM+nOk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316846639"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="316846639"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 19:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="594114361"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="594114361"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2022 19:53:45 -0800
Message-ID: <a7b10de8-b860-a2af-2b59-584b3fc748e1@linux.intel.com>
Date:   Tue, 29 Nov 2022 11:46:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/20] iommu/fsl_pamu: Add set_platform_dma callback
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-12-baolu.lu@linux.intel.com>
 <Y4TCQysTwDqTv/Cz@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y4TCQysTwDqTv/Cz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 10:14 PM, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 02:46:39PM +0800, Lu Baolu wrote:
>> This IOMMU driver doesn't support default domain. Add the implementation
>> of set_platform_dma callback so that the IOMMU core could return the
>> DMA control.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/fsl_pamu_domain.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
>> index 4408ac3c49b6..b8c716e7c424 100644
>> --- a/drivers/iommu/fsl_pamu_domain.c
>> +++ b/drivers/iommu/fsl_pamu_domain.c
>> @@ -314,6 +314,14 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
>>   		pr_debug("missing fsl,liodn property at %pOF\n", dev->of_node);
>>   }
>>   
>> +static void fsl_pamu_set_platform_dma(struct device *dev)
>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	if (domain)
>> +		fsl_pamu_detach_device(domain, dev);
>> +}
> This is a bit ugly, it would be better to make the previous patch call
> set_platform_dma if it is set instead of detach_dev and then these
> patches should just rename the driver's fsl_pamu_detach_device to
> fsl_pamu_set_platform_dma
> 
> Then the last patch just deletes the op and the core code

Yes. That's better. I will update the series.

Best regards,
baolu
