Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7005A5B92E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiIODGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiIODGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:06:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638738FD6A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663211170; x=1694747170;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WZZZSPl+QBxBcZfZhpMsL4YrZVmhzfuac91HSUV9DNc=;
  b=lVNJmtmtKwtz87aNa3UVPDFODWEekkx6wwHtEkhtA1BGTxE4yYeoz07m
   H4AQOSMkjHvrRBU+dt52x+yPtFt15C6xYQ4Qx5EurL9W+yKODOqMgelHg
   FvNymlEPEjx7IfeQZeNclTjuPdCObj0/sZUCOX+1djM5huMhDlkzows1X
   zeKkd74GI7AjyqiM9elILn3u5JaZOTKD1QYBET7zkCHI37y2KzNg1ynY2
   WPNuUN46hinHNqk59lWgfjOPfnL5TvxCiMOdexBc6n6nH1ITPL4nCzNoU
   q4i9e0FVDNzTshUDxI86EJB4VYCzLFkkDTMk1aqL3VGlzkkdnDCyUhXZu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="297325857"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="297325857"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="759453213"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2022 20:06:08 -0700
Message-ID: <5415d383-5442-a127-bdab-fce9e9b7a3b2@linux.intel.com>
Date:   Thu, 15 Sep 2022 11:00:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
Content-Language: en-US
To:     Ethan Zhao <haifeng.zhao@linux.intel.com>, iommu@lists.linux.dev
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
 <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
 <e0c43ca7-0ad3-a4d6-960b-9853bb815438@linux.intel.com>
 <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e26efaee-d84a-3b60-8400-90d8e49a9b25@linux.intel.com>
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



On 9/14/22 4:59 PM, Ethan Zhao wrote:
>>> What the error path would be if this code runs on some old platforms 
>>> don't
>>>
>>> support PASID, would you print out "this platform doesn't suppor 
>>> PASID" and
>>>
>>> give users an interface function to query if the PASID cap of iommu 
>>> is enabled
>>>
>>> and if not why ?
>>
>> It's not an error case if the IOMMU doesn't support PASID. But it's an
>> error case if any device drivers call PASID related IOMMU interfaces
>> (for example, iommu_domain_attach/detach_dev_pasid()). The corresponding
>> error code will be returned to the drivers.
>>
> So iommu driver withdraws the flexibility/rights from device driver 
> about the
> 
> ability to enable PASID, looks much more *integrated* iommu works as 
> relation

No. This patch doesn't withdraw anything. It's just a code refactoring.

> 
> controller in device-iommu-domain by enabling PASID in iommu probe stage
> 
> by default -- iommu decides to enable PASID or not though device-iommu-
> 
> domain might not work ? or they should work because they are hard-wired
> 
> together (device - iommu) even device is hotpluged later.
> 

I may not get you exactly. :-) Some IOMMU features reply on PASID
capabilities on both IOMMU and device. The IOMMU drivers enumerate the
capabilities and enable them if they are supported.

Best regards,
baolu
