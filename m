Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158CC63B3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiK1VCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiK1VB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:01:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E49A32CDE7;
        Mon, 28 Nov 2022 13:01:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00C61D6E;
        Mon, 28 Nov 2022 13:02:01 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 861FE3F67D;
        Mon, 28 Nov 2022 13:01:51 -0800 (PST)
Message-ID: <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
Date:   Mon, 28 Nov 2022 21:01:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
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
 <Y4TjWOXYD+DK+d/B@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y4TjWOXYD+DK+d/B@nvidia.com>
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

On 2022-11-28 16:35, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 04:54:03PM +0100, Niklas Schnelle wrote:
> 
>> I agree that there is currently a lack of distinction between what
>> domain types can be used (capability) and which should be used as
>> default (iommu.strict=<x>, iommu_set_...(), CONFIG_IOMMU_DEFAULT_DMA,
>> ops->def_domain_type.).
> 
> What I would like to get to is the drivers only expose UNMANAGED,
> IDENTITY and BLOCKING domains. Everything that the DMA/FQ/etc domains
> were doing should be handled as some kind of cap.
> 
> Eg, after Lu's series:
> 
> https://lore.kernel.org/linux-iommu/20221128064648.1934720-1-baolu.lu@linux.intel.com/
> 
> We should be able to remove IOMMU_DOMAIN_DMA and its related from the
> drivers entirely. Instead drivers will provide UNMANAGED domains and
> dma-iommu.c will operate the UNMANAGED domain to provide the dma
> api. We can detect if the driver supports this by set_platform_dma()
> being NULL.
> 
> A statement that a driver performs better using SQ/FQ/none should be
> something that is queried from the UNMANAGED domain as a guidance to
> dma-iommu.c what configuration to pick if not overriden.

Ack, I'm sure it could be cleaner overall if the driver capabilities 
didn't come in right at the end of the process with the .domain_alloc 
dance. As I've said before, I would still like to keep the domain types 
in the core code (since they already work as a set of capability flags), 
but drivers not having to deal with them directly would be good. Maybe 
we dedicate .domain_alloc to paging domains, and have separate device 
ops for .get_{blocking,identity}_domain, given that optimised 
implementations of those are likely to be static or at least per-instance.

> So, I would say what you want is some option flag, perhaps on the
> domain ops: 'domain performs better with SQ or FQ'

Although for something that's likely to be global based on whether 
running virtualised or not, I'd be inclined to try pulling that as far 
as reasonably possible towards core code.

>> My case though is about the latter which I think has some undocumented
>> and surprising precedences built in at the moment. With this series we
>> can use all of IOMMU_DOMAIN_DMA(_FQ, _SQ) on any PCI device but we want
>> to default to either IOMMU_DOMAIN_DMA_FQ or IOMMU_DOMAIN_SQ based on
>> whether we're running in a paging hypervisor (z/VM or KVM) to get the
>> best performance. From a semantic point of view I felt that this is a
>> good match for ops->def_domain_type in that we pick a default but it's
>> still possible to change the domain type e.g. via sysfs. Now this had
>> the problem that ops->def_domain_type would cause IOMMU_DOMAIN_DMA_FQ
>> to be used even if iommu_set_dma_strict() was called (via
>> iommu.strict=1) because there is a undocumented override of ops-
>>> def_domain_type over iommu_def_domain_type which I believe comes from
>> the mixing of capability and default you also point at.
> 
> Yeah, this does sounds troubled.

The initial assumption about .def_domain_type is incorrect, though. From 
there it's a straightforward path to the conclusion that introducing 
inconsistency (by using the wrong mechanism) leads to the presence of 
inconsistency.

>> I think ideally we need two separate mechanism to determine which
>> domain types can be used for a particular device (capability) and for
>> which one to default to with the latter part having a clear precedence
>> between the options. Put together I think iommu.strict=1 should
>> override a device's preference (ops->def_domain_type) and
>> CONFIG_IOMMU_DEFAULT_DMA to use IOMMU_DOMAIN_DMA but of course only if
>> the device is capable of that. Does that sound reasonable?
> 
> Using the language above, if someone asks for strict then the
> infrastructure should try to allocate an UNMANAGED domain, not an
> identity domain,

Careful, "iommu.strict" refers specifically to the invalidation policy 
for DMA API domains, and I've tried to be careful to document it as 
such. It has never been defined to have any impact on anything other 
than DMA API domains, so I don't think any should be assumed. Control of 
the basic domain type (identity vs. translation) on the command line has 
always been via separate parameters, which I think have always had 
higher priority anyway. With sysfs you can ask for anything, but you'll 
still only get it if it's safe and guaranteed to work.

> and not use the lazy flush algorithms in dma-iommu.c
> 
> Similarly if sysfs asks for lazy flush or identity maps then it should
> get it, always.

I'm hardly an advocate for trying to save users from themselves, but I 
honestly can't see any justifiable reason for not having sysfs respect 
iommu_get_def_domain_type(). If a privileged user wants to screw up the 
system they're hardly short of options already. Far worse, though, is 
that someone nefarious would only need to popularise a "make external 
dGPUs and/or other popular accelerators faster on laptops" udev rule 
that forces identity domains via sysfs, and bye bye Thunderclap mitigations.

> The driver should have no say in how dma-iommu.c works beyond if it
> provides the required ops functionalities, and hint(s) as to what
> gives best performance.

That should already be the case today, as outlined in my other mail. 
It's just somewhat more evolved than designed, so may not be so clear to 
everyone.

Thanks,
Robin.
