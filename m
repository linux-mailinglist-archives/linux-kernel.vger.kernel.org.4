Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B863A5B6A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiIMJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiIMJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:25:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA1515731
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663061105; x=1694597105;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ez00WRCiSdwFGFwuR0Sn/KBDwI3PBPAvuJrBf1JZWn8=;
  b=EovcdeKPYkhfksCWXsQtgeb4mBniHKcS/JD8O9QYbEKGNIX45hyswScy
   Kcyi+R9Ti3ZEdo+RP7CNMh77FPtM2ri7MANliwqdPEaEgTaMVyvS572n1
   XW0kpTZl0i1spNFvOJuJvg0XjhUbAPvQK1C5zzkgTemnb6VkkCdWS62eh
   hXuZK9MP0V+prIag07sz/p3MVP64SZwoL6K0LsHKiqijVPugFrQ7usrLa
   HHr+GtuK3eghfqMu26zXHDfYhXKz8alzYGFrMYRAK/UaHI2FcTP5+OwQE
   q5xSHACjJyKDVgTZeWixxUkeq85chHfeQgZ05WCdBcL+wJ9oik+2WVKbJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="278484148"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="278484148"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:25:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="646854593"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 02:25:02 -0700
Message-ID: <826a10fa-7dc3-887d-8a08-e03dcf1fa59c@linux.intel.com>
Date:   Tue, 13 Sep 2022 17:25:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52766A868879689D55AE9DC68C479@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <BN9PR11MB52766A868879689D55AE9DC68C479@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/13 16:01, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, September 12, 2022 10:48 AM
>>
>> @@ -1401,7 +1403,6 @@ static void iommu_enable_dev_iotlb(struct
>> device_domain_info *info)
> 
> This is not the right name now as dev_iotlb is only related to ATS.

Yes. This name is confusing. Perhaps we can split it into some specific
helpers,

- intel_iommu_enable_pci_ats()
- intel_iommu_enabel_pci_pri()
- intel_iommu_enable_pci_pasid()
?

> 
>>   		info->pfsid = pci_dev_id(pf_pdev);
>>   	}
>>
>> -#ifdef CONFIG_INTEL_IOMMU_SVM
>>   	/* The PCIe spec, in its wisdom, declares that the behaviour of
>>   	   the device if you enable PASID support after ATS support is
>>   	   undefined. So always enable PASID support on devices which
>> @@ -1414,7 +1415,7 @@ static void iommu_enable_dev_iotlb(struct
>> device_domain_info *info)
>>   	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)
>> &&
>>   	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
>>   		info->pri_enabled = 1;
>> -#endif
>> +
>>   	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>   		info->ats_enabled = 1;
> 
> iommu_enable_dev_iotlb() is currently called both when the device is probed
> and when sva is enabled (which is actually useless). From this angle the commit
> msg is inaccurate.

The logic is a bit tricky. iommu_support_dev_iotlb() only returns a
devinfo pointer when ATS is supported on the device. So, you are right
if device supports both ATS and PASID; otherwise PASID will not be
enabled.

> 
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index 39a06d245f12..b3f40375f214 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -21,6 +21,8 @@ config INTEL_IOMMU
>>   	select IOASID
>>   	select IOMMU_DMA
>>   	select PCI_ATS
>> +	select PCI_PRI
>> +	select PCI_PASID
>>   	help
>>   	  DMA remapping (DMAR) devices support enables independent
>> address
>>   	  translations for Direct Memory Access (DMA) from devices.
>> @@ -48,8 +50,6 @@ config INTEL_IOMMU_DEBUGFS
>>   config INTEL_IOMMU_SVM
>>   	bool "Support for Shared Virtual Memory with Intel IOMMU"
>>   	depends on X86_64
>> -	select PCI_PASID
>> -	select PCI_PRI
>>   	select MMU_NOTIFIER
>>   	select IOASID
> 
> this is already selected by CONFIG_INTEL_IOMMU

Yes. Should be removed.

> 
>>   	select IOMMU_SVA
>> --
>> 2.25.1
> 
> 

Best regards,
baolu
