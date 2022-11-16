Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A742A62BD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbiKPMOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiKPMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:13:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B464B988
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668600516; x=1700136516;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ROaSIFRIO9vsgedLMOHZiWNscCfhR6myclt50kra5OA=;
  b=KPy2rWqd4O1LmiWl9mBiBF9TRq8mbaKavx53RWUvI6MeFwkD6K8JwJyr
   B9IQkhe5wEmUyo0cqE1upZ6G8aHQeGdUeKqm5nTUgaxSinp7OveVDk61+
   ao3izyzF110JEFQPIHHG+iOgFnDgsTUZnjxeBIwWoiI3XzNKp/xd/7E8A
   9EPNI+kImRxO4aIfc+oiTdY1bgpVFlAmDZ1/dt9fixY06Q+BeyiZSEYBi
   r0mVwBzhUD/U4hZiTaMGLZk4p/Z8KuAAA+WqaRBCy5bOOQ0VtUbl53uhb
   wJ+hyYUIt89TDm1T6mMPxrBYLoPFNGsGBTAFNJK8+ot3gljUW/lLaS37E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312534528"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312534528"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:08:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641620162"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641620162"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.114]) ([10.254.212.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:08:33 -0800
Message-ID: <b2fba491-2196-bd6a-d6ef-4029a04a97e6@linux.intel.com>
Date:   Wed, 16 Nov 2022 20:08:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into
 its caller
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-5-baolu.lu@linux.intel.com>
 <BN9PR11MB527668E6C7666CAA5F0804428C079@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e7c686d7-bad9-b58b-3be4-50898e142230@linux.intel.com>
 <BL1PR11MB5271F0D4E91A3F6179216ADA8C079@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ebace32b-be36-5c9f-579b-211cad75df02@linux.intel.com>
 <BN9PR11MB5276DEEEA205B267192FC01B8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276DEEEA205B267192FC01B8C079@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/16 17:15, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, November 16, 2022 4:03 PM
>>
>> On 2022/11/16 13:35, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, November 16, 2022 12:36 PM
>>>>
>>>> On 11/16/22 11:53 AM, Tian, Kevin wrote:
>>>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>>>> Sent: Monday, November 14, 2022 9:41 AM
>>>>>> @@ -4562,7 +4538,10 @@ static void
>> intel_iommu_release_device(struct
>>>>>> device *dev)
>>>>>>     {
>>>>>>     	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>>>>
>>>>>> -	dmar_remove_one_dev_info(dev);
>>>>>> +	iommu_disable_pci_caps(info);
>>>>>> +	domain_context_clear(info);
>>>>>> +	device_block_translation(dev);
>>>>> clear context after blocking translation.
>>>> Unfortunately domain_context_clear() needs reference to info->domain
>>>> (for domain id when flushing cache), which is cleared in
>>>> device_block_translation().
>>>>
>>> this sounds an ordering problem. clearing context should be after
>>> blocking translation in concept.
>>
>> At present, when the default domain is attached to the device, we first
>> populate the pasid table entry, and then populate the device context
>> entry. Above code is just the reverse operation.
>>
>> Can you see any practical problems caused by this sequence? If so, it
>> seems that we should carefully consider whether such problems already
>> exist.
>>
> 
> there is no problem with existing code. Just after this patch the order
> looks weird based on the literal name of those functions.
> 
> domain_context_clear() is a big hammer to disable the context entry,
> implying translation must be blocked. Then calling another block
> translation afterwards becomes unnecessary.
> 
> Probably it should be split into two functions with one requiring
> info->domain called before block translation and the rest which
> actually clears the context entry being the last step?

This is what the existing code does. Perhaps I should drop this patch,
or only rename iommu_disable_dev_iotlb() to iommu_disable_pci_caps().

Best regards,
baolu
