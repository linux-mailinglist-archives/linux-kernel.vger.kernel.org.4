Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0356D979E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbjDFNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjDFNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:08:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BA25191
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:08:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0348916F8;
        Thu,  6 Apr 2023 06:08:55 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33B63F73F;
        Thu,  6 Apr 2023 06:08:09 -0700 (PDT)
Message-ID: <342f729a-c48e-3cc2-d639-3cdb0ebb3e83@arm.com>
Date:   Thu, 6 Apr 2023 14:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] iommu: amd: Set page size bitmap during V2 domain
 allocation
Content-Language: en-GB
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
References: <20230404072742.1895252-1-jsnitsel@redhat.com>
 <k6cz5w66mfse7ztgtfy6ux4bjasg64dhbjnliybybcvmoywrs3@gehaolzeh3ph>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <k6cz5w66mfse7ztgtfy6ux4bjasg64dhbjnliybybcvmoywrs3@gehaolzeh3ph>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 5:28 pm, Jerry Snitselaar wrote:
> On Tue, Apr 04, 2023 at 12:27:42AM -0700, Jerry Snitselaar wrote:
>> With the addition of the V2 page table support, the domain page size
>> bitmap needs to be set prior to iommu core setting up direct mappings
>> for reserved regions. When reserved regions are mapped, if this is not
>> done, it will be looking at the V1 page size bitmap when determining
>> the page size to use in iommu_pgsize(). When it gets into the actual
>> amd mapping code, a check of see if the page size is supported can
>> fail, because at that point it is checking it against the V2 page size
>> bitmap which only supports 4K, 2M, and 1G.
>>
>> Add a check to __iommu_domain_alloc() to not override the
>> bitmap if it was already set by the iommu ops domain_alloc() code path.
>>
>> Cc: Vasant Hegde <vasant.hegde@amd.com>
>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Fixes: 4db6c41f0946 ("iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API")
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> 
> 
> I'm still not sure this is the best solution. Feels odd with adding a
> check to core code to handle something one of the drivers has
> done. Another thought was something like arm does, with amd_iommu_ops
> dropping the const and setting the default page size bitmap in
> iommu_init_pci(), but I think that would still require adding
> something in the protection domain/init code to deal with it forcing
> v1, so it would still require a check in the core code.
> 
> Would adding an op make more sense, with a generic op doing what the
> core code currently does for setting the default? Or am I overthinking
> this?

I think this is fine as-is. TBH it's probably high time 
ops->pgsize_bitmap finished going away entirely - as the Arm SMMU bodges 
prove, it's no longer a good fit for the multi-instance model which 
we've evolved, and for the sake of only this one assignment now, it 
really doesn't seem worthwhile any more. Since I'm still reworking 
domain_alloc, and already have plans to clean up the horrible 
default_domain_ops thing (honestly, what possessed me to think that was 
a good idea at the time!?), I can throw pgsize_bitmap in there as well.

Cheers,
Robin.

> 
> snits
> 
>> ---
>>   drivers/iommu/amd/iommu.c | 6 ++----
>>   drivers/iommu/iommu.c     | 9 +++++++--
>>   2 files changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 5a505ba5467e..167da5b1a5e3 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1666,10 +1666,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
>>   	domain->dev_iommu[iommu->index] += 1;
>>   	domain->dev_cnt                 += 1;
>>   
>> -	/* Override supported page sizes */
>> -	if (domain->flags & PD_GIOV_MASK)
>> -		domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>> -
>>   	/* Update device table */
>>   	set_dte_entry(iommu, dev_data->devid, domain,
>>   		      ats, dev_data->iommu_v2);
>> @@ -2048,6 +2044,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>>   
>>   	domain->flags |= PD_GIOV_MASK;
>>   
>> +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>> +
>>   	if (domain_enable_v2(domain, 1)) {
>>   		domain_id_free(domain->id);
>>   		return -ENOMEM;
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 10db680acaed..256a38371120 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>   		return NULL;
>>   
>>   	domain->type = type;
>> -	/* Assume all sizes by default; the driver may override this later */
>> -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>> +	/*
>> +	 * If not already set, assume all sizes by default; the driver
>> +	 * may override this later
>> +	 */
>> +	if (!domain->pgsize_bitmap)
>> +		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
>> +
>>   	if (!domain->ops)
>>   		domain->ops = bus->iommu_ops->default_domain_ops;
>>   
>> -- 
>> 2.38.1
>>
> 
