Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362495BA50B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIPDHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiIPDHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:07:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1949FAA6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663297552; x=1694833552;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AA4yM8sBHYK6jyGEDMWq+oJQ1iHOxkryKHMct2cC2aU=;
  b=UFWKlLtP0dGWYCDaNUwdOGfrH4NyWJ3Q/8PI7TQC6woLy3HoZjVIUhRX
   s75yZEneubM29suvRP5CAc23Y3gtMS/PrRlhVZ7AqBHLkhxtMDqQw2IU9
   9OI/l8GtkYK7yA3L25Z5Vcqrnvcpa2xjrZ0J9fuh7Jw6yOV/j3ntipnjI
   0QRPssQBKPRVlsZgNQz5ObntAeBOxEB6jjQWpYhEOANnkgzoRWvGVEhHo
   bTZLjcPZDPG1j6YC9AxEBTr2zfUryHNg80Pb8+uFcdilmfxmcNaJWwSPx
   SVINGnHxS24QeInC6fR+gLOO2elP5OCVuZsUq4vzDy3THfT6h+/hG3n0h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="281926880"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="281926880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:05:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="613120043"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.216]) ([10.254.214.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:05:49 -0700
Message-ID: <fc1f5412-6041-71b8-2a87-84f2f32456fc@linux.intel.com>
Date:   Fri, 16 Sep 2022 11:05:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
 <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
 <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
 <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
 <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
In-Reply-To: <78ec0fab-6f69-1d3d-86f3-84f159817707@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/16 10:40, Ethan Zhao wrote:
>>
>> I may not get you exactly. 😄 Some IOMMU features reply on PASID
>> capabilities on both IOMMU and device. The IOMMU drivers enumerate the
>> capabilities and enable them if they are supported.
> I might not express it straightforward,  I mean with this patch iommu 
> deals with
> 
> the complexity of enabling PASID (globally?)  or not at probing stage , 
> instead
> 
> of other device driver side decision to request IOMMU PASID enabling during
> 
> their setup state.  if so you move the decision to iommu probe stage. 
> hmmm...

I am sorry that the commit message was a bit confusing. Actually we
always enable PASID at iommu probe path w/ or w/o this patch.

> 
> Pros,  iommu driver controls everything about PASID enabling.
> 
> Cons,  iommu driver handles all possible complexity about capability 
> matching

Do device drivers need to configure PCI PASID without IOMMU? I searched
the tree and found nothing.

Best regards,
baolu
