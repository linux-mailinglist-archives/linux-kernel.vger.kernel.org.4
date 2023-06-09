Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6511B728D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbjFIBpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbjFIBpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:45:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5D319D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686275114; x=1717811114;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e61UV5SvMM3vHP5TViMCNaMJKnEqTUpRfgGhvY+y4Ak=;
  b=NNno06G+4iM2xQLpeT/uc4xiBYUSPJXlYskSV3cd76ZkhfdvIaSLfOaf
   vSsb6Yschqi7IclvNt+C+e8eAx6CsMQsjB8MM1INcpFK0ng1KSL2p9M8a
   u8ybWKYKMXOmBqZMaFnjx5uwdUs1oZ3piQkBwNsPBQjdWSpdWjA4u2/5R
   pvMkgK7lY845inlT8gNqqO4gNlgjmddWRoUCZPCee4sif5tEtKQH/8BfR
   5WlVyWBC2GLEXgICGcMwmJkbSNh8L6dQujdSXYd5rZwEBkafCpO10iH/k
   PhkJD0UkMxbZrvWkxPWzQBV3ryffXk79KPTzaT8MlMVWO+cxTiQPY+1Er
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423364536"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="423364536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 18:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="854566570"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="854566570"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2023 18:45:11 -0700
Message-ID: <081931a1-204a-8126-5b75-22d35dedef8d@linux.intel.com>
Date:   Fri, 9 Jun 2023 09:44:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Michael Shavit <mshavit@google.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared
 CDs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230606120854.4170244-1-mshavit@google.com>
 <20230606120854.4170244-15-mshavit@google.com> <ZH9oQMmI8CezMCnx@nvidia.com>
 <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
 <f0a691fa-d050-f457-9c8d-0ae340eab58f@linux.intel.com>
 <ZIHaEFJFVQqvJvmU@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZIHaEFJFVQqvJvmU@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 9:39 PM, Jason Gunthorpe wrote:
> On Thu, Jun 08, 2023 at 10:39:23AM +0800, Baolu Lu wrote:
>> On 6/7/23 7:59 PM, Jason Gunthorpe wrote:
>>> On Wed, Jun 07, 2023 at 12:06:07AM +0530, Michael Shavit wrote:
>>>>> What we definately shouldn't do is try to have different SVA
>>>>> iommu_domain's pointing at the same ASID. That is again making SVA
>>>>> special, which we are trying to get away from 😄
>>>> Fwiw, this change is preserving the status-quo in that regard;
>>>> arm-smmu-v3-sva.c is already doing this. But yes, I agree that
>>>> resolving the limitation is a better long term solution... and
>>>> something I can try to look at further.
>>> I suppose we also don't really have a entirely clear picture what
>>> allocating multiple SVA domains should even do in the iommu driver.
>>>
>>> The driver would like to share the ASID, but things are much cleaner
>>> for everything if the driver model has ASID 1:1 with the iommu_domain.
>> This means that each ASID should be mapped to a single IOMMU domain.
>> This is conceptually right as iommu_domain represents a hardware page
>> table. For SVA, it's an mm_struct.
>>
>> So in my mind, each sva_domain should have a 1:1 relationship with an
>> mm_struct.
> If we want to support multiple iommu drivers then we should support
> multiple iommu_domains per mm_struct so that each driver can have its
> own. In this world if each instance wants its own iommu_domain it is
> not a big deal.
> 
> Drivers that can share iommu_domains across instances should probably
> also share sva iommu_domains across instances.
> 
> Most real systems have only one iommu driver and we'd like the good
> iommu drivers to be able to share domains across instances, so we'd
> expect only 1 iommu_domain per mm struct.

Yes. You are right. I overlooked the multiple-drivers case. So we stay
on the same page now.

Best regards,
baolu
