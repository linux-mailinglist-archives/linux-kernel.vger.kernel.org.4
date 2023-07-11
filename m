Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62974E46A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGKCnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGKCnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:43:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD6188
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689043431; x=1720579431;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=upCvkfXEz663AS6MYxFBimuj/g5n8nrt9QG6bA5tcMw=;
  b=g5oQiqapLt0caldkYNKd8lYx1USiSQgolZEmKcKXXa9mhWZMTQspWcG8
   WZXmEGhvjgHCuM8mQSSyL1jwxjqtSQKUwadxv20IiBHUk8G2GW7ZG8mcO
   AxFwslzbl71QsH+co3i6NsBQhR1JA0ULNpa/gU3r9Ci7lbeP5iejqVt3S
   009ROkXGrSkmVBLvqxXH+QwcKe1pJ/+mfzW/9Di9X0AgSB++Q4RfikTmK
   vDPzfKnB401hUeP3LRdOsPzZv7G2ZP2/+GzscWznOzUxZ2URuCJlG3sQr
   Nkc5Vg064SHKhIqxwbRR3iBCYzyuJE4MshPN5+Iz7LWIXUzGJTVNa0M2K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="428203566"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="428203566"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865596218"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="865596218"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.35]) ([10.252.187.35])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 19:43:47 -0700
Message-ID: <6e88db76-6903-cb7b-b608-811a97986592@linux.intel.com>
Date:   Tue, 11 Jul 2023 10:43:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] iommu: Support mm PASID 1:1 with sva domain
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>
References: <20230707013441.365583-1-tina.zhang@intel.com>
 <20230707013441.365583-6-tina.zhang@intel.com> <ZKw/xS7wOoRvNfnH@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZKw/xS7wOoRvNfnH@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 1:28, Jason Gunthorpe wrote:
>> @@ -88,31 +98,41 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   		goto out_unlock;
>>   	}
>>   
>> -	if (domain) {
>> -		domain->users++;
>> -		goto out;
>> +	if (unlikely(domain)) {
>> +		/* Re-attach the device to the same domain? */
>> +		if (domain == sva_domain) {
>> +			goto out;
>> +		} else {
>> +			/* Didn't get detached from the previous domain? */
>> +			ret = -EBUSY;
>> +			goto out_unlock;
>> +		}
>>   	}
> And if we do all of this we should just get rid of the horrible
> iommu_get_domain_for_dev_pasid() entirely.

At the core level, we have no idea about whether an sva domain allocated
for one device is compatible with another device. Hence, we should loop
the sva domains in the list and if the attach interface feeds back
-EINVAL's (not compatible), we should allocate a new domain for the
attached device and put it in the list if the new attachment is
successful.

Perhaps I'm too worried?

Best regards,
baolu
