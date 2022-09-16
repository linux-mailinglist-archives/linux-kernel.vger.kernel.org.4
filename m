Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7012E5BA57A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIPDi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIPDiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:38:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED69E0C6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299487; x=1694835487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UFG3h8qBUR0wYyU/7VlGNPZV1M3+dh/oZIaW4CDXEwo=;
  b=UvpRpJJguvTSfauApa6zQvxz3lhl5f+Hz0FhwyGDEn3Z2xaoPrTj7aDN
   5xzw6pHuHjfULv4sD/rA7WEB6jPPnjJc52M2FEfItY75+yrTje+ZCEqge
   7NOE8RTOmYZDWg4LNHXqmG/gyJnhh3BYLhNHcgtG++JeNOZox7o91IHYw
   MUWFiAOR6V6+gnqSYmmoyQI2DvxdfPqkHTYxgT9rR2H8kcewO6ieJ8Qx9
   jvEyWVkH7NWECgPblxoFxghN3OoV4xztffffYaQ8ucSqXjmb8hpgaXJ8X
   rU6sAc2G7ox+Aq+atjUAlbGLXCevdqnJhCs1Kcz1zWwYpvBHgAWM+p1Nx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="300264507"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="300264507"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:38:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="685987793"
Received: from yingjieh-mobl.ccr.corp.intel.com (HELO [10.254.215.99]) ([10.254.215.99])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:37:56 -0700
Message-ID: <27483599-d0fd-ce07-1a14-c6d68e6d364f@linux.intel.com>
Date:   Fri, 16 Sep 2022 11:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
To:     Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
 <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
 <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
 <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
 <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
 <fc1f5412-6041-71b8-2a87-84f2f32456fc@linux.intel.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <fc1f5412-6041-71b8-2a87-84f2f32456fc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/16 11:05, Baolu Lu 写道:
> On 2022/9/16 10:40, Ethan Zhao wrote:
>>>
>>> I may not get you exactly. 😄 Some IOMMU features reply on PASID
>>> capabilities on both IOMMU and device. The IOMMU drivers enumerate the
>>> capabilities and enable them if they are supported.
>> I might not express it straightforward,  I mean with this patch iommu 
>> deals with
>>
>> the complexity of enabling PASID (globally?)  or not at probing stage 
>> , instead
>>
>> of other device driver side decision to request IOMMU PASID enabling 
>> during
>>
>> their setup state.  if so you move the decision to iommu probe stage. 
>> hmmm...
>
> I am sorry that the commit message was a bit confusing. Actually we
> always enable PASID at iommu probe path w/ or w/o this patch.
>
Really ?  the commit message is quit clear to me ~~@
>>
>> Pros,  iommu driver controls everything about PASID enabling.
>>
>> Cons,  iommu driver handles all possible complexity about capability 
>> matching
>
> Do device drivers need to configure PCI PASID without IOMMU? I searched
> the tree and found nothing.

Device knows if it has PCI PASID cap and its driver also could determine 
to request

iommu to enable PASID or not by invoking

intel_iommu_enable_sva()->*intel_iommu_enable_pasid()*

*that is the old style without this patch.
*

*Iommu driver of course  also knows if devices in its group related the 
iommu
*

*have PASID cap support or not by enumerating them from the ACPI DMAR.
*

This is my understanding, correct me if wrong.

While configuring device PCI PASID cap is another thing, from kernel or 
userland,

compatible with the iommu cap, works, or not work.  Could you prevent anyone

from doing that ?


Thanks,

Ethan
>
> Best regards,
> baolu

-- 
"firm, enduring, strong, and long-lived"

