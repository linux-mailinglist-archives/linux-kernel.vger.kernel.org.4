Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883AC6C7D16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjCXLRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCXLRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:17:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D94D3193F9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:17:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9776411FB;
        Fri, 24 Mar 2023 04:18:20 -0700 (PDT)
Received: from [10.1.28.32] (e122027.cambridge.arm.com [10.1.28.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEF9D3F6C4;
        Fri, 24 Mar 2023 04:17:33 -0700 (PDT)
Message-ID: <80238e1b-15d7-23b7-b2a9-77078e64e056@arm.com>
Date:   Fri, 24 Mar 2023 11:17:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lu Baolu <baolu.lu@linux.intel.com>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca> <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
 <ZBr5e6tn1i7EE/16@ziepe.ca> <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
 <ZBsb01emBJJMZIt0@ziepe.ca> <bee3e168-3fc3-89e8-6b10-a830f052cf55@arm.com>
 <ZBs8k8nki/iqUiwE@ziepe.ca>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <ZBs8k8nki/iqUiwE@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 17:36, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 04:04:25PM +0000, Steven Price wrote:
>> On 22/03/2023 15:16, Jason Gunthorpe wrote:
>>> On Wed, Mar 22, 2023 at 03:08:41PM +0000, Steven Price wrote:
>>>> @@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>>>>  	if (iommu->domain == domain)
>>>>  		return 0;
>>>>  
>>>> -	if (iommu->domain)
>>>> -		rk_iommu_detach_device(iommu->domain, dev);
>>>> +	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
>>>> +	if (ret)
>>>> +		return ret;
>>>
>>>>  
>>>>  	iommu->domain = domain;
>>>>  
>>>> @@ -1049,8 +1070,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>>>>  		return 0;
>>>>  
>>>>  	ret = rk_iommu_enable(iommu);
>>>> -	if (ret)
>>>> -		rk_iommu_detach_device(iommu->domain, dev);
>>>
>>> I think this still needs error handling, it should put it back to the
>>> identity domain and return an error code if it fails to attach to the
>>> requested domain.
>>
>> What confused me here is that there's already a call to
>> rk_iommu_identity_attach() just above. But I can obviously add a...
> 
> I don't know this driver at all, but to me it looks like this is
> perhaps undoing a partially failed rk_iommu_enable() since it doesn't
> seem to enetirely fix itself. Ie it zeros the INT_MASK and DTE_ADDR
> 
> Maybe it would be better to put that error cleanup direclty into
> enable and just move the iommu->domain assignment to after enable
> success.

While I agree this would be better - I don't feel I understand the
driver enough to have confidence in doing this. And I don't know how to
trigger the error conditions to test this either.

>>        if (ret)
>>                rk_iommu_identity_attach(&rk_identity_domain, dev);
>>
>> ... in here. But I don't know how to handle an error from
>> rk_iommu_identity_attach() at this point. Does it need handling - is a
>> WARN_ON sufficient?
> 
> WARN_ON should be fine, that is kind of hacky, it would be better to
> organize things so there is an identity attach function that cannot
> fail, ie pre-assumes all the validation is done alread.y

As the code currently stands rk_iommu_identity_attach can fail for
exactly one reason: if rk_iommu_from_dev() fails. And since that check
is already done in rk_iommu_attach_device() this cannot fail (baring
memory corruption etc). So I'll stick to WARN_ON for now.

>>
>>> It should also initlaize iommu->domain to the identity domain when the
>>> iommu struct is allocated. The iommu->domain should never be
>>> NULL. identity domain means the IOMMU is turned off which was
>>> previously called "detached".
>>
>> I presume you mean in rk_iommu_probe()?
> 
> It would be best if it was setup at allocation time so in
> rk_iommu_of_xlate() before dev_iommu_priv_set()

I've already put an assignment in rk_iommu_of_xlate() just before
dev_iommu_priv_set().

Steve
