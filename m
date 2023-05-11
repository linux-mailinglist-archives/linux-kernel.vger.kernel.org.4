Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4F6FF19B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjEKMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjEKMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:34:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91D9F5265
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:34:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A01F1063;
        Thu, 11 May 2023 05:34:49 -0700 (PDT)
Received: from [10.57.83.77] (unknown [10.57.83.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D2DF3F5A1;
        Thu, 11 May 2023 05:34:03 -0700 (PDT)
Message-ID: <5deb8a32-7f49-06ed-2275-721b93bbfb9b@arm.com>
Date:   Thu, 11 May 2023 13:33:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1 0/5] Add PASID support to SMMUv3 unmanaged domains
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        jean-philippe@linaro.org, nicolinc@nvidia.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230510205054.2667898-1-mshavit@google.com>
 <ZFwIWz8kBL+bti1m@nvidia.com>
 <CAKHBV26rbPXr6QUAx1MSbX58Zr4B7iLhojOgfn9c0tc1wKaP+w@mail.gmail.com>
 <ZFxwEYPn74Tivcrb@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZFxwEYPn74Tivcrb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-11 05:33, Jason Gunthorpe wrote:
> On Thu, May 11, 2023 at 11:52:41AM +0800, Michael Shavit wrote:
>>> Logically when an iommu_domain is attached to a device or a PASID a
>>> STE or CD is generated from the iommu_domain's configuration but the
>>> iommu_domain doesn't "hold" it
>>>
>>
>> Ah yes, I was using iommu domain and arm_smmu_domain interchangeably
>> here since there's a 1:1 mapping between the two. In the current
>> smmuv3 implementation, arm_smmu_domain holds the s1cfg structure which
>> represents the s1 portion of an STE.
> 
> I mean to include the arm_smmu_domain too..
> 
> Generally this sort of seemed OK in the code, I just wouldn't use the
> word 'hold' - the iommu_domain may cache a computed STE or CD value
> but that the actual steering or context tables are held else where
> 
> ie you insert an iommu_domain into a steering or context table, it
> does not 'hold' a table entry.
> 
>> specific to SVA about this behavior however, SVA will do the same
>> amount of work whether the cd table is owned by some special iommu
>> domain or by the arm_smmu_master (since we require that special iommu
>> domain be attached to the master and disallow detaching it).
> 
> The CD table for SVA definately should not be part of an iommu_domain,
> moving it to the master seems reasonable.
>   
>> Gotcha. So this patch series should be less aggressive, but is
>> probably still workable with the nested domain patch series:
>> 1. For (stage 1) unmanaged/dma and sva domains, arm_smmu_domains
>> should hold a single CD. For the nested domain series, arm_smmu_domain
>> can alternatively hold an entire s1cfg.
> 
> These are just pre computed values the can help when inserting the
> iommu_domain into a steering or CD table

Right, a stage 1 domain still logically owns the *contents* of a 
corresponding CD, however in this design it can no longer own a physical 
CD structure, because now every device attached to the same domain must 
maintain its own distinct copy.

>> 2. arm_smmu_master should own an s1cfg (which holds a cdtable) that is
>> used by unmanaged/dma and sva domains attached to this master.
> 
> The arm_smmu_master's cd table can be inserted into a steering table

Not sure what you mean there... STE.S1ContextPtr is essentially just a 
pointer to an array of CD structures (which only contains 1 element when 
PASIDs aren't enabled), so every master must own its own CD table 
directly. There is no viable indirection if you want the abstraction to 
bear any relation to reality.

>> 3. arm_smmu_master also holds a pointer to the live s1cfg, which may
>> either points to its owned s1cfg, or the nested domain's s1cfg, or
>> null (bypass or stage2)
> 
> The steering table either points to the CD table owned by the
> arm_smmu_master, a S1 domain held by an iommu_domain, or a S1 & CD
> table owned by userspace represented by a special nested iommu_domain
> and its internal parent.
> 
> If a kernel owned S2 it attached then the S1 points at the CD table
> owned by the arm_smmu_master and the CD table points to the S2, same
> as if there was PASID (IIRC, from memory I don't have the spec here
> right now)

Nope, CDs *only* represent stage 1 domains, stage 2 configuration is a 
property of the STE, i.e. is directly connected to the arm_smmu_master.

Thanks,
Robin.
