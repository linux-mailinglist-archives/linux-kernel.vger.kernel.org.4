Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF86AB629
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 06:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCFF51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 00:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFF5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:57:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FFB1B54D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 21:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678082243; x=1709618243;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGl9Y7rGNOqc+3WfAtbo6hMfh8OFQWxWhmVI5Kclh60=;
  b=bw6mIaTOQvICfUZpMV6+1dyQDlwnCipv8tJCrbgysylcaFvI447/NvIQ
   6mrsph12GgmccDNJODxckn1K9LMAvV1z+ZzBQK+yIUzL8V4uNQY9SmATV
   iZmZEgAi1TwVsL1N0d+vE9naUfOF0WM24xNaYfZmK1VVizNg2EdWPU8OO
   T4SCChyj7u09n83+lzxlj10mUUStzPnBO/KsKVqaQsx350X1JaHZ+84LW
   G/mwq33AIk+78p6b+SD+XHv7vlipxqQ/V8QOkduP++OjQYLfJbrm0XyV2
   OpueCQFFEmQ7D6d6CN5n6laFpRuaQrio+dQkmyYbGWb5iYfyhrjpGB1rQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315135450"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315135450"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 21:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="626043634"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="626043634"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.193]) ([10.254.209.193])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 21:57:20 -0800
Message-ID: <d18d3026-a3a9-a92b-3735-f4045f96ff4e@linux.intel.com>
Date:   Mon, 6 Mar 2023 13:57:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] iommu: sprd: fix a dma buffer leak issue
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230306052613.411400-1-chunyan.zhang@unisoc.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230306052613.411400-1-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/6 13:26, Chunyan Zhang wrote:
> The DMA buffer used to store the address mpping table is alloced when
> attaching device to a domain, and had been released in .detach_dev()
> callback which will never be called since this driver supports default
> domain, that will cause memory leak.
> 
> Move the dma buffer free before freeing sprd iommu domain to fix
> this issue.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> V2: Modified commit message
> ---
>   drivers/iommu/sprd-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index ae94d74b73f4..4de2e79d2226 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -154,6 +154,17 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
>   static void sprd_iommu_domain_free(struct iommu_domain *domain)
>   {
>   	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	size_t pgt_size = sprd_iommu_pgt_size(domain);
> +	struct sprd_iommu_device *sdev = dom->sdev;
> +
> +	/*
> +	 * If the domain has been attached to a device already,
> +	 * free the dma buffer first.

Is it possible that a domain is attached to multiple devices or attached
to a device multiple times? If so, perhaps the memory is also leaked in
sprd_iommu_attach_device():

233 static int sprd_iommu_attach_device(struct iommu_domain *domain,
234                                     struct device *dev)
235 {
236         struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
237         struct sprd_iommu_domain *dom = to_sprd_domain(domain);
238         size_t pgt_size = sprd_iommu_pgt_size(domain);
239
240         if (dom->sdev)
241                 return -EINVAL;
242
243         dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, 
&dom->pgt_pa, GFP_KERNEL);
244         if (!dom->pgt_va)
245                 return -ENOMEM;

as dom->pgt_va is not checked before setting a new pointer.

If sprd iommu driver only supports one-time use of domain， perhaps put
a comment around above code so that people can take care of it when the
assumption changes.

> +	 */
> +	if (sdev) {
> +		dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
> +		dom->sdev = NULL;
> +	}
>   
>   	kfree(dom);
>   }

Best regards,
baolu
