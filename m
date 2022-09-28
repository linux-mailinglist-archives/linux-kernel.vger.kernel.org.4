Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225025EDA58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbiI1KrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiI1KrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:47:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B9D0ACA0F;
        Wed, 28 Sep 2022 03:47:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7E631595;
        Wed, 28 Sep 2022 03:47:21 -0700 (PDT)
Received: from [10.57.66.102] (unknown [10.57.66.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B49C93F792;
        Wed, 28 Sep 2022 03:47:12 -0700 (PDT)
Message-ID: <739570af-b90a-aea6-ee56-cb1d5da48c97@arm.com>
Date:   Wed, 28 Sep 2022 11:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v4 2/2] perf: arm_cspmu: Add support for NVIDIA SCF and
 MCF attribute
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
 <20220814182351.8861-3-bwicaksono@nvidia.com>
 <7082762d-2d4d-aa7b-656c-75593b0697f0@arm.com>
 <SJ0PR12MB5676A36BC125A9873F74E697A0549@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <SJ0PR12MB5676A36BC125A9873F74E697A0549@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 02:38, Besar Wicaksono wrote:
> 
> 
>> -----Original Message-----
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Sent: Tuesday, September 27, 2022 6:43 AM
>> To: Besar Wicaksono <bwicaksono@nvidia.com>; robin.murphy@arm.com;
>> catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> linux-tegra@vger.kernel.org; sudeep.holla@arm.com;
>> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
>> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
>> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
>> mike.leach@linaro.org; leo.yan@linaro.org
>> Subject: Re: [PATCH v4 2/2] perf: arm_cspmu: Add support for NVIDIA SCF
>> and MCF attribute
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 14/08/2022 19:23, Besar Wicaksono wrote:
>>> Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
>>> Fabric (MCF) PMU attributes for CoreSight PMU implementation in
>>> NVIDIA devices.
>>>
>>> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

>>> +struct nv_cspmu_match {
>>> +     u32 prodid;
>>> +     u32 prodid_mask;
>>> +     u64 filter_mask;
>>> +     const char *name_pattern;
>>> +     enum nv_cspmu_name_fmt name_fmt;
>>> +     struct attribute **event_attr;
>>> +     struct attribute **format_attr;
>>> +};
>>> +
>>> +static const struct nv_cspmu_match nv_cspmu_match[] = {
>>
>> Similar coding style nit below.
>>
> 
> Sure, I will update this.
> 
>>
>> Otherwise,
>>
>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Thanks!
> 
> Unfortunately, we need to update the name of the PMUs and remove
> some of the attributes in NVIDIA implementation. This requires a change
> in nvidia_cspmu.c and nvidia-pmu.rst. I hope you are fine if I include this
> change on v5 patch.

That should be fine.

Suzuki
