Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D665B9522
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIOHVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIOHVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:21:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884E08A1DD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663226502; x=1694762502;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cs0ARHqTg/sLxBqGoBiCU8P4JJO3ea/6zqkCpGynC1g=;
  b=WPMEk0qQ4vx9Mzh7y+pY6kqHM94TvaJdDsI38M8K94Lzs3eQzXN+Pk84
   P9+646jClRXnCNxc9CUPz7GOUYw9DFKE1MYAeX69o9w3qjJXHvjlDQSi+
   mHMSwk0x5sQiuaJ7/UFJKbsHmpSK10HIYnDq3t45U9ILKRIOEta9DUuBg
   hRVrQGM3M7RCk+momnXQKSLC2ErQFO2mRcUzr5kNZJu182t1UoP/XFOIp
   S8ZPFGxT945z2OYl6PsjqBj65yVRzRYkCUorpScV1h6QFY9DAV8IoMyVE
   XEa7N0g5w7yURsPkrzGEqvtOnU9f8tIMvGIUJWl4mi36rGOYSreWFJphf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="384929649"
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="384929649"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:21:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="568322212"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.238]) ([10.254.208.238])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 00:21:20 -0700
Message-ID: <78da3b7e-c930-f433-8c80-b1ac53f9ab58@linux.intel.com>
Date:   Thu, 15 Sep 2022 15:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52766A868879689D55AE9DC68C479@BN9PR11MB5276.namprd11.prod.outlook.com>
 <826a10fa-7dc3-887d-8a08-e03dcf1fa59c@linux.intel.com>
 <BN9PR11MB527688C87CEA57CACD5324608C499@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527688C87CEA57CACD5324608C499@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 11:22, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, September 13, 2022 5:25 PM
>>
>> On 2022/9/13 16:01, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, September 12, 2022 10:48 AM
>>>>
>>>> @@ -1401,7 +1403,6 @@ static void iommu_enable_dev_iotlb(struct
>>>> device_domain_info *info)
>>>
>>> This is not the right name now as dev_iotlb is only related to ATS.
>>
>> Yes. This name is confusing. Perhaps we can split it into some specific
>> helpers,
>>
>> - intel_iommu_enable_pci_ats()
>> - intel_iommu_enabel_pci_pri()
>> - intel_iommu_enable_pci_pasid()
>> ?
> 
> Probably intel_iommu_enable_pci_caps()

It's better.

> 
>>
>>>
>>>>    		info->pfsid = pci_dev_id(pf_pdev);
>>>>    	}
>>>>
>>>> -#ifdef CONFIG_INTEL_IOMMU_SVM
>>>>    	/* The PCIe spec, in its wisdom, declares that the behaviour of
>>>>    	   the device if you enable PASID support after ATS support is
>>>>    	   undefined. So always enable PASID support on devices which
>>>> @@ -1414,7 +1415,7 @@ static void iommu_enable_dev_iotlb(struct
>>>> device_domain_info *info)
>>>>    	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)
>>>> &&
>>>>    	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
>>>>    		info->pri_enabled = 1;
>>>> -#endif
>>>> +
>>>>    	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>>>    	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>>>    		info->ats_enabled = 1;
>>>
>>> iommu_enable_dev_iotlb() is currently called both when the device is
>> probed
>>> and when sva is enabled (which is actually useless). From this angle the
>> commit
>>> msg is inaccurate.
>>
>> The logic is a bit tricky. iommu_support_dev_iotlb() only returns a
>> devinfo pointer when ATS is supported on the device. So, you are right
>> if device supports both ATS and PASID; otherwise PASID will not be
>> enabled.
> 
> Yes, that is what the first part of this patch fixes.
> 
> But my point is about the message that previously PASID was enabled
> only when FEAT_SVA is enabled and now the patch moves it to the
> probe time.
> 
> My point is that even in old way iommu_enable_dev_iotlb() was called
> twice: one at probe time and the other at FEAT_SVA. If ATS exists
> then PASID is enabled at probe time already. If ATS doesn't exist then
> PASID is always disabled.
> 
> So this patch is really to decouple PASID enabling from ATS and remove
> the unnecessary/duplicated call of iommu_enable_dev_iotlb() in
> intel_iommu_enable_sva().

Yes. Exactly. I will rephrase the commit message and send a v2.

Best regards,
baolu
