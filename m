Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F076B98E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCNPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCNPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:25:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3485BA7287
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:25:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FCF54B3;
        Tue, 14 Mar 2023 08:26:14 -0700 (PDT)
Received: from [10.57.91.139] (unknown [10.57.91.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87A143F67D;
        Tue, 14 Mar 2023 08:25:28 -0700 (PDT)
Message-ID: <f718a517-c91a-0608-1d51-4edef8cc88cd@arm.com>
Date:   Tue, 14 Mar 2023 15:25:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>, will@kernel.org,
        joro@8bytes.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
 <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com> <20230314112620.GB137001@thinkpad>
 <13b46d42-e497-8dd7-4785-f58447128a40@arm.com>
 <20230314132018.GC137001@thinkpad>
 <a81515c5-c88c-e3c2-2077-0a78b900bbe5@arm.com>
 <20230314143218.fl3hedg336iofv3n@ripper>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230314143218.fl3hedg336iofv3n@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 14:32, Bjorn Andersson wrote:
> On Tue, Mar 14, 2023 at 01:41:56PM +0000, Robin Murphy wrote:
>> On 2023-03-14 13:20, Manivannan Sadhasivam wrote:
>>> On Tue, Mar 14, 2023 at 11:58:24AM +0000, Robin Murphy wrote:
>>>> On 2023-03-14 11:26, Manivannan Sadhasivam wrote:
>>>>> On Tue, Mar 14, 2023 at 12:17:38PM +0100, Johan Hovold wrote:
>>>>>> On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
>>>>>>> The logic used to find the quirky firmware that intercepts the writes to
>>>>>>> S2CR register to replace bypass type streams with a fault, and ignore the
>>>>>>> fault type, is not working with the firmware on newer SoCs like SC8280XP.
>>>>>>>
>>>>>>> The current logic uses the last stream mapping group (num_mapping_groups
>>>>>>> - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
>>>>>>> reports a value of 162 (possibly emulated by the hypervisor) and logic is
>>>>>>> not working for stream mapping groups > 128. (Note that the ARM SMMU
>>>>>>> architecture specification defines NUMSMRG in the range of 0-127).
>>>>>>>
>>>>>>> So the current logic that checks the (162-1)th S2CR entry fails to detect
>>>>>>> the quirky firmware on these devices and SMMU triggers invalid context
>>>>>>> fault for bypass streams.
>>>>>>>
>>>>>>> To fix this issue, rework the logic to find the first non-valid (free)
>>>>>>> stream mapping register group (SMR) within 128 groups and use that index
>>>>>>> to access S2CR for detecting the bypass quirk. If no free groups are
>>>>>>> available, then just skip the quirk detection.
>>>>>>>
>>>>>>> While at it, let's move the quirk detection logic to a separate function
>>>>>>> and change the local variable name from last_s2cr to free_s2cr.
>>>>>>>
>>>>>>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>>
>>>>>>> * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
>>>>>>> * Moved the quirk handling to its own function
>>>>>>> * Collected review tag from Bjorn
>>>>>>>
>>>>>>>     drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
>>>>>>>     1 file changed, 40 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> index d1b296b95c86..48362d7ef451 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>>>> @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>>>>     	return 0;
>>>>>>>     }
>>>>>>> -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
>>>>>>> +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
>>>>>>>     {
>>>>>>> -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
>>>>>>>     	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>>>>> -	u32 reg;
>>>>>>> -	u32 smr;
>>>>>>> +	u32 free_s2cr;
>>>>>>> +	u32 reg, smr;
>>>>>>>     	int i;
>>>>>>> +	/*
>>>>>>> +	 * Find the first non-valid (free) stream mapping register group and
>>>>>>> +	 * use that index to access S2CR for detecting the bypass quirk.
>>>>>>> +	 *
>>>>>>> +	 * Note that only the first 128 stream mapping groups are considered for
>>>>>>> +	 * the check. This is because the ARM SMMU architecture specification
>>>>>>> +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
>>>>>>> +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
>>>>>>> +	 * groups with the help of hypervisor. And those groups don't exhibit
>>>>>>> +	 * the quirky behavior.
>>>>>>> +	 */
>>>>>>> +	for (i = 0; i < 128; i++) {
>>>>>>
>>>>>> This may now access registers beyond smmu->num_mapping_groups. Should
>>>>>> you not use the minimum of these two values here (and below)?
>>>>>>
>>>>>
>>>>> Doh! yeah, you're right. Will fix it in v3.
>>>>
>>>> FWIW I'd say it's probably best if the cfg_probe hook clamps
>>>> smmu->num_mapping_groups to the architectural maximum straight away, to also
>>>> prevent the main driver iterating off into the nonsensical area in
>>>> arm_smmu_device_reset() or the SMR allocator itself.
>>>>
>>>
>>> We considered that also but Qcom purposefully extended the NUMSMRG for
>>> virtualization usecase and we do not have a clear picture of it.
>>
>> Whatever that supposed use-case may be, Linux does not support it, and
>> clearly isn't going to support it any time soon if we don't even know what
> 
> Can you please elaborate on what it is that would prevent Linux to
> handle hardware with more than 128 SMRs?

https://developer.arm.com/documentation/ihi0062/latest

I would expect actual hardware to follow the architecture (because it 
would need to pass validation suites etc.). The architecture defines an 
extension for supporting up to 1024 stream mapping groups, but that 
works very differently.

The SC8280XP DT claims this SMMU is compatible with a standard Arm 
MMU-500, which definitely does not support more than 128 SMRs, so I have 
no idea what the hypervisor might be up to.

>> it is. Therefore Linux does not need to accommodate this weirdness for the
>> foreseeable future, beyond simply making sure it doesn't cause any problems
>> for what Linux *does* support. It's bad enough that the emulation of
>> "normal" SMRs continues to violate the architecture, but I'm even more
>> uncomfortable letting the generic architecture driver poke at completely
>> non-architectural registers which don't even have the same behaviour as the
>> ones they're supposedly extending.
> 
> Afaict there's nothing special about the SMRs beyond 128 on this
> platform...

If that were true then why would this patch be a thing at all? :/

Thanks,
Robin.
