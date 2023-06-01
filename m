Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1FB71A02C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjFAOel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjFAOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:34:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83371195;
        Thu,  1 Jun 2023 07:34:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6965C1042;
        Thu,  1 Jun 2023 07:35:15 -0700 (PDT)
Received: from [10.57.84.85] (unknown [10.57.84.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD3C63F7BD;
        Thu,  1 Jun 2023 07:34:27 -0700 (PDT)
Message-ID: <dc8d8baa-22cd-ccd9-3598-1a52d4d749af@arm.com>
Date:   Thu, 1 Jun 2023 15:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3] perf: arm_cspmu: Separate Arm and vendor module
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
References: <20230505005956.22837-1-bwicaksono@nvidia.com>
 <09b2a614-b7e5-d4e4-bcd4-bd1c22470821@arm.com>
 <SJ0PR12MB5676B311C2D04301CC266292A0719@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Language: en-GB
In-Reply-To: <SJ0PR12MB5676B311C2D04301CC266292A0719@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-08 18:04, Besar Wicaksono wrote:
[...]
>>> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=
>> arm_cspmu_impl.o
>>
>> Not sure what's up with this... I have no complaint with keeping the
>> impl infrastucture together in its own source file, but it still wants
>> to end up as part of arm_cspmu_module. Doing otherwise just adds
>> unnecessary overhead at many levels and invites more problems.
> 
> My intention is to separate arm_cspmu_impl, arm_cspmu, and
> vendor backend into different modules. Here is the dependency I have in mind:
> 
>                                                 arm_cspmu_impl
>                                                       ____|____
>                                                      |                  |
>                                      arm_cspmu               nvidia_cspmu
> 
> This helps during device probe that the call to request_module can be made
> as a blocking call and the backend init_impl_ops will always be ready to use after
> request_module returns. The code seems simpler this way. Could you please
> elaborate the potential issue that might arise with this approach?

I see the intent; the main issue is that the implementation of it is 
needlessly fiddly: arm_cspmu_impl is not useful on its own, and probably 
only represents a few hundred bytes of code, so putting in a distinct 
.ko which needs to be loaded separately is a relatively massive waste of 
filesystem space and memory for what it is. Also if anything that 
dependency is the wrong way round anyway - arm_cspmu could provide 
generic PMU functionality just fine regardless of arm_cspmu_impl, but 
arm_cspmu_impl definitely has a logical and functional dependency on 
arm_cspmu in order to serve any user-visible purpose.

> After reading your other comments on built-in kernel, can we use late_initcall
> for arm_cspmu module to assume that the main driver will always be init'ed after
> backend module ?

Either that or device_initcall_sync should probably be OK.

[...]
>>> -ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
>>> -                             struct device_attribute *attr,
>>> -                             char *buf)
>>> -{
>>> -     struct dev_ext_attribute *eattr =
>>> -             container_of(attr, struct dev_ext_attribute, attr);
>>> -     return sysfs_emit(buf, "%s\n", (char *)eattr->var);
>>> -}
>>> -EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_format_show);
>>> -
>>
>> Is there a reason for moving these (other than bodging around issues
>> caused by the Makefile mishap above)?
>>
> 
> The main reason is to remove backend module (nvidia_cspmu)
> dependency to main driver.

But it does logically and functionally depend on the main driver, so 
that still sounds wrong :/

>> (also, I'm now wondering why they're exported in the first place, since
>> a backend module is hardly going to need to override the default
>> implementations with the default implementations...)
> 
> My intention is to make the event and format attribute macro
> on the header file to be reusable for the backend module. The event/format
> attribute on the other PMUs is pretty generic, so I thought it would be
> harmless.

Sorry for the confusion, this one's on me - for some reason I started 
thinking these were used as impl_ops callbacks, since in general they 
are something an impl may conceivably want to replace, and I'd missed 
the indirect references hidden in the ARM_CSPMU_{EVENT,FORMAT}_ATTR() 
macros, which are of course used directly by nvidia_cspmu. So the 
exports do make sense.

>>>    static struct attribute *arm_cspmu_format_attrs[] = {
>>>        ARM_CSPMU_FORMAT_EVENT_ATTR,
>>>        ARM_CSPMU_FORMAT_FILTER_ATTR,
>>> @@ -379,27 +355,12 @@ static struct attribute_group
>> arm_cspmu_cpumask_attr_group = {
>>>        .attrs = arm_cspmu_cpumask_attrs,
>>>    };
>>>
>>> -struct impl_match {
>>> -     u32 pmiidr;
>>> -     u32 mask;
>>> -     int (*impl_init_ops)(struct arm_cspmu *cspmu);
>>> -};
>>> -
>>> -static const struct impl_match impl_match[] = {
>>> -     {
>>> -       .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
>>> -       .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
>>> -       .impl_init_ops = nv_cspmu_init_ops
>>> -     },
>>> -     {}
>>> -};
>>> -
>>>    static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>>>    {
>>> -     int ret;
>>> +     int ret = 0;
>>>        struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
>>>        struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
>>> -     const struct impl_match *match = impl_match;
>>> +     const struct arm_cspmu_impl_module *match;
>>>
>>>        /*
>>>         * Get PMU implementer and product id from APMT node.
>>> @@ -411,18 +372,21 @@ static int arm_cspmu_init_impl_ops(struct
>> arm_cspmu *cspmu)
>>>                                       readl(cspmu->base0 + PMIIDR);
>>>
>>>        /* Find implementer specific attribute ops. */
>>> -     for (; match->pmiidr; match++) {
>>> -             const u32 mask = match->mask;
>>> -
>>> -             if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
>>> -                     ret = match->impl_init_ops(cspmu);
>>> -                     if (ret)
>>> -                             return ret;
>>> -
>>> -                     break;
>>> +     match = arm_cspmu_impl_match_module(cspmu->impl.pmiidr);
>>> +     if (match) {
>>> +             request_module(match->name);
>>
>> Are we confident this can't deadlock when it's already in the middle of
>> loading the main module?
>>
> 
> The backend module does not depend on the main driver module anymore
> (please see my top comment). The blocking call to request_module should be
> able to return.

Yeah, it just surprises me that loading a module synchronously in the 
middle of loading another module would actually work. I started trying 
to test it out under lockdep to reassure myself, but that just found 
that my dev board already has a locking issue in the UART driver :(

[...]
>>> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param
>> *impl_param)
>>> +{
>>> +     struct arm_cspmu_impl_module *module;
>>> +
>>> +     mutex_lock(&arm_cspmu_lock);
>>> +
>>> +     module = arm_cspmu_impl_find_module(impl_param);
>>> +     if (module) {
>>
>> I think it's reasonable to have a usage model where unregister should
>> only be called if register succeeded, and thus we can assume this lookup
>> never fails. That certainly fits if the expectation is that
>> register/unregister are tied to module_init/module_exit.
>>
> 
> Yup, that is the expectation. It is still good to validate the module pointer right ?
> Or do you think it will hide a bug, if any ?

If it constitutes an egregious programming error to attempt to 
unregister something which was never registered, such that this pointer 
could never legitimately be NULL, then it should suffice to validate the 
pointer naturally by dereferencing it.

Thanks,
Robin.
