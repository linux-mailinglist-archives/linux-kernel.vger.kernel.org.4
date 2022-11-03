Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4D618645
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKCRfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKCRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:35:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EFDD13D1E;
        Thu,  3 Nov 2022 10:35:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CEAB1FB;
        Thu,  3 Nov 2022 10:35:35 -0700 (PDT)
Received: from [10.57.36.87] (unknown [10.57.36.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14143F5A1;
        Thu,  3 Nov 2022 10:35:26 -0700 (PDT)
Message-ID: <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
Date:   Thu, 3 Nov 2022 17:35:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Content-Language: en-GB
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Thierry Reding <treding@nvidia.com>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com> <Y2PJq27wkVwPg6rp@orome>
 <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-03 14:55, Ulf Hansson wrote:
> On Thu, 3 Nov 2022 at 15:01, Thierry Reding <thierry.reding@gmail.com> wrote:
>>
>> On Thu, Nov 03, 2022 at 12:23:20PM +0000, Robin Murphy wrote:
>>> On 2022-11-03 04:38, Prathamesh Shete wrote:
>>>> In order to fully make use of the !IOMMU_API stub functions, make the
>>>> struct iommu_fwspec always available so that users of the stubs can keep
>>>> using the structure's internals without causing compile failures.
>>>
>>> I'm really in two minds about this... fwspecs are an internal detail of the
>>> IOMMU API that are meant to be private between individual drivers and
>>> firmware code, so anything poking at them arguably does and should depend on
>>> CONFIG_IOMMU_API. It looks like the stub for dev_iommu_fwspec_get() was only
>>> added for the sake of one driver that was misusing it where it really wanted
>>> device_iommu_mapped(), and has since been fixed, so if anything my
>>> preference would be to remove that stub :/
>>
>> Tegra has been using this type of weak dependency on IOMMU_API mainly in
>> order to allow building without the IOMMU support on some old platforms
>> where people may actually care about the kernel size (Tegra20 systems
>> were sometimes severely constrained and don't have anything that we'd
>> call an IOMMU today).
>>
>> We have similar stubs in place for most other major subsystems in order
>> to allow code to simply compile out if the subsystem is disabled, which
>> is quite convenient for sharing code between platforms that may want a
>> given feature and other platforms that may not want it, without causing
>> too much of a hassle with compile-testing.
> 
> I agree with the above.
> 
> Moreover, the stubs make the code more portable/scalable and so it
> becomes easier to maintain.

Are you suggesting that having the same thing open-coded slightly 
differently (with bugs) in 8 different places is somehow more 
maintainable than abstracting it into a single centralised implementation?

Is it "easier to maintain" when already seemingly every thing I try to 
clean up or refactor in the IOMMU API at the moment is stymied by 
finding Tegra drivers doing unexpected (and often questionable) things? 
Is it "more scalable" to make it even easier for people to copy 
questionable code without a second thought, leaving API maintainers to 
play an ever-expanding game of whack-a-mole to clean it up? No. No it 
chuffing well isn't :(

>>> I don't technically have much objection to this patch in isolation, but what
>>> I don't like is the direction of travel it implies. I see the anti-pattern
>>> is only spread across Tegra drivers, making Tegra-specific assumptions, so
>>> in my view the best answer would be to abstract that fwpsec dependency into
>>> a single Tegra-specific helper, which would better represent the nature of
>>> what's really going on here.
>>
>> I don't see how this is an anti-pattern. It might not be common for
>> drivers to need to reach into iommu_fwspec, so that might indeed be
>> specific to Tegra (for whatever reason our IP seems to want extra
>> flexibility), but the general pattern of using stubs is wide-spread,
>> so I don't see why IOMMU_API would need to be special.
> 
> Again, I agree.

The anti-pattern is reaching into some other driver's private data 
assuming a particular format, with zero indication of the huge degree of 
assumption involved, and half the time not even checking that what's 
being dereferenced is valid.

> Moreover, a "git grep CONFIG_IOMMU_API" indicates that the problem
> isn't specific to Tegra. The "#ifdef CONFIG_IOMMU_API" seems to be
> sprinkled across the kernel. I think it would be nice if we could
> improve the situation. So far, using stubs along with what the
> $subject patch proposes, seems to me to be the best approach.

Yes, there is plenty of code through the tree that is only relevant to 
the IOMMU API and would be a complete waste of space without it, that is 
not the point in question here. Grep for dev_iommu_fwspec_get; outside 
drivers/iommu, the only users are IOMMU-API-specific parts of ACPI code, 
as intended, plus 8 random Tegra drivers.

Now, there does happen to be a tacit contract between the ACPI IORT code 
and the Arm SMMU drivers for how SMMU StreamIDs are encoded in their 
respective fwspecs, but it was never intended for wider consumption. If 
Tegra drivers want to have a special relationship with arm-smmu then 
fair enough, but they can do the same as MSM and formalise it somewhere 
that the SMMU driver maintainers are at least aware of, rather than 
holding the whole generic IOMMU API hostage.

Since apparently it wasn't clear, what I was proposing is a driver 
helper at least something like this:

int tegra_arm_smmu_streamid(struct device *dev)
{
#ifdef CONFIG_IOMMU_API
	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev)

	if (fwspec && fwspec->num_ids == 1)
		return fwspec->ids[0] & 0xffff;
#endif
	return -EINVAL;
}

Now THAT is scalable and maintainable; any number of random drivers can 
call it without any preconditions, it's a lot clearer what's going on, 
and I won't have to swear profusely while herding patches through half a 
dozen different trees if, when my ops rework gets to the point of 
refactoring iommu_fwspec with dev_iommu, it ends up changing anything 
significant.

Thanks,
Robin.
