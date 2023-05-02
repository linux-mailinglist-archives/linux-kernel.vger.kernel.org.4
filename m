Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A513B6F43F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjEBMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjEBMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:38:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CAB8526E;
        Tue,  2 May 2023 05:38:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CDC6C14;
        Tue,  2 May 2023 05:39:13 -0700 (PDT)
Received: from [10.57.23.107] (unknown [10.57.23.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32703F64C;
        Tue,  2 May 2023 05:38:26 -0700 (PDT)
Message-ID: <07d187de-2e0c-6ea7-d386-56eb5fb50f7d@arm.com>
Date:   Tue, 2 May 2023 13:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] perf: arm_cspmu: Separate Arm and vendor module
Content-Language: en-GB
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
References: <20230418062030.45620-1-bwicaksono@nvidia.com>
 <61e4c2ba-7549-2766-8c94-9de4fc27ecbd@arm.com>
 <SJ0PR12MB567670F52673F9806BC6EABFA06B9@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SJ0PR12MB567670F52673F9806BC6EABFA06B9@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28 23:23, Besar Wicaksono wrote:
> Hi Robin and Suzuki,
> 
>> -----Original Message-----
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Thursday, April 27, 2023 7:21 AM
>> To: Besar Wicaksono <bwicaksono@nvidia.com>; suzuki.poulose@arm.com;
>> catalin.marinas@arm.com; will@kernel.org; mark.rutland@arm.com
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan
>> Hunter <jonathanh@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Richard
>> Wiley <rwiley@nvidia.com>; Eric Funsten <efunsten@nvidia.com>
>> Subject: Re: [PATCH v2] perf: arm_cspmu: Separate Arm and vendor module
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 2023-04-18 07:20, Besar Wicaksono wrote:
>>> Arm Coresight PMU driver consists of main standard code and vendor
>>> backend code. Both are currently built as a single module.
>>> This patch adds vendor registration API to separate the two to
>>> keep things modular. Vendor module shall register to the main
>>> module on loading and trigger device reprobe.
>>
>> I think it might be considerably cleaner and safer if the main driver
>> retained at least some knowledge of the PMIIDR matches and used those to
>> explicity request the relevant module. Otherwise, not only is there an
>> awful lot of fiddly complexity here, but there's also quite a burden on
>> the user to know which modules they have to load to get full
>> functionality on any given system.
> 
> Do you mean like keep the existing match table as a whitelist, and associate
> each entry with the backend module name to load it from the main driver ?

It would essentially be a table that matches a PMIIDR filter to a module 
name. Having looked for existing examples of this kind of usage model, 
in terms of the overall shape it might look closest to a very 
stripped-down version of the crypto manager.

>> FYI I've just started working on adding devicetree support, and I do
>> need the generic architectural functionality to keep working in the
>> absence of any imp-def backend.
> 
> W.r.t the reprobe discussion with Suzuki, this would mean the expected
> behavior is to attach the device to standard imp as fallback/default.
> Suzuki, my preference is not supporting delayed reprobe on event->destroy
> due to the potential access to stale data. We should just fail the backend
> registration if one of the device is in use.

We shouldn't need to worry about that at all. If requesting an expected 
implementation module fails and those PMUs end up falling back to 
baseline functionality, there's no need to actively deny the backend if 
the module is manually loaded later, it merely won't be used. As far as 
reprobing goes, it seems reasonable for the user to remove/reload the 
main module after fixing the backend module availability if it matters 
to them. Or maybe we could just EPROBE_DEFER instead of falling back to 
baseline if we know the module is enabled and *should* be available; I 
don't have a particular preference either way. The main thing is just to 
have the backend modules work in a simple, intuitive, and mostly 
automatic manner, without all the complexity of effectively 
reimplementing a whole custom driver model in between perf and the real 
driver model.

I think the only really notable thing about this approach is that it 
would probably need to make sure the PMU probe runs asynchronously from 
the main module_init.

Thanks,
Robin.
