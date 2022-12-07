Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AADF645C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLGOS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLGOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:18:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67A3355CB6;
        Wed,  7 Dec 2022 06:18:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0B723A;
        Wed,  7 Dec 2022 06:18:50 -0800 (PST)
Received: from [10.57.74.110] (unknown [10.57.74.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D7F23F73D;
        Wed,  7 Dec 2022 06:18:40 -0800 (PST)
Message-ID: <73a033d6-c1fe-c012-4648-774aa5b93a61@arm.com>
Date:   Wed, 7 Dec 2022 14:18:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
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
References: <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com> <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com> <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
 <Y4Zm53o1ovdIAqr/@nvidia.com>
 <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
 <Y4/LsZKmR3iWFphU@nvidia.com>
 <f9433a12-eacd-9e6b-a517-c3be438193d1@linux.intel.com>
 <Y5CT4BBO9hsmjJfD@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y5CT4BBO9hsmjJfD@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-07 13:23, Jason Gunthorpe wrote:
> On Wed, Dec 07, 2022 at 09:18:19PM +0800, Baolu Lu wrote:
> 
>>> -	/* Check if the device in the group still has a driver bound to it */
>>> -	device_lock(dev);
>>
>> With device_lock() removed, this probably races with the
>> iommu_release_device() path? group->mutex seems insufficient to avoid
>> the race. Perhaps I missed anything.
> 
> This path only deals with group, so there is no 'dev' and no race with
> removal.

If we can now use the ownership mechanism to enforce the required 
constraints for change_dev_def_domain, that would be worthwhile (and a 
lot clearer) as a separate patch in its own right.

Thanks,
Robin.

> Later on we obtain the group mutex and then extract the first device
> from the group list as a representative device of the group - eg to
> perform iommu_domain allocation.
> 
> Under the group mutex devices on the device list cannot become
> invalid.
> 
> It is the same reasoning we use in other places that iterate over the
> group device list under lock.
> 
> Jason
