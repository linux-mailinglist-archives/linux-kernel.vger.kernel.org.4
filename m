Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D869CF3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBTOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjBTOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:21:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E1971EBFB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:21:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B81BFFEC;
        Mon, 20 Feb 2023 06:21:47 -0800 (PST)
Received: from [10.57.76.145] (unknown [10.57.76.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554A63F881;
        Mon, 20 Feb 2023 06:21:03 -0800 (PST)
Message-ID: <60bbb654-9af0-e300-23df-388737a90151@arm.com>
Date:   Mon, 20 Feb 2023 14:21:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/6] ARM/dma-mapping: Remove iommu_detach_device()
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-2-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230217094736.159005-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-17 09:47, Lu Baolu wrote:
> iommu_detach_device() attaches the default domain to the device, or if
> default domain is not supported by the IOMMU driver, it calls its
> set_platform_dma_ops callback. If the default domain is supported or
> the IOMMU driver is not iommu-dma aware, iommu_detach_device() is
> actually a noop.
> 
> The 64-bit ARM drivers always support default domain and iommu-dma is
> even not enabled for 32-bit ARM. This turns out that iommu_detach_device()
> is always a noop in arm_iommu_detach_device(). Remove it to avoid dead
> code.

Huh? This call clearly balances the iommu_attach_device() call in 
arm_iommu_attach_device() - it has nothing to do with default domains.

> The bonus is that it also removes a obstacle of arm_iommu_detach_device()
> re-entering the iommu core during release_device. With this removed, the
> iommu core code could be simplified a lot.

That needs to be worked around in those release paths, not by breaking 
the public API. Should probably just be a case of doing as much "detach" 
as necessary directly, then calling arm_iommu_release_mapping(). Just 
beware that arm_teardown_iommu_dma_ops() may or may not have done some 
of it already, depending on whether a driver ever bound to the device.

Thanks,
Robin.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   arch/arm/mm/dma-mapping.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8bc01071474a..dcbc2f4586d4 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1699,7 +1699,6 @@ void arm_iommu_detach_device(struct device *dev)
>   		return;
>   	}
>   
> -	iommu_detach_device(mapping->domain, dev);
>   	kref_put(&mapping->kref, release_iommu_mapping);
>   	to_dma_iommu_mapping(dev) = NULL;
>   	set_dma_ops(dev, NULL);
