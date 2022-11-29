Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B732463C74B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiK2Slf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235871AbiK2Sl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:41:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5CC459847;
        Tue, 29 Nov 2022 10:41:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8926ED6E;
        Tue, 29 Nov 2022 10:41:32 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9503FA32;
        Tue, 29 Nov 2022 10:41:22 -0800 (PST)
Message-ID: <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
Date:   Tue, 29 Nov 2022 18:41:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
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
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
 <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com> <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y4ZCVgLO9AHatwXe@nvidia.com>
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

On 2022-11-29 17:33, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 09:01:43PM +0000, Robin Murphy wrote:
> 
>> I'm hardly an advocate for trying to save users from themselves, but I
>> honestly can't see any justifiable reason for not having sysfs respect
>> iommu_get_def_domain_type().
> 
> We really need to rename this value if it is not actually just an
> advisory "default" but a functional requirement ..

It represents a required default domain type. As in, the type for the 
device's default domain. Not the default type for a domain. It's the 
iommu_def_domain_type variable that holds the *default* default domain 
type ;)

Which reminds me I should finish that patch undoing my terrible 
ops->default_domain_ops idea, not least because they are misleadingly 
unrelated to default domains...

>>> The driver should have no say in how dma-iommu.c works beyond if it
>>> provides the required ops functionalities, and hint(s) as to what
>>> gives best performance.
>>
>> That should already be the case today, as outlined in my other mail. It's
>> just somewhat more evolved than designed, so may not be so clear to
>> everyone.
> 
> It is close to being clear, once we get the last touches of dma-iommu
> stuff out of the drivers it should be quite clear

Cool, some upheaval of .domain_alloc is next on my hitlist anyway, so 
that might be a good excuse to upheave it a bit more and streamline the 
type stuff along the way.

Cheers,
Robin.
