Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4724163E8FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLAEvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLAEvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:51:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C199F6B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669870260; x=1701406260;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=czGBSNX4YjAv5jaWl9TGCSmAfkTUKYI5muAxzvlCGss=;
  b=YloN2lPafsPcUyfxf99tSPLBwLfG5Vwxahqq9cUjHvfd7WtsHaglTqM/
   1n8X2Fm9yK5IxNKOI7c+K8j3mpuujABk4sQNzwP1kx1/igLM5BcfM/zgu
   6TpxL1a2VQyPB4Cg3ZDNgILYymoMdka/zmB+zG1Llx4PnWbB3QfJ7HyuJ
   wQ5tHE+GoXENwVoEY93YGdSWAKcJ21uPfuG+hx33omUCtLP94GmpKG+Vc
   JvSLHPL2X4v2Y45+D2Dr+MHfoeXMCSzi981/i5NIpEgkLBkH3P4HROwZv
   F8cytEMYFKHbFiKWc/84roFNwUPvBHTVqbkPfOtwCVhD6RfAsQOg1K84d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314287183"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="314287183"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:50:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="786745982"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="786745982"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.206]) ([10.254.215.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 20:50:54 -0800
Message-ID: <b3b2226e-7eee-f24c-9f61-8b968ef6af9c@linux.intel.com>
Date:   Thu, 1 Dec 2022 12:50:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     baolu.lu@linux.intel.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
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
Subject: Re: [PATCH v3 02/20] iommu/apple-dart: Remove detach_dev callback
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-3-baolu.lu@linux.intel.com>
 <e255ed09-ed67-46b3-b055-287959d1b76f@app.fastmail.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e255ed09-ed67-46b3-b055-287959d1b76f@app.fastmail.com>
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

On 2022/12/1 1:00, Sven Peter wrote:
> On Mon, Nov 28, 2022, at 07:46, Lu Baolu wrote:
>> The IOMMU driver supports default domain, so the detach_dev op will never
>> be called. Remove it to avoid dead code.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
> Reviewed-by: Sven Peter<sven@svenpeter.dev>
> 
>>   drivers/iommu/apple-dart.c | 17 -----------------
>>   1 file changed, 17 deletions(-)
>>
>> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
>> index 4f4a323be0d0..6fbe6b275c79 100644
>> --- a/drivers/iommu/apple-dart.c
>> +++ b/drivers/iommu/apple-dart.c
>> @@ -535,22 +535,6 @@ static int apple_dart_attach_dev(struct
>> iommu_domain *domain,
>>   	return ret;
>>   }
>>
>> -static void apple_dart_detach_dev(struct iommu_domain *domain,
>> -				  struct device *dev)
>> -{
> Thanks for cleaning this entire API up!
> 
> It actually turns out that this is slightly broken because I assumed that
> detach_dev would always be called for any attach_dev. I think the only
> consequence for a device that used to be assigned to domain A and is now moved to
> domain B is that any TLB flushes required for A will still flush the TLB for that
> device.
> 
> That's not a big deal but I'll eventually send a fix.
> 
>> -	int i;
>> -	struct apple_dart_stream_map *stream_map;
>> -	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
>> -	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
>> -
>> -	for_each_stream_map(i, cfg, stream_map)
>> -		apple_dart_hw_disable_dma(stream_map);
>> -
>> -	if (domain->type == IOMMU_DOMAIN_DMA ||
>> -	    domain->type == IOMMU_DOMAIN_UNMANAGED)
>> -		apple_dart_domain_remove_streams(dart_domain, cfg);
> Something might complain about unused apple_dart_domain_remove_streams now.
> Might make sense to drop that for now as well.

Done. Thanks!

Best regards,
baolu
