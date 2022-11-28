Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262EB63AE27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiK1Q4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiK1Q4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:56:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26ACD1D0D9;
        Mon, 28 Nov 2022 08:56:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FCAD6E;
        Mon, 28 Nov 2022 08:56:54 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B77073F73B;
        Mon, 28 Nov 2022 08:56:44 -0800 (PST)
Message-ID: <815278cc-7fad-1657-c07a-e9825f137e5c@arm.com>
Date:   Mon, 28 Nov 2022 16:56:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
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

On 2022-11-28 15:54, Niklas Schnelle wrote:
> On Mon, 2022-11-28 at 09:29 -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 28, 2022 at 12:10:39PM +0100, Niklas Schnelle wrote:
>>> On Thu, 2022-11-17 at 09:55 +0800, Baolu Lu wrote:
>>>> On 2022/11/17 1:16, Niklas Schnelle wrote:
>>>>> When iommu.strict=1 is set or iommu_set_dma_strict() was called we
>>>>> should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
>>>>>
>>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>>> ---
>>>>>    drivers/iommu/iommu.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>> index 65a3b3d886dc..d9bf94d198df 100644
>>>>> --- a/drivers/iommu/iommu.c
>>>>> +++ b/drivers/iommu/iommu.c
>>>>> @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
>>>>>    {
>>>>>    	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>>>>    
>>>>> +	if (iommu_dma_strict)
>>>>> +		return IOMMU_DOMAIN_DMA;
>>>>
>>>> If any quirky device must work in IOMMU identity mapping mode, this
>>>> might introduce functional regression. At least for VT-d platforms, some
>>>> devices do require IOMMU identity mapping mode for functionality.
>>>
>>> That's a good point. How about instead of unconditionally returning
>>> IOMMU_DOMAIN_DMA we just do so if the domain type returned by ops-
>>>> def_domain_type uses a flush queue (i.e. the __IOMMU_DOMAIN_DMA_FQ bit
>>> is set). That way a device that only supports identity mapping gets to
>>> set that but iommu_dma_strict at least always prevents use of an IOVA
>>> flush queue.
>>
>> I would prefer we create some formal caps in iommu_ops to describe
>> whatever it is you are trying to do.
>>
>> Jason
> 
> I agree that there is currently a lack of distinction between what
> domain types can be used (capability) and which should be used as
> default (iommu.strict=<x>, iommu_set_...(), CONFIG_IOMMU_DEFAULT_DMA,
> ops->def_domain_type.).

As far as I'm concerned, the purpose of .def_domain_type is really just 
for quirks where the device needs an identity mapping, based on 
knowledge that tends to be sufficiently platform-specific that we prefer 
to delegate it to drivers. What apple-dart is doing is really just a 
workaround for not being to indicate per-instance domain type support at 
the point of the .domain_alloc call, and IIRC what mtk_iommu_v1 is doing 
is a horrible giant hack around the arch/arm DMA ops that don't 
understand IOMMU groups. Both of those situations are on the cards to be 
cleaned up, so don't take too much from them.

> My case though is about the latter which I think has some undocumented
> and surprising precedences built in at the moment. With this series we
> can use all of IOMMU_DOMAIN_DMA(_FQ, _SQ) on any PCI device but we want
> to default to either IOMMU_DOMAIN_DMA_FQ or IOMMU_DOMAIN_SQ based on
> whether we're running in a paging hypervisor (z/VM or KVM) to get the
> best performance. From a semantic point of view I felt that this is a
> good match for ops->def_domain_type in that we pick a default but it's
> still possible to change the domain type e.g. via sysfs. Now this had
> the problem that ops->def_domain_type would cause IOMMU_DOMAIN_DMA_FQ
> to be used even if iommu_set_dma_strict() was called (via
> iommu.strict=1) because there is a undocumented override of ops-
>> def_domain_type over iommu_def_domain_type which I believe comes from
> the mixing of capability and default you also point at.
> 
> I think ideally we need two separate mechanism to determine which
> domain types can be used for a particular device (capability) and for
> which one to default to with the latter part having a clear precedence
> between the options. Put together I think iommu.strict=1 should
> override a device's preference (ops->def_domain_type) and
> CONFIG_IOMMU_DEFAULT_DMA to use IOMMU_DOMAIN_DMA but of course only if
> the device is capable of that. Does that sound reasonable?

That sounds like essentially what we already have, though. The current 
logic should be thus:

1: If the device is untrusted, it gets strict translation, nothing else. 
If that won't actually work, tough.
2: If .def_domain_type returns a specific type, it is because any other 
type will not work correctly at all, so we must use that.
3: Otherwise, we compute the user's preferred default type based on 
kernel config and command line options.
4: Then we determine whether the IOMMU driver actually supports that 
type, by trying to allocate it. If allocation fails and the preferred 
type was more relaxed than IOMMU_DOMAIN_DMA, fall back to the stricter 
type and try one last time.

AFAICS the distinction and priority of those steps is pretty clear:

1: Core requirements
2: Driver-specific requirements
3: Core preference
4: Driver-specific support

Now, for step 4 we *could* potentially use static capability flags in 
place of the "try allocating different things until one succeeds", but 
that doesn't change anything other than saving the repetitive 
boilerplate in everyone's .domain_alloc implementations. The real moral 
of the story here is not to express a soft preference where it will be 
interpreted as a hard requirement.

Thanks,
Robin.
