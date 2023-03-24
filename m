Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165246C7A48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCXIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjCXIub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:50:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B1196B2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679647830; x=1711183830;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DCiN3ZdhQ9Gk5WRDAOIr0yBvgeA5s48pgR7GgQdQ8nE=;
  b=mt+TxJ66vMwGaUvId3J8/bEt/IZ0M2uHGgjeeWj5jOap1zmVqVEaOFGg
   F2rbHbY6bTn67seLp3+i1FM7GzmqYa2XzLhU3N9XEcfk/5V2ONpqJjZzh
   GXk/hce2yxfBR9/ISHnrZpgn171iTc6aBSEsQnai2HivK+KM9BF7cO30s
   ptAWcKoT/oCCc5LDMiYkDl2o4IG2Sw3gKW22Wix3s+QQol3ODq3OtGJy3
   IJ40rGASazRxNiYv8EQ3SZPS2qCaUk+ww2lnVVn+lDk6Wl6MkaSltaemV
   RUu5hQ9u6HDKwa2F7IAl1F8mxNSPeyxRwX5kiw1doaNfOMTjQtw3Ar02z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="426001579"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="426001579"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="682612064"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="682612064"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.177]) ([10.254.215.177])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 01:50:24 -0700
Message-ID: <62b2ee87-642c-d951-3c5e-9d6f035b5717@linux.intel.com>
Date:   Fri, 24 Mar 2023 16:50:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Srinivasan, Raghunathan" <raghunathan.srinivasan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Allow zero SAGAW if second-stage not
 supported
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230318024824.124542-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52768EB838F5E7219BE058F08C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768EB838F5E7219BE058F08C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/24 12:49, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, March 18, 2023 10:48 AM
>>
>> The VT-d spec states (section 11.4.2) that hardware implementations
>> reporting second-stage translation support (SSTS) field as Clear also
>> report the SAGAW field as 0. Reflect this in the sanity check of
>> alloc_iommu().
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>> default")
>> Suggested-by: Raghunathan Srinivasan <raghunathan.srinivasan@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 6acfe879589c..23828d189c2a 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1071,7 +1071,8 @@ static int alloc_iommu(struct dmar_drhd_unit
>> *drhd)
>>   	}
>>
>>   	err = -EINVAL;
>> -	if (cap_sagaw(iommu->cap) == 0) {
>> +	if (!cap_sagaw(iommu->cap) &&
>> +	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
>>   		pr_info("%s: No supported address widths. Not attempting
>> DMA translation.\n",
>>   			iommu->name);
>>   		drhd->ignored = 1;
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw I wonder whether it's cleaner to record separate agaw values for
> stage1/stage2 instead of picking a minimal set from both in
> __iommu_calculate_sagaw().

That's better. The agaw could be picked according to which stage the
domain is used for translation.

Best regards,
baolu
