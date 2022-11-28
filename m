Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C163A8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiK1NAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK1NAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:00:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00E211156;
        Mon, 28 Nov 2022 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669640440; x=1701176440;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=CuUxM0z/3KSQu9y5awXbBEiVKQT5wLrzlc0qrTwSUdc=;
  b=LFZxKupJ8DM44fqYIEVgGtuu+gFpT1hTj3ROdToKYDgoq4zc+uF1Uv4Z
   3WSoBrrCTIdcmSS46Y+EdVqqm7447XTId+NNkwaRhh/siit0WmTeQF4m6
   5YRT97WiYnqitA19IgzP0HXDDYohNwXv69Eg57LGG4LqSbSZakZKVS47L
   I/2465eT/pqoPJyCIJyXIACZgBUk5DtmOB6Q2EwkdZ4b1R/lSKQxaz8SC
   zCHD9W9IBf8gydhRjT2Y2tWIfe2cSiJkb2IId67Ax8fmrI8M3NvdNsQ51
   RC2tlgrGCbIQEmqnAJaFkJA/u7ZzJccNOoniwSEmefIKTAyiCWm1WAViS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="316652634"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="316652634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:00:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="785620261"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="785620261"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.244]) ([10.254.213.244])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:00:35 -0800
Message-ID: <2fde49a1-a1df-d78a-dd38-2322a760513b@linux.intel.com>
Date:   Mon, 28 Nov 2022 21:00:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
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
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
In-Reply-To: <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
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

On 2022/11/28 19:10, Niklas Schnelle wrote:
> On Thu, 2022-11-17 at 09:55 +0800, Baolu Lu wrote:
>> On 2022/11/17 1:16, Niklas Schnelle wrote:
>>> When iommu.strict=1 is set or iommu_set_dma_strict() was called we
>>> should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
>>>
>>> Signed-off-by: Niklas Schnelle<schnelle@linux.ibm.com>
>>> ---
>>>    drivers/iommu/iommu.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 65a3b3d886dc..d9bf94d198df 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
>>>    {
>>>    	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>>    
>>> +	if (iommu_dma_strict)
>>> +		return IOMMU_DOMAIN_DMA;
>> If any quirky device must work in IOMMU identity mapping mode, this
>> might introduce functional regression. At least for VT-d platforms, some
>> devices do require IOMMU identity mapping mode for functionality.
> That's a good point. How about instead of unconditionally returning
> IOMMU_DOMAIN_DMA we just do so if the domain type returned by ops-
>> def_domain_type uses a flush queue (i.e. the __IOMMU_DOMAIN_DMA_FQ bit
> is set). That way a device that only supports identity mapping gets to
> set that but iommu_dma_strict at least always prevents use of an IOVA
> flush queue.

def_domain_type returns IOMMU_DOMAIN_DMA, IOMMU_DOMAIN_IDENTIRY or 0
(don't care). From a code perspective, you can force IOMMU_DOMAIN_DMA if
def_domain_type() returns 0.

*But* you need to document the relationship between strict mode and
default domain type somewhere and get that agreed with Robin.

Best regards,
baolu
