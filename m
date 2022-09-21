Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDD5BF6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiIUGtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIUGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:49:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4407F81693
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663742964; x=1695278964;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XawNPyqzrCuNlg8rwhRO9w7/Tv1o2gsrQDcffFviwHs=;
  b=f5vRZ33+ZBJCVa7MB1+PFL34AX87SG6UCIt7LcVn8732AHVJB/ycZBh3
   nJAE8lRda3cw7zc7W6QRvpFvd2pw1mEt6T11vasb365c3RBAgWT7aqVM9
   MSZxCtDc717eZV+CidRuiR5lyCg90hZ6Z5hW7Dsakj19CyvZr1Jr5nHI6
   o3v8u+3irLaTFGsgUxS9vdgVpywwWDfZSWCdgPo+N9VF8kzcLXxyBIFzk
   o+f1ocPbgBCLWJuet5oCbBXCygyZW+KGK9GXQS6Lez3SCj89c66t+Uuum
   jKpheOxqv1ZtBJ8Io6T6mx3Wh6vRbM9Bs/zXTXn9OCWWu0tzWuffzRWK+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282965025"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="282965025"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:49:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="708318589"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.217]) ([10.254.208.217])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 23:49:20 -0700
Message-ID: <bbc6da4d-c2d9-c5ee-aced-3f08831672bc@linux.intel.com>
Date:   Wed, 21 Sep 2022 14:49:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/vt-d: Avoid unnecessary global IRTE cache
 invalidation
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52760E6985B16235A30B57978C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760E6985B16235A30B57978C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 15:51, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, September 19, 2022 2:25 PM
>>
>> Some VT-d hardware implementations invalidate all interrupt remapping
>> hardware translation caches as part of SIRTP flow. The VT-d spec adds
>> a ESIRTPS (Enhanced Set Interrupt Remap Table Pointer Support, section
>> 11.4.2 in VT-d spec) capability bit to indicate this. With this bit set,
>> software has no need to issue the global invalidation request.
>>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h         | 1 +
>>   drivers/iommu/intel/irq_remapping.c | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index eef1a166b855..5407d82df4d1 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -146,6 +146,7 @@
>>   /*
>>    * Decoding Capability Register
>>    */
>> +#define cap_esirtps(c)		(((c) >> 62) & 1)
>>   #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
>>   #define cap_pi_support(c)	(((c) >> 59) & 1)
>>   #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
>> diff --git a/drivers/iommu/intel/irq_remapping.c
>> b/drivers/iommu/intel/irq_remapping.c
>> index 2e9683e970f8..b4a91fbd1c2f 100644
>> --- a/drivers/iommu/intel/irq_remapping.c
>> +++ b/drivers/iommu/intel/irq_remapping.c
>> @@ -494,7 +494,8 @@ static void iommu_set_irq_remapping(struct
>> intel_iommu *iommu, int mode)
>>   	 * Global invalidation of interrupt entry cache to make sure the
>>   	 * hardware uses the new irq remapping table.
>>   	 */
>> -	qi_global_iec(iommu);
>> +	if (!cap_esirtps(iommu->cap))
>> +		qi_global_iec(iommu);
>>   }
>>
> 
> Same check is also required in iommu_disable_irq_remapping().
> 
> The spec says that:
> 
> --
> For implementations reporting the Enhanced Set Interrupt Remap Table
> Pointer Support (ESIRTPS) field as Set, hardware performs global
> invalidation on all Interrupt remapping caches as part of Interrupt
> Remapping Disable operation.
> --

Yes. I will add the same check in iommu_disable_irq_remapping(). Thanks
for the reminding.

> While looking at that code I think it's problematic to invalidate interrupt
> cache before disabling interrupt remapping. Presumably invalidations
> should be done only after a configuration is changed, no matter it's 'enable'
> or 'disable'.

I understand your concern. The spec doesn't state the sequence in the
interrupt remapping disabling flow. Need to check it with the spec
developers before any change here.

Best regards,
baolu
