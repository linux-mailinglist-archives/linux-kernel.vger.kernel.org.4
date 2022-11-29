Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC163B7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiK2CWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiK2CWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:22:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D34384B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669688542; x=1701224542;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tbc+ZueGykxDbF9jnsj+Z1gJ1TR24nDwb3s1ZF8qrDE=;
  b=LHR99n/mThe3KyTN5JrRmXdQcXdBaPc/+kHHKuQHZiyUGGQOhWhiFvtc
   viaHnaUSBmBoA/X2cJFkMFlF7Kss/MaLnzvKkPac16OiknAGg/U29Z8Am
   dvd1L4BW8YCAzC0rv0eGoCZhVWgzN5/eyo2gMbMLMdz/v31nqyAhROz01
   Demxt3E+SfjGP8rlBN7SF6ZqsGgu564TYzojvG/xcIg/w1aqDYnZCsWRm
   jJOoLIxDkRXc47DdNMRs/brcMiMy8q53PvxAO/jwjg3cVEn7FkvvM6lXl
   zpv3WGuAcbhthDQW2B3SHewjn5x8qnX9yiSmflmTwlwXCsNsEA+fmId8l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312630483"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="312630483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 18:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="594094969"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="594094969"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2022 18:22:15 -0800
Message-ID: <777eb770-7db2-0cb8-876e-67d86abffa42@linux.intel.com>
Date:   Tue, 29 Nov 2022 10:15:03 +0800
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
Subject: Re: [PATCH v3 10/20] iommu: Add set_platform_dma iommu ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-11-baolu.lu@linux.intel.com>
 <Y4TBng2SY0eGE7wx@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y4TBng2SY0eGE7wx@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 10:11 PM, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 02:46:38PM +0800, Lu Baolu wrote:
>> When VFIO finishes assigning a device to user space and calls
>> iommu_group_release_dma_owner() to return the device to kernel, the IOMMU
>> core will attach the default domain to the device. Unfortunately, some
>> IOMMU drivers don't support default domain, hence in the end, the core
>> calls .detach_dev instead.
>>
>> This adds set_platform_dma iommu ops to make it clear that what it does
>> is returning control back to the platform DMA ops.
>>
>> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h | 4 ++++
>>   1 file changed, 4 insertions(+)
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
>> + * @set_platform_dma: Returning control back to the platform DMA ops. Only
>> + *                    valid for IOMMU drivers which don't support default
>> + *                    domain.
> I would add:
> 
>    This op is to support old IOMMU drivers, new drivers should use
>    default domains, and the common IOMMU DMA ops.

Done. Thank you!

Best regards,
baolu
