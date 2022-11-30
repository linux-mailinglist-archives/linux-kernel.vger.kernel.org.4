Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB963CCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiK3B3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiK3B3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:29:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE15F46;
        Tue, 29 Nov 2022 17:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669771735; x=1701307735;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FiqAFQXIvz60hbT0xq79nRbGcPgH1YTtz35ZXjIbxDA=;
  b=mCaoWbEZpnUM4dRevpzpb7M1p9aCtDu3QlnCGwTcuyqdC9qp+iwSZVRY
   UqB2+bMOuB1BQa7mMh8BaF8nmEaOmuIB1m+6of7nIHH1fXYRPk0PMBMxp
   TzVk5AN4Geq6ibfmWT/LDvACzwzAJQTI9uBT2GlM+Ty8CKQs/BaHU+uur
   OsBV/zifJDA/R5QABx/aw6lQpr4iIzSipGrug9Oa1KZ0LLiXKa8uOYYSg
   YWPF07lVX0Wa9LSp7dOKV4aWunRZQalCATT37eZz64LH1BdoyeNrP4pbj
   rQR0pRFMNHZ8Z3ADgp6VCJ3sZZvCY5RN3tgYVlWAqt8Y28+6lLovJXriv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="377434702"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="377434702"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 17:28:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768645885"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="768645885"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.199]) ([10.254.210.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 17:28:49 -0800
Message-ID: <ca0d8de0-a881-0ccb-75fb-2530428f2c3e@linux.intel.com>
Date:   Wed, 30 Nov 2022 09:28:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     baolu.lu@linux.intel.com, Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com> <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com> <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
 <Y4Zm53o1ovdIAqr/@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y4Zm53o1ovdIAqr/@nvidia.com>
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

On 2022/11/30 4:09, Jason Gunthorpe wrote:
> On Tue, Nov 29, 2022 at 06:41:22PM +0000, Robin Murphy wrote:
>> On 2022-11-29 17:33, Jason Gunthorpe wrote:
>>> On Mon, Nov 28, 2022 at 09:01:43PM +0000, Robin Murphy wrote:
>>>
>>>> I'm hardly an advocate for trying to save users from themselves, but I
>>>> honestly can't see any justifiable reason for not having sysfs respect
>>>> iommu_get_def_domain_type().
>>>
>>> We really need to rename this value if it is not actually just an
>>> advisory "default" but a functional requirement ..
>>
>> It represents a required default domain type. As in, the type for the
>> device's default domain. Not the default type for a domain. It's the
>> iommu_def_domain_type variable that holds the *default* default domain type
>> ;)
> 
> I find the name "default domain" incredibly confusing at this point in
> time.
> 
> I would like to call that the "dma-api domain" - its primary purpose
> is to be the domain that the DMA API uses to operate the IOMMU, there
> is little "default" about it. This meshes better with our apis talking
> about ownership and so forth.
> 
> So, if the op was called
>    get_dma_api_domain_type()
> 
> It is pretty clear that it is the exact type of domain that should be
> created to support the DMA API, which is what I think you have been
> describing it is supposed to do?
> 
> And with Lu's series we have the set_platform_dma() (Lu perhaps you
> should call this set_platform_dma_api() to re-enforce it is about the
> DMA API, not some nebulous DMA thing)

Sure thing. It's more specific.

> 
> Which is basically the other way to configure the DMA API for
> operation.
> 
> And encapsulating more of the logic to setup and manage the DMA API's
> domain into dma-iommu.c would also be helpful to understanding.
> 
>> Which reminds me I should finish that patch undoing my terrible
>> ops->default_domain_ops idea, not least because they are misleadingly
>> unrelated to default domains...
> 
> :)
> 
>>> It is close to being clear, once we get the last touches of dma-iommu
>>> stuff out of the drivers it should be quite clear
>>
>> Cool, some upheaval of .domain_alloc is next on my hitlist anyway, so that
>> might be a good excuse to upheave it a bit more and streamline the type
>> stuff along the way.
> 
> Yes, I think so. I want to tidy things a bit so adding this "user
> space" domain concept is a little nicer
> 
> Jason
> 

--
Best regards,
baolu
