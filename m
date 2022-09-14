Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAA5B8F63
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiINTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiINTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:53:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF5A77287B;
        Wed, 14 Sep 2022 12:53:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 956841576;
        Wed, 14 Sep 2022 12:53:23 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CB443F73B;
        Wed, 14 Sep 2022 12:53:12 -0700 (PDT)
Message-ID: <5f049bb8-76e6-901a-9f8e-b48d270bc4a0@arm.com>
Date:   Wed, 14 Sep 2022 20:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robdclark@gmail.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, matthias.bgg@gmail.com,
        heiko@sntech.de, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, sricharan@codeaurora.org,
        yong.wu@mediatek.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        thunder.leizhen@huawei.com, christophe.jaillet@wanadoo.fr,
        yangyingliang@huawei.com, jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com> <YyB3F/o3RfymqiFW@myrica>
 <YyGaqsXSDMn8R12R@nvidia.com> <YyGjtsB2Yq4fQICS@myrica>
 <YyIWQ6rX6AR9KX5E@Asurada-Nvidia>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YyIWQ6rX6AR9KX5E@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-14 18:58, Nicolin Chen wrote:
> On Wed, Sep 14, 2022 at 10:49:42AM +0100, Jean-Philippe Brucker wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Sep 14, 2022 at 06:11:06AM -0300, Jason Gunthorpe wrote:
>>> On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
>>>> I think in the future it will be too easy to forget about the constrained
>>>> return value of attach() while modifying some other part of the driver,
>>>> and let an external helper return EINVAL. So I'd rather not propagate ret
>>>> from outside of viommu_domain_attach() and finalise().
>>>
>>> Fortunately, if -EINVAL is wrongly returned it only creates an
>>> inefficiency, not a functional problem. So we do not need to be
>>> precise here.
>>
>> Ah fair. In that case the attach_dev() documentation should indicate that
>> EINVAL is a hint, so that callers don't rely on it (currently words "must"
>> and "exclusively" indicate that returning EINVAL for anything other than
>> device-domain incompatibility is unacceptable). The virtio-iommu
>> implementation may well return EINVAL from the virtio stack or from the
>> host response.
> 
> How about this?
> 
> + * * EINVAL    - mainly, device and domain are incompatible, or something went
> + *               wrong with the domain. It's suggested to avoid kernel prints
> + *               along with this errno. And it's better to convert any EINVAL
> + *               returned from kAPIs to ENODEV if it is device-specific, or to
> + *               some other reasonable errno being listed below

FWIW, I'd say something like:

"The device and domain are incompatible. If this is due to some previous 
configuration of the domain, drivers should not log an error, since it 
is legitimate for callers to test reuse of an existing domain. 
Otherwise, it may still represent some fundamental problem."

And then at the public interfaces state it from other angle:

"The device and domain are incompatible. If the domain has already been 
used or configured in some way, attaching the same device to a different 
domain may be expected to succeed. Otherwise, it may still represent 
some fundamental problem."

[ and to save another mail, I'm not sure copying the default comment for 
ENOSPC is all that helpful either - what is "space" for something that 
isn't a storage device? I'd guess limited hardware resources in some 
form, but in the IOMMU context, potential confusion with address space 
is maybe a little too close for comfort? ]

>>>> Since we can't guarantee that APIs like virtio or ida won't ever return
>>>> EINVAL, we should set all return values:
>>>
>>> I dislike this alot, it squashes all return codes to try to optimize
>>> an obscure failure path :(
> 
> Hmm...should I revert all the driver changes back to this version?

Yeah, I don't think we need to go too mad here. Drivers shouldn't emit 
their *own* -EINVAL unless appropriate, but if it comes back from some 
external API then that implies something's gone unexpectedly wrong 
anyway - maybe it's a transient condition and a subsequent different 
attach might actually work out OK? We can't really say in general. 
Besides, if the driver sees an error which implies it's done something 
wrong itself, it probably shouldn't be trusted to try to reason about it 
further. The caller can handle any error as long as we set their 
expectations correctly.

Thanks,
Robin.
